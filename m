Return-Path: <linux-pm+bounces-11951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E156949545
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 18:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4630F287371
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 16:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E198FDF71;
	Tue,  6 Aug 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+vshGM+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95FF184D;
	Tue,  6 Aug 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960529; cv=none; b=fUAjTFt7i7tGCymNhA/LJ1VeOMsXV/utKIVBcaKuK8ccQrLkbmTDfz0B1u6RCGFA4BhUf7bAhPwAWhYHieOJOSwQ3TuLDgVaFT9w0WJEDQnvUi86NzUsk1E6gj16VG95tkLsnI4/HWsQ09C2E7gxoipxjHYlEyRhpYRGrn4f70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960529; c=relaxed/simple;
	bh=zleTztI71bR1VV4Zd7JrcyASC2gGE5G/CC5AYm4vrpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Grg4XwlhZlbZBXt7/vtD+A6yF/Fmqc8d5C+usTj0c+hI0WtZ3ZAlkpaE6i4VuDxTZWaC8G0CJWTFDsv6XAr8l5rFePrtYHBUyuvUJ9+EEC2fC9qc9wPpgmk5hQcq3Nliyf5QNA+rwl+g46dszz9YiWw/wDlvZSMoYumCkK/WHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+vshGM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562E9C4AF0E;
	Tue,  6 Aug 2024 16:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960529;
	bh=zleTztI71bR1VV4Zd7JrcyASC2gGE5G/CC5AYm4vrpY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F+vshGM+0ebvKnXUGkH1sr9W9as/nny881xJ+w6cYDz9EQwStLrtloZNZx2fUWmgh
	 n0ODDEKbhq/m6Bz6XyuhxgiYdob4AxP7o76DFSTkdIYkwr6jVhH9/2+6ObVEp+yPYZ
	 RntkplLtMMHrb71L086pvX52+73Cx5NMC0M7Fa3cSLvhU51LL6gfciP7QngozgxVLy
	 hXBpZW4FFNjOMVvN/z+Mogu/pGTJdj7WC7XZYeaXx8QDEfA5h8TAxP3zJ8RxzwByKc
	 bNtA2SIc5bhlCSLOA5RGkjtCtMa4/lfQx/cFoIEK437bZFG5Um8l1yTllXz8IXiOpR
	 6KMtOQJ41IN7g==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f183f4fa63so9520611fa.1;
        Tue, 06 Aug 2024 09:08:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrU9jzX774KNDkwFxTUj1+MAOQHphLgighFSXiZx76oH/uqDTc2UlWNEBG3jIoWDkqSpLxN3KNwY6fTtBpKHRGC/qeWGw6aYh4UE2S/qS/Dq96Hsbv0retamHWbSb7L8Xis0ge2hY=
X-Gm-Message-State: AOJu0YwZps0rRlEel3gQFSOFxyOuMxL5Xwq1TRxUPSo+z9dk4D2OXeV3
	DGHxf1XCpFaEmsbwn0IOFJnKUwc6QOyKoFpoK2cE+e+KnIKAO++9xeodi6LoalwFuhXJDnLAoMA
	ZmlxEy46IRt8e+mhuaQLxRMdsBg==
X-Google-Smtp-Source: AGHT+IEEvIvp/KP9FxUMY15tzLmsM9A3gLkk1/eG9Nu8oa6/kQAQeFXGkAT3KG0Ks16DKyBfq45lT3A45Jf4iTbLChQ=
X-Received: by 2002:a05:651c:10b8:b0:2ee:811e:757c with SMTP id
 38308e7fff4ca-2f1576ddda5mr45044911fa.21.1722960527685; Tue, 06 Aug 2024
 09:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805202042.3229190-1-robh@kernel.org> <20240806044928.2j6z2ucnzk6lg5y3@vireshk-i7>
In-Reply-To: <20240806044928.2j6z2ucnzk6lg5y3@vireshk-i7>
From: Rob Herring <robh@kernel.org>
Date: Tue, 6 Aug 2024 10:08:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLVj2sCuQFYFwR8QnB9jHq_9z4axeNzid1d7+ZrWzmgYA@mail.gmail.com>
Message-ID: <CAL_JsqLVj2sCuQFYFwR8QnB9jHq_9z4axeNzid1d7+ZrWzmgYA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: spear: Fix uninitialized variable "i"
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel test robot <lkp@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 10:49=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 05-08-24, 14:20, Rob Herring (Arm) wrote:
> > The refactoring in commit dca2ef2b7d91 ("cpufreq: spear: Use
> > of_property_for_each_u32() instead of open coding") left "i"
> > uninitialized. Initialize it to 0.
> >
> > Note that gcc doesn't detect this, only clang does.
> >
> > Fixes: dca2ef2b7d91 ("cpufreq: spear: Use of_property_for_each_u32() in=
stead of open coding")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202408030418.gnJDcCpm-lkp=
@intel.com/
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  drivers/cpufreq/spear-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cp=
ufreq.c
> > index 4d28147c23f1..f8c16699a68d 100644
> > --- a/drivers/cpufreq/spear-cpufreq.c
> > +++ b/drivers/cpufreq/spear-cpufreq.c
> > @@ -173,7 +173,7 @@ static int spear_cpufreq_probe(struct platform_devi=
ce *pdev)
> >       struct device_node *np;
> >       struct cpufreq_frequency_table *freq_tbl;
> >       u32 val;
> > -     int cnt, i, ret;
> > +     int cnt, i =3D 0, ret;
>
> We don't increment 'i' anymore, don't we need an i++ in:
>
>         freq_tbl[i].frequency =3D val;
>
> ?

Sigh. Yes.


Rob

