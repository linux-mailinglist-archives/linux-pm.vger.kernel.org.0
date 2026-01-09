Return-Path: <linux-pm+bounces-40552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A74ED0B755
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 18:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7EFB30DD89C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 16:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8926C364EB6;
	Fri,  9 Jan 2026 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MOl4bzuB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PIcu6bIi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA7364E81
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977898; cv=none; b=HGXVz9V8UhLE0iPtTWZ9sHeI8j7NRGeaptsb6EY03JcHtZRrPS1Puss8fdbTbBzYL1f3ThMg9htfVqR9r9LvAmLIhztNq+7Cr+gJ+nqt0OONYgVHRBJwiiVGmWWpUIiQYXR7rcW7H0MlT+trsmxkZe7dAr1YeAi8oeEvlRZiwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977898; c=relaxed/simple;
	bh=abI4vVKZ2V3r6fPoj3rMop+rIaKgyFQ7QmKPzSitsLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8IEQuQ4fcuBVaN9DNK01HNzu2Zaq5TZyHwaa3yCsnZz6xpPYxuAeFVr9bBzQLKFFJQz1l7R22uw/AONOkBFGMGx5ATomLAzxhLzTV2m+loGl5PW5xzEAr4+ahWX51ov+Wi1I7Ipno3HhauE82ejl+wGD0FqSsAisjBiIMWlo1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MOl4bzuB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PIcu6bIi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6099XhdV1048220
	for <linux-pm@vger.kernel.org>; Fri, 9 Jan 2026 16:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/ylUaLBidala1u98n/o6ZCU1ttqISuhXHyYTd1kU9MQ=; b=MOl4bzuBSkWhZR+W
	e45f2dSaxBgBGDuf1HyNyAouMHpD3OPIAKpLdTTQz60siPaIuA46bKvIADDGByRx
	SHQebU8ZwOw6m8f/ZHUK5WY9gT33MeYB8w4VLt82nfVny/c41UlLyTE9BiZ12vUT
	Ecclfxouckb/F0baX9Rh+DGum9cTsDnva7cgykx42OupLEBPUV6g4Eaxqtz0ONC1
	8Dbr5zR3m11HqeMUjULZw94ONdU6kBgkoko3IKxS03bSEbOLjWLiSDPhPZ4ZoXr4
	9Wvmgsr7yzW+VXoN9D884Am/S2z1saGWfAnB/aAtw3F7KCmNXiM5UxF/cxcZiyF2
	j2rm1g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjy5b978g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 16:58:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8bb0ae16a63so513487085a.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 08:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767977892; x=1768582692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ylUaLBidala1u98n/o6ZCU1ttqISuhXHyYTd1kU9MQ=;
        b=PIcu6bIiUMKDIEwTqO3KZQb2eXAirQWYggJQO5eUDDHtZXqRxPm/NTBCBun4elIXBy
         xmbmi4xqKU5QHNm8SYwMjWsb0Ewz68zaaPBbTibbuZJchVyMOVB4oTPKkjnMUAWdwNAZ
         TW8r+hFg7gtNaWscvMoAZ5cB2OIK6kb8jw6QJ1iVcRmwmnAnpZ1vtym/ksne1yEFA0GP
         QRZAaxddiZBGKcp91kFUqIYoyx2YmZ5ztf495Xv+YPVz5XU1hcoWInbaeRP0cSypF+kO
         TcqFQa4ikJADntiWB2pPiZlBvtZYw0bQJwd1yw5vq/KUMN9S8HeV8q6rQLGeLewlgQIw
         jtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767977892; x=1768582692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ylUaLBidala1u98n/o6ZCU1ttqISuhXHyYTd1kU9MQ=;
        b=GuaJMdMV5XH42AikAqAaShHFG8uy+gIHQMK47bdy03QFsql5Pqbo4k1qZPu8e28mgQ
         ojpEcIu/gNqYXgxYLdu9ofOGnj28/GW9nBqOg3D087C2EhY5LLeNEPg9k27AH9z4KKMc
         iwUl/ttgp+ivdZcRFXjjz3hG8LvoM/fmxROosXTbm6KFpGJeq/ob01HE9IbrRPlbSZj3
         oVRJp84kzHZU3y1QSKv4on5deUxTo5TIIkO7lsbivYO84KfD1Lg7l44xrNQJBvCL1OW7
         iJFhIfZUPq+SFrEx+w3IQpiivh7i/FuSdQNalguU1G4HDT1qM2nR7isDlp8aYkhbMtDP
         zHqg==
X-Forwarded-Encrypted: i=1; AJvYcCWtMhR/7X1vJwrFR0RDGKEHSNRncjVxvj9Tz9dpz4C8nKx/BQ3DuGyxRTOKwr5HF4myO7mjMnGfUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOal+4dXe8c/TTm7ineQoC6X8pdTXm8jy8WJZN4biOyZy+XF4s
	hCYc62hW2P/YSejfm+D4MBeAPH4seGQRxiG9p96MP74sM2X4epPrzgMe6ip6HzQ5dDWe3KcdBPF
	JtFAZ2jx0EKl4b09yBzdH/3fQrlEsjSrgNoMeBAT9VPIJToXbwdLaEh5nl4wrlg==
X-Gm-Gg: AY/fxX6CeF1EAIF2MA30GoEFxV8Tl74s1BnfXazeEpZpsNDApMG+dE7pK3qSeNf76J3
	I163Bn8gZ92S0QKqYOOO9pFqJEr2qdoF3A/+rkhAM6QojiFm1oLRrLQsv4emSAPIP7An0jK1k/a
	STE33dKrkCVrm8YMqQ12Ds+3QxXcYuq3mMb+FfiBphwGknjfO0ueJP1HYXjZci2Sexm5zVzhBlw
	ySJiEo72xegZJwVkZYPg2F/g6gBuwP5xUQBuQdvWTMTsfpaSUi8qpFlc1tXVwQURL+lx/HGRFek
	GAETK9Dj0cGBgBzdfD9tW3MnoHuNmXxj8uA+4zC71swuTVP1zPBC7Zri32s1odVon0820pPIkCS
	gDbVb5k9hDdZP32zsx3PAaaT4GMibmXsXBg==
