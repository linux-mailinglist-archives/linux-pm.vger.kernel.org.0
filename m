Return-Path: <linux-pm+bounces-11368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 525C793B3AC
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 17:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43AD1F22ACB
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E90915E5CC;
	Wed, 24 Jul 2024 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hIFvKCJ4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E815B97D
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835089; cv=none; b=NDgak53bl+jvhpcViKsrrb+QwLYAfJUhZA4Wd8hvVwjGcnXGPHZp6p/sr6lmspBUoLxtitXqnl0OwnWmdMjHJKHMwxNwn0ckupJSuGJgTKHeiso9oyheU0h2vNcGbyztEZ3uFx1wU3+/VtlcJ2AYkWVHq22rcWC0AdVg+NdnIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835089; c=relaxed/simple;
	bh=47Ky+48e/8/FwyaHOpYAGpQHh6jTDnsO2L6HFR++eao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=EbnosRAhI4tCjA9B7KWETHpdfQBVsOfFahP07krOn5l5SZzZem1LvASBeZvX+6mqkoqZlVNYTScyLHHT+q73Fe2tFKPmrFULo+zH7OvIV1B9ilo+yK+FYqX+CeNzBZrVrTANZ80gpWC8rXFj0jcTM8kyf89uBTllbRZGJA51FRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hIFvKCJ4; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240724153126euoutp02ea5fb6b513ae37e284950e018e1a808d~lL_Ns0XTp2384823848euoutp02Q
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 15:31:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240724153126euoutp02ea5fb6b513ae37e284950e018e1a808d~lL_Ns0XTp2384823848euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721835086;
	bh=47Ky+48e/8/FwyaHOpYAGpQHh6jTDnsO2L6HFR++eao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIFvKCJ4a/X9fMagrETDmEM7857AUOHD3JfgaAGsTaa5S5qbi/09xHzFRhd9JwXbI
	 osZsX01qA/KP8DLZSKtY3NS0PKhQHD5WzA84EtMzw4RLWxNUtgb1zSwmh2ZeBAO+uD
	 TtIdMF/1aGtf5Bl3BoWXR/qNOBp0q+PHmPmfTNR4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240724153125eucas1p1bb4665c4398c72bda4daf7735540fbd6~lL_NN_qkj3048130481eucas1p1C;
	Wed, 24 Jul 2024 15:31:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E2.6C.09624.D4E11A66; Wed, 24
	Jul 2024 16:31:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240724153125eucas1p26cded41c82d3a851a7a4d845a81a3e29~lL_MzkPxx0144401444eucas1p2W;
	Wed, 24 Jul 2024 15:31:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240724153125eusmtrp298afe717e274023e7905ddf73757422f~lL_My26L10803908039eusmtrp2b;
	Wed, 24 Jul 2024 15:31:25 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-4e-66a11e4d1a41
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 4A.D2.09010.D4E11A66; Wed, 24
	Jul 2024 16:31:25 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240724153124eusmtip230f3f2e6a87864305408c32ddb4a68b5~lL_L8rU_d2711927119eusmtip2l;
	Wed, 24 Jul 2024 15:31:24 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 0/6] Add initial Exynos 850 support to the thermal
 driver
