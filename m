Return-Path: <linux-pm+bounces-27670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B80BAC45A2
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 02:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCB516B19F
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 00:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD646BF;
	Tue, 27 May 2025 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXOjpeYl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825F2CA8;
	Tue, 27 May 2025 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748304320; cv=none; b=lkILF+n/pPmkVspnWQxfjGp/vnYL6ksb4DQmo7NPqMWLb6d61rm+dxo3F2VVSmv2A/xjHWk3qDy8wjDFII7xGn0uyecI/n5Vqi0RKpKkHSIXIiWBMudwKxVIZJwSIDmWeIaZkO3Pjqm4wgynmLWg6kNtzPVZoWkkMTS+iGoMLeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748304320; c=relaxed/simple;
	bh=r1xxob3cHvQ50YeOPa143G4Cs++QqeFJ5fmfOzctg5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXptfkrOxaTwvJwqewfJCBbfU5NNuKE3Y/TB88otfkK9FaN01cPqb5YHATMr4NL+FePzklPoxXsKdE9LP2l24lhFgyUCAHPBa+tHj+1F2q695mAZdjZw+za2yncYktOHFnyCV3QNDjczJCtLDbHgdUmUbgD8PRkh8L/ugRXNaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXOjpeYl; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-52b2290e292so821530e0c.3;
        Mon, 26 May 2025 17:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748304317; x=1748909117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Addthv64Q3TTSQf/2nFhVGk8jr68iUDk2g8AigrRaGQ=;
        b=kXOjpeYlXieH0mFDV7Bm+IDR9nTfnGhvagPXdH+fhDQ/Jr9svf3eVGNlwTRBgAuJDW
         Nr8uizeV79Cj7sZM4sfo5mCfKBsnwl8mzZoyaXh82GHqHd1F6y9P9rKcSI9h8/Iw0YSe
         dSpaFu8nEYBTuLgX7SrmU04I+0EzrVgtF9ZNqKBZgr8P1QLGYPonlCCvzQJIUmVnkjc6
         BlmQEiXiY8FtMT4M+Roy9DQoF2eIGs4US9iFDRD7ncds6L6jnjZsf9G0xYp2Dn4zLSL6
         +D+V5QpLGB2wP/haHtGtAnHKEhEH+Je3/pjt7cr+pArad7+21Cr7MBQLoaK0jNNbpvm5
         xtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748304317; x=1748909117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Addthv64Q3TTSQf/2nFhVGk8jr68iUDk2g8AigrRaGQ=;
        b=E6i6tpmvf85KPBe7rvIf/1cPUCHQ4xKpZrKrdbKJQZL7adXx6T6prhst2rYMvQWk6e
         qE4lDd8DbPXYg3+4bCXJhr76hSGEGgGxK815h3aOSa6Ynq4i+s2pDgQNDh2vh5xRb45y
         BMSSOs2HR+tQYtXjq8UIz6Hm6TVdCyiCnxLcXDrB7Gb0inSrSVcmwGsr9SkN327ZV9/3
         djuS02sIq/EE9uOVaE7qzdOdVO7CzqNmbSK7MrhtVeqtNg2cO+Ahd4xHqE8JPCVp4V2y
         32Os4F0da29fpZtqH3t/wJzallarfwAQvVbECQl9Fadw21uWNy9f/xUokqCS8TZCWmoB
         y6vg==
X-Forwarded-Encrypted: i=1; AJvYcCVpBXgPdvIKNV5AUltYaYc7TwKeYS3DbN4WHR91np9/F19Cxx0at0/hiPhsxewKXth/HT8Ih5GpPqYMrPw=@vger.kernel.org, AJvYcCX7/EnIV3oi75n2/KJ255zkeUSsrL0TT70B5azvkiJmqGelNL0zfQJF1UNCYAeULJ6qyfUxplwetGM=@vger.kernel.org, AJvYcCXp55v/Fs8oGz1vI2NUn3Wbig4HPA5SQvEm41+1HD3aBBwKm/67Eqnz42z7rQUrNbX71q5Ou9H3heSr6cdiOGwXZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJ18zlLIaCgVTcXJLsznYRxi/pAkP+sLf+MOQBdhxjN4UANRW
	BHd2z4Y8Y4q5ohukKN1B/jI2e6cj0K5AmHAs58PyH+eGUYDoqI2IQbbj
