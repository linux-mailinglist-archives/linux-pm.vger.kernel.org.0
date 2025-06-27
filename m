Return-Path: <linux-pm+bounces-29679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80087AEBC21
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 17:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA5C3ABDEE
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 15:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB4D2E92C4;
	Fri, 27 Jun 2025 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFQQlKYP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAE23E34F
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038841; cv=none; b=P4mw/fQDhYpK8q4uN801nIubeKlcGdUJqcbudmIujzUyKcu9Engvomtbq3xEbEIDMYHMTiOlmEqq1ZIciSjv2wqQx+31K1xYkhruhOElUGDRjv22JHsnw1pWY3Dd9hlvCNxpWqKKMvBbuzgaLuupQnI207eKfxT8uvSm94YVphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038841; c=relaxed/simple;
	bh=d/GwnZrXW005mxplKA0+3KM5bSTcbwWbAmIzKExtCRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Um5mooozv8cizV+ycNlDXtp5x2reHp6383Dz5bvH4QCnnp4zLnc1zM68b++dWQWO7Ps+pKCDtimwmduYCdlGOWJ0L+I9os9Sp1Iq8nZGX/Ne/hvzaONFA2SsfKBsazjPhywEyNu9hhv2ogr9qcnP4ZOXikseOwnWljDLHPx7NHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bFQQlKYP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so3886220a12.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751038838; x=1751643638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jj2bLybNvPyHSij0xa+7vNe8FDo/UYuhavfR08FTa9E=;
        b=bFQQlKYPKxiyY8eG3TYrpt5hGovP45sXfReq1O19GCqO0OxSR9Qqbi6is3EvjLr1FZ
         IpGq+Wo1S4Q3jMmgINzHLjCjqnctW1OI4i8Ml7cjmgyfBYEyXz9I0vr+EmCVI64edhL1
         n104rNkadhyL9CB81cN2Hm4qHquz66o1q7cE5FlVPVi1AwZPvBUMAtqDDi1AtaOknSRk
         8F4Qso0Fe473bMMlSPDpB6LnHCgATC7Ha4ggUcJqGsspp9hPGEtgwiyn/GEcxy32jMwx
         +mBnjt7O+6BI/eAbm4KyEnDfr6suvOOd/ygrdK8nnHD/zWfKu0kfXpVkP9Z0i7y0Mg41
         HHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751038838; x=1751643638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jj2bLybNvPyHSij0xa+7vNe8FDo/UYuhavfR08FTa9E=;
        b=QcitguJP4QsGHZ6Px7fQr3u1Z717SaVQ9XhDc3vPV/8YbV3MaomBb3ce9YPo6aRPDI
         Mu+yyW62C4GxX/1TSkeTD6t+MD9r3CMCm1IpJwJEGYcTgAZtWRYrDa95LfV38fjYfSSK
         2zU8UQWW9FnF/uM7iD30zS5WLPywidpzC5OYvIKLPvJUhew4CjCeDKk3MpxEjrHFfO3U
         VHZmvIf89QL0f34yUILo3Ekys3fV0jiuMLQD8rxeeI6p2nliEzZ7f15fE49rQ8sPxWDn
         tGsnGjx6zzdXHb5x/lbM638uLt0rw4CA7ogHykklUYSaoGAQmq32f+fjA33EcUFDvbf+
         VsFA==
X-Forwarded-Encrypted: i=1; AJvYcCVZujJsvKX8k1EKsbH7/WQtGOBdjZ8v7BmgUCTrXmBA4c0KHnT8MvrdnPfaio514u58cDeOe6H7lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwswpcAia1Obw0KnxhyVWdg9uObSuZwNG1X56dO65bTRUIfJ+2j
	Gtr1h+lj5kKGdC8Canq75Z6yyuNf3YhAWkusRQ3c0PIPXinoQyYMy3CrbTBP3GgEewoKpfSdwBA
	hAXh7LZb3FOVgfHrJv0Y+TS6WpfJobCU6p9Wk1eo/XA==
X-Gm-Gg: ASbGncv1bwnGmc1P56a6BeR7JVIuXnK/pyo/2yfxLM5I3actqbBdVn1aoleLXGda8dy
	+rJLzqDbK0cQ+dvSmV5Dn46f4xmD7qJh+NIF9OeYc22+xv7enYm47U/7wB8HpnH9XlRI9Q2WcDG
	sn6B2g3FxtnntcunUxTXgFrOptL7RtCKKdmTXsN3V+XRprLcRZRtodl/zi16zL+86hPHv8zUT/C
	mxB2Q==
