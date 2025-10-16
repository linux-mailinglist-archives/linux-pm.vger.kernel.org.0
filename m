Return-Path: <linux-pm+bounces-36215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E90ABE1986
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 07:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E561019A070A
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 05:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D800624635E;
	Thu, 16 Oct 2025 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VmpOb6OV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA8A23A564
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760594031; cv=none; b=IVwUrO/uTzGQUSbKQMo9F/pxGEPcqrcChMafV3yzoHpXLC6xiAFgyM93cuUOz2ZGRh6xclp8rRR9Xgc/qHHJZsTE2hGfD0wYm4M0Y7eJmUun0AS+hxurcWucS9G8+HAKpDlGZKdCAwS75HFSizg31/+aaaf9YYLGigsTuYgbjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760594031; c=relaxed/simple;
	bh=dbfShNokxRlugLHxPs9wTRgJuWF4zkrJL4SFAce5Gq8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=tD+K29bdkjfjb0lMBzV3uGrw8lZJRKc1q3YmS0Xidix1D5S3/E8OIcy4xZ3YT0DnWxPFf9hBI7A1B3wahloxch4EzUVTQU3GoyZLlgc2uyg5nCoRQJ/GD3KFSUp3HCWMj0zfIj3oPNoDD5OboXDItzCMjzyO9eM0MQCO1UsE/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VmpOb6OV; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251016055341epoutp0171f4e5033f494ed1feac7d41f74a9961~u4u9Mxza42932029320epoutp01N
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 05:53:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251016055341epoutp0171f4e5033f494ed1feac7d41f74a9961~u4u9Mxza42932029320epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760594021;
	bh=z2ypzUBcWsUqTIXgsF8JXfZwJi1SAGJzy/+9Dlfy/QU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=VmpOb6OVVUaQYzAo0awrm5AOgB7QXefsBoWKwVxcHOwQnUbxCJBwuia7rU9Qf4Sr1
	 vdcFfXWwGEvzZa7vJ+9ZGUUNE4kvbCDdeWCePXeV8Y8lctxq+YDoYWdHy7IuNzvn5W
	 Vn3FMqLsTRAzho/ngR1D2oiHc+73irEremZZT9J8=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20251016055341epcas2p2d516a747f9a7b8abb3e6b7b2e1b7314e~u4u8qPRRC2084520845epcas2p2M;
	Thu, 16 Oct 2025 05:53:41 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.203]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cnHFJ624vz2SSKZ; Thu, 16 Oct
	2025 05:53:40 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20251016055340epcas2p32ef2561a9a5d91e7deba938cc0726965~u4u7mlIJa2970229702epcas2p3q;
	Thu, 16 Oct 2025 05:53:40 +0000 (GMT)
Received: from KORCO115296 (unknown [12.80.207.128]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251016055339epsmtip116886c713983525e1e5383faeb4afbae~u4u7gq99m2565525655epsmtip1u;
	Thu, 16 Oct 2025 05:53:39 +0000 (GMT)
From: =?UTF-8?B?7IaQ7Iug?= <shin.son@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Bartlomiej Zolnierkiewicz'"
	<bzolnier@gmail.com>, "'Rafael J . Wysocki'" <rafael@kernel.org>, "'Daniel
 Lezcano'" <daniel.lezcano@linaro.org>, "'Zhang Rui'" <rui.zhang@intel.com>,
	"'Lukasz	Luba'" <lukasz.luba@arm.com>, "'Rob Herring'" <robh@kernel.org>,
	"'Conor Dooley'" <conor+dt@kernel.org>, "'Alim Akhtar'"
	<alim.akhtar@samsung.com>, "'Henrik Grimler'" <henrik@grimler.se>
Cc: <linux-pm@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <5747ce14-2963-4c5f-b43b-5437807cfb11@kernel.org>
Subject: RE: [PATCH v6 1/3] dt-bindings: thermal: samsung: Adjust
 '#thermal-sensor-cells' to 1
Date: Thu, 16 Oct 2025 14:53:30 +0900
Message-ID: <001e01dc3e61$38c3fb30$aa4bf190$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIjrV0tYij4Y9dxV2JVizj4BALpcQLXJsyWAWfT4LgCVC5cw7QAy2lw
Content-Language: ko
X-CMS-MailID: 20251016055340epcas2p32ef2561a9a5d91e7deba938cc0726965
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250930005147epcas2p2622ff5fdbffc045bbd625e3e60db8118
References: <20250930005139.1424963-1-shin.son@samsung.com>
	<CGME20250930005147epcas2p2622ff5fdbffc045bbd625e3e60db8118@epcas2p2.samsung.com>
	<20250930005139.1424963-2-shin.son@samsung.com>
	<5747ce14-2963-4c5f-b43b-5437807cfb11@kernel.org>

Hello Krzysztof Kozlowski,

> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzk@kernel.org]
> Sent: Friday, October 10, 2025 9:44 PM
> To: Shin Son <shin.son@samsung.com>; Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com>; Rafael J . Wysocki <rafael@kernel.org>; Daniel
> Lezcano <daniel.lezcano@linaro.org>; Zhang Rui <rui.zhang@intel.com>;
> Lukasz Luba <lukasz.luba@arm.com>; Rob Herring <robh@kernel.org>; Conor
> Dooley <conor+dt@kernel.org>; Alim Akhtar <alim.akhtar@samsung.com>;
> Henrik Grimler <henrik@grimler.se>
> Cc: linux-pm@vger.kernel.org; linux-samsung-soc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v6 1/3] dt-bindings: thermal: samsung: Adjust
> '#thermal-sensor-cells' to 1
> 
> On 30/09/2025 02:51, Shin Son wrote:
> >          reg:
> >            minItems: 1
> >            maxItems: 1
> > +        '#thermal-sensor-cells':
> > +          const: 0
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: samsung,exynosautov920-tmu
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 1
> 
> You can drop minItems. Existing binding has it unnecessarily.

Ok, I'll drop it.

> 
> > +          maxItems: 1
> 
> You also need clock-names restriction, just like clocks or just ": false".
>

I'll add the clock-names restriction. Thanks.

 
> > +        reg:
> > +          minItems: 1
> 
> This also drop.

Ok, I'll also drop it.

 
> > +          maxItems: 1
> > +        '#thermal-sensor-cells':
> > +          const: 1
> >
> 
> 
> Rest looks fine, so with changes above:
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Ok, I'll add the reviewer tag on the patches.

> 
> 
> Best regards,
> Krzysztof

Best regards,
Shin Son


