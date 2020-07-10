Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812B421B19E
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 10:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgGJIvL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 04:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgGJIvL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 04:51:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00211C08C5CE;
        Fri, 10 Jul 2020 01:51:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j20so2260657pfe.5;
        Fri, 10 Jul 2020 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MeCDns59/k2bXtkn8SMRmiwgQqN/hMhz05uwtyfKKUM=;
        b=HNOZWK7SwXsnFaNyNyvu27IJMIt5XSrf6bLCyYlf0APu1rWlDf36KRnbzVfABE7QtA
         XschrBNM1eshFsR99uVvaEk9MGaaobQtxPq8Y483DbJ9nMpwoD8/z+MAweL+jpf/fl2L
         0Nue25QBtrPTZSb42CK0v+fkcYenKIamVjeTpG9wKWjsClcESBH8gWGvaNHMTN5I5+b8
         TQEbzuJIeBRx9e5B4CSVPq2dixBFhfiFe4WV2nmD8Up5Lxeeq0Q7h2Ua2iZBzWTmbTjq
         csmzpnJiLpRmbYCw21MYLOWv6o9V2e1Y1Bq5kPWhlp8Vac11gvz6sudUbZbqQjGL2BM/
         XDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MeCDns59/k2bXtkn8SMRmiwgQqN/hMhz05uwtyfKKUM=;
        b=YKnpB0qYA83UPViRQUvcWXGXwUv5CTG0cSLYpCWlZIC9jFyIupjLaEtUqXExCSG2PK
         ygKoSetKe5KKTYeHsQYqIb+0VvNdmEIq/DYHVJafAbChoF4v7ZoYHoN0KKL9kGOu4FuI
         2UmJeifRKG+roHuhl/MUbW1IZTFtCp5he0s4hL2iBpfjQbRuL5MLEx/WOshA7JPxNjov
         sq4MKKGmaEsOk3OaxXHnOB0gTQTidcj3St/8+K4Glnv9i2Lhx2DAW7H3BGLvmq5Zdag6
         0QiXtg+CsK0tFWwiR/A93d35b21wMcAtzPHhk1g6gZRE7mEcDocWI378D7LUkKk8YxUK
         x/3A==
X-Gm-Message-State: AOAM531W9l8PW26aqmNP9dMUE487ejgAaLMjO8yKXTiZ+gzG0UfrK90O
        ZbKLEeQO7aDjM/u84Yyacho=
X-Google-Smtp-Source: ABdhPJxjSoOvDBzyXkU35F4bRtBqORPXDAxYRHxJp6IIZ2XkTf5pKjqKLzWOJmUdmoW302Fgy6YTIg==
X-Received: by 2002:aa7:98c6:: with SMTP id e6mr63130832pfm.17.1594371070449;
        Fri, 10 Jul 2020 01:51:10 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id e8sm4734273pff.185.2020.07.10.01.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 01:51:09 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH 2/5] power: supply: core: add wireless charger adapter type property
Date:   Fri, 10 Jul 2020 16:48:38 +0800
Message-Id: <20200710084841.1933254-2-yanziily@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710084841.1933254-1-yanziily@gmail.com>
References: <20200710084841.1933254-1-yanziily@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Reports what type of wireless adapter connection is
currently active forthe supply.
for example it can show if ADAPTER_PD capable source is attached.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 13 +++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 0d9d6b46e239..2099cf194a89 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -718,3 +718,16 @@ Contact:	Fei Jiang <jiangfei1@xiaomi.com>
 		Access: Read-Only
 		Valid values: "QUICK_CHARGE_NORMAL", "QUICK_CHARGE_FAST", "QUICK_CHARGE_FLASH",
 		"QUICK_CHARGE_TURBE", "QUICK_CHARGE_SUPER".
+
+===== Wireless Charger Properties =====
+What:		/sys/class/power_supply/<supply_name>/tx_adapter
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		Reports what type of wireless adapter connection is currently active for
+		the supply, for example it can show if ADAPTER_PD capable source
+		is attached.
+
+		Access: Read-Only
+		Valid values: "ADAPTER_NONE", "ADAPTER_SDP", "ADAPTER_DCP", "ADAPTER_CDP",
+		"ADAPTER_QC2", "ADAPTER_QC3", "ADAPTER_PD" or other private adapter.
\ No newline at end of file
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f95574c41898..c864a14829ec 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -207,6 +207,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(MANUFACTURER),
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
 	POWER_SUPPLY_ATTR(quick_charge_type),
+	POWER_SUPPLY_ATTR(tx_adapter),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 3fe7e9ef2f0f..2de9a4c93723 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -168,6 +168,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_TX_ADAPTER,
 };
 
 enum power_supply_type {
-- 
2.26.0

