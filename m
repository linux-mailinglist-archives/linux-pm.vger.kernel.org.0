Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBF0648540
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiLIP1L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiLIP0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FCA8F730
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:34 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9k1/hFr00T67xtkffzPkykKHxr1GVhyJpRwSC3tXQlc=;
        b=25/cAwc5gi4UNu2rx7AZdre3GRqGtCvOTulk/QhVmoRo9ue/fTgP5Ne/ASEwX4uyDezxni
        i/xQ/Yge1UIomNM8KdEGeW6lOlplgSRFCZ6PLk7YR1G9jH2EzHx3xMzdpqZdFas/y7MR/R
        +E4VaB2MBdOyzJWBMknNlLJ8kGSfHLAGH4/yikyhLdG9OmNCleJbo121VVphyaVkxBMRUk
        hwXGdwovOiWews/dohslePBGGWKQKyngCBpSmd2sxXNf7VbLS8zthpvny5QzgyUruXQh2m
        lisVngEJ0vg+24ilFgbdrz9XiWA0FiStYk1DCPGoNy3oPSSgkoQUaw4MEcXOpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9k1/hFr00T67xtkffzPkykKHxr1GVhyJpRwSC3tXQlc=;
        b=CNrDddUqXJ0gY6awDU6nBTlYGlknyYXVjPb52HhLsjJfVpM9yyBOuo4mY3mFBBZkxtQUOW
        kZz3rpNVszUO5qDA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] wifi: iwlwifi: Use generic
 thermal_zone_get_trip() function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kalle Valo <kvalo@kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20221014073253.3719911-1-daniel.lezcano@linaro.org>
References: <20221014073253.3719911-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959067.4906.17883271511238633427.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     ac8c83919cdd8cba05c2697fbd944ec3f6697d7b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ac8c83919cdd8cba05c2697fbd944ec3f6697d7b
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Fri, 14 Oct 2022 09:32:50 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

wifi: iwlwifi: Use generic thermal_zone_get_trip() function

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

The get_trip_temp, get_trip_hyst and get_trip_type are handled by the
get_trip_point().

The set_trip_temp() generic function does some checks which are no
longer needed in the set_trip_point() ops.

