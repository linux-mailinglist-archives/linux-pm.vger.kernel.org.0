Return-Path: <linux-pm+bounces-27627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81301AC33D0
	for <lists+linux-pm@lfdr.de>; Sun, 25 May 2025 12:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EE43A48AE
	for <lists+linux-pm@lfdr.de>; Sun, 25 May 2025 10:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5F01EF0B0;
	Sun, 25 May 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="VkZ5059r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PLO3eXAa"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FEC17BED0;
	Sun, 25 May 2025 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748168399; cv=none; b=SQRSm3fZbbgtSHYOTvhHrX/OmV8oPQIgtN1gErSSjiX9oeB01r7BDx+BKE+4bVNaDc4UFZijwagYYjBcVSr42Nq5ENY+T2vlmOhuxD8ciT2luoEF3KWz4Ftd0JPvWdMUMdispR34kJZeOIom4YWecSEH1c1CVWM/boKTG7eTuhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748168399; c=relaxed/simple;
	bh=1kgNPA7E50ptAHDPhxFZ5JjcvPGjCbICdrnubM0rl0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaS2jzBr+p2mgtj4zIEMMtE9LvInC0ycrBtfKfMEWoVq18GcXRHN9OxkdLnhsEyKM5socFZFroXf5fO3g8QWdA/sfgkeJXbZrMYTx3J+oPn2+uW4X2CceAhBXrvU/6itaFNDLlV/oB1uu63SEzUYE/QR4GcY/mG1SJEusNSBw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=VkZ5059r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PLO3eXAa; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5C6431380186;
	Sun, 25 May 2025 06:19:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 25 May 2025 06:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748168395;
	 x=1748254795; bh=Nde2SkTDak5t7cCJKYp/aSUwJXpBCopTUS04DjQZk70=; b=
	VkZ5059rjCC9tiBPqn7yu4+dDulqLrtNHPnj4JyYGRCy86WYJFp/+EtIUTQ9K4b9
	1kaUtqRdQ4MxsIlDX6K6UqeZLVmR6U4X/Q63n3aOne3AuO+BSn5xbk7V8QqtUDzy
	Gt7almcJrT7PJrtKNqbteTIDSwwOFex2xjXGFnFMmrUi70qFnPSWw3YDhs5zNAwV
	JM5kCLWQoPy9RHImp9mXWQqJxVirCLN/mm6lEzrjJQdF71XF0S9mw5Fd3bR23EwZ
	eU8LQNF2X3xnAI9NjvSUutSIGIZjZoeqz/mLxLlNjR1kCe0yhSzB+IZONvsJA3I9
	oqgb6UddBuRc1OxQ1lhAOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748168395; x=
	1748254795; bh=Nde2SkTDak5t7cCJKYp/aSUwJXpBCopTUS04DjQZk70=; b=P
	LO3eXAaO+KaHnZS4qXMn3JmsoC72DXJTNsjvQxCpwCs7d0E2QeVW1hga+nkCCe64
	alLwkz1ZPJx4ESMp20Dyq51x5D58eVS+ZmQa7P9qrsQHXcs0kwPK6qDDFGbig5PQ
	vBj84OYKCAPjcywwgzr7jQ2OebeJNZvnGsO8C4N68nNjtPwy0pwS1mfFS+KSxI/S
	Zvnh/gwcx0/m3jy0M85JSlGM4oB4ha8A0qJBMSPzwY/dlN+2zWvSHn9+Q5XPRisN
	xz1klJOm1/zD3QLJ+Hbyj3u+XaVWn1kbYpcON3HpXvzbOHkR73vNCm3UeHnOa83E
	k5tMmYtiupoOHInIQPYdA==
X-ME-Sender: <xms:ye4yaAV0TmhvVuGmh2lKBch3mhFzsDsvVn-Ob3Zg6RfuLWFUchVs8Q>
    <xme:ye4yaEkANnjrD3288fsi1tfIDUZttXEZLcIwa9AC5v9iRwixplqUuhy_3PU-ZakYS
    VeQGb9TTjf8WPEEaMY>
