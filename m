Return-Path: <linux-pm+bounces-30945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A68DB07E63
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 21:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C871582372
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 19:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2C729A9F9;
	Wed, 16 Jul 2025 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iwg2OguT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E49288C2D;
	Wed, 16 Jul 2025 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695412; cv=none; b=VGi1lVxZTJVPx2RjlZG6Tae+yaq1R7FQ/y40M/O0tKyw9BTzPsj/kiiNHki9ThyCmr7BpHlhmsRBfGwxcOqzDyXvyw8AsThv/doHylUIgdVjLH2BVU9KXynSyHcFwc9U9sI93cFbDvvMDKUAlbxzfJWkHrM9+Rqq6GAowH5WWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695412; c=relaxed/simple;
	bh=SsZPmiVgiEbGyuQvV/yeqg4poe+PgKXSBFskoQzwdAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avfTvxWILyuRDXAr/t+iLUrQj/ihSu9BxMYh0TGBPJMvpVBdqX4S0HKcTSfkB5R7xldBQNlmpMeL1Vsrin5BTKzF9V+kNTi3PDr5nPWVYSZe8pyQfk1ihcvMl+qT18TAdphdIIbaCeJROIiS1LNsbUyzkK3lEnRA7O0f9WBp3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iwg2OguT; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313a188174fso1042951a91.1;
        Wed, 16 Jul 2025 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752695410; x=1753300210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZZgzA7unxaQYTpUKeT3tiFqc0eDBxi7N6aA9SCTkxo=;
        b=Iwg2OguTpTjvgUmJ2POq4QxjIuHGkxBJVWFY6sPVvogYQwNGQIFF5ckFqIa1SODjT9
         x+QZBGIs6w4MTcntxpow1sa9ZQnoigwBS2RnTxEJCSN5XcJr9c2RXoWc8k0RZWI8ZkT1
         xZl++uEV49f03P1EaZUNRbvFH/4w9xfQMqU6Tm8JuDU2D5vGYWmu/XDQTyXAxrFftqQn
         pgStHC+rIWqTibPriQaG/NFixnp4j3o8/Zfx+eiU96o21x384Uwz5spnZb0+65/ZFo4v
         MtloLu12lwEa43NoNXUw9jeKGafIXL1l4Xb5szW5DQedqntGJZnzJ4AAZIadsYJ1Pa4r
         zDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752695410; x=1753300210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZZgzA7unxaQYTpUKeT3tiFqc0eDBxi7N6aA9SCTkxo=;
        b=AneQSy+Mt9wE2ssc2i6QtNTK192m9BuxD7qCQIWhZsoU+cdysEqKpE1yy7wIKgXldx
         B7pIvDMVmSyNG3xHOOzYiRyTLpTig2Aj6ih7wA75MokoLfV1s+bFrIqWJLpFmP2/E4k+
         H1MNqT3WZAXG5BRSlEg4Fuyg3n0Z8xIKwEiTRYvShg3xUCall138jwokVJQme20hF3xx
         5Y7YIwnGXGYzPERU4DEW88LY46M3c/0rMkqltAa6uTXygL7DOq3OKhytYQ+N5pE5YaA3
         bCePm8cT2Wx2JxbvqVssF0UIysY6v2LPiDYQWeQPK3JwwjvGmTuQ+7X1Fo4vDVBaLB0r
         CMKA==
X-Forwarded-Encrypted: i=1; AJvYcCV/RGnWq/6NXK12K15Z02AgsXRAIE6tZJxa/doJofVuTnmlML7KTF8I4wb0Mw6qsTTdczRYD9eZ7R8pOxc=@vger.kernel.org, AJvYcCVPMq0HYE5xeh0V6Mf1gA/DV2CazStO0HW6A7YxkIFd+DFWX55yQsGaqyLO1JeLHd/ZT3UDt0r35PYHieyVNNEDrQ==@vger.kernel.org, AJvYcCVhiofV/RfZ9ONkn/yo8ivxXDQuWPuioVlaetyNFn4pdWPab3g1wagwsBd6LKT/eT+M6n577U1xdYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxibxEXGa6a5WhgORQD5uGBrl1+fbRz7ffRe2GLBzuofpCwKxhL
	8K9+T8/kkQrYAATytlomrJg9lX0L87MJdgxQrKaZWRg5qkL/IaC6ubhy
X-Gm-Gg: ASbGncslJMUnGFFKKhDuIIkRW4wvsjBQLbqNNHoHcqZEEBherGj4bKaV+InnXVIoEL5
	LcX2S3E83hNqCInykFfs/dGCjjvTQ93CWNiAxVKKO31x1yIPHdMw3sr1bFNUtR3sA7woxwut+cZ
	NLZ1xjc4yGDOsP/hgbwTPs/0W60eLCHEMAgas+HtHMSllXDn+UsugPtAluiXuWezyKewJJv2VXV
	WGzNuxXgzr2KPhjzpZ4PMQAPZnOG5olZG1P5Sfaai/KYy6bFBYTAiHJsWI2dAnIOY91Tpt42iiA
	l4B+uRC5Wi4eo1Zt5DCwS45LQnxTZvM8acZ+DG3s73Bk1DA+IVxX9vG7wQEKX+OeQKk6zNZrj+Y
	2ZIx+GPn4h6phRlqQXyA=
