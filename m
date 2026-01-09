Return-Path: <linux-pm+bounces-40557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CD0D0B6EE
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 17:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C7C63026DE1
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 16:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA573368260;
	Fri,  9 Jan 2026 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HLLk73qH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ayg8v68e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53165366571
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977911; cv=none; b=sQleyXiBuQATu3QkyzBcV6URTMrKOZKRTjfvJ/mdb5RBcLaqA1LZ9jI9stJqTOCM+sUrjeNTIPd9OOJrEFow4bYx8rl1Q2okTYO578rzQKNaRRqaL5zJ2kGvoAuTKPJsydozTbqtK7cAGzYmvfECWXVhR2ScS1BTGU8EnMNhEVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977911; c=relaxed/simple;
	bh=X+rJqgWZb7AzM0cu+pmQcyBAFnuuYCBdFr+ESsAnRIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pe6rO6+sXqyTFMagYvazBRo9msF7xvJkez4A8V1MltgHRyScWGgIBxRNVPi14Detk49f0uZIk6j6zhHzGIi2bHiUYIBi5jq5KAarLwfvYcIkKMuNMRsr0orjP8sB1dTBsyl2oAGP5ozU+JwjAVSxWXcWu2+Ipy0c3e6w1vCo8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HLLk73qH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ayg8v68e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609D4ZuH3542109
	for <linux-pm@vger.kernel.org>; Fri, 9 Jan 2026 16:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pS94iKUZ1ZfNhKbyBy+xUgSm1zdImwT1//knkyqK6zM=; b=HLLk73qHKf0AEcm3
	ZjzclVmLeQ0/Ah6IGmE38mGb8WeT7jkmCfgh3Qhq7o7iAMC9TMWTvb/v3TfrkoWm
	rTJHj7cFsKnO7AOfejr9gYB4KoyZh8Q8/AP83uWDcREQRbmXggFdKDH7zHksGjIY
	+346youzmL0/w61L1v0BhkvOYwxSoMWwS6zZvE7WA5o8HqVR0ADPaoutLXKO6Qdg
	cnWCF72VIPRVdRwKLf6roz8zagjxDXW0ilwhrt0cEhupDMoPd9gEEZnmVLYOqHmH
	sNtKvWEEP3xrXM37MwdtQRa0KoAjjtzu+dk6iIKy2JqYcShpU4Bqo4/T0xw8AQHE
	RMWEJw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bju6b211h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 16:58:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c1cffa1f2dso878370885a.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 08:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767977906; x=1768582706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pS94iKUZ1ZfNhKbyBy+xUgSm1zdImwT1//knkyqK6zM=;
        b=Ayg8v68e4CM7+wiooAPxaVFiEGgHSKVGDz7PAuVJKMWLPVqLDHH2FfuH1RvSYg+vZQ
         1z3UnGYA6ZzlH1rzWsvHhdCch6BtnJxKiqrYkjMcxj+mqXk/qQpJeVErZf7dZNJROX9O
         0wbN3H2GmxPm3Dud1TI9vzpXsFyOd9h7sfemDe4t6vgFeBNsLXR7wDnLWGke5IIu2pEB
         +J3G8JciPhTNDFsA9xkdronJVA0dFXCOLbCdvOzp8RHDe+aMVfgjErAjwKl82BD4dlje
         Bb40idYHwBN3m1+T1PmRMhw9HWIcpE0euqhGgv37nl6L+Q6teRzuqgc6F2fFDcvBl78U
         YPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767977906; x=1768582706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pS94iKUZ1ZfNhKbyBy+xUgSm1zdImwT1//knkyqK6zM=;
        b=jBR1JR6PU5kyt8Fu6wqvyUNycxSSpI70AxqGcOMBAQhv257Hh7GQWBFEBaDCWIA4Do
         c123A3pNvCznB3pPO2GRZcjYbxtqmdeThMawddoPl8dR9TTJnAYrAdoJ1zO5RL2ObD1n
         Q9P01V03ELc7/r6TyOjhsGRjQUAKgVrIjmh68HWQ7MOegLZGpCkXFkk52frhp0Up57Pf
         aNP9k655IRRi2HCNxWTfNwtDipxAMMAhS80pslMmqZLsYhoYbtNkf8p2Lyw9qxhweIhv
         Y/zIwaGVKpDqsT0WihBXQ7p5Lcf6anMmybFb8ZzRooMTJJt5MJIvm56+um9CZU78BR0H
         S37A==
