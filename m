Return-Path: <linux-pm+bounces-10025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA3917A17
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 09:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7941C2299C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1A115F3ED;
	Wed, 26 Jun 2024 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sm2RBKYg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A730915ECF3
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388156; cv=none; b=X+Tk+kRz0YnIvXQtMNQl0yeZMNoIPXHocwGoKYqrgDw/5klZlOKs/CZLxKn/VvNXbqCAoqJUPOyCY7JV09hcQMJcOq8+NKhiByov+RsfLlMRdCFSpq0xwmBRqn0l9GbG7o3pR5zrjN89DVO53QeTulU9JgBehD127LgOyFhfDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388156; c=relaxed/simple;
	bh=9ApuSxps7IxuDfoDtOKVKXsCtIlHbfe/9watfwFZ+LI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=rVyR2jiw5uySNc+zRBabsX9nZgwz8yx2PP2ddMAq1jV/H3VurGpQcR8q3mBqH2LfDJ1Q+vMwroucwvP0GO3gUT/6m+lM6jix1+Kw0CF4LJp4Flwk+k4r7ObxN0i4wRVRCObXyjp4Yu4bKiKGj8+vZpHSeavSOT86bFxce/yxMTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sm2RBKYg; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240626074911epoutp0206d7b4e7b1d438814ca80d736a9030f6~cfmn40M451488914889epoutp02V
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 07:49:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240626074911epoutp0206d7b4e7b1d438814ca80d736a9030f6~cfmn40M451488914889epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719388151;
	bh=3yWXZ7SGSEfCN6yXGdQIRnQOcuLZUOlDTlk00sawPhY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=sm2RBKYgsizf0S8sjDJFRWyuSgadqiKi3aWa44mJYkS3JCJT4gmYcn3SeQl0+pE7p
	 8mUzZI4EhELEYbasuf2xwL2NKsaXp4kfpEt6jE0TdQLpZNT0PH0UHG+kab3/LQl3wy
	 RR7i79L/v+HBNNL7m/ifG0bnuQIJ2SG0A32+sEMo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240626074910epcas1p3820e8d82021bd2c5fb2494724ef51a83~cfmnMUEBK0213302133epcas1p3F;
	Wed, 26 Jun 2024 07:49:10 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.145]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4W8DNj4WLSz4x9QD; Wed, 26 Jun
	2024 07:49:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	D1.BE.34823.5F7CB766; Wed, 26 Jun 2024 16:49:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240626074909epcas1p4dddc9ee5b42c3df1fa5bec0ea3a9a4a7~cfml7FZ2f0214302143epcas1p4C;
	Wed, 26 Jun 2024 07:49:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240626074909epsmtrp2f12783d30139157c57ee56e7be988d56~cfml6U5es2588525885epsmtrp2z;
	Wed, 26 Jun 2024 07:49:09 +0000 (GMT)
X-AuditID: b6c32a35-e8dff70000018807-88-667bc7f5e7ab
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	53.8A.19057.5F7CB766; Wed, 26 Jun 2024 16:49:09 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240626074908epsmtip16071f43ee4c5ad95d55be7adaf8f574a~cfmlqI4fI1279612796epsmtip1G;
	Wed, 26 Jun 2024 07:49:08 +0000 (GMT)
From: "Chanwoo Choi" <cw00.choi@samsung.com>
To: "'Jeff Johnson'" <quic_jjohnson@quicinc.com>, "'MyungJoo Ham'"
	<myungjoo.ham@samsung.com>, "'Kyungmin Park'" <kyungmin.park@samsung.com>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
In-Reply-To: <f09b56c7-ad2f-472a-896e-466261b39ce7@quicinc.com>
Subject: RE: [PATCH] PM/devfreq: governor: add missing MODULE_DESCRIPTION()
 macros
