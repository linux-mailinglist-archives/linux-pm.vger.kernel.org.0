Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03523365DBE
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 18:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhDTQuc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 12:50:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49813 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbhDTQub (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 12:50:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lYtZW-0003WN-2v; Tue, 20 Apr 2021 16:49:58 +0000
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
From:   Colin Ian King <colin.king@canonical.com>
Subject: incorrect mask/shift issue with qcom tsens thermal driver
Message-ID: <aac16b20-12e7-5925-2c25-ee11b237a431@canonical.com>
Date:   Tue, 20 Apr 2021 17:49:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Static analysis on drivers/thermal/qcom/tsens-v0_1.c has found an issue
in function calibrate_8974 with an incorrect mask value used when
shifting a value. The analysis by Coverity is as follows:


400                        p1[5] = (bkp[1] & S5_P1_MASK) >> S5_P1_SHIFT;
401                        p1[6] = (bkp[1] & S6_P1_MASK) >> S6_P1_SHIFT;
402                        p1[7] = (bkp[1] & S7_P1_MASK) >> S7_P1_SHIFT;

Operands don't affect result (CONSTANT_EXPRESSION_RESULT)
result_independent_of_operands: (bkp[2] & 63) >> 24 is 0 regardless of
the values of its operands. This occurs as the operand of assignment.

403                        p1[8] = (bkp[2] & S8_P1_MASK_BKP) >> S8_P1_SHIFT;


S8_P1_MASK_BKP is 0x3f
S8_P1_SHIFT is 24

so anything masked with 03f and right shifted 24 places will be zero, so
this looks incorrect.  I suspect the mask should be 0x3f000000.

My thinking is that this is a typo, and should be:

	 p1[8] = (bkp[2] & S8_P1_MASK) >> S8_P1_SHIFT;

since S8_P1_MASK is 0x3f000000. However, I'm not 100% sure as I don't
have the EEPROM layout so it maybe that S8_P1_MASK_BKP is incorrectly
#defined.

Any thoughts?

Colin
