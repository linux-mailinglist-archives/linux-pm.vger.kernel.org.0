Return-Path: <linux-pm+bounces-40553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 256EBD0B76D
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 18:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C727330F0FB3
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C9C3659FD;
	Fri,  9 Jan 2026 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vykohv77";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IvuTgpcZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5CD364EB0
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977901; cv=none; b=SVtvsWh8MQtRzSuwb//sg9x5X74iQvrzITewkukk/fG4Q/J5dgqSXfQblf8fZ+O0iHxAfqBdcAKBwiY3RRgwV+kfOhoe6dV2Ou4icbjJNZj4WBCk8XosRrEODd4IxDvlLXKTSyttF3JCgHhTiV/iLwihb1vUprLTftbvJL1b4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977901; c=relaxed/simple;
	bh=hWij0Cx2nUsE3a6sV+TeED1rlFEQMwzrQCGei407aGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UZvq8Iz2aG98BxSZ+U+9YfjXO4fSYbyRatwv/IhEPdUHvSaksPUmEUq89NWw8u6/LZmMfBdeTp+1J7CO6Cgv6DIHv+yvHN6HN9ySb4B5X3FcSjfl6H+mKP9WNLbqz6Z2Zt7Ww1njxZkuNUEQeG1Txt3rpSyrgLdsfPBQEYA02Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vykohv77; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IvuTgpcZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6099XhnL1048225
	for <linux-pm@vger.kernel.org>; Fri, 9 Jan 2026 16:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ADXvSV8kR6oK/joxnZuLV2sADvFjrfufvsAY5SEvyoo=; b=Vykohv77h7z1Of4A
	xXh/fqXuzRIH/PbRRIxfYdGGnxwMQUo8igi1aNjeeV6K6Q7c8bVeyJadWeXzYDU6
	PhWQfwMWtVpVsacS9iASx7ISQoQ6f4Zk+kNh9kzbQHxtqTQ7aFYv61QhOwwFgrUX
	+LZXegAPJkQj0Oq8Mfw2PT7WnMjosGX3u3ZObRY7IgEfWIRGR2aID4S7cBNnKbBa
	k5QH24HY9KzH3SwS+g2rxk0NyQn4q9ICWkZOvPDJfnLfFXO4E3fB1a29bB2te7VN
	kWMOMNx7rjBp7HvW8utlT0nd3BRy3gK10OCnA+E0Kdlhr4z4IKVYCRhyf8bKXKaz
	rdfaYg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjy5b978w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 16:58:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b24a25cff5so1310079185a.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 08:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767977895; x=1768582695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADXvSV8kR6oK/joxnZuLV2sADvFjrfufvsAY5SEvyoo=;
        b=IvuTgpcZhSa1Pqx7gCjQ8vDeB8XUSArcGgVODYXHG7hHJDCbYAEvaFi2ydBJmiMr8o
         lz5Or1Mpd78KIDQB+X2LM0D6hwGD2h32mHwNiDJXX99efGzyYs3cIgELXYJ5gHDu/8cU
         ugml/ZLn/NlQnTpa25Km9LJr3a+5iKUf9anstU3v1aODcFVL5aPnuymOZ8iOm9qj9c90
         w9zOELhHdgYveNK73M+xl5a7nCxdDsd/c67psNyMJNs0rGpu/rWt/dM9H9Y+WJei2BNT
         CM83+qOMBxDnuU3eOTlst3l7xqcTtEnpRGuETVil00+MxPXeVk3+gWXEqm3cnrv0gr6r
         4Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767977895; x=1768582695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ADXvSV8kR6oK/joxnZuLV2sADvFjrfufvsAY5SEvyoo=;
        b=ALm8tb8Ly56Cq2mc1GvJDZsOpriC6ZQY9lUc9a5sO8kcmK6iCY6OrObnL/9mn5uGT3
         9ZtYseNOTEwK78I6jKtDey+BHMZ97pCQ6mWVAgVwAvg0iP6sLO4HrgNRvXHTN95wi4EJ
         SZyCGrqJEdk8suYEiHgBII+tOvfGIfVtoyuZurmCyeZKe0vZEILFH1qfTbFfkbUPKKuq
         rYZB4DGWd4PbirLt/y1EA/78PaIYRDhadlf467538EMClYxuCO/3ECFLTTh36QU532Yn
         KUfXiBtiDTqmcWeTNL84vxj15aRHcDhouauKN9jTmOueq4XBl3MJyGTClKSzokd7vxgH
         /Y5A==
X-Forwarded-Encrypted: i=1; AJvYcCVIGbACNKMxr8h+WClkxcj5dGx33HMFU7RY7QSoqsWdSnxxY2b6tZWtxSSlyK39X1Os9bkiQYSZqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF4B++RCfkovUZ2QRbSYUlgrbbpSFVhDk6npjUY4V9F0ZGwrgv
	z8PNvTlO/jLLCZqfO8A1yh5pqI6vA/2B77s/Lh8SUgvjs05zqGomoCt+2c3wY+Jgv6zMCEtv3dr
	5bY5es7n+gXYQ7kwAj7XWA02ISjF322+vFWRqxYGtNQAxzdD1Ld2lD56V6EutpQ==
