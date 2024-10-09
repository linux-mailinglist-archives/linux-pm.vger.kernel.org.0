Return-Path: <linux-pm+bounces-15399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EC5996BA5
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 15:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09981F22564
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 13:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29039192B6D;
	Wed,  9 Oct 2024 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mM1J/c1T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823531EA91
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479912; cv=none; b=WCW13F0XIMVZOAXVBeJ4HBZTbg3SHB5tSeu5rnfZf/DBumb3AURhBqLj8lxKntfdxfTuI2CB1AfMy10In7nZUrbFz3XGiZGPG8YyuSvyFKp58h+vlaMM6p+STKkYT6QL0au+paz/86CbP2bMofFkbxfwUq1pave/qyqIsAofguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479912; c=relaxed/simple;
	bh=DEs/d30A6OdgSded7yLq86hpsqBzL2gpxnYKoRS9vWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUm7xszj533zLv9ccoAeXzdMAPknIGPnTXbVDclMFdGNrSO3nmwt2wr75sTZ0/x73BkJoRp2utnlqgHtPFus9P0mrU8IZZBlxta5TmUe/nFpXPoy/1JiKJa0Ad7mU9Uh7YXi59UjqWdFQuTqEg8JaMMdH/tbovUPnvWJ4sml4Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mM1J/c1T; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e290582301fso489110276.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2024 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728479909; x=1729084709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fahjuP5GSwT5SXM4x2ztwRN877oqyqnMQjfzefZnQm4=;
        b=mM1J/c1TOedfqGlDpF0hjCdX9OAj4kbWxx/1tPRvUwuBGhrW2eUkuSiZQg153bzkhU
         BHfoJyHgDBOSwoK72YQkDuYLe/Er+Yqn/9e3MBggW5vuWJJwx+C6k7dBaSLAIAZ56EoD
         yntdjkpFgk85kXnZS8nnO5nBx8JDrT6eP9VlDp4swJ+jMAC7QaZXCnXw0vDU6lPUDkUs
         IFQhPg66TUT2HTQfXB3fqYBt0ghDgC2hkfZwZxGV6CY/SL3wXd6hF55/HfSB47+AFUJG
         WAcdiSylD4pXC3PsjOHXnr22d9GCrWKrvy/hssW16NbWI7l9VsCDPLUORqk0mFFGyQv9
         sbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728479909; x=1729084709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fahjuP5GSwT5SXM4x2ztwRN877oqyqnMQjfzefZnQm4=;
        b=MKhYD/b2zACz+tOunXXZBXmEMrxIaeYOI0roplufy7kN2tLKPzxNn9ufsDmMRvsj5k
         2/L2AsgkVF9N2fuSzq+W1Z9Xt2OuyY9N88wQbtL4MYPbIl26pA1QPZCL+UqNXls7jCNY
         xa3bCV7uak0rSQNEemlaoX1m5BJxwekqvh8xqV0C24k3pz0GHZOLns3K1xeBzYBYErzg
         Y+Lhs5om2oWIocZF7F9giIXhDgPbuZrf1V0jeTMW49u6ZHNZ7M3Lvyg4wIqgW8fR74Yx
         1WptmSttja/ZHzCn+8OMu2E/3jgsK/RxpY68QtDcoVdBMCrcox4pchNfmjFqdUr6d7TA
         /f1g==
X-Forwarded-Encrypted: i=1; AJvYcCVF3XqJnvwukL4sGKO8cqoeOtIvTJQFWDZeciWpXGm3mfqYAOsMAp36uBmu6tWccgzByuBCn9n31w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJWeBW4+T0rTiLJ77e4c3eTzlfgUvX5GQ/OHXYoPKelne5nXy
	4yT26JSl2CPYyTeK1EC9ViXeXcJC20xv+jtPG93ERrlkMzVs4VHT5Az5s+vQVXazUPMxkvlK6nB
	md3faDcJoUCtHla2e5f+vxkvhSuRWvAy4usiV0g==
X-Google-Smtp-Source: AGHT+IGdMVfirN3r2XR9CcAsjc7P63ptNZgOVR3DTBZovGzj3+iT9kj28KuHzCMjhXPK3VMUIZsVtd+U5lqO0q997qI=
X-Received: by 2002:a05:6902:124f:b0:e28:e605:2dd4 with SMTP id
 3f1490d57ef6-e2909c1b69bmr146400276.17.1728479909496; Wed, 09 Oct 2024
 06:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com>
 <20241008-8250-omap-no-console-suspend-v1-1-e7f0365c02f0@bootlin.com>
In-Reply-To: <20241008-8250-omap-no-console-suspend-v1-1-e7f0365c02f0@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 15:17:53 +0200
Message-ID: <CAPDyKFroumouYavhaHp=aSh=0WsDO=_4kbVgS-+Y7CADyO-Kmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: ti-sci: set the GENPD_FLAG_ACTIVE_WAKEUP
 flag for all PM domains
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, u-kumar1@ti.com, tony@atomide.com, 
	khilman@kernel.org, gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com, 
	theo.lebrun@bootlin.com, richard.genoud@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Oct 2024 at 11:34, Thomas Richard <thomas.richard@bootlin.com> wr=
ote:
>
> With this flag, if a device is marked on the wakeup path, the correspondi=
ng
> PM domain is kept powered on.

Perhaps extend this with some more information that it fixes a problem
for the uart console too?

>
> Suggested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Should we add a stable/fixes tag?

Kind regards
Uffe

> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/t=
i/ti_sci_pm_domains.c
> index 1510d5ddae3d..38448b4a035a 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -186,6 +186,7 @@ static int ti_sci_pm_domain_probe(struct platform_dev=
ice *pdev)
>
>                                 pd->pd.power_off =3D ti_sci_pd_power_off;
>                                 pd->pd.power_on =3D ti_sci_pd_power_on;
> +                               pd->pd.flags |=3D GENPD_FLAG_ACTIVE_WAKEU=
P;
>                                 pd->idx =3D args.args[0];
>                                 pd->parent =3D pd_provider;
>
>
> --
> 2.39.5
>

