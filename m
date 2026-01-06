Return-Path: <linux-pm+bounces-40276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F39CF778D
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 10:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B04B311F267
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 09:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4304830CD99;
	Tue,  6 Jan 2026 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jyPHtjye";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LfZUj+DD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454C30C619
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690937; cv=none; b=hoevhSelElP+3xM8BHMf78gXibsL2JnqlX891FuiZVHeYAw6Tgp1RYkKLYvHa5OKtk7nR8emn3l2l91F5U+qWefA0Vw5gJFy4GGuP9n+f441xZq8y/+6Lmh6Kmv0nKtn/gvpn+3KC8yXT9wIjnVgEzqXEHNm0eVNEJM2eg9EIFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690937; c=relaxed/simple;
	bh=JLd+YJVelW7DAYz5I5oq+Bq5OMySRygwF3/FHKcXlRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQTJqNWn0J3YQvdYSGv61WfoaNnNWVZKVG4yHrss8PuwvmkisBXuQ9EStWhQr4ABfUMbF94QoOqQWK8xkLxxOUx4c/QB7y8smg/sZWI8kGiMwesSimSTdmQly5srVehhKGo7JYoJLV4F8vRcxsc1/r/bwXS+EdNuHuindUPPMt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jyPHtjye; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LfZUj+DD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6063RRcM2432438
	for <linux-pm@vger.kernel.org>; Tue, 6 Jan 2026 09:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	apBQxo7qSrwo1nwoLIpfGQYjycgRUvqMuCwBV3g5lLc=; b=jyPHtjye2eAPhVOc
	PoAK8lUqtWAiT8w8TQfWZiRDQ9pGJxBritSL8tg0Y4L56BTFb6DAMYnIj+86Jnb+
	HOIY/Nmq2E/Mp//T6Ffru9yH654dokV6tl89I1XNdbaSlJw3iklF1VHjrOTKRJMa
	iPtsqn4Zig19W0IQBIok5o17eqI+EmNQCvO5Gd0ch3Zw8Np69pPHirjWHn9SKB+b
	LV3i4wS+J5L1hSd+BRvGIGV99VYDqED7UgA/WApXOhV8Nx4sPT5Dhdk2D8iNy9gO
	aOXJM25hacXO7ZiExwMxxF3FrNzKjNCpSvuka/FOn++kqf/ElGWT96vL1s/5aiZ1
	reVXWw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgr7399ty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 09:15:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee04f4c632so13363221cf.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 01:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767690933; x=1768295733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apBQxo7qSrwo1nwoLIpfGQYjycgRUvqMuCwBV3g5lLc=;
        b=LfZUj+DDJ/VDK0BcYoyQ3VdXSp+IkS5Zqx+JlcldSgcvOIzncnmaS0ypOXNa3VQhlY
         gEBbKHlGF30GmLlElEkfTWIaPNbsdUb5D/GRVsQd/pBeUbu0D+Md6quodmIBy8xKhHP3
         WgSWojHAaW7AislFHhHapCVkw19dBbjrQUdk40qX54+czzxKZTZ3Mer5yOXchYJ+fsjK
         8juOgjbdLVMNIgwWbLzMEd+/7b6sNwn91mLSrbry+8QSmGRGIHLMloxEjXpykOhVAXNt
         OyTqzNMBofnEt7NA/+3ugqazTmDtWdDHBdb+Mt60xFgrRzEpUbWZ7VRPxz90FZ6e1qwO
         ZyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767690933; x=1768295733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=apBQxo7qSrwo1nwoLIpfGQYjycgRUvqMuCwBV3g5lLc=;
        b=X7rnjoyOHDAb9yK/+kEoa4Yfa04fsKye3oF1GA5b6dGH45ceZzI7yrmLY+nsxafFEj
         ov40yADen7xTpMzuNF2dPXhh0gCFiCLRS2u4SWrQ+UOxnY7iliholnwXxM+1wh0dfS8b
         y5+jmBcerFIoQCEu2YZY8iCc3dW3QPQ6Vq8+0lpCOXOIYpJDM2a24GuhLWyk58zotTRa
         HNf8+dFNlipPlsMR5nk8im5I+H/JIjE4xS5YWc5gD0gSxlf5bA8jnt+rJtdbJseqSR7z
         uidwYi1c3WFdFvu7usjI6Us3Lsfu358kiORnUn8l/xbSDGja3bcl7CurbCXI10wAIx0o
         NH7A==
