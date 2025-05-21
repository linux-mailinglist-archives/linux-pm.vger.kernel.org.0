Return-Path: <linux-pm+bounces-27472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1998ABFE93
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 23:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2536B9E78BA
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 21:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94FB29B212;
	Wed, 21 May 2025 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="CIjmP3oc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A327145FE0;
	Wed, 21 May 2025 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747861237; cv=none; b=fsHXXRoYqmsPWXLCPqe3OnmI3cQOZXPxArv83JvNFXf5iDVoijlXvhQuecTiSdEjd9BHTLxj7VDU49qa/bj6W6wk70VGZt2yah+U8fhoUGLbsIgM7sclEUiCscJtkKHERBdmWmLQAu4uhbIFxHohPTJsNqUirEvIYY7hsen3fz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747861237; c=relaxed/simple;
	bh=0oYjCXjS4sH9UQwXXGgifJus/SXfuN9+9VoHkC7p0dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nsq+YeJrWulo6f0EHT23ZSJ06aBKwTbCiHT1i5vGeHBwYI2ikAWk0/JdxJeLOktDN8laf4Wd++ibzUKlXcmez/ZGM9bi8nfIqw2LNMdX7NAu+BvMo7WIcxX70DSkiSTzDoUjJOnxBz9oOikB3Ohtdt3eOh/vKndniTKVnM7wSwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=CIjmP3oc; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8EBDE9C11E3;
	Wed, 21 May 2025 17:00:32 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id qbZlAlv4cQFW; Wed, 21 May 2025 17:00:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 211739C349D;
	Wed, 21 May 2025 17:00:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 211739C349D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1747861232; bh=VSYCrUr2jQIFVHQA14LqoWAe4hyMiMmPDg22XFPGbLo=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=CIjmP3ocacJryrBlWDhDAtaS8OiO4p0fuHF7dOuNYaoLTQvwUTUaUPlpflOM0azCq
	 c1RiBg+Y67LQpI4DS3xT5TDb0qUaD4x1U1aNYu30IjDw5ZX5ERXY0N0tbRRYPNT1Ny
	 msbWllEy2Ck3gqEl6eAMRJlVdOujWcRsfUGeJoBJKlTWYHn2NxEpOs3Nk+mPHlg1/N
	 1amI991f2hB7thbXenYwooN6myQZ2svMV6MN+QwLsWS1vyRT8G/p2cVOYRaBQyoIJt
	 YU3YzQGqEEZBAOwo086pFm9UnPA/8F5a1sZj8q/iEGnCjr+1cvxcnwzzkl3/UBzP55
	 HS0JkDyKUKMuA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 8pC_bwiUjZXw; Wed, 21 May 2025 17:00:32 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D2F619C11E3;
	Wed, 21 May 2025 17:00:31 -0400 (EDT)
Date: Wed, 21 May 2025 17:00:30 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-imx@nxp.com,
	linux-input@vger.kernel.org, Abel Vesa <abelvesa@linux.com>,
	Abel Vesa <abel.vesa@nxp.com>, Robin Gong <b38343@freescale.com>,
	Enric Balletbo Serra <eballetbo@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 7/9] input: pf1550: add onkey support
Message-ID: <aC4-7pNAFn9jN-DI@fedora>
References: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>
 <7d80afedf1ad9e98c9739163751bcb2785009e74.1747409892.git.samuel.kayode@savoirfairelinux.com>
 <pnfj4tyj3hovtu5ttnecmgozdq7hm2clxhl4xpuzrahlrzqmdm@qpdr4z2y5ylg>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pnfj4tyj3hovtu5ttnecmgozdq7hm2clxhl4xpuzrahlrzqmdm@qpdr4z2y5ylg>

On Fri, May 16, 2025 at 03:55:02PM -0700, Dmitry Torokhov wrote:
> > +	input->name = pdev->name;
> > +	input->phys = "pf1550-onkey/input0";
> > +	input->id.bustype = BUS_HOST;
> > +
> > +	input_set_capability(input, EV_KEY, onkey->keycode);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(pf1550_onkey_irqs); i++) {
> > +		struct pf1550_irq_info *onkey_irq =
> > +						&pf1550_onkey_irqs[i];
> > +		unsigned int virq = 0;
> > +
> > +		virq = regmap_irq_get_virq(pf1550->irq_data_onkey,
> > +					   onkey_irq->irq);
> > +		if (!virq)
> > +			return -EINVAL;
> > +
> > +		onkey_irq->virq = virq;
> 
> I think this kind of mapping needs to be done in the core part of your
> driver.
>
Without doing the mapping in the MFD children, a list of all virqs for the PMIC
would have to be maintained in addition to the (regmap_irq) irqs. Perhaps,
there is a better way to implement this?
> > +
> > +		error = devm_request_threaded_irq(&pdev->dev, virq, NULL,
> > +						  pf1550_onkey_irq_handler,
> > +					IRQF_NO_SUSPEND,
> > +					onkey_irq->name, onkey);
Thanks,
Sam

