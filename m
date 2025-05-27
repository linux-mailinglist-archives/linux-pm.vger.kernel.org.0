Return-Path: <linux-pm+bounces-27681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4B8AC4E03
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 13:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF4117D0D4
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA28262FF0;
	Tue, 27 May 2025 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rBaFXeJU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841C625DB13
	for <linux-pm@vger.kernel.org>; Tue, 27 May 2025 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748347166; cv=none; b=il4cME01gEFjF6dMl0yKG712kHF705R8QIhzspYg/1d8MU05QwguhXec6kME5hTB8zQGjHST0hTOmPifywn3jBRyT9E7LsYJNwcK7OClnFJLwbQoNTzQmmy9QEmWwtRV0Cz3FqSZt1eQDVIu/634cxh1FCFgZCbpX1In1y/B/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748347166; c=relaxed/simple;
	bh=U4dckQjpQfIhR/F8/iVTttXAf3SkdZoJAUKOCKjQq68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hy+906hvrongTdp+5wn5vP71qCGKxuaSi40rrw/ZnnXQaFBPFYHVeGl5DuVUy0g4F3TGCpZQYkdnjV+P29L+LOPGSoETwsxiGeeFEqAqdIThMh5vI/GPXuGobc76BPweU5PRMgCpykC1oZGXXuAI54oEU+crwQmXnFfv+JuxRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rBaFXeJU; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e7dc5f8148bso554276276.0
        for <linux-pm@vger.kernel.org>; Tue, 27 May 2025 04:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748347163; x=1748951963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f4szaLzc/F2h1MlyYwOny8uUmi1IH+zWJep2HTDgXGs=;
        b=rBaFXeJU+Csua0IA1lHvyXm1MdMEk9oHNBfuyauIP6YHrRhFw0Dx61ivSomX+CVV4b
         Z+E4JuvKDXagIo9HJN5WkY0ZoUeNgfhiohB+2MIUyaKrarc8rXUNPh/xJeSMsK/wQCHb
         A4FHAAgyrMIaWpqW2Dt/Xufq81SlxRUpI5CwdxZks+zq+LCb/orVxmUvS90V8PiiFuYp
         2L7DYraJj212AhE+5rsYkVHTwu8OHEsT2c3l9IA7Qljw7Wv0aMk0W9SY7xNRQo94R1cg
         bFn5pdWTMVWcr+icVuxQGCu8jfOmhXtBcTp1hCTaYD27Qzkldgz79pk5OstFswXmKAMU
         l/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748347163; x=1748951963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4szaLzc/F2h1MlyYwOny8uUmi1IH+zWJep2HTDgXGs=;
        b=cVFunQOzcFVkzYyZl+tNOMxMr33RXqYK4gilfoYUa2/MZIfmDb+a7NuUxj31fP03XM
         0EcBInf0hXyX7OQX4v/RZk7lDP10FiMhgx4+bjL8Q0Bqei9LMW858CNLlmH5B9sG7jwQ
         XGEs+u77FvcZX8inM8e5+MRxFAB8xTXru00F+8/IFDVIPAhsSqaofa5eiFdYjGA4SCjD
         bNnJf/4WiUFiijY++Wk/6TfnYTmpRs6nDX8+/Krhpf17s+D1M6goWNJyz9l5meJz5o3v
         jzXMxJL50hDlnAoAboigTccGDUHE1/orfYVETf97lrHIyPkmWiliWEswqHdYXlbNATUx
         FhDw==
X-Forwarded-Encrypted: i=1; AJvYcCXHdRSZzOahmh3KI5InCUdbLV7TrkzAR8gIWbHamRrRRgFVWXgg7ebbzsD2vkRPQ34XIm1ENTkc2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOEvzMBK0RB/zLdS1ZFDIMz86UNa+XeAkR38BbplD0A6nUXpp
	L6t48J7qTofTmfEV55rdS9slBVdqOJMnbm27lmB/CnJiyVj7ibCiULQu5dtAKEk3vMxX/QlslNK
	ZQHvBsOIJOHRpUKTb3i7IFQ/EBh7ll4pwRQ55GMEF7Bj5mPKvFLbF+NQAxA==
X-Gm-Gg: ASbGncuL9j50hvb1guNbzYaIvkjDni5wwaLG7BJK/hKyZDFd9nwp6cclnYOWJIxaLRS
	L97u4UxhSwZcKH8cWqorbvb6u2FRzV7DoKSS+4or5ngatpkwzFaMpd9RrLltk+yj6CRaY7rnHwi
	lczoQQ18TTKJZAAbaQRbn+19wFgJ74FqarPA==