X-Forwarded-Encrypted: i=1; AJvYcCX5o5kwDLtzQysIGn3fuMrYrjqXVkwS3Va/eqvY9fDwBmqguk0uWVephmg93Bg9grG31nMWXDmWOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/v9o31cDVgbbge+Y/oQc5e9a1TtC7eQ8qwinOgVkFxqJuRi4
	nRSDeiQuINZ5GVoRfXVP39TPi85J5BENxfuu4Qs9zV4ybZ389a6bbvA5+sHTyDP5PxO2P0PNwWt
	Z/1OIRrQ0J4ndEYSIjWfjFFl3i29QkvZNMX763798fXQv6wP+t9Bv6l3lbpB2Nw==
X-Gm-Gg: AY/fxX5dgsioQc1iczkd/Kp5wdS+SBifeIxtQIVzeY0fgMn2fnksC6mAIj5T4zcgBt4
	DWM3y1ksSCXAvlgZzQ2k29a3q3tQVNe77ajMy/u5QmuP/FFhNTZBfsY/kbTrVYQKuzP++xwPr8l
	CExENpdrz4teGGd1s1gjhNnggN1E4stetvEWiN2TOig2Jf3VGIrGRPrlQi1H9L4O7S1QiP4kwyc
	ws553m1ydEz6hCgxvy4L/n9n96gawsrkY3jgrHjcQJMeIzWXUsCDzmda6mrcWJqT5CPxmZwVTbY
	CTfCwAYh4ZZtaFXjGFJrNhkGO1tM4Z0ZpH/4lnw/vZM6wp+zllY/OmDdEtqEMADaMHJhe9JtT/o
	K+rwr44b+K7p8XcI75NFxWKn/IAJ+S5+1JQ==
X-Received: by 2002:a05:622a:493:b0:4ed:ee58:215 with SMTP id d75a77b69052e-4ffa76de37emr30150851cf.35.1767690933176;
        Tue, 06 Jan 2026 01:15:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU3Y8zmw4yDdSsZkO7a8vArQ0g4z9wcGDwN18iKO05ZqGqQu4wJ8DuL7AWHNnJ0SucciF+eA==
X-Received: by 2002:a05:622a:493:b0:4ed:ee58:215 with SMTP id d75a77b69052e-4ffa76de37emr30150331cf.35.1767690932699;
        Tue, 06 Jan 2026 01:15:32 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff319sm3271370f8f.43.2026.01.06.01.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:15:32 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 10:15:13 +0100
