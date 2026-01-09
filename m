Return-Path: <linux-pm+bounces-40556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D80AD0B746
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 18:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55919301701A
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222DB35A939;
	Fri,  9 Jan 2026 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WlU1ri0i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MeBA4BMp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D0366558
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977910; cv=none; b=ttVzJ+yjk9zfYIRASS/+fMIGUB8Yjn0PuG6QylNyz/jBP9jVXRWG/tntez5TAVEUYQMThX8dpmLTThGYXOcXk+RRBGduVmvNRWy4VOUJaFmygZfhEo+GofSwgg1oiYpJIWFCQLrkMyU18ZlZPwNTFTYN2MQEwHg0vJ7CdbGBLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977910; c=relaxed/simple;
	bh=etPrXIm2DbWPr0yBMZ1LGq97W5bne6RQqRx/65G5X9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QvVPtYQZZVgOujD+VDpBvzavt5x2rNZVE3NbhCGGCPdp8D2VnaBe5rF7jhR6RjCN2l4D1F53PwbrV4faKlAFlWWFtr8LDXvyYMYtWhJOG3PTJsOxt7gdAI8UDzHD1TWDyy687AU8OoT67wfeiMk8W2Dmgp2zK/4VEX+va1vtPv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WlU1ri0i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MeBA4BMp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6099XgtE1048200
	for <linux-pm@vger.kernel.org>; Fri, 9 Jan 2026 16:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TVJbv/lv1mJxKEXbFe7HFa6qKPqOIW0YhqRLM00SXEM=; b=WlU1ri0iWmc40W41
	+yFJU0QbrSHlE9jWu8kujGIrwwbbXrxSuxPJvlKoj4NLiTOV2oZW9z+gNP+bdo0z
	m5XaQaz5fjNVAgWZDl1r38AjfaskEol+fOVBSBzrpztFHxQvABY8wW/D9KE8D34Z
	L751B/4CXiVvG7hC4/HAj8Rhp0jtR8djYUIAPYp+nSgnzLDiPi6ci+JGsrka/xqY
	oCJfPg+fNMaY/UJeC7YNrlirdQOmRq+V4ozFVCnNVq0UrcI/+QHcM0nS2jp3VDXT
	ZF9mJOzt80HwMaB9sBjYkqB0Q2IHLkFNFfLKMNu+/mksmHa+T2Pzh8oVnKzrPN8h
	HmBI2A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjy5b97a2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 16:58:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2f0be2cf0so926853885a.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 08:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767977903; x=1768582703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVJbv/lv1mJxKEXbFe7HFa6qKPqOIW0YhqRLM00SXEM=;
        b=MeBA4BMp7k7b+zLKEk9FR2v8ef+fHIyayZexk1NMowcUe+TxGHgcwq4IiPWU4mxmJL
         ASQwHTZsy1aogwRio1cYUqf6hmVPNJdUIlqVBjyH/9Ke48yBjU/fjvH8/VI6V3pCkIzn
         0elGMAQDIVAMBN+GPEMm+MnPsE9C0ChrKpWinsoeUL8jTybXFhv9MH7AYgB247BqVJ/8
         uxJLfJLuRbUr3D9Ag/+5wMYql6l3dLoZub4fRQa6YYsUGNB949WhTFCN4i3YhbNGdSFI
         mKkpy41o5l4zTOrTZgRrcOOGPXNG+tALP93SJmbN2jkJpOAbq20JMnpsUqQsENgGXHB+
         onvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767977903; x=1768582703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TVJbv/lv1mJxKEXbFe7HFa6qKPqOIW0YhqRLM00SXEM=;
        b=a+pJQhFOwJDw2CmTR6A7v9kkjiX2QLud2iKUrtc7wv+tZlDk585SvjAYWgC7C4386w
         qdQKCWKVJQWR+CGPg7QhtZ7qq41+3T9MFB90R/khTaTY8JSGtFg9g9YXxY5GQdyp+5P2
         u13OEjrs1KtorHz6YNcCFSF5jjvV4OunNnjAGHWp4ei0gKDsN6BNQAzWcMFWmLNWcJQB
         nGtaD/6DF5RPHIUT402s25vsurNQP8rdxGvZsnlfCS7KETM7gbxr1IocoFAprScZm8F0
         rMNjbHFcJZ37oeLdf9uqJWNX5jFcm5WwXGF93e8ZdxbkvSs3luGNfKRjMa8RHzhzj6QZ
         rdCw==
X-Forwarded-Encrypted: i=1; AJvYcCUGDtzGHSkrJrM8uYgT6WbLuIYAClFCYbtsk/m/DQWo8IRASfjjnSaNQaveODY/d27saGmvS6gzdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWvhZE62QrR1WHR4lsvpto8hSgcnIB7LXApWIlTlTYJpcBqrd
	kgt7+blczaRwhgyKPxrnD5PczMvnX7gx+Fq4e7t7utyx2HDIvmW5LHCWuRqAfnBfZCDGGH6hovQ
	AK0oMetflrZkosEf6j/r3r3ioL04/ZiuMnYjAdTnJGZrDlmIO4Gt0KG8zcnJ81u1Bb0T7ag==
X-Gm-Gg: AY/fxX6UUsE32Z934ZYIwka7QzqNFtxM484jeIMsN9Bp4WEbHGIKGQbOpvjhj9VE12z
	tABa+c6AqRnZcLNBTOiaoLNPStDFt77IH9MwxxAu6NlmiEkgwHLaa2Qjq4QsWva4PJf9fRr6CPM
	Cae23VXqir92L5bX5CW3SKrDEPXrV1ijvx80n1g4dWMhO5PwqKAaAtpp9gf4OB+BK09VlwzY+ur
	l1J0+BeIySytidUcK0sDPIdOnpfu8NFEsiWo7ZY+zQKdLWz8Th/UXkBA5pNpQsAtjWv9ngNnmeE
	HMf4lBAZ6vdkhhS0xQyrDVeK8trOJ8bzKXPOlY0S1ZSXa4V+uf1V5H3F3PKr5ws/iUK5MXC7D6f
	4vKi/0zUM1m/HASjXxjYhy2Tfn9s/PHvwmQ==
