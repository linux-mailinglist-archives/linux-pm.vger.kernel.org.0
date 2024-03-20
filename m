Return-Path: <linux-pm+bounces-5155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330AE88142B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 16:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC121F2103E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D04F4AEED;
	Wed, 20 Mar 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="HmUfmCgy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ddFaGcNB"
X-Original-To: linux-pm@vger.kernel.org
Received: from wflow5-smtp.messagingengine.com (wflow5-smtp.messagingengine.com [64.147.123.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF0F47F77;
	Wed, 20 Mar 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947289; cv=none; b=Ok0y4QOlBO9GiHNrV+TmjVIgzncpgYRzaqk3nu0Ta+VVOUO+sil96xfWa16/ZirRj1YW1EI0ymnsQbL+vFTARPCwG7jsLvHU9poibdHdl9hqlEqTms8JPtFPWSFSzHjtVZZ8cTUDvKfNvASl/9ZwxSSgxFa10OaauXLwiZ199vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947289; c=relaxed/simple;
	bh=OjgwgzVRO/fVYmeGXGSSsRNo4kb6E0q3D0LmsbpDSSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGDp239ji/lXiLje99q0+n/KP1mrBnfZs77f+uOdSpgbRinQScEMfGHUS+JIt2bm35tGmkaeYQaAp/w9rYkMv74R/C4asDXE+kPFNhVTSwrzCXt0J9Gd2hPL4bWA4KG8Vk9mVacbHFNNpdmf7ivlCkYyOlHKgSQKkK2lYiNi0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=HmUfmCgy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ddFaGcNB; arc=none smtp.client-ip=64.147.123.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.west.internal (Postfix) with ESMTP id 596992CC045C;
	Wed, 20 Mar 2024 11:08:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 20 Mar 2024 11:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710947281;
	 x=1710950881; bh=jMiZTHE/GUhyhYg59+y2RR8gcRX58T/2Vt95sYEBAz4=; b=
	HmUfmCgyVn5UjX+ysD2vusUmG3UkopuNouB44wWfhcz19i+oLxgKX/66hCzzhV3s
	mj/B06+CnTf5SK6n3/qIbWqbskqq7WBXCe4qF/1304nKL2Wp8rBTbqdFWaLtBuZZ
	jpCleVj+F0FrZ3jEL+nYKGw3gaBq0MlYd4v5O8kkw9Ir6pFR1VqmxD2WP7K1YDdY
	DFE+pHQuEmWpYm1JhInIrxQkSFQTXp+i5JxsjYn7s/EYFAogl18JJNRNlGi70mR+
	Y3r+da6tjM/Dg51yJ8YVr8h8OnAKqeYOMHjVoBAdkFk91am6FnWceK7EbQkdYsDw
	5GJOb8YDV+dQFt7pUifZ1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=i80c9496c.fm2; t=
	1710947281; x=1710950881; bh=jMiZTHE/GUhyhYg59+y2RR8gcRX58T/2Vt9
	5sYEBAz4=; b=ddFaGcNBkBJiqU5lRFZKNBB0WnJucyc5DEEgfPTxYWGNDJMGO6S
	bfOet9g1H9P7b+Ci5nI+pWZLL50fh1xxOG8tBtH39wel/AgLx/7e6R3qKfTh6/Mq
	JO8vwPTd7m4jBID1D007+Gyk9+JbYAguIJdpQjNdzTPSc0vgh/An5dgZqJ1OnIyc
	YWytruBwWzCob7vKeE2ZZgS62h4u5ZTGxvZ6ikNxGCBAYMnWYxIxrwQnRe+vo6EG
	R770kvCusFcFGMsCFXU0BVFmyFib8CaAu5u6iiByxY2Z/4y9tTwbj0XZIlNl1o0I
	2dSIhbbbls3jcimfVwpgtdcjYuIFSjADGXQ==
X-ME-Sender: <xms:0Pv6ZXeY8KDvaPPlKS--tiGnQN5tuqEXHaNB6PAZemRebRhN7pRvEA>
    <xme:0Pv6ZdPwFbdEwZxY1cgBhNBb-wG7W4y_9kfPV_LNkulU4iCcXG2tzn36mHX05wSWz
    5655leJFQo8VtF4jKY>
X-ME-Received: <xmr:0Pv6ZQh0mZ6S1zlkgxX12dyzF2YSns-ta4OsbkjHi3KA-BXEZEycuzqiGtC3N-qm6xaYIaVDT1PlV26z7JSrEOyoN0L0rco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeggdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheppfhikhhl
    rghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlhhunhguodhrvghnvg
    hsrghssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepfefhleelhfff
    jefgfedugfegjeelhfevheeikefhueelgfdtfeeuhefftddvleeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhsohguvghr
    lhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvg
X-ME-Proxy: <xmx:0fv6ZY8D2ZGnLkXkpsZBfVpqFuROaS4Q631CY90GD2L2CKJzTBNmCw>
    <xmx:0fv6ZTvCsJhAPdUvBb3nUdpqOqOnNh-PCPaHLI7vWIFF4lE-4c2vjA>
    <xmx:0fv6ZXFRDovfhwic-ciMih-Tm9KTKcJ9mLmOn7toBlVlRJ1dZEWVsw>
    <xmx:0fv6ZaPEDZclqBgk0HzPZXs3QZNxiwRn01ffnmQQrb7iwOLILP5dMg>
    <xmx:0fv6ZZBuLUOqnslnmPg0uDFDv8iEmGxmVAzeXKoHYKmfIWE8ungEuiC0ufoFNKq6>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Mar 2024 11:08:00 -0400 (EDT)
Date: Wed, 20 Mar 2024 16:07:58 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/3] thermal: rcar_gen3: Update temperature approximation
 calculation
Message-ID: <20240320150758.GF3438308@ragnatech.se>
References: <20240307110216.2962918-1-niklas.soderlund+renesas@ragnatech.se>
 <20240307110216.2962918-3-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdU1RxN1iEnok8Hp6ZMWY1QVuu71PuG4OwWcKgPSv-kFiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU1RxN1iEnok8Hp6ZMWY1QVuu71PuG4OwWcKgPSv-kFiA@mail.gmail.com>

Hi Geert,

Thanks for your feedback.

On 2024-03-20 14:22:31 +0100, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> Thanks for your patch!
> 
> On Thu, Mar 7, 2024 at 12:03 PM Niklas Söderlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
> > The initial driver used a formula to approximation the temperature and
> 
> approximate
> 
> > register value reversed engineered form an out-of-tree BSP driver. This
> 
> values ... from
> 
> > was needed as the datasheet at the time did not contain any information
> > on how to do this. Later Gen3 (Rev 2.30) and Gen4 (all) now contains
> > this information.
> >
> > Update the approximation formula to use the datasheets information
> 
> datasheet's
> 
> > instead of the reversed engineered one.
> 
> reverse-engineered
> 
> > On an idle M3-N without fused calibration values for PTAT and THCODE the
> > old formula reports,
> >
> >     zone0: 52000
> >     zone1: 53000
> >     zone2: 52500
> >
> > While the new formula under the same circumstances reports,
> >
> >     zone0: 52500
> >     zone1: 54000
> >     zone2: 54000
> >
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> > --- a/drivers/thermal/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/rcar_gen3_thermal.c
> 
> > @@ -112,51 +115,41 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
> >  /*
> >   * Linear approximation for temperature
> >   *
> > - * [reg] = [temp] * a + b => [temp] = ([reg] - b) / a
> > + * [temp] = ((thadj - [reg]) * a) / b + adj
> > + * [reg] = thadj - ([temp] - adj) * b / a
> >   *
> >   * The constants a and b are calculated using two triplets of int values PTAT
> >   * and THCODE. PTAT and THCODE can either be read from hardware or use hard
> >   * coded values from driver. The formula to calculate a and b are taken from
> 
> the driver
> 
> > - * BSP and sparsely documented and understood.
> > + * the datasheet. Different calculations are needed for a and b depending on
> > + * if the input variable ([temp] or [reg]) are above or below a threshold. The
> 
> variables
> 
> > + * threshold is also calculated from PTAT and THCODE using formula from the
> 
> formulas
> 
> > + * datasheet.
> >   *
> > - * Examining the linear formula and the formula used to calculate constants a
> > - * and b while knowing that the span for PTAT and THCODE values are between
> > - * 0x000 and 0xfff the largest integer possible is 0xfff * 0xfff == 0xffe001.
> > - * Integer also needs to be signed so that leaves 7 bits for binary
> > - * fixed point scaling.
> > + * The constant thadj is one of the THCODE values, which one to use depends on
> > + * the threshold and input value.
> > + *
> > + * The constants adj is taken verbatim from the datasheet. Two values exists,
> > + * which one to use depends on the input value and the calculated threshold.
> > + * Furthermore different SoCs models supported by the driver have different sets
> 
> SoC
> 
> > + * of values. The values for each model is stored in the device match data.
> 
> are
> 
> >   */
> 
> > @@ -172,19 +165,29 @@ static int rcar_gen3_thermal_round(int temp)
> >  static int rcar_gen3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> >  {
> >         struct rcar_gen3_thermal_tsc *tsc = thermal_zone_device_priv(tz);
> > -       int mcelsius, val;
> > -       int reg;
> > +       struct rcar_gen3_thermal_priv *priv = tsc->priv;
> > +       const struct equation_set_coef *coef;
> > +       int adj, mcelsius, reg, thcode;
> >
> >         /* Read register and convert to mili Celsius */
> >         reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
> >
> > -       if (reg <= tsc->thcode[1])
> > -               val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1,
> > -                               tsc->coef.a1);
> > -       else
> > -               val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2,
> > -                               tsc->coef.a2);
> > -       mcelsius = FIXPT_TO_MCELSIUS(val);
> > +       if (reg < tsc->thcode[1]) {
> > +               adj = priv->info->adj_below;
> > +               coef = &tsc->coef.below;
> > +               thcode = tsc->thcode[2];
> > +       } else {
> > +               adj = priv->info->adj_above;
> > +               coef = &tsc->coef.above;
> > +               thcode = tsc->thcode[0];
> > +       }
> > +
> > +       /*
> > +        * The dividend can't be grown as it might overflow, instead shorten the
> > +        * divisor to convert to millidegree Celsius. If we convert after the
> > +        * division precision is lost to a full degree Celsius.
> > +        */
> > +       mcelsius = DIV_ROUND_CLOSEST(coef->a * (thcode - reg), coef->b / 1000) + adj * 1000;
> 
> Don't you lose a lot of precision by pre-dividing b by 1000?

