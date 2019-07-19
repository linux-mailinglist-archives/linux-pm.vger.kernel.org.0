Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E176D768
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 01:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfGRX5Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 19:57:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44311 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGRX5Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 19:57:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so3462311lfm.11;
        Thu, 18 Jul 2019 16:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hNVX5WkLZKyzpsgEvRPgrr6VSyip1kjBL3pFIcGFrXw=;
        b=uVuQxmVcp1S8+BuqZ5W3Hyy2zmI2PnHu2U+ySwPZuQUXDUEB55Mpb4xpBsVSUWhbMi
         nf8cVLFXdbgxwtJIvyMEJG7fDMAPnhem+mUGazCXiq+WiEFvOg6ICwSt+3M0Fj0sYSVz
         B2+pl64VUhgFlS26lJwtv3u8xEwtl6W2R5zqximyeA7mvGNiKdsCOL2Mk8OZ5c63eeCV
         f8btRtLJK3mFV/fNHlbuQxi+8aNC/yaHSVtinkPxN1IFPbiT2GCP4qks5bleb1rrllCY
         WHupjQ1zVTW20szgkOh0Os559rYlGDpxJu4KAZXH4SzClkvXNj5Nu/4kkDdexFvlPuC+
         r+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNVX5WkLZKyzpsgEvRPgrr6VSyip1kjBL3pFIcGFrXw=;
        b=LuIK1SFWJu0Q/VXEIAIov354nuyylXQcqUElDOyVzByG8rUze2Y+gz4x7AvuiZRNPk
         cUgrbJyP1RFYqrWJMPNO+gHmn8JKEwMct1eQTeSZe89NCw1FXwPf1pwhTpXvkVngyZB5
         gUfyDnfXV/lgnEy0NT9H64hwZsf6HdGDYMYepxPgCHJybyogJbA1vHwxc1hwAqttWhqU
         ggIe7uBobiuYd2fOdkTH50mcBGJBYOdX1K4yui9+KcLwAiQGM0LdVO3wLomBJurNcYHr
         aD38nlH08zPntL36RX9lcavH2erzrIaV0exCryzL4OF51HH6zv5hiKNukD7LBTNet1if
         inIQ==
X-Gm-Message-State: APjAAAX7NUJTU1191R93H+whE3IOTfLWmcVqpktVWXJVW3ZXtcRfKBiu
        lIRJUK3h3P6qg92n8HvEXtBFOlM9
X-Google-Smtp-Source: APXvYqyplyQijeSE1Oczb6QVeMUKQdnCn/cQQPfi0wmj7fawasIU3QkEslwz64Ifhi6wRFnGk+R2Qg==
X-Received: by 2002:ac2:518d:: with SMTP id u13mr22522316lfi.40.1563494241949;
        Thu, 18 Jul 2019 16:57:21 -0700 (PDT)
Received: from dimatab (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id 27sm5315210ljw.97.2019.07.18.16.57.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 16:57:21 -0700 (PDT)
Date:   Fri, 19 Jul 2019 03:00:58 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/24] PM / devfreq: tegra30: Set up watermarks
 properly
Message-ID: <20190719030058.617de581@dimatab>
In-Reply-To: <9efb75fe-994f-24c7-7872-b5e5041105a6@samsung.com>
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223647epcas5p4eecd38dad5a5c12300f9e1945f3d07fe@epcas5p4.samsung.com>
        <20190707223303.6755-6-digetx@gmail.com>
        <9efb75fe-994f-24c7-7872-b5e5041105a6@samsung.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=D0=92 Thu, 18 Jul 2019 19:17:17 +0900