Date: Wed, 26 Jun 2024 16:49:08 +0900
Message-ID: <001501dac79d$53cdf390$fb69dab0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJ1vcgjbNwdtN0YPI7qXTPUbW8f+AH8kPSiAnbMmY+wgCOJMA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTQPfr8eo0g32PlSy23pK2ONv0ht3i
	8q45bBafe48wWtxuXMFm0bjlLqsDm8fEPXUefVtWMXp83iQXwByVbZORmpiSWqSQmpecn5KZ
	l26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFVJoSwxpxQoFJBYXKykb2dTlF9a
	kqqQkV9cYquUWpCSU2BaoFecmFtcmpeul5daYmVoYGBkClSYkJ0xd7FXwT3pih2PZ7I1MJ4R
	72Lk5JAQMJG48fw8YxcjF4eQwA5Gif9PN0I5nxglPv+fxQThfGOUmN81mQmmZdavjewQib2M
	Eqtmr4Cqesko8azzGVCGg4NNQEdiwY9QkLiIQB+jxNtJZ1hBupkFkiU+txwEm8QpYC8x7dAV
	FhBbWCBE4tbZp4wgNouAqsSFg/vB6nkFLCW2tH1nhLAFJU7OfMICMUdeYvvbOcwQFylI/Hy6
	DGq+iMTszjawuIiAk8TECxeYQY6QEPjLLvF2zSZ2iAYXiYnLNrFC2MISr45vgYpLSXx+t5cN
	omEyo8TF16+hutczSmxc2QK1zlhi/1JQYHAArdOUWL9LH2Izn8S7rz2sIGEJAV6JjjYhiGpl
	icsP7kKDTlJicXsnG4TtIXFm8UrmCYyKs5D8NgvJb7OQ/DMLYdkCRpZVjGKpBcW56anFhgWG
	8OhOzs/dxAhOklqmOxgnvv2gd4iRiYPxEKMEB7OSCG9oSVWaEG9KYmVValF+fFFpTmrxIUZT
	YGhPZJYSTc4Hpum8knhDE0sDEzMjYxMLQzNDJXHeM1fKUoUE0hNLUrNTUwtSi2D6mDg4pRqY
	0goXiSre9DhWnn16hlJnHtPxHYJbFkZwXq0IWbkl31OQudpmz1Lhuf9z3zxLdch60mYaq2C3
	6epkaXXG1y8UQrk2rP3jLuPIFNi4Zt1VjteZ/zskJWeH1+5YVciaEiGbXLgyM5B5i6i0HtPH
	i6GCLqI39PfPjTpvUJ4oeZPzqmzU+9aLDYHxT7aGXSw8f2/5d8ms6Gs7DRrnnfXut55/JNxh
	c4gQ66kVHc8Mpnla1l478/j2o3LblQLC8fz5ttalH75tfvi3d/6qu0+KrKb3vGl6Xduc6z45
	KuvcSrlL7sfXK73+aqbhlp245nuAzGvzGV8mhEy/UFM498We9tgHiXYbbzRUO7Z63K+av2+R
	EktxRqKhFnNRcSIARRpnDBsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSnO7X49VpBq++slpsvSVtcbbpDbvF
	5V1z2Cw+9x5htLjduILNonHLXVYHNo+Je+o8+rasYvT4vEkugDmKyyYlNSezLLVI3y6BK2Pu
	Yq+Ce9IVOx7PZGtgPCPexcjJISFgIjHr10b2LkYuDiGB3YwSH6+dZIZISEpMu3gUyOYAsoUl
	Dh8uhqh5ziixd8cdNpA4m4COxIIfoSDlIgITGCVOH4gFsZkFUiWute9nhqg/wyhxfd9LVpAE
	p4C9xLRDV1hAeoUFgiRmnTUHCbMIqEpcOLgfrIRXwFJiS9t3RghbUOLkzCcsEDO1JXoftjJC
	2PIS29/OgTpTQeLn02WsEHERidmdbcwQ9zhJTLxwgXkCo/AsJKNmIRk1C8moWUjaFzCyrGKU
	TC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4TLa0djHtWfdA7xMjEwXiIUYKDWUmEN7Sk
	Kk2INyWxsiq1KD++qDQntfgQozQHi5I477fXvSlCAumJJanZqakFqUUwWSYOTqkGphlnerOy
	chv6dFWvGZasMg1brZL2pt3M9fEjhbKIJX/4Aq9y+smkmIQunvxx5SFGN3V9gzMxCucdeFfM
	N1vfd8v9wruUE4zLjWcz7bv7LEev8ssEw4tiO6r2iB584XN7SxLv84Xx3modwvaWne/2NcbP
	YmFku/Y7xM1+7o7Dl+YXXv3t01Zt+fae0123lbsSzudN9OzQdtVMylhdMafv1l+J7lyJs6ya
	6tuXKx9zfeA/Ufr/qVceyc0fr0/hWnX+wqqT1RN2cz/0XexjELn8X4TlEsdZWx22X5il8unV
	uQ7F1uzoPPPndvyvintL7671efzkwEfeV2d/HZ8SWHC86JRQ+5ecDf9Pcnjqft8U9U+JpTgj
	0VCLuag4EQDYeyqvAgMAAA==
