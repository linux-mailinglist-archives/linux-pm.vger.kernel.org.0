Return-Path: <linux-pm+bounces-15846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5B29A1D97
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 10:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7B1284610
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 08:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F51D619D;
	Thu, 17 Oct 2024 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuXI4RuY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FF1D5AD4;
	Thu, 17 Oct 2024 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155125; cv=none; b=QAtnun0cuECk7iPi4RW4e2lflLdhbAfwjjMK3w69F0XC6s/Le5z/N0NZr9K90JMMewzHCGCBViI+JD7tv5LxPkSpmpioBpQzcxP+Cvx4Svb+uMIZkPJ4+FasJDuudyFu7Xr5jmyLCRQ1Hoq2mNWXCN9oVgAqUCbyDGMX8a529Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155125; c=relaxed/simple;
	bh=gEvb6Lvc7GI3LGcawTs2HtCBndRHTWo+uYHTSmyA5Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGuc5XoStSy348x1K8TfLftGirL0GjMp1DZmEuvkOa+L015ZFCQ7uE9ZFMsJgL+QRxRR7pmu1CWfg6XjzcCLDORZzwM5mwlOr9GI/p2bDZ4JiPpdcV0fC8yBScmwJE/7rMDGktyENUyUOnZFRenB+Wg/1ZJIAleeUsqOOnySu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuXI4RuY; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so6329211fa.1;
        Thu, 17 Oct 2024 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729155120; x=1729759920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIKQOSn+OzCMfWxjDnYu4Cj5q8Asx6TloHeXxyGjmj8=;
        b=kuXI4RuYnWOyb6TEdcxEfCpU3dLUdz+dlcX9a1yeB12KNyrL+OdyPIQJ7oUXQKTSJK
         T+cp4hdWaX78aqC/FO/N1jPBK8Lc3njuAQtQhfOvKhtDhD/XdeL7hDK4F0/MeqL64LhN
         4UildAcD4xYD1aCluUHWCFe1mkkyJ+CMTaHoTmdENl5Sb10cjfUdLEUWbKT4pl1i9zaB
         rUmmO+aVwBSyPsOvImxAGLKgz5NsFowxVNO1Nk2fqD/DfwCPbvgecfofoL9JekwWjZOM
         YeJ92ktmeJNHsjKkpYgDouQF447YUmzHE5mC2WBg7HIO6yO+DTvBs6J0C3/Mc8yToz/o
         HZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155120; x=1729759920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIKQOSn+OzCMfWxjDnYu4Cj5q8Asx6TloHeXxyGjmj8=;
        b=YBGx3GsoP992sjUWm3gej2Ne6/Bqw/fs2nQx0vo/wijEcB/7ju6w99M0ZWP+EguSoL
         t+1Oj8luN8iNn2HTzZbfaBbRy5MgqjbVfuVeYUDY+UQe4AyniV398w0t/yc4/7vu+eec
         ODiy/2nCy0xlGOEGLqQiorzXWQuCHZgDNC52gYr4LTgOqRW0Sy3QEh0nmLoQvutplInF
         quwMQl0GkP90OkKrc94k2O/JaqMIYLW9CY/E5JkKLaslKHN4uKR+d0t5aruasqChoVjO
         zlxrMngzWzKBNR1q5jqmBB5LO96i9h7aHacCVKEmslCwr6fcMKECLm4tzjr0jF8JizYP
         o7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUemRSw6x42O64kl02N+MOUC/YaGZBa7zO/OTfvX+2aPsGlS3TEXDv/cDoWK6PUcN50dsd/pDWqseOh@vger.kernel.org, AJvYcCUqK53F487c8zCYiDTT90DjO5wAwczqvYKdh5zbrp0+VOrkTHDR3XWWn9tJI0i7MZVzK5kYgjcKzQE=@vger.kernel.org, AJvYcCVPz9kE7SJltIi53xdKLN94pNmCfUrKY8yAiWC6gbsXnLWsdbUZc+5T7dFc/YDLNNIBYTjWGxAHAYQyO2Zf@vger.kernel.org
X-Gm-Message-State: AOJu0YwDG3HHmwb0v4ia7wyPNSkKX1pfu5vNAz0ME9WyDP468RNdgx0w
	BffLrECt11DvVnBvkd56qZVlBFGd7Xxq0VqGdgV5XqmGdov5HezQ
X-Google-Smtp-Source: AGHT+IFa05Tw/OxDuv2XAa8AxBAc26dQ4PJSNT2cz40KikvUKyt7MVPDkF5xJw0vAU4W5HtGJocRug==
X-Received: by 2002:a05:6512:3994:b0:539:f2b9:c4d0 with SMTP id 2adb3069b0e04-53a03f8865amr4887610e87.52.1729155119163;
        Thu, 17 Oct 2024 01:51:59 -0700 (PDT)
