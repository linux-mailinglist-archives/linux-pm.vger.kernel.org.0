Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09966648566
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiLIP1k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiLIP0s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4588F0BF
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:41 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=frS3EzYa2XR/D6WbzPF+EQ7AWO1d3yfGz8sx8Bc8OyM=;
        b=kheYFCsQ2w6ooglmeLeaZex2upz8FYJNvIOCzMqO9TxjSl+6aZ7ey2dcDVJVsXe/1RIxXb
        xT/lhqYgTA7Hg5SyT+DcX4U6O1oHXVIMuEpaT9qMdgSpX5fP9N0Htpk9vwfizIkeAY4J3s
        rD7nJTnw0M/iUJajMtRePe/2SDh97Rn4jvx9+jlhv+nFQ+I3KgWrA8vIj8+ibrE45jurGl
        zWbGmFWg2R0A7P3oqFR6Sk2bdJME0QKwUTUs1M0NebogY++/wUQ/pzYM5UmpFYOTAS119m
        ZYadpr8XDKMnrJjxNASV/cPNK2vJgpC4j89P11VlQwbau/eIO/+Fe/5TFftAfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=frS3EzYa2XR/D6WbzPF+EQ7AWO1d3yfGz8sx8Bc8OyM=;
        b=Nl9oJiQDqNF+qPb98u8RiNXCGLK3lvt3/Acztc8D2f2VrnERvqDcHvhxeahtFzVQmsAY4L
        UnwLJ+IP8VTVJ+Bw==
From:   "thermal-bot for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Move parameter validation from
 __thermal_zone_get_temp to thermal_zone_get_temp
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959830.4906.18053139639944296768.tip-bot2@tip-bot2>
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

Commit-ID:     ed97d10a8b2c78d1664b01658c5f581e6791ff7d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ed97d10a8b2c78d1664b01658c5f581e6791ff7d
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Thu, 10 Nov 2022 07:24:55 -08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 14 Nov 2022 19:04:37 +01:00

thermal/core: Move parameter validation from __thermal_zone_get_temp to thermal_zone_get_temp

All callers of __thermal_zone_get_temp() already validated the
thermal zone parameters. Move validation to thermal_zone_get_temp()
where it is actually needed. Also add kernel documentation for
__thermal_zone_get_temp(), listing the requirement that the
function must be called with validated parameters and with thermal
device mutex held.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_helpers.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index fca0b23..321f802 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -64,6 +64,20 @@ get_thermal_instance(struct thermal_zone_device *tz,
 }
 EXPORT_SYMBOL(get_thermal_instance);
 
+/**
+ * __thermal_zone_get_temp() - returns the temperature of a thermal zone
+ * @tz: a valid pointer to a struct thermal_zone_device
+ * @temp: a valid pointer to where to store the resulting temperature.
+ *
+ * When a valid thermal zone reference is passed, it will fetch its
+ * temperature and fill @temp.
+ *
+ * Both tz and tz->ops must be valid pointers when calling this function,
+ * and the tz->ops->get_temp callback must be provided.
+ * The function must be called under tz->lock.
+ *
+ * Return: On success returns 0, an error code otherwise
+ */
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int ret = -EINVAL;
@@ -73,9 +87,6 @@ int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	lockdep_assert_held(&tz->lock);
 
-	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
-		return -EINVAL;
-
 	ret = tz->ops->get_temp(tz, temp);
 
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
@@ -114,13 +125,22 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int ret;
 
+	if (IS_ERR_OR_NULL(tz))
+		return -EINVAL;
+
 	mutex_lock(&tz->lock);
 
+	if (!tz->ops->get_temp) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	if (device_is_registered(&tz->device))
 		ret = __thermal_zone_get_temp(tz, temp);
 	else
 		ret = -ENODEV;
 
+unlock:
 	mutex_unlock(&tz->lock);
 
 	return ret;