Convert ops content logic into generic trip points and register them
with the thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Kalle Valo <kvalo@kernel.org>
Acked-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20221014073253.3719911-1-daniel.lezcano@linaro.org
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c  | 71 +++----------------
 2 files changed, 13 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 97cba52..1a69237 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -501,7 +501,7 @@ struct iwl_mvm_tt_mgmt {
  * @tzone: thermal zone device data
 */
 struct iwl_mvm_thermal_device {
-	s16 temp_trips[IWL_MAX_DTS_TRIPS];
+	struct thermal_trip trips[IWL_MAX_DTS_TRIPS];
 	u8 fw_trips_index[IWL_MAX_DTS_TRIPS];
 	struct thermal_zone_device *tzone;
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 69cf3a3..232c200 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -573,11 +573,11 @@ int iwl_mvm_send_temp_report_ths_cmd(struct iwl_mvm *mvm)
 	 * and uncompressed, the FW should get it compressed and sorted
 	 */
 
-	/* compress temp_trips to cmd array, remove uninitialized values*/
+	/* compress trips to cmd array, remove uninitialized values*/
 	for (i = 0; i < IWL_MAX_DTS_TRIPS; i++) {
-		if (mvm->tz_device.temp_trips[i] != S16_MIN) {
+		if (mvm->tz_device.trips[i].temperature != INT_MIN) {
 			cmd.thresholds[idx++] =
-				cpu_to_le16(mvm->tz_device.temp_trips[i]);
+				cpu_to_le16((s16)(mvm->tz_device.trips[i].temperature / 1000));
 		}
 	}
 	cmd.num_temps = cpu_to_le32(idx);
@@ -593,8 +593,8 @@ int iwl_mvm_send_temp_report_ths_cmd(struct iwl_mvm *mvm)
 	 */
 	for (i = 0; i < idx; i++) {
 		for (j = 0; j < IWL_MAX_DTS_TRIPS; j++) {
-			if (le16_to_cpu(cmd.thresholds[i]) ==
-				mvm->tz_device.temp_trips[j])
+			if ((int)(le16_to_cpu(cmd.thresholds[i]) * 1000) ==
+			    mvm->tz_device.trips[j].temperature)
 				mvm->tz_device.fw_trips_index[i] = j;
 		}
 	}
@@ -638,37 +638,12 @@ out:
 	return ret;
 }
 
-static int iwl_mvm_tzone_get_trip_temp(struct thermal_zone_device *device,
-				       int trip, int *temp)
-{
-	struct iwl_mvm *mvm = (struct iwl_mvm *)device->devdata;
-
-	if (trip < 0 || trip >= IWL_MAX_DTS_TRIPS)
-		return -EINVAL;
-
-	*temp = mvm->tz_device.temp_trips[trip] * 1000;
-
-	return 0;
-}
-
-static int iwl_mvm_tzone_get_trip_type(struct thermal_zone_device *device,
-				       int trip, enum thermal_trip_type *type)
-{
-	if (trip < 0 || trip >= IWL_MAX_DTS_TRIPS)
-		return -EINVAL;
-
-	*type = THERMAL_TRIP_PASSIVE;
-
-	return 0;
-}
-
 static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *device,
 				       int trip, int temp)
 {
 	struct iwl_mvm *mvm = (struct iwl_mvm *)device->devdata;
 	struct iwl_mvm_thermal_device *tzone;
-	int i, ret;
-	s16 temperature;
+	int ret;
 
 	mutex_lock(&mvm->mutex);
 
@@ -678,40 +653,17 @@ static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *device,
 		goto out;
 	}
 
-	if (trip < 0 || trip >= IWL_MAX_DTS_TRIPS) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	if ((temp / 1000) > S16_MAX) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	temperature = (s16)(temp / 1000);
 	tzone = &mvm->tz_device;
-
 	if (!tzone) {
 		ret = -EIO;
 		goto out;
 	}
 
-	/* no updates*/
-	if (tzone->temp_trips[trip] == temperature) {
-		ret = 0;
-		goto out;
-	}
-
-	/* already existing temperature */
-	for (i = 0; i < IWL_MAX_DTS_TRIPS; i++) {
-		if (tzone->temp_trips[i] == temperature) {
-			ret = -EINVAL;
-			goto out;
-		}
-	}
-
-	tzone->temp_trips[trip] = temperature;
-
 	ret = iwl_mvm_send_temp_report_ths_cmd(mvm);
 out:
 	mutex_unlock(&mvm->mutex);
@@ -720,8 +672,6 @@ out:
 
 static  struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = iwl_mvm_tzone_get_temp,
-	.get_trip_temp = iwl_mvm_tzone_get_trip_temp,
-	.get_trip_type = iwl_mvm_tzone_get_trip_type,
 	.set_trip_temp = iwl_mvm_tzone_set_trip_temp,
 };
 
@@ -743,7 +693,8 @@ static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 	BUILD_BUG_ON(ARRAY_SIZE(name) >= THERMAL_NAME_LENGTH);
 
 	sprintf(name, "iwlwifi_%u", atomic_inc_return(&counter) & 0xFF);
-	mvm->tz_device.tzone = thermal_zone_device_register(name,
+	mvm->tz_device.tzone = thermal_zone_device_register_with_trips(name,
+							mvm->tz_device.trips,
 							IWL_MAX_DTS_TRIPS,
 							IWL_WRITABLE_TRIPS_MSK,
 							mvm, &tzone_ops,
@@ -766,8 +717,10 @@ static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 	/* 0 is a valid temperature,
 	 * so initialize the array with S16_MIN which invalid temperature
 	 */
-	for (i = 0 ; i < IWL_MAX_DTS_TRIPS; i++)
-		mvm->tz_device.temp_trips[i] = S16_MIN;
+	for (i = 0 ; i < IWL_MAX_DTS_TRIPS; i++) {
+		mvm->tz_device.trips[i].temperature = INT_MIN;
+		mvm->tz_device.trips[i].type = THERMAL_TRIP_PASSIVE;
+	}
 }
 
 static int iwl_mvm_tcool_get_max_state(struct thermal_cooling_device *cdev,
