Return-Path: <linux-pm+bounces-37546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C3EC3D25F
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 20:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1022351FE6
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 19:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C46A34DB6E;
	Thu,  6 Nov 2025 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtEVGkns"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D1234FF51
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456095; cv=none; b=lOPJs3UNOrgKZpeoVCbnhBJ+DdH3uMiSyaoYWqRlVbLz7BtEwkGMn4uQX1tGD3u5PEecBHC/ec9RI4lucytNhXYjODoFbMASxlf+D7fV73+tkM935o+rDUP3QFQrbF167VN4OgJxmvetFFhmnzDgOVeW5dMTJb3hdkURthtU89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456095; c=relaxed/simple;
	bh=O33tzwOMuFzj5je6ou6p3VavVz9CrO7CoaSioDAC7d0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SS5GLNCc4Ic/6J6LkvBFw6xItIxMPV6PkDT3Tx8gOgKtdIUPiS++7lXfBOrUDWOR1ni8ftVXGLOU+oZXJTBOHM5Tucmo8j6uTQOWwuN8FJte387mcntUoQTtipd2hRyGGH6gHJ7ZRCV0eubWYjKxYJggh8Xnda9qf4MPyX6sNdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EtEVGkns; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7273abc418so16701766b.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 11:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762456090; x=1763060890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UC7o/Lm5tysqi1r/QiS1zppEaC6hX+4dTRHAwtxyreU=;
        b=EtEVGknsOFhCcSOEMc2+Slmr+7GwYUBA+JQOZ2iFjK4vC9Nwdn3PfUD3iWkslImcie
         lppg8/FSu5qmeVp4E670ra6wh9oOxqrW/yLR5NXgK54A273jBcCdfD6Fg/2uPXAduM4r
         E1Mn3jNUK9hNDMUVxDXe0q56gGdwGaKrbnzU2DpFvIWKUnV/IhZzJ9krccoCuSoyC4TN
         r/51yUb08M2h+SQRN9CYy6vor1DQ2hNnrBen2t/xmCCNLEXcNizC5DC68oRwLUDvSffa
         Oa/0GRUSaBXRSSJi9R2sfjdM9AnS7Bojp75SZvklkNDaBKJztt+qeY8aZ60GbLOKX/Ms
         +uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456090; x=1763060890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UC7o/Lm5tysqi1r/QiS1zppEaC6hX+4dTRHAwtxyreU=;
        b=qoBhbUo0p+9KyIQu2ZSavTb/Af07m1K7zwhdL9GKgc+cyjWqCI7h6q6RTYK7U4LABN
         RKiOC2yaUgC9btRsTliTQO5PH2fCarmuqM3T8wZ3X2B3xpcVn/HTUZZEh+ccsi1QSoSG
         hzZNykT6h+4by8d73rP1Aq2muTb2hxO4SjJ1IarsGK64amJci5pqwDrddzOyiwR3L54T
         BRuAPtW4Ie4oowtZ0MXpgixEI14uvJ/bxXkJMuKaQEfxDDDOe68En+Cay35m+S6RZeVm
         z4FIpmYO/WfM8noYOzAh/9lBlLc6K2X/FAGgMHT3q7NzqQn4X8/h8LGV7CIvBFIA8sRl
         0EAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfZK+dWiSHF2faKxftMsV0IW2ePLrig0qArt9agl+ixHQhPn8BkD/IxGcKfexbGFm96BUrNNht9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyls5Ykf1TUqEw6igdutaviEzs6EJp/cKTplx/JWmddXmofTcmg
	4I/h+TGG2UFtZoO959E4LWxpkETtJ0sWbx0xiSq++NpBSJI5uxcG6L8vyOe1BJuZszg=
X-Gm-Gg: ASbGncuzR/8zExgX+s3yH9IJk1eTwW7UNVHVuLYJ4xbt+zCLiJd34dGUMnHZDMo+h2P
	H6Nv/3mYgHMqtS+NE51K2yDp1O01JnhYO7yD1/1IRmx18+LPZKaWBkD70pBz4Nf9TbhHb53PYJH
	Ex2LCTE2eVP+w/Tz2YcsL6/qPQzrfdNALiW2XwNcA5I7w36ZNEtDwAKB83HJ80Ukik2Aa9qLiNS
	NF3QaVydFHINa7u92xG/U8NuA6bjEgSrF5oMSYqP3MJ5J/EuijAjUYUKv67Pp+n/sY1rGGDE85X
	Iyjvk4n/7geVsYnUonfTq+JM2l/2j9nUkpSFo5HMxLOCuD9Udm3vCMgmHofFPw4l1jI+7KRExKA
	WLqAC6ckQwI3N0sp9/Hj0F+s2IydlNsiUwvGFK8a9hrEHPHQXyo15hHE0unGFq0da/ebEhuGURu
	dSg0Oe7RCaPDFU4J1Yh5RqLrUT5QE=
X-Google-Smtp-Source: AGHT+IH4u0visRizZo2d3rYJCHF6DFTUhu6yOMzJeaTU5w4S3ldRzQL6ooWntCfuedndsflKkieXmA==
X-Received: by 2002:a17:907:1c01:b0:b6a:382a:1516 with SMTP id a640c23a62f3a-b72c0d52bf6mr17951666b.5.1762456090174;
        Thu, 06 Nov 2025 11:08:10 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa2510esm26739566b.72.2025.11.06.11.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:08:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 20:07:08 +0100