I do, but the docs say the measurement is only accurate to +/- 2 degrees 
C anyhow so I don't see a real issue losing precision which at worst is 
1 degree C. Of course if a smart way to avoid this lose without the risk of
overflowing that would be ideal.

I see in the follow up reply to this you suggest a way to increase the 
precision by a factor of 10, I will use that in next version.


> 
> >
> >         /* Guaranteed operating range is -40C to 125C. */
> >
> > @@ -198,15 +201,21 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
> >                                               int mcelsius)
> >  {
> >         struct rcar_gen3_thermal_priv *priv = tsc->priv;
> > -       int celsius, val;
> > +       const struct equation_set_coef *coef;
> > +       int adj, celsius, thcode;
> >
> >         celsius = DIV_ROUND_CLOSEST(mcelsius, 1000);
> 
> This is pre-existing, but I think it would be good if you could avoid
> this (early) division by 1000.

I agree, I plan to look into that in a follow series. In this series I 
wanted to focus on getting the approximations match what's in the 
data-sheets.

> 
> 
> > -       if (celsius <= INT_FIXPT(priv->tj_t))
> > -               val = celsius * tsc->coef.a1 + tsc->coef.b1;
> > -       else
> > -               val = celsius * tsc->coef.a2 + tsc->coef.b2;
> > +       if (celsius < priv->tj_t) {
> > +               coef = &tsc->coef.below;
> > +               adj = priv->info->adj_below;
> > +               thcode = tsc->thcode[2];
> > +       } else {
> > +               coef = &tsc->coef.above;
> > +               adj = priv->info->adj_above;
> > +               thcode = tsc->thcode[0];
> > +       }
> >
> > -       return INT_FIXPT(val);
> > +       return thcode - DIV_ROUND_CLOSEST((celsius - adj) * coef->b, coef->a);
> >  }
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Kind Regards,
Niklas Söderlund

