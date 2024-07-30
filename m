Return-Path: <linux-pm+bounces-11658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D981940FC7
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 12:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B1D2802BA
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 10:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9B19F495;
	Tue, 30 Jul 2024 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="RNYzcpct";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lfIpJC0E"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1DA19E7E4;
	Tue, 30 Jul 2024 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335861; cv=none; b=o1kPes+P1+ZcgzDV4uLzaNQ8NrJe0+r3GW79I4gkh22IrgF0mCFgBBJ1vuwLskCaUyNPJANKWzXZH54j+XY0y6uTssfL6DV4657UH6T3PF8XF/jx4BstW5yBfOpkT3pmbEk4NzdVWmTqt8IbsxG4jPdb0ZlL/myjmBnQOGri6ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335861; c=relaxed/simple;
	bh=7bhmWJ4F4fCA4+A84l6x7aUr8sGx8nmnSiTTUK2/c6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ua8IxBRDvEJjJoCEukvMCa0wy0NxIqIsLr70MIYAaGKgbdJuzv6Vi5oNTxO5TNSCF4uVjlZwuFXCgIohjgP2K+dYubFV4IgqF8T9W2dRG1N6QQF7MVh/tSvq2CSv1vf2HIwUQ/2jkx8MvMzpf4cQ7s7KTvEUiWOfmuU9i9LutQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=RNYzcpct; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lfIpJC0E; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 936FC13806A6;
	Tue, 30 Jul 2024 06:37:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 30 Jul 2024 06:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722335854;
	 x=1722422254; bh=VX/Tkdcy9ImXaRgVm/RQ9iSM0HkWsMXF2m6jBPYecV8=; b=
	RNYzcpctswcndh6F8lRrEqri9PmkFhm/Q2Rl4RRIuqNJmo6Emx256ztgkbAXWOmk
	/kxt+x1fAJCKXEzGTFx6Giw5Pvw8bulIZxQc9Y8bPq1C2rO592kde/P+7uoNpNMB
	LKA3WtKEgf3U9AEDMOBG6JRUwC4EqWGgQe8rG3XPzCbnbB9k4RZzjyqa/SoIgj2n
	AeV8Ezs8ONqpgLcUUFtH2/nJrCDMHlPweQoK2LN8OuSSWChI+ujyVaV0Q1G7R+FZ
	7q3lnMUtfp+roDnz1nj6aVXT9/IIlTC84cwZrXErXFny2F9wxG+WnvfDknuTlptT
	/kwre63qyWcTQkrwA8giPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722335854; x=
	1722422254; bh=VX/Tkdcy9ImXaRgVm/RQ9iSM0HkWsMXF2m6jBPYecV8=; b=l
	fIpJC0EejGnJsumzLRqCCINacradXLkA5W+fE6aLiNE3RIUbA08zYqMj1bobOW6W
	WzMph3hFJi3iF+qLkmOR1HjwFQrzUuaO5hbrWfEukSSbukqmipwxLrSczfA26WjA
	d0Ik0mAb3/2E1zhjLfoIwCnlXQy+Aq46xIZhuHWcpR5PHtBr7spEveBRSzm4lnsu
	V0JyB8y9DEL9GU2TTtFzvisYc0tOWKHeGcPylbCJNcXNdKDhPIlvfHccmXLvyJsz
	V1+BUaxJFX62wVnTfO2c4VlR6XAK3KytIBMcC+i7kTv47LiGmMDzW4myql19pRzn
	zTXOppnPJVHpgbF9Pyobw==
X-ME-Sender: <xms:bsKoZhEm0eo8D2zhR7XdEbaoceA4YpcsRtXVzqNaFO7-ziQbxQJmww>
    <xme:bsKoZmWX4gDLIdJWG5YYhOQ4gGEeNVGQFaZYy8ccceg3VOfYeXE8e8Hgo9Fd35F3u
    _Q8Vz_NBUlexE-vcZg>
