Return-Path: <linux-pm+bounces-17791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DEF9D2F76
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 21:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710CA1F23A7B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 20:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE881D5CCD;
	Tue, 19 Nov 2024 20:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="YGlaPcf7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aSDRFLvY"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1EA1D359E;
	Tue, 19 Nov 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048256; cv=none; b=eorwivCbnlfLVTY49H5EenLgURISZjXgbke5Qu6BzQhvLMg0kuJlWIH2zorzemSbJ2R21rD4hLIXoDOyha+kPU8fUAR2j8J+4dH9yC07gTq1g+PFyTvST9KHYO+oEeeBcfm7k9VCA/qZTNx5p/LVEApyNxn4sU4abSB+OUuOAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048256; c=relaxed/simple;
	bh=56ArrsIDQV4Mcl9L7IRi7dVYZAeRnuAyV4eq90yHuNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcaeOQAkR/ztqlrz6IEuqTKhXcHsPuSGHju15tFexhaj+FF3dPoZwRTtgqHqdsAHSQZ3ZXZNFermyDTlwgKDlSwznC06J02zET0IKRWNIREtGoIETdDKo5GKWNzwLYhZM8ZqukjkzEwDHGSKS6SG+iudvV7aj7/Evhak2u7DQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=YGlaPcf7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aSDRFLvY; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id DF390138075F;
	Tue, 19 Nov 2024 15:30:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 19 Nov 2024 15:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732048251;
	 x=1732134651; bh=7+eJYpd6GRbgJjpSCYGLsGStpmlpnCcU8XzwnJegeJM=; b=
	YGlaPcf7aEARn0feYng7f0geZm+xcu28wAVVZ3NIZeFt+Nmwi7d8b6HXA9wYBUQy
	Xg9UZuLS1QtRGFuHMQbm6VQCATOH0FvuXOiBEb1o3cDmxOn8cArnSu+TMa7V/Y7Q
	pgEoBo2uozsswGVHrx0i0+/EvNrX6Aq3O5ZZY8mhieW1iFFWrU/PQMDp6DpxWfv0
	kzgC8Upjn+vCHdxULJqgktngqUFnMVd6r8PTrJAG8zDUaI09vPQm1nU1+TSZVTmd
	HsDMXtwxZprYIQN0PgiX8aZQkSZjjb9hW4O4bErOr57/KDZrJz+MlLxOF6s8BG7y
	SgFUu3xe0BKnCuGdQ0KrXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732048251; x=
	1732134651; bh=7+eJYpd6GRbgJjpSCYGLsGStpmlpnCcU8XzwnJegeJM=; b=a
	SDRFLvYvTtgTORgtQgKdM4xqxUm9Zr3ehppm8ljJLviEqKWRfJT4lTyMOvmFW8Aa
	ttpjZamyFyh2flnJnkSKp/stBoBqoKkhFMLp7AvppAtNiV0xuw3wxPz+gwt4hPCi
	lH9H3pisADc1RFMWE+IfK9vWR4jsfEf7I8ymiW5Rg54StnzUN2i0/ww3I+t0FDZ2
	3/PtfStL/U0aTbRUevfBm+TfmMBaVfiXjV4U9X42Ct8Mcza2rIrVp6Vwhgj9BySE
	tAG6M4XA/5b3Un13nA+K7TxvaNcoGKGm46ROQ4Ng7VFSZB303FN3M4gDoDhCupF5
	WBhp8xXDYhsFIXgfi7SMQ==
X-ME-Sender: <xms:e_U8Z2_LHy6tvzx0UonpTcBOcFJ-SHxkDHmoNO9xuYwvmVWBjeyUZg>
    <xme:e_U8Z2t0mUgPk-Xo8HKRK-PFJTgQP1eZ5oyMLPiGjRwLG8cAUzEICcuEEwOrRvu5Y
    Ft6Hv2ZUsKlQeEv3mg>
