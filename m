Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E921CDFE
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 06:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgGMEGI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 00:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGMEGI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 00:06:08 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44888C061794;
        Sun, 12 Jul 2020 21:06:08 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x72so5437110pfc.6;
        Sun, 12 Jul 2020 21:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c2UQvYzlnc2/AAGwljZkMYuOimUwvrvoBN1cwDaK3Ag=;
        b=ZTFXwINjQqPXvn5NNIU5P08lljR+ImntkHPrZiTvkiypv+xCzczQruYIRoRAFrm8Ag
         GcNXWz8ruYFuN51+dA7fHffMoWWlvEA9WsRfSB7jIXxPAK+eufTs3k7Uj386D4iaQ11y
         dz/L5xdd3rOvDx4xVuyVNN/FvcX4tjCAcXOdKGvi61+e643SKMIzzyyE/0vrRHOCtbFL
         PWOB+M+qUdZRcF9CcUjxhaC07CMfQaSuVZZSMKwdQP3eXuaDXI6Nn2J14Rg77F2SI99S
         72I6/J11ryrtHmjBTKvRXfsBg1ixL/C64cgyUDk30EpbTqMy4men33tOr23RlhEv8hDr
         JiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c2UQvYzlnc2/AAGwljZkMYuOimUwvrvoBN1cwDaK3Ag=;
        b=jrtn8rNGRmS2Lct1y7Lwyi+0jXVX/yVrxPBcbzIRq1BEfV8WUcX+r8vUfKaotw5OuY
         k0yDAh5feHE4gnaczn/8wT0HisapDwaT8su3vttq2JSRS4KdZ4U5lHnRV9EVTifpSn9V
         szmpBxdJf3XFmgYOQxQ9IrwMs+6l0wGpeg8PaZ2SOEdtZV2rBijN0PPTqrk9jEsVnZLm
         yevq0ZslZ/RB143sLgeK1txekmODluIQ3He0lwRVsAWZhAC4YkH5X/yCf2PtzbVcxUDa
         nUayWMCyEYa5M15LqvI4RITIUbko+yOMiUHeHun9wJqiMBwZ6aRjzNTppjx2ismeKWxA
         m0jw==
X-Gm-Message-State: AOAM530DKxaMR3uDUCQ8aQz0A9lXq8W103KuUCiSnAzjygYfqjHpc51t
        slS0+YbGfChSdClNAfxxAnQ=
X-Google-Smtp-Source: ABdhPJw+NzUjAbHdzxl3R6oRzgz/t5P87LWjwapN+GRyKy//ULbbSy4yD77be+ZtWSbZfHXwV7BtDQ==
X-Received: by 2002:aa7:8648:: with SMTP id a8mr72872009pfo.222.1594613167716;
        Sun, 12 Jul 2020 21:06:07 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id j13sm12561570pjz.8.2020.07.12.21.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 21:06:07 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v2 5/5] power: supply: core: supply battery soc with decimal form
Date:   Mon, 13 Jul 2020 12:03:40 +0800
Message-Id: <d7b0e268892b6143e537cf823d3a74214f6e6b1c.1594612572.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594612572.git.huangqiwu@xiaomi.com>
References: <cover.1594612572.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Broadcast battery soc with decimal form.
soc_decimal is the decimal part of battery soc.
soc_decimal_rate is update frequency of decimal
part of battery soc.
We want to report such as 0.01 to 99.99% to
user space to improve user experience
when do very quick charging.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 20 ++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  2 ++
 include/linux/power_supply.h                |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index f4234ba1684a..bcc8ccad8163 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -349,6 +349,26 @@ Description:
 		Access: Read
 		Valid values: Represented in microvolts
 
+What:		/sys/class/power_supply/<supply_name>/soc_decimal,
+Date:		Jul 2020
+Contact:	jiangfei1@xiaomi.com
+Description:
+		Broadcast battery soc with decimal form.
+		soc_decimal is the start decimal part of battery soc.
+
+		Access: Read
+		Valid values: 0 - 100
+
+What:		/sys/class/power_supply/<supply_name>/soc_decimal_rate,
+Date:		Jul 2020
+Contact:	jiangfei1@xiaomi.com
+Description:
+		Broadcast battery soc with decimal form.
+		soc_decimal_rate is the decimal part of battery soc update freqency.
+
+		Access: Read
+		Valid values: 0 - 100
+
 ===== USB Properties =====
 
 What: 		/sys/class/power_supply/<supply_name>/current_avg
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 81916b6b6ccf..a837addb4f21 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -210,6 +210,8 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(TX_ADAPTER),
 	POWER_SUPPLY_ATTR(SIGNAL_STRENGTH),
 	POWER_SUPPLY_ATTR(REVERSE_CHG_MODE),
+	POWER_SUPPLY_ATTR(SOC_DECIMAL),
+	POWER_SUPPLY_ATTR(SOC_DECIMAL_RATE),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 319bf6456867..d1aa5497938e 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -171,6 +171,8 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_TX_ADAPTER,
 	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
 	POWER_SUPPLY_PROP_REVERSE_CHG_MODE,
+	POWER_SUPPLY_PROP_SOC_DECIMAL,
+	POWER_SUPPLY_PROP_SOC_DECIMAL_RATE,
 };
 
 enum power_supply_type {
-- 
2.27.0

