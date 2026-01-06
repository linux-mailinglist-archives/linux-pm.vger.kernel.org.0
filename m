Return-Path: <linux-pm+bounces-40278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F433CF77AE
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 10:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C02213152172
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456E231355F;
	Tue,  6 Jan 2026 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bt7QpBhU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cJ+Tcw4B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3430EF6D
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690942; cv=none; b=AQbl8XBGQMsJSydfG5uP9cBnMGOjJM4WS7rEkSVv1+/W7x7hen+rIz5fEzwV4FTqwIMvnmJQ1bP3DTAICUfjvD1P0HIJzE2/kjB1/Tn48Q3+jTmCLdvotT5PxZ97C7bwOeYZDuDjXJ70hFPQToEL7hy+YPtXuFmO89INkyhDf9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690942; c=relaxed/simple;
	bh=CcL2dBoqkb70hXswIhn+u0x+0kkWxrj/nvOKr2gseQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NFXYnU5PXGK4NHY7WViB9n8O11o++et3XxrCclDv5tCL8zwwWSJcWRYhbwnoN1SN4Zb7JpL2IjyK2xSssqdg8uTZkxQaaaCR5lH7Bn7Hc4m8uhdFoDk2jgVEBpHCG/1ps6jDG4/ta/ybtevPfMy3iQclpAVAiUvQpWKdr15rXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bt7QpBhU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cJ+Tcw4B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6066t2jd3294939
	for <linux-pm@vger.kernel.org>; Tue, 6 Jan 2026 09:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jv9UX/vL1VNz1ktXt+fRG2Ciov2t8INtnqmx6plWOIw=; b=Bt7QpBhUM67lRrub
	XnhKKB/sVehI4YaGtZlLkz5hDTDM9DeNSWuXNh0C8tuEs66yE8SE4L2HFkIJ+1r4
	37crvmDEv9n6qX4w3BuxHFL3Dzasr21YsgYjE+V/lOyP1mM5Scr04D7q/OyJDFTv
	EgIvS3g/lGoT60ng1HhzWTJS6DRGyrrmnB8Za3UmCbpP9UHUSE8paeHp1Y1u0Wpb
	eecYByuk2JSYiUhBsTy77Gh0Q7rYypE+bGjOvukgMFk4k0ET/Cydzdfg+yIbvS7m
	X9gfda4OxOHA4zNrxIEzqQU0rjXq1NK8hIwBoXsSyKZJ5QxET8VpcSKtMXeNBNXd
	6H9o2Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgwj00dn6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 09:15:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f4a5dba954so20585031cf.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 01:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767690938; x=1768295738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jv9UX/vL1VNz1ktXt+fRG2Ciov2t8INtnqmx6plWOIw=;
        b=cJ+Tcw4BuFojabw9qxGnEOFHNiDcvQ3luKIqd5Cg4Wzl0CjTjy2om7CtMs01k/1uZ0
         YaLrqN2RieEOJf7vYUFF7mxWWLnosD/jqbhWeKkVu9iyHMjF5xjeAB3Le8ccXzKlmz9R
         hl93aQyc94CuYgCdVcA/dVn+U8o8hI/rroTiDpl/mHeBjHjVrpGSqQmeaPOQvGqLyCEd
         WvLWaZw1eFYYEGeUk2ot3cuFOToBKBApUosQhygKDSQOC8jSVcnJuxrDQp/N78D5k9ks
         3C6nD9h+NxvCRdimQnX/FyZCk+aJTLaK0A87OPqhhBtwMtuWOsH0mock9A0T/oSSQCfL
         7xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767690938; x=1768295738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jv9UX/vL1VNz1ktXt+fRG2Ciov2t8INtnqmx6plWOIw=;
        b=KUS2xO55v3X4VQqmRTNqtw/mSJGj8KhSP1cnRVHZf365/ye/dvJ2el86gyhRhGYRwD
         DoOO3iCX+9gg1xhdfcWgxDpQi+SmU3cVFiT3jzpkXUMxs2eX6mhJKiGTHk9jI5Gfwond
         qZoJrEW4CIxGdYTshTNRVSy4IpfTeDMNy2Uf9s1ybgtdUsaxtbOcNOIDXKHjOTASt4eS
         yd2oK0LNbdr+YIIlD7Yi8U/lOa6govK8c6AsfHEaDKiDzrYvFL9UNpVB9PKZJNztyjgk
         auqoTTldGQRF5cu78zETapoHmUpyGSxCExNnuXR16FWNKS94hJf4t62DF2+w5TFE7o+V
         GFfg==
