Return-Path: <linux-pm+bounces-27645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BA4AC3DB2
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 12:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAADD1894FFA
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 10:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2611F4187;
	Mon, 26 May 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Spq1EHqX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23E619F424
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748254109; cv=none; b=XfbkjffgbwW/d2NgiNQGZ5otEYHyP578I3IOAH9IMf4GTdVWd1G7EEHmeZ9BYr3WVkOzFJJEWJedesuWzfkpmMsjxQFTiwjs3inhzd35HxxBEF4aPfBGnR8Uz8WKw9d8EAU3vzMvbwJ1uSY0K/anycMPVRCx1fsrxULqtlhiOKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748254109; c=relaxed/simple;
	bh=RssPTTSlOi3uPhFyxHYOhka1vxO3+iE4N6adykha/8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTSWn7w8TDYgPxrEtj7QPBQvMiCmhPNryrd7IjTp53CwWeUVP8HNLTenCTdvp0UsQOA9fspBrUXeb2bsn0BYQpQ/sbgH9VrXT4trBQjtgWwe0VqZ00Ct4p/DAVQ9ZFciR8jlxOrGQHh2TvdJ2YLCbDFcaXIjfQGEibzViqIDZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Spq1EHqX; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e75668006b9so1563260276.3
        for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748254106; x=1748858906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NpPv+jwx+sCOwe5Xg7tTvOuLFtJsEPCNaLZVy2I7eGY=;
        b=Spq1EHqXbIGNlg8Q0GD1Yo9/3bvEJqFPG812dFxbLji/uK0kQjjyLHvZUht+9GvYRM
         Y887wY4XJ4FhVokSF9aCttMUiaNtIk77o5WaMFJjK5DKTlXZmZAlzMhCfGYPbLaaj8TT
         F+0mUzb5A0qLF7UTSlADuiQKQkOecHZQM9Em9IpU5oCHYDWlEVjUQUYzZ89baHq1nSZ1
         +B1BdsEBnZ1UpX60FLeY4BgiMlMzP2lqEry0mOAoHHFkedBXE5r8MB2Fl8r+GVvUYut4
         ctRghzxNgRm5akLx3a0u8p8Km5ASdCEhEOX2a5wN0hD+mybJpcp8LbwEsikO+0PwlxzP
         OVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748254106; x=1748858906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpPv+jwx+sCOwe5Xg7tTvOuLFtJsEPCNaLZVy2I7eGY=;
        b=EoFuHxYpyWjxsc1toiu5K5bg33j/dnpXwVoW/zl3DdH1Wb5l777bpQcY/2jaxg1bY1
         p012EytcoJWC0VMMP3HxoA3zsBnT4MX6V4i0X1FxAx6xzxboGoKXf6KXHyKq+i98XGNV
         XAc6kung2Bz95aPvyA+V2L5fqTIIekYfT5XLuEQZvMaCbroWxydfPZZ+ZdThoFPRDnj1
         /ojFIPhvKYwMzxexcAGTx2rUyYXjpGbyZLMShUKFyI/wREb2RjKx10b7ttpuBgnrGw0D
         CfWzVMUZwcK2Yb6erlOx89fnpvJBBsNcGq7osFt3tzjE/mSUD/ECoqknik/3p7l7tDJK
         JIMA==
X-Forwarded-Encrypted: i=1; AJvYcCXqSSK8Ix33dK7bY2Tu/cJBYsaRgynbneaFWQGx4eWSQpF2rWvXPFHMbXm0MygxoEjZfoDS9iMw5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuPT9CE6kfexRMwqbUDq5lEWLJ1vYELZ2Zw3DEvEY3iRThwRLy
	7mXHqtN+oT3iAQ+dKQcbuYeeKRoiEBlca9HjNz21ljYY8CEFvNDxRH2znCqTpOPY4fHVhh4boo7
	pTS2MsCCAa9toYAffDOwDnhlW5sTyXSW7ASj7jsJYQw==
X-Gm-Gg: ASbGnct962qy+uivBfhb99++3PiYx+uR0+AnmlyWIwPQqee9gM+CbTjOBK49a0J0Om1
	Wz6VwkDH4h4j/6qGkIV3zEQT4X49f7VhMHB+jUcvHejnj9i4SERkQ8gAnjpbWNJa7G/+tBZWr84
	nhAczuRtZvvpeyEhaqD6x5k7GkZZ5sdnghuA==
