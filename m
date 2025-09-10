Return-Path: <linux-pm+bounces-34320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7EBB50A46
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 03:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5934E563A3F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 01:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0FA1D7999;
	Wed, 10 Sep 2025 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jRGOMphx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2C02E403
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468031; cv=none; b=QYUeZTo0FCTOV89ZuwVyse2lc9dGEkTlLAB8J+97JBcZj8MBm16pUkw6p+G0ogma5xl6GWCcBJMCq+8xZSs/4wooi5Kq/5evhpfKz1yhg3KYFG39MVg6O60H7Bi7AlqQxB9dBCiOh2IIUVLD8oCj5t7dkYrOuZ7KUkGh3aawQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468031; c=relaxed/simple;
	bh=UE1dW2vjyCtvAjqcbpkaQjgaA6fRIygDccPoGm5LG1Q=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=CFFQNnwkgNqepDxNxihb1FKVvebXj08dOS5hqg+1q3fw5O0F3CYKhDcrwaTk/I1OSSvvFdRoJCuMNbf7R1WYRPxMnodcGJELYUSieQG1ce+1n9w9INpHBqiPGscp10ljQ/FaL4xeoCv5421Zv0MHtpVyorFb27QyJFowKdmsxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jRGOMphx; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250910013346epoutp038340f6f6143488c5b3cd2f8d0cb3ffbc~jx9vMuZrR1089910899epoutp03_
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 01:33:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250910013346epoutp038340f6f6143488c5b3cd2f8d0cb3ffbc~jx9vMuZrR1089910899epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757468026;
	bh=B/cQztE6JVsN29H2UCnnOkTaLkGI3st9SaYIAZ0Aj6I=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=jRGOMphxr9OlYaJEH6x1gYZyDvpOgTnngtS/3I3ljide5pEQgBPHPyvfPhpoecHxL
	 MIApyz7+jUfWexphehLhwg6aRsUOj3CAnGERFpgOk5n9bZnwnsZlDyxsipwQ5cWOc5
	 9MerGn9AbIJGYFCRZ9NMOm1pfNQ3IgfUSKGKrM48=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250910013345epcas2p1627ed06365bff0aaf2d6a0810b074777~jx9ui-Lrd2488624886epcas2p1h;
	Wed, 10 Sep 2025 01:33:45 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.36.70]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cM3B075H5z6B9mD; Wed, 10 Sep
	2025 01:33:44 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20250910013344epcas2p265fefabdfed14e90b66cc856c559e561~jx9tOknPz1132511325epcas2p2b;
	Wed, 10 Sep 2025 01:33:44 +0000 (GMT)
Received: from KORCO115296 (unknown [12.36.150.221]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250910013344epsmtip1bcef11072703a7ec40ff187ab78578bf~jx9tKKmwA3018230182epsmtip1Y;
	Wed, 10 Sep 2025 01:33:44 +0000 (GMT)
From: =?UTF-8?B?7IaQ7Iug?= <shin.son@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Bartlomiej Zolnierkiewicz'"
	<bzolnier@gmail.com>, "'Rafael J . Wysocki'" <rafael@kernel.org>, "'Daniel
 Lezcano'" <daniel.lezcano@linaro.org>, "'Zhang Rui'" <rui.zhang@intel.com>,
	"'Lukasz	Luba'" <lukasz.luba@arm.com>, "'Rob Herring'" <robh@kernel.org>,
	"'Conor Dooley'" <conor+dt@kernel.org>, "'Alim Akhtar'"
	<alim.akhtar@samsung.com>
Cc: <linux-pm@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <e71e6f3d-af02-4910-91ae-acf41692ac5b@kernel.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: thermal: samsung: Add tmu-name and
 sensor-index-ranges properties
Date: Wed, 10 Sep 2025 10:33:43 +0900
Message-ID: <03a301dc21f2$f2236380$d66a2a80$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJcDpuT0zWDya8nliyk6vzs/32vBQIURjbqAvLO/ccA7RxvPrNcJnHw
Content-Language: ko
X-CMS-MailID: 20250910013344epcas2p265fefabdfed14e90b66cc856c559e561
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250903073653epcas2p4cb25058c97aab9a30c7e68ef5f10fb91
References: <20250903073634.1898865-1-shin.son@samsung.com>
	<CGME20250903073653epcas2p4cb25058c97aab9a30c7e68ef5f10fb91@epcas2p4.samsung.com>
	<20250903073634.1898865-2-shin.son@samsung.com>
	<e71e6f3d-af02-4910-91ae-acf41692ac5b@kernel.org>

Hello, Krzysztof Kozlowski.

> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzk@kernel.org]
> Sent: Saturday, September 6, 2025 9:06 PM
> To: Shin Son <shin.son@samsung.com>; Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com>; Rafael J . Wysocki <rafael@kernel.org>; Daniel
> Lezcano <daniel.lezcano@linaro.org>; Zhang Rui <rui.zhang@intel.com>;
> Lukasz Luba <lukasz.luba@arm.com>; Rob Herring <robh@kernel.org>; Conor
> Dooley <conor+dt@kernel.org>; Alim Akhtar <alim.akhtar@samsung.com>
> Cc: linux-pm@vger.kernel.org; linux-samsung-soc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: samsung: Add tmu-name
> and sensor-index-ranges properties
> 
> On 03/09/2025 09:36, Shin Son wrote:
> >  > +  samsung,hw-sensor-indices:
> > +    description: |
> > +      List of hardware sensor indices that are physically present and
> usable
> > +      in this TMU instance. Indices not listed are either unmapped or
> unused.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 1
> > +    maxItems: 16
> > +    uniqueItems: true
> 
> 
> For v3 you also need:
> 
>   items:
>     maximum: 16
> (or whatever values are actually correct)
> 
> 
> 
> Best regards,
> Krzysztof

Ok, I understood. I will add it in the next version
Thank you for your feedback.

Best regards,
Shin Son


