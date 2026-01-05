Return-Path: <linux-pm+bounces-40194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23401CF3E9F
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 14:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89F0F30090E0
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6D4315D5D;
	Mon,  5 Jan 2026 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HpwB7a+i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RDppoon1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B365C2C0299
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620043; cv=none; b=upTkjcblFE2CIGz27K1ZtB9bF7l+DGEQ0c551JnyoL3d0jAaDpwPq4ZthqLlJnIWL/+doFZpawRJ4e/HtocxxWkakaXMWdvmqv7XNn6jyq9DaS+gY5aDPrmU4jwwOa9+Gzt8hjZrtBwDIIS3OXv98R//YLSsEA2nxkuCGVqx680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620043; c=relaxed/simple;
	bh=GAS9AEe5svij+iU9HSZ0g+GWVfBCriapq27kDniovIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LzHbLj+Itt1nDNJ0iujvhA0R1PqKM+mQ/qGA+bPM8RmLr9FdlTzid5QZVNKsSf0WbgzaKLklrl16iMV0aOoRcE04GbLu/5dkiKrSMq21JkWDnziksQ5wzXmrtTfNAW/2QDjk7Oyqn8tk1QlwYpRT6CnXqVoaMWfrK8+tdOaCQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HpwB7a+i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RDppoon1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6058LrGk3738169
	for <linux-pm@vger.kernel.org>; Mon, 5 Jan 2026 13:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QRm9jmTww7VVgDoLVcF8mMh0LdpCo6QQ7D5Go7eNjzA=; b=HpwB7a+iAZkL1k4x
	s3UZKic6MXZgtLDFjUUvN17XE+8wQX3uis3IILFluMqIJjirnkjq9KUIyCrDGFwJ
	w+lCivFopT9AAdAfMRbbpNhmoCetqaXH/KJ113RKYAJBAjaqaK+DMplCm6ocFC78
	SWTD9FZoub1NQBMw3rH03kIrWNG/bMVph0VJG5G+Ed+z47cykYtc+nhPYbql4LEW
	HbbtwlIqGxwwngxqe5DqyzoemN/xIjvVpbCVhk4S+eL8qBZK5g/F5ON192UUgNo9
	dvfnUiYcZ3RKSWb1diDxToCjUUWq+UGvflV8+vdBsMK7dHF6lXIMKnttSTsuyagQ
	m+t1wQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bet2qvsu6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 13:33:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f35f31000cso193782211cf.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 05:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767620038; x=1768224838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRm9jmTww7VVgDoLVcF8mMh0LdpCo6QQ7D5Go7eNjzA=;
        b=RDppoon1ehRugnFNWhEntsYRgtGqS+EzTICaL20OlUwMRuvZZ2x6OSOjsWTuNivTFZ
         1hNd7eDZ0MqEeCYFZXznQYiosFtglndHvLh5+DweQMd9gZvTxzykw2e21JJUvaD9VSQx
         GDqSzkYeES2LmSBccFugB+9X81YIyXc6NOVmFPj9kLdzc/hEw5n38Zn5mELmvmcJzGT1
         oB5NevOJ5hzSjjqKlC0TqBY+LNLxTXVemW9pnFDlQIhz2p6r45RNls+h1ty2323RZ8VK
         6KjWAKZkipt+NO0s/JJCplVXfzmilGDQkBTDtUf93a8bF+TJYX3c3tXZiX46Gs4EZxfL
         bzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767620038; x=1768224838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QRm9jmTww7VVgDoLVcF8mMh0LdpCo6QQ7D5Go7eNjzA=;
        b=u7/82j5MuGtKMDK+euatSyVTKA2uG4b6ApmQrqCto7/dPjJnTqRO9fZhAiPVgWXT3O
         /wlqFhvCmoANr0iWXUOmIu8uX6+6BycAmMfmrN/JrHGUembe4INRyes8u+8nnOJRzYfi
         GsAPMdJK8iRIBxrm+WRAMey69Gyeo12OGDoXyebARCSVhSbAOmposAMpTHvtqMtGpHa0
         SY315ntD1h8E3xi46ealxmn52VvHWETCReSxI2VuZ5JIVf9ApdJl4kXfWNJuYkyZutxd
         zKXuH2ds+2bLH1xXg95tWWarYSXsF6K+yTX/tXjv7eoiAUEEz4rlKB3wHe5ikZ1hGn/c
         IxvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBAUZ4IcVoHcBNpQojl+vGzdBdFfj9BAJWfhqs95vV1U2eCBbmk+O9YifS4scSmFIZ67gCpx03dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyymbV77aboLg/Ap3xzKnoPUCSEaTXmUm/S4aVwLiIVN3+F9PWT
	3rf1UbRDl7mHLP15Qa6jjBXRlypErkq0GiV9Fe8KgwM6VEsad3zheODq+3w8EM5WYVhjdRdyYBL
	0gKoL6Lr97mUr/TrSDvtnC6quxqpKCE5dDn94t4Zf6TxsNjJRL8rlHFL+me0QDQ==