X-Gm-Gg: ASbGncvLe/vRkrkCA+qR+A061DQAtyYUVlsytojzDCctcA8nPpW+Xs2vNka/o/xzBMZ
	Si4ZfsYCOJP61pAkbVLEwDKcUXT1b/GJwSzsUnI/bM3Y9X4DqrBU/PcOFVcps3Q5dTrznjCnU0L
	VlXXbsE9fVDj5W0hpFR3eKkgZtwJeZml+pm4bnl3rCvHLWU+XGbwcN1uCXweiXJTIrtzBmYwIS2
	jgCVPr2S0aR1xpX7YfvbRC4Y4Y91TMFSMIqHZGodXZdHO6T0Jy5dGko0V86gRoAcrwt0EgUwhWB
	QiQnUnaWfQB+VFEKKJixL9SnOwRbGHcOAScyy0PtflULc60Sox8=
X-Google-Smtp-Source: AGHT+IHEjq49q8FhVaC/VV5WmHQM/CAYARQEncGZ9g1VnXXQ7c/Eg+DEVGvPVjcXeeAr8+7lupfz7w==
X-Received: by 2002:a05:6122:169b:b0:52a:863f:4189 with SMTP id 71dfb90a1353d-52f2c5923f8mr7340486e0c.8.1748304317399;
        Mon, 26 May 2025 17:05:17 -0700 (PDT)
Received: from hiago-nb ([2804:1b3:a7c1:78c2:1931:19db:1830:5cf4])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52f2f73d4b4sm4433946e0c.20.2025.05.26.17.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 17:05:16 -0700 (PDT)
Date: Mon, 26 May 2025 21:05:10 -0300
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
Message-ID: <20250527000510.fofehmsdhifcwlys@hiago-nb>
References: <CAPDyKFr3yF=yYZ=Xo5FicvSbDPOTx7+fMwc8dMCLYKPBMEtCKA@mail.gmail.com>
 <20250509191308.6i3ydftzork3sv5c@hiago-nb>
 <CAPDyKFpnLzk5YR3piksGhdB8ZoGNCzmweBTxm_rDX5=vjLFxqQ@mail.gmail.com>
 <20250519172357.vfnwehrbkk24vkge@hiago-nb>
 <CAPDyKFpGcgMzOUHf-JTRTLBviFdLdbjZKrMm8yd37ZqJ1nfkHw@mail.gmail.com>
 <20250521041306.GA28017@nxa18884-linux>
 <20250521041840.GB28017@nxa18884-linux>
 <CAPDyKFpSb+KsfDr1-=uk4TF4Op1dUQ9rDwPP5sSpMfxDRDhnZA@mail.gmail.com>
 <20250523191713.nylhi74jq6z4hqmr@hiago-nb>
 <CAPDyKFq6HG6iTZRnBSN25vhCU8Zj1c+r_ufGbiBsJ16N+1bJVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq6HG6iTZRnBSN25vhCU8Zj1c+r_ufGbiBsJ16N+1bJVg@mail.gmail.com>