X-ME-Received: <xmr:e_U8Z8AL89uVDKL8sxnoIerQq8uKKR-bdVIu6hOqJSGF_W-000uoIXjC2BWXL0WSZ8kAkxAmC0raRRc07p6I3L6rbOabxOcKJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefpihhklhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhoug
    gvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrght
    thgvrhhnpeefhfellefhffejgfefudfggeejlefhveehieekhfeulefgtdefueehffdtvd
    elieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehn
    ihhklhgrshdrshhouggvrhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrsh
    gvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehg
    vggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehrrghfrggvlheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhn
    rghrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpd
    hrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhrvghnvghsrghsqdhsohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:e_U8Z-fs7Zw1PJveQCyFjc9-Bg2dXNkpoql3H_0gIRBT7EnlNimtBQ>
    <xmx:e_U8Z7MsXYcNBg9sYZ6REXv_cjJ1eC_llibEA31Q1npVapVRCGR8DA>
    <xmx:e_U8Z4l2v0g4tyWbaUaKFhNrba-I3TJ59dcScZSed52CRJY0JQIzrQ>
    <xmx:e_U8Z9sf7oRdr9Uz_xVJz0Svuim-0QHoFuXfUZk11E3IqkbvS93Jmw>
    <xmx:e_U8Z2fvxHTrgOmLfAePS0-czLd8eAQpkOuJvqelBkHDrVwwk2ML65-7>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 15:30:51 -0500 (EST)
Date: Tue, 19 Nov 2024 21:30:49 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: rcar_gen3: Use lowercase hex constants
Message-ID: <20241119203049.GN5315@ragnatech.se>
References: <20241116172934.1829676-1-niklas.soderlund+renesas@ragnatech.se>
 <20241116172934.1829676-2-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdXvvD9+2=GvH+AtZUvKx2dhMEtR3e5oXQBF8FgBOVL7eQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXvvD9+2=GvH+AtZUvKx2dhMEtR3e5oXQBF8FgBOVL7eQ@mail.gmail.com>

Hi Geert,

On 2024-11-18 11:30:17 +0100, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> On Sat, Nov 16, 2024 at 6:30 PM Niklas Söderlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
> > The style of the driver is to use lowercase hex constants, correct the
> > few outlines.
> >
> > Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Thanks for your patch!
> 
> > --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> > +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> > @@ -57,11 +57,11 @@
> >  /* THSCP bits */
> >  #define THSCP_COR_PARA_VLD     (BIT(15) | BIT(14))
> >
> > -#define CTEMP_MASK     0xFFF
> > +#define CTEMP_MASK     0xfff
> >
> >  #define MCELSIUS(temp) ((temp) * 1000)
> > -#define GEN3_FUSE_MASK 0xFFF
> > -#define GEN4_FUSE_MASK 0xFFF
> > +#define GEN3_FUSE_MASK 0xfff
> > +#define GEN4_FUSE_MASK 0xfff
> >
> >  #define TSC_MAX_NUM    5
> 
> LGTM, but you missed a few:
> 
> $ git grep "\<0x.*[A-Z]" -- drivers/thermal/renesas/rcar_gen3_thermal.c
> drivers/thermal/renesas/rcar_gen3_thermal.c:#define REG_GEN3_IRQCTL
>          0x0C
> drivers/thermal/renesas/rcar_gen3_thermal.c:#define REG_GEN3_IRQTEMP3   0x1C
> drivers/thermal/renesas/rcar_gen3_thermal.c:#define REG_GEN4_THSFMON15  0x1BC
> drivers/thermal/renesas/rcar_gen3_thermal.c:#define REG_GEN4_THSFMON16  0x1C0
> drivers/thermal/renesas/rcar_gen3_thermal.c:#define REG_GEN4_THSFMON17  0x1C4

d00h, I just checked manually for things around the fuses, will fix.

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