X-Gm-Gg: AY/fxX5v24L1ob9u12RH6QxA3wRozP7UCKmDFQyYSFNCGbTOk8R+iyj0GyszNpc8CuA
	pBa2uS/CxP/OnVLJ3hbor2OzxAubF9infLc6HcQHWOeUKaAbD6D4EWbtDEbNP5F1Eh5yxulQY6U
	Q6aH9faJi8/7+Z2tqfACLi3DEjnZ3wJwY1GNgPfLvAcV2knnquzQ1lWdxyHlUOEk8JqsD7js+aF
	hSn9MhTWfWBusgteEeYynBaGx2HYS/Dk9HnU3MBbSzC3PYp0CitwPT/vE/74xyp/o9KSyZeHVdc
	RjEGcr3nnJETRAdi+P5wlPNIPjOGGaP18GUSC7075r2t0uf3FShOlRsiICGT+LsuCuOogXw/eaW
	polP3secgS3UaPGjuC3JzcxfJb3I59OF6Cg==
X-Received: by 2002:a05:622a:480e:b0:4f1:bdba:8cfc with SMTP id d75a77b69052e-4f4abd942dfmr763072841cf.65.1767620037906;
        Mon, 05 Jan 2026 05:33:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXQkdFy+C8VMCsuzSjjG/gB7L6UA8wdH00hVPMYjUK2EJpc3FaxCWzsUTPLbxXtEYVpT4NdQ==
X-Received: by 2002:a05:622a:480e:b0:4f1:bdba:8cfc with SMTP id d75a77b69052e-4f4abd942dfmr763072071cf.65.1767620037276;
        Mon, 05 Jan 2026 05:33:57 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d143f75sm147211015e9.5.2026.01.05.05.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 05:33:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 05 Jan 2026 14:33:39 +0100
