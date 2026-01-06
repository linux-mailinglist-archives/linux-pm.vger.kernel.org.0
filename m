Return-Path: <linux-pm+bounces-40282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41337CF780C
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 10:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E0F9307CA4B
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 09:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8893191D4;
	Tue,  6 Jan 2026 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K2y2OUhF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sfx12r/y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF579317704
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690952; cv=none; b=D4i0BEW2Nx0Ev61l6p/MwQIShn0PXdWAtXREzOv6Dhpfb5w7T7e9tGorpirHnYcuVS0PaCycbWNcLavRJIhFFixVWoENHg4gI6gyJET7XZKA7TWE74ou0hVZLbYrY8XSqIzVVm+fQ2PV9zB1duJzx1CTQy9s4VKSoGTo+MIR6HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690952; c=relaxed/simple;
	bh=GS8OvkusvmgcdB0Bw7k1Y4Yk9s8voPKG1OqeEcLUEtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9LLnAzWT0a5DbYE19sGziNWhqeTtR1MEzNQ1F6Vd2ztw8vsKw/ucnJulkwmP8VmrJ7996mJI8YFJc49q5qQCt8cgRuc7tFbkYg6G7xCSGd0dcu/ROYlgTu8QrSTT5m2oPyzCbWcwCDi2JA2B5vjJVaqP/MXqcGHP22D+VYjYcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K2y2OUhF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sfx12r/y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6063QUMS3214304
	for <linux-pm@vger.kernel.org>; Tue, 6 Jan 2026 09:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Du52gVNSd6dUN+ox34XkpgmRisqcm6nMlHGah1IV5Rs=; b=K2y2OUhFOKBTeAtq
	0u3zoFdkyq4eSfwn01b61VxjwIpsk8g7AtXa3/k74ZPY6EZPoSZsi4cKkD2i3QOT
	vDh1SZqJ4Zx3seDvUjM91DML6YuJjIugh3lC0Bl01rL32fUPu1QWlXVOULAGSzJ5
	wI735DOof3sDJ9L9n05wfTrhAdsr1E42NWlVeRE0h0CHNegkr722qKG/ej9/TydZ
	5oevEigT2LrTmQSq35sMNSUpi1IqH+li99Lu29RrjfsDs5bTMHwG0RmBQJokrY+q
	7FgIQI7FVfEULJD9NMGXqhL/2gBnMN1FnxITSuIm6OLnRrQQFi0zV/Nb+0qKnpEI
	Ym/P/w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgpnd9hf2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 09:15:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b22d590227so102492085a.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 01:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767690948; x=1768295748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Du52gVNSd6dUN+ox34XkpgmRisqcm6nMlHGah1IV5Rs=;
        b=Sfx12r/yqDwbOFU3kZIxkQaQ0xPT1d2uYZQibqEQJiK7x0nXpz7o78d4eSfoayvPAB
         M/yep8JWx8WpeRucOmh6g7JjvJ5ETOhlr7fwuCZ0QQjlgzZlXIgnQcsHo1X3dT8qUGKt
         ymTNmsAOOPGE/vim45d4um2cD8jZtAxPe7N8bPPI4KiYkDZKRMb0iP8copx8oPiJm5ix
         mhACuJvqCEx8auojX+DM58bfaqz+yRHJKY/6NKDGXDLia+9c8AxwsqXhQkU/8ytX5vFn
         DwdvLM3LrKnJFsgUNd63sCB47r05BFOsuXAov0BQfj1W8z9JteryDwZD+bUU/qpxGttS
         ZE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767690948; x=1768295748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Du52gVNSd6dUN+ox34XkpgmRisqcm6nMlHGah1IV5Rs=;
        b=qlIZ1E8NjjKDw864saZErg3id2Zme54RrJ+U+1bceecTZ92+ADsS0DCgsrm6TzLw//
         eTc3qtg4HUbvAByIUXm1T/R/9R9mkXEMgxCffpWn2IQpv5642idxFO0Abk76zVczs9w9
         EMeQ1l7wbF7aGsHdLNZXQM7Et8PLLbF0a+naASbd1bzm1OhUNw5faxvfvvJmYQiBpwE5
         Lv/bl0LYub1tbIRYxKTB1JHYywmlkPfoP2j0JECOPzxpkDJlewpNB9oidADhl1fCTTKr
         T/YFv6Z19vp2RXHhwsZIkmUzgy2c6lJ+QGHaiTvAsk4fwFfeJXoJYYIPmlltaqlKDk+h
         /4EA==
