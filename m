Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D704822015E
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 02:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgGOAiA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 20:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgGOAiA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 20:38:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF6DC061755;
        Tue, 14 Jul 2020 17:37:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a24so415407pfc.10;
        Tue, 14 Jul 2020 17:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v31UIEz3Dwtg5YacEjDmu57JbCXcygtQk9X1DgLN9BA=;
        b=MJSxcvEtp3Y7p+hcrYq1rjGXkaZBgyQWEYJsNvHJANRqI7O6Z5BGS+FbwUdXzCgY+d
         Wyz0O7PPgSIaV/Bv8N5Fg1bJ+frtJknNAnZlp9phkKvyLCaVdqqGMIq4po1eGkEDqStX
         Jc4qCE3IHBGNsfeIA2359MNtSDS30hCC/QDVO0Lu6DsB+HCdjGE3QVRc/ZEQd/KXu1zm
         yy6t7VOdf9ufa9+PUJAqtXN5TW6e2RTtkrUJu60W+uZFK29QGOj0TvszRLHTYnAfCfJ3
         XykCKHlOLurgGGm7vv/WuvCBOgW+bdmnlv1wTAQzRnvFukX/4cO0MsA+Q2LGjnbOTIFm
         Y1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v31UIEz3Dwtg5YacEjDmu57JbCXcygtQk9X1DgLN9BA=;
        b=JCFhKl91JIGOgvffmQ3zeP/RdKaRaTWqopgRV5qu7ozNWWnCmCPAK5hqEN1beUFpv2
         wGji0vX8vevMJvL5Rt4qTYgJ/NQUSMQn7F/LaLUUSmzFzmwhp1nldiKCND60YNGIttE4
         XolnGZnwHiG5eDdhyEA+7xLVeRn3ph4dk/r3HvMwYxHToyPzulBgx5nAmAwgSRGOUNvn
         l4IhXEd4MKGAxh2z/Y7Ky0V63Y4S+CF751/5iFfXp3Wx9macBJ8hLo3Co5FF5iog28dj
         arUZU43R3x3yTpq7XPx2oQCLIWu1ngzXqBf1+vTvgN/e5Z+XCmbVfn69kDhjtSdgGH1J
         rVrw==
X-Gm-Message-State: AOAM531NSB+ZTlXfwPSCQY1VY7oIb0UQAvpyNdOq00QgJbPzBLpDb2Wx
        43OazUVes828KipnnO0odUhoBmOjtc/fWqXD
X-Google-Smtp-Source: ABdhPJzIqRBAELFTUnIIaf/a+MWpl2QQpsiWVJK2IZJVmAxnHSGDSUYcefZpujxHQydNXBLoQTc4IQ==
X-Received: by 2002:a65:64d8:: with SMTP id t24mr5742788pgv.286.1594773479515;
        Tue, 14 Jul 2020 17:37:59 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id t126sm266156pfd.214.2020.07.14.17.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 17:37:59 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v3 3/5] power: supply: core: add wireless signal strength property
Date:   Wed, 15 Jul 2020 08:35:21 +0800
Message-Id: <460b4176d1ef7001cecdf84682c9d39ac676b8bd.1594726859.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594726859.git.huangqiwu@xiaomi.com>
References: <cover.1594726859.git.huangqiwu@xiaomi.com>
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
 Documentation/ABI/testing/sysfs-class-power | 10 ++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 03ab449fae8a..75ec7de2fe78 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -757,3 +757,13 @@ Description:
 			13: ADAPTER_VOICE_BOX,
 			14: ADAPTER_PRIVATE_PD_50W.
 
+What:		/sys/class/power_supply/<supply_name>/signal_strength
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		In PING phase, RX transmits a signal strength packet as the first
+		communication packet to instruct the base to keep power signal on.
+		The value reports wireless signal strength and show degree of coupling.
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
index 0bbdec1630a4..346c6c9c0737 100644
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
2.27.0