X-ME-Received: <xmr:bsKoZjKM-xJcazB2zIo7VaF5MH-lXA2cpwabb1kgTBdU6CGT9ENRtPAvv4NJpqOHCJ2LTHQL_Jk1p04GDEggacFaoa22YNU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheppfhikhhl
    rghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlhhunhgusehrrghgnh
    grthgvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepffdtgeefveefgfeutdevveelgfel
    keeuvdefgefgfeehfeeijeehudelhfejkefgnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehn
    ihhklhgrshdrshhouggvrhhluhhnugesrhgrghhnrghtvggthhdrshgvpdhnsggprhgtph
    htthhopedt
X-ME-Proxy: <xmx:bsKoZnEJC_T05Om-Qz_rHkvlurA5A7Ya147pXIerz1Bec1xbVK2N4g>
    <xmx:bsKoZnVPnsFoRefjRoZ9t5WPUhYXxieN9C0q0E9VKJZWFs7lCnF_aA>
    <xmx:bsKoZiOPjeI1K07R-AYdRafN0Qy1Kco0brNXn80iXAIvQGQwAEEeGg>
    <xmx:bsKoZm31wGWNK6X1cpI1XRIh-rOZzXyVit9Te7-F7idAyaDX830-Iw>
    <xmx:bsKoZpIxiIzsx34oFlaTCViP6t2TKo58rsBYG55lYvzaZi8Xr_2klUph>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 06:37:33 -0400 (EDT)
Date: Tue, 30 Jul 2024 12:37:32 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 7/8] thermal: trip: Get rid of
 thermal_zone_get_num_trips()
Message-ID: <20240730103732.GC4118426@ragnatech.se>
References: <2211925.irdbgypaU6@rjwysocki.net>
 <2636988.Lt9SDvczpP@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2636988.Lt9SDvczpP@rjwysocki.net>

Hi Rafael,

Thanks for your work.

On 2024-07-29 18:11:29 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The only existing caller of thermal_zone_get_num_trips(), which is
> rcar_gen3_thermal_probe(), uses this function to put the number of
> trip points into a kernel log message, but this information is also
> available from the thermal sysfs interface.
> 
> For this reason, remove the thermal_zone_get_num_trips() call from
> rcar_gen3_thermal_probe() and drop the former altogether.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> 
> A new version, based on the discussion following the v1:
> 
> https://lore.kernel.org/linux-pm/20240617183949.GO382677@ragnatech.se/
> 
> The Renesas driver change does not depend on the previous patches
> in the series.
> 
> ---
>  drivers/thermal/renesas/rcar_gen3_thermal.c |    6 +-----
>  drivers/thermal/thermal_trip.c              |    6 ------
>  include/linux/thermal.h                     |    1 -
>  3 files changed, 1 insertion(+), 12 deletions(-)
> 
> Index: linux-pm/drivers/thermal/renesas/rcar_gen3_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ linux-pm/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -563,11 +563,7 @@ static int rcar_gen3_thermal_probe(struc
>  		if (ret)
>  			goto error_unregister;
>  
> -		ret = thermal_zone_get_num_trips(tsc->zone);
> -		if (ret < 0)
> -			goto error_unregister;
> -
> -		dev_info(dev, "Sensor %u: Loaded %d trip points\n", i, ret);
> +		dev_info(dev, "Sensor %u: Loaded\n", i);
>  	}
>  
>  	if (!priv->num_tscs) {
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -55,12 +55,6 @@ int thermal_zone_for_each_trip(struct th
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_for_each_trip);
>  
> -int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
> -{
> -	return tz->num_trips;
> -}
> -EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
> -
>  /**
>   * thermal_zone_set_trips - Computes the next trip points for the driver
>   * @tz: a pointer to a thermal zone device structure
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -210,7 +210,6 @@ int for_each_thermal_trip(struct thermal
>  int thermal_zone_for_each_trip(struct thermal_zone_device *tz,
>  			       int (*cb)(struct thermal_trip *, void *),
>  			       void *data);
> -int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
>  void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
>  				struct thermal_trip *trip, int temp);
>  
> 
> 
> 

-- 
Kind Regards,
Niklas Söderlund

