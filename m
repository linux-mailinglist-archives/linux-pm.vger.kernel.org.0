Return-Path: <linux-pm+bounces-17424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08179C5B85
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 16:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0736282388
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C08200BA2;
	Tue, 12 Nov 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zotxy6K0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2285E200B80
	for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424156; cv=none; b=X5jY4/cohb0AINbK5TV2zbL1S/AI+dnZJcSxcUZDngfTape4vyZ9pQuyfmHKxv9bmpuv58d71bQ92IvO2Rd2t4oKMKZcxkAy5pAExUgsOSGE5ezOW3/sefiRSMeqWwZNJwpqwlJtEdLiGsSPGFJZ7Te6tX978eKMJxm2jXtU2Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424156; c=relaxed/simple;
	bh=Yae/ZjXnszptIo2maTzMX7IonhdZHY8qYoZEO0bvb9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REUEa1C1IYRMctA7u5MT9ISTYjY1Tp8m4o1r+wQMyurscEFWQie5to4PI0y5L+5QY1WuMyFAiBxk44oyoDUoj1ICWDmFbXpfgkTIfr6rE7g1KctjjwptLPe+gmEALUDlDvHp/xz4ExZJLWOymCJWajSErdCO6mojTNCJqmZT/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zotxy6K0; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ff3232ee75so24088941fa.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 07:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731424152; x=1732028952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kkBUPNbMV6MFN98HPxYcgn3PAbnpKABvT452YVQrYcY=;
        b=zotxy6K0N+L9HKHOv56SOnamXLYa91Pwn8UPK874PTkP6ApcNAHPVPB6aUPM3DHIb3
         ih2sdK0fucGEDd6pYHtTMlhnhn9xPea6iIixGoWSNFZ47mM2prBOnsgAbseEhnUFLNnI
         g2wa2nhLWzq3rJcEUr740BzFFCODeyQ0pZTNeT1GFwMml2jHuXgnMGrQe9AvI0qqMecz
         cYBCM/OhfiyFtCvE1CbF4FCVu+zlZknUBPk2QXeCrSEGI/Ubc8JXisEcXAEGFpbQQtnX
         fERBcscZ00S5c9H5noVb2Lnea4L36bhi9U/JXU9kiCRwiRwVioWSeu0zYqJaNK7qqCHm
         nHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731424152; x=1732028952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkBUPNbMV6MFN98HPxYcgn3PAbnpKABvT452YVQrYcY=;
        b=ET6BGj7DhN5Z0jgyv6+62r7QA2SWw4mYGWbgpDte2kH4SW4N0+UEZ4RD04RT4PjNT9
         VDZ3eGA/7B5GQXytGilB0aO0kiwPjJqcVxEc+g+PGnZjd7UmJoyuQK0xvHsoRGSuyxfT
         pCYW9Ib8QTRNSeMJ5R6q/5wONpyAEdsnlRBu6tyI/r5JS+sXe+EsMhsJPb5fiyOwsFnQ
         +g5nQIbUFFyzKXqyZuE9KEWB4jzbYHTw01gu+X9m0K6uzshmwYwHMG01SksOdLYiWF1f
         2DJ12IDPUT4hLKxLj2zEwWeD7Aesg5TqBtVN/3S7phV87qlUqvaZZMdwmk8YE5ATGrV0
         XMuw==
X-Forwarded-Encrypted: i=1; AJvYcCXxQXy/4PNvgQSf1B9SopOC5Sfpl8FQoXFIUImOrpgRqrZTqTR8WEEI+UdCr00ek9iNbDQQSPNpRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK8fteuT45lkQ9bvyzX8Lez3XxDaWQFQe/t06re10tMf67DsR9
	4pthRwiRSapzuVEo7oNsZxXye5DR5L8hiw/QfGt5WYj4Nlerfg2E2/sNnB40DRGwole8q4OU3CT
	W7BnTE3l9PtDRTpBUoyo5sVEEeSPUAO0kWv8kXw==
X-Google-Smtp-Source: AGHT+IHTB+grajHe7E97x8MV2YTQN5hBgnGWn0IHcuQOPbvDYqMQzYaTKUG23YmQOHodHydT3IBLTdqixufjVmyRrvI=
X-Received: by 2002:a05:651c:1589:b0:2fb:587d:2ee with SMTP id
 38308e7fff4ca-2ff201620b4mr85511191fa.12.1731424151990; Tue, 12 Nov 2024
 07:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101024421.26679-1-quic_msana@quicinc.com> <1e47ee3e-7439-4dc4-aef6-0ad2f82ee341@intel.com>
In-Reply-To: <1e47ee3e-7439-4dc4-aef6-0ad2f82ee341@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 16:08:35 +0100
Message-ID: <CAPDyKFrku7pEPz0xNbtJetK1XhUmhgsN9Sx9Ea8=tNNhTkxa7w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhc: Add PM QoS support for mmc driver
To: Madhusudhan Sana <quic_msana@quicinc.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: quic_cang@quicinc.com, quic_nguyenb@quicinc.com, quic_bhaskarv@quicinc.com, 
	quic_mapa@quicinc.com, quic_narepall@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_rampraka@quicinc.com, quic_sachgupt@quicinc.com, 
	quic_sartgarg@quicinc.com, Linux PM list <linux-pm@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 15:43, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 1/11/24 04:44, Madhusudhan Sana wrote:
