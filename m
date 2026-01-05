Return-Path: <linux-pm+bounces-40199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE13BCF3FE3
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 14:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 476E731317A4
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 13:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E9A334C3B;
	Mon,  5 Jan 2026 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZUSeJkiX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XNA057GR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13E4332914
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620059; cv=none; b=KVIZHY1KXrJKNpEvM+3VFUEML3JMV56f37RxVD/anUMyeJj7DOdxlbQy1xVyQgeO3JoxBbMNNOOiAmROwtxo1lLa6wRmB18PUCvv7t6PDNy3tvDjWdoeWjfJJ12bFV4lEgfm96FfkAJCq5t9VkXztrEFPh8zjAgA9y6fcdT8KVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620059; c=relaxed/simple;
	bh=etPrXIm2DbWPr0yBMZ1LGq97W5bne6RQqRx/65G5X9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzqzvIi4Am60XjuTtgMld0KPFQCxi3c/XedpPsGKQOBuAFKa9gcujOkXQOcB1Zym7EhRq/cpgA7ZEAzMNKRuVQ2r1TlVQcJRVICK4N0V+aSDu4XufJVTSDeDvO9kb9VOjmQih76zKrNys0AHpIkq4XellvKiWkt5Z7KAjviW8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZUSeJkiX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XNA057GR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6058bSHL1216101
	for <linux-pm@vger.kernel.org>; Mon, 5 Jan 2026 13:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TVJbv/lv1mJxKEXbFe7HFa6qKPqOIW0YhqRLM00SXEM=; b=ZUSeJkiXhgraqhhp
	F9dBNlDU2NjJn3UYcir4XLIvDkfLIqXrqgJ770e0uuuD3xR1xmIrxRuxiT7ZeJzu
	zIq/lxvweyNV+PueM0rqT3bzxnqzHA6NMNB2l0a0205iiIeNgO7j9pvpT6N9XttR
	scrfVoTLyPxZaXSZJZvdRInISVIX+rGTIqDtRRNHfTWZzYMS+M3mNRvd1ntqtojx
	d82EKfzcpzT+YOJ4k5q8kZLPeGcJYhXp4b8IJ9pafjIUYq957UR9TSlxmodSjYtR
	kWhuTIa+ATVn01Z6oypoyskUU1kfupOx2KAOKGtFvKzmdgcp7PAvcBy3oh8TkUR8
	e2gXYg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bev9hcj1v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 13:34:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed69f9ce96so523309481cf.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 05:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767620052; x=1768224852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVJbv/lv1mJxKEXbFe7HFa6qKPqOIW0YhqRLM00SXEM=;
        b=XNA057GRZ7FypHaWeOY3NON5BLILuR/Ps50Ioui/CoTVPyzlfEP6IrbFnj+GpitIPG
         xxvNgA8m3ACorYFA+WV168rcZkLdyPNqGKUNbjzHt1klPgMa0rCYPoXeO3qBAHdAGsWD
         fWkft/MDIqO0GfR30YNYUcpN7d0GI4CDz33Kp+3WXPMDKiqtTdBPx3oJb/wbY2tZRG6P
         HmiVkoKlfz6ABd7bUFn6jNDz18YE0ShQhcuONqFbb2uDDkvEd7nyEd6dY52LteCsqQtU
         oI07IObzVQjCFNiF1vJTFCvcl0spGLa3M/q5Qm2oMDDBK16pdoDAcW6rEVFfG3OfxB5X
         NtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767620052; x=1768224852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TVJbv/lv1mJxKEXbFe7HFa6qKPqOIW0YhqRLM00SXEM=;
        b=wgxiHv5N0EPhQaR9Ni317MbyJTXKJhv4HPYoQIWVrYvYZc0wIquhepah12VqZNkd8J
         S+K9vGh1qjsSE1gkGeOykrua4GKudLDQ+eJjreWak52m32SlkupRSb7RFlQgPEzSM8+O
         662feZh1dK/3ifmNrnDQwj8wedpymXCCaNQnA9vOfgQN0tZ2f/fKZ5AjRrAMe6FRutpV
         iKccOSa/o8fwRjUkVe9gwIzq9UNojp/VvogkRO8WN1+c+lXhKuBBvZe8lLxrdeQcdUyv
         YG7Xjpdz70XrbD1bao2AC+ToRGBVH30Z9acL/UOG9MM1Y7kfGkbSI+YpVsfmrvZAUEYQ
         wfGg==
X-Forwarded-Encrypted: i=1; AJvYcCXJhFjC8DjtGZX7ikKUUtZj8ZhpG6dLj4wwi8R5d2z4L3GJ4NYYhxyi3YlsEfoFYiV55kOpiAtUlg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2EZn9Uk3cwaVWv2DTJTCuDYir8gNbGAPaEISG/JyPiGqbsCgh
	N5N81yw+VbEMQ9qUDZyzkd8fNm8a/uhQX2NYpRU1DkQrZdnavp8j/8iMW0OZKU8+GK9VNB+AQqM
	TLNyiUb2MuSi81AXWGjGMJxqzNF1i98O0KbaXwvjeQAaKTyqGAoW7e/iXcIpQkg==
