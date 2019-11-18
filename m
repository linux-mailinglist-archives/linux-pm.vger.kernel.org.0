Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C057100CC8
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfKRUFs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:05:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32821 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKRUFs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id t5so20466577ljk.0;
        Mon, 18 Nov 2019 12:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jtQOw16WoMpEt4SoGX9byL7HDrHPGiMhOLF5kml9J0Q=;
        b=paJSL49Qt1niUiCqYC8XIkUdjTCfgHWcXo+AnD1uIs7fbJ8VBSH+Ql6Xtj/7AMNqwz
         U+fhZqREpAXa4+rACo1ggFEW2p4jUj+vRjvY2ZWT3E0QEXgpHs1CZER1RJCcmtlFTrhi
         72e2KK+ql3HNXSOh+UMnL4mz8MWfPBYqHTu/GwP1v5uzCsEFjtnr0ncITu9Ck6FRVcBC
         Me7r6NGJLmjZ2E93Cs2qlNYOOkv7krFqc7C1R818I+dDS5GSDOGUpQpzeH2OxipuvguH
         OD13OFKTZfSVaWQN72zkd4JpoWyO2NAitzlDTtP7qlcGI9qxa2eWyRIYBrNfapQwjvbX
         0yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jtQOw16WoMpEt4SoGX9byL7HDrHPGiMhOLF5kml9J0Q=;
        b=JbPzGzvU9oW1Xzp4ejg1gli7PSuIzcZWgPXFVs485i2+u0i5J2raq7v41dJ5wcuxyn
         cV4P30NLC+LD8rsALEvWE0wMPUAl9OLbAfp3tegNVSJ/GM5lvJKFkGS3cNXnH4YvRnI8
         BswWt4FhfVKGNLs2ktlZylhyAJ24qG872yMvvbx5yu99IgfR4mBNOPd9TxT6oX1uBAZh
         m3+U4wHytkAqLGlZGpbCMxoNMH8wM3Nz1oklR69qa4EQ8u/7tKrwF9YuP1JAT7HDEbN9
         ERIVWAzDrucwOK8okp200vqya6mnuvkoKUfkn4ZhelJIPY2FpP55uJ+qkNjkQYmhuNHU
         hG/w==
X-Gm-Message-State: APjAAAWhxzB8qtu5o53yIzEmePpTVMOO4ZfqdqXzjxzWzhmNePS8vokh
        w32eD3tgh8eYPeAiSjc9Vj0=
X-Google-Smtp-Source: APXvYqweojvqcO2WlzbF6KO7J6N1VMDj9n8MbXE7507vvPPlEveZyHQN3RCKshLkdt/YkoVS6tQINw==
X-Received: by 2002:a2e:9097:: with SMTP id l23mr907248ljg.103.1574107545646;
        Mon, 18 Nov 2019 12:05:45 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:45 -0800 (PST)
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
Subject: [PATCH v1 15/29] memory: tegra: Add interconnect nodes for Terga30 display controllers
Date:   Mon, 18 Nov 2019 23:02:33 +0300
Message-Id: <20191118200247.3567-16-digetx@gmail.com>
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
 drivers/memory/tegra/tegra30.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index fcdd812eed80..df0d550b07f8 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/mm.h>
 
+#include <dt-bindings/interconnect/tegra-icc.h>
 #include <dt-bindings/memory/tegra30-mc.h>
 
 #include "mc.h"
@@ -1011,6 +1012,17 @@ static const struct tegra_mc_reset tegra30_mc_resets[] = {
 	TEGRA30_MC_RESET(VI,       0x200, 0x204, 17),
 };
 
+#define TEGRA30_MC_ICC(_name)				\
+	{						\
+		.name = #_name,				\
+		.id = TEGRA_ICC_MC_##_name,		\
+	}
+
+static const struct tegra_mc_icc_node tegra30_mc_icc_nodes[] = {
+	TEGRA30_MC_ICC(DC),
+	TEGRA30_MC_ICC(DCB),
+};
+
 const struct tegra_mc_soc tegra30_mc_soc = {
 	.clients = tegra30_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra30_mc_clients),
@@ -1025,4 +1037,6 @@ const struct tegra_mc_soc tegra30_mc_soc = {
 	.reset_ops = &tegra_mc_reset_ops_common,
 	.resets = tegra30_mc_resets,
 	.num_resets = ARRAY_SIZE(tegra30_mc_resets),
+	.icc_nodes = tegra30_mc_icc_nodes,
+	.num_icc_nodes = ARRAY_SIZE(tegra30_mc_icc_nodes),
 };
-- 
2.23.0

