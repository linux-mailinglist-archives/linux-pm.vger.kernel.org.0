Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E739741B82C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 22:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242720AbhI1UNL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 16:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242702AbhI1UNG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Sep 2021 16:13:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA88DC06174E;
        Tue, 28 Sep 2021 13:11:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b15so1002592lfe.7;
        Tue, 28 Sep 2021 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dwkX337TFgvRCTKSZKyXnwJ7aBWtkckS2fkSGygsoPM=;
        b=LpSrHmS/g55thZZsWlc9LqEsQDcVeNBD+8feeAhfGaY5kf0Ls/aH1DGZw3wPk/gYgb
         pN7OGp83Jami/P+sHB6E1GHNOvmY0XM5VKuSnq3iuq4IsdnNe3pQ/UXxQf3p7FAwOYPW
         uJVOIF4H/SEOdx4qwuc6mj6uCVkMelYM9ruJmiuawgJMSizTYClPLn5FRrCnFj1G9D0t
         Vx7fxvIqVd1Uc3dHJIVSaBexgQFtEscMJri1GL2DDSr1LEE6z9TB+cK03AFXI5W76PQI
         iF/kZXjFi0aFr2RinSK8PCnooEfLUUHiuPgw/jWzoO0TZGjMxN108fww+UvMAwp795bX
         ZWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dwkX337TFgvRCTKSZKyXnwJ7aBWtkckS2fkSGygsoPM=;
        b=au6UBckHcjw3WdeoBAzqrxnQri4JGTHe9dM6p7DKFydofi4fM8V+RvUQaf6TfKrxWz
         K/jdYmJ2DVaDM8685kD3drgpkp1Mr7cI1B+QAX1Nast0yQrPVm7Biq6WRWzl0akxEcYz
         MdnUi4ZgwlZgGi95FnDtdswHrcRwJaRcEa0ETLrOlMCQtXL8x1WzJ6mR2HHsj9t2JWyY
         pl6CZhGap1S+4WtTT0LEPCNzr13j0g35j6XC9uKxWgFctwsDYzbnmZPP3tJMpx3hA/kD
         1AOxT9u6yIdguOoQ4XSyGzJ/FgK4Yq375OjbLl9VC6Cah2vL8o3UMRz0jCuLT6A7TeNy
         3yFw==
X-Gm-Message-State: AOAM531LK14LhzxjhkiDa4h67j66CTOg3qtGxT2EEn/7Ql42c7PFrnBy
        UnLKuZceT2EYe9l7KmVBA8SIAX3ToVc=
X-Google-Smtp-Source: ABdhPJx/8xu/CO+zN4ujsJ2sY19t9g9l6MgzZBJxBlqbQXSGmTnhKHEBakBYour3NGGlbklwScn8ww==
X-Received: by 2002:a2e:b4ac:: with SMTP id q12mr1917432ljm.221.1632859885281;
        Tue, 28 Sep 2021 13:11:25 -0700 (PDT)
Received: from [192.168.1.4] ([185.205.48.180])
        by smtp.gmail.com with ESMTPSA id l11sm2974lfg.39.2021.09.28.13.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 13:11:24 -0700 (PDT)
From:   =?UTF-8?Q?Nicol=c3=b2_Piazzalunga?= <nicolopiazzalunga@gmail.com>
Subject: [RFC] add standardized attributes for force_discharge and
 inhibit_charge
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Thomas Koch <linrunner@gmx.net>,
        "smclt30p@gmail.com" <smclt30p@gmail.com>
Message-ID: <21569a89-8303-8573-05fb-c2fec29983d1@gmail.com>
Date:   Tue, 28 Sep 2021 22:11:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

this is a proposal to introduce separate and standardized attributes
for force_discharge and inhibit_charge of a battery.
These are simpler than using status from a user-space perspective,
as discussed on the platform-driver-x86 mail list.

Regards,
Nicolò

---
 Documentation/ABI/testing/sysfs-class-power | 27 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  2 ++
 include/linux/power_supply.h                |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index ca830c6cd809..2c5f48f49273 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -455,6 +455,33 @@ Description:
 			      "Unknown", "Charging", "Discharging",
 			      "Not charging", "Full"
 
+What:		/sys/class/power_supply/<supply_name>/force_discharge
+Date:		September 2021
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Represents the forced discharging status of the battery.
+
+		Access: Read, Write
+
+		Valid values:
+			== ====================================
+			0: Force discharge while AC is attached
+			1: Terminate forced discharging
+
+What:		/sys/class/power_supply/<supply_name>/inhibit_charge
+Date:		September 2021
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Represents the presence of a manual override over the threshold
+		attributes of the battery, thus inhibiting battery charge.
+
+		Access: Read, Write
+
+		Valid values:
+			== ======================
+			1: Stop charging
+			0: Terminate the override
+
 What:		/sys/class/power_supply/<supply_name>/technology
 Date:		May 2007
 Contact:	linux-pm@vger.kernel.org
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c3d7cbcd4fad..6e7303935810 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -136,6 +136,8 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
 static struct power_supply_attr power_supply_attrs[] = {
 	/* Properties of type `int' */
 	POWER_SUPPLY_ENUM_ATTR(STATUS),
+	POWER_SUPPLY_ENUM_ATTR(FORCE_DISCHARGE),
+	POWER_SUPPLY_ENUM_ATTR(INHIBIT_CHARGE),
 	POWER_SUPPLY_ENUM_ATTR(CHARGE_TYPE),
 	POWER_SUPPLY_ENUM_ATTR(HEALTH),
 	POWER_SUPPLY_ATTR(PRESENT),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 9ca1f120a211..4340fe65df4d 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -96,6 +96,8 @@ enum {
 enum power_supply_property {
 	/* Properties of type `int' */
 	POWER_SUPPLY_PROP_STATUS = 0,
+	POWER_SUPPLY_PROP_FORCE_DISCHARGE,
+	POWER_SUPPLY_PROP_INHIBIT_CHARGE,
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
-- 
2.33.0
