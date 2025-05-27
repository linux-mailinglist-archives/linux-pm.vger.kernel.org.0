Return-Path: <linux-pm+bounces-27689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5756AC5025
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 15:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714A0171176
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 13:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3FD2673BD;
	Tue, 27 May 2025 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mExRjwBU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB316134CB;
	Tue, 27 May 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353535; cv=none; b=BByVL2iuvtLBDH3c1uXmoXUoapBz0BykmtsVuDfF7OUcoJJFJ2WiWoUfnQke8n6uKcHaliJwsqp8Po85GxunB9FYxBYh+Ji8ckCXQlybhPlRuhFKvdWhOjk5zk3IkvHn7g8T2sGKhzwxwc+M2eMiipnaoFMTWsJd62or+lm633M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353535; c=relaxed/simple;
	bh=dWadNyQe5NZ3KPaA0NCWArTpti0dxfrwBYDwSEczjFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEJkzEnKuXfULOBKc6zlcLIwPQ5hhhYVozgY36K5Lo05zRLegrDsejUL98nnuoDV3wk9LzM8n0df7u5+IDmTLx2Cd4Uy3dyTJJk3G7/sWtIASrPVD2ytXNEU9yI9NSSuja9RfUvTi9bdZ4Y0mRkwDRhjL+UD0AL5201BgMitCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mExRjwBU; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5240b014f47so967692e0c.1;
        Tue, 27 May 2025 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748353533; x=1748958333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGgb0gI0WsEnrlnk5sBAIi/zTeFlXCSw5R23gVgvlik=;
        b=mExRjwBU05p9WAiTrQqYU3RueJ3EroJLkTz7kknh7YoDLlQUJ1OUjQgfwYNV/+kY0U
         b7VQAYYa6bxC3aBvBr/UjjViizvyreeBl+aL8XHPXUJ5EKcpbvCTBBYJE1QpcoBdcT1R
         6fzNg+1FGLVMCaZS8iU5eX8HIVJybDXAPdLR808w8kNUvuBeBnkgB3O8w0iPFWYfAtVb
         yBySJuU/HuCkwmRO3S1cq2unbiM1CkwU0CaQRXI+CndwcIyOMvrn40Odi2Um7lXtoLCM
         AXOHpBUqrgOIH46QLsSFQZ0hFgNL7yLrqmiqLd5w4v26uVWVHKe5c7dDJZvceONS7E6L
         kUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353533; x=1748958333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGgb0gI0WsEnrlnk5sBAIi/zTeFlXCSw5R23gVgvlik=;
        b=rV3JT8KALlpkCOx63cWyhZcSECZFGnxG9dPl0UkAdxj01u1s075WhokMsgytEKV/H0
         PZ2SCEoJefzu0Bd2l+qclUx2JC/Eb5dmzs4pkFdwTtzz1qLTyx3bX0/9eWt2WYtEc3ts
         9gGeBHIeeL6sxxJn1GxcSAsso52E0dXED1uuF1decgrg/pFkZ8q6NELr3tI8dls83Cz2
         pWCaD70Fp64DSjKIcs+fqs1o9kOk+0kvd1Q+jVk32G+sJgynmaHszFXQsq52h4cQkamg
         GokLW9fWDxfXueynBlL+jxf7uBjeh9lAVHtthJAtU/jzbg5KEaiP/UAgD7660eB+fNFs
         NI4A==
X-Forwarded-Encrypted: i=1; AJvYcCVWMNiSDuEXbQcLHao38asCGEcd84Y5kxzTdzB9lRc+RhCU2GkrQQt4+2CHm2v99gQVTxefpHjE0rc=@vger.kernel.org, AJvYcCVxv6CX49UXRKmdxXyyufikkbpYrJtksBXxsxSb+8jajW+SClvTZ2xUnwXoizxrZtDqRfJF3FoYaZLib4Q=@vger.kernel.org, AJvYcCWIo/6UNVsaoR2wWI0L4J6ZsW0DoZ8aKljfJBZbehngYE07o82SyMQevyMlDTG41kQGgDNWG8KB7s9xvgzZZkOmLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTazC9f77K8hK/qFDj1JRv+FGK7pXyNHg1jPhYtQS5brd1Nuu
	7Xep4e9ByO5NFxTyU+DteNvBqeXXjlRKhjt/lSO4O1FpMm0KUFWg1fTR
X-Gm-Gg: ASbGncunavsgDDDFpSm/hqDYIEURmYNCLNY8i4RHTmA8KsT5pTLH6TYMxoiOr6tim6e
	rInDNsh3K41eexsvgX6ecVmQh7/8Lj2Y+oK+DJsvBbtYxoPylYrgNMiNDYVFZZNRRPDTIOPKfnu
	p+lCFe0VDqGIBI7WJhdMUwcuZ+8vWgBmx635vOLxWDJi+maX+ZCw3qxXBs7v9V9uqt7eFo6u65/
	eDBPk65NBpnl4kkFfagcg/BFCiGzy1YexuK5tDinjK4dH2aj9ld9jWwGIK32tteKJlqqeyYju+a
	ut/JkgxCh3jc0u1P9oXlb9ohuqJyz8ywXJ384U0hvncLnBz+GQ==
