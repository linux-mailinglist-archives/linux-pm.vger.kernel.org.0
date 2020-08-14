Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4943E2443FA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 05:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgHNDtT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 23:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHNDtR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 23:49:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883A1C061757;
        Thu, 13 Aug 2020 20:49:17 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i92so5095107pje.0;
        Thu, 13 Aug 2020 20:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vq8VrvDZDnyF2Zh3awLs7OB7VEuN+RNqZyCqVxEY1Zo=;
        b=EuMum0ABMVFIJnP9Ihd84HBQAuUgrUpF1ipxe+RfSXkoVOYh9hDDtMDuni8wxHHqRd
         YNVMj0q1a6cIDS9xBRBjRx98X7pe5rUtD4VXwJP0A4exuQvn58e347r0a0V/QxvkqI3b
         a10edfO8y5qNbBoNjaGb0+w7SxGxQPsXYlqU6k804W8L2Vg//zqzNAJxi4Wzo14l/7tL
         eV+h9pCUa1EESO5GCOpBfdhKvPjYLA6nJA0JeOlK3GwAL0XhB+PO4G229ULndQxfGkec
         nK/Q+18cuUFojZSSShQm7vGe+xdNGDSbVyyyWZRLyyI/BQKG166jrKZsz4jcRH0CE+CT
         4+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vq8VrvDZDnyF2Zh3awLs7OB7VEuN+RNqZyCqVxEY1Zo=;
        b=AxzdtpITeg9AaciJXyOPUBIk9rJb2aFNjmGceDti9Om6xh0EyPG2t2geOiHKIZ7cq1
         fCv/k1k9wlpwoowK9suSva7CY/3OTUoyuv0+tMiLLF/jx1pFkHhLWLwhTaFu2AIK85Iz
         eec6aik7O1N9ITfagqVp+rfmO/C1JCi2CgNkR2OIErrgDWkyWwIAEqNaOQez4bIzSnIM
         n4PpIHJjjc+M+Cx1evKfHA81u2YRguteRKLtZeWtBRk4jqb/Zl4AWHKB5de8D0medosw
         +61/aaeySroxLB2zMyDPdDBtmiP5l9OU55u6k2KY8wiHTu/mZtOIj99Lb53/3fM05Pu4
         b3Wg==
X-Gm-Message-State: AOAM530L6ZH61dOsY9/ql+YaZiBOJoPAY14TfzcTKEbo+rdbjiVALwC5
        qJJ4UC9TB326qfjDsRZcuVpyRxf5wTE=
X-Google-Smtp-Source: ABdhPJzvCpiP218WCNXHj4r6QMUBslZTwe9a87OA+R/nZJwk2v0CCldIVc1V9+IqT1+Rl+iHmq7a0g==
X-Received: by 2002:a17:90b:4acd:: with SMTP id mh13mr711419pjb.147.1597376957120;
        Thu, 13 Aug 2020 20:49:17 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id n26sm7253385pff.30.2020.08.13.20.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 20:49:16 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v8 3/4] power: supply: core: add wireless signal strength property
Date:   Fri, 14 Aug 2020 11:46:56 +0800
Message-Id: <dd97baf0ff97bacdf73b8fbcbbb951a16f644129.1597376585.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597376585.git.huangqiwu@xiaomi.com>
References: <cover.1597376585.git.huangqiwu@xiaomi.com>
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

