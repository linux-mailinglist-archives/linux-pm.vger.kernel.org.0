Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F2A285149
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 19:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgJFR7Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 13:59:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53861 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgJFR7Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 13:59:25 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kPrFD-0000WP-5G; Tue, 06 Oct 2020 17:59:23 +0000
To:     Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: power: supply: bq25980: Add support for the BQ259xx family
Message-ID: <af1a1044-5f45-ecaf-244e-90650f17ff17@canonical.com>
Date:   Tue, 6 Oct 2020 18:59:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

Static analysis with Coverity has detected a potential out-of-bounds
read issue in the following commit:

commit 5069185fc18e810715a91d80fcd075e03add600c
Author: Dan Murphy <dmurphy@ti.com>
Date:   Mon Aug 31 11:48:49 2020 -0500

    power: supply: bq25980: Add support for the BQ259xx family


Analysis is as follows:

1099 static int bq25980_hw_init(struct bq25980_device *bq)
1100 {
1101        struct power_supply_battery_info bat_info = { };
1102        int wd_reg_val;
1103        int ret = 0;
1104        int curr_val;
1105        int volt_val;
1106        int i;
1107

    1. Condition !bq->watchdog_timer, taking false branch.
1108        if (!bq->watchdog_timer) {
1109                ret = regmap_update_bits(bq->regmap,
BQ25980_CHRGR_CTRL_3,
1110                                         BQ25980_WATCHDOG_DIS,
1111                                         BQ25980_WATCHDOG_DIS);
1112        } else {

    2. Condition i < 4, taking true branch.
    6. Condition i < 4, taking true branch.
    7. cond_at_most: Checking i < 4 implies that i may be up to 3 on the
true branch.
1113                for (i = 0; i < BQ25980_NUM_WD_VAL; i++) {

    3. Condition bq->watchdog_timer > bq25980_watchdog_time[i], taking
true branch.
    4. Condition bq->watchdog_timer < bq25980_watchdog_time[i + 1],
taking false branch.
    8. Condition bq->watchdog_timer > bq25980_watchdog_time[i], taking
true branch.

Out-of-bounds read (OVERRUN)
    9. overrun-local: Overrunning array bq25980_watchdog_time of 4
4-byte elements at element index 4 (byte offset 19) using index i + 1
(which evaluates to 4).

1114                        if (bq->watchdog_timer >
bq25980_watchdog_time[i] &&
1115                            bq->watchdog_timer <
bq25980_watchdog_time[i + 1]) {
1116                                wd_reg_val = i;
1117                                break;
1118                        }
    5. Jumping back to the beginning of the loop.
1119                }

Accessing bq25980_watchdog_time[i + 1] when i is 3 causes the
out-of-range read

Colin