X-Google-Smtp-Source: AGHT+IEvkXr4JcCj5oD0vFiY1H6Wn1hmSJv40jglC0KLoMmc4+ZOMxDrQflQwFqUtAQPpKoqyo8PcKiVmvrT6rHam7I=
X-Received: by 2002:a05:6402:2802:b0:608:6711:a06f with SMTP id
 4fb4d7f45d1cf-60c88b33e2bmr3273384a12.4.1751038838221; Fri, 27 Jun 2025
 08:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626215911.5992-1-hiagofranco@gmail.com> <CANLsYkzo32BHkxRzSLY1U_PcidMPOaz7xZjDs8HKtTCQ0ZpF=g@mail.gmail.com>
 <20250627144955.tbmk6ako3rgv3djo@hiagonb>
In-Reply-To: <20250627144955.tbmk6ako3rgv3djo@hiagonb>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Fri, 27 Jun 2025 09:40:27 -0600
X-Gm-Features: Ac12FXyUCI-R2q8qxbHAG9epzvsz_v3mTi9fyUrRB-IT5cqGx_PrRwpqh4kxuRo
Message-ID: <CANLsYkz3SD1PPnVwoBnnKhyCUig67o+=NgoDucq5m+4sQ=xMYQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] remoteproc: imx_rproc: allow attaching to running
 core kicked by the bootloader
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 08:50, Hiago De Franco <hiagofranco@gmail.com> wrote:
>
> On Fri, Jun 27, 2025 at 08:31:20AM -0600, Mathieu Poirier wrote:
> > On Thu, 26 Jun 2025 at 15:59, Hiago De Franco <hiagofranco@gmail.com> wrote:
> > >
> > > From: Hiago De Franco <hiago.franco@toradex.com>
> > >
> > > This patch series depends on Ulf's patches that are currently under
> > > review, "pmdomain: Add generic ->sync_state() support to genpd" [1].
> > > Without them, this series is not going to work.
> > >
> >
> > I thought we agreed to repost when the feature referred to above and
> > the work in drivers/pmdomain/core.c will be merge.  I'm not sure what
> > to do with this patchset.
>
> Sorry Mathieu, my goal was to update the whole patch series with your
> reviews from v5 so you could take a look and then I would resend
> everything again once the others have been merged.
>

Ok, I'll take a look next week.

> If you prefer I can wait for the other patches to be merged and then
> send the next v7 corrected.
>
> Best regards,
> Hiago.
>
> >
> > > For the i.MX8X and i.MX8 family SoCs, currently when the remotecore is
> > > started by the bootloader and the M core and A core are in the same
> > > partition, the driver is not capable to detect the remote core and
> > > report the correct state of it.
> > >
> > > This patch series implement a new function, dev_pm_genpd_is_on(), which
> > > returns the power status of a given power domain (M core power domains
> > > IMX_SC_R_M4_0_PID0 and IMX_SC_R_M4_0_MU_1A in this case). If it is
> > > already powered on, the driver will attach to it.
> > >
> > > Finally, the imx_rproc_clk_enable() function was also changed to make it
> > > return before dev_clk_get() is called, as it currently generates an SCU
> > > fault reset if the remote core is already running and the kernel tries
> > > to enable the clock again. These changes are a follow up from a v1 sent
> > > to imx_rproc [2] and from a reported regression [3].
> > >
> > > [1] https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/
> > > [2] https://lore.kernel.org/lkml/20250423155131.101473-1-hiagofranco@gmail.com/
> > > [3] https://lore.kernel.org/lkml/20250404141713.ac2ntcsjsf7epdfa@hiago-nb/
> > >
> > > v6:
> > > - Added "reviewed by" from Ulf and Bjorn.
> > > - Fixed and improved commit descriptions of patches 2 and 3.
> > > - Improved the comment inside imx_rproc.c file.
> > > v5:
> > > - https://lore.kernel.org/all/20250617193450.183889-1-hiagofranco@gmail.com/
> > > v4:
> > > - https://lore.kernel.org/lkml/20250602131906.25751-1-hiagofranco@gmail.com/
> > > v3:
> > > - https://lore.kernel.org/all/20250519171514.61974-1-hiagofranco@gmail.com/
> > > v2:
> > > - https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/
> > > v1:
> > > - https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/
> > >
> > > Hiago De Franco (3):
> > >   pmdomain: core: introduce dev_pm_genpd_is_on()
> > >   remoteproc: imx_rproc: skip clock enable when M-core is managed by the
> > >     SCU
> > >   remoteproc: imx_rproc: detect and attach to pre-booted remote cores
> > >
> > >  drivers/pmdomain/core.c        | 33 +++++++++++++++++++++++++++
> > >  drivers/remoteproc/imx_rproc.c | 41 ++++++++++++++++++++++++++++------
> > >  include/linux/pm_domain.h      |  6 +++++
> > >  3 files changed, 73 insertions(+), 7 deletions(-)
> > >
> > > --
> > > 2.39.5
> > >

