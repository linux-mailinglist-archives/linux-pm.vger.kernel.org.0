Return-Path: <linux-pm+bounces-34453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF53DB52E43
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 12:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E801C1BC7402
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F002130FF21;
	Thu, 11 Sep 2025 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMfx2t96"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118B265CC9
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586349; cv=none; b=b0lBAU1Pb2r0og1KgZhAxGdAX5ExBjukWjXvxuBUSJOMIwR9tlzBLuNnIAcFACgFg3b6YpUe6wtozQCDN1S8JvNLN5LZsKZLmVHZ3FznyaMv0pR+HJTInECzwMa2t4cNzsSX2PD4RZWMKRxdpd41Lov3uJt5yP0kD6xB9SYbZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586349; c=relaxed/simple;
	bh=HCJdonPKLov6xMKe9itZ7eqPhfT6RLprJ1LItmPQQWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJbm6PYvxnBtwkzAjGza5KtymFQBgupkktuLIi8O+Eimd6ylmNPeMKzEyekpKOUGqNwTtkBvg0rVWlf1fbfO2QJMx0FNmcKu/V6fWliq27/gUOSfQPbND+ny3lR8xS3nNiSWyQA9tBnMzEuy1e8k4nUN/UxKhGkbNfUPu5GYjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oMfx2t96; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e96ee32f86bso335230276.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 03:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757586347; x=1758191147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh9CoKh+ZXVGj6kTKZS0aB5YRv820luNzFDKgz4XQQE=;
        b=oMfx2t96EIBA0GOaiaXlDydr2AMGCoXpr3CBKjxXiWG3ukBQAwet32wd8Mmnm/w/yY
         2gs40oSC/aPOzujogITyeU1iZzr49jz6VLjkIx+3gnyubvbMBxBJ9i8Ti5x2JF32Sc7x
         JJkTBMH2ykJEEpvw77ctCkx2eVV5dBFpabPT5En4KvCeShH7rFzTXFTwrATymXUu1IKP
         vJsZ6ZiKS3XMaN9GzIvsA5fIvZDCczJWxO24aClKfH1a0g+nZpLiN9JlZYdP2BW/f459
         +doJEHGMG+1BjycoEO9O92AOjLXxpi1/2OTGaThrtkGDV7yWmJW85ispAHcxua5dXYSF
         B7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757586347; x=1758191147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qh9CoKh+ZXVGj6kTKZS0aB5YRv820luNzFDKgz4XQQE=;
        b=iLh0NF+t6pVBWI/loIyHv1v791zhFX5Zd05aJvBk7ujswKGkQy5SkW0yInmteHcXYj
         6+GLDgAEylHXLzOg3/hX6ROiCtu6RM6sKe4goQezN9DizqYRMbEJ/5955KBoQ1zxMwmA
         I4TmMDfILd0iDs08pBiENYZURK8YlXvwR3eOeAgCn2JE6tmcdRsPOBzSiM6BoP0I7LIT
         mpXl7ynv/agLKXW16GiVe58iqnVJ/yLUiaKe06B1o6gGr3D4FmOnOEf8AFO+L8Zc7HaA
         OqydqQwxC94JV3JbDOju6rNoGC6qCDbJUWNcBEmN0+Heq3c0j0lygbRpxp77cnPn2sVi
         V5ug==
X-Forwarded-Encrypted: i=1; AJvYcCXVSSlQmCCTfTuaK2QhVXsod+0P4nx4w7O77M/SNzQgXklctO3m7OCww7zljgI813/jAwLbEAUYfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWkD/HaLPomp0Z4zV0B1Er6RJuR0/kbhJPKAp8cmIUGRxlN8y
	T3Qnfh9ODpEpfoHMO+8XpZDAIELPNPThTtCO/TY+d2j0ksFNpc7uqHzCFVnfTWIDWNYAID4hoEk
	grRZo48fVmvIFqCkTqNzvQfTKbvlwvmmZV6c79R6o5Q==
