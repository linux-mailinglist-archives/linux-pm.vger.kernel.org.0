Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD0C6D7D9
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 02:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfGSAjY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 20:39:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39945 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfGSAjX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 20:39:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id b17so20508313lff.7;
        Thu, 18 Jul 2019 17:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WCkyKYTPbPUh8SG+lXVnndg59ELsHEuerb/rYoY8h3w=;
        b=g3at9eEMDZ3nWk1PMPltMtWtHC+dIyIRlMQXGTRT7ya+EJuT8QAjC4J/HZ5w+dgPDU
         fgA63t1tXM/Cki9E1nY8qpomHnjiScNTpE66JF15GxbfJbWojQoZ9qjgk5OeOYeI9J6L
         /uEFU90Jn0QC42lFXYioKNCdMFF+Lf7cwMYX4+ERkUXbRZeliLeVtQxYf/Z5MsPorZVp
         K2zAJp2/KVdMjzL/wxu50iIjegpEfzGyBlJvXU2oIedDoknYDYne8OGPvaPvkFNCfPVu
         /N4F0KC4VNdDUnHGuFLFY3joAJ4JRAmGswjLEjn1WMBbVSycF/gkP4qSl750Gaqhoebc
         aRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WCkyKYTPbPUh8SG+lXVnndg59ELsHEuerb/rYoY8h3w=;
        b=Cm1Q6NUKiP0/7xok5ZPQDUf+p3XrL6/So5FME/dZMCxqLxFvtCwqDAKOGYSuW6xpRr
         K4Sdl7o2r8q+ClCJSKBtBGBgfUmsrw0+/lG2kDa0CZy44UgbxQThO0u2GBNDRrWs/kJ2
         5TG4nNeurvdssbhXXLB33LGSgn8O0e6X0BLdT7mcnwaI4Stm/GuiEB0kiXmaXw1BLV+W
         VBClRMRFS41xEBQHoUbEQ7CzUuPR0aQJ1XML+T9y7DNddb/Ig+itLiLygpaKXACBWH3z
         uYQxCBx+nIfbv/8sOmjiW8wfYXjlba8VyRnpMjEtU0+PEy6WmvasoBjvgjLx+4Mre0D8
         0BMA==
X-Gm-Message-State: APjAAAWJ1LpH899U9yePzFl3KhKVQz0i8x46bmtTO1QUWYN/TjNxlfvy
        alnX+hPTvTYqa6cZrmKm4rM=
X-Google-Smtp-Source: APXvYqwMShFT1VPyMw1AhICy0JWk5ONRwIM69pZQ6NM6d2V9e0EnMLTzjZqwDEz19lF2lnERUgsQXg==
X-Received: by 2002:ac2:4ace:: with SMTP id m14mr9975695lfp.99.1563496760535;
        Thu, 18 Jul 2019 17:39:20 -0700 (PDT)
Received: from dimatab (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id t137sm4192909lff.78.2019.07.18.17.39.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 17:39:20 -0700 (PDT)
Date:   Fri, 19 Jul 2019 03:42:58 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 18/24] PM / devfreq: tegra30: Optimize CPUFreq
 notifier
Message-ID: <20190719034258.651a9c06@dimatab>
In-Reply-To: <ce18694a-4281-a245-7bdf-299fedc3c724@samsung.com>
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223618epcas4p48e1e2ae7af04775ac50c68b7636f1a56@epcas4p4.samsung.com>
        <20190707223303.6755-19-digetx@gmail.com>
        <ce18694a-4281-a245-7bdf-299fedc3c724@samsung.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=D0=92 Thu, 18 Jul 2019 18:48:42 +0900
Chanwoo Choi <cw00.choi@samsung.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On 19. 7. 8. =EC=98=A4=EC=A0=84 7:32, Dmitry Osipenko wrote:
> > When CPU's memory activity is low or memory activity is high such
> > that CPU's frequency contribution to the boosting is not taken into
> > account, then there is no need to schedule devfreq's update. This
> > eliminates unnecessary CPU activity during of idling caused by the
> > scheduled work.
> >=20
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/devfreq/tegra30-devfreq.c | 73
> > +++++++++++++++++++++++++++---- 1 file changed, 64 insertions(+), 9
> > deletions(-) =20
>=20
> Patch4 add the 'cpufreq notifier' and this patch optimize the cpufreq
> notifier. I think t hat you can combine two patches.

I'd prefer to keep them separate for a sake of git bisection.