Chanwoo Choi <cw00.choi@samsung.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On 19. 7. 8. =EC=98=A4=EC=A0=84 7:32, Dmitry Osipenko wrote:
> > The current implementation is inaccurate and results in very
> > intensive interrupt activity, which neglects the whole idea of
> > polling offload to hardware. The reason of the shortcoming is that
> > watermarks are not set up correctly and this results in ACTMON
> > constantly asking to change freq and then these requests are
> > ignored. The end result of this patch is that there are few
> > hundreds of ACTMON's interrupts instead of tens thousands after few
> > minutes of a working devfreq, meanwhile the transitions activity
> > stays about the same and governor becomes more reactive.
> >=20
> > Since watermarks are set precisely correct now, the boosting logic
> > is changed a tad to accommodate the change. The "average sustain
> > coefficient" multiplier is gone now since there is no need to
> > compensate the improper watermarks and EMC frequency-bump happens
> > once boosting hits the upper watermark enough times, depending on
> > the per-device boosting threshold.
> >=20
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/devfreq/tegra30-devfreq.c | 293
> > +++++++++++++++++++++--------- 1 file changed, 209 insertions(+),
> > 84 deletions(-)
> >=20
> > diff --git a/drivers/devfreq/tegra30-devfreq.c
> > b/drivers/devfreq/tegra30-devfreq.c index
> > 4be7858c33bc..16f7e6cf3b99 100644 ---
> > a/drivers/devfreq/tegra30-devfreq.c +++
> > b/drivers/devfreq/tegra30-devfreq.c @@ -47,6 +47,8 @@
> > =20
> >  #define ACTMON_DEV_INTR_CONSECUTIVE_UPPER
> > BIT(31) #define
> > ACTMON_DEV_INTR_CONSECUTIVE_LOWER			BIT(30)
> > +#define
> > ACTMON_DEV_INTR_AVG_BELOW_WMARK
> > BIT(25) +#define
> > ACTMON_DEV_INTR_AVG_ABOVE_WMARK
> > BIT(24) #define
> > ACTMON_ABOVE_WMARK_WINDOW				1 #define
> > ACTMON_BELOW_WMARK_WINDOW				3 @@ -63,9
> > +65,8 @@
> >   * ACTMON_AVERAGE_WINDOW_LOG2: default value for @DEV_CTRL_K_VAL,
> > which
> >   * translates to 2 ^ (K_VAL + 1). ex: 2 ^ (6 + 1) =3D 128
> >   */
> > -#define ACTMON_AVERAGE_WINDOW_LOG2			6
> > -#define ACTMON_SAMPLING_PERIOD
> > 12 /* ms */ -#define
> > ACTMON_DEFAULT_AVG_BAND				6  /* 1/10
> > of % */ +#define
> > ACTMON_AVERAGE_WINDOW_LOG2				6
> > +#define
> > ACTMON_SAMPLING_PERIOD					12 /*
> > ms */ #define
> > KHZ							1000 @@
> > -142,9 +143,6 @@ struct tegra_devfreq_device {
> >  	 * watermark breaches.
> >  	 */
> >  	unsigned long boost_freq;
> > -
> > -	/* Optimal frequency calculated from the stats for this
> > device */
> > -	unsigned long target_freq;
> >  };
> > =20
> >  struct tegra_devfreq {
> > @@ -156,7 +154,6 @@ struct tegra_devfreq {
> > =20
> >  	struct clk		*emc_clock;
> >  	unsigned long		max_freq;
> > -	unsigned long		cur_freq;
> >  	struct notifier_block	rate_change_nb;
> > =20
> >  	struct tegra_devfreq_device
> > devices[ARRAY_SIZE(actmon_device_configs)]; @@ -205,42 +202,182 @@
> > static unsigned long do_percent(unsigned long val, unsigned int
> > pct) return val * pct / 100; }
> > =20
> > +static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq
> > *tegra) +{
> > +	struct tegra_actmon_emc_ratio *ratio =3D actmon_emc_ratios;
> > +	unsigned int cpu_freq =3D cpufreq_get(0);
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(actmon_emc_ratios); i++,
> > ratio++) {
> > +		if (cpu_freq >=3D ratio->cpu_freq) {
> > +			if (ratio->emc_freq >=3D tegra->max_freq)
> > +				return tegra->max_freq;
> > +			else
> > +				return ratio->emc_freq;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static unsigned long
> > +tegra_actmon_account_cpu_freq(struct tegra_devfreq *tegra,
> > +			      struct tegra_devfreq_device *dev,
> > +			      unsigned long target_freq)
> > +{
> > +	unsigned long static_cpu_emc_freq;
> > +
> > +	if (dev->config->avg_dependency_threshold &&
> > +	    dev->config->avg_dependency_threshold <
> > dev->avg_count) {
> > +		static_cpu_emc_freq =3D
> > actmon_cpu_to_emc_rate(tegra);
> > +		target_freq =3D max(target_freq,
> > static_cpu_emc_freq);
> > +	}
> > +
> > +	return target_freq;
> > +}
> > +
> > +static unsigned long tegra_actmon_lower_freq(struct tegra_devfreq
> > *tegra,
> > +					     unsigned long
> > target_freq) +{
> > +	unsigned long lower =3D target_freq;
> > +	struct dev_pm_opp *opp;
> > +
> > +	opp =3D
> > dev_pm_opp_find_freq_floor(tegra->devfreq->dev.parent, &lower);
> > +	if (IS_ERR(opp))
> > +		lower =3D 0;
> > +	else
> > +		dev_pm_opp_put(opp);
> > +
> > +	return lower;
> > +}
> > +
> > +static unsigned long tegra_actmon_upper_freq(struct tegra_devfreq
> > *tegra,
> > +					     unsigned long
> > target_freq) +{
> > +	unsigned long upper =3D target_freq + 1;
> > +	struct dev_pm_opp *opp;
> > +
> > +	opp =3D
> > dev_pm_opp_find_freq_ceil(tegra->devfreq->dev.parent, &upper);
> > +	if (IS_ERR(opp))
> > +		upper =3D ULONG_MAX;
> > +	else
> > +		dev_pm_opp_put(opp);
> > +
> > +	return upper;
> > +}
> > +
> > +static void tegra_actmon_get_lower_upper(struct tegra_devfreq
> > *tegra,
> > +					 struct
> > tegra_devfreq_device *dev,
> > +					 unsigned long target_freq,
> > +					 unsigned long *lower,
> > +					 unsigned long *upper)
> > +{
> > +	/*
> > +	 * Memory frequencies are guaranteed to have 1MHz
> > granularity
> > +	 * and thus we need this rounding down to get a proper
> > watermarks
> > +	 * range in a case where target_freq falls into a range of
> > +	 * next_possible_opp_freq - 1MHz.
> > +	 */
> > +	target_freq =3D round_down(target_freq, 1000000);
> > +
> > +	/* watermarks are set at the borders of the corresponding
> > OPPs */
> > +	*lower =3D tegra_actmon_lower_freq(tegra, target_freq);
> > +	*upper =3D tegra_actmon_upper_freq(tegra, target_freq);
> > +
> > +	*lower /=3D KHZ;
> > +	*upper /=3D KHZ;
> > +
> > +	/*
> > +	 * The upper watermark should take into account CPU's
> > frequency
> > +	 * because cpu_to_emc_rate() may override the target_freq
> > with
> > +	 * a higher value and thus upper watermark need to be set
> > up
> > +	 * accordingly to avoid parasitic upper-events.
> > +	 */
> > +	*upper =3D tegra_actmon_account_cpu_freq(tegra, dev, *upper);
> > +
> > +	*lower *=3D ACTMON_SAMPLING_PERIOD;
> > +	*upper *=3D ACTMON_SAMPLING_PERIOD;
> > +}
> > +
> >  static void tegra_devfreq_update_avg_wmark(struct tegra_devfreq
> > *tegra, struct tegra_devfreq_device *dev)
> >  {
> > -	u32 avg =3D dev->avg_count;
> > -	u32 avg_band_freq =3D tegra->max_freq *
> > ACTMON_DEFAULT_AVG_BAND / KHZ;
> > -	u32 band =3D avg_band_freq * ACTMON_SAMPLING_PERIOD;
> > +	unsigned long lower, upper, freq;
> > =20
> > -	device_writel(dev, avg + band, ACTMON_DEV_AVG_UPPER_WMARK);
> > +	freq =3D dev->avg_count / ACTMON_SAMPLING_PERIOD * KHZ;
> > +	tegra_actmon_get_lower_upper(tegra, dev, freq, &lower,
> > &upper);=20
> > -	avg =3D max(dev->avg_count, band);
> > -	device_writel(dev, avg - band, ACTMON_DEV_AVG_LOWER_WMARK);
> > +	/*
> > +	 * We want to get interrupts when MCCPU client crosses the
> > +	 * dependency threshold in order to take into / out of
> > account
> > +	 * the CPU's freq.
> > +	 */
> > +	if (lower < dev->config->avg_dependency_threshold &&
> > +	    upper > dev->config->avg_dependency_threshold) {
> > +		if (dev->avg_count <
> > dev->config->avg_dependency_threshold)
> > +			upper =3D
> > dev->config->avg_dependency_threshold;
> > +		else
> > +			lower =3D
> > dev->config->avg_dependency_threshold;
> > +	}
> > +
> > +	device_writel(dev, lower, ACTMON_DEV_AVG_LOWER_WMARK);
> > +	device_writel(dev, upper, ACTMON_DEV_AVG_UPPER_WMARK);
> >  }
> > =20
> >  static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
> > -				       struct tegra_devfreq_device
> > *dev)
> > +				       struct tegra_devfreq_device
> > *dev,
> > +				       unsigned long freq)
> >  {
> > -	u32 val =3D tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
> > +	unsigned long lower, upper, delta;
> > +
> > +	/*
> > +	 * Boosting logic kicks-in once lower / upper watermark is
> > hit.
> > +	 * The watermarks are based on the updated EMC rate and the
> > +	 * average activity.
> > +	 *
> > +	 * The higher watermark is set in accordance to the EMC
> > rate
> > +	 * because we want to set it to the highest mark here and
> > EMC rate
> > +	 * represents that mark. The consecutive-upper interrupts
> > are
> > +	 * always enabled and we don't want to receive them if
> > they won't
> > +	 * do anything useful, hence the upper watermark is capped
> > to maximum.
> > +	 * Note that the EMC rate is changed once boosting pushed
> > the rate
> > +	 * too high, in that case boosting-up will be stopped
> > because
> > +	 * upper watermark is much higher now and it is
> > *important* to
> > +	 * stop the unwanted interrupts.
> > +	 */
> > +	tegra_actmon_get_lower_upper(tegra, dev, freq - 1, &lower,
> > &upper); +
> > +	delta =3D do_percent(upper - lower,
> > dev->config->boost_up_threshold);
> > +	device_writel(dev, lower + delta, ACTMON_DEV_UPPER_WMARK);
> > =20
> > -	device_writel(dev, do_percent(val,
> > dev->config->boost_up_threshold),
> > -		      ACTMON_DEV_UPPER_WMARK);
> > +	/*
> > +	 * Meanwhile the lower mark is based on the average value
> > +	 * because it is the lowest possible consecutive-mark for
> > this
> > +	 * device. Once that mark is hit and boosting is stopped,
> > the
> > +	 * interrupt is disabled by ISR.
> > +	 */
> > +	freq =3D dev->avg_count / ACTMON_SAMPLING_PERIOD * KHZ;
> > +	tegra_actmon_get_lower_upper(tegra, dev, freq, &lower,
> > &upper);=20
> > -	device_writel(dev, do_percent(val,
> > dev->config->boost_down_threshold),
> > -		      ACTMON_DEV_LOWER_WMARK);
> > +	delta =3D do_percent(upper - lower,
> > dev->config->boost_down_threshold);
> > +	device_writel(dev, lower + delta, ACTMON_DEV_LOWER_WMARK);
> >  }
> > =20
> >  static void actmon_isr_device(struct tegra_devfreq *tegra,
> >  			      struct tegra_devfreq_device *dev)
> >  {
> > -	u32 intr_status, dev_ctrl;
> > +	u32 intr_status, dev_ctrl, avg_intr_mask;
> > =20
> >  	dev->avg_count =3D device_readl(dev, ACTMON_DEV_AVG_COUNT);
> > -	tegra_devfreq_update_avg_wmark(tegra, dev);
> > -
> >  	intr_status =3D device_readl(dev, ACTMON_DEV_INTR_STATUS);
> >  	dev_ctrl =3D device_readl(dev, ACTMON_DEV_CTRL);
> > =20
> > +	avg_intr_mask =3D ACTMON_DEV_INTR_AVG_BELOW_WMARK |
> > +			ACTMON_DEV_INTR_AVG_ABOVE_WMARK;
> > +
> > +	if (intr_status & avg_intr_mask)
> > +		tegra_devfreq_update_avg_wmark(tegra, dev);
> > +
> >  	if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_UPPER) {
> >  		/*
> >  		 * new_boost =3D min(old_boost * up_coef + step,
> > max_freq) @@ -253,8 +390,6 @@ static void actmon_isr_device(struct
> > tegra_devfreq *tegra,=20
> >  		if (dev->boost_freq >=3D tegra->max_freq)
> >  			dev->boost_freq =3D tegra->max_freq;
> > -		else
> > -			dev_ctrl |=3D
> > ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN; } else if (intr_status
> > & ACTMON_DEV_INTR_CONSECUTIVE_LOWER) { /*
> >  		 * new_boost =3D old_boost * down_coef
> > @@ -263,63 +398,37 @@ static void actmon_isr_device(struct
> > tegra_devfreq *tegra, dev->boost_freq =3D do_percent(dev->boost_freq,
> >  					     dev->config->boost_down_coeff);
> > =20
> > -		dev_ctrl |=3D
> > ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN; -
> >  		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >>
> > 1)) dev->boost_freq =3D 0;
> > -		else
> > -			dev_ctrl |=3D
> > ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN; }
> > =20
> > -	if (dev->config->avg_dependency_threshold) {
> > -		if (dev->avg_count >=3D
> > dev->config->avg_dependency_threshold)
> > -			dev_ctrl |=3D
> > ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
> > -		else if (dev->boost_freq =3D=3D 0)
> > -			dev_ctrl &=3D
> > ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
> > +	if (intr_status & avg_intr_mask) {
> > +		/*
> > +		 * Once average watermark is hit, it means that
> > the memory
> > +		 * activity changed significantly and thus
> > boosting-up shall
> > +		 * be reset because EMC clock rate will be changed
> > and
> > +		 * boosting will restart in this case.
> > +		 */
> > +		dev->boost_freq =3D 0;
> >  	}
> > =20
> > -	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
> > +	/* no boosting =3D> no need for consecutive-down interrupt */
> > +	if (dev->boost_freq =3D=3D 0)
> > +		dev_ctrl &=3D
> > ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;=20
> > +	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
> >  	device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
> > ACTMON_DEV_INTR_STATUS); }
> > =20
> > -static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq
> > *tegra,
> > -					    unsigned long cpu_freq)
> > -{
> > -	unsigned int i;
> > -	struct tegra_actmon_emc_ratio *ratio =3D actmon_emc_ratios;
> > -
> > -	for (i =3D 0; i < ARRAY_SIZE(actmon_emc_ratios); i++,
> > ratio++) {
> > -		if (cpu_freq >=3D ratio->cpu_freq) {
> > -			if (ratio->emc_freq >=3D tegra->max_freq)
> > -				return tegra->max_freq;
> > -			else
> > -				return ratio->emc_freq;
> > -		}
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -static void actmon_update_target(struct tegra_devfreq *tegra,
> > -				 struct tegra_devfreq_device *dev)
> > +static unsigned long actmon_update_target(struct tegra_devfreq
> > *tegra,
> > +					  struct
> > tegra_devfreq_device *dev) {
> > -	unsigned long cpu_freq =3D 0;
> > -	unsigned long static_cpu_emc_freq =3D 0;
> > -	unsigned int avg_sustain_coef;
> > -
> > -	if (dev->config->avg_dependency_threshold) {
> > -		cpu_freq =3D cpufreq_get(0);
> > -		static_cpu_emc_freq =3D
> > actmon_cpu_to_emc_rate(tegra, cpu_freq);
> > -	}
> > +	unsigned long target_freq;
> > =20
> > -	dev->target_freq =3D dev->avg_count / ACTMON_SAMPLING_PERIOD;
> > -	avg_sustain_coef =3D 100 * 100 /
> > dev->config->boost_up_threshold;
> > -	dev->target_freq =3D do_percent(dev->target_freq,
> > avg_sustain_coef);
> > -	dev->target_freq +=3D dev->boost_freq;
> > +	target_freq =3D dev->avg_count / ACTMON_SAMPLING_PERIOD +
> > dev->boost_freq;
> > +	target_freq =3D tegra_actmon_account_cpu_freq(tegra, dev,
> > target_freq);=20
> > -	if (dev->avg_count >=3D
> > dev->config->avg_dependency_threshold)
> > -		dev->target_freq =3D max(dev->target_freq,
> > static_cpu_emc_freq);
> > +	return target_freq;
> >  }
> > =20
> >  static irqreturn_t actmon_thread_isr(int irq, void *data)
> > @@ -351,8 +460,8 @@ static int tegra_actmon_rate_notify_cb(struct
> > notifier_block *nb, unsigned long action, void *ptr)
> >  {
> >  	struct clk_notifier_data *data =3D ptr;
> > -	struct tegra_devfreq *tegra;
> >  	struct tegra_devfreq_device *dev;
> > +	struct tegra_devfreq *tegra;
> >  	unsigned int i;
> > =20
> >  	if (action !=3D POST_RATE_CHANGE)
> > @@ -360,12 +469,28 @@ static int tegra_actmon_rate_notify_cb(struct
> > notifier_block *nb,=20
> >  	tegra =3D container_of(nb, struct tegra_devfreq,
> > rate_change_nb);=20
> > -	tegra->cur_freq =3D data->new_rate / KHZ;
> > -
> > +	/*
> > +	 * EMC rate could change due to three reasons:
> > +	 *
> > +	 *    1. Average watermark hit
> > +	 *    2. Boosting overflow
> > +	 *    3. CPU freq change
> > +	 *
> > +	 * Once rate is changed, the consecutive watermarks need
> > to be
> > +	 * updated in order for boosting to work properly and to
> > avoid
> > +	 * unnecessary interrupts. Note that the consecutive range
> > is set for
> > +	 * all of devices using the same rate, hence if CPU is
> > doing much
> > +	 * less than the other memory clients, then its upper
> > watermark will
> > +	 * be very high in comparison to the actual activity
> > (lower watermark)
> > +	 * and thus unnecessary upper-interrupts will be
> > suppressed.
> > +	 *
> > +	 * The average watermarks also should be updated because
> > of 3.
> > +	 */
> >  	for (i =3D 0; i < ARRAY_SIZE(tegra->devices); i++) {
> >  		dev =3D &tegra->devices[i];
> > =20
> > -		tegra_devfreq_update_wmark(tegra, dev);
> > +		tegra_devfreq_update_avg_wmark(tegra, dev);
> > +		tegra_devfreq_update_wmark(tegra, dev,
> > data->new_rate); }
> > =20
> >  	return NOTIFY_OK;
> > @@ -374,15 +499,14 @@ static int tegra_actmon_rate_notify_cb(struct
> > notifier_block *nb, static void
> > tegra_actmon_configure_device(struct tegra_devfreq *tegra, struct
> > tegra_devfreq_device *dev) {
> > -	u32 val =3D 0;
> > -
> > -	dev->target_freq =3D tegra->cur_freq;
> > +	u32 val =3D 0, target_freq;
> > =20
> > -	dev->avg_count =3D tegra->cur_freq * ACTMON_SAMPLING_PERIOD;
> > +	target_freq =3D clk_get_rate(tegra->emc_clock) / KHZ;
> > +	dev->avg_count =3D target_freq * ACTMON_SAMPLING_PERIOD;
> >  	device_writel(dev, dev->avg_count, ACTMON_DEV_INIT_AVG);
> > =20
> >  	tegra_devfreq_update_avg_wmark(tegra, dev);
> > -	tegra_devfreq_update_wmark(tegra, dev);
> > +	tegra_devfreq_update_wmark(tegra, dev, target_freq);
> > =20
> >  	device_writel(dev, ACTMON_COUNT_WEIGHT,
> > ACTMON_DEV_COUNT_WEIGHT); device_writel(dev,
> > ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS); @@ -469,13
> > +593,13 @@ static int tegra_devfreq_get_dev_status(struct device
> > *dev, struct tegra_devfreq_device *actmon_dev; unsigned long
> > cur_freq;=20
> > -	cur_freq =3D READ_ONCE(tegra->cur_freq);
> > +	cur_freq =3D clk_get_rate(tegra->emc_clock);
> > =20
> >  	/* To be used by the tegra governor */
> >  	stat->private_data =3D tegra;
> > =20
> >  	/* The below are to be used by the other governors */
> > -	stat->current_frequency =3D cur_freq * KHZ;
> > +	stat->current_frequency =3D cur_freq;
> > =20
> >  	actmon_dev =3D &tegra->devices[MCALL];
> > =20
> > @@ -486,7 +610,7 @@ static int tegra_devfreq_get_dev_status(struct
> > device *dev, stat->busy_time *=3D 100 / BUS_SATURATION_RATIO;
> > =20
> >  	/* Number of cycles in a sampling period */
> > -	stat->total_time =3D ACTMON_SAMPLING_PERIOD * cur_freq;
> > +	stat->total_time =3D cur_freq / KHZ * ACTMON_SAMPLING_PERIOD;
> > =20
> >  	stat->busy_time =3D min(stat->busy_time, stat->total_time);
> > =20
> > @@ -505,6 +629,7 @@ static int tegra_governor_get_target(struct
> > devfreq *devfreq, struct devfreq_dev_status *stat;
> >  	struct tegra_devfreq *tegra;
> >  	struct tegra_devfreq_device *dev;
> > +	unsigned long dev_target_freq;
> >  	unsigned long target_freq =3D 0;
> >  	unsigned int i;
> >  	int err;
> > @@ -520,9 +645,9 @@ static int tegra_governor_get_target(struct
> > devfreq *devfreq, for (i =3D 0; i < ARRAY_SIZE(tegra->devices); i++) {
> >  		dev =3D &tegra->devices[i];
> > =20
> > -		actmon_update_target(tegra, dev);
> > +		dev_target_freq =3D actmon_update_target(tegra, dev);
> > =20
> > -		target_freq =3D max(target_freq, dev->target_freq);
> > +		target_freq =3D max(target_freq, dev_target_freq);
> >  	}
> > =20
> >  	*freq =3D target_freq * KHZ;
> > @@ -642,7 +767,6 @@ static int tegra_devfreq_probe(struct
> > platform_device *pdev) return rate;
> >  	}
> > =20
> > -	tegra->cur_freq =3D clk_get_rate(tegra->emc_clock) / KHZ;
> >  	tegra->max_freq =3D rate / KHZ;
> > =20
> >  	for (i =3D 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
> > @@ -671,7 +795,8 @@ static int tegra_devfreq_probe(struct
> > platform_device *pdev) platform_set_drvdata(pdev, tegra);
> > =20
> >  	tegra->rate_change_nb.notifier_call =3D
> > tegra_actmon_rate_notify_cb;
> > -	err =3D clk_notifier_register(tegra->emc_clock,
> > &tegra->rate_change_nb);
> > +	err =3D clk_notifier_register(tegra->emc_clock,
> > +				    &tegra->rate_change_nb);
> >  	if (err) {
> >  		dev_err(&pdev->dev,
> >  			"Failed to register rate change
> > notifier\n");=20
>=20
>=20
> Maybe, it is possible to merge patch4/patch19/patch20 to one patch.

All these three patches are completely separate changes, thus they
should be kept separate.
