Return-Path: <linux-pm+bounces-139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EEC7F63C5
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 17:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E951C20CA3
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3183FB06;
	Thu, 23 Nov 2023 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOPgTB/t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4C810D5
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:17:47 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b36339549so5629845e9.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700756266; x=1701361066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+r17lnAn408XDZCP50GEiVUXSzg8gJpg2O6vmcLUw8=;
        b=dOPgTB/tmckixtW9mlhQAh287zMg632un9YucwCsh8FGFic91g/NMXNWlQUl0Uxh55
         gN9Hg3XxdI7qi25llctF4BJP1Xnk+gSEk9kWAnJWphE86H4MzpXJbHt6UKBmQSO9F8mu
         N2zKMjGPmD0Rqbh/RWr/kABwLs/gQTX9Bgh8vL7t8kpGtfpCMJlR7MelnqtC1FwSG1fG
         lhv5d9kzCY/afSej9gX2QT+SHQiwryBgdV68o59NLpJU9fcB8XIwy9wOWlme6J3KwXqA
         x+O9r29bMnee27USakoFZt8ONRNNWRPAJ8iwu2dzLIUcpQ5WesOBRap9naCru/onD4iu
         wLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700756266; x=1701361066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+r17lnAn408XDZCP50GEiVUXSzg8gJpg2O6vmcLUw8=;
        b=VbHPAXG1r/i8GeI91nmLM6txD1wpu9CmgH45LniakB0mzvwfS9WTay+6C3SzSdHzwy
         oquTRukYo/xPiKEoK0HgiSUZZ7GsfDRJmN1doGNA2MDINWb+8Iy8EtuPJIVhj67SKw5i
         m8JaquBGuNvR4t4JgthoNR7ghNz1X3hbbPngzWy0HpbjiM+h7YZOXt9b/auuJwa//iKj
         NrYKKUrju8zRH+1I8MAZc/ozMjfTP3+W4sf1fIJaI/R1fyPaCFA9iULrFJEbuLgw9zoH
         qBwuIKJ0FZB+URF3LaF5gT3lnoxNYhbybyJ4dMC1WktdB0m8Zv20ioetLbJBnElZjK4L
         kPAw==
X-Gm-Message-State: AOJu0YzMT1lpugbspzLKiBfLC4EURTb/z4Lhw1dpBjFMdTyMB4juc1Pj
	1D+1bCYVHx4u6ooPsjR1AymTZQ==
X-Google-Smtp-Source: AGHT+IETz9wWM20n4EcOTVByPj1PCVyhgGlZT40Husp41oVXnYZX/66zd5tbmlbQ1MnFGe7B94ODEA==
X-Received: by 2002:a05:600c:5252:b0:40b:36e7:1edf with SMTP id fc18-20020a05600c525200b0040b36e71edfmr17894wmb.26.1700756266142;
        Thu, 23 Nov 2023 08:17:46 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y3-20020adfee03000000b0032f7e832cabsm2052748wrn.90.2023.11.23.08.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:17:45 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 23 Nov 2023 17:17:42 +0100