On Mon, May 26, 2025 at 12:07:49PM +0200, Ulf Hansson wrote:
> On Fri, 23 May 2025 at 21:17, Hiago De Franco <hiagofranco@gmail.com> wrote:
> >
> > Hi Ulf,
> >
> > On Wed, May 21, 2025 at 02:11:02PM +0200, Ulf Hansson wrote:
> > > You should not provide any flag (or attach_data to
> > > dev_pm_domain_attach_list()) at all. In other words just call
> > > dev_pm_domain_attach_list(dev, NULL, &priv->pd_list), similar to how
> > > drivers/remoteproc/imx_dsp_rproc.c does it.
> > >
> > > In this way, the device_link is created by making the platform->dev
> > > the consumer and by keeping the supplier-devices (corresponding to the
> > > genpds) in RPM_SUSPENDED state.
> > >
> > > The PM domains (genpds) are then left in their current state, which
> > > should allow us to call dev_pm_genpd_is_on() for the corresponding
> > > supplier-devices, to figure out whether the bootloader turned them on
> > > or not, I think.
> > >
> > > Moreover, to make sure the genpds are turned on when needed, we also
> > > need to call pm_runtime_enable(platform->dev) and
> > > pm_runtime_get_sync(platform->dev). The easiest approach is probably
> > > to do that during ->probe() - and then as an improvement on top you
> > > may want to implement more fine-grained support for runtime PM.
> > >
> > > [...]
> > >
> > > Kind regards
> > > Uffe
> >
> > I did some tests here and I might be missing something. I used the
> > dev_pm_genpd_is_on() inside imx_rproc.c with the following changes:
> >
> > @@ -902,7 +902,12 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
> >         if (dev->pm_domain)
> >                 return 0;
> >
> >         ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
> > +       printk("hfranco: returned pd devs is %d", ret);
> > +       for (int i = 0; i < ret; i++) {
> > +               test = dev_pm_genpd_is_on(priv->pd_list->pd_devs[i]);
> > +               printk("hfranco: returned value is %d", test);
> > +       }
> >         return ret < 0 ? ret : 0;
> >  }
> >
> > This was a quick test to check the returned value, and it always return
> > 1 for both pds, even if I did not boot the remote core.
> >
> > So I was wondering if it was because of PD_FLAG_DEV_LINK_ON, I removed
> > it and passed NULL to dev_pm_domain_attach_list().
> 
> Right, that's exactly what we should be doing.
> 
> > Booting the kernel
> > now it correctly reports 0 for both pds, however when I start the
> > remote core with a hello world firmware and boot the kernel, the CPU
> > resets with a fault reset ("Reset cause: SCFW fault reset").
> >
> > I added both pm functions to probe, just to test:
> >
> > @@ -1152,6 +1158,9 @@ static int imx_rproc_probe(struct platform_device *pdev)
> >                 goto err_put_clk;
> >         }
> >
> > +       pm_runtime_enable(dev);
> > +       pm_runtime_get_sync(dev);
> > +
> 
> Indeed, calling pm_runtime_enable() and then pm_runtime_get_sync()
> should turn on the PM domains for the device, which I assume is needed
> at some point.
> 
> Although, I wonder if this may be a bit too late, I would expect that
> you at least need to call these *before* the call to rproc_add(), as I
> assume the rproc-core may start using the device/driver beyond that
> point.
> 
> >         return 0
> >
> > Now the kernel boot with the remote core running, but it still returns
> > 0 from dev_pm_genpd_is_on(). So basically now it always returns 0, with
> > or without the remote core running.
> 
> dev_pm_genpd_is_on() is returning the current status of the PM domain
> (genpd) for the device.
> 
> Could it be that the genpd provider doesn't register its PM domains
> with the state that the HW is really in? pm_genpd_init() is the call
> that allows the genpd provider to specify the initial state.
> 
> I think we need Peng's help here to understand what goes on.
> 
> >
> > I tried to move pm_runtime_get_sync() to .prepare function but it make
> > the kernel not boot anymore (with the SCU fault reset).
> 
> Try move pm_runtime_enable() before rproc_add().

Thanks Ulf, that indeed made it work, at least now the kernel does not
reset anymore with the SCU fault reset. However I am still only getting
0 from dev_pm_genpd_is_on(), no matter what the state of the remote
core. Maybe I am missing something in between?

Peng, do you know what could be the issue here?

> 
> >
> > Do you have any suggestions? Am I doing something wrong with these PDs?
> >
> > Best regards,
> > Hiago.
> 
> Kind regards
> Uffe

Best regards,
Hiago

