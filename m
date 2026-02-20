Return-Path: <linux-pm+bounces-42950-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNu5H9uemGnJKAMAu9opvQ
	(envelope-from <linux-pm+bounces-42950-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:50:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3630D169DA0
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DD7430101C4
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32FB366566;
	Fri, 20 Feb 2026 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bhu1xkm9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RuCLHaFz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ACE36654A
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609801; cv=none; b=acALtJmmqZnzmlFfPvR/HpErYLIEv7S6E7u8odMPuNm9pnrqDS3L+pt/xoKHdD+ehY4SWjHJ6WqNubsuS6tnhWXGs1j/qgWWIYAbkKW7gOpgYt77IegA3yF78E5YHXI1ZH9LmIvQnxK7C0iSQOMbGwJ0a7jYRIoVfuWXUhQKmVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609801; c=relaxed/simple;
	bh=9OhP4drx+ZLT599fYCtdePi5TUeVCQS5ByZXJPIBh9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhpSVQMFiX0rkhj5E0i9wTkOZqSzE0EiuunWipG8du1GyEZqbnW1C2rQLZxz4RK5BkuHjZR1cE6GOGjDL1IWefgJ/dMzrJFrUdhx3wQcciuynTIp8OQbFC1VewIJeltZ12VCby2i2YyVAiV7u1hgj+Mecfg7bciR/dsGpHXCBnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bhu1xkm9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RuCLHaFz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KGL2it1851326
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TMqmm3W3eT8
	CeFb5oLw0W4i0/QaHbnABHdnWM8pp/rk=; b=bhu1xkm9kginlpHXm+WQeBpu+DH
	xn9Q0SSMfSVxCl63U0PPi2tlEAo/0WAsOHmOpwgaGqDz2ZHdDt7nf5ZAYXLxS/ng
	f+iWU3xYF6gTaDsBpRjn1awIuFUOqo/rPEfvIHF4x4qHV7+izERXAAQMm7bvtp/m
	PFqy3ICcJdjYTg3UfbHNnOnKc8BUumL5Ja4goShqWremDr7z5pbPoicx4K7JrfOg
	fmj84iLAlD3Wyc1Q5tg0IXCaCmIP5RyKAdwU6ncZZLWkfLDdXxA6SJ8Dz+plgwjH
	rHr59llR9gQANH7oSHhYscbv8s77Zg+1+qdlLlukcspYpVHHI/g+xNEcouQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ce9ngayxh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:49:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb3a2eb984so3190786685a.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 09:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771609794; x=1772214594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMqmm3W3eT8CeFb5oLw0W4i0/QaHbnABHdnWM8pp/rk=;
        b=RuCLHaFzUztqERl1eNYMhDJk1l0lOD1QoFDovp6p2B2Z912SEV37uhZ/2XUPsC9DT3
         B3fNCatZk7bvEVRgXfyAE/O+blDg1OE67ufAt3FdYdL/eZrEGpuZE/+W2MoQsi6/Gy5s
         9w1z24viwu5Ivgd9Sf9Wajk32FSEoaOIB/QkZNFFAMVy5P2ybsm53BUp2kkpE1NW/fXV
         Xy6DaEkuZ/vRxUU+BOBjBsD34ba/KWL9VFdjPo6l+34OYhyGlGvmEto78/RSnnE/C7BL
         oV8qW8tWJ9j3QUmkmXMfb8OmiCqFVjQO0amt+IMWjb04U1k1T3C3YN/UL1p8FWZWpePj
         G92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771609794; x=1772214594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMqmm3W3eT8CeFb5oLw0W4i0/QaHbnABHdnWM8pp/rk=;
        b=hhKxbezcyzfg6m3n9ckrLdkYX0/1yoXRO7n8ckCOTbFem2eJUopQbbbppziXyao352
         KxyzSAXnWyPtUSATN6rd8aBjt0DWlJc5Lktpq6eV3jUx1PdXBxq74D9cgP5fkd5Vhwt/
         djtlh4z7CbCDfRWmPCISvvEfCURVAVkW4l2Hd041oVDY27E5ZCHnAm1Z8f479KtDrZwX
         MzOqNVTM0wQMWptFe3OdJh77DBcLfiY5mveE5g9ww2RBRogE1gBFPQpPwKy2acS5l9rS
         tD8BZ+AkrVUbpduJMO27tvnaPUeKlthNtfQ3DHKmLgeLN9395m8taTqWpzVneJP1+rjD
         CkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnd9E8kN58yoroaokwFJwMTZsiY3qb0a5f0ElmskbpXVDmGXod4YjAxM5OwHukVurIv+aUVJR1qQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2b3eRtTDSFC0LLtO6zxDTzCp6mcKlh7Tu0APIUJpynLpLP4X+
	7IvSflN++4/e0tf4AdKZn0D1gaRBglsPPN3hm5WxBvvnfw9W0oa1EOAGrAkLIfhdZeMcg1Ly/1t
	sV3FNyqBJJq1AQnPKLQH0loVyJA+Zr3i7EEyCm06rmW1hsY6xqILxs6Zmddw/wQ==
X-Gm-Gg: AZuq6aL48p3Ef6SXwI9gJqpObb/TINkVsN5hJfv+rs1YG+Hrit1nNTXrmyDuePV4iYT
	G8M67o8+oBx1ZAFxxDacy3fhG/j6zCGfWlvFiFERHFwvd2ecb/WB/irnSPPDiScWprYhtB68gP8
	4TRcCWR3bBsoKJ/W15DgId4qefnrJx3oZHgZ0D96hmwPPd5PagqXfbp5qAxBPhUcBwAosu04rYc
	pveMs81/wGDhYOFezYaXUgxiCGh1KazU2II8qaiZTiriOgI3qfwlZRces9+EPHlQ8tnq49AGM9s
	2wlfeworr2rJf5mAe/Mwg2l1tyHi54gYxtJlufxfKtrU7aPRjfJPF6HHjKsV4m9xscFRO1aLn62
	m5VQLJ/mvyPx/tI0gjOeCr0pZ4y0Jxtt4pfV1Tg==
X-Received: by 2002:a05:620a:1a85:b0:8ca:d5cb:6839 with SMTP id af79cd13be357-8cb8ca7fbd7mr41122885a.65.1771609793910;
        Fri, 20 Feb 2026 09:49:53 -0800 (PST)
X-Received: by 2002:a05:620a:1a85:b0:8ca:d5cb:6839 with SMTP id af79cd13be357-8cb8ca7fbd7mr41120285a.65.1771609793509;
        Fri, 20 Feb 2026 09:49:53 -0800 (PST)
Received: from quoll ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6a5e5sm54071940f8f.9.2026.02.20.09.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:49:52 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 4/4] power: supply: twl4030_madc: Drop unused header includes
Date: Fri, 20 Feb 2026 18:49:42 +0100
Message-ID: <20260220174938.672883-8-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=728; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=9OhP4drx+ZLT599fYCtdePi5TUeVCQS5ByZXJPIBh9U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpmJ649+Vmb6wz+6GXGOcQj8o+yEo5NWVbMIydV
 DD6r62GDHaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZieuAAKCRDBN2bmhouD
 19R0D/9Y45dT8J3geJvxLSiKfC7ouxskWXCpG+jscQnAs396xVAOrxMe/OrOK92sH3OncRnqf9e
 JMfIQ/pnqMnPlyQxAvW0lj14JG7u3KP0awbMDyj1mdWvIltz8FczMxaZOelXH27w5t2h875DhFu
 8jUTID/fp+Lmetn9RycRRxGqPJPyzaqH4574mCAYqC25q756XMh+Zbd9a1pp+OQHfkQOhOGirL8
 Q2k8mS5Xxa2D2+gMvd1q7WcFAvSesSpTtSuAsbOmcTuHC+fhI6sYwlLAyFvVGa3l5XvAZmSOjvf
 BYhOlMNL2PxDHQHFD0Go6CVpazGgfa39UDTYXhXGDNoFiyA2940vGl6MWC19rBWvq2oYbn7Jzqh
 byX7/ckWf+JzjaqyK0FYsZ4CKYBzE6cbodq0QsZJr28O90aUZqafvYHcAfKSCL5/90NlgwgukvF
 C1V2bUVyIWOPaY7ArgTdaAapAXjoxior5ZQ598WdtffnN9rFKROaDG1CxTmnHiCRuqTPA4ki4WJ
 A720s3V8Jd3/pOM+dscnpQPQrr7zl75jISDF+RnBMgPwSkD5VpzKGGs/xwhjZsUPxvJBU6OJNn3
 bys7hwG4agOi/KFlcoxKMaa8dNCG8UcCmo5ycwF2aGo1mFcUzf2Z5DVpXS0fSra5zTDX1avzC2w 5B4eOZgKYQMYlzw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MiBTYWx0ZWRfX346L8zrueDPf
 c3+nCWP0Zq1ZxsepzSJCecdZTCLp4Q2bTKQUf6SHByGObaCWQyWEiLYDJay2MxCwXd8ugrM0sEd
 sYrTadTugVgDKDhYnBIwcHgN+43DG9UJwpKbErG76BdT9cRfFXaEFNM6tn/KIZ6ETxDusT8Sn/S
 H3d0udVZNCfmto2LI9ra6Uz9Nb1y3UEnMR3yK+Xcond/Df3yBrnBbj47VWzXcfIe0lwHvBytKdD
 3RO//VxGjYl2UtN1zNYJ7ftRbpi3QxM2HeBOze/qWxNk0AUpH3uxYgc/BRE+9tQEmvb3rhrxFKW
 wKyjGVmw2C5tl2OG0e61DeklJVOGfm+z2tLWndkgfr2sGI+1289BHT/TEoBMPpvb5jnXoV4vVbs
 LlvcuuwhUrTUDvvrdpl2jrlp8CWl6T1oyZzxOFgxwGYenAHJ/qS+w1VNVPlRSZ9iNdfhne8BcUR
 dI8setBUeAifRDpFUAw==
X-Proofpoint-ORIG-GUID: hdgwcHyBIr4ElBChI7_GkIqkEZ3dgPvq
X-Authority-Analysis: v=2.4 cv=Sbj6t/Ru c=1 sm=1 tr=0 ts=69989ec2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=V_1ONkZhdB-HRgfDaDkA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: hdgwcHyBIr4ElBChI7_GkIqkEZ3dgPvq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42950-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3630D169DA0
X-Rspamd-Action: no action

Driver does not use any code from workqueue.h and param.h.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/power/supply/twl4030_madc_battery.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/twl4030_madc_battery.c b/drivers/power/supply/twl4030_madc_battery.c
index 3935162e350b..a99b3ff26929 100644
--- a/drivers/power/supply/twl4030_madc_battery.c
+++ b/drivers/power/supply/twl4030_madc_battery.c
@@ -11,9 +11,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/param.h>
 #include <linux/delay.h>
-#include <linux/workqueue.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
-- 
2.51.0


