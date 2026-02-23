Return-Path: <linux-pm+bounces-43001-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IAnE+oBnGn6+wMAu9opvQ
	(envelope-from <linux-pm+bounces-43001-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:29:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA53172AB3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3450C302CE15
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9694334CFCB;
	Mon, 23 Feb 2026 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OR0kQOaV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ckWu6GBv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA634CFA8
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831685; cv=none; b=KDqen4OqDLsuBxEQMx3+wmF5NzmE1U3t3kXRLkV4LUY84eMvrZGMNK4Xa5s1wf1PZdPIe6pC1xWAsAuvHqwPOYVI0M4KncOrU0IxYhP6dzPQxCaXPK7Ouvf1bUQlIx0SGDwqv4+HQtWwZfcA/xly2PmjTvCW1Lc4Et9X2f2ajNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831685; c=relaxed/simple;
	bh=NdggOG5IZsY7LXa79Nq7AL/G3ae8FCgqBbMs7M+Uv2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PcDjMrfzVNp33r5Tzg6YZQEshwNi6Ag9OJAaRQ2K7lgsVmmCEnodX/sr9n2JfSzOrXjFgUvVoDLra9/Ll4peLLqgzKC/md6vKF1AoylTY58SosFzoRM3abHeGEWypcMQYAJWop2qQGOQXU5DBRnWr8nwTTNv2s8O0UR6Gy69aws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OR0kQOaV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ckWu6GBv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MCThq4721346
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EievHyEEfc+ZB9sgh0Kt3vK9ZMOHKaJHuHGtcF08CgI=; b=OR0kQOaV8mPN3yp4
	O4ooXQ7AMGaHD/vk0t/uniHvc39ZF0bY6yiA6wRIgVnd2zwJmllKwH3nmURftTsR
	uRwNUWNzXJfjcBuSn89FBRiGhezEOAu8mK/OqUxVcj2jUvYHEK8Pe1WR8DZgAVgU
	v8fkhvAiCSOAsv07CTnGUpakv65K27hZ7OnJOGXCEYopS/QA3HFpnFTX3AK2dheg
	lEMRXRjPu3Q7GNK0ijrV9Nx6jFhWIWseomXEojpOGB/a6tiuk8J6YLbmzSw6wfLU
	gkL6XIel1ooBiXNQVu0rStqwPjcUZuBaEceEUqO1/gGjxd/hJlhc84MkaknPP7+K
	CiTQyA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wbbs02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:28:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb4b8e9112so360408985a.2
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 23:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771831680; x=1772436480; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EievHyEEfc+ZB9sgh0Kt3vK9ZMOHKaJHuHGtcF08CgI=;
        b=ckWu6GBvLF9hkSzylZXLg6mgAMXWTeA1FMSKn33ePF1MzzMX0dQZ+Fgx3Ntj1NLmqy
         RjkE2WMICIP0eCns8oGoywbqzZjXQryG1gU3qB/aOqeuD0kgG34Qy4Ym9PrmfWBZYzjr
         XWRfACYIVBZcIZwWttjUuXNwJSzU5axpxJdnDpemtev/zvY3hkEGRPnEgkik7SfMdqDq
         7K6xQJUOdvXYQZoPg560fFEcHF57ZQq6cIvWQ2BvDB5yksP7EZiJN/fZVjgGKrBFMved
         /gjxnc7T8w5CFizsN5cmxBNrXOTYg2cu0rM02H0EhgH6cAlzWW59R06AJR215ErfZN4B
         idQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771831680; x=1772436480;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EievHyEEfc+ZB9sgh0Kt3vK9ZMOHKaJHuHGtcF08CgI=;
        b=LrEIhQXCsoQ6Pb9tUoPc+uAYKBqmW+bra/iM2VHF9CsKkfLPJLXvSTY5N5iMyypcQ7
         gMKpd502ld1b/Wu3aqzgJZOKTpBUm1TyQykz6DO8aPSp3+aEER/ntR7Ho9CeJxmelEiZ
         wJ4pTiDREEIHpyx1wjUo4Cp3QgKkkY6DOEops4CiFC2VRmCD1AeJiE+fO6OUWxRpHoqr
         OnL5vI3Gqj7I9e3pof29eYc3impj2VjiS8jDcCsG9aVw+McjjXgNr+OUMC+bHWNCOelL
         Hh3eBNvS2p4ClxFzPi++DL0xo/SE++XA2ZgZElDuYCxzLlejahMUBySQPoieEEj+Dc+A
         IJuw==
X-Forwarded-Encrypted: i=1; AJvYcCWm5mCSlPyPuJLBt0FKtIeyraihbKf8bwnW6nDAGl2Px0Bi1ENWDXXYR7oNuOQC87Da/ai9qEzeow==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlqPUyxnOoaYo6WuMca9yaXCqIMsHIpRR/yqglK52jHzy3kzTu
	JZDtcdByblWUoEz3oLF/TMtrkOvdJxn/fJEKqni/4Mzj0hJJNWs12pQrxVE8jCmo9R6tE/FVV+a
	8q3bZIowtNvfnbCJdlPWRGLLaJZvt1bkwiyWREfQ5JB7bro3yMZ4k6bRDoI4PToV+z+bYTg==
X-Gm-Gg: AZuq6aJgF+FPcA9xC4wHOGX1YLHBiOm7uywrQz/VhjNJfi2mO6b5qA4tB9olHXZic/B
	D562zMCdeRJRzfBeuF1g2Js/Tahi756azZUfiOUlE6GBui49r7HQHcRl868u/1odOxn/LCfisWa
	eU3jI4AfElGRiImOlrDPg+bIVGzB6fEOQEYkcWzAPp1f0QO8uzoY36JPt+PUiSe8yTuew6rWLuB
	WgQWXJ2XTb2ESQpH6MiFS7X7Z5DwJ0SAPawzo5auJ11NXUpWIDKIEqDzV1Gj6E5WXe74U/3ifqJ
	U3pymGDPrhGYcwMoOTr2o5n/4kqky5Y7FTilrdsjalM0XXnfz85R3+LOTqaK6cFk8ZQzH+Oyc60
	sogTfbJipRUmTxYc/57H7y/wM6jzV0dYQfKRtLhevVdVV4g==
X-Received: by 2002:a05:620a:4085:b0:8c6:ac29:70ff with SMTP id af79cd13be357-8cb8ca65e96mr953128885a.52.1771831680573;
        Sun, 22 Feb 2026 23:28:00 -0800 (PST)
X-Received: by 2002:a05:620a:4085:b0:8c6:ac29:70ff with SMTP id af79cd13be357-8cb8ca65e96mr953126785a.52.1771831680071;
        Sun, 22 Feb 2026 23:28:00 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9ff5sm18550286f8f.4.2026.02.22.23.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 23:27:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 08:27:36 +0100
Subject: [PATCH 8/9] mfd: ezx-pcap: Avoid rescheduling after destroying
 workqueue
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-workqueue-devm-v1-8-10b3a6087586@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2013;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=NdggOG5IZsY7LXa79Nq7AL/G3ae8FCgqBbMs7M+Uv2w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpnAFtqPjY1qKyahTuUblrNnMhZfW/1VNWITp6i
 +IhXm5LfTeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZwBbQAKCRDBN2bmhouD
 15FIEACAA9XT78ap89BEm6isO1fI6/YX3bggCblWINXzvuzlJGfwB3B0VnAFlTD6+y1zI1shA7J
 Eiiyd/S8i/yKNwjPmqMBhZrjNVdSEs8HdfTN0rvmHhgNqSi8Yyoq1gFJ3HtKmnFyA0qHpsvUpq3
 +VQQwHfPysAby0QYLjXKUwyRzOo41GW/vhM/sItWsdQRCPnEzG+O6ogAT4WiWGcX+Wmwk62STPC
 ief7WiwnKfWJXzieUqsRZVGqZd7mXQsNUrfcIBv0DINdyn0j8odj6D6xo4jgf49thmMDr5CAefC
 yG5p8y1WdKdh+hD1ddFb65TmYSFU9HO2AIzdLNTly7bNQ/GcQlQ97HomBZKTClUGuzTJhLmuv/2
 mwB/7U4KZr9+/VWT+spMEVHe2wGqrOzEKaxbaEIvN8DqgrgFvl1x1qp5/O6Z8UODnFLukCFY707
 gdcJRcK1CKnClIWcJ6w72wS1ItFXBTVBgstbzQ33MCr3IzqNDgTDQRi8lyJXourEeL8wOjXajGb
 qd6HYIqo1vKR5qtCH9fYdNXPAwCavd26qPmcpDaOH3omR1dHCo60MJi+A0c51ZTYkHNd02g77Zd
 835Pl1A8pEm9U/0tyUb/tGHKgz/oaVXIm7/AZuCOdlDJdniUZ8/PBzIMWpPeXMeLh7flqzKBr0S
 3fbO7I7VZezSo0A==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: xHZXL06GBjeWAr12uP79GtDirYgH-xWl
X-Authority-Analysis: v=2.4 cv=UZlciaSN c=1 sm=1 tr=0 ts=699c0182 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Iaj16dx_8Jk8doGcJVoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: xHZXL06GBjeWAr12uP79GtDirYgH-xWl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA2NCBTYWx0ZWRfX2cS9MwVcou9T
 mAB5UpX80YbOI/N8Sf4EXJAzknEcILGD/gGWe8vMsSxf1Msda0rwjPra1ekXlSflLwJOUB0kDSq
 p8JdbN/4G+Ln1FrIHkTSscqbyPdSWLkcwnnjXHni1bg287vkzwP48Id5hxNi88oL0kfzF2uV3TB
 2AX+7wWgRGfDIKsm8qBMTrBLyhWNoPbtXX+Kmf3pOnQgWXLGRxl19U8YrzlWn2qVizgKU0QTyNr
 EV5K81xIjIf+7HuhrxmpyEbPvKPoxmSzswGgdb5TVMtj11zpkZ28EkQUYEF0gRg4n7O13mUPp5j
 y2TaGXSafk8W5VurjlgkpYPGgssvYoSPKGBx8iQBORoRSLPNpKXeBogqZH3jD90vXYdfrN6UHZL
 1nBxPssyIQxXx9IM4jLgO0SoLqUV3QtVwkIfTS2/njB3iNQ3QVw1Q1QV9PF2Oen1uvgFcjjloVq
 9IkcbZsBC3Sjg12llWA==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43001-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6FA53172AB3
X-Rspamd-Action: no action

Driver allocates workqueue and then registers additional interrupt
handler with devm interface.  This means that device removal will not
use a reversed order, but first destroy workqueue and then, via devm
release handlers, free the interrupt.

The interrupt handler registered with devm does not directly
use/schedule work items on the workqueue and the remove() function
correctly removes other IRQs handlers, however the code mixing devm and
non-devm interfaces is difficult to analyze and read.

Make the code flow much more obvious by using devm interface for
allocating the workqueue, so it will be freed with the rest of devm
resources.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Depends on devm_create_singlethread_workqueue() from earlier patches.
---
 drivers/mfd/ezx-pcap.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index b929559d84ae..a06fc3447104 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -375,8 +375,6 @@ static void ezx_pcap_remove(struct spi_device *spi)
 	/* cleanup irqchip */
 	for (i = pcap->irq_base; i < (pcap->irq_base + PCAP_NIRQS); i++)
 		irq_set_chip_and_handler(i, NULL, NULL);
-
-	destroy_workqueue(pcap->workqueue);
 }
 
 static int ezx_pcap_probe(struct spi_device *spi)
@@ -411,7 +409,7 @@ static int ezx_pcap_probe(struct spi_device *spi)
 
 	/* setup irq */
 	pcap->irq_base = pdata->irq_base;
-	pcap->workqueue = create_singlethread_workqueue("pcapd");
+	pcap->workqueue = devm_create_singlethread_workqueue(&spi->dev, "pcapd");
 	if (!pcap->workqueue)
 		return -ENOMEM;
 
@@ -463,9 +461,7 @@ static int ezx_pcap_probe(struct spi_device *spi)
 free_irqchip:
 	for (i = pcap->irq_base; i < (pcap->irq_base + PCAP_NIRQS); i++)
 		irq_set_chip_and_handler(i, NULL, NULL);
-/* destroy_workqueue: */
-	destroy_workqueue(pcap->workqueue);
-ret:
+
 	return ret;
 }
 

-- 
2.51.0


