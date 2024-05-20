Return-Path: <linux-pm+bounces-7989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17FE8C9A51
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 11:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E287F1C21227
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4FE1CA81;
	Mon, 20 May 2024 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QctnMMGS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC753224D7;
	Mon, 20 May 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197348; cv=none; b=YSDeTvfeUeq/Pd5kqa3KduwDpIjFIesqeEbHrQH8Q4DeKDRKXye1TVETTPpmyjkbZA3nUseJwaMPbVLz1OxsFu2WIMXOvTCwD1hIIyZ3Bn/DKb9v9jn3cnkIRZipvBCemM3vbSMs+4uOuBfTIbgBg96cnqmXQbToPlmTKgVFxHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197348; c=relaxed/simple;
	bh=o2Ta2tVgYz8zBplQ5g6ryctD/giXzE2qXg58AjWjmPI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=MC4FLh9mL8CWod3mp0bZNCtgjW0Zbl5foyy11w+FnDpR367lTceuLzYiw4NIWiv2oZO9QywRpoLNL5IC8MDPYlCcGKpMjBA33A7fJODCR/H5HQbGaiGG7rZAQRMsqoJ6MeAQXuLaLrVDqbzVgu3H5KXSc77b2C5itxpNWNs4zvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QctnMMGS; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716197295; x=1716802095; i=markus.elfring@web.de;
	bh=u6nHGvcBqMTPqIN2MtW+oE9OO6oEG3uVuQ2+HbH7zik=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QctnMMGShrq3jzUdzH42CozIpIvdz3PVcHZG2w7BJjcZ/8gJeqWmVRlatVhzTeNo
	 NPDXUbQMi6Rj6Ri1Dt8z5WpEmJy92LlOGpmbeg8zPWHJd0IC6sjXkIAkivly+Dwq7
	 fA+Wn+Yt4ifQh6Dnc9jXoa7ATOT50BEKb5SLhN+6SIATQEaj8CYl1X///jEN46Flk
	 n3RKchsO/HS9Udcdvj/2QSZqnFnEw8+n20J68muI1rS+6eAGCPq1x5imZoEkRoTiP
	 NF9zFr5WcIlOg9g+WZSAxyzeky3R+hpoFnYEoqwwbIwRXG2FADFOtj//uRrRLjxPE
	 8rP83LZrZMcRm/v/mA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMAE-1snFU10Bh0-00mXlY; Mon, 20
 May 2024 11:28:15 +0200
Message-ID: <fb6ee370-54d7-4eff-8a44-ee7cf2d13e61@web.de>
Date: Mon, 20 May 2024 11:28:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Yangtao Li <tiny.windzz@gmail.com>
References: <20240520083522.vvga3aqjg4w3adkj@vireshk-i7>
Subject: Re: [PATCH 2/2] cpufreq: sun50i: replace of_node_put() with automatic
 cleanup handler
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240520083522.vvga3aqjg4w3adkj@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HXcd/g6a7OP7gzDepmaooJv4Okhf0ew3NClde231I+VAKbgUuUQ
 JBKPP52Ckkjb/6eHI2X/we+fKADuX3zCpDcEp3Hk0hYeyD+9R2YoH7H2V4L83HPktsFdupf
 DQt8z/9xr2wFzt6JdZEaeIX8XbtVrYeyOab3UegVdwLJF6s2s7f9hvaU2XD6P7iZknTmL7L
 VD4hqRfiaFvFL59HuY6xA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QBI3m0Ncq0k=;c3cL6gMCHAggpVYtmQaIPDAmjqU
 7/YAfq7dareu5KT74iLb6rfqNfT6Mmh+8HRex9EkUFLjXkl0tTM811TYZ9WSkLRCii3kPi3/X
 5jDVp5EaDEij5R8iB6g84/Lqkk16yasgKeuuuk3EnWYCR4FCbqWxvXHWryeIIsL1oFdMUCjfC
 t3uGwR/uzrp4qr1s+wj64EAvaoRABsw+k5XB28bbd3c/5vXMjXWFZU2V3+/IrBgOvh+mZ6Avi
 UpmxzjtPcFP9w30CPXhVK38EL2PoAWUDsGMndFCUc4/Ig+emvYLWDKi2XadVcf1knnlvr4AzY
 IGgY+eYCboDteS6AZzHSzkMXERru82JtjaIL3dv+pol6YzHKJN4xoSRbckERtRKbXzOZJv1mw
 Kl77HmCC0pbL3TGD/HXrHT8JzL6QzvUNbmIezJlzxZcxGqUb7GFG5nzHmbtHmJaMDRI/LYZDn
 /Evzkb2gHuHCNB+6YwqPpkQgRyztc/u+sm77mur2FQvy9RAjC7xc8DFJVx5+h4PjUJ/lnQ52q
 GdlfzoNkk0NF4SizfPWb5jCYg/sVEd6EuR6vWCXZsTsSkz90doCR3L9s8lj8rQNX+5WCfKRNM
 DoNl7SG2LhranQYdqYeWT/qtmXBRaWX7jEAiRT6c/4Ur3Wf/F6N/31KOuI27UEQRmuhTNypzS
 LQEh3s/livmf7VnAiEnzLHUFOcQAdgyAULqe79VXG7eo8otr/K8EbCwnSs3h2KGGQTj+4Q2PM
 9Nxg9YVhkpWEmB6JVYac2amaIrw8NrZx2c57m6grarJdxAp8tGZej768wLcXAOgntuogsYFWa
 u28cNRuVWTy5LsdyGfXS1216jtauRgwdnhcM3zMRhELvk=

=E2=80=A6
> > > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > > @@ -131,14 +131,14 @@ static const struct of_device_id cpu_opp_match=
_list[] =3D {
> > >  static bool dt_has_supported_hw(void)
> > >  {
> > >  	bool has_opp_supported_hw =3D false;
> > > -	struct device_node *np;
> > >  	struct device *cpu_dev;
> > >
> > >  	cpu_dev =3D get_cpu_device(0);
> > >  	if (!cpu_dev)
> > >  		return false;
> > >
> > > -	np =3D dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> > > +	struct device_node *np __free(device_node) =3D
> > > +		dev_pm_opp_of_get_opp_desc_node(cpu_dev);
>
> Won't that result in build warning, mixed code and definitions now ?

I suggest to take another look at a corresponding information source.

[PATCH v3 04/57] kbuild: Drop -Wdeclaration-after-statement
https://lore.kernel.org/all/20230612093537.693926033@infradead.org/

See also:
https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Warning-Options.html#index-W=
declaration-after-statement


Would you like to stress a scope reduction for the affected local variable
by adding any curly brackets?

Regards,
Markus

