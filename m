Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16012A9429
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 11:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgKFKZu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 05:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgKFKZu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 05:25:50 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD86C0613CF;
        Fri,  6 Nov 2020 02:25:49 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id z3so912418pfz.6;
        Fri, 06 Nov 2020 02:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBXfFm02ABja54Il3Ns8zFaadLu9ijtBeVpM6C5JJKM=;
        b=F9mSDvj3aiysbsXywu3vPBQXfbTMXTZDaUkdrVL0vNSlMce8ZE+a/kq98+Jv9Ly1F9
         NnCFFGjk/JhloQaksuKF49vOkVKs/k5/qmnkqVffr6/A2Z088iNh65ZxbXf8KnWHIMu6
         e9lkZHQPAZ1hM/QdZbfxw4wUhaSP8DXD3UtSCztAEAiavV36OJFoPswoi3eEhmkOTyii
         JRMHDuGB44vFC0kN6hrnF8JmLn5EQdHvzFl1Jgq6gRnbnDKQpfN1do1R+sp7LaRgdvGo
         whIaQSad+kh+bRvvirq/DZK0kw9s/ReFpfua/ihT5fE9Smqafbt1cSsxrZtkgPSF62hT
         P8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dBXfFm02ABja54Il3Ns8zFaadLu9ijtBeVpM6C5JJKM=;
        b=W1duH5eCZ1qjac2vzHH5K6XXJBrSV783oYU2iTQ/+75btqnAUVo4dCtgEHC26lnTih
         coZocL4T4K4k+iOc+TZwpngJJVOnwdNCz+Vr2adjqeVbIYZEMrLEmngQ/P+pP2g0JlpN
         4uF3jB86tTw0Q+GuJeJKjfrt6X05mhahUhZaaLazUmgUEzpd47rI0exah9tbNB42e6YR
         FlbGxNkj80VjtSlbyu3Ijk8tv4kiRMCDEGv+0oYZI2BwIipA0tQ7WxOPu3IuvXoXzISo
         xiGhgGqoc2mIrnEDsvIaHL+LcT9m5PKsb2T2tTQ7toKUitak5SzJs6CiFLAQAGgVTBt7
         /1xg==
X-Gm-Message-State: AOAM532FNnhmA5c5yvtd+KCP7qPY++YlnM9GPMWLzKl5h0U4pPrhPNRB
        pFDEEQbV2rTuoMWZGgRb0Ww=
X-Google-Smtp-Source: ABdhPJyOoEl2EyBaEKDHqV+DPOhHyR4+tKumhbZ85FjJmKhuLm3MQdmT5CSPZNaFDXLZQh47CTS6SA==
X-Received: by 2002:a17:90a:f314:: with SMTP id ca20mr1829215pjb.191.1604658349132;
        Fri, 06 Nov 2020 02:25:49 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:57a:6823:8ab3:4b5d:4c53:f39b])
        by smtp.gmail.com with ESMTPSA id g3sm1260633pgl.55.2020.11.06.02.25.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:25:48 -0800 (PST)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     sre@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v6 01/11] mfd: mt6360: Rearrange include file
Date:   Fri,  6 Nov 2020 17:53:42 +0800
Message-Id: <1604656432-10215-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1604656432-10215-1-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Rearrange include file without sorting by alphabet.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index e9cacc2..c7a955f 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -5,15 +5,14 @@
  * Author: Gene Chen <gene_chen@richtek.com>
  */
 
+#include <linux/crc8.h>
 #include <linux/i2c.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
-#include <linux/version.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
 
 #include <linux/mfd/mt6360.h>
 
-- 
2.7.4

