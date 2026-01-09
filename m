Return-Path: <linux-pm+bounces-40558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E7FD0B75E
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 18:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E6A43025AB2
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F86365A19;
	Fri,  9 Jan 2026 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BDejZZEq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C52LZWse"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D5A364E8C
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977912; cv=none; b=txkW/4Eu58T0BEflgMMkqLetx2HAaH0LG3f5+j7+wpWY5Fw5g8J7WHr+8PAot+B53Uwcm6loAhSP2koJt8xbWTJF0sKDjawhNZfgj7BaRSA3bkgA1hZxGTAQtirk86wThua7ALHGJJT4RdRPNZjQaUrL39zzpGlNVb0LrmpMHH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977912; c=relaxed/simple;
	bh=1iu6MNvbVEoRTI7JygnS7ijPqFY49qevKSe1ouy8Rv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kyYl/7XsDs0Ao2/Jg8T0CqE7iVytuRxbv7dhkilwk8xUuvTl6wLU2oOiM6bg4ZEHZu2+eH70XQhElGoHrUbU29LsuviWWBJdpNU/K4umD7p+7Fv7TyiQGYTwmUMyn5wqK22z7CizYD9kdBaInRH5KnYNe0d87b2dvdTHYQUuqCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BDejZZEq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C52LZWse; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609EcabA3142492
	for <linux-pm@vger.kernel.org>; Fri, 9 Jan 2026 16:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	52esIL2ucnGVPUBCl6apqalrw+3CaurVcR5VdpYCYsQ=; b=BDejZZEqdgQLTInS
	KroDPvkMPu72OlNPQ52qCdnZBYB+ZhZlbDvgTHriSrXYqOTO259Jq8xa455VGk45
	SVuKQEFw6PEsnXPU6P9SxiaUgkx5TY1q8cvOgsWXY+yL0Ub2SzKL3qRHn+4sSjNp
	0dvsNguDmHwtvosvjDA3EWdR/yzOItD4EryNa9F/+ZpRWSZTAy4mJblRWobe4j4K
	7Vdh5obXuX+6PdfP7A3mOCGM1/shKRD0z1ZB9xPt/PxP1l/FHAinh8F85+vMY42q
	8XfuAVf6eZy2gp1+GYtrrSAOxPOfDsIEzJy8H88V0+pOM3SXgub50jw5lOsli44O
	5u5hsw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjj8j3d94-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 16:58:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b6a9c80038so481527785a.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 08:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767977908; x=1768582708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52esIL2ucnGVPUBCl6apqalrw+3CaurVcR5VdpYCYsQ=;
        b=C52LZWsePUKEzrEv4TaLMDGqbDaNIox+ClGsJLDscluC++k6kWgT4WARgK/pOmWhYg
         sDpnOYRs7MoGoDctOaasGZmUgEvGjnIIQXeEaeS8CHVwk05dBZCtFdQ5/tp9/HAh0Nm1
         3ZA47iCksucRRSzcej706Jqq52BpxM9zlSkI9lFYpYzpkF3npDhRfg2fTHnFgrOb1dxJ
         +VDyXKHoF9ttfZGJutjdINLSodFUzTfGc3uHs+G/wTeooGv+SL9bjisLhUfJJQGHclS2
         ByWpqBl1fVvXgGJ+EyBNEzCC+xnR5HJ2RXlSjUnS4Ihhy33GkHcWs2p0nDcBpUnI4+ve
         UWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767977908; x=1768582708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=52esIL2ucnGVPUBCl6apqalrw+3CaurVcR5VdpYCYsQ=;
        b=pG0aK/oba3y9V4a04DPyrZA004dyaGgQYPMzYR0rKY15cCaP9pwfRZu7rjlCp5jrQS
         EHczCHjb2KoPQwGDvdsMtTdUQ9YajE8eo9nV5UhrMCATSgBj/hHqjFp41CQ9QxpfNcS5
         9utMIiZsth63aKdbE/lDcSQA48Tnr/ib0UL0CO+GBi92V1yi+3HK7SXRLIIWMNCH4Jr7
         gUIwh0BNVXdrE9kuBqvA8QtUot3ae3aqr8j+ZBQUCizycNJYhG802YU9wWog3XC3z05q
         aGkYYGzHeAIA90BRimq6v0kHqJ19X6BWjY8bEyJJSVc4qt/1C99EW6qRHHi9d5s6rFQ3
         iWqw==