Subject: [PATCH 01/13] of: Add wrappers to match root node with OF device
 ID tables
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-b4-of-match-matchine-data-v1-1-d780ea1780c2@linaro.org>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3693;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=O33tzwOMuFzj5je6ou6p3VavVz9CrO7CoaSioDAC7d0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDPIJjcqOIsRPKVtKm1n48qkLFTKl0iTeRLJML
 O0ig2VobJSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzyCQAKCRDBN2bmhouD
 16upD/0ZvU0jba0Dx7VybPnYT2mGXlqQGiRbmnASkWMky8rIi6Sp8RSTLDhpclz2LmVx2skpz9v
 0r6fP/FAMEFShI7EOBA+3f2t6USlukHdnPVV5xooagFdsMEyVL6+LwbgBm0f51zE6VM/tdjSDvM
 lCVONspGTJH1L/sttThdI2ovYpqbZYDhIgRcyLipKeWZte4YfeSzgnv3mOsaZFNFZKNt1Y8jn5q
 lAnXZCY6RgamYZplen5FS1RlMwii6jqAT4iMGTBELYGQSe4sB6WFyV4jpa5ZvU6gKmSjgMPVrAa
 u+SHuX1DmTVBI+iqI+OHv0K5lS2PQIvbQOYEI1nVsSxLPQj3FZDmO2dIMvtZq/A1xk150fjigAN
 IXNMW7CdnSTV4oloo/K2XJKpIqVWKtkjEMeQz8y3d7z+i9ufMn+SvYkCQwhDWwr26gkfEIHxLRd
 GcS4JoNkEeK1NPDp1DJsvbGwTtKcfxX5AE/GI11SX5KqZmCOcZfsh3AxXQsI6q/r/HIoj0pWGr/
 aawjN/1UsCSiEDwm7T0yFZgc40VQp5wqrhuIZclvDr0ycCO6vt4LEFykBHRt5xA27HSsxSWVT35
 oEZvCZypUBmVZTUMfjm3P2tcxblSskFAWSXealeXfawQqRW3usvcwdwSGsJ4wz1RkezOFDOI08h
 PmOXu5HeggsWkCw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Several drivers duplicate same code for getting reference to the root
node, matching it against 'struct of_device_id' table and getting out
the match data from the table entry.

There is a of_machine_compatible_match() wrapper but it takes array of
strings, which is not suitable for many drivers since they want the
driver data associated with each compatible.

Add two wrappers, similar to existing of_device_get_match_data():
1. of_machine_device_match() doing only matching against 'struct
   of_device_id' and returning bool.
2. of_machine_get_match_data() doing the matching and returning
   associated driver data for found compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

All further patches depend on this.
---
 drivers/of/base.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h | 13 +++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 7043acd971a0..0b65039ece53 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -434,6 +434,53 @@ bool of_machine_compatible_match(const char *const *compats)
 }
 EXPORT_SYMBOL(of_machine_compatible_match);
 
+/**
+ * of_machine_device_match - Test root of device tree against a of_device_id array
+ * @matches:	NULL terminated array of of_device_id match structures to search in
+ *
+ * Returns true if the root node has any of the given compatible values in its
+ * compatible property.
+ */
+bool of_machine_device_match(const struct of_device_id *matches)
+{
+	struct device_node *root;
+	const struct of_device_id *match = NULL;
+
+	root = of_find_node_by_path("/");
+	if (root) {
+		match = of_match_node(matches, root);
+		of_node_put(root);
+	}
+
+	return match != NULL;
+}
+EXPORT_SYMBOL(of_machine_device_match);
+
+/**
+ * of_machine_get_match_data - Tell if root of device tree has a matching of_match structure
+ * @matches:	NULL terminated array of of_device_id match structures to search in
+ *
+ * Returns data associated with matched entry or NULL
+ */
+const void *of_machine_get_match_data(const struct of_device_id *matches)
+{
+	const struct of_device_id *match;
+	struct device_node *root;
+
+	root = of_find_node_by_path("/");
+	if (!root)
+		return NULL;
+
+	match = of_match_node(matches, root);
+	of_node_put(root);
+
+	if (!match)
+		return NULL;
+
+	return match->data;
+}
+EXPORT_SYMBOL(of_machine_get_match_data);
+
 static bool __of_device_is_status(const struct device_node *device,
 				  const char * const*strings)
 {
diff --git a/include/linux/of.h b/include/linux/of.h
index 121a288ca92d..01bb3affcd49 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -407,6 +407,8 @@ extern int of_alias_get_id(const struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 
 bool of_machine_compatible_match(const char *const *compats);
+bool of_machine_device_match(const struct of_device_id *matches);
+const void *of_machine_get_match_data(const struct of_device_id *matches);
 
 /**
  * of_machine_is_compatible - Test root of device tree for a given compatible value
@@ -855,6 +857,17 @@ static inline bool of_machine_compatible_match(const char *const *compats)
 	return false;
 }
 
+static inline bool of_machine_device_match(const struct of_device_id *matches)
+{
+	return false;
+}
+
+static inline const void *
+of_machine_get_match_data(const struct of_device_id *matches)
+{
+	return NULL;
+}
+
 static inline bool of_console_check(const struct device_node *dn, const char *name, int index)
 {
 	return false;

-- 
2.48.1