X-Google-Smtp-Source: AGHT+IE4BoE+wRq0vStmnqOD4qXT5MdjgPUfSxYYYKWtFbpYnegO3+6kCXHmykmhdGnIfdFOGCxs8g==
X-Received: by 2002:a05:6122:891:b0:529:2644:8c with SMTP id 71dfb90a1353d-52f2c58c9cfmr8165088e0c.8.1748353532620;
        Tue, 27 May 2025 06:45:32 -0700 (PDT)
Received: from hiago-nb ([2804:1b3:a7c1:78c2:1962:9d1:d346:d848])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52f6b9253fdsm2499564e0c.27.2025.05.27.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:45:31 -0700 (PDT)
Date: Tue, 27 May 2025 10:45:25 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peng Fan <peng.fan@oss.nxp.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
Message-ID: <20250527134525.f7yzs4ww64xxmjmr@hiago-nb>
References: <20250519172357.vfnwehrbkk24vkge@hiago-nb>
 <CAPDyKFpGcgMzOUHf-JTRTLBviFdLdbjZKrMm8yd37ZqJ1nfkHw@mail.gmail.com>
 <20250521041306.GA28017@nxa18884-linux>
 <20250521041840.GB28017@nxa18884-linux>
 <CAPDyKFpSb+KsfDr1-=uk4TF4Op1dUQ9rDwPP5sSpMfxDRDhnZA@mail.gmail.com>
 <20250523191713.nylhi74jq6z4hqmr@hiago-nb>
 <CAPDyKFq6HG6iTZRnBSN25vhCU8Zj1c+r_ufGbiBsJ16N+1bJVg@mail.gmail.com>
 <20250527000510.fofehmsdhifcwlys@hiago-nb>
 <20250527023921.GA14252@nxa18884-linux>
 <CAPDyKFqZkcaGfss=Oi+H9UERFU29jY2t5uTPnGVGQgSAJSeCoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqZkcaGfss=Oi+H9UERFU29jY2t5uTPnGVGQgSAJSeCoA@mail.gmail.com>