> > Register mmc driver to CPU latency PM QoS framework to improve
> > mmc device io performance.
>
> Not sure host controller drivers should really be manipulating
> cpu_latency_qos in order to squeeze a bit more I/O performance.

I fully agree, this type of boosting doesn't belong in a low level
storage driver, as it is simply not capable of understanding the
use-case. Note that the cpu_latency_qos can also be managed from
user-space.

Moreover, I guess there are use cases where it would make sense to
have some in-kernel governor to boost too for some conditions. But as
far as I can tell, we don't have a common way to do this, but rather
platform specific hacks via devfreq drivers for example.

Kind regards
Uffe

>
> >
> > Signed-off-by: Madhusudhan Sana <quic_msana@quicinc.com>
> > ---
> >  drivers/mmc/host/sdhci.c | 47 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.h |  4 ++++
> >  2 files changed, 51 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index f4a7733a8ad2..ffcc9544a3df 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -359,6 +359,46 @@ static void sdhci_config_dma(struct sdhci_host *host)
> >       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> >  }
> >
> > +/*
> > + * sdhci_pm_qos_init - initialize PM QoS request
> > + */
> > +void sdhci_pm_qos_init(struct sdhci_host *host)
> > +{
> > +     if (host->pm_qos_enable)
> > +             return;
> > +
> > +     cpu_latency_qos_add_request(&host->pm_qos_req, PM_QOS_DEFAULT_VALUE);
> > +
> > +     if (cpu_latency_qos_request_active(&host->pm_qos_req))
> > +             host->pm_qos_enable = true;
> > +}
> > +
> > +/*
> > + * sdhci_pm_qos_exit - remove request from PM QoS
> > + */
> > +void sdhci_pm_qos_exit(struct sdhci_host *host)
> > +{
> > +     if (!host->pm_qos_enable)
> > +             return;
> > +
> > +     cpu_latency_qos_remove_request(&host->pm_qos_req);
> > +     host->pm_qos_enable = false;
> > +}
> > +
> > +/*
> > + * sdhci_pm_qos_update - update PM QoS request
> > + * @on - True, vote for perf PM QoS mode
> > + *     - False, vote for power save mode.
> > + */
> > +static void sdhci_pm_qos_update(struct sdhci_host *host, bool on)
> > +{
> > +     if (!host->pm_qos_enable)
> > +             return;
> > +
> > +     cpu_latency_qos_update_request(&host->pm_qos_req, on ?
> > +                                             0 : PM_QOS_DEFAULT_VALUE);
> > +}
> > +
> >  static void sdhci_init(struct sdhci_host *host, int soft)
> >  {
> >       struct mmc_host *mmc = host->mmc;
> > @@ -384,6 +424,9 @@ static void sdhci_init(struct sdhci_host *host, int soft)
> >               host->reinit_uhs = true;
> >               mmc->ops->set_ios(mmc, &mmc->ios);
> >       }
> > +
> > +     sdhci_pm_qos_init(host);
> > +     sdhci_pm_qos_update(host, true);
> >  }
> >
> >  static void sdhci_reinit(struct sdhci_host *host)
> > @@ -2072,6 +2115,7 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> >
> >       clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> >       sdhci_enable_clk(host, clk);
> > +     sdhci_pm_qos_update(host, true);
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_set_clock);
> >
> > @@ -3811,6 +3855,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
> >               sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
> >               free_irq(host->irq, host);
> >       }
> > +     sdhci_pm_qos_update(host, false);
> >
> >       return 0;
> >  }
> > @@ -3873,6 +3918,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
> >       spin_lock_irqsave(&host->lock, flags);
> >       host->runtime_suspended = true;
> >       spin_unlock_irqrestore(&host->lock, flags);
> > +     sdhci_pm_qos_update(host, false);
> >
> >       return 0;
> >  }
> > @@ -4987,6 +5033,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
> >       if (host->use_external_dma)
> >               sdhci_external_dma_release(host);
> >
> > +     sdhci_pm_qos_exit(host);
> >       host->adma_table = NULL;
> >       host->align_buffer = NULL;
> >  }
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index cd0e35a80542..685036ed888b 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -16,6 +16,7 @@
> >  #include <linux/io.h>
> >  #include <linux/leds.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/devfreq.h>
> >
> >  #include <linux/mmc/host.h>
> >
> > @@ -675,6 +676,9 @@ struct sdhci_host {
> >
> >       u64                     data_timeout;
> >
> > +     struct pm_qos_request pm_qos_req;       /* PM QoS request handle */
> > +     bool pm_qos_enable;                     /* flag to check PM QoS is enable */
> > +
> >       unsigned long private[] ____cacheline_aligned;
> >  };
> >
>