Received: from zenbook.agu.edu.tr ([95.183.227.32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29816c24sm267045266b.110.2024.10.17.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:51:58 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Fabien Parent <fparent@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Alexandre Bailon <abailon@baylibre.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/2] soc: mediatek: pm-domains: Add support for MT6735
Date: Thu, 17 Oct 2024 11:51:35 +0300
Message-ID: <20241017085136.68053-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017085136.68053-1-y.oudjana@protonmail.com>
References: <20241017085136.68053-1-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add support for SCPSYS power domains of MT6735. All non-CPU power domains
are added except for MD2 (C2K modem), which is left out due to issues
with powering it on.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mt6735-pm-domains.h | 96 +++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c    |  5 +
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |  2 +
 include/linux/soc/mediatek/infracfg.h         |  5 +
 4 files changed, 108 insertions(+)
 create mode 100644 drivers/pmdomain/mediatek/mt6735-pm-domains.h

diff --git a/drivers/pmdomain/mediatek/mt6735-pm-domains.h b/drivers/pmdomain/mediatek/mt6735-pm-domains.h
new file mode 100644
index 0000000000000..71896be68e227
--- /dev/null
+++ b/drivers/pmdomain/mediatek/mt6735-pm-domains.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT6735_PM_DOMAINS_H
+#define __SOC_MEDIATEK_MT6735_PM_DOMAINS_H
+
+#include "mtk-pm-domains.h"
+#include <dt-bindings/power/mediatek,mt6735-power-controller.h>
+
+/*
+ * MT6735 power domain support
+ */
+
+static const struct scpsys_domain_data scpsys_domain_data_mt6735[] = {
+	[MT6735_POWER_DOMAIN_MD1] = {
+		.name = "md1",
+		.sta_mask = PWR_STATUS_MD1,
+		.ctl_offs = SPM_MD1_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = 0,
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT6735_TOP_AXI_PROT_EN_MD1),
+		},
+	},
+	[MT6735_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = SPM_CONN_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = 0,
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT6735_TOP_AXI_PROT_EN_CONN),
+		},
+	},
+	[MT6735_POWER_DOMAIN_DIS] = {
+		.name = "dis",
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = SPM_DIS_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MM_M0),
+		},
+	},
+	[MT6735_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = SPM_MFG_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_cfg = {
+			BUS_PROT_INFRA_UPDATE_TOPAXI(MT8173_TOP_AXI_PROT_EN_MFG_S),
+		},
+	},
+	[MT6735_POWER_DOMAIN_ISP] = {
+		.name = "isp",
+		.sta_mask = PWR_STATUS_ISP,
+		.ctl_offs = SPM_ISP_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+	},
+	[MT6735_POWER_DOMAIN_VDE] = {
+		.name = "vde",
+		.sta_mask = PWR_STATUS_VDEC,
+		.ctl_offs = SPM_VDE_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT6735_POWER_DOMAIN_VEN] = {
+		.name = "ven",
+		.sta_mask = BIT(8),
+		.ctl_offs = SPM_VEN_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+};
+
+static const struct scpsys_soc_data mt6735_scpsys_data = {
+	.domains_data = scpsys_domain_data_mt6735,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt6735),
+};
+
+#endif /* __SOC_MEDIATEK_MT6735_PM_DOMAINS_H */
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 3580913f25d39..b866b006af699 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/soc/mediatek/infracfg.h>
 
+#include "mt6735-pm-domains.h"
 #include "mt6795-pm-domains.h"
 #include "mt8167-pm-domains.h"
 #include "mt8173-pm-domains.h"
@@ -608,6 +609,10 @@ static void scpsys_domain_cleanup(struct scpsys *scpsys)
 }
 
 static const struct of_device_id scpsys_of_match[] = {
+	{
+		.compatible = "mediatek,mt6735-power-controller",
+		.data = &mt6735_scpsys_data,
+	},
 	{
 		.compatible = "mediatek,mt6795-power-controller",
 		.data = &mt6795_scpsys_data,
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index aaba5e6b0536f..2ac96804b9853 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -21,6 +21,7 @@
 #define SPM_ISP_PWR_CON			0x0238
 #define SPM_DIS_PWR_CON			0x023c
 #define SPM_CONN_PWR_CON		0x0280
+#define SPM_MD1_PWR_CON			0x0284
 #define SPM_VEN2_PWR_CON		0x0298
 #define SPM_AUDIO_PWR_CON		0x029c
 #define SPM_MFG_2D_PWR_CON		0x02c0
@@ -30,6 +31,7 @@
 #define SPM_PWR_STATUS			0x060c
 #define SPM_PWR_STATUS_2ND		0x0610
 
+#define PWR_STATUS_MD1			BIT(0)
 #define PWR_STATUS_CONN			BIT(1)
 #define PWR_STATUS_DISP			BIT(3)
 #define PWR_STATUS_MFG			BIT(4)
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index 6c6cccc848f48..9956e18c5ffa9 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -434,6 +434,11 @@
 #define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
 						 BIT(7) | BIT(8))
 
+#define MT6735_TOP_AXI_PROT_EN_CONN		(BIT(2) | BIT(8))
+#define MT6735_TOP_AXI_PROT_EN_MD1		(BIT(24) | BIT(25) | \
+						 BIT(26) | BIT(27) | \
+						 BIT(28))
+
 #define INFRA_TOPAXI_PROTECTEN			0x0220
 #define INFRA_TOPAXI_PROTECTSTA1		0x0228
 #define INFRA_TOPAXI_PROTECTEN_SET		0x0260
-- 
2.47.0