Subject: [PATCH 01/11] of: Add for_each_compatible_node_scoped() helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-of-for-each-compatible-scoped-v1-1-24e99c177164@oss.qualcomm.com>
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
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=GAS9AEe5svij+iU9HSZ0g+GWVfBCriapq27kDniovIo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpW722LmpKz6ga22yVNigaxc6TbG9MFhD0lOLYz
 7KcR095lKmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVu9tgAKCRDBN2bmhouD
 1838D/93vCXd+UZrPicCNSlGq0pDKnZ06PbiU5ryxUc4AR5JcGFQz041BCQ5MQfeOzIBlHThKzE
 akOLKKjAfTtHE+UfhdJzn2EXuHduDj3kbSkhi9/HR+pPEyZDcH7uHCn7mcIEtryrN5z6MzTzQkc
 /AxXVgKCr2N33F/AY4eVdpVPIiCYHk7Rcb7xs69cEeFgkNFFzC8scDEayJq8Ijy43NeBkiHHL89
 hpmE/KT4gu/Fkl8QUkxldwLMP9SqvbfDrXsTkt4BWiGM40zzIWe2P+xYjqs3ckIhVNIIX8gO0XS
 hnMNRXTxZHe17ZJgVclUuGVZEmoWoEH0iVxOiUS8RIN0E38lj6LFICvgQESkxmBzVRlJvHNnNFJ
 1rNigrMb/Xrx0MgSu8+VcKRKB5IVpemev7bAmGMuZFYzP/nfdKsFXDRpUzl9mJkV9nzAtqrmN/S
 VcV6jhBDOq18cIxjBk/hr/95kstkCb8jld23pYvf2ebPDIdlkFXVNBNOerNtZWBbmGBFLidmpUV
 CHm7AgPKg8LscfMZrKZyl6FNKScZw0YkO5RIz19HyBrq0Gh1nvdsccqFlRVa5rk6YoUNrMKy3pG
 ygYnP7LfU1nqPXDEBnkl0AQnb9Se8tdpGrNjNtbff/7bOGrGHVAIBvJSI06DriCEf2ZpHh2RtLj
 SeI2gkRt4EdtVBw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: gDrn_swzoOu3UD8NNrv8KdnEHjUgRDsG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDExOCBTYWx0ZWRfX3+JO3i7xqL/n
 8ZTc7oe9nSHtpMIbZC1I/ZvqfR/aDSydLKYTM56qmDPqntNyAMZZ4gziOxqfhBi1YCOd250WT/t
 dnkkSUuA7owRu55R8Z7wR485gJWZnymBfE9Dqae+4Y36VWs4Yv8ZKZW5GWa7JpEE8RdgbDRNke3
 z5T46zWZLwVUQzKx2dkW+gPHDGOwOg5VUq2/VVwRxTef9WCuxhcGVLe6dSWTJy0Wv5oocuAaJ+I
 fff57f2o0cBl0mkiOlN22bwzNdpHV2p5uIgX6SUlDQy8lHrc8+wWs4HO5iGqtHSHzMI2o7EZoGF
 Y/SOy2jjOQ4B48onh0KI+q9h+Gtn4Q3btUNz80+AcakfrmuJ7Ejw2Nzpz0v7YrofdP60Po1dMyQ
 rERtoTKsZ3gq5JtHYj6GMZeC2qzzuarOUlKy+8TS3qYHKN2Hp0krgD8xTN+VMjVYHNwmg0gxScn
 v0NRcMxKDnN0Z4tFn/Q==
X-Authority-Analysis: v=2.4 cv=RKK+3oi+ c=1 sm=1 tr=0 ts=695bbdc7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8
 a=fqHlcV494ISa_mgYehwA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: gDrn_swzoOu3UD8NNrv8KdnEHjUgRDsG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601050118

Just like looping through children and available children, add a scoped
helper for for_each_compatible_node() so error paths can drop
of_node_put() leading to simpler code.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Prerequisite for all further patches.
---
 .clang-format      | 1 +
 include/linux/of.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/.clang-format b/.clang-format
index c7060124a47a..1cc151e2adcc 100644
--- a/.clang-format
+++ b/.clang-format
@@ -259,6 +259,7 @@ ForEachMacros:
   - 'for_each_collection'
   - 'for_each_comp_order'
   - 'for_each_compatible_node'
+  - 'for_each_compatible_node_scoped'
   - 'for_each_component_dais'
   - 'for_each_component_dais_safe'
   - 'for_each_conduit'
diff --git a/include/linux/of.h b/include/linux/of.h
index 9bbdcf25a2b4..be6ec4916adf 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1485,6 +1485,13 @@ static inline int of_property_read_s32(const struct device_node *np,
 #define for_each_compatible_node(dn, type, compatible) \
 	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
 	     dn = of_find_compatible_node(dn, type, compatible))
+
+#define for_each_compatible_node_scoped(dn, type, compatible) \
+	for (struct device_node *dn __free(device_node) =		\
+	     of_find_compatible_node(NULL, type, compatible);		\
+	     dn;							\
+	     dn = of_find_compatible_node(dn, type, compatible))
+
 #define for_each_matching_node(dn, matches) \
 	for (dn = of_find_matching_node(NULL, matches); dn; \
 	     dn = of_find_matching_node(dn, matches))

-- 
2.51.0


