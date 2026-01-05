Return-Path: <linux-pm+bounces-40197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA92BCF3E78
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 14:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EE623016919
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0211F3321A2;
	Mon,  5 Jan 2026 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cqq+Tvia";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TMllukJx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F732AACA
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620053; cv=none; b=hDjyvJUkmfCp4NSfGT81OTH7vjnvOSQKn3YbICI3gbG2+BuWSGYK22nKJJcO+ndR6sufrhfft1h8imL+O0GaBICXQ7aXp47S05NFbb/aCt2zurgrA+XpKaX1ad6m3IyQF8B3ToImMWdbS9E77tyzP4dj5pkBDy6KChOSQLaqW8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620053; c=relaxed/simple;
	bh=LVLzy0PUtWV8BS2tmtolxGrxYJ3Rutx30xWjiFUNeE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lI3yIqFIEpCSjONKBNIoByRXWbnO5gegduKJ4LythspVHYfdxN6P4hOIbskRzPe0B1Yg3SAPXqpb8N3jIvukRJ7o8obnUnkGbUuou/JjsB2AnRuf+8YxOSFCY02COOlTV04BwcHkQ49nILXHW/gEE79zd1kgcT/msGAzxnDSS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cqq+Tvia; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TMllukJx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6058wKIs594188
	for <linux-pm@vger.kernel.org>; Mon, 5 Jan 2026 13:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oArkW0LARboCK7gb4mMn0LYpSg410D5nG+SDjMvZOYk=; b=Cqq+Tviamb8ohm1N
	qJMGiuQ6TRAQg/hGCAvjozssKyzNHDhBVl8EI4QxNSQ8oF+1U32/wJnNXW+n8gjD
	8wAjGWlGqIkS1vJqrOW16+rYlI/s5+9CesvEbKs7Pa+37mN0BRBuHJJVx9f3Uo4O
	RudXhY4JOe77hHwt3+KHZ4/qUagXde4wsVcUXpJevKRqoW2jl7Uum8aJy6uKdnR5
	0kl9mGnPu19TMVfo/ASTEeVNg2VPSm+LR1QDOHdHCaxgQT8bGI3XubV0xJv+Zgt4
	WNRsCjjUkx4qxjUlYQZ3VslIFReKQHYfsPCAaKxQ8L3d1nLGf9Kg7woYRHD2fGc9
	LE9frg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bga8pgpfe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 13:34:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1dea13d34so357695541cf.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 05:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767620045; x=1768224845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oArkW0LARboCK7gb4mMn0LYpSg410D5nG+SDjMvZOYk=;
        b=TMllukJx1gXtib7rSP8160yVPowJ4XUjXWfbYXlVlNL2CpVL2cR9iyIW8/gcA8ZrjB
         xbdEH6zfnFE7ulCMHn6i8HzMJIzmXmHebsTqxereqkAoBUlVxISEHFm63RBcDQjO+u7T
         bLnRLyVWnxg8Vhmwc5p/aMbr2bJF+T0KPoZrklcj/4NlYGIpGXl9k64NZ1HYFAUCwFGH
         iE+wBBc67QAA57iOc2GJLFtpk/1L/uudB3y0KU45bUvcoPHjS+6+bjbGcV3nFeecAcQS
         87g41Cx62KnezK26Xpnia2EkZR8lXUvMP+Sak0O5gxA6yw1ZPtqR4hFPO8anpl2r1d/9
         3U2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767620045; x=1768224845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oArkW0LARboCK7gb4mMn0LYpSg410D5nG+SDjMvZOYk=;
        b=WE0nS6u0FMxpWho2mSDRuSJO7+JlSCXqyzQTf2FWBdrJ9pg9XdwHqBzRZi/yiJiVTy
         dNd8fpcFw5X67fqd4GyUSCWban7pxn1TU2GO/xrnNwuMdPo0M6CUQt6ZzCUZc+wi2zF2
         Pc3Tqif9GQk+EdFns1VOcztPUJBz5M7JiU2IPKippUDWsmuFK1Y6/4ptcLgwAqKT6lhX
         8L9HYPmpf/kteF5cUEEdXqjtFeffn2ZwmXPcwGBBhvibNsESFGyWSx7Qn2bmd5vWigys
         B00o9uT8lC8xCjK/cFKbevePoo75hLvFfELBBYfGo7ddjNv6Hre8tIEo7j1p2oUcPXIq
         rBuA==