X-Forwarded-Encrypted: i=1; AJvYcCUzx/trFqSruB5zAPxNK9MPGgHwOcOOOd3UqeQgn3rM37GczBfpf3bwjgSUHOlSmD2OV3Oy1U1IXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4BkJORYtpIPyMtN3zW+x1nHnRryUmSzOsEOjsSLBEJW2qoP7
	zDChjGXLKqiuiGq+/0oESdlJwHMliNyxXbrP9nB2jnSQPqHF9hDjlV+j3n0rXtLitMUbwBB5cbW
	T30QRzoSbEg0QQjOCFaMPhxaTChskaQ5Xxx35B208BCI4sPei5cpilba0czYP2Q==
X-Gm-Gg: AY/fxX64KpD/KRAQMr2IWxl0nOtK/KmKbOGkdkJnFw0CIuacB0ve4GVEjsjjQiWZzyy
	+shaKBeUazKOsezlmc0qkb2D2fe1gNdlkaRr6Zdn2M8uskjE0jErD9qr6Q9AeMmJaLDdbYvWCpW
	y6KpoqLfkn8wzVYb46+JxdiYKCfRhp9h/arm2tj19TbpkmL3Dg2JUJ3JUWdKOYR0TTDGddFTiSY
	OpcI/+N18hP65ZwcXm3a3bwgk3qmJmn7bTQtPPG8BnkvBbsvW3HCtIhOw741B2oEOWUCPcZ1Mbw
	XzyU2YdyVjI5UYseGCvC10gBKnv8Te5Q0kjnx038IAwU1n0bavnU0KnjzchHJ9+C5c9KDKwRtaj
	WHS0mUZXxgRlF4iZz4nWwXIEzGZUAuKxxzA==
X-Received: by 2002:a05:622a:34f:b0:4ed:b83f:78a3 with SMTP id d75a77b69052e-4ffa77aa653mr26990761cf.47.1767690948187;
        Tue, 06 Jan 2026 01:15:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHlsqdZImWyZR63WwFSMPpAOaqhhQOEY6qsvs8J2TYEGoLxgoyQ+tQ2SIrX93DUzAU0HOBJw==
X-Received: by 2002:a05:622a:34f:b0:4ed:b83f:78a3 with SMTP id d75a77b69052e-4ffa77aa653mr26990431cf.47.1767690947749;
        Tue, 06 Jan 2026 01:15:47 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff319sm3271370f8f.43.2026.01.06.01.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:15:47 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 10:15:19 +0100
