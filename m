Return-Path: <linux-pm+bounces-43715-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CLGBQH7qWlcJAEAu9opvQ
	(envelope-from <linux-pm+bounces-43715-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:52:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F17C218AAF
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D1D03189CC3
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 21:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C2A35F5F3;
	Thu,  5 Mar 2026 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nr4T+3eb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EESKTbtp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C166035F5EE
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747197; cv=none; b=o5u3QuxMeFzii9caRbrz1Xlg2NPuF9ObCzwoXehKvY4VK6g54C5YP3EZUo2gS8w1nnE4wYwm83HXptGOeijCrym4HDkPqmuDwDvww/W+fsL5tjA9/vQ5LtOFNoYPyGdzJIRGBbVW0jUSnWN6gmStbQm/6c7Hn34KH6SLQZesJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747197; c=relaxed/simple;
	bh=aBbZ3fBywOvpHZwjLuwnPh4cf1hQWBZWB8iOkYD1Dl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aBijfaN4eTWbUTV8TEVfxw8OAfS+kh/YoappPPfbYt22W79vowDlF6nOlkGMUKrMhMbzXghZEJ58jaSZZDQ6EFAUVTOGv+WLqWTesB9H/n8Gy8zcP6uChxOcFuXt/8pfGWyLYGuEudZEfiYepFN15wvWR4Im86THkBJm/5ThkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nr4T+3eb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EESKTbtp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625KmYIe3725930
	for <linux-pm@vger.kernel.org>; Thu, 5 Mar 2026 21:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n4xjjhrcSsGg/B56PKtYV9FcQh+keTvXc9MMcImQ6Q8=; b=nr4T+3ebr1GJrOG6
	oJS1QoImgPAnuAAGCrayURKG6BxlosUfnXUwq/PWK6ywxT/K4BzCHSJlmRScuKc1
	YDLEDC5EdgKDgnHIwOhbJ/ypifKbXb2fXrY1kSU4BqI/Xivne2zrKiU09upW9WEk
	hj8gxxcO8lu5OhvwP+/vBktvBJOdsqEsZ2M6GXGhPExJUogJ4BQCPR12z3cHFnqQ
	g+J7fjOh6uDcM3BbxgUZzqyeD5r8JJhyfVR6c5VcNNIFaFuyIrGZF1RpPoBQNJaC
	fxQ/UGt1g+KdbfOt/8gi4RDZ0HrqA1I61U2/o3j42lldLnNas1910ChS8YzrA/K0
	OcGQZQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq85dj4j5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 21:46:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb4d191ef1so1116932485a.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 13:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772747194; x=1773351994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4xjjhrcSsGg/B56PKtYV9FcQh+keTvXc9MMcImQ6Q8=;
        b=EESKTbtp6tMM2reRdIo/reE4m3Ha/MCYRk0jccHNxJyHWbcRnqMjcPLJjY4BHE79BU
         1ydi4Fn1CmeKRygRjbmsh57sJf2NSW2TGJ40fVlrM/9TVxdajKmCDXR0M5t7OTzBxFo9
         zDyegWmLcYF9NAks+mF++YvAwaXGtLooOLG4drDwlwewClfYd/neWqbcxPRLYEIDELGh
         ZaDBKdYg0+ExwCC48GhqyRuMurocy9F9MeUuGqLdt8Is8D0scijkTtzlldbwopPxt3y/
         kn+WO95oqjxbkqYMJJW8b657+2Xz5ZbdH3P97Urz0A8TwF8YWuaPW4lzK05NuBzsTTKQ
         g1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747194; x=1773351994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n4xjjhrcSsGg/B56PKtYV9FcQh+keTvXc9MMcImQ6Q8=;
        b=ATVP3k6eJTqF4Vfno/x6yk0rzJhav1Cvg08YzIie1rPbELbgUjFNQxBf8H2ZvsZk0y
         MtwJoOK6oOkakMLI7OOIh9+03535kFqTq+V/5lbBs+KyKORNK5oXgM+AOK/Nj9F+QPSt
         Ki7ho1QelQPp7drp/+aUZFBY0mL+wECXHqTjaiDludizQI6pgzkkR35JD95BqEvyAmKQ
         nGrjtfd6GNCYfE7UOZj92ocF0jKzASXtb9xGArae964lQHgXhR1yZg+eB662teovwKL6
         Jz320l842u7Y3rJIGmHLe85I8vbOQD+TqDjCMFiQhVPSwECH4ayNxgP2IAj4kXPqHaH6
         BtdA==
X-Forwarded-Encrypted: i=1; AJvYcCWPSfjRksYPhLMeI8odK7DiNsAUBgPJnSq32sX5IwKAMEuqUj4ftAAYyJ9JJmwnUZlNw9yum0Eq6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPUowLwbNKPOT/L1qk+yPJrzT/Ce1p5g/f2JITouGKEONZUwM
	BCbampVHekgrZ91O4nIK6U+nvjnRNd3lmPnGDtG+PxhskPCL6+cf5hTrrF0WGcS4vw+DJXaY7e7
	ERTGwMqEUYzjJ/QUe4gw6cHw0rnxu9/s0BhsRogGyeCEZR3rjEwN2oF0yRe+CJQ==
X-Gm-Gg: ATEYQzzOP5oLKMrstunqSF69FGVlA8VgUJaFtIN583tQDORnmVu9xXzSb1vq2fX3Z+2
	zf3UOVcgIS0AsM4hSQTywi8IPGbxC0aCD+3hwjChz2+O9Wd6jEmQzTwUnMhD2jHFMitQaoWrGYA
	g25laEazyhlG+H5G4QwoVrTc6aSADDPgdr/VViu62Hg7SLlgM8VvMPQA/8chzoPSxYVVUVC78X/
	uXjyNduMuQoCOwb4saNN7W7Mym3evE4ylrZzPQ2/ucMpsD4G/s6g0JkkY7YFakOHlEWuAYsfTcc
	RQaUnGkL5abNcN8oHxCEulWXSTUsJ0gBn6yN0bmSXbHuFIfbcvt5mcxQDTCMzkLXh+33Jke6C4R
	GFf8yQ/EkwMmmyxSHhOl4tmeaCGIOxR1u5sKCnQnlSuqo
X-Received: by 2002:a05:620a:2806:b0:8c7:9e6:3a72 with SMTP id af79cd13be357-8cd6d31f36emr6488885a.6.1772747194119;
        Thu, 05 Mar 2026 13:46:34 -0800 (PST)
X-Received: by 2002:a05:620a:2806:b0:8c7:9e6:3a72 with SMTP id af79cd13be357-8cd6d31f36emr6484285a.6.1772747193616;
        Thu, 05 Mar 2026 13:46:33 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a58dasm28571575f8f.27.2026.03.05.13.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 13:46:32 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 22:45:47 +0100
Subject: [PATCH v2 08/10] mfd: ezx-pcap: Return directly instead of empty
 gotos
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-workqueue-devm-v2-8-66a38741c652@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=aBbZ3fBywOvpHZwjLuwnPh4cf1hQWBZWB8iOkYD1Dl0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpqfmfZyTBQ2+zfg1PVbm//IV3ttzRuDFXfJ09L
 Fi7SOtMm4iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaan5nwAKCRDBN2bmhouD
 13yRD/9atq9XS2gdzOD4iwNE2NzTH/fSxgzEasdtz+9zZKfFoTpfnxFWtJTbN7SumZgig525A5R
 VdZmzIWGbcYZpE3xAn4xsvjLbNB8/GeTpJ1kt8T1rcPPpX94dr5Ht/K5pRdjnVycWFPiKJXtfcA
 iRY5/XOeIZEhXpU7ClLZTrejxnGjsURe8r+u+LlmWrGlfT4VYT4yepmb5E8OIVDUXnlKFEepRKQ
 WYPZ09Oyl21MABeuojbxhRPxzoA/jzjdLe+iCBVzlFihUMfiFrrWvfX872J1GXClSLlGaYFGLeA
 VYOoHJFuO57Q7+4oULKXpzkUTIexLmRp3dGkkprPpzpR0q6+gCsLVeSHJfIl54kgDeKlSJVa4tP
 3tx68crLjDIkHq147LN+7Nlv1yacTQ1Drn3PPXGsOwNHTmOkKt6eoO1tJSU8dItyVB3VdAVUtW5
 YLK5tSgOKhSGndBJaJennrnsayMckl9rhJer7AXlC+sKZ31Ii2uZY9DFB4tGUXtmtDRpX+Nnw1u
 mTECOe4Qt/1YAn962XvbBJjzoZWliJdxuREn2dZiFlamnSKzxS8Tk9zX12OJI6nHFFiZNZESZ3L
 13YIinDTo1FuLh5Fosug3FzrBQlUb6CCIR4714nwcgAQpBhwwMlKDWA4q46CeQ1kxUm2ocxmk0m
 CC5zMWv80d+IrUw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: yL-4bflRUjA0OycLhT0BuvwKutcw4X1t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE4NSBTYWx0ZWRfXxJlEgf/E1PiW
 9ViC1Ga4tMhsuB1J43hlDM6Jc6wP9mryr7wBxo4q1owPszTJPrpfHRDGuVMcfb+PiF9DKj9ofMo
 /9yHZsdMvzkE2x7gJWoSYk5G2wgQjwNexgtBhLZFpEuV3jFWQBOp2CgqHstU784nMhi5vPkC7WK
 /jkGSpXFM+eqwCKcxyY8twELOMUQrvOa+TEhG87AkMNQlLtRw2XpEIz9UrYIEQBqZUHDVyCLNAQ
 fSbc2+4vdsC5LnXgUnz0R7Qhdo1uw8lNgCtbGSNDt9g8v0l4AWDGXKoqEy/FE0xj/ANJIw6Rlo9
 ort7DggHNgtgMME33GfeY72v8csCmNp5uF41030en3hhWDPTKqOk/UynYhl8kIlLSFfrtlE6gAb
 4avxUlmz64+DjZ20BsxcykdSBwHeX6/BVYY+gZDGu86MQoQjwg9gQmkPufA352LCm5iNJIUJCuI
 wAgeSD61ySjUc52ORLw==
X-Authority-Analysis: v=2.4 cv=aOb9aL9m c=1 sm=1 tr=0 ts=69a9f9ba cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=VGyNsPSQNFFz0_f43M8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: yL-4bflRUjA0OycLhT0BuvwKutcw4X1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603050185
X-Rspamd-Queue-Id: 5F17C218AAF
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
	TAGGED_FROM(0.00)[bounces-43715-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,collabora.com,lists.infradead.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
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

Code is easier to read if empty error paths simply return, instead of
jumping to empty label doing only "return ret".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/mfd/ezx-pcap.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index cd0520a08224..8e51c113a320 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -384,17 +384,15 @@ static int ezx_pcap_probe(struct spi_device *spi)
 	struct pcap_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct pcap_chip *pcap;
 	int i, adc_irq;
-	int ret = -ENODEV;
+	int ret;
 
 	/* platform data is required */
 	if (!pdata)
-		goto ret;
+		return -ENODEV;
 
 	pcap = devm_kzalloc(&spi->dev, sizeof(*pcap), GFP_KERNEL);
-	if (!pcap) {
-		ret = -ENOMEM;
-		goto ret;
-	}
+	if (!pcap)
+		return -ENOMEM;
 
 	spin_lock_init(&pcap->io_lock);
 	spin_lock_init(&pcap->adc_lock);
@@ -407,17 +405,15 @@ static int ezx_pcap_probe(struct spi_device *spi)
 	spi->mode = SPI_MODE_0 | (pdata->config & PCAP_CS_AH ? SPI_CS_HIGH : 0);
 	ret = spi_setup(spi);
 	if (ret)
-		goto ret;
+		return ret;
 
 	pcap->spi = spi;
 
 	/* setup irq */
 	pcap->irq_base = pdata->irq_base;
 	pcap->workqueue = create_singlethread_workqueue("pcapd");
-	if (!pcap->workqueue) {
-		ret = -ENOMEM;
-		goto ret;
-	}
+	if (!pcap->workqueue)
+		return -ENOMEM;
 
 	/* redirect interrupts to AP, except adcdone2 */
 	if (!(pdata->config & PCAP_SECOND_PORT))

-- 
2.51.0