X-Forwarded-Encrypted: i=1; AJvYcCXihoH+ppdpd1/SjrY25AHUIf3EnUUd9P0jaQAqkvGDTFV3s5BgnckzZfGIocRW95sMRcWwA1DMfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFB+qg7Cb1slBp2mfrWHDxyr44rXaX0AKBIen21ehwaGVUkOo
	FQIyaQu65cl8OcEhGQR5FQWY/3W+v9JvnskMfA9yXUsl4/11lhNjiNXxY1W2F6oWiBXf1r3CnBw
	rKvMd4otw43J0pGBW5psaBr0pmJp8sdNg3UuEWVvSwXNM4cA20laSWQ+XJDLGUA==
X-Gm-Gg: AY/fxX57sqUfDP3h4DNVflfNR7wyLO35acmpQqgpn4SZKVqma+BiBTPuZ3mq2Awozi/
	8p6xmN/JNv0kmSDCJE8+iwUgtJbCBq3HRPV0DPkLjkNrQP5efj7su7gTaQRyg0Ne2AZXTu7kIKD
	Lmm8m9c0TAL1O+ta0j5q/bW8WJERQWaYGM/wHcO4SRNWrORoFS9nTNnn3MPNlqB9F5frGk1ogNi
	l806VlXiABCppRKyHCLOORJ75REZIHIrqLVfGr+bfWvMT8gcXQIEzCLY3XmzLRYSWkOk+epwFD7
	t4Dc4WAMsjiGS/96UZkCrUDbK6f2soqlTOQlL0QqvZWcl6TpdPQPVofNVjJQMAJBGfeas+8tDp5
	qXYCnG5mZN18NPKANdP+eYd1fHnkyquGDNQ==
X-Received: by 2002:a05:620a:4508:b0:8b2:e3c1:24b7 with SMTP id af79cd13be357-8c37f535f19mr1820070585a.29.1767977905730;
        Fri, 09 Jan 2026 08:58:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsfjFGqbAxLc23gcdJYsriEigu5ohevlkCtmB7A0Yd5kZaYg4F8i/gp5IEYHwuSzY4tC8AiA==
X-Received: by 2002:a05:620a:4508:b0:8b2:e3c1:24b7 with SMTP id af79cd13be357-8c37f535f19mr1820067085a.29.1767977905236;
        Fri, 09 Jan 2026 08:58:25 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm23231784f8f.31.2026.01.09.08.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:58:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 17:57:51 +0100