X-ME-Received: <xmr:ye4yaEYN7DuTNeem48U6ut8zhp7S5kXVNOLPGssh9iKDyPY8MDOsGgunKxEGIrd7GKj8C4BLwT6FYkGMKoSgT_GH4Hym6I2fUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddugeefheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomheppfhikhhlrghsucfunpguvghrlhhunh
    guuceonhhikhhlrghsrdhsohguvghrlhhunhgusehrrghgnhgrthgvtghhrdhsvgeqnecu
    ggftrfgrthhtvghrnhepveetgedtvddvhfdtkeeghfeffeehteehkeekgeefjeduieduue
    elgedtheekkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepnhhikhhlrghsrdhsohguvghrlhhunhgusehrrghgnhgrthgvtghhrdhsvgdpnh
    gspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhr
    ihhsthhophhhvgdrjhgrihhllhgvthesfigrnhgrughoohdrfhhrpdhrtghpthhtohepmh
    hiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrrghf
    rggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnh
    hosehlihhnrghrohdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghl
    rdgtohhmpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtph
    htthhopehsuhhpphhorhhtrdhophgvnhhsohhurhgtvgesughirghsvghmihdrtghomhdp
    rhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    drhhgruhgvrhesphgvnhhguhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:ye4yaPX22cycY_RFWzhzoxjcLJrjG4QrfTChm_xl0MKRIEeCd035Gg>
    <xmx:ye4yaKkIzmgXp1wVQU0I_bHFWgLxyGjqh4JbrqOxtXB_2Iz6zYNn2A>
    <xmx:ye4yaEciNMYD8G4p0mjheCagaA3JRG8oL0rCb2PmaptDexJ3yaGw9w>
    <xmx:ye4yaMHzD9nlu_4ri7v8sXYvzYlewq6Jh3loJ7MlOCW2BM4blWnVEw>
    <xmx:y-4yaDYNJCUmwsiSrtv-F_DKn-_S-icPF9YHu5FmKZP_k1EdWq75roPt>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 May 2025 06:19:53 -0400 (EDT)
Date: Sun, 25 May 2025 12:19:50 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] thermal: Constify struct thermal_zone_device_ops
Message-ID: <20250525101950.GE600042@ragnatech.se>
References: <5bba3bf0139e2418b306a0f9a2f1f81ef49e88a6.1748165978.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bba3bf0139e2418b306a0f9a2f1f81ef49e88a6.1748165978.git.christophe.jaillet@wanadoo.fr>

Hi Christophe,

Thanks for your work.

On 2025-05-25 11:40:04 +0200, Christophe JAILLET wrote:
> 'struct thermal_zone_device_ops' are not modified in these drivers.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   28116	   5168	    128	  33412	   8284	drivers/thermal/armada_thermal.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   28244	   5040	    128	  33412	   8284	drivers/thermal/armada_thermal.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  drivers/thermal/armada_thermal.c                        | 2 +-
>  drivers/thermal/da9062-thermal.c                        | 2 +-
>  drivers/thermal/dove_thermal.c                          | 2 +-
>  drivers/thermal/imx_thermal.c                           | 2 +-
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
>  drivers/thermal/kirkwood_thermal.c                      | 2 +-
>  drivers/thermal/mediatek/lvts_thermal.c                 | 2 +-
>  drivers/thermal/renesas/rcar_thermal.c                  | 2 +-

For R-Car,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