X-Gm-Gg: AY/fxX6/n6pI6V5ooz0pkQwQedep7+ciH8A+/nHXYujUuFZnTcms66eYTqw3Wl5Vb/x
	9HtA7rq5TxhMjr65YTaQyK51yVT2f6UZ/Q2Jf4UQadPOA4GyFDtrF9UZUllf0gmdnuA4wxwMMGq
	EmxMX8Dp2lg4Hej762WWEX7WlA0MOvweqiiPZyavaGw8Jfjsm4VCVWF1D76tcu9vAIpmsKdb185
	TAXgyQ2udNjL0d3w8h2j9crGEK0XaJZ/cYqM0XaZRpIX/meBPMcoIMMM8HSa3/GCRTPYaqH8GTh
	nJQ8HC/OlPatquj5rfgv+lOQV7gIt5bsEHcy+jwjtBAm2DEa1jzSycrg7VV4O5E2qYVnapOhzDW
	9cuO51nPDI57ZQiDNXqgdUZ5P0D8hxFnQPw==
X-Received: by 2002:a05:622a:1b9f:b0:4ed:b441:d866 with SMTP id d75a77b69052e-4f4abd9e674mr707316131cf.65.1767620050764;
        Mon, 05 Jan 2026 05:34:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjkllDicKUX9VQMpUuwOZohyZvcZc3Sco6Qs7v09u/svEypj1zueiG6vlATp619yW0479jww==
X-Received: by 2002:a05:622a:1b9f:b0:4ed:b441:d866 with SMTP id d75a77b69052e-4f4abd9e674mr707315331cf.65.1767620050252;
        Mon, 05 Jan 2026 05:34:10 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d143f75sm147211015e9.5.2026.01.05.05.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 05:34:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 05 Jan 2026 14:33:44 +0100
Subject: [PATCH 06/11] cdx: Simplify with scoped for each OF child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-of-for-each-compatible-scoped-v1-6-24e99c177164@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=etPrXIm2DbWPr0yBMZ1LGq97W5bne6RQqRx/65G5X9g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpW727J4D1GLQTEFCgq5popKtB8fHsHipG20NOw
 7z8v0h748+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVu9uwAKCRDBN2bmhouD
 13ZID/9xu3/z1GcnP/fuqu4umSBmakzQTGc8DuW+gIfzqb7Gxzh8CxMkYlfQpNvAoCYycruPEvm
 GJML8j4hYrwgMmBh3ewue+/gteRx4hOxY8jH9FcaBDWmanCk4BuDOa7siP9b6EUHPNnR+4dTppW
 DXVyaIvSvf9LYx4+EtVrCOhTAJlSjeItLFi622QVjfN96g+AU000wgNYtqmCjk80iXT3gLQfHR1
 JUVhEXtB5GQWMBeCliK5ZJOpcdHOVCtwwoiTXIFR2NeivDwy0jLt/C9WCSK+DR85oGhmrfBrVQT
 tInXNSuUDB99YTyg5PeUAdPYIs2+TGDYUHsG/ndluq7GBcij2t62nWH5SyvSsOyntrEQAjGfzDi
 06x9RjniTGa1+TA6SvqVmgBb4DRScfnZYz2MMu1NA+W7O2i1bH6HDbtXwh+BSzJ7IbcbPjG6U+C
 ZFKQlPvYvUm4pXyQ4ZCQzuYYaRG3RbbFC4TrrkC0sshupoWEcyVIEz24MaTMyqS2tNYjLlXFZV0
 y1xadk4qsAVMWwkS+k6Rbzx7pmClj/inj6npgzu8JIgPOVY+u48VcjOI8LYtbvs7kVA+35hKguO
 RZUWcDvabzrQ0gLOcftg5KUN6+ZhzN0HT9aOdPs1AnA8wU7Nld1rSagbCVv4iEw3rUF8io22J0w
 Ll+Nq5ST0Zad7VA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDExOCBTYWx0ZWRfXxyTkectMymT8
 qKqzNQcz53ie4aMmMLHRp9EXWb1g95a0BvFQryPLog/NwrDyYuSUo4FvWZZhn74EE2sQSmsUivh
 ceapqL022dol/vxDoz2PM1wv4iM41o2zjZaQu4ZQxT0LzFc2R++3vEEDEG1WzlxjGyEkitoVwcN
 otaJkYNCys+3XWLmEO4E1aAFZ23GBDFTTnvbxXQzB396XdTwTQm/qOsqLYA0vdVO6f0W/ZFz485
 4Jcx93BZYcpzRlJRvJG1vmRrLLjocL0A24g7iY+xCvnJvrlwU3V8wOrutg8PlYufa2swWfn0H94
 YvrCTKTbtgpUUTE1VWeZZl083egORhMBI18YJosd5TEtuPqYb2gBLJwV6XfezU+UYhgkbr8UNlJ
 0vO3zCFRmuHQgXNDuIcGHxV5O4TSyW7dIAJLcJjNSe4zcgcnb0+T4KygD8mSaKVmdyTIdfX0aen
 hWPMpGpUzUvyQyh+PEA==
X-Proofpoint-GUID: 6HeQn2Ut6BZ2UBM73Gx1F3OHbmf8PpRk
X-Authority-Analysis: v=2.4 cv=RrbI7SmK c=1 sm=1 tr=0 ts=695bbdd5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=lBFd75AfmJVjEZM8J80A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 6HeQn2Ut6BZ2UBM73Gx1F3OHbmf8PpRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050118

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


