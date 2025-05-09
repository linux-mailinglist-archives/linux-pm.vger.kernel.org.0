Return-Path: <linux-pm+bounces-26975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2CFAB1D31
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 21:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE35500175
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 19:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D12254B14;
	Fri,  9 May 2025 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2U5F0u4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D45F239E8F;
	Fri,  9 May 2025 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817998; cv=none; b=eHyXgEZbU5uXIY4X/NCGP8iw4R4GaSHAFxRzjJa1NOK1epnFH2zDqaWGW3VBTB0haLwxX1EaS5NaFbFMfiJR+MRgx0ByV9UEEVKuLIALIAdV0T21Bu7hPRqZ3PFdXuFxAZPZUnlu/4dmzVaR2cIOp3rq0YOxiKDAunG52GikBA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817998; c=relaxed/simple;
	bh=QCR55OsR8BeOhjGcGHiHtwOpQrGrz8N/scYm+FoUARk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGgGa4esK5tkaqbo8KT+deG9UG/Wc/0JNQDKXeal7zr3pIDYH0VQEvauV2nXxXPh+vHhjcx625zAbPRuyIFMaju8Z5OSs/JKLPLEEfP+td6JFA67YSwtnobpiRd++NEO+MMnYmRMGL9eCgCS6B0vH0ogrIWQAjXKMTpz8hzMs88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2U5F0u4; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52934f4fb23so1815078e0c.1;
        Fri, 09 May 2025 12:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746817995; x=1747422795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZfddHQu5I9Otb7WuExi6VXYbXbdDVVverdTHksitlQ=;
        b=I2U5F0u4n7SKNMKZs5KpuwD4UFZQ7Z5wjtyjZhJ++Iv1wUz/yi/bm52kVhTPQEsdYd
         U5XajEMCO/ASXkvvsnEJMwyVXNn/lRagbraM1WKPU+nxdSkHT9hIwGtaYjwWOta4Yjqx
         8Khaiy0P8bamwqZUZlX1JlBfUyQDkE4jRzcrrFgkGHf/cY8EyyVeWHX4+MCy17qP07En
         N1ByqN+Ktx5VDvKd+7OHwD4PTo78wDIUyrDB6qCM2xis9OOPp8KzuCjNtv6XyH6Qaioo
         TlLsEPhuIqQ4447ZRTXrxpIl6C9w2A89sLSPCFuKA+uzVtS/vBBzI+iKlgjsdLbXaoRH
         2LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746817995; x=1747422795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZfddHQu5I9Otb7WuExi6VXYbXbdDVVverdTHksitlQ=;
        b=OAoAatg4t267E3zM1eVQbc8DZvuG0HpO6ceR1rJSxKXry9X1eb53RyT5kgXQwD8+tm
         ram5jdEjgyvZetylq5W82INVQrNCaMyuPesQfCooyIvPprZg/WTLb9fYm0uYWuop2O6O
         Sb9NV8yCAtl/kWiXhfMhe9PpVYNR4MVzsP0GmR/AdoJ9NtK1GwiK0foOXVNrpTT8qZSg
         zjiZFMgUbJ/KKJNAdA1rZYiMyS5Z6oSaOELro/869Z09AKzN1KDj4ljOXL3rC8NijX9D
         gCX2hKRpWCVKfBnhIQ2ucWsk6t4WmfxipruIBEOhvTHMiE8eSSeJv+c1mmgifK/fa0HZ
         yvvw==
X-Forwarded-Encrypted: i=1; AJvYcCUdfcFOC+7CAxAW0iaLhzJkAMCvIgQs95ljRLtqfea4KA7YOszWPRSelI+dgP8pJenf9pImCu0hHk/POJGLJqe3wA==@vger.kernel.org, AJvYcCWsYlhFJ5f6J1Get7E5E7qWFHhQpdIOoSBgGjjttW81KofOSfLDMpiCBhFvX/nImDf/jC1iPGMYmHw=@vger.kernel.org, AJvYcCX2pNoGHtlM6aSQq3Ef0AsqLLWmSDUXzvh8Pa3rAezedXcSQGqp0tA57zxHgQvNxPcbKoFQJuGhbDmgPXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVELst/+WDM6VhdG/pvIsUSsqnOPgqRBa6YebFb+Sqf9WfmFW1
	l3XjwzhwQ5RMMjae5oru4qTb6ECMuXGL/wTjfFh0BSKxff1YlCboNcyK5CP8
