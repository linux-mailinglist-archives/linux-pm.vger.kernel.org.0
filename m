Return-Path: <linux-pm+bounces-43710-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDGqL7X5qWncIwEAu9opvQ
	(envelope-from <linux-pm+bounces-43710-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:46:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EE021895B
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6035302D9EC
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 21:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFE335F19E;
	Thu,  5 Mar 2026 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bKCS2POP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RdjIF6dk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D4235E940
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747184; cv=none; b=jBCemMfUPo+Frwp808JMwhHw7gJ/B4HCaMltUqbdZqNyAJ8T8tMUfNXlBtvs2dzLJ6xN17i8zRhwhNCOWiY2G62Hm3kx3a5KDyznuVnPBiZo2er68V7gM6BABIuSSJRF1KlAcCO7ITTD+afsFJruGZPHnSd12ORkSaKAGXXrJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747184; c=relaxed/simple;
	bh=6wTg5DsJ+ATD7iLynQ18x4EJDM0BB2ZAPMsN3b8NZJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBcnQOHuIbSAhJ4cvj75wzO60va/8iHR7R2HPMtSvXZ5jC8PZk+MSwOz8yaFlv4j8FtAz8kfZhYwJ0JBeTJLbU7HQbn4KrjdneUFm2E8TKmVV+iGMIwkG8JokcgCSSqcogY7qt0rtDH1VrbH6VdR+6ClzyL0Sd4S+MQeN4mz/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bKCS2POP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RdjIF6dk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625Kn91O2269827
	for <linux-pm@vger.kernel.org>; Thu, 5 Mar 2026 21:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lmkUTSqSMKdHAfSHvzXCLPeWkagFUCz0SlNEC6QFdTo=; b=bKCS2POPMQPrhHTk
	ngNEQyMtdSUmID1ke5PQnDAWyP62jpHAdCAGQ3Rlru28IR2le3f4V/FpLO2n1OQm
	cMEG/XkRS4ik+VDEjHAlj3RMPaUE1GYVcEGbUy1wtOhDdF0n+sueBWvOEY5tn+fK
	YsXx2uEnAFpLhBX1uiUGNpRMLzjUq++idIRis2YSfm3ulhsiDpsQLOS2P1GdAC7m
	GSzaAJGqpZpRcHQsXXk6dZjKo1iW6zpEH6ZACe75dKr7H122JTczXqU3o+Qszzbd
	Iv3WjqUH0Zbam5CljqlClCvQCvJjHeuzykxsgbwm6k8fUfxCAgddNktl+SoLAnp5
	dPt6sw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq380u81j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 21:46:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb3d11b913so4848717585a.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 13:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772747181; x=1773351981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmkUTSqSMKdHAfSHvzXCLPeWkagFUCz0SlNEC6QFdTo=;
        b=RdjIF6dkbg7rl+eKkgvGhqshIRxRDWxxFB7QpQogtgEn9M5lgfVp9/Q10Z9bQwaY7f
         UdgxGc1oiu+O37vk2sRMRjIwjhVg8TYv2sKnCmfZ3Qilgbetva3zTaKsUmMrnYWkl50d
         OaXjx2hJMOLVDiXvRA7MrKSXWjuNZ6+p3MdvfQAkPsBBrjm/UNScUzDT4RLH9bw4IXSe
         OFQ02xNmo8/D/7nJJDGlofZAV9Zl6Xv4UQkNFsZeV9Fw6WqtksQrMQHH9Xeu2/4KPQK9
         vG63w8h8QgBTOSEA8i3P9+ri7yUpswYPUhcIh4HcAWfxnrbEwYOn1KWUOjLsGTFowTCs
         g1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747181; x=1773351981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lmkUTSqSMKdHAfSHvzXCLPeWkagFUCz0SlNEC6QFdTo=;
        b=rqh+V+yD7UB6RwQuHyOeGpNOpbBHYjcLTBHII4RSh/syCPQeOlHygo9XBxgC5aY9Ub
         EIKzGSPVQrkhMEvjDClcfe7Hj8Zy6dBBimRNk0KHVMxfpNdC/WC/FpsrbeHjqYEdygRd
         0u84w5LT5LY5XCDIG+AjXtQu2k1xq8ZCMRJCYPw0Sb7nEBf+nVtlhP5uTPoX+MB0cwRO
         uZ5NobM+qRqrlc8UaHbg4n+lq6+i44qfa/fUQJyBepOHyngxns+xOBMgVrZQOhKxnKb7
         jHVNo6txveFW14aDMss3XpL/FK1suF0N+frH8FGl/fihOdUf5H8oeuCtnepODLNm7Bra
         tfeg==
X-Forwarded-Encrypted: i=1; AJvYcCVePHLXZkBNz/emdY3hZ/E3ZDkQDhbvobkqZgmucbOU7GI44WEXq7h2C3CbW7smuwkVPplKjv7Ipg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQ6Yk7763ccTjtt4VwcOyXgpGSFuw6VlQijnapodwgxZn35Tg
	uand0fPtuLGmtez988u18HxiamMaNXFwFHI9tk2tBHzIPLq+ZmywSlpPcJpvNggXybaws+qY9lH
	olEZxQjBYTEqC87SpL9F4ZuYgCLIvYqGK5Dmwi82bn+YKAN4/ysWG//dD62KT+w==
X-Gm-Gg: ATEYQzzMh2rC5rkfiMyVbanNX5cw8xksqDi14ZkIwn1m7rkGwysQoxuDfbdg/W8KhLZ
	iG0sSvW2Kf8IJgZHca+EikiT6FpBEtodCKRYCZ3A7/hO4+8NavGcbic/nJ2Q7sxTb4/ohatoVtj
	iklpH1L9+incHqBfiiaW7157Ej5uX8QSL4/c5pSJQTxCIDXH4vOS637nkozXlIl3EPo1hZbxa6c
	xgXoZ94JDNMIM+PNI2jG7hxHdTYoPdIWIpg0VyapfZRHb9hgsNzJD9bzFSJVUZLVL+ZyPVq0UBn
	5t+Gl7K6g0qLNJTdVy5VpixL+Kkz2wP6sDllmyE/HADENSURqOLRWzQWxcfMsGrIduNolZujpMh
	SMRAuNpO1ZoCzflVIe8spUJDD4bhyR0Cq52i8kbiC0p56
X-Received: by 2002:a05:620a:4494:b0:8c3:598a:2956 with SMTP id af79cd13be357-8cd6d3966bamr6925285a.33.1772747181600;
        Thu, 05 Mar 2026 13:46:21 -0800 (PST)
X-Received: by 2002:a05:620a:4494:b0:8c3:598a:2956 with SMTP id af79cd13be357-8cd6d3966bamr6920685a.33.1772747181120;
        Thu, 05 Mar 2026 13:46:21 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a58dasm28571575f8f.27.2026.03.05.13.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 13:46:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 22:45:42 +0100
Subject: [PATCH v2 03/10] power: supply: max77705: Drop duplicated IRQ
 error message
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-workqueue-devm-v2-3-66a38741c652@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6wTg5DsJ+ATD7iLynQ18x4EJDM0BB2ZAPMsN3b8NZJk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpqfmb4FqaUPE8Ufhusp62MvQj/z/BudC05PFyG
 lRWQHQ+flSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaan5mwAKCRDBN2bmhouD
 18oJD/0TgRoahqQolkN+HXA2B7CERLNPQLecC5FxtW/Y0TeM3mpHkMAh5y1xBix+0e9BayIEkGg
 SMrEr3kgC8I9FEc8Mc8G2UFY7AQpAHuFGmjnjIhj9YCfgJaOB9GLUtsDkzip9AjWYMuEPNdg0hH
 N240sOUOBCgzBgfGY+5U8AHaK7JKZp4nA257ZtiwWR/9Ua7KEXVvyXL7KujZzgWoYIY1H3CJ+p9
 T2MII1isUfaViTmqZnLN/EDTeHMwvh2SUwRMBc0x+oROHzkHmx7GkhwhXEFpFaQlJpLhHdM0cr6
 UCteNGZaYTAhPBNZ3Iwwg1g3kHUQpAtuxMGI6wP2TM2T8thzx0lOP1vpCHoyAKS8NffvVE4Cnlk
 LJeRT9kzSPj3mNfW2tQPou3NDRouDud3eSUX7dHRCsKEgWH94aGzbAGxyuCFcq/tWFl2XXBOmfm
 44H+Vcs8ff43di9cK0YWiJtn5Sk14hXiz1sz6bEFr/nKpKDdCiJw5sSjZF3+ODc93BsQWiJXlsI
 8T9NZ7c4YdS+9WfiGvwjRTTPanrmNmgtAZXQEooWvgiGwxRPaR1whqMDEtiuFeAauioOIxE2eQ7
 +MCgY2ay1ZTUSZ8QjJDAT3LgPa6Dqw/0s4NcwNpP6zqW+ya/JiSa/HNOPPnTzOt2BShhQY/QI3E
 YavCWFWns+RI0Iw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=I5Johdgg c=1 sm=1 tr=0 ts=69a9f9ae cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=e9VCzvh-DsFqsbzuLP0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: pw3N-xLjgn4K_6Rxd-ZT3kseluhk0GHN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE4NSBTYWx0ZWRfXwWJUc6Fs8eos
 fLSbo9RvVJNbue0cNzDVDEocPAcU4BmK4d5CO18ajdlBd6E7QD6HSqH4VIrq0kSQOrWL26U7l8f
 UHdvy4k1ewn9eqUQNJgsvI+m+tL1KlXUlVolmqde7mg4ybaGyq2Y5phbVY4tdw8bxZ8hUOjQlmy
 DRILEq0JP9y3fpdClqYjoOaffkmrx4M7uT51AnKoEHzbPcFOpXmF8OU6wbMZrZCISVhZxqZLYcB
 h5PeGZ7lq8gxjjEgn2G0sKxws48q9+l3k5RgQ/sSm46H/KNbi3T2jsWusOI/wNmaO62Usm2NFD4
 5scpjzliN6KArTTEroT498RFyd9teS3tADZD3e3ssoAPNMzfNK4w3mx8yIQXzvj2MbkhE6fPx6G
 LiWCAXsoYjzBZWJjFrOP8AtyeKxdljC9Xs5Gp1Y+kIMtlQabxJym3bPOBryYWACeO3QVqhdbxA4
 uKlWa/rgZAcGGrH0Iog==
X-Proofpoint-GUID: pw3N-xLjgn4K_6Rxd-ZT3kseluhk0GHN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050185
X-Rspamd-Queue-Id: 84EE021895B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43710-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,collabora.com,lists.infradead.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,intel.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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

Core already prints error message on devm_request_threaded_irq()
failure, so no need to do that second time.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. New patch
---
 drivers/power/supply/max77705_charger.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 5dd02f658f5b..0dfe4ab10919 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -666,19 +666,15 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 					NULL, max77705_chgin_irq,
 					IRQF_TRIGGER_NONE,
 					"chgin-irq", chg);
-	if (ret) {
-		dev_err_probe(dev, ret, "Failed to Request chgin IRQ\n");
+	if (ret)
 		goto destroy_wq;
-	}
 
 	ret = devm_request_threaded_irq(dev, regmap_irq_get_virq(irq_data, MAX77705_AICL_I),
 					NULL, max77705_aicl_irq,
 					IRQF_TRIGGER_NONE,
 					"aicl-irq", chg);
-	if (ret) {
-		dev_err_probe(dev, ret, "Failed to Request aicl IRQ\n");
+	if (ret)
 		goto destroy_wq;
-	}
 
 	ret = max77705_charger_enable(chg);
 	if (ret) {

-- 
2.51.0


