Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD3C2D2E4C
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 16:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgLHPbc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 10:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbgLHPbc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 10:31:32 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9850C061749
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 07:30:51 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bo9so25070482ejb.13
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 07:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bJHsD7wusQYPoSnayseCrxu6qN7hzp3QYIwsAak7I3I=;
        b=bzJj91XMnvArriI3I1poli3kf9PSZjAHzPXbnwtMGmfHPoHARHfic9GH5/nSP6a21N
         FE0e4E4o14IYYLgzGDOeUGxAr/H4n4rNvp9l/rNuOt1nqkLKOuG5qrvmRI6NMhIbSeOv
         6Qhl7o2zrzyqqfkYQradnD/t6hU2VHaH02kjrhx72k2A6iqJKoNGyEfKBadcd+R0DXJc
         d30xQrl/deFB438A12OgexfIqN7N9gGP1kVJIHUmkGsd+YEZPQ36W+9euOBd9SF5EDHQ
         JC8PWXJM5LKf811U4haUANBlLXhAs20BYsEj3TnU29+72zG96PGpBCPc/My0MJaUdesw
         JMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bJHsD7wusQYPoSnayseCrxu6qN7hzp3QYIwsAak7I3I=;
        b=i7ZEyPcR4tMaouyU6/AAz+yx7Wqg+dfVch5oUFbqci87mHTmYFq4PPe11Z9H6SSvQ+
         AMOB2qWoktf+fhprEXaAG1Led7gv2l6YigslZCfYf45ojvsKjurZu9Qolt2/zbDjg2f9
         cOHIJJ1T+I9WxNqVkX0mU9SSHJLADLAVxppKKRXQINZuBL9Zk948kypAVd3gM+ygk3pj
         DbfVQm9IZPKviJdTxglGwleqOtWdIlMc1BDG6L0YfkRPRa5aAchDhVjdIEv7VxqpIpdi
         cxnR01rIlsv34QDFnkJccIFOso8EN9Px18CQhFg1LPuboY8NyOy8pMRaYZfnfQeWOYzJ
         iixA==
X-Gm-Message-State: AOAM530XcgDjIbWbHcKE18OesXHpfgJscrxR738HXF35tnZCqt5bMpgJ
        ecqtaHcaByyRqwOSEOsy+oAcDM11yr/ymg==
X-Google-Smtp-Source: ABdhPJyEdIVR5McQZGlRUMGSoMxBnErGu7+TVm5gy13H7lFhayHXkqsjZ4vtCsP1Q4frlXzHhOsLHQ==
X-Received: by 2002:a17:906:7aca:: with SMTP id k10mr23128906ejo.215.1607441450423;
        Tue, 08 Dec 2020 07:30:50 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:7b:3cd9:3112:fa1b])
        by smtp.gmail.com with ESMTPSA id z9sm16233427eju.123.2020.12.08.07.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 07:30:49 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitk@kernel.org
Subject: [PATCH] thermal/core: Make 'forced_passive' as obsolete candidate
Date:   Tue,  8 Dec 2020 16:30:43 +0100
Message-Id: <20201208153046.297456-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The passive file in sysfs forces the usage of a passive trip point set
by the userspace when a broken BIOS does not provide the mitigation
temperature for such thermal zone. The hardware evolved a lot since
2008 as a good thermal management is no longer an option.

Linux on the other side also provides now a way to load fixed ACPI
table via the option ACPI_TABLE_UPGRADE, so additionnal trip point
could be added there.

Set the option obsolete and plan to remove it, so the corresponding
code can be removed from the core code and allow more cleanups the
thermal framework deserves.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/ABI/obsolete/sysfs-thermal-passive | 13 +++++++++++++
 drivers/thermal/thermal_sysfs.c                  |  2 ++
 2 files changed, 15 insertions(+)
 create mode 100644 Documentation/ABI/obsolete/sysfs-thermal-passive

diff --git a/Documentation/ABI/obsolete/sysfs-thermal-passive b/Documentation/ABI/obsolete/sysfs-thermal-passive
new file mode 100644
index 000000000000..2510724cc165
--- /dev/null
+++ b/Documentation/ABI/obsolete/sysfs-thermal-passive
@@ -0,0 +1,13 @@
+What:		/sys/class/thermal/thermal_zone*/passive
+Date:		December 2008
+KernelVersion:	2.6.28
+Contact:	Daniel Lezcano <daniel.lezcano@linaro.org>
+Description:
+
+  The passive file in sysfs forces the usage of a passive trip point
+  set by the userspace when a broken BIOS does not provide the
+  mitigation temperature for such thermal zone. However, the Linux
+  kernel evolved a lot since 2008 as well as the hardware and it is
+  able to manage correctly the thermal envelope. It does also provide
+  a way to load fixed ACPI table via the option ACPI_TABLE_UPGRADE, so
+  additionnal trip point could be added there.
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 0866e949339b..578099b520b1 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -232,6 +232,8 @@ passive_store(struct device *dev, struct device_attribute *attr,
 	if (state && state < 1000)
 		return -EINVAL;
 
+	pr_warn("%s: Consider the 'passive' option obsolete\n", tz->type);
+
 	if (state && !tz->forced_passive) {
 		if (!tz->passive_delay)
 			tz->passive_delay = 1000;
-- 
2.25.1