X-Gm-Gg: ASbGncsWsA2LzIPZdbDa/wzPsaCZSrRQ2WyuBdLtlyZCuYK1Zwwq5CYtgeMK/M2FxqS
	4cTVsxVATOIfM3NrvZqcDlg6dd28saqMCTxznQv82FkUjmRXjU3VOm9IYeBPcGRjv8y+kjPXOGa
	P9samQSaS82iKybyveNGFv9UL9gBAfPm4+sjvyzFM4bq6qfgTsC6dgDB8Q8an/nmYCRe8cbaRS0
	gpCNBR6n3TWmbChr4bpWLyvuuGpoSINdwhtmni76Vk5FN6JfbXXotJ26/VwW/iNlpN/TrJC6fyN
	Rddcvy6zehvYQdOwdTKG+9Ih7Wv/iuFYxuvkSJbIUgGBdQ+6ng==
X-Google-Smtp-Source: AGHT+IH6q+Y+fNg3K1fYBeHbGWU3eRXIxIU/yD3j9JyGk1Xodh5lnXB6Ky0QBqgV1qG4FaffonJZUQ==
X-Received: by 2002:a05:6122:1d14:b0:523:dd87:fe95 with SMTP id 71dfb90a1353d-52c53daf2admr4866962e0c.9.1746817995152;
        Fri, 09 May 2025 12:13:15 -0700 (PDT)
Received: from hiago-nb ([2804:1b3:a7c0:6030:2d83:24ee:356:8505])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-879f6298ebasm1570303241.34.2025.05.09.12.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 12:13:14 -0700 (PDT)
Date: Fri, 9 May 2025 16:13:08 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com, Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
Message-ID: <20250509191308.6i3ydftzork3sv5c@hiago-nb>
References: <20250507160056.11876-1-hiagofranco@gmail.com>
 <20250507160056.11876-4-hiagofranco@gmail.com>
 <CAPDyKFrHD1hVCfOK-JV5FJM+Cd9DoKKZGKcC94fxx6_9Bsri1g@mail.gmail.com>
 <20250508202826.33bke6atcvqdkfa4@hiago-nb>
 <CAPDyKFr3yF=yYZ=Xo5FicvSbDPOTx7+fMwc8dMCLYKPBMEtCKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr3yF=yYZ=Xo5FicvSbDPOTx7+fMwc8dMCLYKPBMEtCKA@mail.gmail.com>