X-Google-Smtp-Source: AGHT+IGKfe3vNrVmk4UJNSrzHf1HzxY3z+PLvn7rrFkkGWoEaq5BirzXQytDxVB9kstnSznqWcVD3oPaUzvTQgaFbac=
X-Received: by 2002:a05:6902:722:b0:e7d:c4e4:3295 with SMTP id
 3f1490d57ef6-e7dd031e2c1mr376900276.1.1748347163229; Tue, 27 May 2025
 04:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509191308.6i3ydftzork3sv5c@hiago-nb> <CAPDyKFpnLzk5YR3piksGhdB8ZoGNCzmweBTxm_rDX5=vjLFxqQ@mail.gmail.com>
 <20250519172357.vfnwehrbkk24vkge@hiago-nb> <CAPDyKFpGcgMzOUHf-JTRTLBviFdLdbjZKrMm8yd37ZqJ1nfkHw@mail.gmail.com>
 <20250521041306.GA28017@nxa18884-linux> <20250521041840.GB28017@nxa18884-linux>
 <CAPDyKFpSb+KsfDr1-=uk4TF4Op1dUQ9rDwPP5sSpMfxDRDhnZA@mail.gmail.com>
 <20250523191713.nylhi74jq6z4hqmr@hiago-nb> <CAPDyKFq6HG6iTZRnBSN25vhCU8Zj1c+r_ufGbiBsJ16N+1bJVg@mail.gmail.com>
 <20250527000510.fofehmsdhifcwlys@hiago-nb> <20250527023921.GA14252@nxa18884-linux>
