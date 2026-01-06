Return-Path: <linux-pm+bounces-40280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD2ECF77FA
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 10:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E122F317093D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 09:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB492315764;
	Tue,  6 Jan 2026 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UNssgyvH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WBvDsNem"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED88315772
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690948; cv=none; b=Nf/tqHHyXG5DM52oYvyAy/m40PA1I1ivVf4lRPdvqRO82510tPkWoXKcqILW1AVrNsxeW72KWyKto0iVmS2hNtguS02uNqB1yR4LhJs8MpdZzO0Y6QCzkS632vwcukl1o6EeLjWqly4vYmNscJOUJ3mj9rs5vF7+jys+6r+bybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690948; c=relaxed/simple;
	bh=KN3KRjm/oDtXh/DCN2KUrl2ZPSM8F0ypALb9+d3CNrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f15mTfWMKN5gK9yth+a6DJXnruyQLwGQLpvzAim2LP4Q/wnlXAtcxg+YI0KISLA/9yrWKaORPsI3Yg8eWQ6Wvb3E4JeezxCTnfZj4aBLFDPbVi1MmS1AUJcyNFvPQjgD1T55SZhoomvXjSExs5RpGCk8Hk8hX6JKF6plO19KHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UNssgyvH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WBvDsNem; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6063QTiu2430122
	for <linux-pm@vger.kernel.org>; Tue, 6 Jan 2026 09:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RUqp4Iv9+wUxLp5PK1JfIBFWlyQtuLekkwcSh0GtSIY=; b=UNssgyvHFOsSoRhz
	hOzHNq2+BwVowQQTIUH3/4CGt1LOpBwuf2jIfcMKVipTU4rvfDxDeMCKH3Rt9ABW
	ijX6rFSRM3IESx2ytEd/9vo8eeL+cU6IhhNRYE12Y2cNq012BRnOBPEj2eXZqhkS
	5qFWVlUWtGUjOIxBCAbbZL1PLIFvwpre1KlwZI552q72amNuXpIL957aBowCCxEb
	1IHJKVQKN1XjLIMSZn+gtQaTyej1nMcO8w9Tzn4HDaO7yvvxdLSKqPmr4U0chZyz
	vW8i/4Xtc10bvN83JL15y3h0P4XERWPcxhEFGs+B0V00P/QeK/JbNJ4yz0OM8gVo
	EI8h5w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgr7399v3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 09:15:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4fb2f0cb59bso18187391cf.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 01:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767690943; x=1768295743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUqp4Iv9+wUxLp5PK1JfIBFWlyQtuLekkwcSh0GtSIY=;
        b=WBvDsNem1qhp24XXQqyFnbCEAlZBB4XzRfs894HMBIDl5daxNGbaE0hrZYJVweiyp1
         OzmmyWQYI+wjCUSAhN6qMM14t+exEu58kO19L+uh4+VL4vIKkHKWTgTWlmnWn67fiR7/
         n2ij9+CGLjWApfvN+R3MG8MU3v/qaF+pFM0nbOtrkir2jAz8av7Nm/ZtMbkl/L50xVdl
         ADSF2ccdMTS7SWn5peI+FMJkuGyeYs18jkpDXCJv1fj7Ak7RdgsEMhaA5mLqqbRk38o/
         5XnPBmuApvUv6MezyGuCyasiRC3ph2EFY09QvIkc7dcuYnVwva6Z2ZXIu6dIXq7f9L/o
         za/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767690943; x=1768295743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUqp4Iv9+wUxLp5PK1JfIBFWlyQtuLekkwcSh0GtSIY=;
        b=gy9slK14ZTtHJJQf5jxWEQM6q/d8AvRbNyLKPRE1WHYgXmlVTnstQ2+G39N0EthsGT
         h1DRHenCEORhvd0Q04t0GtQBq+mW+fWF4q8/uSXMVUIMt9vCaWrPIIsnqhWjaHD+yOTb
         ksFSgp13nLXLP1h25pC0e3IXFSNrFf2W6rCq/sUdiWyzOvLqQ3SUm8/cCGga1USDUTLz
         Rq7wynxpceyRWVscWfPu35dkJXC+TyUoQlYUZ5dC5lg1Up4rTmq3dZyZggeXt9vwdrEa
         gxt4iSlEvXYC8KFICISap/0LF9ZdPWOmqSWXWf+Ix0ArWDmnQeHZ7TDQnOphdEfwho2r
         LTGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1sjg4RNx++fLIhJ45Ogta+BqlKWeSJBccJ0laULAEfpBHgP82svExybmDarkNZ0uPCHrMoerxuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDX/G1LJOBSP21S4ODRvmM4VrjqNOsgaVwSmKYNOKHKvPonrKd
	4e74lkEQER9c9RYmDcOEz9Hx+ry5UeKGB+hhrp/8IQGDRu4ZmhCpuxoQaKzSRPIqiPvNcdK9SkS
	e7dGHKs/NB9MRdIEeCf6dNeXjWHKW1XGKmwcHBmt64scfLlLql7dSX3hATLXa4g==