Subject: [PATCH v2 09/11] dmaengine: fsl_raid: Simplify with scoped for
 each OF child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-of-for-each-compatible-scoped-v2-9-05eb948d91f2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=GS8OvkusvmgcdB0Bw7k1Y4Yk9s8voPKG1OqeEcLUEtQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpXNKoTrzxQuj34DrlmfL4gkQkEqmVwpmfV966k
 v59U9aryviJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVzSqAAKCRDBN2bmhouD
 1xq5D/wLkQTsn/q86zmdnRKEfkOqoz59r5ZsIs4UkOT6p3gUQrAkGQMknuX75jZWDumDlMMzr4m
 wm31zU7SZgxaiwsfheFrSVHIGnXEldOci2nKTq3QVc713Rj8YZXHTqSQmTgeS7pDi5ZcDDDxrEJ
 +/brmshxXLsTtWWuSapoo40bEXBBUxscI8K3embILPzkizJQtfBb1t2m+bONrtO00as6BuPRVhQ
 IShnvdBTOwbCDRpo0WZ3twrbajEdLMOq+QIZlaEZuyMI4Qu7bU6s+SMXevITYOOlfgO2vZWSQ4Z
 S4STHxsPHVZunvspOch+78go59+OZtMYWhMrl4XYpUGeHRuP2qou5RsrZ8OnYEDw+uUL2FoHljs
 dT8P2D0dXjqMiT6Omgq3mZJudvmLAn6UqUODK/GvT/+iphjlu4qToc7iBShU/pwQ9z0NAS6H8sa
 D1AhlzYysND44RVmdQtX4txfFqs0/c4tR7ucfYjneGkWIgcxDrq8WBHZO5jwL6j/WirnUX/+jxG
 KcU81Km4LTP+iTvv9zqqCOXweuoC0Pv3RpavjT8c+5tY1U71Z00azyzpP+ibdlrx2bzIqD2xiW9
 0kIO857qBHsEIIbcdpU+pgch9fb2zFg6dT0l5ZLAdQHGvChNJsgtzfWml3v7QtVFu2RdKCrnn/o
 lRzC6hj6dWUEK5g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: G5z_camr2j0JsekLU1rd9sfH5lLVwORd
X-Proofpoint-GUID: G5z_camr2j0JsekLU1rd9sfH5lLVwORd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA3NyBTYWx0ZWRfX45sqJcc2q3Tc
 7wgUju1suhYp7/cJy+d1HS+N6wswiKaWqdnnz2t9hQUvTcFJNfAcO+UOKF6ZcdEZm2VN9V67y22
 p6APxE2jb9EC5VHhxBE1avUGMA25Ouvhh7hvMALmTWLhWRLlCGzbQa49nr0i0X6i8XwUOOBmWYA
 Su7qcYxL/wlf/L6DR3uDmd2h2oPLRNUl8kdIotQ5Dj8toRwpu4xXP0AoXW93a9roBrnr1sk8YJT
 N/nUwXFk3W4N/lMjQcFbaEI596TS0lqK7bSG31+jaQXAJe8Bsi5YRKO4IybE/n7ZbeueHaCf6DQ
 pbm4KXjS1MYGOch5BnAisFBB88/5khAIguxkP7tl45pNDAT2yUaz14EXcKzRGrB55fle9Et6yTU
 fux0Z++OtnityweJW3EHQmWFAj9nHerMLzV2qiq44UQJU5aJpzGWK1gd59M/6sNniMvrZBGcy4N
 E2Tbso/vEFNPiSWn7DQ==
X-Authority-Analysis: v=2.4 cv=Jpz8bc4C c=1 sm=1 tr=0 ts=695cd2c4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=kVq6N5mEIK0mURhpU1kA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060077

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Depends on the first patch.
---
 drivers/dma/fsl_raid.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index 6aa97e258a55..6e6d7e0e475e 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -746,7 +746,6 @@ static int fsl_re_chan_probe(struct platform_device *ofdev,
 static int fsl_re_probe(struct platform_device *ofdev)
 {
 	struct fsl_re_drv_private *re_priv;
-	struct device_node *np;
 	struct device_node *child;
 	u32 off;
 	u8 ridx = 0;
@@ -823,11 +822,10 @@ static int fsl_re_probe(struct platform_device *ofdev)
 	dev_set_drvdata(dev, re_priv);
 
 	/* Parse Device tree to find out the total number of JQs present */
-	for_each_compatible_node(np, NULL, "fsl,raideng-v1.0-job-queue") {
+	for_each_compatible_node_scoped(np, NULL, "fsl,raideng-v1.0-job-queue") {
 		rc = of_property_read_u32(np, "reg", &off);
 		if (rc) {
 			dev_err(dev, "Reg property not found in JQ node\n");
-			of_node_put(np);
 			return -ENODEV;
 		}
 		/* Find out the Job Rings present under each JQ */

-- 
2.51.0