X-Received: by 2002:a05:620a:4708:b0:8b2:ea3f:2fa5 with SMTP id af79cd13be357-8c3893e0447mr1278316885a.69.1767977892313;
        Fri, 09 Jan 2026 08:58:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPgCL7OXhofKD63yu6CqXzLuabksUOQ8VJV1cad4gN38L8pgj/ln+3O094KFk9sDY/IZdfDQ==
X-Received: by 2002:a05:620a:4708:b0:8b2:ea3f:2fa5 with SMTP id af79cd13be357-8c3893e0447mr1278309385a.69.1767977891782;
        Fri, 09 Jan 2026 08:58:11 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm23231784f8f.31.2026.01.09.08.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:58:11 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 17:57:46 +0100
Subject: [PATCH v3 02/12] ARM: at91: Simplify with scoped for each OF child
 loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-of-for-each-compatible-scoped-v3-2-c22fa2c0749a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=abI4vVKZ2V3r6fPoj3rMop+rIaKgyFQ7QmKPzSitsLY=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGlhM5KjFL+VmtviwKxvhVbScXQzaoAQG4FgEd7/qE93wpepQ
 YkCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJpYTOSAAoJEME3ZuaGi4PXbIYP/2FV
 PTcFQgtRjUNhHGjo0i1/wWxp6lecwR2vezt4z0Y7HtRiPAGB4smNbyWnxb6PhoufWzhQiKcUlox
 IyUXaDuNVhHVF0ciy+80/o7qJLkRbmaA9yML3inA7+ttUCdLtumN3GdgznjiWW58InRPVKKAMBr
 74TUOqUoWsPRCCmRFbsV8LarOKHQl43aPrSFKMO4BxOB98Ff7eNGUzxqStCv0HB8Fb4U67sEEB8
 vjH+FPXHfdrWWYClfg96cRQhIm8scSKz4EZiUJGXSy5efSia11pfzkKrAmuHa7W+nvW34l/CbLF
 RmvGPFB6A2wryDmNhLx4C4Y+oCn6X5jJkcFR5yhTHG00wt4LMlKK63a38ZQSGdxNMa08cR+ZA2i
 scypfUltDqxfv0UNGHlBcevq0vbhhwt8LrfS/O9jHzKud05bcUqwtwwRxGge7+RCPLffZkvAuE6
 4V69DEvZ7zJFMPiSc41CHlltPTLCOXE9otxpyh5fAteTLFUkszNovEJAt64t2rirWRemXfelR+V
 6OB8Iiw3vK0kpIuIuxF+cY2dvCUKoMLXA0hSUih2WqLERud1raVcvBW3p8kGiOELMVX21R13DoR
 3WPrQcn8FzQyttIpIj1d5xvibvNczCroHEvxiXjKK4WK1yJ0hBHnSaiBYb8oXHD8b73H+ZEz3b/
 Mbja+
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: -_32kOZALDmvaCeOlD7vHxzfCI8e6PVJ
X-Authority-Analysis: v=2.4 cv=JP42csKb c=1 sm=1 tr=0 ts=696133a5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=XYAwZIGsAAAA:8 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8
 a=HKzYjZOG_gvwJIbDKMwA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEyOCBTYWx0ZWRfX8fapzIqpocA7
 FMdy1g6MeyAp6klHhT6ugaFfkzAUnVFM7HDQ74s8I1FnhBlLNWp3XhYyhqWxcDmitiH7HB1swVA
 4gsOXZgpEdAhPkeqImjsxdH8SVbRIuPJx4Nm8dVEhzWwGJkrTc0b5hBv1BU7WDFnO9EuizqZwvy
 Ba7i8brnBcSa1tHIK+eCJKCA+5uOvO3qtX9j9/cjk+rhsmv9kPcmnQKm2zTZNQ0Kq3/W04zWeyd
 1ySJZGk9MaFwpQUR/DLjSSxM0RBtHoyqw937GYOlCDqvPmqPutb+dyrWRGJ+IDG3UA+g1kdHriY
 sptPMeNml+mvjYn8Q9V/BsxFLIUTR2OCgJyabUmGsH6TBF6EuBMqsSpFoyDOj4CRIYfzkeJM6XB
 UP59CHHjWurXiF83/iau0v/pd4fQ3EP/7cf9OMU74bWeMXjV5Xk1Kj4/6f9jCza5rdexwW0Qe0x
 ybQwweNRPMC0bqHdnmg==
X-Proofpoint-GUID: -_32kOZALDmvaCeOlD7vHxzfCI8e6PVJ
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

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---

Depends on the first patch.
---
 arch/arm/mach-at91/pm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 35058b99069c..68bb4a86cd94 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -982,15 +982,12 @@ static void __init at91_pm_sram_init(void)
 	struct gen_pool *sram_pool;
 	phys_addr_t sram_pbase;
 	unsigned long sram_base;
-	struct device_node *node;
 	struct platform_device *pdev = NULL;
 
-	for_each_compatible_node(node, NULL, "mmio-sram") {
+	for_each_compatible_node_scoped(node, NULL, "mmio-sram") {
 		pdev = of_find_device_by_node(node);
-		if (pdev) {
-			of_node_put(node);
+		if (pdev)
 			break;
-		}
 	}
 
 	if (!pdev) {

-- 
2.51.0