X-Forwarded-Encrypted: i=1; AJvYcCUwEMiSvXcrMMG38EDyOAlscv16oO/MTJr50iVmfNJbI2x4JSxfbooz3s/bG2xA+2ZUUbuf3u2oQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAjt0ewQO+teS8hI/9Q89TaqquaVXB2OF6X/75hXYmrkkOjAY7
	OvngoM9F6tthmihiJLRelr9zqDtxKGiTzA6haPa/g1LW06nYlVKIsba9h4SIN8rK7D+QLeSUTEp
	L4g/TnMd8zaGSMlYlU5bDoQ1DbMSk44JZxdmWJnKihZFZim0yZe8bbtQVSHzi0A==
X-Gm-Gg: AY/fxX7krZnBbZChm/AnGV2qE8QxHez2fJmau1tbw/Mo8Nsxl/1GHjJaKSIeYiZyV6z
	YmPmW1ejWJI7AiXfMEOZnwmJIF2n/VDo1n87KROxL+7Dk3neNpVngqlC2KzMRI057jqS1mWR6El
	jJ/2heEsJ2my8FWzmM2nsedbTFFy05yNOGibQDxyDcdTHcDPG+wzt7gFI9vVqen4ol+AORw9kel
	76SiRczTV+A9DHgjFbhnfHl6EhtOfLQn7j5FLos2IBQuuE23JK9a2qMbw502//2K5hSv4gn8way
	pUzva3UE1KD/fJfkcDUf7t3MoES5p2ILoSx4dEH7SyOnH/R8WCEQhlom+xsPNUSp0+H14t0QLzv
	BSwDu4Koks19I32ockmRyPv32nHnY+8qLfA==
X-Received: by 2002:a05:622a:588c:b0:4eb:a6c9:e839 with SMTP id d75a77b69052e-4ffa77c0648mr26146691cf.47.1767690938057;
        Tue, 06 Jan 2026 01:15:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjHrSISO5W+RHtbFoxesZK1qbi3BFpaO3DUV/f+DVaCU9q3ACBvIruRc8VJXRXhXWn+bAw1g==
X-Received: by 2002:a05:622a:588c:b0:4eb:a6c9:e839 with SMTP id d75a77b69052e-4ffa77c0648mr26146461cf.47.1767690937572;
        Tue, 06 Jan 2026 01:15:37 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff319sm3271370f8f.43.2026.01.06.01.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:15:36 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 10:15:15 +0100