Subject: [PATCH v2 2/2] pmdomain: amlogic: meson-ee-pwrc: add support for
 G12A ISP power domain
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-2-61f2fcf709e5@linaro.org>
References: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-0-61f2fcf709e5@linaro.org>
In-Reply-To: <20231123-topic-amlogic-upstream-isp-pmdomain-v2-0-61f2fcf709e5@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Daniel Scally <dan.scally@ideasonboard.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2024;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fh+alAeyQd+6EQRoyWWcZlg2EgCfV/yy1gc39wpItH8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlX3smSfL7PHAK5roBnpOcsvqwWyGp7LGN11oKwPVT
 UQBlg+yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZV97JgAKCRB33NvayMhJ0Z9dD/
 42G8H2F1iQB1WalKUFK9EdFqjVyCmcLo/V0CzI3JvjfkodlcUDzbUl1Yd99otNMs8D0HfxPJGFY9V7
 S5a35LlTmQcJGzduSmNwx19r86Il1n5jYAaNKGh0ADjUTNw5H5UxFdRNyiPApbLAkaFcV7xp/48zT5
 qelZ+95Oe3Z2AO/FLGhGqdXNsnk/xh6v771/opSxU1tI6lF1G3q2lt2Of3tMFUdR1nlOVe6y+myG/s
 kt4vQSN80oNtzmufuEYR6dkjISqaYUMe1S0tLyKCs65dR/tWJQSqxYOiB6zbGS08QHBqrK5CndugW7
 vtG95szlgUb0BCiLenHWs+WwWEnw7uVZvgOklmDy4Em93txmKrI9vSzbV813kCYnrU5eur/Sa11Aoj
 m+u+me8TFAy8WwXUUs5Cmj82EJjMDgjPaUo6KfeVj2AZKC8I6WaQPKMNLhrpzBmwJsAa5XZ+NMmk7w
 3tTVzvDhLW00ODmk66gjl+nKqk0+XaAbTSHOXll8GsY0hFe8Is435BP148EFL5p4SO0V+5xXFyAsno
 4wH0n0hT7rNDi0h7DhXGK1USBha363nImOMlJaB9wwSHM+HDGpE/rEYrzwzdRYlv60HMMl3DPXiMx9
 ZNSUbihiMeaBe6NA+1gbpXF8hVJ7wGdQYAF7PqJwJOvFSG+PyUCRv3zRDEog==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add entries for the ISP power domain found in the Amlogic G12B SoC

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pmdomain/amlogic/meson-ee-pwrc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
index 0dd71cd814c5..fcec6eb610e4 100644
--- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
@@ -47,6 +47,8 @@
 
 #define G12A_HHI_NANOQ_MEM_PD_REG0	(0x43 << 2)
 #define G12A_HHI_NANOQ_MEM_PD_REG1	(0x44 << 2)
+#define G12A_HHI_ISP_MEM_PD_REG0	(0x45 << 2)
+#define G12A_HHI_ISP_MEM_PD_REG1	(0x46 << 2)
 
 struct meson_ee_pwrc;
 struct meson_ee_pwrc_domain;
@@ -115,6 +117,13 @@ static struct meson_ee_pwrc_top_domain g12a_pwrc_nna = {
 	.iso_mask = BIT(16) | BIT(17),
 };
 
+static struct meson_ee_pwrc_top_domain g12a_pwrc_isp = {
+	.sleep_reg = GX_AO_RTI_GEN_PWR_SLEEP0,
+	.sleep_mask = BIT(18) | BIT(19),
+	.iso_reg = GX_AO_RTI_GEN_PWR_ISO0,
+	.iso_mask = BIT(18) | BIT(19),
+};
+
 /* Memory PD Domains */
 
 #define VPU_MEMPD(__reg)					\
@@ -231,6 +240,11 @@ static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_nna[] = {
 	{ G12A_HHI_NANOQ_MEM_PD_REG1, GENMASK(31, 0) },
 };
 
+static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_isp[] = {
+	{ G12A_HHI_ISP_MEM_PD_REG0, GENMASK(31, 0) },
+	{ G12A_HHI_ISP_MEM_PD_REG1, GENMASK(31, 0) },
+};
+
 #define VPU_PD(__name, __top_pd, __mem, __is_pwr_off, __resets, __clks)	\
 	{								\
 		.name = __name,						\
@@ -269,6 +283,8 @@ static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
 	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
 	[PWRC_G12A_NNA_ID] = TOP_PD("NNA", &g12a_pwrc_nna, g12a_pwrc_mem_nna,
 				    pwrc_ee_is_powered_off),
+	[PWRC_G12A_ISP_ID] = TOP_PD("ISP", &g12a_pwrc_isp, g12a_pwrc_mem_isp,
+				    pwrc_ee_is_powered_off),
 };
 
 static struct meson_ee_pwrc_domain_desc gxbb_pwrc_domains[] = {

-- 
2.34.1