X-Forwarded-Encrypted: i=1; AJvYcCVYlPX9zIQfCcfVTT8XRP+28Mei0MUjBP1vkOWKIwVbTC+l5N26xTcISmtiMySd1TPGYTqypmOmSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwYUF65ps/WzLnSPCdyKPm6Oub06vBVAWp5p/7DPQcSNVKsTE
	XafSZYgQN4Dj3HmgpG0dNwGOI8oEWOVxKhkMZv4Fr6Y7NWSNspc1HPz8ZqlOkMtQOK3cKO3QN3Y
	vZPgSewloEAqbk00wf0pvJ45UhLuYIfwDGEAk/kRcQcbm+b+xLS+jwto04PkLJw==
X-Gm-Gg: AY/fxX7Ssl/97CQIZIe1KSGbbJzZNhz03BjheudsTmEIsTCnTXgwDNDCTJzQ48swZhE
	ZlIb0oSIclypoBB1tp9lDCVdTjWkGwenI78xRoma0zzMVBF26xkV7YreSH8WwgaF3mqetLozhY2
	fTI630fZZIPW+5+foXuCxIeZdfSGrvKT6h91sPdWd7rV83AU8XPEVazwlR63H1hk831TXI/logw
	7cVMnwgnV07w1NdUCEUi3shia/u9QGEHn1JfelyzyfWap4lORpcRfwbJlNLf3+JjW7QUsHdAoOd
	jtpZijwfbII2y9RoJG2yVfRim71xAv0bAyte1onfx2nDr/fpzeK9cnzvj/G5ztEFxD4RzmHhoAD
	AfvnrBZ+cDA6/+d+0gH10/hlY+SzX2XH3iw==
X-Received: by 2002:a05:620a:7087:b0:8c0:cdbd:e09c with SMTP id af79cd13be357-8c3893cd9dbmr1340624885a.45.1767977908519;
        Fri, 09 Jan 2026 08:58:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMbrCPEDW/gDRkMomtSmQ/ccO5PqCMMr3MSo9Tk3+E6JheH1AjT7zmuRjVtv2Aa/bfG1NR1w==
X-Received: by 2002:a05:620a:7087:b0:8c0:cdbd:e09c with SMTP id af79cd13be357-8c3893cd9dbmr1340618485a.45.1767977907891;
        Fri, 09 Jan 2026 08:58:27 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm23231784f8f.31.2026.01.09.08.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:58:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 17:57:52 +0100
