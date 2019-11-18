Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2265D100CC4
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKRUFt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:05:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41411 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfKRUFt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:49 -0500
Received: by mail-lf1-f66.google.com with SMTP id j14so14867435lfb.8;
        Mon, 18 Nov 2019 12:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SERw9nCbud8tdFDukLLsJdUgk5juTTigzobfxKmrkf0=;
        b=da/vl09U+Ezy+opOo0SLb4ri11IQ/xqN6q8Gu1asTD6BPPWjY/HsIELwTwcrHyaGac
         sbTrkftbAT7GTyGGf25TzcVYb+1/lB+7PNsBXwkVW7t+vf/y3YEkd74ZkfFFwuJ0BPU7
         96Fe6gDSHAh8LMfU4fNYdel+pBnzqi+noc78zT3MiiPFzflJdtZqUzX7islk6dA2RBy+
         Qy2kKIhb2scv05kKVmCfKr11xEW1qI3OweaAbUY1wwBOSsuv2qRYWF/JrKM+GbHfhycl
         YNYpuaLgiFAYJSDluPjk5PJ2Z0y6a7wRM7UU8iO2t1svAtYxfa6qTq2+DPSRpjiqHmzY
         FbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SERw9nCbud8tdFDukLLsJdUgk5juTTigzobfxKmrkf0=;
        b=ZPrcLPtR/QR7KLiQqdw1gNpBcIjLnqCtNtSSzEUwP8cwA8YBOvwrFy4CK8JtJJ8A8d
         KNaBDpWb10UZgSF5sD+4krSBEAJL6MkCEtWqR52pcZsJ6SxiuCaDGEq2Sx4/jRGe9EB+
         Cf/U9+TU0e5Iul60L5mOiaoqJAwBtva87nOPZ4T5afMBb/kkf0VD91cSwcuzgwMHSMch
         A55ucJgclVw6mAem7PStcuAX+l78Naoil5BFvgvAyfHFc26MhV0thNiWc3ZVEPqxbG/K
         ROgthj/YjCxGSzxQDFCtBcOUsIdyeNY+nDpZbTCNvCp18iH2VghMaM6oPqRCxXuA/BBz
         US5w==
X-Gm-Message-State: APjAAAXkV/eq7ZKZ3rsB+uOgaQSTEtIXyYrBO8SsSwYpqefa5JUbAHHV
        TZXecc1IdA8YWaUReEn4Mk4=
X-Google-Smtp-Source: APXvYqy7JAAIPml6XBajTor+RlCN+vGhrDWqbF5FKIOEKhj66PqT47STzTZ7exq/OcNh2vypJEIeug==
X-Received: by 2002:ac2:5594:: with SMTP id v20mr897373lfg.148.1574107546740;
        Mon, 18 Nov 2019 12:05:46 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:46 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 16/29] memory: tegra: Add interconnect nodes for Terga124 display controllers
Date:   Mon, 18 Nov 2019 23:02:34 +0300
Message-Id: <20191118200247.3567-17-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add initial interconnect nodes that allow display controller driver
to perform memory bandwidth requests using interconnect API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra124.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 493b5dc3a4b3..dae6b366281f 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/mm.h>
 
+#include <dt-bindings/interconnect/tegra-icc.h>
 #include <dt-bindings/memory/tegra124-mc.h>
 
 #include "mc.h"
@@ -1028,6 +1029,17 @@ static const unsigned long tegra124_mc_emem_regs[] = {
 	MC_EMEM_ARB_RING1_THROTTLE
 };
 
+#define TEGRA124_MC_ICC(_name)				\
+	{						\
+		.name = #_name,				\
+		.id = TEGRA_ICC_MC_##_name,		\
+	}
+
+static const struct tegra_mc_icc_node tegra124_mc_icc_nodes[] = {
+	TEGRA124_MC_ICC(DC),
+	TEGRA124_MC_ICC(DCB),
+};
+
 static const struct tegra_smmu_soc tegra124_smmu_soc = {
 	.clients = tegra124_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra124_mc_clients),
@@ -1056,6 +1068,8 @@ const struct tegra_mc_soc tegra124_mc_soc = {
 	.reset_ops = &tegra_mc_reset_ops_common,
 	.resets = tegra124_mc_resets,
 	.num_resets = ARRAY_SIZE(tegra124_mc_resets),
+	.icc_nodes = tegra124_mc_icc_nodes,
+	.num_icc_nodes = ARRAY_SIZE(tegra124_mc_icc_nodes),
 };
 #endif /* CONFIG_ARCH_TEGRA_124_SOC */
 
@@ -1086,5 +1100,7 @@ const struct tegra_mc_soc tegra132_mc_soc = {
 	.reset_ops = &tegra_mc_reset_ops_common,
 	.resets = tegra124_mc_resets,
 	.num_resets = ARRAY_SIZE(tegra124_mc_resets),
+	.icc_nodes = tegra124_mc_icc_nodes,
+	.num_icc_nodes = ARRAY_SIZE(tegra124_mc_icc_nodes),
 };
 #endif /* CONFIG_ARCH_TEGRA_132_SOC */
-- 
2.23.0