X-CMS-MailID: 20240626074909epcas1p4dddc9ee5b42c3df1fa5bec0ea3a9a4a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240626042133epcas1p3f68b406443e993411c4e01072ed63d5f
References: <20240605-md-drivers-devfreq-v1-1-d01ae91b907e@quicinc.com>
	<CGME20240626042133epcas1p3f68b406443e993411c4e01072ed63d5f@epcas1p3.samsung.com>
	<f09b56c7-ad2f-472a-896e-466261b39ce7@quicinc.com>



> -----Original Message-----
> From: Jeff Johnson <quic_jjohnson@quicinc.com>
> Sent: Wednesday, June 26, 2024 1:21 PM
> To: MyungJoo Ham <myungjoo.ham@samsung.com>; Kyungmin Park
> <kyungmin.park@samsung.com>; Chanwoo Choi <cw00.choi@samsung.com>
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-
> janitors@vger.kernel.org
> Subject: Re: [PATCH] PM/devfreq: governor: add missing MODULE_DESCRIPTION()
> macros
> 
> On 6/5/2024 11:18 AM, Jeff Johnson wrote:
> > make allmodconfig && make W=1 C=1 reports:
> > WARNING: modpost: missing MODULE_DESCRIPTION() in
> drivers/devfreq/governor_simpleondemand.o
> > WARNING: modpost: missing MODULE_DESCRIPTION() in
> drivers/devfreq/governor_performance.o
> > WARNING: modpost: missing MODULE_DESCRIPTION() in
> drivers/devfreq/governor_powersave.o
> > WARNING: modpost: missing MODULE_DESCRIPTION() in
> drivers/devfreq/governor_userspace.o
> >
> > Add all missing invocations of the MODULE_DESCRIPTION() macro.
> >
> > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > ---
> >  drivers/devfreq/governor_performance.c    | 1 +
> >  drivers/devfreq/governor_powersave.c      | 1 +
> >  drivers/devfreq/governor_simpleondemand.c | 1 +
> >  drivers/devfreq/governor_userspace.c      | 1 +
> >  4 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/devfreq/governor_performance.c
> b/drivers/devfreq/governor_performance.c
> > index 5dbc1e56ec08..2e4e981446fa 100644
> > --- a/drivers/devfreq/governor_performance.c
> > +++ b/drivers/devfreq/governor_performance.c
> > @@ -58,4 +58,5 @@ static void __exit devfreq_performance_exit(void)
> >  	return;
> >  }
> >  module_exit(devfreq_performance_exit);
> > +MODULE_DESCRIPTION("DEVFREQ Performance governor");
> >  MODULE_LICENSE("GPL");
> > diff --git a/drivers/devfreq/governor_powersave.c
> b/drivers/devfreq/governor_powersave.c
> > index 4746af2435b0..f059e8814804 100644
> > --- a/drivers/devfreq/governor_powersave.c
> > +++ b/drivers/devfreq/governor_powersave.c
> > @@ -58,4 +58,5 @@ static void __exit devfreq_powersave_exit(void)
> >  	return;
> >  }
> >  module_exit(devfreq_powersave_exit);
> > +MODULE_DESCRIPTION("DEVFREQ Powersave governor");
> >  MODULE_LICENSE("GPL");
> > diff --git a/drivers/devfreq/governor_simpleondemand.c
> b/drivers/devfreq/governor_simpleondemand.c
> > index d57b82a2b570..c23435736367 100644
> > --- a/drivers/devfreq/governor_simpleondemand.c
> > +++ b/drivers/devfreq/governor_simpleondemand.c
> > @@ -140,4 +140,5 @@ static void __exit devfreq_simple_ondemand_exit(void)
> >  	return;
> >  }
> >  module_exit(devfreq_simple_ondemand_exit);
> > +MODULE_DESCRIPTION("DEVFREQ Simple On-demand governor");
> >  MODULE_LICENSE("GPL");
> > diff --git a/drivers/devfreq/governor_userspace.c
> b/drivers/devfreq/governor_userspace.c
> > index d69672ccacc4..d1aa6806b683 100644
> > --- a/drivers/devfreq/governor_userspace.c
> > +++ b/drivers/devfreq/governor_userspace.c
> > @@ -153,4 +153,5 @@ static void __exit devfreq_userspace_exit(void)
> >  	return;
> >  }
> >  module_exit(devfreq_userspace_exit);
> > +MODULE_DESCRIPTION("DEVFREQ Userspace governor");
> >  MODULE_LICENSE("GPL");
> >
> > ---
> > base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> > change-id: 20240605-md-drivers-devfreq-42b19b2594a1
> >
> 
> Following up to see if anything else is needed from me.
> Hoping to see this in linux-next :)
> 
> /jeff

I'm sorry for late reply. I applied it.

Thanks,
Chanwoo Choi