Date: Wed, 24 Jul 2024 17:31:17 +0200
Message-ID: <20240724153118.914714-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <CAPLW+4nYfVytXnpDs02QQGms59dL+=pAv7NMNPK6Ymsemmi_cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djPc7q+cgvTDG6+1Ld4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GOzeN63j8lBwGPNvDWMHjtn3WX3WLznJZPHplWdbB53ru1h89i8pN6j
	b8sqRo/Pm+QCOKK4bFJSczLLUov07RK4Mv7Nucdc8Iaxou3MQvYGxp2MXYycHBICJhIv5j5h
	62Lk4hASWMEo8adjDyOE84VRYvvGqawgVUICnxklVl1MhOnounqFBaJoOaPEjYdnoDpamSSa
	d/eCzWUTMJB48GYZO4gtIqAnsW7mK3aQImaBzSwSF57OBBsrLOAvsWDjNyYQm0VAVeLZ9Wdg
	Nq+ArcSVGc+ZINbJS/Tu7wOzOQUCJb7PWccGUSMocXLmExYQmxmopnnrbGaQBRICkzklNu/7
	wQrR7CKxdFc7C4QtLPHq+BZ2CFtG4v/O+VAL8iVmbH4PVMMBZFdI3D3oBWFaS3w8wwxiMgto
	SqzfpQ9R7ChxdM4pVogKPokbbwUhDuCTmLRtOjNEmFeio00IolpV4vieScwQtrTEk5bbUCs9
	JI5s+sY8gVFxFpJXZiF5ZRbC3gWMzKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECU9vp
	f8c/7WCc++qj3iFGJg7GQ4wSHMxKIrxPXs1NE+JNSaysSi3Kjy8qzUktPsQozcGiJM6rmiKf
	KiSQnliSmp2aWpBaBJNl4uCUamCqfMfk2Btk2721yFxyo9C/I51e150F/pz+vfin0NaOr8c4
	Lpe6ZauyPCtY6KV3UmGnVCm32KTob4e8d3yYo9w2b5J6nvxWE9fb0zSWzTXovBBf5y29cbs+
	U/2XkvN1ry4eeZvDp+OlcYvzm59id9cXN5HrN9aVvNefOH/ykT27yvctyAnJckzQad6bVihY
	deitqVHUk6WJUrPaJsnMcfh5YmLPP4HekkNKvzmnXuGfO/tX0TfZP933d0ToLO870ylS5qae
	GWubZa6mLxDx7f2rtslSC68GHfwUY3lks+ykm/6Kp8+tdOl4M2XWZu088+Nyqy/pSCUrBb1Z
	aG2xZOkP7+XcLNLeYm9UGAPmtJQqsRRnJBpqMRcVJwIAKhV7UtwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7q+cgvTDP68FLJ4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GOzeN63j8lBwGPNvDWMHjtn3WX3WLznJZPHplWdbB53ru1h89i8pN6j
	b8sqRo/Pm+QCOKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
	Uov07RL0Mv7Nucdc8Iaxou3MQvYGxp2MXYycHBICJhJdV6+wdDFycQgJLGWU+DZ3IVRCWuLw
	lynsELawxJ9rXWwQRc1MEovOTQcrYhMwkHjwZhlYkYiAnsS6ma/YQYqYBQ6ySPS9vsIMkhAW
	8JXovbGYBcRmEVCVeHb9GROIzStgK3FlxnMmiA3yEr37+8BsToFAie9z1rGB2EICPBKvNuxn
	hKgXlDg58wnYHGag+uats5knMArMQpKahSS1gJFpFaNIamlxbnpusZFecWJucWleul5yfu4m
	RmAsbjv2c8sOxpWvPuodYmTiYDzEKMHBrCTC++TV3DQh3pTEyqrUovz4otKc1OJDjKZAd09k
	lhJNzgcmg7ySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBiYvL+mc
	/icL+C7P/LLY6Wq+vv627Emd3Zuksi5wPXyVZ7RhpWjBvPb9RhpHuBZ0VXzM0uzT+s+TmbXb
	dsnKtcLtBhPa1fycrz9fwHz798Zn/2y67nyc0HB/ifn5I6FiPwSeP6tUyLl7Vnnai8Jz638p
	XnDcVyl40fDI2QMKi2O7/uYIpYrNvtg/TUL3p+mvuFWLPudlPUg5nvK5SP6o+JZL85rvT/GM
	WzX9coWy69qj217y2fe22WbO+bQn6FnOOsa9bsJm9rcc3HQvHCpaxJL7dmnarzS39uYt63TY
	L937GPOlZ0/OyiD5k09XL0ublrhfpue53jkNVhW1bG259xmrF38Tqg842nrzhVQS6zZdJZbi
	jERDLeai4kQALbkc604DAAA=
X-CMS-MailID: 20240724153125eucas1p26cded41c82d3a851a7a4d845a81a3e29
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240724153125eucas1p26cded41c82d3a851a7a4d845a81a3e29
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240724153125eucas1p26cded41c82d3a851a7a4d845a81a3e29
References: <CGME20240724153125eucas1p26cded41c82d3a851a7a4d845a81a3e29@eucas1p2.samsung.com>

> Btw, I'm
> curious what is the reason for implementing TMU? Do you have some use
> cases where it's needed?

Not really AFAIK? Mostly because we have the hardware, are familiar with
this driver, and have some time to do this :)

