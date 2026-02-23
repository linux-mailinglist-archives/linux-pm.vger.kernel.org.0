Return-Path: <linux-pm+bounces-42998-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHbCFpYCnGn6+wMAu9opvQ
	(envelope-from <linux-pm+bounces-42998-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:32:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DCD172B5E
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 992933073F55
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4381734CFA7;
	Mon, 23 Feb 2026 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IPkQwJkV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PrO/RMIJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189234BA49
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831681; cv=none; b=QpXQaqH72AghWHw/OE8xHNagqNwfmcs56XMW/ul5UoRHAz1gbwSKDe6euzCcxmy7KLoMOUpqzIIPPeYc3yK9SGe9iuZiFyp1zDF8N3UWHaaEc7Fp1RcVGvTea8U5N1e341x8EMqSN3M82X6Cw+wTF/Hqv2712Dl72yx4VFRIFg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831681; c=relaxed/simple;
	bh=G2Qaq1IYTDtA8nYq8hb67ozAR45iYXNAROMWtKf03Uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jMiS1opTCFtiHUFXudtkWvS3HdpEZWr5B4HAsjIgB9a2+NENlTj32LlwaL1mxdS31L3MpL8YewCwhg/KG7RdxCP+Z+P5mERBACJi8CumIZ6rUIww2lC+qNqXMBXK7fgha3UEGXasS4/ho6Tj8cCsR+gC08b0DbGqrXbYcWjbRmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IPkQwJkV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PrO/RMIJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMHd5J1871263
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AH50fw9QTtdpPbt41EGIzTuypwuiZyQQHwG7B4PGWqg=; b=IPkQwJkV2xswGPCh
	rc3S7O5B9GNV14vX4IX8goHyV0CQK1YBxQHVtKRzM7s59ilh+7WdzmyNwk0bPXo1
	4BtOGKkxBBhQecc+toLDIAgYgKgx5oOC+N9otwEZFgVfHQKJtSlX9txYMWJQJHxD
	xUHTNr7LClPUIZveXVZbDiFmTfdb21XbH410rYJS3nv4+71vAyTjwE8jCfPA9ziA
	b61Lq5jOuNoK1GnE5TKO9/QABCXAQPfFymvBkzuQlukp0j0gJb4u22iIvLXz0rHw
	f9xG75AOu5gdH4B2LSoLOVXpfvnCRMMZE/DnZy3j34HbXdOgUxLXgx54prbFk90E
	yuSbgw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wbbryk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8ca3ef536ddso5007261885a.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 23:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771831675; x=1772436475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AH50fw9QTtdpPbt41EGIzTuypwuiZyQQHwG7B4PGWqg=;
        b=PrO/RMIJUPw6eGWSAjUIvLqS17ZSwo7HJ5FkWOxkLQGI7rW+nlIUJWPAaXc8zUSaEN
         8i19xNX79qcexlzBN1qRmKFBQJxjlqUPskYQ9nesteGhihc16BcdhNnjJLF8Q7gwiLgq
         +aVpxmzBVpt/yBjrVR4FVkOyLzPwFDikXiMsuPmNfnRdM9V+bSSp60Klb2akACM5LgFn
         +K/Bt3sIWOogAw/Gu9XeGCyZsdcqNtqOWntNbEd7HTfwYLlEstQILqphnt96s5k9FpSk
         E5nl8aDSPqwhb+Ztr2EQCBH9zBTDu/8Rq0KPa0dfNLN881xHcDo2hmG7Oopsz6AyLMov
         pokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771831675; x=1772436475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AH50fw9QTtdpPbt41EGIzTuypwuiZyQQHwG7B4PGWqg=;
        b=I0va2RPiUYzN3GLG4xBuqN0Qw53cpyMnqDx0EoiRQNURoPs4FBJn9yCzi6APVv7rvl
         XcwoHloN/cUvTwa8w3Pf7WTW60rYxmfUr8ViTWpB3n10wDdlAFxsfu65RWBeJX49o/9n
         kzLxL3dqTG2nlG9LfCJKxeT4/9PMU7NCbmVp4YkS5FWpJ7o7xCH5Zyt4iRECub0Jk3h5
         styys//UY2hbs8ot/YQLOl2/xCXIJItEXG3Dgv4dHfg/GpWfDKMWGAz8jsyzWSF5mn+f
         tfIU50JMA9QgBy7EC9h2XzofjPF9x75jrCpnCHVLuPnMbC7XC6KRKr5ve64w1k5KPhnT
         9IoA==
X-Forwarded-Encrypted: i=1; AJvYcCVZHRM+oM2dCeq37UMzMQV+9wwsu26uAEH0y0kkLk8WjlqupoOnEL5GvwQtIk2Jb05g6QWc9NV4yw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr5yYjJHI7JV9yZ0Yb1XZ01cl7ZSNNUs2lJR55f5eTwbq1ieIE
	mavBEAVX67gdekDEhfwzd0ZUkLjY8uhXYaxq6O+Vi9pc4xrHYDBoQso56CUeR/oi8OosnKkCdxh
	vAQatE0kihduNocX9MNCwOv/8Z8fkZ3evcZfuyGwSeI3Mpl6T8F9Yr4ESLScSoWhTNRvMSQ==
X-Gm-Gg: AZuq6aLrxD1/QzHd4kmh1f5Cz+q0KRfrBOjdIx/stlbxC45ChU/IN+PNz+ZVHoSBhxX
	FOWLpWWV0E/5TjtLFEqJXkaSC9J0g+g64rSDeDIG1b5c3VjoLDQPyZke/u2xracY8fNJSyuAcwr
	g51PpRgq0aUj3pcFJnjN8cVLFeRVBfwP3+jsr7va52KFGBPg5h1H6KrCQxb8wcuH/zBrMDcoGkE
	33zT/WEXNSNYvNB6z6/6T2vU3yBHwGUd9PsmptlQrFZMlmNOEOWLGRIiECHy8dNaHxtbcbZ52P5
	7mqiqUsLcxHmfLoJWsTxP7ZuRY0iAuwHzC50znfsxovG700p7hk3tK4ggTtF5+A5vt26eGqjBWC
	lYbNlMQ8wDNtPz6d5g2dIKRe9sJKURjBBcIeZcygOoEdBxQ==
X-Received: by 2002:a05:620a:25c7:b0:8c6:ed3d:be60 with SMTP id af79cd13be357-8cb8ca8926emr880335785a.71.1771831674940;
        Sun, 22 Feb 2026 23:27:54 -0800 (PST)
X-Received: by 2002:a05:620a:25c7:b0:8c6:ed3d:be60 with SMTP id af79cd13be357-8cb8ca8926emr880334085a.71.1771831674487;
        Sun, 22 Feb 2026 23:27:54 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9ff5sm18550286f8f.4.2026.02.22.23.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 23:27:54 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 08:27:33 +0100
Subject: [PATCH 5/9] power: supply: ipaq_micro: Simplify with devm
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-workqueue-devm-v1-5-10b3a6087586@oss.qualcomm.com>
References: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
In-Reply-To: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
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
Cc: driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3021;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=G2Qaq1IYTDtA8nYq8hb67ozAR45iYXNAROMWtKf03Uw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpnAFqVbGd+Oyd+isBnLp3Irn3IzZIFzgrOBn+8
 5TEkaEct86JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZwBagAKCRDBN2bmhouD
 1/PbEACD32lwshZ2ZGTfWR2j4TEzEqcr5UkWKivQj4l2BDJ3b0cx3v9UXC+uQpxEwQRsNqj0BvG
 I1fbqNt2AyWmkGgU5CQ/mctWF9CLx35r8IK/9NdFjOqcFxht4uwjb6upeBsp+J9Pv4HEfYA0wAN
 KTA7ic+gakOj5ORF0AX0XB+z9UwqeB8IbQrIH7214fJQfuMgYgOooGihxSqfiOsUPuOZ9ls5/dM
 epmwdKvIbeyOiwRprJ77lkVrp+OMFQXa7Z3PUu0SZkkyFzbd7PZxw1z192ZbcfxAarusRPDYPy3
 wg9eYXwcNtW8bxgrkKEeFuuHIQYLM/XjrlvnAGGRttd3REFDczgFmq2NJxW17OOVDZeYCMfKj4U
 x50tsh+z6Y0ziwp0yrkLamVu++cpOHEeoets78gt/cg4eSkEFdA7Bm6o1PBYHVqPrYUMwYO3uzw
 jTyOPwQM3T2UT6UB95Cz2t5+dDzKC/lSPReC0bsI+qBURe6pUl4SOcPr44WISrvlDFn+uxccMAP
 cZ9tGiPuZpEGR4H7DnWR1quOQzOJwWZEQ/EbBXRzQS0zF1KAcc0gxH1sTluqtgGKh/1LOGDmNJk
 ILB2rMYlea2r74+WwfmYhcO0zntsIz41R1A3mBVMXjAxQHSN1RCq0uN/1cASc2WbfdgyvfjfE/z
 84W99rJwWh793pg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: rD_FmvSnxvmOE8KB6kXW7Bk3-We4i6ln
X-Authority-Analysis: v=2.4 cv=UZlciaSN c=1 sm=1 tr=0 ts=699c017c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=PkD0MmKtpR7JdVUpc-MA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: rD_FmvSnxvmOE8KB6kXW7Bk3-We4i6ln
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA2NCBTYWx0ZWRfX3MMuVasxzgF6
 wTrceKdEpI1JjRx6GwtzTPrDciZ40rZheU9rh3JoCVZTXQzwLB8VXZEDTUj5XN30rwklwmVRyxj
 7gu6XobMo0A8fAtM+eTLQTTZcaHsgJkil1KJbAU9ENI+ZtoJl+anDBfnCFvFcSGPsX6KH5DrOeT
 EAn24/oVI917eZiOc58PBimewNOTbT19L0/gdLcUgdwRFTmbq3zU77KaRIJ1wD0AnaohxdUzft/
 ewG5ga04aVjXIdjSepdLi+LL3DiBqSsOvp8xNAAewDgMQ00gSChQa41zdcxgINvEqOvBBpMXCsT
 q3p5yw8QU0na47HD7/O7sLK6IRp9xV+JqfzAoOqsFLbD3Z9HX9nLSFy7e96WjlPvCnFRFoVZI/3
 epqmtUwQdhKoS5tNzHYzhPAsJnjW400A9Fjk61hQ1lR2tn8k/7mBUe9BPg5Oo1TlmfaVFxSJwyE
 gYxyCLSyDKs2Jvf71Ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230064
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42998-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B5DCD172B5E
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