> >=20
> > diff --git a/drivers/devfreq/tegra30-devfreq.c
> > b/drivers/devfreq/tegra30-devfreq.c index
> > 43c9c5fbfe91..8d6bf6e9f1ae 100644 ---
> > a/drivers/devfreq/tegra30-devfreq.c +++
> > b/drivers/devfreq/tegra30-devfreq.c @@ -216,10 +216,10 @@ static
> > inline unsigned long do_percent(unsigned long val, unsigned int
> > pct) return val * pct / 100; }
> > =20
> > -static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq
> > *tegra) +static unsigned long actmon_cpu_to_emc_rate(struct
> > tegra_devfreq *tegra,
> > +					    unsigned int cpu_freq)
> >  {
> >  	const struct tegra_actmon_emc_ratio *ratio =3D
> > actmon_emc_ratios;
> > -	unsigned int cpu_freq =3D cpufreq_get(0);
> >  	unsigned int i;
> > =20
> >  	for (i =3D 0; i < ARRAY_SIZE(actmon_emc_ratios); i++,
> > ratio++) { @@ -239,15 +239,15 @@
> > tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra, struct
> > tegra_devfreq_device *dev, unsigned long target_freq)
> >  {
> > -	unsigned long static_cpu_emc_freq;
> > +	unsigned long cpu_emc_freq =3D 0;
> > =20
> > -	if (dev->config->avg_dependency_threshold &&
> > -	    dev->config->avg_dependency_threshold < dev->avg_freq)
> > {
> > -		static_cpu_emc_freq =3D
> > actmon_cpu_to_emc_rate(tegra);
> > -		target_freq =3D max(target_freq,
> > static_cpu_emc_freq);
> > -	}
> > +	if (!dev->config->avg_dependency_threshold)
> > +		return target_freq;
> > =20
> > -	return target_freq;
> > +	if (dev->avg_freq > dev->config->avg_dependency_threshold)
> > +		cpu_emc_freq =3D actmon_cpu_to_emc_rate(tegra,
> > cpufreq_get(0)); +
> > +	return max(target_freq, cpu_emc_freq);
> >  }
> > =20
> >  static unsigned long tegra_actmon_lower_freq(struct tegra_devfreq
> > *tegra, @@ -531,16 +531,71 @@ static void
> > tegra_actmon_delayed_update(struct work_struct *work)
> > mutex_unlock(&tegra->devfreq->lock); }
> > =20
> > +static unsigned long
> > +tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
> > +				  unsigned int cpu_freq)
> > +{
> > +	unsigned long freq, static_cpu_emc_freq;
> > +
> > +	/* check whether CPU's freq is taken into account at all */
> > +	if (tegra->devices[MCCPU].avg_freq <=3D
> > +	    tegra->devices[MCCPU].config->avg_dependency_threshold)
> > +		return 0;
> > +
> > +	static_cpu_emc_freq =3D actmon_cpu_to_emc_rate(tegra,
> > cpu_freq); +
> > +	/* compare static CPU-EMC freq with MCALL */
> > +	freq =3D tegra->devices[MCALL].avg_freq +
> > +	       tegra->devices[MCALL].boost_freq;
> > +
> > +	freq =3D tegra_actmon_upper_freq(tegra, freq);
> > +
> > +	if (freq =3D=3D tegra->max_freq || freq >=3D static_cpu_emc_freq)
> > +		return 0;
> > +
> > +	/* compare static CPU-EMC freq with MCCPU */
> > +	freq =3D tegra->devices[MCCPU].avg_freq +
> > +	       tegra->devices[MCCPU].boost_freq;
> > +
> > +	freq =3D tegra_actmon_upper_freq(tegra, freq);
> > +
> > +	if (freq =3D=3D tegra->max_freq || freq >=3D static_cpu_emc_freq)
> > +		return 0;
> > +
> > +	return static_cpu_emc_freq;
> > +}
> > +
> >  static int tegra_actmon_cpu_notify_cb(struct notifier_block *nb,
> >  				      unsigned long action, void
> > *ptr) {
> > +	struct cpufreq_freqs *freqs =3D ptr;
> >  	struct tegra_devfreq *tegra;
> > +	unsigned long old, new;
> > =20
> >  	if (action !=3D CPUFREQ_POSTCHANGE)
> >  		return NOTIFY_OK;
> > =20
> >  	tegra =3D container_of(nb, struct tegra_devfreq,
> > cpu_rate_change_nb);=20
> > +	/*
> > +	 * Quickly check whether CPU frequency should be taken
> > into account
> > +	 * at all, without blocking CPUFreq's core.
> > +	 */
> > +	if (mutex_trylock(&tegra->devfreq->lock)) {
> > +		old =3D tegra_actmon_cpufreq_contribution(tegra,
> > freqs->old);
> > +		new =3D tegra_actmon_cpufreq_contribution(tegra,
> > freqs->new);
> > +		mutex_unlock(&tegra->devfreq->lock);
> > +
> > +		/*
> > +		 * If CPU's frequency shouldn't be taken into
> > account at
> > +		 * the moment, then there is no need to update the
> > devfreq's
> > +		 * state because ISR will re-check CPU's frequency
> > on the
> > +		 * next interrupt.
> > +		 */
> > +		if (old =3D=3D new)
> > +			return NOTIFY_OK;
> > +	}
> > +
> >  	/*
> >  	 * CPUFreq driver should support
> > CPUFREQ_ASYNC_NOTIFICATION in order
> >  	 * to allow asynchronous notifications. This means we
> > can't block=20
>=20
>=20