X-Forwarded-Encrypted: i=1; AJvYcCXGA19qeSTu15AFYHbctCddN+FbvwxmoYVWSq9CagkJRSwAgcsjo4p8MKKneUmPgMauclAwUYeCcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWc/nbpij4PdEEmCreId73oZ81WyF3C2XWygtFJ1yA2khH5msP
	yRhNSw1aiEk6qnsrK789oLHY39bdkp4c7b2IGvWr/fa/wDE+MxWmn+Pb1U3JKk8oSxJiwlc9xER
	EDLik7KG5JU5TsyPVHnR9DPK4bVAwfivtbERGVS4vhlkUcHN7i2OLgK9OtO4osg==
X-Gm-Gg: AY/fxX51D/y2eNHxBu23s+CRbM77jnu7iywAgQzX5yjpyp6NgV5UPKXiAhTY2Axfjzq
	wwhO2S23z2oVAfHusqXEiSmGk7A3fEMlLCALsys0JyldQzqbxhWIowrAPIjmUhYh8ns+pJYKj7B
	4dFeqgqcEkzaUaDrKlruxDv4ydS1t9WtOmKezLVfdufWdRV9i6Ewc5kxnVNT5TdLrbQ0Dy6NWwO
	t6sd/G887N7iWvRhh/vat381hQo9tX20Ngfpj9gHORVGusWxdOJQblgZn77eLRgFpToAXNjUHUM
	usPF7UdMiLxBy6iH85ckNcdAFZVKZBjc3yqO4OodbN21YIgVM5WulKlXFvr+lhZOsm/yetuMpAs
	QPHqNaI6S7L1pkYVV86GvKWqGBLTCCWOPjA==
X-Received: by 2002:a05:622a:4ccc:b0:4e2:e58a:57e1 with SMTP id d75a77b69052e-4f4abd1fd20mr854416011cf.37.1767620045476;
        Mon, 05 Jan 2026 05:34:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaegexSj096K3fUiheKT2eEZCKoRyRaf9tDTO6HJyvQ3dPuQF/hQFiRxGLj+JZN3lJsktzbQ==
X-Received: by 2002:a05:622a:4ccc:b0:4e2:e58a:57e1 with SMTP id d75a77b69052e-4f4abd1fd20mr854415341cf.37.1767620044848;
        Mon, 05 Jan 2026 05:34:04 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d143f75sm147211015e9.5.2026.01.05.05.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 05:34:04 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 05 Jan 2026 14:33:42 +0100
