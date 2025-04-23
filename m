Return-Path: <linux-pm+bounces-26008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C89AA98101
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 09:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8246B7AE6FB
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 07:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B633426D4D3;
	Wed, 23 Apr 2025 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHr9B00k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FACC26C3A9
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745393484; cv=none; b=PItrgubmwAiXhW1pnXsgqE+C7QNy4c4lAjDJ4l5zscfDSBL/5ZsrBOKXBXQmBjb78DNAiWZszX1gI6qFgZh95ETBbgi1VfcKaYGXgXe6NH4nklq+BYe1DUE4KRaoyBA4lGAMu92clP+++NZoQjawlY8qH00u09SCOInrx8J26EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745393484; c=relaxed/simple;
	bh=xx40UBXWzin2l8gJ2C8uis4CgnNnBmPKea5bOv3ped0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqcYvCw19bHRgSitB4VHm98loHrfPs2XMIjbWL+7lnxuuB8whlpgmo3Nz7UQYtOVf5m8OyTL2rKMZy2l7I0XV8xR9T/V/NroUGRJRBa1Gj3em4OmYj1YStNLibuy/Hv0FMWSwNTYr+pgIEuA3tN/l/ozJImWEIj3HPcv2CuqTNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tHr9B00k; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-703cd93820fso52494807b3.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 00:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745393482; x=1745998282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz2Pp4NKveXDGybOZvUBUVWwEBJwIqad3g3WPhZc9y0=;
        b=tHr9B00kpukFEnzXiGao3gGOMAV5r9pp4bFBfoFfr9kPUEic9GCwh4ywQRdjcsFC4/
         xQCrl2uheFaF2j/2mls7U+46v8MSktN8GSV86xyx5S/I6dscRQmUIXyv/1fFHaAy3ETC
         K+w2MrM/1d+WE77J1KSyT6PCsZ8+1FENF+hQaB58YFSr0EQVmTcQYitd4qnHucslxN4E
         7WkEMODHxqB8S3OtuExI/TMZUPXznfyZIxbcQzYUikCERCnId8ZO0PjwZT7zK89dYuD1
         gKd0SMkmEfnMzsQVZo1ETHQMYm6hE/b12g4VqeB1eMs+3G5yagDW+NOLIZwYd4dhwff7
         oalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745393482; x=1745998282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wz2Pp4NKveXDGybOZvUBUVWwEBJwIqad3g3WPhZc9y0=;
        b=o5XjQ6bGe1Qro3W2pFA1gO1mMU3JlNkBbGufHdvorXKwFmrB4wgjmjr+Yo6oykLBmt
         RZ+AYz+ySXTma4rsRF1rAjjTLS8pJBrBn1D5vIcAi1cAUaZgYJ44D2OudyHwUptUqkcx
         9NfQHk+3ZQSeyh4qLo61xsz2XtipdstKS5c5no7+6NiV+kkug10iqBMHYblYr/WCGM+M
         ycr5//jTERhoO6Zdj80P7vWc310WmJqwKRjqpYWnrt+pkLUqNhQrw3u2mdJXGm3mDjbN
         51iEPWc4pdYVQQKszKA8e5rEIYgWfG7F0Tjp2Ly9UPd9gUVbD8XhZMe/ZNFnMm5o7Laj
         2+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9ttTfGVWqVkZpsYf7utn6nT7Wkzm7v32CouT8iMslV1aUW7SiDDhoM8vV8Vym4Czq7F4UpSSguw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0orYF7u80UOUU9GEFov9jvEnQg6j7mU+glbi0xh0uXX7cXmxc
	XfccLGuZxuCGpf4M6vjlnKWPBuyBvtz3fH0YpvsQ7z/aNYcFilGIh5FzkiQSNsm8zlTXxsnIFi9
	fYXbvYsCKLdU8nmlrm4ExRquBwHAyW78qP44TNA==
X-Gm-Gg: ASbGncsnBbQYnqHHxhtIX7KuGkpgTmNwNY2rhLMBa8GavvO5AHFKpNv9Dhucwhosysd
	wcVwXt9XTnVe6D9qfnVug44tSr3f/fU6sTGOO5oh+aeEN8d3KuFcf/39Ns2E9SYU95xPYYG6PQD
	p/YVbjuoBqodIixt+bSQ9Isw==
X-Google-Smtp-Source: AGHT+IE+vAxAxZJmVGsaCnTFHZjG8MA1QnR3dHhv/DlYpHbMQAbbJHrQ+/iv4PqqOdBAor/gFff+5XP0bi9r4uUyOEw=
X-Received: by 2002:a05:690c:905:b0:6fd:4485:9255 with SMTP id
 00721157ae682-706cce1025cmr244056317b3.24.1745393481950; Wed, 23 Apr 2025
 00:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
 <20250417142513.312939-6-ulf.hansson@linaro.org> <CAGETcx9bHGuJ_J6yF14x0NJJXGWgoDn_X_ScBKaGdD4aTBvo5w@mail.gmail.com>
In-Reply-To: <CAGETcx9bHGuJ_J6yF14x0NJJXGWgoDn_X_ScBKaGdD4aTBvo5w@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 23 Apr 2025 09:30:45 +0200
X-Gm-Features: ATxdqUEwA6P7n5uoj4yF10q5muEKuOPxhwor3p-HG94_3W4Rslh-b95bMMDwj7M
Message-ID: <CAPDyKFoBm_MbHzuf9AOLZ+xLDOmscZATiqkOfOmd5igN6WSu8A@mail.gmail.com>
Subject: Re: [PATCH 05/11] pmdomain: core: Use device_set_node() to assign the
 fwnode too
To: Saravana Kannan <saravanak@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>, 
	Peng Fan <peng.fan@oss.nxp.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Apr 2025 at 22:56, Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Apr 17, 2025 at 7:25=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > Rather than just assigning the dev->of_node for the genpd's device, let=
's
> > use device_set_node() to make sure the fwnode gets assigned too. This i=
s
> > needed to allow fw_devlink to work correctly, for example.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/pmdomain/core.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index da51a61a974c..3911d3e96626 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -2627,6 +2627,7 @@ static bool genpd_present(const struct generic_pm=
_domain *genpd)
> >  int of_genpd_add_provider_simple(struct device_node *np,
> >                                  struct generic_pm_domain *genpd)
> >  {
> > +       struct fwnode_handle *fwnode;
> >         int ret;
> >
> >         if (!np || !genpd)
> > @@ -2635,7 +2636,9 @@ int of_genpd_add_provider_simple(struct device_no=
de *np,
> >         if (!genpd_present(genpd))
> >                 return -EINVAL;
> >
> > -       genpd->dev.of_node =3D np;
> > +       fwnode =3D &np->fwnode;
>
> Use of_fwnode_handle() please.

Sure! Thanks for reviewing!

[...]

Kind regards
Uffe

