Return-Path: <linux-pm+bounces-43713-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH4tFZj6qWncIwEAu9opvQ
	(envelope-from <linux-pm+bounces-43713-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:50:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8CD218A5F
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18696316CE5C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB23F34E75E;
	Thu,  5 Mar 2026 21:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WFSxdaVi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bEinuJIW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193535E93F
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747192; cv=none; b=TjBh0mGinZkF6sJs4RWh6VkF6v45i9t39VF9Nsuflhot0S3krAuT2XIeUfTYUeOAutLiPvugBlVOF9vK6zfLFXjLJlvVQIdsaxt2VZ1x1o8uP1DJOwxIhNbIwP2dE8v2/44KfvWkX1QfWSPWa4ozZMt1E+jkxtndheRW78CRG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747192; c=relaxed/simple;
	bh=G2Qaq1IYTDtA8nYq8hb67ozAR45iYXNAROMWtKf03Uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYqnm5otVqb++iMkT6NjNqVmCVGwmY0bGjECrm5hucGGnFgyEND3LFmogvjF+QsnCFtGK8q2We88UqZzHSkofhVUPLWBPfsyVenKCY5tYUJ3gns1IUtzmHdCyTitA7ByEz7kyVsVhiH+TiKcpPav4HM1q39x9TptX3Wh/DsG5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WFSxdaVi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bEinuJIW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625KmwXL1810101
	for <linux-pm@vger.kernel.org>; Thu, 5 Mar 2026 21:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AH50fw9QTtdpPbt41EGIzTuypwuiZyQQHwG7B4PGWqg=; b=WFSxdaViIVPBNC+X
	9bqAQeOpl9vGXSUUioaKpINGyFSaBj1czQ0kQkCk8MAiZaNmcE7wHL7+fV2sSzvQ
	6+x6p53n81WDEWEXo0Nv8GVfz/Bq6O3kyYYQTrRB5tyQjxBDwKMW+0/9IXoQz2Y6
	d4BwliZ31/MTimweCNxGsU/+OJhDIJazRYQ9e0jeS9F19EGb9kvDa4WRvV90AKH6
	2VVrNet5cmq2/CEVpkYGWwoO80ZawsyODj/naisE4DyT4Ns4KkPWvMc1KeARrEeT
	q79E+dOAggE0iGVpm+VqfUmpaIxDya2l8W/S/L/z/yRp6GtTChefieGrRO/pVVkG
	7QkkbQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqgp407pa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 21:46:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb4b8e9112so754405585a.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 13:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772747189; x=1773351989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AH50fw9QTtdpPbt41EGIzTuypwuiZyQQHwG7B4PGWqg=;
        b=bEinuJIWCzs8oyxJ1ZQe/B5ibrlzguy8muAk1KsnTZo/ivMShgSxykKHbB8DPs4Sny
         k+g2UVvAfb2S61E6t2Nm8Hu1EF1Ytd93B7lH0Dz2MUtWgDntxPFi8vNPc9XgWGfZIHSw
         mLlKjmXqFi/cUq0hwehoEMQ/7Q++j8gY6eyqnuZQyxpbrYdsCtbvvJj9UpJXyM5JkjxJ
         L2hF2fDkmYBFb7gOzLsF/CDBjzDA1u6CYj+U0gID5bDfHFvSnyaNv+5nIRJYJJnrLyhg
         jFXcw6lFvjnBRkIX0XxXNP39prOOjuTFOUO/oMSrVMpDVwzUW0pbPx12rHFYBqgDWDN7
         npxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747189; x=1773351989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AH50fw9QTtdpPbt41EGIzTuypwuiZyQQHwG7B4PGWqg=;
        b=CfSfX+EI7ml62qDE3JvIFdCYsRMIsdac9bcpakaYL+FnYnM7xF8XkzkBR4bJ1eUJow
         0x+QrHDIYiZVhTARaMvIxQkmIZAi0BPBu/FQwOVg4F4lMtXQ5oCQEZx7Q60Opx7Fx4Va
         Q6MFX6sXeDFZMj4ZOmYHqKZwQhrrGqh7NULIoLmaqIH4qsHAM8+E+3/lP0kLWIa3uxf+
         M4AiTe3ISrrmcGuu/iOO2s0afbIOCk/AyZp0dFBd+1ShNM0jKOSXNNKvPHV8M1TDRHtd
         Yg7L0fHwKVinkCX186P3YBF99xKJC+dvAM1fooDOa70mG8UGMHDgi72g/BU0mec3Irhi
         gzmg==
X-Forwarded-Encrypted: i=1; AJvYcCXOB3+oKwbFfRhSKGXMKrFyubc/9PMtm5/bao/JI3GXDvcBCVbRDeMJ28j38vonN7n1hWKawxBCXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw5jcPIXLB4EHaDLxikwlN9YmmxOgDgpX2M9eeGPCxK5nlFr46
	pEwREOVI5e11NLrbUWHMNspy3CaiDXUt49v3wnDFVzZJuWrENiHsSWK3lobmPXrlClHi3C+QWG2
	LhVlQuwBbmSvC3blP2vqmlx4CFxj2Zm0thvymhvI+njSE/AtdiPGb9phzc7z7Yg==
X-Gm-Gg: ATEYQzz6MB+HDxbMpXIERCG/vIwza6dk/uJ3O61ENJ36w7yTj+KqMGRCKCQf+3h31Wy
	6gP7MP0tJNfqUFEUWyuv9IeUiDL4evn64aNswYXMtTOAG3BLcSL0XNwiLDK1LnBWitkTxGRAJYN
	Kjw/d6LFtm/lZTFi9COdJ77KpzPccDl0mw0Z+xsdfb9dfKHfPlR/btPA4VuF8JJvCQGGjqeWRhP
	pbVHO78TcmNa78OR2Kod4Tu6LKugJKFbx8kY4MmsEK06jVQR34xi/q7vh/NQF9GdxbubaiyfVl8
	lUixNuP0JmgEjzwn2EaxgT3RQE8bZXovmK8WXT7QAdqfhKyqScqniA44yo0ZlXznQGYF83c/yco
	dGafReAYNlEcmswjo1iQaEAyiPk1wwBXtl/3HjwHDrZhw
X-Received: by 2002:a05:620a:1726:b0:8cb:4fa5:d47a with SMTP id af79cd13be357-8cd6d494e49mr2330985a.77.1772747189125;
        Thu, 05 Mar 2026 13:46:29 -0800 (PST)
X-Received: by 2002:a05:620a:1726:b0:8cb:4fa5:d47a with SMTP id af79cd13be357-8cd6d494e49mr2326485a.77.1772747188622;
        Thu, 05 Mar 2026 13:46:28 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a58dasm28571575f8f.27.2026.03.05.13.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 13:46:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 22:45:45 +0100
Subject: [PATCH v2 06/10] power: supply: ipaq_micro: Simplify with devm
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-workqueue-devm-v2-6-66a38741c652@oss.qualcomm.com>
References: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
In-Reply-To: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tobias Schrammm <t.schramm@manjaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Dzmitry Sankouski <dsankouski@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, driver-core@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3021;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=G2Qaq1IYTDtA8nYq8hb67ozAR45iYXNAROMWtKf03Uw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpqfmdS1zMtD2UaoQRfaiq5mLP0QlOTpilY/8TD
 J4ztu2IWgOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaan5nQAKCRDBN2bmhouD
 13BxD/0YZqo0vRusnBrySJI4j7j0qBvMSBLl9ERMwbH5zZQFXisFq0V0/yim2m6aeuWG3sue54q
 cQyLvmbMOtlHEjhHsJW0gAP7otcp1O0SfR3ykSEKToa0wZY7+zGXm7wnrXKcTsXhcddZj9Ywk7G
 k8pxhlb6R/iKHlXjSedxxBM2U3iicVf9s043yF+9ADEZTF2SsoruyLdMui8TCO60ILt39gQjuqx
 9inYM98ZePPGSQtHGfvmONO7Gu1D+EvkseMIaO+YIhDzEMAJUAmew+WPrK567ES5pxsJ/GIg9ul
 ND9JhEpU12ZAB7EKrHhCcxcFQOn6vDEvL5ZJ4rtl/Ts+C8ufpzL1pVEuldmRhFHjG17dv3Mm1hU
 qG4oztSBnPshts2d6Nc/Y4uayRlpNpeK+7SrP2f/PrWGQdd5KdFo5Iu1uJnwGMsiExW0MLOT2eI
 43o7eDO7M+jC3NfI7za2SVUY8POdUyx/ba5BPcXUmJd5RpRiyOgPbEIZeRhYhkxSm6zNITQjBIQ
 7tVjG3QlahgAPAcbxe0FiplwIwhYBRcso/cJGY5XD8IFB9T8+OH6y3pOed4UM7DNe3E2zT03P08
 8/si+s74GY7hTw3HR+7C9YKGWQeAGDNHcOFKDrfcLEjPqmN4Od/VOYDbfizGIxxbX4sM4VQDDfi
 JSVXiCJBbZxkykw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: q60sbI2Nplkwv3SzhLxVeT7ALg7MCgfs
X-Authority-Analysis: v=2.4 cv=LegxKzfi c=1 sm=1 tr=0 ts=69a9f9b5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=PkD0MmKtpR7JdVUpc-MA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE4NSBTYWx0ZWRfX5PrZM8nDoQy2
 6V7fYvqF4FiZN2g9X2HydMDzSI8HkUVFH/mR/sB3AnKewROdzvcNEBGjcbR5Y2gPdBfReT+NrXz
 1/nHKefzBW8GTAsKCJ/m02/g5vWzKp06st0JrRJisxXKgjKfQ5vmzw6ZfvRLfzedH69db6L26QO
 8k3VUp7lbm9KZTX6N1nCWhRFDsCiHrrrgU1OffGIdWQi8YcY+kCTd2c4pTO122glfUtyX0hA4RN
 P9uy7pQkzGBtnWCuCBCngTeO7D3Cw+GnGOzrnPHj8yv2+gJrSGYD0suza4BDz9KZoGDfX++pB3w
 AKGYtwMPrBTIi5QrNL4YUomTQyOcZeZQcn81etqAbGJQmAeiaxkjwJWOdcRF0mUX5megl/2GpoE
 0QbpOuQ8pN24CGBq14v5BRVECDUN/OXauPR/RepePgGsghYpjeZtovxsk3VX/hoxg56F5Zx19/4
 38NnTQEKaVWp+QZTcOQ==
X-Proofpoint-GUID: q60sbI2Nplkwv3SzhLxVeT7ALg7MCgfs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050185
X-Rspamd-Queue-Id: AA8CD218A5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43713-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,collabora.com,lists.infradead.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Simplify the driver by using devm interfaces, which allow to drop
probe() error paths and the remove() callback.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/power/supply/ipaq_micro_battery.c | 50 ++++++++++---------------------
 1 file changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/power/supply/ipaq_micro_battery.c b/drivers/power/supply/ipaq_micro_battery.c
index ff8573a5ca6d..5e3fe3852d0e 100644
--- a/drivers/power/supply/ipaq_micro_battery.c
+++ b/drivers/power/supply/ipaq_micro_battery.c
@@ -7,6 +7,7 @@
  * Author : Linus Walleij <linus.walleij@linaro.org>
  */
 
+#include <linux/devm-helpers.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -232,49 +233,31 @@ static int micro_batt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mb->micro = dev_get_drvdata(pdev->dev.parent);
-	mb->wq = alloc_workqueue("ipaq-battery-wq",
-				 WQ_MEM_RECLAIM | WQ_PERCPU, 0);
+	mb->wq = devm_alloc_workqueue(&pdev->dev, "ipaq-battery-wq",
+				      WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!mb->wq)
 		return -ENOMEM;
 
-	INIT_DELAYED_WORK(&mb->update, micro_battery_work);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &mb->update, micro_battery_work);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, mb);
 	queue_delayed_work(mb->wq, &mb->update, 1);
 
