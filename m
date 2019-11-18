Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B33E100CC9
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKRUFr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:05:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34522 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfKRUFr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id 139so20452334ljf.1;
        Mon, 18 Nov 2019 12:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AXPcCtWfFdM922/tpHZwDdON4BCmhCdgkfo59YRa3Do=;
        b=UDlBXSLm5h/lMmeVtYLejQYPHEsYXSZt3oTVz+XKp/fNbo2O4nKCfW2bZI+3IuE+Gc
         yxvWBMUJf7quIzxKH7PshGVB2yp/jpvVCAEo+oA5/fqQEGpMhGrdlilCm57lbhZ5PDlY
         rc4StURSae5b2aJ5GwKgb013v8JxYtmHfpPA/no7u7nAVOXjPy/5Xo+shDxKMqfACN7s
         lD73XIPwL9JmMQM4po8XQTZtfZjGZs6GZzctIJ6eh+F80BzBBXnNxG5VQxtf4BeUIsUi
         GeZbEtNxNayWO0hIs7l9uAdXC0IyNHLECm8ZtfjpUZpEf5ZGCk4btLlg2MlJed9wZYd0
         rU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AXPcCtWfFdM922/tpHZwDdON4BCmhCdgkfo59YRa3Do=;
        b=TXhafiX5X5k80nlRUQtY0A2qpgW2I49MU26+aDxRF7SQPFZZ1560wWCqwK2GAt4UlQ
         ybbH4BMmtALrtVyaGNUBrHlVZaLi1B8jINNYU0vLl8DRHC9ev4DA/nU8ZeqIT397ilzo
         O1RI0SnRZr4XKvWkTQvSpmS9Wm80s/kcbXiAeGbyF8u6JQt/J6Ekw3XXLSC0f3Az+gjE
         VxdfIiR7+tR/2VJUEU7Cjcinsgs/F2EVDn/rlXEkZPB6kJdM31wKx+g/rRXon9Ccab0L
         oFrY0fl+RGIhUanDMPL4Ua+/6eCHeaIWpybIUo0e9/ipu8MGgrk7IWAswzAIbmoyEU73
         16qw==
X-Gm-Message-State: APjAAAWGGQtEQ2gl69fU4/RbGIi60XnM+IAsysu+dnjk8cLhzfyy8ngN
        ghhHWBHk8UPaZmCXULFF31U=
X-Google-Smtp-Source: APXvYqxFqKp1pbZFLyQGOIJfn/MUcaI3N4Nzzk27nuVm3omARADEcIhY54wVfdD0ARzQMyBu2EvDBw==
X-Received: by 2002:a2e:90b:: with SMTP id 11mr856517ljj.233.1574107544702;
        Mon, 18 Nov 2019 12:05:44 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:44 -0800 (PST)
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
Subject: [PATCH v1 14/29] memory: tegra: Add interconnect nodes for Terga20 display controllers
Date:   Mon, 18 Nov 2019 23:02:32 +0300
Message-Id: <20191118200247.3567-15-digetx@gmail.com>
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
 drivers/memory/tegra/tegra20.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
index a8098bff91d9..dfcd9fdb7ce7 100644
--- a/drivers/memory/tegra/tegra20.c
+++ b/drivers/memory/tegra/tegra20.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2012 NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <dt-bindings/interconnect/tegra-icc.h>
 #include <dt-bindings/memory/tegra20-mc.h>
 
 #include "mc.h"
@@ -280,6 +281,17 @@ static const struct tegra_mc_reset_ops tegra20_mc_reset_ops = {
 	.reset_status = tegra20_mc_reset_status,
 };
 
+#define TEGRA20_MC_ICC(_name)				\
+	{						\
+		.name = #_name,				\
+		.id = TEGRA_ICC_MC_##_name,		\
+	}
+
+static const struct tegra_mc_icc_node tegra20_mc_icc_nodes[] = {
+	TEGRA20_MC_ICC(DC),
+	TEGRA20_MC_ICC(DCB),
+};
+
 const struct tegra_mc_soc tegra20_mc_soc = {
 	.clients = tegra20_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra20_mc_clients),
@@ -290,4 +302,6 @@ const struct tegra_mc_soc tegra20_mc_soc = {
 	.reset_ops = &tegra20_mc_reset_ops,
 	.resets = tegra20_mc_resets,
 	.num_resets = ARRAY_SIZE(tegra20_mc_resets),
+	.icc_nodes = tegra20_mc_icc_nodes,
+	.num_icc_nodes = ARRAY_SIZE(tegra20_mc_icc_nodes),
 };
-- 
2.23.0