X-Gm-Gg: ASbGncsjQUEGTdtZJNQNG3OJdEXzGtNKpngh9fD87x76RMVtSuxK/599hviL8FwJ99j
	e+CvVHKGlYL2FG8GZ2uQoADa6/4+uo2iC/EMpoQuU2HLRuyCViBsDf8iL1KPLbpC37v1ax8Ss+v
	pisnbFZ9y9EsHQwhQjliT3PBGNa/ra+CN/6CUiKwRXcmvN84UuRjkTJ05JOTNOdtrYFVtza/bv+
	s5cyi9+
X-Google-Smtp-Source: AGHT+IG3s4IJNZMJSCEDBH6fNAyZFvVket6EtCNxPtuvOXrrmrIogMrgaGfvzIvNzamapqOCag5fTU5WzoWDmiZ5pgw=
X-Received: by 2002:a05:6902:2a4a:b0:e98:9926:e5cf with SMTP id
 3f1490d57ef6-e9f6798f570mr15236689276.24.1757586347029; Thu, 11 Sep 2025
 03:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909111130.132976-1-ulf.hansson@linaro.org>
 <20250909111130.132976-2-ulf.hansson@linaro.org> <CAMuHMdUFXioe36r9mzNchHw3DGyEiVA-=ajTp333jowEsrxMNw@mail.gmail.com>
In-Reply-To: <CAMuHMdUFXioe36r9mzNchHw3DGyEiVA-=ajTp333jowEsrxMNw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Sep 2025 12:25:09 +0200
X-Gm-Features: Ac12FXzECRIqMODIi1UrVX0E7YEVWHDVwJFOM_t49DQAOVwqsE-keud9aiJ5lYc
Message-ID: <CAPDyKFrTTUs2xwoY+Tmff1SHhsGjj-XmW3maDnO7V6T7m_8H=Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] pmdomain: core: Restore behaviour for disabling
 unused PM domains
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org, 
	Stephen Boyd <sboyd@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 09:56, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Tue, 9 Sept 2025 at 13:11, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > Recent changes to genpd prevents those PM domains being powered-on during
> > initialization from being powered-off during the boot sequence. Based upon
> > whether CONFIG_PM_CONFIG_PM_GENERIC_DOMAINS_OF is set of not, genpd relies
> > on the sync_state mechanism or the genpd_power_off_unused() (which is a
> > late_initcall_sync), to understand when it's okay to allow these PM domains
> > to be powered-off.
> >
> > This new behaviour in genpd has lead to problems on different platforms.
> > Let's therefore restore the behavior of genpd_power_off_unused().
> > Moreover, let's introduce GENPD_FLAG_NO_STAY_ON, to allow genpd OF
> > providers to opt-out from the new behaviour.
> >
> > Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Link: https://lore.kernel.org/all/20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com/
> > Reported-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> > Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -115,6 +115,12 @@ struct dev_pm_domain_list {
> >   *                             genpd provider specific way, likely through a
> >   *                             parent device node. This flag makes genpd to
> >   *                             skip its internal support for this.
> > + *
> > + * GENPD_FLAG_NO_STAY_ON:      For genpd OF providers a powered-on PM domain at
> > + *                             initialization is prevented from being
> > + *                             powered-off until the ->sync_state() callback is
> > + *                             invoked. This flag informs genpd to allow a
> > + *                             power-off without waiting for ->sync_state().
>
> This also restores power-down of pmdomains after a failed device
> probe (due to a real issue, or just -EPROBE_DEFER), possibly
> interfering with other devices that are part of the same pmdomain(s)
> but haven't been probed yet. E.g. what if your serial console is
> part of the same pmdomain?  Probably the pmdomain(s) should not
> be powered down immediately, but only later, when either sync state
> or genpd_power_off_unused() kicks in.

That is exactly one of the problems we solve with the new sync_state
support in genpd.

If you have this problem for one of the PM domains, we should not set
GENPD_FLAG_NO_STAY_ON for it. In fact, that's exactly why I added this
flag, to allow it to be set on a per genpd basis. Otherwise we might
as well have used of_genpd_sync_state().

Down the road, if we can improve the sync_state support in genpd,
especially a more fine-grained control for those providers that use
of_genpd_add_provider_onecell(), I hope we should be able to remove
this flag.

[...]

Kind regards
Uffe