Subject: [PATCH v2 05/11] powerpc/wii: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-of-for-each-compatible-scoped-v2-5-05eb948d91f2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=CcL2dBoqkb70hXswIhn+u0x+0kkWxrj/nvOKr2gseQs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpXNKkBhQzmnu819Q1j3S59efOSUy8B8frf8Oif
 oFQAFjLyXuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVzSpAAKCRDBN2bmhouD
 1yFFD/oC2ftD9ryyYMAcCvww+JY1z1bD7uWaP5uh6DpPPH76O7rLf8NpHji9WYn3FS9/PeQRqh1
 QgLs2r7YAAG+nbEFuKlb8u5XWcJxalKZsThHBEhmMq/E9c49Zs2f/bm7Z8tGnb8CUbJp6v5TgEZ
 kPhDgH79CQWn8LfXHbXpRKW2xi6Iyg51k8KYVRB/YYRSIwG4mA0jujcBb8iSVPxSg/ScCoC3l4P
 nPn+xtmqDh9NSprtqdFkKQ0sPGNzjqXWy514od6NbTwrPip53myf/RgO2Y3Lo7E5O+UrwXtKBGy
 yPzGvp0MgPbX72kUDCy2i4FOh6PAKWTGD4eUNPkIQtLvIbcOAGrwhQHb2pXUbKTnr64CzSHWnru
 mtUFlUOtgbNGfzogdjslxK8HfRYdV+9YLLYWh5mZIr4i13LSlbSoUfTeECsZByZFXoWWmbI1zRV
 DBwB/2ler64x0rk/oYEBpDXQ0bZECG0Wx68RkRTnpkTQu9s0BdQCVihrXMNXoEF8pMGzMM8ylQT
 3nzvdbVOuIfPuyY+P7M78l2itk6VPF0jKsd5vJ7F49JOGmNFEBT2ceurCdOD0S1XC8uwPmYU6bZ
 +eR/9kV0Zn15DeBOjTgdU4qJKyy1mjkCFv9BD0TRdUDd9TSfgJCFWV72V7YLdumfeyPEDL4/RZd
 iAua0BTHZRiL5Ag==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA3NyBTYWx0ZWRfX9co1csGDKisq
 YCdobzb8L/OJE2nwj6mcXmHKcZ1Ov6qc0shYlpt6FEUBF5lorePKGFUxW9L5Xb7DH+QfDWIfgGP
 JoMwEwGmQ36W4G4+MgchaPtsAncSkmmow+ZRLAU7Z6yHVyUk4sqRzDuOJt8CqfwovTWhLdwkhbl
 XeUSDThihAdnynux4L5oa+SKovus/+Xf/2uqG4j2rE0F0Cl6ezRH1/xzu0qduLrekMsB5X6kswC
 1wZVadHL+BGUoX82c6WKlO8jdhxpwV9qJhvFWp1L0RQHSJIitV5SfGT135cP7POlc8deR7dZ8Uj
 50gb0miDBvz3uYlWMe+8gw0XZ5QcODkwy6jx9Ji69bFDqWUoNLskzO7YelYVcrxytpnXs5yiwJ7
 F2HTqxJu+CErigkqfvgz7R++omP/TEnt3J4aJ9RpN/ACLH8gJsECw11vfDJ7u2lTXBHP0wEi8Z+
 ZuHAMjzocR06ZtMaQHw==
X-Authority-Analysis: v=2.4 cv=bdBmkePB c=1 sm=1 tr=0 ts=695cd2ba cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=uffMIp6nSmQIayL3VFUA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: oist6Gd4m5rC55EsPGI3uDipuHLmGu8Z
X-Proofpoint-GUID: oist6Gd4m5rC55EsPGI3uDipuHLmGu8Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060077

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Depends on the first patch.
---
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index b57e87b0b3ce..1522a8bece29 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -201,11 +201,10 @@ unsigned int hlwd_pic_get_irq(void)
 void __init hlwd_pic_probe(void)
 {
 	struct irq_domain *host;
-	struct device_node *np;
 	const u32 *interrupts;
 	int cascade_virq;
 
-	for_each_compatible_node(np, NULL, "nintendo,hollywood-pic") {
+	for_each_compatible_node_scoped(np, NULL, "nintendo,hollywood-pic") {
 		interrupts = of_get_property(np, "interrupts", NULL);
 		if (interrupts) {
 			host = hlwd_pic_init(np);
@@ -215,7 +214,6 @@ void __init hlwd_pic_probe(void)
 			irq_set_chained_handler(cascade_virq,
 						hlwd_pic_irq_cascade);
 			hlwd_irq_host = host;
-			of_node_put(np);
 			break;
 		}
 	}

-- 
2.51.0


