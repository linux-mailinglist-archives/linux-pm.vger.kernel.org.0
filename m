Return-Path: <linux-pm+bounces-19477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C60E9F742F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 06:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55EE8188DCF2
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 05:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BCC2165EE;
	Thu, 19 Dec 2024 05:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Huclpdxj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E91F2C21
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587323; cv=none; b=jPweSpaukWRoBtPy2IBE/w6HLZdJdqhTcdBCF68sei6C07iXN6bYxb6P+HPEfPWiGUgw0/X/DwYC4q42B9430EGvSQMiFARMdCzNLo5Gur1xNdt0n/GpzR2Kh962bz9vujsi4ky6Bcc90UhlD79PuPel6v99sxdAd5sWFstl2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587323; c=relaxed/simple;
	bh=NpAg7edbl+ro3WCPZTSr4fO3DbAVIDxN9hswptx87qU=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=r3cHQ0ro2ews+R3IOSV/NfVfnEO+DcjxEGllGtch+/E19mBQbNqN+uyb1fp0B989lHzWthBn36k7MlvyECx5+f37+cV6HNMo/HMmhYOB/wA6r1a7dCHYYxzttQFyCYLjt0gIhwUuAYTHpyrcLUjHNLwW/rJ6vB3N/GpF7Bzz3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Huclpdxj; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241219054837epoutp04f5954e5e2d0bf85694748add7d77daeb~Sffl-Uyq10252802528epoutp04b
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 05:48:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241219054837epoutp04f5954e5e2d0bf85694748add7d77daeb~Sffl-Uyq10252802528epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734587317;
	bh=xBXqWRxS5kcGdxJYyC4GmfdY31Ei8TvnVfnnDXHy8Bg=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=HuclpdxjWaerxDFktCH1w1QYbPdEkCsi5mnIYodDl5Cn46qPsyvdxDBTJ5uCT/IqY
	 6oaQMY9365bRx39v+hIuuW0x9ZZpcY0/EiRcyJkldrSx0mSyaV81EdZRtYmf3pxW1v
	 /Q/YljzQ3ZTlLRt2rjV8B0Cc+5/+z8MFju6T3Siw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241219054836epcas1p2e13e2882f9607862e5b1520e2f441809~SfflsBrLi1111711117epcas1p2D;
	Thu, 19 Dec 2024 05:48:36 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.134]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YDKNM36KDz4x9Pw; Thu, 19 Dec
	2024 05:48:35 +0000 (GMT)
X-AuditID: b6c32a38-580dc70000005e9a-fd-6763b3b3984b
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	50.D0.24218.3B3B3676; Thu, 19 Dec 2024 14:48:35 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH] PM / devfreq: Check dev_set_name() return value
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Ma Ke <make_ruc2021@163.com>, Chanwoo Choi <cw00.choi@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20241211031829.2257107-1-make_ruc2021@163.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241219054835epcms1p5645eee0b14f65ecf8bb272b7d949045d@epcms1p5>
Date: Thu, 19 Dec 2024 14:48:35 +0900
X-CMS-MailID: 20241219054835epcms1p5645eee0b14f65ecf8bb272b7d949045d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmnu7mzcnpBoeWiVtc//Kc1eJs0xt2
	i8u75rBZfO49wmixYOp1ILHxEaMDm8fiFVNYPfq2rGL0+LxJLoA5KtsmIzUxJbVIITUvOT8l
	My/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2ivkkJZYk4pUCggsbhYSd/Opii/
	tCRVISO/uMRWKbUgJafAtECvODG3uDQvXS8vtcTK0MDAyBSoMCE74+C3/cwFPVwVV5pnMjcw
	nuToYuTkkBAwkVh1+jNbFyMXh5DADkaJbdPXMnUxcnDwCghK/N0hDFIjLOAicfribkYQW0hA
	SaLh5j5miLi+RMeDbWBxNgFdia0b7rKA2CICxRIPuxczgcxkFljPKPHywRY2iGW8EjPan7JA
	2NIS25dvBWvmFLCRaJ5xmRkiLipxc/Vbdhj7/bH5jBC2iETrvbNQNYISD37uhopLSvTd2Qu2
	TEJgNqPE997ZzBDOZkaJH5d/Qm0zl2g9vhFsKq+Ar8SUC3vBLmIRUJW4dGQ1M8jHEiBvXikE
	CTMLyEtsfzsHLMwsoCmxfpc+RJhP4t3XHlaYX3bMe8IEYatJHNq9BOpmGYnT0xdCTfSQWPZX
	ERK2zYwSH/fNZ5zAKD8LEbyzkCybhbBsASPzKkax1ILi3PTUYsMCE3iMJufnbmIEpzstix2M
	c99+0DvEyMTBeIhRgoNZSYTXTTMxXYg3JbGyKrUoP76oNCe1+BCjKdCXE5mlRJPzgQk3ryTe
	0MTSwMTMyNjEwtDMUEmc98yVslQhgfTEktTs1NSC1CKYPiYOTqkGppiU7GOMV/QqP18/eW7F
	OZn8E9eOpKpmdEdsKJ43u9tM3831bVb1vIspZwR9d7w4eCu1xCeyReHb/UjeTJ/ICxw9PKKz
	yt6WrdVizTereswXtbvyCnfKa/7pBVl3z9S/eW5Us8j7atYUoWc6KlytTK4nVHrWFOT62l2t
	b7sosYR9v4zJZMUTJlckA/02CydH3b/HXbLzXgObY5mv48p9O1Vq129n2Pn2q5buvbWTfvaY
	7r1Qw92iw699L3yO/3XejQUOKXKLK2xaPj44n70/TOjbF+2e6fKdP0vNlx77wCP051TK+qcN
	bb8Vz66ftVHiYERTQ5x9v+caO6s3r8SnfjgfXXLArjv4of4u5/AHSizFGYmGWsxFxYkA8k1Z
	2AAEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241211031841epcas1p393092ea5f020ab4c7587228395d9a843
References: <20241211031829.2257107-1-make_ruc2021@163.com>
	<CGME20241211031841epcas1p393092ea5f020ab4c7587228395d9a843@epcms1p5>

>It's possible that dev_set_name() returns -ENOMEM. We could catch and
>handle it by adding dev_set_name() return value check.
>
>Cc: stable@vger.kernel.org
>Fixes: 775fa8c3aa22 ("PM / devfreq: Simplify the sysfs name of devfreq-event device")
>Signed-off-by: Ma Ke <make_ruc2021@163.com>
>---
> drivers/devfreq/devfreq-event.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
>index 3ebac2496679..9479fbe71eda 100644
>--- a/drivers/devfreq/devfreq-event.c
>+++ b/drivers/devfreq/devfreq-event.c
>@@ -328,7 +328,10 @@ struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
> 	edev->dev.class = devfreq_event_class;
> 	edev->dev.release = devfreq_event_release_edev;
> 
>-	dev_set_name(&edev->dev, "event%d", atomic_inc_return(&event_no));
>+	ret = dev_set_name(&edev->dev, "event%d", atomic_inc_return(&event_no));
>+	if (ret)
>+		return ERR_PTR(-ENOMEM);
>+

NACK.
1. edev is not handled.
2. although dev_set_name returns -ENOMEM or 0 today,
you don't know if it will return something else in the future.
Use what it has returned.

Cheers,
MyungJoo

> 	ret = device_register(&edev->dev);
> 	if (ret < 0) {
> 		put_device(&edev->dev);
>-- 
>2.25.1

