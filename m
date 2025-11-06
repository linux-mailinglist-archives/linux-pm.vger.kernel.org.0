Return-Path: <linux-pm+bounces-37557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27151C3D342
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 20:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38AFD4EC118
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 19:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2CF3590A5;
	Thu,  6 Nov 2025 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDLrhueV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8859358D1C
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456119; cv=none; b=V9gT56xJJHojT2xoIp9Elk6ma7U7qq33eJveqEFDeWNgC/KsvdiFbQbLLVx+CfdO5bbFyUdZd5PTrhyWstkx80KFt+D75oWEzP48Pu15Rd/6Yzeof1psR091SuzrY9vTNn/Db1S1oe9MkbTHFHWQFRzQZ7d9SVQu8vbU/6GaiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456119; c=relaxed/simple;
	bh=duU5u56PDy568nC9gTgD/sRRW1Kja+NAYhWyt8rAuUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wf7xKfwXJ6n2A8AvUpBgIRhLYf9p6zUZghZLMBIxqU77/m1zUckHPsknz8gIGpDAjrllHJlWbSpxBeVK7L8F6x/k9aIMNqkrh0I8y1KAqr+bo5GcB1BQR+TKhF64NHDvpBiqv+JUOLKwq9btLkjyExhfZV/h98kwJnIVMPZHPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iDLrhueV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b70b40e0321so16690166b.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 11:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762456116; x=1763060916; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCEpBcWqzOzxXS+spa/CGSDCftzF1chyjPQmDO6LlhQ=;
        b=iDLrhueVLDgcz0P30hT8Hucm3xNNZnhXdG6A4k1joRn7iu0/I+jiHJ5VIZ/QWp2k8e
         yPgCwF+1Qx+OnmZZce2NBtduUsOn8yNicMTGCWXAQ0JEnijIGu39UIGuGLM115kqzbKx
         nHiNcy8QPAFZMTvFSMU7gk2HlUEVzO46BP7woaG7oH69hLYl+q6nKgMJ356485Bcrpin
         0RMNrw7SxTeGGWPUThb3sSuDLfYL9yC2Afm9yYtz4VbBu5gBw8kQXSAEx/BpQjEIIvwg
         lTM1ghMQWOohECkZW4A6DoCmbWlr4iD/pUC9ONPMIcHfHYzebUGD26yX7V/GaRZTLmmd
         T9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456116; x=1763060916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YCEpBcWqzOzxXS+spa/CGSDCftzF1chyjPQmDO6LlhQ=;
        b=vL6n56dpli3xVlS+iiHGDRl8rd510zYELu6S/CZv8k2Sxp18O+TrYz5yLY+FmX4aVh
         Py6mkvEg8IcY29PR+s6oFkrc3RY2y9z8gIkVggevIEY1UoN5ZsC8qbXDuVGtj1X8Kila
         adOkxac12PXdeRlf8QVh+0bjGGFyPEPJ/DOIVfi3ZVsDYn5yaXhtBWpZwRtvMW6JbpFM
         TSRB5PxQZl3eyAGlq0/JoZz8KDY4cRH5bLt51598mtm5OvxEMlEABuAeJYfZ2cX7MdCU
         4GgimSa0gvmrONKW7Z4vY/m6ybgYX00Ef5FYa7zM4ajc1os6+IgtBpDwfaGN/Vl/yyrf
         hvcg==
X-Forwarded-Encrypted: i=1; AJvYcCWGWzPZjzoKV9c5kQNWIKfhfJjNnXeKN4lJ+isX4iDfhyiHcqpTP83CFIT352nC137NWGkU1vkypQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEQ+Qf5I5ZwFfIKGW5kLHKfqAnzMKRYtKqBgJsYqwMTQtvdwZ
	IkGsBS5fdeoSXkNu2O1Wy8MRm1ngWIcpuH3xAd3xEsKVvj4cguR7pCL7neymTuBrK2c=
