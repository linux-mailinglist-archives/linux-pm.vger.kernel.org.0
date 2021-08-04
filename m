Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F68B3DFFD3
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 13:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbhHDLET (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 07:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbhHDLES (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 07:04:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B774C06179A;
        Wed,  4 Aug 2021 04:04:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so8145398pjb.2;
        Wed, 04 Aug 2021 04:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=v5VrqkSgwcCOdp//iZ1+g23cZqbac3VU++EnpM9xUWo=;
        b=bdXX9UkIiNxdKTu55zA79ScTv3KBbwcD60BGbO4c5FTbCJ1yXmeRL1sSOnODMrwqaw
         vdyOiaiJCDCoMgCYNT7mXaZpc5q72wNVYtonp57/R26n+HmH4IcjusYJCVd6r+91TivH
         IQ33hOSA9VULtDS263o3siUjaxr6+Am9PfEJOj3/mjqS2yIZAoedii2nYh4L6X8l367G
         8Q18zSV+ydnp5gbWmSSAIaLG7/iwXhzi1/t9zoAKDSdWMY00RaVw+OM99lFcaOldOLGt
         Vs69FL+d3q+AOQcGPloMFormCzeR3wknSXQ1UlrE7+Bqk2hKzzqudFAG/fRkXOQq81K9
         oQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=v5VrqkSgwcCOdp//iZ1+g23cZqbac3VU++EnpM9xUWo=;
        b=EsgNY7j1O7be+qahMqJpABLT/F58rDIQlG/x7U+JP/LKB989VUxtN173OESkKmAEf2
         x9zhrClWAx7riAbnAdjPLLc7yf/Ik2/Vhwh7jJS0b41BlqLO8mY3iyBE4w+F8WGGb8Q7
         n9FwAaUWjJI9YBztRakGZM7HWwbCg1Ju7/d37TeupoJFqBtFSQ3oAvh7JjFDWP5Fnv5l
         OiSsfOwO3Dzg6sBRrjgwL8hQ6DdrWK96kGbi3l2iuPlbURUO77eq5JL/jridPAGOJzVf
         MfYA5vgv+WAXiuhcaq9WkE6UbSOuXACcbOLMlrfPQR2QoBTMerqhaiWyhV4qVS6CGitH
         /VZQ==
X-Gm-Message-State: AOAM532xcUV+py/OIsJi4aWrxHnydFgS71T9Plfcd6QpvqFfkvmlA0t2
        Up18r5Wl6BeuAqd69HwDLxk=
X-Google-Smtp-Source: ABdhPJyf17/KCD/KDGkCC5YNeZ6PbVZA6xobce3OQP6nVQoJYNnbhLAMnZfLWV90yBvJ+g5/SVnItQ==
X-Received: by 2002:a17:90a:ccc:: with SMTP id 12mr27577608pjt.57.1628075045064;
        Wed, 04 Aug 2021 04:04:05 -0700 (PDT)
Received: from wangting-OptiPlex-7050.mioffice.cn ([2408:8607:1b00:7:529a:4cff:fe0e:1dd3])
        by smtp.gmail.com with ESMTPSA id f6sm2306220pfv.69.2021.08.04.04.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:04:04 -0700 (PDT)
From:   Ting Wang <zxc52fgh@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, wangting11 <wangting11@xiaomi.com>
Subject: [PATCH v11 3/4] power: supply: core: add wireless signal strength property
Date:   Wed,  4 Aug 2021 19:02:00 +0800
Message-Id: <8599adb4d1c966c8d0cd6e25137a660546c1115c.1627992564.git.wangting11@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1627992564.git.wangting11@xiaomi.com>
References: <cover.1627992564.git.wangting11@xiaomi.com>
In-Reply-To: <cover.1627992564.git.wangting11@xiaomi.com>
References: <cover.1627992564.git.wangting11@xiaomi.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: wangting11 <wangting11@xiaomi.com>

reports wireless signal strength.
The value show degree of coupling between tx and rx.

Signed-off-by: wangting11 <wangting11@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 22 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 36808bf8731b..4a6b4970cb7d 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -785,3 +785,25 @@ Description:
 			13: ADAPTER_VOICE_BOX,
 			14: ADAPTER_PRIVATE_PD_50W.
 
+What:		/sys/class/power_supply/<supply_name>/signal_strength
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		In PING phase, RX transmits a signal strength packet as the
+		first communication packet to instruct the base to keep power
+		signal on.The value reports wireless signal strength and show
+		degree of coupling.
+
+		The Qi Wireless Power Transfer System is published by the
+		Wireless Power Consortium.The ping phase is the necessary stage
+		for matching transmitter and receiver. In this phase,the Power
+		Transmitter executes a Digital Ping, and listens for a response.
+		If the Power Transmitter discovers a Power Receiver, the Power
+		Transmitter may extend the Digital Ping,i.e. maintain the Power
+		Signal at the level of the Digital Ping. This causes the system
+		to proceed to the identification & configuration phase. If the
+		Power Transmitter does not extend the Digital Ping, the system
+		shall revert to the selection phase.
+
+		Access: Read-Only
+		Valid values: 0 - 100
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 561cffef9d61..4de91dce2001 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -213,6 +213,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
 	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
 	POWER_SUPPLY_ATTR(TX_ADAPTER),
+	POWER_SUPPLY_ATTR(SIGNAL_STRENGTH),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index bcfadf2a995f..0dfec19cb473 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -173,6 +173,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_TX_ADAPTER,
+	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
 };
 
 enum power_supply_type {
-- 
2.17.1