X-Received: by 2002:a05:620a:4802:b0:8c3:7e09:7305 with SMTP id af79cd13be357-8c38936be22mr1435183485a.8.1767977903019;
        Fri, 09 Jan 2026 08:58:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErA4IpVIsA+Sdg4ABihyyJ8f7uZZY3fgBUgwNKuKAzxhY6GZ6Dv7hnyicoT9YujsNjruLj4w==
X-Received: by 2002:a05:620a:4802:b0:8c3:7e09:7305 with SMTP id af79cd13be357-8c38936be22mr1435179185a.8.1767977902519;
        Fri, 09 Jan 2026 08:58:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm23231784f8f.31.2026.01.09.08.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:58:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 17:57:50 +0100
Subject: [PATCH v3 06/12] cdx: Simplify with scoped for each OF child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-of-for-each-compatible-scoped-v3-6-c22fa2c0749a@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=etPrXIm2DbWPr0yBMZ1LGq97W5bne6RQqRx/65G5X9g=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGlhM5Wh01oE3KlsXi1oRCb1ebqBEOJW+lH8G7ztv7v1zkNrv
 okCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJpYTOVAAoJEME3ZuaGi4PXv7kP/0jb
 +sneulwBx9dx7PbHub3lGdRzucikXzqpPxwEBwTD8oy+DEhmYBPmN2ELBeXlAV3yA3zxNQQeGgn
 gILtucbXtK+pd9MWYsXD9goHh2aokAQ1WKdq5rqv/BKQNKuWEWHj9nALLxrreu5MIM3CyLMf/75
 FZju/PldbhUYIWNLuBBHvnNQ7UWekhFoc9T3b+lsQsWD3S5/DJpI2+gs6QXftE+GN9ErHHSdmYx
 Jfbit39mvSJR2hPlcjjrNsC5E1Hd2234AHzcPAW64PlZi5fA+olx6o3egjYa7uZRatAuTiyToqc
 E35inBibatbJ2okonvpTmFUtduRaklEFtfQykDNxVGtRDK2At+jQuhhTwV2TsugiT7oDpNyq3do
 zHE4yS1kkwZ162UlE2nRducX6NDZDHPcy/3s9iOEMmy1HhmD1Pb+8YINH5eunx1E7VMLTU7r9w4
 7asY/VydT6D8OwPxVQn9nmPh3xmDXHXJBUQ4YaehsS/R4j8iymLOhai/woh76AgK/9VdxYfiFF6
 d81EpawWPRTxMOQPszdEkiBnuRWHfqwxU/HQUOBZwHbrv5HnuRjKnUEIgJOE1EN3HHIQV/n9dvR
 eOh8jyDFMajmozTKQ5EZFxCbS7N1/3OvjHbC/qFpL64WXCTvwIdZN8wQEA6KgdM4j9M459dGsGx
 vQ+6n
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: ylZUNC6EvelAxpwqk73nCH17O94y_ziF
X-Authority-Analysis: v=2.4 cv=JP42csKb c=1 sm=1 tr=0 ts=696133b0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=lBFd75AfmJVjEZM8J80A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEyOCBTYWx0ZWRfXxw80bxIu4aFb
 h0m0k6O2QKns4N85tGJTThleJwW5JtnWZ8v6eEtMLQaIq/fyLzow88I1QhGCHEuf+YZ2l2vLLKb
 AOUG00ZiihWNFxqLTkGSDNqh/QlCUET7+uy2cInYAuzzKZDAeAy9ZTPsLcf78OCUNvcjBGK9UJd
 dxqjR61dWCmT7wAd+SLCGTa3FrbEy5Me1YtmdSSM5QN9MBtaL/JI4DeOwMwJU7BO9GVBAuFjuVb
 s3bjRBfS6wnOQSF6H9PpeLYtNo4mbYomiReWRNeyBP8M/njc0xWIdqR6qJFF9iRFV+xx6KNss+w
 KOZEMxVzg4Zkwd4rMigpotIRa1lB2fM2OkVBR/sRayHNd8YMIqZo91liUu9RFBFtTWO0qtor6k/
 WKsQnZdPIByo5tpQhEvbX5OgVudlsMfnECc/DQEyg87fAJfjNo0nY1S9UrecQQgExVb0Q8xhAIS
 qyCPnaUmn5PvraDI61Q==
X-Proofpoint-GUID: ylZUNC6EvelAxpwqk73nCH17O94y_ziF
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Depends on the first patch.
---
 drivers/cdx/cdx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index b39af2f1937f..bbde529aaa93 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -608,7 +608,6 @@ static ssize_t rescan_store(const struct bus_type *bus,
 {
 	struct cdx_controller *cdx;
 	struct platform_device *pd;
-	struct device_node *np;
 	bool val;
 
 	if (kstrtobool(buf, &val) < 0)
@@ -623,10 +622,9 @@ static ssize_t rescan_store(const struct bus_type *bus,
 	cdx_unregister_devices(&cdx_bus_type);
 
 	/* Rescan all the devices */
-	for_each_compatible_node(np, NULL, compat_node_name) {
+	for_each_compatible_node_scoped(np, NULL, compat_node_name) {
 		pd = of_find_device_by_node(np);
 		if (!pd) {
-			of_node_put(np);
 			count = -EINVAL;
 			goto unlock;
 		}

-- 
2.51.0