Subject: [PATCH v2 03/11] ARM: exynos: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-of-for-each-compatible-scoped-v2-3-05eb948d91f2@oss.qualcomm.com>
References: <20260106-of-for-each-compatible-scoped-v2-0-05eb948d91f2@oss.qualcomm.com>
In-Reply-To: <20260106-of-for-each-compatible-scoped-v2-0-05eb948d91f2@oss.qualcomm.com>
To: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-clk@vger.kernel.org, imx@lists.linux.dev,
        dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=JLd+YJVelW7DAYz5I5oq+Bq5OMySRygwF3/FHKcXlRE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpXNKizhg0XZxRYwya0cdJWbbigmzWMszpBlU0f
 m1rX1SufhSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVzSogAKCRDBN2bmhouD
 16WcD/9AhTJOymnDzTKEIECQkDIqwNngscSld9son4Qg1SfT0m0VMq9fHgWlbKbWiApl9CN9J2O
 uESLQE2cmOqFiDE97+ECgudVTYu004061lm3PoQgKxNe6wu1KGtTv8b9izPrlHN4H18M/Xfe/TY
 +95V47mm8FsjC03fWPMoad2dNAbSeglSfoITtmenOcTruqyHxZBwKYOuJaxlPvgn+Xl+TX/sdJQ
 CdbXwQj5gkFylKFlDEWfBVfcHEzRm5qCDIffdoH/lQc5vOjbp/18olrjxjwbYktFI/NZLnWB/6S
 IqSluu/rV/AL2/YkfYpOd0jWcd86Emfe7qumv5diaxtoQK8vqz9p/Uwp/0RZhPjE1CIqRUkVIQ3
 LUXb3vYW1b3fYYHQc0XJqe8TdprAvIisJS+sK8IYgEIeZ9r4ob2mFuurqXosFeM7K9kRD0wHSpk
 zJ/Dbo8xhRBSlqGwCHYiuUr5xD+9Xg2hej2sjSQt6xn3PbbNZZZYgCQV5ku3JZCg5jQRrmV6v2Q
 GQejma+7ZAlcvZYyKT+Ia+TC1jngq6hwyaY5JBi0BTXdkjeZRLcUEZfMftZtpreRex8OYwP9LaS
 sM12WcO970a8+frrRnPAZgGCLbeoDkvIPMf2xoJsHBz0QTDIXlZI86HCo+ybqT/sOAI+HFubvgd
 u3+klfTs97qeiQA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=QrxTHFyd c=1 sm=1 tr=0 ts=695cd2b6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=kVq6N5mEIK0mURhpU1kA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: jqCoxzjeV6PC6Cyh_tTjUtt71RdO7wN4
X-Proofpoint-GUID: jqCoxzjeV6PC6Cyh_tTjUtt71RdO7wN4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA3NyBTYWx0ZWRfX+hhgdL6zLHLD
 xwtHERJRGtpMG6iuobDJt5GrmnqqKZHs0Jx6aTU/KR1ysSWanAD5fr+QGdgF7T4umSbuDrEBVSP
 RbgmxD0BZJR726u8hrl+7p6bjZMu9HkuhPq3HM+x0hinhQvOG4tPeMLB+4OJbfrqI6T/VToMjgM
 kV+UCv8nhrxgb51/nKI5acr2UslTv+ddUaqAT8SwdG+GcZQUoNFI1m9NRGnwmgHbcHd4wWAGF2h
 pLT8fyrx2g+JQ8uCBFRFxGoB3O46w1L81geEY8js29oAYu1aGVTlPoUZJI8UW9NCVer25Z0aTrL
 sLabwmGJ906yJw0Cougyh9h3YdAq+x6SYFi2TEQJKTGvmUrrU/yQCK9Ec1BrM2IqY8v5vS6YKPu
 L0MG2627iHUSTll/jE2O3Ea7Wkgj23drSUJ1YbKcbq/Qbkt/TEpZJEKtlIgoAB5KQkE0n7zdjwe
 73v2FWJjjVKZIOjE6BQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060077

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Depends on the first patch.
---
 arch/arm/mach-exynos/exynos.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 2e8099479ffa..18695076c34e 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -47,9 +47,7 @@ unsigned int exynos_rev(void)
 
 void __init exynos_sysram_init(void)
 {
-	struct device_node *node;
-
-	for_each_compatible_node(node, NULL, "samsung,exynos4210-sysram") {
+	for_each_compatible_node_scoped(node, NULL, "samsung,exynos4210-sysram") {
 		struct resource res;
 		if (!of_device_is_available(node))
 			continue;
@@ -57,15 +55,13 @@ void __init exynos_sysram_init(void)
 		of_address_to_resource(node, 0, &res);
 		sysram_base_addr = ioremap(res.start, resource_size(&res));
 		sysram_base_phys = res.start;
-		of_node_put(node);
 		break;
 	}
 
-	for_each_compatible_node(node, NULL, "samsung,exynos4210-sysram-ns") {
+	for_each_compatible_node_scoped(node, NULL, "samsung,exynos4210-sysram-ns") {
 		if (!of_device_is_available(node))
 			continue;
 		sysram_ns_base_addr = of_iomap(node, 0);
-		of_node_put(node);
 		break;
 	}
 }

-- 
2.51.0