Subject: [PATCH v3 08/12] clk: imx: imx27: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-of-for-each-compatible-scoped-v3-8-c22fa2c0749a@oss.qualcomm.com>
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
        Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1iu6MNvbVEoRTI7JygnS7ijPqFY49qevKSe1ouy8Rv8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpYTOXziE2GDkuuIF6EGlGGzxkIyEdrM4juybcV
 MZ1Pl6iph+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWEzlwAKCRDBN2bmhouD
 16RLD/9Bs2DV32C3cRtjI1vXFRSea24Y2aVmtYMHDgYOu79Jt2cq46IeeilIr2S2ootiThXa3lL
 tzwrtBZsYC62ADGCAUklN5b0Yy1CFN40LrXNOX8N2EFzhAcdzxMdXvvqpRQ9LJDoS9cSY6gQdKZ
 JsopQCuyds8GHSp/Borf2T51wFML9VGGxP/4XCfkXDmAHqgZ9yHpX8on7FMYG1RKA3XJlpVxuX0
 Al90LDs9V9oEI231z/vU1HMOm58AgKp7Nj+a3+8YL0ZPhPczivfbPkmDz6RYGLL9hgYUnOJx79a
 MZb/ES4HJ8cKfOU2UoP+FuQLb67UA2ZMn9UDADo4CqaYQPzwhYDva/UAcPxsGKvl9UuzKv8ltsJ
 b+ySzmiIfC4+YvxPWpDE6+oQcO5DtRLNVIJoDV+Qo6X5oAbF0fC35ab0VXZSLsaANUMn6y/iHL+
 RBBGI6EVNL20l7KhT8CsWlSZleDoLstMff2HUmwkDP45DryYEpIfdsRwMyTKwYd8IOAQkkve/we
 aeWgZhVggXZ69FDQ1oCXMsBtGPXJIPTgDAV77HfT3HzXYIoPnUMUOnGPlxWdVGRguYZw35GO7zi
 Yv6tgTTqllF9V8bBSNB7vs0tXyXMe7aJ7JqCcF3KYzqKOSRWI/nGgHnFND0Foh7MuknQcNOMhuR
 pZy37qRG78PrWYg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEyOCBTYWx0ZWRfXw3AdjrEP9Kfq
 42HWduYa3gOzL1h7BFwhtoKrewLh6E9rdmxzOA9Q3ELan8LdlDM4PeIrI+9zpbK+dL2iotI3Cgg
 xkJYq95aRDEfteQctUJ0HaR1NLmf92XMBomiBCkXTYyFE5O6gPz4wuETaxrQa2oLb6TN4iKYSjR
 crGCiDt4clIHKR1BT1PYCzIySE/7s4CoXUTDxPfRxlwU4QXM+Aj5J+E4wgT4XxIXKIdS8mXKAeu
 2UJeib3kAVAjpmrm0O3g6v9yGSAmL9moL8XO7SMPBbFiPRn3xUYiQEFy155Yq/1gxMilugattGt
 EHJmpckzHskFSFhAbyJ9wGZAYzZDtA2FgHac5IIcJHaGEjtFxS1LwWwwNnFkHfIass7WFInr2yg
 h4b2Gq5eQL1cxZhJupfdebcKM1bbNmZDPHJZdqCMZZXFwWkfQn/dsq4jneOILwp/a8YH0XT8KDH
 uBlPVDZ+CTjZzjgHmkw==
X-Authority-Analysis: v=2.4 cv=JIs2csKb c=1 sm=1 tr=0 ts=696133b5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8AirrxEcAAAA:8 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=RsIb78jGsj8zXbp4E7EA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: 35rA_gm0HBKTxYJTVN5HKkyAtxVf_Us9
X-Proofpoint-ORIG-GUID: 35rA_gm0HBKTxYJTVN5HKkyAtxVf_Us9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090128

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Abel Vesa <abelvesa@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---

Depends on first patch.
---
 drivers/clk/imx/clk-imx27.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
index 99618ded0939..f2f0d3fe5c52 100644
--- a/drivers/clk/imx/clk-imx27.c
+++ b/drivers/clk/imx/clk-imx27.c
@@ -171,17 +171,14 @@ static void __init _mx27_clocks_init(unsigned long fref)
 
 static void __init mx27_clocks_init_dt(struct device_node *np)
 {
-	struct device_node *refnp;
 	u32 fref = 26000000; /* default */
 
-	for_each_compatible_node(refnp, NULL, "fixed-clock") {
+	for_each_compatible_node_scoped(refnp, NULL, "fixed-clock") {
 		if (!of_device_is_compatible(refnp, "fsl,imx-osc26m"))
 			continue;
 
-		if (!of_property_read_u32(refnp, "clock-frequency", &fref)) {
-			of_node_put(refnp);
+		if (!of_property_read_u32(refnp, "clock-frequency", &fref))
 			break;
-		}
 	}
 
 	ccm = of_iomap(np, 0);

-- 
2.51.0