On Tue, May 27, 2025 at 01:58:46PM +0200, Ulf Hansson wrote:
> On Tue, 27 May 2025 at 03:29, Peng Fan <peng.fan@oss.nxp.com> wrote:
> >
> > On Mon, May 26, 2025 at 09:05:10PM -0300, Hiago De Franco wrote:
> > >On Mon, May 26, 2025 at 12:07:49PM +0200, Ulf Hansson wrote:
> > >> On Fri, 23 May 2025 at 21:17, Hiago De Franco <hiagofranco@gmail.com> wrote:
> > >> >
> > >> > Hi Ulf,
> > >> >
> > >> > On Wed, May 21, 2025 at 02:11:02PM +0200, Ulf Hansson wrote:
> > >> > > You should not provide any flag (or attach_data to
> > >> > > dev_pm_domain_attach_list()) at all. In other words just call
> > >> > > dev_pm_domain_attach_list(dev, NULL, &priv->pd_list), similar to how
> > >> > > drivers/remoteproc/imx_dsp_rproc.c does it.
> > >> > >
> > >> > > In this way, the device_link is created by making the platform->dev
> > >> > > the consumer and by keeping the supplier-devices (corresponding to the
> > >> > > genpds) in RPM_SUSPENDED state.
> > >> > >
> > >> > > The PM domains (genpds) are then left in their current state, which
> > >> > > should allow us to call dev_pm_genpd_is_on() for the corresponding
> > >> > > supplier-devices, to figure out whether the bootloader turned them on
> > >> > > or not, I think.
> > >> > >
> > >> > > Moreover, to make sure the genpds are turned on when needed, we also
> > >> > > need to call pm_runtime_enable(platform->dev) and
> > >> > > pm_runtime_get_sync(platform->dev). The easiest approach is probably
> > >> > > to do that during ->probe() - and then as an improvement on top you
> > >> > > may want to implement more fine-grained support for runtime PM.
> > >> > >
> > >> > > [...]
> > >> > >
> > >> > > Kind regards
> > >> > > Uffe
> > >> >
> > >> > I did some tests here and I might be missing something. I used the
> > >> > dev_pm_genpd_is_on() inside imx_rproc.c with the following changes:
> > >> >
> > >> > @@ -902,7 +902,12 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
> > >> >         if (dev->pm_domain)
> > >> >                 return 0;
> > >> >
> > >> >         ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
> > >> > +       printk("hfranco: returned pd devs is %d", ret);
> > >> > +       for (int i = 0; i < ret; i++) {
> > >> > +               test = dev_pm_genpd_is_on(priv->pd_list->pd_devs[i]);
> > >> > +               printk("hfranco: returned value is %d", test);
> > >> > +       }
> > >> >         return ret < 0 ? ret : 0;
> > >> >  }
> > >> >
> > >> > This was a quick test to check the returned value, and it always return
> > >> > 1 for both pds, even if I did not boot the remote core.
> > >> >
> > >> > So I was wondering if it was because of PD_FLAG_DEV_LINK_ON, I removed
> > >> > it and passed NULL to dev_pm_domain_attach_list().
> > >>
> > >> Right, that's exactly what we should be doing.
> > >>
> > >> > Booting the kernel
> > >> > now it correctly reports 0 for both pds, however when I start the
> > >> > remote core with a hello world firmware and boot the kernel, the CPU
> > >> > resets with a fault reset ("Reset cause: SCFW fault reset").
> > >> >
> > >> > I added both pm functions to probe, just to test:
> > >> >
> > >> > @@ -1152,6 +1158,9 @@ static int imx_rproc_probe(struct platform_device *pdev)
> > >> >                 goto err_put_clk;
> > >> >         }
> > >> >
> > >> > +       pm_runtime_enable(dev);
> > >> > +       pm_runtime_get_sync(dev);
> > >> > +
> > >>
> > >> Indeed, calling pm_runtime_enable() and then pm_runtime_get_sync()
> > >> should turn on the PM domains for the device, which I assume is needed
> > >> at some point.
> > >>
> > >> Although, I wonder if this may be a bit too late, I would expect that
> > >> you at least need to call these *before* the call to rproc_add(), as I
> > >> assume the rproc-core may start using the device/driver beyond that
> > >> point.
> > >>
> > >> >         return 0
> > >> >
> > >> > Now the kernel boot with the remote core running, but it still returns
> > >> > 0 from dev_pm_genpd_is_on(). So basically now it always returns 0, with
> > >> > or without the remote core running.
> > >>
> > >> dev_pm_genpd_is_on() is returning the current status of the PM domain
> > >> (genpd) for the device.
> > >>
> > >> Could it be that the genpd provider doesn't register its PM domains
> > >> with the state that the HW is really in? pm_genpd_init() is the call
> > >> that allows the genpd provider to specify the initial state.
> > >>
> > >> I think we need Peng's help here to understand what goes on.
> > >>
> > >> >
> > >> > I tried to move pm_runtime_get_sync() to .prepare function but it make
> > >> > the kernel not boot anymore (with the SCU fault reset).
> > >>
> > >> Try move pm_runtime_enable() before rproc_add().
> > >
> > >Thanks Ulf, that indeed made it work, at least now the kernel does not
> > >reset anymore with the SCU fault reset. However I am still only getting
> > >0 from dev_pm_genpd_is_on(), no matter what the state of the remote
> > >core. Maybe I am missing something in between?
> > >
> > >Peng, do you know what could be the issue here?
> >
> > imx_rproc_attach_pd
> >  ->dev_pm_domain_attach_list
> >       ->genpd_dev_pm_attach_by_id
> >               ->genpd_queue_power_off_work
> >                  ->cm40_pid0 is powered off because the genpd is set with is_off=false
> >
> > So dev_pm_genpd_is_on will return false after attach.
> >
> > This means that with U-Boot kick M4, cm40 might be powered off when
> > attaching the pd even with LINK_ON set, because genpd is set with is_off=false.
> >
> > The reason we set genpd to match real hardware status is to avoid RPC call
> > and to save power. But seems it could not work well with U-boot kicking M4.
> >
> > I not have good idea on how to address this issue. The current driver
> > could work with linux kick M4, M4 packed in flash.bin and M4 in a standalone
> > partition.
> 
> Thanks for the detailed analysis!
> 
> This is a very similar issue as many other genpd providers are
> suffering from - and something that I have been working on recently to
> fix.
> 
> A few days ago I posted a new version of a series [1], which is based
> upon using the fw_devlink and ->sync_state() support. In principle, we
> need to prevent genpd from power-off a PM domain if it was powered-on
> during boot , until all the consumer-drivers of a PM domain have been
> probed.
> 
> I had a look at the DT description of how imx describes power-domain
> providers/consumers, along with the corresponding genpd provider
> implementation in drivers/pmdomain/imx/scu-pd.c. Unless I missed
> something, I think [1] should do the trick for you, without any
> further changes. Can you please give it a try and see if that solves
> this problem?

Cool! I can give a try and provide an answer soon. Thanks!

> 
> [...]
> 
> Kind regards
> Uffe
> 
> [1]
> https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/

Best regards,
Hiago