On Fri, May 09, 2025 at 12:37:02PM +0200, Ulf Hansson wrote:
> On Thu, 8 May 2025 at 22:28, Hiago De Franco <hiagofranco@gmail.com> wrote:
> >
> > Hello,
> >
> > On Thu, May 08, 2025 at 12:03:33PM +0200, Ulf Hansson wrote:
> > > On Wed, 7 May 2025 at 18:02, Hiago De Franco <hiagofranco@gmail.com> wrote:
> > > >
> > > > From: Hiago De Franco <hiago.franco@toradex.com>
> > > >
> > > > When the remote core is started before Linux boots (e.g., by the
> > > > bootloader), the driver currently is not able to attach because it only
> > > > checks for cores running in different partitions. If the core was kicked
> > > > by the bootloader, it is in the same partition as Linux and it is
> > > > already up and running.
> > > >
> > > > This adds power mode verification through the SCU interface, enabling
> > > > the driver to detect when the remote core is already running and
> > > > properly attach to it.
> > > >
> > > > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > > > Suggested-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > > v2: Dropped unecessary include. Removed the imx_rproc_is_on function, as
> > > > suggested.
> > > > ---
> > > >  drivers/remoteproc/imx_rproc.c | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > >
> > > > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > > > index 627e57a88db2..9b6e9e41b7fc 100644
> > > > --- a/drivers/remoteproc/imx_rproc.c
> > > > +++ b/drivers/remoteproc/imx_rproc.c
> > > > @@ -949,6 +949,19 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
> > > >                         if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
> > > >                                 return -EINVAL;
> > > >
> > > > +                       /*
> > > > +                        * If remote core is already running (e.g. kicked by
> > > > +                        * the bootloader), attach to it.
> > > > +                        */
> > > > +                       ret = imx_sc_pm_get_resource_power_mode(priv->ipc_handle,
> > > > +                                                               priv->rsrc_id);
> > > > +                       if (ret < 0)
> > > > +                               dev_err(dev, "failed to get power resource %d mode, ret %d\n",
> > > > +                                       priv->rsrc_id, ret);
> > > > +
> > > > +                       if (ret == IMX_SC_PM_PW_MODE_ON)
> > > > +                               priv->rproc->state = RPROC_DETACHED;
> > > > +
> > > >                         return imx_rproc_attach_pd(priv);
> > >
> > > Why is it important to potentially set "priv->rproc->state =
> > > RPROC_DETACHED" before calling imx_rproc_attach_pd()?
> > >
> > > Would it be possible to do it the other way around? First calling
> > > imx_rproc_attach_pd() then get the power-mode to know if
> > > RPROC_DETACHED should be set or not?
> > >
> > > The main reason why I ask, is because of how we handle the single PM
> > > domain case. In that case, the PM domain has already been attached
> > > (and powered-on) before we reach this point.
> >
> > I am not sure if I understood correcly, let me know if I missed
> > something. From my understanding in this case it does not matter, since
> > the RPROC_DETACHED will only be a flag to trigger the attach callback
> > from rproc_validate(), when rproc_add() is called inside
> > remoteproc_core.c.
> 
> Okay, I see.
> 
> To me, it sounds like we should introduce a new genpd helper function
> instead. Something along the lines of this (drivers/pmdomain/core.c)
> 
> bool dev_pm_genpd_is_on(struct device *dev)
> {
>         struct generic_pm_domain *genpd;
>         bool is_on;
> 
>         genpd = dev_to_genpd_safe(dev);
>         if (!genpd)
>                 return false;
> 
>         genpd_lock(genpd);
>         is_on = genpd_status_on(genpd);
>         genpd_unlock(genpd);
> 
>         return is_on;
> }
> 
> After imx_rproc_attach_pd() has run, we have the devices that
> correspond to the genpd(s). Those can then be passed as in-parameters
> to the above function to get the power-state of their PM domains
> (genpds). Based on that, we can decide if priv->rproc->state should be
> to RPROC_DETACHED or not. Right?

Got your idea, I think it should work yes, I am not so sure how. From
what I can see these power domains are managed by
drivers/pmdomain/imx/scu-pd.c and by enabling the debug messages I can
see the power mode is correct when the remote core is powered on:

[    0.317369] imx-scu-pd system-controller:power-controller: cm40-pid0 : IMX_SC_PM_PW_MODE_ON

and powered off:

[    0.314953] imx-scu-pd system-controller:power-controller: cm40-pid0 : IMX_SC_PM_PW_MODE_OFF

But I cannot see how to integrate this into the dev_pm_genpd_is_on() you
proposed. For a quick check, I added this function and it always return
NULL at dev_to_genpd_safe(). Can you help me to understand this part?

> 
> In this way we don't need to export unnecessary firmware functions
> from firmware/imx/misc.c, as patch1/3 does.
> 
> If you think it can work, I can help to cook a formal patch for the
> above helper that you can fold into your series. Let me know.
> 
> >
> > With that we can correcly attach to the remote core running, which was
> > not possible before, where the function returns at "return
> > imx_rproc_attach_pd(priv);" with the RPROC_OFFLINE state to
> > rproc_validate().
> 
> I see, thanks for clarifying!
> 
> Kind regards
> Uffe

Thank you!
Hiago.

