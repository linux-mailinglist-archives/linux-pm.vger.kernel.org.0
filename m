Return-Path: <linux-pm+bounces-26901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF2CAB049F
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 22:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CAC1C0020C
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 20:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6371228BA91;
	Thu,  8 May 2025 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d16MN9ga"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F671E1E1D;
	Thu,  8 May 2025 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736116; cv=none; b=pLBBJ76oZ2yIwjAPIn8H4L3+a2OfTCZ52n0lOH2g+76wbhXRi3XDdvheKvJRPraScRgKPpv/iOUe6Sa9cRo1RPJ6Kmb+h3PL9NrMmiGs7FKGNOgdI4Lvd4NrmCXVCry9flWOq7dGHFpPCbzxTSkzT7GOOeW9CAlgfO24NrLREkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736116; c=relaxed/simple;
	bh=glI2QyA2V4kwUucOfsrEIYTyDYNwfxLg42DzzZgissg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUU8sQ9JWgU10vEHUrjSKhNjUFLejzrsZQ//Qz5cBLiWqRg2jN9RMTfF78DdgcpaOlJINRiNqAlJQPAq2YJuskyhgFhKBViSuGnDzvloTjoHfvgum2A2N0mUkB+mCmXe7ENwtsagclbAdFUvzMaUGJ8jdIEqhasuZibGCzXSAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d16MN9ga; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-525b44ec88aso445024e0c.3;
        Thu, 08 May 2025 13:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746736113; x=1747340913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pc5D2wBbh6n4AHAVGKAJlI6vZAzUWJsMh1/Yq1dDS0=;
        b=d16MN9gavssuSj3PnohD0slnV7NEBM1B81vgUy12FUnL0pyEmzz8csoO+SmKf/PLai
         KM+sCS9pQij8rIf0a+oDq3xUcFgEw6cyCen8LAJ5sqQd+aowAdgJaS4jMRAmwkpX0vb8
         HrLU7sXY5QhEYHQt7HhUcmHERbqhneO74wYVLOSyqsMoudPx9PLdHWhA0pM82xCe9OZ1
         f/7jhUBMEn2G8ZHNYjZFgSY0KvklAftlWXlSfdG9Gm1kmqkIXEXhhKDhLSb3BCgB1ykq
         r9ygBXAhHV8Q960mZmn1abbw+5XneEPqbBw9QCNDvnsjiTQ6/YYaC/0eVciCW0lG+/sP
         fukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746736113; x=1747340913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pc5D2wBbh6n4AHAVGKAJlI6vZAzUWJsMh1/Yq1dDS0=;
        b=OBPuMgS84CFXXrQ04c4IgmPdWB327ZaT2p81wnDz/ucHsI7s+zv4whfRjpXwafnbeH
         G8MohrSq5EjpJdvVv78T3+aDaefRQqU9IlfAMBWlZhqtcvvTy5DoaoArrCCWLQt12AIm
         qA4mwvA5g+fferUAJt8gEi06+gI3OWdBHFM2HGig9zjSKyNOGXuJu67npucPa9j4olTb
         PjYc5+BL35iTcf1/KNHVsdYoO3XJxn/ITGsL2s5jFJ0GzK4jJv38P7qCAFK754K84QNS
         67y2Qz/W2oHHAqWyGwy9JaWBao9ujcvVd1Y0BNdy8vQreMHYjc5Z53/MfTJlfwy5pcGU
         n+cg==
X-Forwarded-Encrypted: i=1; AJvYcCVeezngOw/nG9ZUOKL1+BvhVXUqxORZoCHeC0vYqSVsawSuLkNTwnBvU9E4ST8uQcmING2nYiMYBcQ=@vger.kernel.org, AJvYcCWgaEIIoW1Bp5CA8n8aQjUCga7BIww/c1ujalR4D+r+wBMR6LV9RqOHWEDwdHOBo/SmF7C7v7MgPZjXl3o=@vger.kernel.org, AJvYcCXiSoM/0PETq9KGEcXPNzOMVzjr7SGNc4aSZ2rwsS8s+S4/1rubvQq1qupgovbqlet9Sj8/0xe4rgzMX0CBE+MnCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwISI3m+AaLz7BzRZSYBVj5PZF824VsE1IraZwfUOOh+bgN71er
	k84q7ZrvtXtjwuOLaHWmqsQ0SBMye+IJCYSw2umhaJGOtuAm7evh