Subject: [PATCH 04/11] powerpc/fsp2: Simplify with scoped for each OF child
 loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-of-for-each-compatible-scoped-v1-4-24e99c177164@oss.qualcomm.com>
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
In-Reply-To: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=LVLzy0PUtWV8BS2tmtolxGrxYJ3Rutx30xWjiFUNeE4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpW725Sthfa38INoq+BFrKBCIQ9LENj28mNcejT
 zH4La1FBV2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVu9uQAKCRDBN2bmhouD
 1+Y3EACFb/c5RPWrsm9EJCGgElk5vs16RKVssUJeI8OeCDe7qdbUwCuVZxqQKA9r/qGQOvjvryT
 hX1qwbs//UAEeuNPZV2XNaE3dmO+F3Hly+GEsYAz7c0N+h2s56k/uDY5eXRpmlEmFTIySUAHDbR
 GEq8fQjte6VxHDXwURB9tn1H/t/djxNMYWHo6p1BGJkA70pTZyp6+Cdpzj+6JguPl9xOcg0Rm1k
 PuJe7XLwfWmdFYdjjoWNAmL1U9f2lO744KzgnVSiuIFbhiQEm9MR9x54yUAcuGgvHmpwh/nXVSO
 svb+ji0Nrkp12dBF2Tx37D3xIgYqw4CdAkNc4TsN8FA7xzGfdjnp0p1917/yozTqg3uw9poYf0s
 L6wG2dEzDp9TOu5hT3wPQSyZJUg6/H8J52lQKd4pZXvRK7LrOw3WH99h5BAp40dXR4NuaQPe+fd
 sFEuD9e7N4KLOUYa4VACZbhVGPSIPmdEsrvjkoEiotFcGCRNWcfNA5I4Q2JXlBwPhzQtmBDhBPa
 tp0G+hWwzQahW0uFa+KcCd0sPoUz48CQP62nynSjLl7rsA2XvCYLPo8HEzevq0q2pmJnNYznbAq
 vhbVRAcFTXI7l5F/Ph7YDmX7evKLAzxjmpU3wjr/16y3Id3dr/lcqHb4vmmZBPry3EU8sU4akYy
 NGGA0x15ltZqDCA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDExOCBTYWx0ZWRfX2dX1r13Zfrk7
 qOrf8ejo0+ixpUhcdx11pWi4ZR2RqYbJI2v5Phn87UVQti8Dnz29B3M+WddwtiwhubEQkjQgb90
 tcFkA8/op1MUXXLSO16Auy4xVHkSpG2doqLDRU2aYd9vC1B+y8xCmWxN7xRXJjSX6PLTd1ZbP+q
 9292lbI3JYzuVUkBtl8hbBSQZs9e9XDRTLvWYu361IkhiyqaEF5RIYrNtDsAos54ptCA7tiReRV
 1hd/I97v7YJxLyk8R71O/CYK8rZtWRMEDl/NQG0ukHD5v3YjtQqcLiqcA94q9L9s8A2nCLmFa7d
 N+TQ2dtsUnOEypLkOdzqVtb3s5eRHIwyIaZqC5dVbrjYeDvdk/RIln7fhpGb930xiDRvWAyoHMU
 EzWK79ozna4wXnThPE0lyV+/PxD1HBhW/ns4PNCcrkY4VRTNZJBhbxG0UI6DaBiQFxSp7fzZ5Lz
 VFpmQrARiuYXHx/CvLA==
X-Authority-Analysis: v=2.4 cv=JfWxbEKV c=1 sm=1 tr=0 ts=695bbdce cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bRA1xQHzFO3ZoMUYUbgA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: IiUyIwAkUHDC1ebRcLeIdgtss7SuKUMA
X-Proofpoint-GUID: IiUyIwAkUHDC1ebRcLeIdgtss7SuKUMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050118

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Depends on the first patch.
---
 arch/powerpc/platforms/44x/fsp2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/44x/fsp2.c b/arch/powerpc/platforms/44x/fsp2.c
index f6b8d02e08b0..b06d9220844c 100644
--- a/arch/powerpc/platforms/44x/fsp2.c
+++ b/arch/powerpc/platforms/44x/fsp2.c
@@ -199,16 +199,14 @@ static irqreturn_t rst_wrn_handler(int irq, void *data) {
 
 static void __init node_irq_request(const char *compat, irq_handler_t errirq_handler)
 {
-	struct device_node *np;
 	unsigned int irq;
 	int32_t rc;
 
-	for_each_compatible_node(np, NULL, compat) {
+	for_each_compatible_node_scoped(np, NULL, compat) {
 		irq = irq_of_parse_and_map(np, 0);
 		if (!irq) {
 			pr_err("device tree node %pOFn is missing a interrupt",
 			      np);
-			of_node_put(np);
 			return;
 		}
 
@@ -216,7 +214,6 @@ static void __init node_irq_request(const char *compat, irq_handler_t errirq_han
 		if (rc) {
 			pr_err("fsp_of_probe: request_irq failed: np=%pOF rc=%d",
 			      np, rc);
-			of_node_put(np);
 			return;
 		}
 	}

-- 
2.51.0