X-Gm-Gg: ASbGncsecG1BtozKPZD4rlZi5uvCQ21sdjumZcVLylXsTdaFPBogmcOecqzmMFKHbOF
	21ahENQ00pEuh0dRCigkGJGr1Y77To7cWCqMWBjIEp3vTu8RCj4S33HEy0p39bxjovYY6ABwFYB
	QfZZJcFaILbosvm6UMeg4VOwCmtpB4JFm4DB55evJ3vTLXyAJLPuE4+/TNl6VXgwCp2SVoqfzLQ
	roG0pxh634L8cbIrvkPNa+wG8RkhgtLU/8pibps93Cf4mwjJmfiuaIzt33obYs37O+XSig+9cLQ
	GlDQtPJ7PVhcSkj/wS1uJCIN4gIpNtOxY9Hu6sOT8aGJ8/HnpmPHa1Vsq+apP9XIBLXf58XqFKS
	4yvy2SC8yEhb8DVosxKmnh5TpSObIivmsw9NhoMU08uiy0iVLSfI01+xwWOirJIdLSSZxXa6OPP
	2J6Sh39fkk01Kyf8TE
X-Google-Smtp-Source: AGHT+IGtACsnNdaWz105iCINoWr5n9UXht5NcROgRS6+92tcuuFFCVXa8Xeak1w/fHe1KKxJJQTUmQ==
X-Received: by 2002:a17:907:86a1:b0:b70:ab64:434f with SMTP id a640c23a62f3a-b72c0a8cb89mr17450666b.6.1762456116128;
        Thu, 06 Nov 2025 11:08:36 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa2510esm26739566b.72.2025.11.06.11.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:08:35 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 20:07:19 +0100
Subject: [PATCH 12/13] soc: qcom: ubwc: Simplify with
 of_machine_get_match_data()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-b4-of-match-matchine-data-v1-12-d780ea1780c2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=duU5u56PDy568nC9gTgD/sRRW1Kja+NAYhWyt8rAuUM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDPITu0xcd1Xu7SDbTfboqrqtm0O8I5f3k4GxJ
 sb3DuVcYy6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzyEwAKCRDBN2bmhouD
 13hVD/4nWu9gGWq6/LJwCrfVYOFlQ2hUn93EjQWiFRTwwmgC9sbS3NA9MR19W+gEIdKMVerKLcR
 qWz4RXbJ3AR8qwBVAgGhp5mP8v68fVp06zYEjKkmsDZd1zJYY6QRtlVK4l5h0J+my+9zwRl8O+Q
 YzKoXLBhxFNRiLPny1JxlIa1yaTC6CNYWDt04MnQmbnPJehWYg1NUbSWkF6HsEdtyFhqGcvc/+B
 9uZA72RelClKR8PfknzlUexnJVx/QyUbApsMuxODlLZaZAV7oL9xM4Zqgxolw1524IZe2eDPBgD
 KS1EquOwIM6NUJIbkQ0MTBy48To3g3jW7ssf0ktGE7EI1tPR3YvdCgq4R9h6yWDw3KaquxNvqRM
 JBcv1EnddNFIiMxi05AfKZ5xkuWv4dxzdVQqw8kgF6p9YpgE8ib3h3WM5JtHXptC3QswTi8sspr
 HocdHYB2mNKGLOKFSZ+4N+xnPr/oO49a15Nl0B1bNbdKTUmPBLfIn5f2jGjRubu6zmW6mF9m132
 6WsB6B1i6jZUXmWjgSvfn4pc092phlb0LULHZfbJSgzsN/y0xTkKM3TihUIYS0w34xthKyg8Zk3
 pRt3JEIKc/Qm4FALNBmlQN6hGotDxh4wfz1G2vFQhMROvMlxYyGvu+V0LTe0qSvGDwveKy11LUH
 1LudEj4LNSbfXzw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Replace open-coded getting root OF node, matching against it and getting
the match data with new of_machine_get_match_data() helper.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first OF patch.
---
 drivers/soc/qcom/ubwc_config.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 1c09796163b0..1c25aaf55e52 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -301,21 +301,15 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 
 const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
 {
-	const struct of_device_id *match;
-	struct device_node *root;
+	const struct qcom_ubwc_cfg_data *data;
 
-	root = of_find_node_by_path("/");
-	if (!root)
-		return ERR_PTR(-ENODEV);
-
-	match = of_match_node(qcom_ubwc_configs, root);
-	of_node_put(root);
-	if (!match) {
+	data = of_machine_get_match_data(qcom_ubwc_configs);
+	if (!data) {
 		pr_err("Couldn't find UBWC config data for this platform!\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	return match->data;
+	return data;
 }
 EXPORT_SYMBOL_GPL(qcom_ubwc_config_get_data);
 

-- 
2.48.1