X-Google-Smtp-Source: AGHT+IFdBGTGYZOotDK/y3Q59f0r8dFms0TkmjC4C0sHaJmgkuM3Am4LonkHZ4KeqelTVat8o4uyIxhJmZyFRyDPL7U=
X-Received: by 2002:a05:6902:160d:b0:e7d:b8ce:cb91 with SMTP id
 3f1490d57ef6-e7db8cecd3dmr1219626276.5.1748254105723; Mon, 26 May 2025
 03:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDyKFrHD1hVCfOK-JV5FJM+Cd9DoKKZGKcC94fxx6_9Bsri1g@mail.gmail.com>
 <20250508202826.33bke6atcvqdkfa4@hiago-nb> <CAPDyKFr3yF=yYZ=Xo5FicvSbDPOTx7+fMwc8dMCLYKPBMEtCKA@mail.gmail.com>
 <20250509191308.6i3ydftzork3sv5c@hiago-nb> <CAPDyKFpnLzk5YR3piksGhdB8ZoGNCzmweBTxm_rDX5=vjLFxqQ@mail.gmail.com>
 <20250519172357.vfnwehrbkk24vkge@hiago-nb> <CAPDyKFpGcgMzOUHf-JTRTLBviFdLdbjZKrMm8yd37ZqJ1nfkHw@mail.gmail.com>
 <20250521041306.GA28017@nxa18884-linux> <20250521041840.GB28017@nxa18884-linux>
 <CAPDyKFpSb+KsfDr1-=uk4TF4Op1dUQ9rDwPP5sSpMfxDRDhnZA@mail.gmail.com> <20250523191713.nylhi74jq6z4hqmr@hiago-nb>
In-Reply-To: <20250523191713.nylhi74jq6z4hqmr@hiago-nb>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 26 May 2025 12:07:49 +0200
X-Gm-Features: AX0GCFtV9JrsWnRtXpr1h2X2HDFYAFvpBaxszSIspVyj2HxlBm4_wnbvi_OW3II
Message-ID: <CAPDyKFq6HG6iTZRnBSN25vhCU8Zj1c+r_ufGbiBsJ16N+1bJVg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Bjorn Andersson <andersson@kernel.org>, Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 May 2025 at 21:17, Hiago De Franco <hiagofranco@gmail.com> wrote:
>
> Hi Ulf,
>
> On Wed, May 21, 2025 at 02:11:02PM +0200, Ulf Hansson wrote:
> > You should not provide any flag (or attach_data to
> > dev_pm_domain_attach_list()) at all. In other words just call
> > dev_pm_domain_attach_list(dev, NULL, &priv->pd_list), similar to how
> > drivers/remoteproc/imx_dsp_rproc.c does it.
> >
> > In this way, the device_link is created by making the platform->dev
> > the consumer and by keeping the supplier-devices (corresponding to the
> > genpds) in RPM_SUSPENDED state.
> >
> > The PM domains (genpds) are then left in their current state, which
> > should allow us to call dev_pm_genpd_is_on() for the corresponding
> > supplier-devices, to figure out whether the bootloader turned them on
> > or not, I think.
> >
> > Moreover, to make sure the genpds are turned on when needed, we also
> > need to call pm_runtime_enable(platform->dev) and
> > pm_runtime_get_sync(platform->dev). The easiest approach is probably
> > to do that during ->probe() - and then as an improvement on top you
> > may want to implement more fine-grained support for runtime PM.
> >
> > [...]
> >
> > Kind regards
> > Uffe
>
> I did some tests here and I might be missing something. I used the
> dev_pm_genpd_is_on() inside imx_rproc.c with the following changes:
>
> @@ -902,7 +902,12 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
>         if (dev->pm_domain)
>                 return 0;
>
>         ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
> +       printk("hfranco: returned pd devs is %d", ret);
> +       for (int i = 0; i < ret; i++) {
> +               test = dev_pm_genpd_is_on(priv->pd_list->pd_devs[i]);
> +               printk("hfranco: returned value is %d", test);
> +       }
>         return ret < 0 ? ret : 0;
>  }
>
> This was a quick test to check the returned value, and it always return
> 1 for both pds, even if I did not boot the remote core.
>
> So I was wondering if it was because of PD_FLAG_DEV_LINK_ON, I removed
> it and passed NULL to dev_pm_domain_attach_list().

Right, that's exactly what we should be doing.

> Booting the kernel
> now it correctly reports 0 for both pds, however when I start the
> remote core with a hello world firmware and boot the kernel, the CPU
> resets with a fault reset ("Reset cause: SCFW fault reset").
>
> I added both pm functions to probe, just to test:
>
> @@ -1152,6 +1158,9 @@ static int imx_rproc_probe(struct platform_device *pdev)
>                 goto err_put_clk;
>         }
>
> +       pm_runtime_enable(dev);
> +       pm_runtime_get_sync(dev);
> +

Indeed, calling pm_runtime_enable() and then pm_runtime_get_sync()
should turn on the PM domains for the device, which I assume is needed
at some point.

Although, I wonder if this may be a bit too late, I would expect that
you at least need to call these *before* the call to rproc_add(), as I
assume the rproc-core may start using the device/driver beyond that
point.

>         return 0
>
> Now the kernel boot with the remote core running, but it still returns
> 0 from dev_pm_genpd_is_on(). So basically now it always returns 0, with
> or without the remote core running.

dev_pm_genpd_is_on() is returning the current status of the PM domain
(genpd) for the device.

Could it be that the genpd provider doesn't register its PM domains
with the state that the HW is really in? pm_genpd_init() is the call
that allows the genpd provider to specify the initial state.

I think we need Peng's help here to understand what goes on.

>
> I tried to move pm_runtime_get_sync() to .prepare function but it make
> the kernel not boot anymore (with the SCU fault reset).

Try move pm_runtime_enable() before rproc_add().

>
> Do you have any suggestions? Am I doing something wrong with these PDs?
>
> Best regards,
> Hiago.

Kind regards
Uffe

