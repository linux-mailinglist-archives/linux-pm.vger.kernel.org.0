Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04576251232
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 08:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgHYGk1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 02:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbgHYGkP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 02:40:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7AFC061755;
        Mon, 24 Aug 2020 23:40:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 31so3880944pgy.13;
        Mon, 24 Aug 2020 23:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vq8VrvDZDnyF2Zh3awLs7OB7VEuN+RNqZyCqVxEY1Zo=;
        b=USyUfQrpK/4m4wnRxHSiWWvGFAdJ05ICWKl1iSCqImXNEUVDkch//fXKVgJvQvNpbP
         GS3apgwV4zJ2oSj3/0DGA9ejo+UGCWiGl8JOHB/vIK3Crdgv1UMHLI2c4u4UilZ4K6NM
         cRkaUX4d9SMPxjKugPkzz7YJ776n/ucCtJbzR4msTvuCBMGg5WY280i0Q/hEY1e9Vl2e
         NfNDoQ+adgcFCr1j33DGNxYjG2Drx7oibS5WppD1/HgSfW+N/ul7CG7/4BLr69/4lq9x
         CvbdxhjXwoZoMm7b/9bUGiFowoGrsz0r/D3AEaqx9y513ttIqnxFmgrH/7How42KIU76
         Ma6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vq8VrvDZDnyF2Zh3awLs7OB7VEuN+RNqZyCqVxEY1Zo=;
        b=j9M+sKQqbJSf4wpzuY52ZI1VXTHIYpKQUd5Y8eOIKobPHaL55c62s4zon1lstulEZY
         iUwMljrWOZg4BIb5c5xIpYw8paCmmTFhVgMqW5qpiS+oEzzK8RDI8X5djJsQ0p2ivkBg
         5nCRRsDk4Rix4S4RLen2slT5A/cKhYgKhafqpSqnHZ0Gr1eUd4z7tNDJvzgn1AbEHPOf
         I6u57uS1t+yJbrwvsI2FHKU0V4lybWAbEHjlfYdUiZJ2iourSinZ5iLlMB5CXgXuaIDB
         p0/Z8DxZmQiiwFqDPvO/2WUXbvZszg6x/PrceeDjJorucCMk9h97TFMdt6y/3Jyb3xq7
         yO7w==
X-Gm-Message-State: AOAM530ZyiMlI4gBK3At/7HuymOERM5Q5bQ4k7fKC3Fe/QA96WJSyklM
        eObS+kG9/aWh9FzJWcMCm+A=
X-Google-Smtp-Source: ABdhPJwh3w6aT2s8Mb7x5LK+JRQGTlSNdqj0BOax533TddvgCV4+7RcIX/gbZ3Uj9KzdFUwvmVbQMQ==
X-Received: by 2002:a65:6882:: with SMTP id e2mr5941334pgt.290.1598337614586;
        Mon, 24 Aug 2020 23:40:14 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id z2sm14197283pfq.46.2020.08.24.23.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 23:40:14 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v9 3/4] power: supply: core: add wireless signal strength property
Date:   Tue, 25 Aug 2020 14:37:58 +0800
Message-Id: <7b38a519d85ad526cee8d25a00ad8de1a98fb04f.1598337073.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598337073.git.huangqiwu@xiaomi.com>
References: <cover.1598337073.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

reports wireless signal strength.
The value show degree of coupling between tx and rx.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 22 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 03ab449fae8a..4459b720feb2 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -757,3 +757,25 @@ Description:
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
index f2458e21d02b..e420a453095e 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -208,6 +208,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
 	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
 	POWER_SUPPLY_ATTR(TX_ADAPTER),
+	POWER_SUPPLY_ATTR(SIGNAL_STRENGTH),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 00254e096a4a..747338118fa1 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -169,6 +169,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_TX_ADAPTER,
+	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
 };
 
 enum power_supply_type {
-- 
2.28.0