>  drivers/thermal/spear_thermal.c                         | 2 +-
>  drivers/thermal/st/st_thermal.c                         | 2 +-
>  drivers/thermal/testing/zone.c                          | 2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 9bff21068721..c2fbdb534f61 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -408,7 +408,7 @@ static int armada_get_temp_legacy(struct thermal_zone_device *thermal,
>  	return ret;
>  }
>  
> -static struct thermal_zone_device_ops legacy_ops = {
> +static const struct thermal_zone_device_ops legacy_ops = {
>  	.get_temp = armada_get_temp_legacy,
>  };
>  
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
> index 2077e85ef5ca..a8d4b766ba21 100644
> --- a/drivers/thermal/da9062-thermal.c
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -137,7 +137,7 @@ static int da9062_thermal_get_temp(struct thermal_zone_device *z,
>  	return 0;
>  }
>  
> -static struct thermal_zone_device_ops da9062_thermal_ops = {
> +static const struct thermal_zone_device_ops da9062_thermal_ops = {
>  	.get_temp	= da9062_thermal_get_temp,
>  };
>  
> diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
> index f9157a47156b..723bc72f0626 100644
> --- a/drivers/thermal/dove_thermal.c
> +++ b/drivers/thermal/dove_thermal.c
> @@ -106,7 +106,7 @@ static int dove_get_temp(struct thermal_zone_device *thermal,
>  	return 0;
>  }
>  
> -static struct thermal_zone_device_ops ops = {
> +static const struct thermal_zone_device_ops ops = {
>  	.get_temp = dove_get_temp,
>  };
>  
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index bab52e6b3b15..38c993d1bcb3 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -361,7 +361,7 @@ static bool imx_should_bind(struct thermal_zone_device *tz,
>  	return trip->type == THERMAL_TRIP_PASSIVE;
>  }
>  
> -static struct thermal_zone_device_ops imx_tz_ops = {
> +static const struct thermal_zone_device_ops imx_tz_ops = {
>  	.should_bind = imx_should_bind,
>  	.get_temp = imx_get_temp,
>  	.change_mode = imx_change_mode,
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 0e07693ecf59..5736638c586b 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -515,7 +515,7 @@ static int int3400_thermal_change_mode(struct thermal_zone_device *thermal,
>  	return result;
>  }
>  
> -static struct thermal_zone_device_ops int3400_thermal_ops = {
> +static const struct thermal_zone_device_ops int3400_thermal_ops = {
>  	.get_temp = int3400_thermal_get_temp,
>  	.change_mode = int3400_thermal_change_mode,
>  };
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
> index 7c2265231668..4619e090f756 100644
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -48,7 +48,7 @@ static int kirkwood_get_temp(struct thermal_zone_device *thermal,
>  	return 0;
>  }
>  
> -static struct thermal_zone_device_ops ops = {
> +static const struct thermal_zone_device_ops ops = {
>  	.get_temp = kirkwood_get_temp,
>  };
>  
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 985925147ac0..acce8fde2cba 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -571,7 +571,7 @@ static irqreturn_t lvts_irq_handler(int irq, void *data)
>  	return iret;
>  }
>  
> -static struct thermal_zone_device_ops lvts_ops = {
> +static const struct thermal_zone_device_ops lvts_ops = {
>  	.get_temp = lvts_get_temp,
>  	.set_trips = lvts_set_trips,
>  };
> diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
> index 00a66ee0a5b0..fdd7afdc4ff6 100644
> --- a/drivers/thermal/renesas/rcar_thermal.c
> +++ b/drivers/thermal/renesas/rcar_thermal.c
> @@ -277,7 +277,7 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
>  	return rcar_thermal_get_current_temp(priv, temp);
>  }
>  
> -static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
> +static const struct thermal_zone_device_ops rcar_thermal_zone_ops = {
>  	.get_temp	= rcar_thermal_get_temp,
>  };
>  
> diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
> index bb96be947521..603dadcd3df5 100644
> --- a/drivers/thermal/spear_thermal.c
> +++ b/drivers/thermal/spear_thermal.c
> @@ -41,7 +41,7 @@ static inline int thermal_get_temp(struct thermal_zone_device *thermal,
>  	return 0;
>  }
>  
> -static struct thermal_zone_device_ops ops = {
> +static const struct thermal_zone_device_ops ops = {
>  	.get_temp = thermal_get_temp,
>  };
>  
> diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
> index a14a37d54698..1470ca519def 100644
> --- a/drivers/thermal/st/st_thermal.c
> +++ b/drivers/thermal/st/st_thermal.c
> @@ -132,7 +132,7 @@ static int st_thermal_get_temp(struct thermal_zone_device *th, int *temperature)
>  	return 0;
>  }
>  
> -static struct thermal_zone_device_ops st_tz_ops = {
> +static const struct thermal_zone_device_ops st_tz_ops = {
>  	.get_temp	= st_thermal_get_temp,
>  };
>  
> diff --git a/drivers/thermal/testing/zone.c b/drivers/thermal/testing/zone.c
> index 1f4e450100e2..4257d813d572 100644
> --- a/drivers/thermal/testing/zone.c
> +++ b/drivers/thermal/testing/zone.c
> @@ -381,7 +381,7 @@ static int tt_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>  	return 0;
>  }
>  
> -static struct thermal_zone_device_ops tt_zone_ops = {
> +static const struct thermal_zone_device_ops tt_zone_ops = {
>  	.get_temp = tt_zone_get_temp,
>  };
>  
> -- 
> 2.49.0
> 

-- 
Kind Regards,
Niklas Söderlund

