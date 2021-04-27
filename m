Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933BC36CBEA
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbhD0TpQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43146 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbhD0TpP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:15 -0400
Date:   Tue, 27 Apr 2021 19:44:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B9mrBFug5DTdAgBUg/6ewFyMTGJtdcJlZ4dFTJaYEu4=;
        b=0jrr0FlCnWLpGjumCItmf3UibdqHXrUeQuOukPvjjIvmEjr18eQ4oVUXz/fCe81/fXw17d
        VhcemtG7PgT8Eqpsu7H5HzLWd+FKUDlfjdlxNm6N3JYxfD10+TsjxwUUNjBq6ZeSDLGwFg
        IV+AtYYEquhYUci3HIUEHqOSUlkaToBFEtdibcSsCCFbHOAwyH8bxCzeAE8ayNyJhL+d5R
        VhYcJSYplzMsAbgTILU5i6ffHqZDmcaCzN5WEoC9A6S3RgRg/N0LBmvk1GMP6Z12R7ZD1s
        8oQHd8qpVxZODvH0WthwGg7zpnRldmuJvxC+HI3weSUnXigWpfHotWeS6iE0hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B9mrBFug5DTdAgBUg/6ewFyMTGJtdcJlZ4dFTJaYEu4=;
        b=YneuUhLmvgZRdolV8tx9dPB/lQ37I20E+SvmbJU8+APcbfnxJ++/BkJJPFTJDR4Mjbq3Js
        IrZs/9juv0QRa+Dg==
From:   "thermal-bot for Thara Gopinath" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] iwlwifi: mvm: tt: Replace thermal_notify_framework
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210122023406.3500424-2-thara.gopinath@linaro.org>
References: <20210122023406.3500424-2-thara.gopinath@linaro.org>
MIME-Version: 1.0
Message-ID: <161955267041.29796.9891161624431870692.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     93effd83b6927c0252bb1e35aa3e116d3e2527bb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//93effd83b6927c0252bb1e35aa3e116d3e2527bb
Author:        Thara Gopinath <thara.gopinath@linaro.org>
AuthorDate:    Thu, 21 Jan 2021 21:34:04 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 13:11:35 +02:00

iwlwifi: mvm: tt: Replace thermal_notify_framework

thermal_notify_framework just updates for a single trip point where as
thermal_zone_device_update does other bookkeeping like updating the
temperature of the thermal zone and setting the next trip point etc.
Replace thermal_notify_framework with thermal_zone_device_update as the
later is more thorough.

Acked-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210122023406.3500424-2-thara.gopinath@linaro.org
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 2a7339b..398390c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -146,8 +146,8 @@ void iwl_mvm_temp_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	if (mvm->tz_device.tzone) {
 		struct iwl_mvm_thermal_device *tz_dev = &mvm->tz_device;
 
-		thermal_notify_framework(tz_dev->tzone,
-					 tz_dev->fw_trips_index[ths_crossed]);
+		thermal_zone_device_update(tz_dev->tzone,
+					   THERMAL_TRIP_VIOLATED);
 	}
 #endif /* CONFIG_THERMAL */
 }