In-Reply-To: <20250527023921.GA14252@nxa18884-linux>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 May 2025 13:58:46 +0200
X-Gm-Features: AX0GCFsGQsZvMPYEw23_m2_PwaUZ98TXNs_OMa1x3DVp8g7JgD3e4NzGOr3Ljfk
Message-ID: <CAPDyKFqZkcaGfss=Oi+H9UERFU29jY2t5uTPnGVGQgSAJSeCoA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
To: Hiago De Franco <hiagofranco@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, linux-pm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 May 2025 at 03:29, Peng Fan <peng.fan@oss.nxp.com> wrote:
>
> On Mon, May 26, 2025 at 09:05:10PM -0300, Hiago De Franco wrote:
> >On Mon, May 26, 2025 at 12:07:49PM +0200, Ulf Hansson wrote:
> >> On Fri, 23 May 2025 at 21:17, Hiago De Franco <hiagofranco@gmail.com> wrote:
> >> >
> >> > Hi Ulf,
> >> >
> >> > On Wed, May 21, 2025 at 02:11:02PM +0200, Ulf Hansson wrote:
> >> > > You should not provide any flag (or attach_data to
> >> > > dev_pm_domain_attach_list()) at all. In other words just call
> >> > > dev_pm_domain_attach_list(dev, NULL, &priv->pd_list), similar to how
> >> > > drivers/remoteproc/imx_dsp_rproc.c does it.
> >> > >
> >> > > In this way, the device_link is created by making the platform->dev
> >> > > the consumer and by keeping the supplier-devices (corresponding to the
> >> > > genpds) in RPM_SUSPENDED state.
> >> > >
> >> > > The PM domains (genpds) are then left in their current state, which
> >> > > should allow us to call dev_pm_genpd_is_on() for the corresponding
> >> > > supplier-devices, to figure out whether the bootloader turned them on
> >> > > or not, I think.
> >> > >
> >> > > Moreover, to make sure the genpds are turned on when needed, we also
> >> > > need to call pm_runtime_enable(platform->dev) and
> >> > > pm_runtime_get_sync(platform->dev). The easiest approach is probably
> >> > > to do that during ->probe() - and then as an improvement on top you
> >> > > may want to implement more fine-grained support for runtime PM.
> >> > >
> >> > > [...]
> >> > >
> >> > > Kind regards
> >> > > Uffe
> >> >
> >> > I did some tests here and I might be missing something. I used the
> >> > dev_pm_genpd_is_on() inside imx_rproc.c with the following changes:
> >> >
> >> > @@ -902,7 +902,12 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
> >> >         if (dev->pm_domain)
> >> >                 return 0;
> >> >
> >> >         ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
> >> > +       printk("hfranco: returned pd devs is %d", ret);
> >> > +       for (int i = 0; i < ret; i++) {
> >> > +               test = dev_pm_genpd_is_on(priv->pd_list->pd_devs[i]);
> >> > +               printk("hfranco: returned value is %d", test);
> >> > +       }
> >> >         return ret < 0 ? ret : 0;
> >> >  }
> >> >
> >> > This was a quick test to check the returned value, and it always return
> >> > 1 for both pds, even if I did not boot the remote core.
> >> >
> >> > So I was wondering if it was because of PD_FLAG_DEV_LINK_ON, I removed
> >> > it and passed NULL to dev_pm_domain_attach_list().
> >>
> >> Right, that's exactly what we should be doing.
> >>
> >> > Booting the kernel
> >> > now it correctly reports 0 for both pds, however when I start the
> >> > remote core with a hello world firmware and boot the kernel, the CPU
> >> > resets with a fault reset ("Reset cause: SCFW fault reset").
> >> >
> >> > I added both pm functions to probe, just to test:
> >> >
> >> > @@ -1152,6 +1158,9 @@ static int imx_rproc_probe(struct platform_device *pdev)
> >> >                 goto err_put_clk;
> >> >         }
> >> >
> >> > +       pm_runtime_enable(dev);
> >> > +       pm_runtime_get_sync(dev);
> >> > +
> >>
> >> Indeed, calling pm_runtime_enable() and then pm_runtime_get_sync()
> >> should turn on the PM domains for the device, which I assume is needed
> >> at some point.
> >>
> >> Although, I wonder if this may be a bit too late, I would expect that
> >> you at least need to call these *before* the call to rproc_add(), as I
> >> assume the rproc-core may start using the device/driver beyond that
> >> point.
> >>
> >> >         return 0
> >> >
> >> > Now the kernel boot with the remote core running, but it still returns
> >> > 0 from dev_pm_genpd_is_on(). So basically now it always returns 0, with
> >> > or without the remote core running.
> >>
> >> dev_pm_genpd_is_on() is returning the current status of the PM domain
> >> (genpd) for the device.
> >>
> >> Could it be that the genpd provider doesn't register its PM domains
> >> with the state that the HW is really in? pm_genpd_init() is the call
> >> that allows the genpd provider to specify the initial state.
> >>
> >> I think we need Peng's help here to understand what goes on.
> >>
> >> >
> >> > I tried to move pm_runtime_get_sync() to .prepare function but it make
> >> > the kernel not boot anymore (with the SCU fault reset).
> >>
> >> Try move pm_runtime_enable() before rproc_add().
> >
> >Thanks Ulf, that indeed made it work, at least now the kernel does not
> >reset anymore with the SCU fault reset. However I am still only getting
> >0 from dev_pm_genpd_is_on(), no matter what the state of the remote
> >core. Maybe I am missing something in between?
> >
> >Peng, do you know what could be the issue here?
>
> imx_rproc_attach_pd
>  ->dev_pm_domain_attach_list
>       ->genpd_dev_pm_attach_by_id
>               ->genpd_queue_power_off_work
>                  ->cm40_pid0 is powered off because the genpd is set with is_off=false
>
> So dev_pm_genpd_is_on will return false after attach.
>
> This means that with U-Boot kick M4, cm40 might be powered off when
> attaching the pd even with LINK_ON set, because genpd is set with is_off=false.
>
> The reason we set genpd to match real hardware status is to avoid RPC call
> and to save power. But seems it could not work well with U-boot kicking M4.
>
> I not have good idea on how to address this issue. The current driver
> could work with linux kick M4, M4 packed in flash.bin and M4 in a standalone
> partition.

Thanks for the detailed analysis!

This is a very similar issue as many other genpd providers are
suffering from - and something that I have been working on recently to
fix.

A few days ago I posted a new version of a series [1], which is based
upon using the fw_devlink and ->sync_state() support. In principle, we
need to prevent genpd from power-off a PM domain if it was powered-on
during boot , until all the consumer-drivers of a PM domain have been
probed.

I had a look at the DT description of how imx describes power-domain
providers/consumers, along with the corresponding genpd provider
implementation in drivers/pmdomain/imx/scu-pd.c. Unless I missed
something, I think [1] should do the trick for you, without any
further changes. Can you please give it a try and see if that solves
this problem?

[...]

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/