X-Gm-Gg: AY/fxX47cWwcwQMACNkFfmTEdRUSQKJhRoEnRuGXigMa8uxU9lxqG0s8G4SFWlu0q0r
	wUflGN6vjFoZG5B13PadGwDg3CVIaMFaQI4N7V/qwULHReKgp+5OvJCU0Mh92XM9c+TkCWyNQ0w
	MvPc0VwLYw86VmIyj9pRzzN00JxidO7Rgc056E9I0x3Pexe/U4Stf90Le2yX21Ke/dvJNWndEKE
	msvdK90A90+NJr/ebSm/7UrL7vuCHNtz6rq1p0hWTQf769I8vrXffCFJdNlW2T19CUno90v8VMv
	OFtjB7LQC8CIVgPC8Ah6yyc0oQOomx9ltN0Do+QsC60GN6P1YeLD/aJKnpJBG2gdMIJk/+i8gnC
	6kbZI1IDLDROOJju9jdnwB+CLIispT8R/qQ==
X-Received: by 2002:a05:622a:2b45:b0:4f1:e46b:9dc0 with SMTP id d75a77b69052e-4ffa781fd69mr24540431cf.76.1767690943153;
        Tue, 06 Jan 2026 01:15:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDeuNCrhajN4w2pa9axdtue2qax6nwJTvnc5Cls39nE/xZiXkUxIgLPcpsnvdWju8KVH6lSw==
X-Received: by 2002:a05:622a:2b45:b0:4f1:e46b:9dc0 with SMTP id d75a77b69052e-4ffa781fd69mr24539871cf.76.1767690942649;
        Tue, 06 Jan 2026 01:15:42 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff319sm3271370f8f.43.2026.01.06.01.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:15:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 10:15:17 +0100
Subject: [PATCH v2 07/11] clk: imx: imx27: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-of-for-each-compatible-scoped-v2-7-05eb948d91f2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=KN3KRjm/oDtXh/DCN2KUrl2ZPSM8F0ypALb9+d3CNrY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpXNKmZXsuC2g+Xb1baVzgLGhhR7Rrcrdg1gFaJ
 ezTFD7yVUmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVzSpgAKCRDBN2bmhouD
 1z7jD/9kNeKktB5dvv1Vao6f1rBEkvNEL+y0aGnFILkw+fFKcXIFMwxxYzzlQfUksNYfJyOdK8O
 BzBik3cMNTqxSDXOVNd8Ijzd3DEfi8jW+J5PLcEpz7riNnuqwBaJkXRAGKiaxYuEFhSTmp8ICqw
 IA3pRZc2+nUuNYEntoIyQa8N4540M6T9RloRrgx8KA/AcupxDC//I6Cnupv+Pd20xe5DweyVTkL
 rH2B84HPtNXAPqy213xQXzfSNeddPtb1NG64d1aT1mDRyu0GX5lvaZBfoaJd++RukRLmTaNjIXz
 n+mK/Udfsktb5JzVUCENVmlt2iBhLG3eXRTcxRyBYn6ela1urPy/DLLyJfRVAcKLGDB5hj7kR5i
 LM8pl9ZOC8Vy19Pvs0obJ2CD9NKLcL64c4V+ol/46prYOEIctwq0WflPChe5Z/BidWm/rfncPLc
 VyFnW86N5SwGO4QUL3MForM/G7H7qgy3Pwha0smSE3OGOxIbISUBhCw6k5YvVfWG3mbQS9ivvJb
 +dumTJQYrMdyXwOlfy3D1qzf8aomhc6kqmB395QwwcwOFVjxeR4gm9QgipV9wsvcA9aRwOq6cHo
 qEWskUhBBGlAzjTlSUE+Op/O0zRyKACK4ToDJ4MefQdIut8sKN/ADiSTOc8+wgCcD0DJBDVmCsD
 /+ZKdT0xUuqOBng==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=QrxTHFyd c=1 sm=1 tr=0 ts=695cd2c0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8
 a=ZKLgdMRimQxpfTQYzWgA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: vBmtrK5ycURRoF00CUY42ALtmEOzw5gS
X-Proofpoint-GUID: vBmtrK5ycURRoF00CUY42ALtmEOzw5gS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA3NyBTYWx0ZWRfX126k9ucFnmy5
 Qnnlzb1LDNgmsEvIS4j3C9Z1C1NVEIa6/OJiBD8NjRvbfcPoQFje0ydm52cLdYa3gOB4FPaWgCq
 fVpGl7fRKXRfZb5AN8p6sFuvtdCBt3H4UW72E5By7KLpR0w61oImeixW9vwdBXoM02XKg8b1R7a
 WT9inaBXZOzWlOTMW8qKjwve12GViq51etMR4Nb4PQXkQfbVBy3AW6xYj7xfsqBp2/KiMHMzSKF
 D4YwrybEHnDWkDPKJSv2Gf3rdd0FqZzwyMovvMN4v4MlNcXmlRm/MO1VEJmw/ENEWk533jD0l6L
 ezKlrf4BFNFiHXyurL4edxEYGwsHFuwNljaZ9jIz/ivS/yNvrA/MxXNeG/vdzMF75jZuFq4UXo6
 A2i5QHfiSTKr2dZkRSucraKpPCHtYR+tCny/wPsk7ltJU0QgP0TiDDJDudJv+p6a3VmDw1m5bZ/
 sKhS14xfC8yC+EzR5OA==
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

Reviewed-by: Peng Fan <peng.fan@nxp.com>
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