X-Gm-Gg: ASbGncsGQwWoGYiaKZXLsUDx5IqetFaQVWgVcwiqRTRjsYiWZ4o17p5oiZT3FiFIXU+
	HEg1TvPt6o55KiRvHJYjn1ZBox4X125yfKhliiBBQNiP7vn9w3GJtvBINHK2O0TSi/a8B7qA1vm
	2nfOVBd/zMj23LXdDOHc3G57yAWFPx21b4ex8YS24lnrBNiXZJKz2VkMlDSTRsupKa0Y12g36aO
	FzD3S301MmwVERzGgjUKFeKShJmyUYAyaUxswQa2FgYXFHrNcWlwK1m5EdwqjB+p/camo8EAlA7
	Hv9a6BpjMfHS9wCU9P90XiQm4T3Jz73sVNve8UAe
X-Google-Smtp-Source: AGHT+IHH8Hb44S2pUrzpBoAuMzG/VFUuedek3qnL1aKjilRrz2XuP3PUIZdV2EDPHQ1l0mwZVNw7hQ==
X-Received: by 2002:a05:6122:828d:b0:523:9ee7:7f8e with SMTP id 71dfb90a1353d-52c53c68f4amr1351138e0c.4.1746736113471;
        Thu, 08 May 2025 13:28:33 -0700 (PDT)
Received: from hiago-nb ([2804:1b3:a7c0:6030:ff91:5999:3ab5:5caf])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c5375bcdcsm217781e0c.25.2025.05.08.13.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 13:28:32 -0700 (PDT)
Date: Thu, 8 May 2025 17:28:26 -0300
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
Message-ID: <20250508202826.33bke6atcvqdkfa4@hiago-nb>
References: <20250507160056.11876-1-hiagofranco@gmail.com>
 <20250507160056.11876-4-hiagofranco@gmail.com>
 <CAPDyKFrHD1hVCfOK-JV5FJM+Cd9DoKKZGKcC94fxx6_9Bsri1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrHD1hVCfOK-JV5FJM+Cd9DoKKZGKcC94fxx6_9Bsri1g@mail.gmail.com>

Hello,

On Thu, May 08, 2025 at 12:03:33PM +0200, Ulf Hansson wrote:
> On Wed, 7 May 2025 at 18:02, Hiago De Franco <hiagofranco@gmail.com> wrote:
> >
> > From: Hiago De Franco <hiago.franco@toradex.com>
> >
> > When the remote core is started before Linux boots (e.g., by the
> > bootloader), the driver currently is not able to attach because it only
> > checks for cores running in different partitions. If the core was kicked
> > by the bootloader, it is in the same partition as Linux and it is
> > already up and running.
> >
> > This adds power mode verification through the SCU interface, enabling
> > the driver to detect when the remote core is already running and
> > properly attach to it.
> >
> > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > Suggested-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > v2: Dropped unecessary include. Removed the imx_rproc_is_on function, as
> > suggested.
> > ---
> >  drivers/remoteproc/imx_rproc.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > index 627e57a88db2..9b6e9e41b7fc 100644
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -949,6 +949,19 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
> >                         if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
> >                                 return -EINVAL;
> >
> > +                       /*
> > +                        * If remote core is already running (e.g. kicked by
> > +                        * the bootloader), attach to it.
> > +                        */
> > +                       ret = imx_sc_pm_get_resource_power_mode(priv->ipc_handle,
> > +                                                               priv->rsrc_id);
> > +                       if (ret < 0)
> > +                               dev_err(dev, "failed to get power resource %d mode, ret %d\n",
> > +                                       priv->rsrc_id, ret);
> > +
> > +                       if (ret == IMX_SC_PM_PW_MODE_ON)
> > +                               priv->rproc->state = RPROC_DETACHED;
> > +
> >                         return imx_rproc_attach_pd(priv);
> 
> Why is it important to potentially set "priv->rproc->state =
> RPROC_DETACHED" before calling imx_rproc_attach_pd()?
> 
> Would it be possible to do it the other way around? First calling
> imx_rproc_attach_pd() then get the power-mode to know if
> RPROC_DETACHED should be set or not?
> 
> The main reason why I ask, is because of how we handle the single PM
> domain case. In that case, the PM domain has already been attached
> (and powered-on) before we reach this point.

I am not sure if I understood correcly, let me know if I missed
something. From my understanding in this case it does not matter, since
the RPROC_DETACHED will only be a flag to trigger the attach callback
from rproc_validate(), when rproc_add() is called inside
remoteproc_core.c.

With that we can correcly attach to the remote core running, which was
not possible before, where the function returns at "return
imx_rproc_attach_pd(priv);" with the RPROC_OFFLINE state to
rproc_validate().

> 
> >                 }
> >
> > --
> > 2.39.5
> >
> 
> Kind regards
> Uffe

Best Regards,
Hiago.