-	micro_batt_power = power_supply_register(&pdev->dev,
-						 &micro_batt_power_desc, NULL);
-	if (IS_ERR(micro_batt_power)) {
-		ret = PTR_ERR(micro_batt_power);
-		goto batt_err;
-	}
+	micro_batt_power = devm_power_supply_register(&pdev->dev,
+						      &micro_batt_power_desc,
+						      NULL);
+	if (IS_ERR(micro_batt_power))
+		return PTR_ERR(micro_batt_power);
 
-	micro_ac_power = power_supply_register(&pdev->dev,
-					       &micro_ac_power_desc, NULL);
-	if (IS_ERR(micro_ac_power)) {
-		ret = PTR_ERR(micro_ac_power);
-		goto ac_err;
-	}
+	micro_ac_power = devm_power_supply_register(&pdev->dev,
+						    &micro_ac_power_desc, NULL);
+	if (IS_ERR(micro_ac_power))
+		return PTR_ERR(micro_ac_power);
 
 	dev_info(&pdev->dev, "iPAQ micro battery driver\n");
 	return 0;
-
-ac_err:
-	power_supply_unregister(micro_batt_power);
-batt_err:
-	cancel_delayed_work_sync(&mb->update);
-	destroy_workqueue(mb->wq);
-	return ret;
-}
-
-static void micro_batt_remove(struct platform_device *pdev)
-
-{
-	struct micro_battery *mb = platform_get_drvdata(pdev);
-
-	power_supply_unregister(micro_ac_power);
-	power_supply_unregister(micro_batt_power);
-	cancel_delayed_work_sync(&mb->update);
-	destroy_workqueue(mb->wq);
 }
 
 static int __maybe_unused micro_batt_suspend(struct device *dev)
@@ -303,7 +286,6 @@ static struct platform_driver micro_batt_device_driver = {
 		.pm	= &micro_batt_dev_pm_ops,
 	},
 	.probe		= micro_batt_probe,
-	.remove		= micro_batt_remove,
 };
 module_platform_driver(micro_batt_device_driver);
 

-- 
2.51.0