X-Google-Smtp-Source: AGHT+IGkORjHEJ3lwLi+FibgkhUKI9Xi/FApJrENFdLLcxtfYU8HO8fS+q0sfAOpe3IeYIpcVRS1Jw==
X-Received: by 2002:a17:90b:3d81:b0:312:e73e:cded with SMTP id 98e67ed59e1d1-31caea21526mr783583a91.16.1752695410205;
        Wed, 16 Jul 2025 12:50:10 -0700 (PDT)
Received: from hiagonb ([2804:1b3:a7c1:459e:e3dd:d2e:b1ee:b9ec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e684csm1947200a91.12.2025.07.16.12.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:50:09 -0700 (PDT)
Date: Wed, 16 Jul 2025 16:50:03 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v7 3/3] remoteproc: imx_rproc: detect and attach to
 pre-booted remote cores
Message-ID: <20250716195003.5kunymu3nrdsfnz2@hiagonb>
References: <aHZ0nK4ZZShAr6Xz@p14s>
 <CAPDyKFrWng0CY-ayKoEbnS_yanghSqogxfuizxEVbVogJ4DT=g@mail.gmail.com>
 <20250716132552.bra37ucw4fcjwril@hiagonb>
 <aHfYQFvkJcdfq9K_@p14s>
 <20250716172308.lzh3aak24d6mt4cs@hiagonb>
 <CAPDyKFr8eYiyj5s7wGsru8GJ+CS6h-o+a+BOV-nvCdSzWM0bSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr8eYiyj5s7wGsru8GJ+CS6h-o+a+BOV-nvCdSzWM0bSw@mail.gmail.com>

On Wed, Jul 16, 2025 at 08:56:37PM +0200, Ulf Hansson wrote:
> On Wed, 16 Jul 2025 at 19:23, Hiago De Franco <hiagofranco@gmail.com> wrote:
> >
> > On Wed, Jul 16, 2025 at 10:50:08AM -0600, Mathieu Poirier wrote:
> > > On Wed, Jul 16, 2025 at 10:25:52AM -0300, Hiago De Franco wrote:
> > > > Hi Mathieu, Ulf,
> > > >
> > > > On Tue, Jul 15, 2025 at 09:32:44AM -0600, Mathieu Poirier wrote:
> > > > > On Sun, Jun 29, 2025 at 02:25:12PM -0300, Hiago De Franco wrote:
> > > > > > From: Hiago De Franco <hiago.franco@toradex.com>
> > > > > >
> > > > > > When the Cortex-M remote core is started and already running before
> > > > > > Linux boots (typically by the Cortex-A bootloader using a command like
> > > > > > bootaux), the current driver is unable to attach to it. This is because
> > > > > > the driver only checks for remote cores running in different SCFW
> > > > > > partitions. However in this case, the M-core is in the same partition as
> > > > > > Linux and is already powered up and running by the bootloader.
> > > > > >
> > > > > > This patch adds a check using dev_pm_genpd_is_on() to verify whether the
> > > > > > M-core's power domains are already on. If all power domain devices are
> > > > > > on, the driver assumes the M-core is running and proceed to attach to
> > > > > > it.
> > > > > >
> > > > > > To accomplish this, we need to avoid passing any attach_data or flags to
> > > > > > dev_pm_domain_attach_list(), allowing the platform device become a
> > > > > > consumer of the power domain provider without changing its current
> > > > > > state.
> > > > > >
> > > > > > During probe, also enable and sync the device runtime PM to make sure
> > > > > > the power domains are correctly managed when the core is controlled by
> > > > > > the kernel.
> > > > > >
> > > > > > Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > > > > > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > > > > > ---
> > > > > > v6 -> v7:
> > > > > >  - Added Peng reviewed-by.
> > > > > > v5 -> v6:
> > > > > >  - Commit description improved, as suggested. Added Ulf Hansson reviewed
> > > > > >    by. Comment on imx-rproc.c improved.
> > > > > > v4 -> v5:
> > > > > >  - pm_runtime_get_sync() removed in favor of
> > > > > >    pm_runtime_resume_and_get(). Now it also checks the return value of
> > > > > >    this function.
> > > > > >  - Added pm_runtime_disable() and pm_runtime_put() to imx_rproc_remove()
> > > > > >    function.
> > > > > > v3 -> v4:
> > > > > >  - Changed to use the new dev_pm_genpd_is_on() function instead, as
> > > > > >    suggested by Ulf. This will now get the power status of the two
> > > > > >    remote cores power domains to decided if imx_rpoc needs to attach or
> > > > > >    not. In order to do that, pm_runtime_enable() and
> > > > > >    pm_runtime_get_sync() were introduced and pd_data was removed.
> > > > > > v2 -> v3:
> > > > > >  - Unchanged.
> > > > > > v1 -> v2:
> > > > > >  - Dropped unecessary include. Removed the imx_rproc_is_on function, as
> > > > > >    suggested.
> > > > > > ---
> > > > > >  drivers/remoteproc/imx_rproc.c | 37 +++++++++++++++++++++++++++++-----
> > > > > >  1 file changed, 32 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> > > > > > index 627e57a88db2..24597b60c5b0 100644
> > > > > > --- a/drivers/remoteproc/imx_rproc.c
> > > > > > +++ b/drivers/remoteproc/imx_rproc.c
> > > > > > @@ -18,6 +18,7 @@
> > > > > >  #include <linux/of_reserved_mem.h>
> > > > > >  #include <linux/platform_device.h>
> > > > > >  #include <linux/pm_domain.h>
> > > > > > +#include <linux/pm_runtime.h>
> > > > > >  #include <linux/reboot.h>
> > > > > >  #include <linux/regmap.h>
> > > > > >  #include <linux/remoteproc.h>
> > > > > > @@ -890,10 +891,8 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
> > > > > >  static int imx_rproc_attach_pd(struct imx_rproc *priv)
> > > > > >  {
> > > > > >         struct device *dev = priv->dev;
> > > > > > -       int ret;
> > > > > > -       struct dev_pm_domain_attach_data pd_data = {
> > > > > > -               .pd_flags = PD_FLAG_DEV_LINK_ON,
> > > > > > -       };
> > > > > > +       int ret, i;
> > > > > > +       bool detached = true;
> > > > > >
> > > > > >         /*
> > > > > >          * If there is only one power-domain entry, the platform driver framework
> > > > > > @@ -902,7 +901,22 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
> > > > > >         if (dev->pm_domain)
> > > > > >                 return 0;
> > > > > >
> > > > > > -       ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
> > > > > > +       ret = dev_pm_domain_attach_list(dev, NULL, &priv->pd_list);
> > > > > > +       /*
> > > > > > +        * If all the power domain devices are already turned on, the remote
> > > > > > +        * core is already powered up and running when the kernel booted (e.g.,
> > > > > > +        * started by U-Boot's bootaux command). In this case attach to it.
> > > > > > +        */
> > > > > > +       for (i = 0; i < ret; i++) {
> > > > > > +               if (!dev_pm_genpd_is_on(priv->pd_list->pd_devs[i])) {
> > > > > > +                       detached = false;
> > > > > > +                       break;
> > > > > > +               }
> > > > > > +       }
> > > > >
> > > > > I was doing one final review of this work when I noticed the return code for
> > > > > dev_pm_domain_attach_list() is never checked for error.
> > > >
> > > > As Ulf pointed out, the 'return' a few lines below will return the
> > > > negative value to the caller of 'imx_rproc_attach_pd', which ultimately
> > > > will fail 'imx_rproc_detect_mode' and fail the probe of imx_rproc.
> > > >
> > > > Please notice that even tough 'dev_pm_domain_attach_list' fails, the
> > > > rproc->state will still be set as RPROC_DETACHED because we are starting
> > > > 'detached' as true, but I am not seeing this as an issue because as
> > > > mentioned above the probe will fail anyway. Please let me know if you
> > > > see this as an issue.
> > >
> > > Two things to consider here:
> > >
> > > (1) It is only a matter of time before someone with a cleaver coccinelle script
> > > sends me a patch that adds the missing error check.
> > >
> > > (2) I think that @rproc->state being changed on error conditions is a bug
> > > waiting to happen.  This kind of implicit error handling is difficult to
> > > maintain and even more difficult for people to make enhancements to the driver.
> > >
> > > Adding a simple error check will make sure neither of the above will happen.  It
> > > is a simple change and we are at rc6 - this work can still go in the merge
> > > window.
> >
> > Sure, I can submit a new revision with this error check. Sorry I did not
> > see this before, I only had a close look at this '->state' now that you
> > asked on the previous email.
> 
> Alright. To avoid having you to resend patch1 and patch2 I have
> applied them on my next branch and added Mathieu's ack for patch2.
> 
> Note that my vacation is around the corner, so if you want patch3 for
> v6.17 you better be quick. :-)

Thanks Ulf, as requested I resend only patch 3.

https://lore.kernel.org/all/20250716194638.113115-1-hiagofranco@gmail.com/

Have a nice vacation =)

Best Regards,

Hiago.

> 
> [...]
> 
> Thanks and kind regards
> Uffe