X-Gm-Gg: AY/fxX4AzIIXu8hbXyuGpjEPT6FfnV0Y372jUsgeL7ARmZMB5fKTABXg85aQVQhlvIz
	jNtg9QS7ia2FfXbvjjmeHEOWVZiYlVIMDw4pcPH/HbCXtWUJsc946IfqYhPK82EDaSwwbKlCB4y
	CuX6q/ZfgLCHEZtdKdffZy6beMLkbSZ/EKz4kRUG3VO1JyhwmlP9E8ZAc5ojYllfwby8PGPMP2V
	AF2tzya0KTnuJOv7aGjnI4dy7VvoF8wt4m6DyNg1g9PH97l9KQUip9TVtnk95eRGWu5ArAF1j62
	HTXtNbYlTm6Kwf00m5Qxn4BGTqmijZDm+Fs1VxNleq6lsUnc3OcHakkCrC3KfVl1nER66hLSJeY
	S8syChaOOvHHv3Bj11Ys3x0SOQm02BDqEgQ==
X-Received: by 2002:a05:620a:17a4:b0:85e:b7b6:81e2 with SMTP id af79cd13be357-8c3893eb55fmr1410580885a.50.1767977895036;
        Fri, 09 Jan 2026 08:58:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrBq7Oj9urWGrpAyGkXDWzVgxkYyRBhfKrUthko6Zes9haa8dRS5mYm1yWfIN6yIJkyYVWUA==
X-Received: by 2002:a05:620a:17a4:b0:85e:b7b6:81e2 with SMTP id af79cd13be357-8c3893eb55fmr1410575885a.50.1767977894515;
        Fri, 09 Jan 2026 08:58:14 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm23231784f8f.31.2026.01.09.08.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:58:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 17:57:47 +0100
Subject: [PATCH v3 03/12] ARM: exynos: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-of-for-each-compatible-scoped-v3-3-c22fa2c0749a@oss.qualcomm.com>
References: <20260109-of-for-each-compatible-scoped-v3-0-c22fa2c0749a@oss.qualcomm.com>
In-Reply-To: <20260109-of-for-each-compatible-scoped-v3-0-c22fa2c0749a@oss.qualcomm.com>
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
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=hWij0Cx2nUsE3a6sV+TeED1rlFEQMwzrQCGei407aGw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpYTOTQudL3FhN/34Bx16jwi5rezq66og3KX2Uf
 nRZnoW0HkqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWEzkwAKCRDBN2bmhouD
 14y3D/4nRgbqVx8NtVKmBEK82/3qTuU14fmyZPVMKAzr3vodo9z/CnsYeX4Qs1/H+v0LL4bLIx0
 KAKUSyyY9ODpBcUTAjJN4/BIOegFdaaC7IjIAwyELLeBRd/3om/oSeas8xuNpggHee/nl+w/MSU
 xFz+iDuuEfBIiVSCW+YXK3KrfzQ4Xn4QuR4njXOrnNOSP8JMAQK+sDYahJYSjkFPhKFcDDbvm97
 R0VcxMpp3lbC+UDz3noSUjgLmlPlQOInreZDxRuumLEV0zvDzRuM/wJRD42VLh7gWw/NBBGu0z3
 kgjnZeMxSp+g+b+fPw/ec7Yv7MnK+qs9Wq+kGlESUXzmSB+Fsjo2dNVhyUCLcWgtG73zmT1MRgJ
 xefiuNEHNpvmWTKQK16hRQK2NL1qFwaz1JayxTJkQm3qAcOuzgGaczahlz7IXO53lQ6PVLDTVmQ
 EBFoOhQfNtnN6D3MfQ++8WB1kHf2Mwyx/RypZZ4jwz1yJ3qqmJEQQnfoGjprZ0G0ssDE7wGcabu
 hntZ1KDKHv9vqVhxYpRcY5WUvvajcC5cCbbVCzq/u9BdlVm3yum0xkaTKKIr8+EPGC/5gcJq6B9
 Hi+WNrkX7nZ9NkWFQSY3iXfuuSG1OcdSKgjIZjRnXw++nfWCpe/oMSiC3zukGykDljEPv8/QmQi
 gLVKlFqabwawcPA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: TJO3EbYl_p9AT0SrgbkMCeQIfhvF789o
X-Authority-Analysis: v=2.4 cv=JP42csKb c=1 sm=1 tr=0 ts=696133a7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8
 a=75aRx82TGYjwQxWndmAA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEyOCBTYWx0ZWRfX1inIo3MJWRha
 7dYxPHVyu2+2yvt06/12f2WB/FhYWhDaqbZyYPguAmUEXb4YHuDWXdH+/4/zZ1WmhhoEkeUyQ5y
 g6w6gOfOBYQJZ/NKt3+h9drulQEj8+jvR4dsu/ox7oPVyYzRMjfkd8CI8i3CmX7AINmSfje0U65
 alWwFHn5Z40VWbT2iuLuWWVjaJsgzgHEbocgF5HLjnooCOzT44ptt8RHVb5s+iLjDpHLFa/Q8OJ
 6DXm8nxtgUPOS//dCcjPn2Cgfe8ZJA52/39wBSy0kyq3vGALXA+B0NpMds+cokSqhEmIYFnHOZf
 go/NDTCCPKhxNskURW6rzc6h/Nq6k4zrC33wSuJW1YHw4/weZEPV6nRkumWmDHSzktYaFvJA7SN
 Wgt7zARZdY9FAqdAByve9c18x7zPmLE/TJ7nymcglCADwkfQ9KiHeklOH9JCPBEj2H+3ihdMFtS
 vWPSBKCvoh8WmmkkhBQ==
X-Proofpoint-GUID: TJO3EbYl_p9AT0SrgbkMCeQIfhvF789o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090128

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
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