Subject: [PATCH v3 07/12] cdx: Use mutex guard to simplify error handling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-of-for-each-compatible-scoped-v3-7-c22fa2c0749a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1439;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=X+rJqgWZb7AzM0cu+pmQcyBAFnuuYCBdFr+ESsAnRIM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpYTOWTG2xT0pRpBkG2Oxza7snBRuC4VjYU3M/U
 qAWA101mfyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWEzlgAKCRDBN2bmhouD
 1z25D/43t1RnWOYzf6VK4emya2IvUXE4PE2KamRZbdrtRYUt33wpN5FW/mIaskpIim+yLl4Mz57
 Q99PnqT67OgRKNWb5vmCgdvzae2SWBlxdKcnNPQnlosJLQrzfUCiZ0JDB1SUJRi7Gkkt2EYH1FR
 ABmiT4JE4sfEYLpZYwp0xtuNfjNRa3KTkJMP5pE3gHAfHHfmLaw0FImBWZKPPa3vPfJ9G7c0WtP
 i68ZQ7BIm5bYdiwMB3H6oYmovINgnOafL8vV1vuCxpCEg2a4L931KEMc+hmHQE4vPjpr5MoZOV1
 6NrLnPJTqdu1x0qXBS0iyPV5wNigBxrB23X+AAecmDUiNNDKSRa432oGjKMxmqRcVlyehngW8qv
 kryEBlWuLwaUiwOBxco/J6hgP6KeFL10P9udg8CAfutYUMxVAoU3ZDhNEZjIzZ7B+TR5yUjG3Am
 kKEusMDjK0bNXrAVkFkmYgSddWZK9KeNtqGe1jaKsr/WnyFFbNIyY3FjjqitFE6wg3fZSGLnnPM
 HluYuCBYQrTbNLEw021XbRsgnYSjh2j3tHlJWE8ajcwk8qzdhuugpcOFQ6ADF70mVzyRdFMSIbL
 YMdfyfOEGuzc1cFMbv7kIwtnmyv5mpgwGMlBRVfqlb8udSpwuJ09qezcbQ169bmtQve+3z3ZGHc
 gkOPygD7XBxOF/A==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEyOCBTYWx0ZWRfX+WgiL8WENW88
 bxKh1BzXgKbB35WixKRMeHbyWTfBALzTrtZ67UpIM8IvAytRovDI0qsmyX+wYGyJ1gZVTfYdi/F
 1yVaydVZxbgnYyCW0klBSFNHa0vaybK3RzM3B2B8CoH9w+uiRDFM3a+X3jIKgdYGxOxu4ztDJ+M
 lgVUdakhM5e+A9aeLsViDWEF7ZOZCRWRTzK63/+iRQyVFdP6dkPrzdCV2v+fBGZ+/4oxYxK4I6m
 PWoZxKhmrAYhL0CUcgCjYujVAbJNccBml4T3BbowEhQsRa9YYy6Q7+a1/S7SDM7CAP4YDcXEOU6
 cM0Z0xyNtexb+YLuXvMf8DqK/ycv/DudkwAGQiPWxFeHOZ627wgyIhxHwbgmz3cM4XFOoVkOVi/
 rEYvKb8dEn1OqTHrU0B7xdkDs8qExeRnlqzA9nw2/o81sfQsDoN8NGtJhhLQCPTUNNwcdZRLUCA
 7yYLcecRfo2v7n+1qzQ==
X-Proofpoint-ORIG-GUID: Vp6Rorp6Yp0ps9_xsuezZPkB-8kppk9d
X-Authority-Analysis: v=2.4 cv=V+5wEOni c=1 sm=1 tr=0 ts=696133b2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8
 a=HFiHojuE27rTourpOroA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Vp6Rorp6Yp0ps9_xsuezZPkB-8kppk9d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090128

Mutex guard allows to drop one goto/break in error handling and the
less expected code of assigning -EINVAL to unsigned size_t count
variable.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/cdx/cdx.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index bbde529aaa93..588dd12e8105 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -616,7 +616,7 @@ static ssize_t rescan_store(const struct bus_type *bus,
 	if (!val)
 		return -EINVAL;
 
-	mutex_lock(&cdx_controller_lock);
+	guard(mutex)(&cdx_controller_lock);
 
 	/* Unregister all the devices on the bus */
 	cdx_unregister_devices(&cdx_bus_type);
@@ -624,10 +624,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
 	/* Rescan all the devices */
 	for_each_compatible_node_scoped(np, NULL, compat_node_name) {
 		pd = of_find_device_by_node(np);
-		if (!pd) {
-			count = -EINVAL;
-			goto unlock;
-		}
+		if (!pd)
+			return -EINVAL;
 
 		cdx = platform_get_drvdata(pd);
 		if (cdx && cdx->controller_registered && cdx->ops->scan)
@@ -636,9 +634,6 @@ static ssize_t rescan_store(const struct bus_type *bus,
 		put_device(&pd->dev);
 	}
 
-unlock:
-	mutex_unlock(&cdx_controller_lock);
-
 	return count;
 }
 static BUS_ATTR_WO(rescan);

-- 
2.51.0


