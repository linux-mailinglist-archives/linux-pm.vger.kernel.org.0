Return-Path: <linux-pm+bounces-9379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C9590B9DD
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA08C287989
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE889196DA4;
	Mon, 17 Jun 2024 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="WsUkHiWR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XxA5TMWQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786A1194C6B;
	Mon, 17 Jun 2024 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649598; cv=none; b=DaZ3f2HT9rrY5MEPo5LdTNHSff3UtbmuPgHA8qH0T1j99k1NOUiWClNhVBxS7ACv8wJsH30TEFm9qyhxrSCjBG5Mmno+3cyhrWKGOUBoVaqFmYbub+xLupj53QrXisYMpToiVMaInGIm/LZwDN9vefwcvOLJvUs+JKcapJkJ/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649598; c=relaxed/simple;
	bh=50YbFiyyun7jhliGlj7MoCG7c7HVccDzNWYjG3f0AHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSvmDsJPfvGtSAFa8USuG/6z++V7AqrDvbtIOPcasf85icT0b6MnHbKGKrda7rLBg8ic6eiR6wjCi1dXQbWtCax6y1jNyKFP04+k/1lPFjVn3DPC4TFQWwRMPiv326gt63izt8Sh/paBNmTSe+ypDQlb4M8AEmah1zKs5C6zVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=WsUkHiWR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XxA5TMWQ; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id EBD9B1C00069;
	Mon, 17 Jun 2024 14:39:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 17 Jun 2024 14:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1718649592;
	 x=1718735992; bh=xWSRl1XwcoZve5FJ1LHB/z+FtpOFW6+RKHWNhLNvaNE=; b=
	WsUkHiWRD+ULhSlo8Qop/N7fUpXDvjQiaVuL8sF9xs7e4T/vh7ilpmBfjmDM51wB
	H3OzDVuUkrafgR1W4H9jcvgwsScCDzyMCyYgC4gQRzt39g9HSqwY9Uksf7wQEAqv
	pyPBCFvm21XEWwBxAkhHIqApbkybweZMP4v6Epel8EvkLeE7d/LfrDIKlBh7rvev
	dsI5oiy/ubmHtx+ukExJMby7pyOPpTpZ31MSSBvrvzGDh/wP44r+XmV3+CUSYWRE
	FtM7hTZktAXftdEeRD4EChnqYtX2rEjT2TuBM6CGEmai9Rntl6WKq5A4yY/CZZLR
	yfA+EsaA4hoY93weVFZl3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718649592; x=
	1718735992; bh=xWSRl1XwcoZve5FJ1LHB/z+FtpOFW6+RKHWNhLNvaNE=; b=X
	xA5TMWQROPrJyc8aXrl64LEVTUSvh/XfTBNZWGcWmkYq8N6IN9jKhZ1Z5VW7taTk
	S+vz0XHJLDjo3IsC38WVSfQwulkv8Fl1TcMZKkxPAtjqP1KHPEIO3N9YES4vmPUa
	YGe4/+bk8TN1sttMz0MN2xfQve9vlOQHZcdvZ3j2JAMZ3RL822Eyi6FccxPvBgVq
	UofU83Shxxjyu0dUY6uTFyTdsg/5o8lRqP8PjBw4igZopLENGICh+M9CmfdJU3Cj
	KFFunYFATyERlP0Z9f26wwHqByoNaIl6Hcayy0znCjgsdLZZPGiv35RsVcBQMkAG
	0t6h74nvOmV1zM7oa5O4Q==
X-ME-Sender: <xms:-IJwZsMGW5t8Bq4rzUwo-1qNL1h68v9jx-RFzIYVqZpgqZ4zXmT_pw>
    <xme:-IJwZi8vj4u5AS99wklXWRQ4j8f0pjSznNJ8kuC0SP1UWosCgyB06LoXUiZUKbTp_
    1dwssgrtldo9tUxzWY>
X-ME-Received: <xmr:-IJwZjSpD0l_o5i8xO_4vIre2xdoqtSkxys8iMFQTHe-ol758QnXcYmdwQSvKQs3Mxv9DOVc_EBhSSoQ08mNAon18-8jBWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheppfhi
    khhlrghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlhhunhguodhrvg
    hnvghsrghssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepfefhleel
    hfffjefgfedugfegjeelhfevheeikefhueelgfdtfeeuhefftddvleeinecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhsohgu
    vghrlhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvg
X-ME-Proxy: <xmx:-IJwZksvg4bGwsxdoQaykYyZyaCNAvgdg8en5tGb0PmWCh8rt8f_iw>
    <xmx:-IJwZkdJwAG3gpDUs0VO_63JDUFnMi3Vj40DSSvDtEm21qo6-U78ew>
    <xmx:-IJwZo2ZDyFN8UtXh8T0OEeJyjNHDVeglXLiRGp_P775AitonhAe3w>
    <xmx:-IJwZo-gMl5y6GIu-HbykIBr2O1qj46oxaQWR1PNxXKN9aATWgUPDg>
    <xmx:-IJwZivjboGzh_NJSdBYxoFk4vjQnSb3EzHrWiKVZj54lZbjAZfiOXpj>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 14:39:51 -0400 (EDT)
Date: Mon, 17 Jun 2024 20:39:49 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 13/14] thermal: trip: Replace
 thermal_zone_get_num_trips()
Message-ID: <20240617183949.GO382677@ragnatech.se>
References: <8409966.T7Z3S40VBb@kreacher>
 <3312460.oiGErgHkdL@kreacher>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3312460.oiGErgHkdL@kreacher>

Hi Rafael,

Thanks for your patch.

On 2024-06-17 20:11:30 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The only existing caller of thermal_zone_get_num_trips(), which is
> rcar_gen3_thermal_probe(), uses this function to check whether or
> not the number of trips in the given thermal zone is nonzero.
> 
> Because it really only needs to know whether or not the given
> thermal zone is tripless, replace thermal_zone_get_num_trips() with
> thermal_zone_is_tripless() that can tell rcar_gen3_thermal_probe()
> exactly what it needs to know and make it call that function.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/thermal/renesas/rcar_gen3_thermal.c |    3 +--
>  drivers/thermal/thermal_trip.c              |    6 +++---
>  include/linux/thermal.h                     |    2 +-
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/thermal/renesas/rcar_gen3_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ linux-pm/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -563,8 +563,7 @@ static int rcar_gen3_thermal_probe(struc
>  		if (ret)
>  			goto error_unregister;
>  
> -		ret = thermal_zone_get_num_trips(tsc->zone);
> -		if (ret < 0)
> +		if (thermal_zone_is_tripless(tsc->zone))

There are two issues with this change.

1. The original code only jumped to error_unregister if there where a 
   negative number of trip points, presumably to allow for an error to 
   be returned when reading the number of trip points.

   If an negative error was found it was stored in ret, and this was 
   then returned from the probe function after jumping to 
   error_unregister. This change jumps to the error out path, but do not 
   fail probe.

   However it is valid to complete probe without any trip points found.  
   So failing probe on thermal_zone_is_tripless() is not desired.

2. The value returned from thermal_zone_get_num_trips() and stored in 
   ret is used in a dev_info() below, logging how many trip points (if 
   any) where found.

   With this change that is no longer true and it will always log 0 trip 
   points found.

As there is no long (if there ever where) a reason to check for errors 
when reading the number of trip points, and no real use to log the 
number of trip points found maybe a modified patch can do what you want 
(not tested).

- ret = thermal_zone_get_num_trips(tsc->zone);
- if (ret < 0)
-    goto error_unregister;
-
- dev_info(dev, "Sensor %u: Loaded %d trip points\n", i, ret);
+ dev_info(dev, "Sensor %u: Loaded %s trip points\n", i,
+       thermal_zone_is_tripless(tsc->zone) ? "with" : "without");

What do you think?

>  			goto error_unregister;
>  
>  		dev_info(dev, "Sensor %u: Loaded %d trip points\n", i, ret);
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -55,11 +55,11 @@ int thermal_zone_for_each_trip(struct th
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_for_each_trip);
>  
> -int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
> +bool thermal_zone_is_tripless(struct thermal_zone_device *tz)
>  {
> -	return tz->num_trips;
> +	return tz->num_trips == 0;
>  }
> -EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
> +EXPORT_SYMBOL_GPL(thermal_zone_is_tripless);
>  
>  /**
>   * thermal_zone_set_trips - Computes the next trip points for the driver
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -210,7 +210,7 @@ int for_each_thermal_trip(struct thermal
>  int thermal_zone_for_each_trip(struct thermal_zone_device *tz,
>  			       int (*cb)(struct thermal_trip *, void *),
>  			       void *data);
> -int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
> +bool thermal_zone_is_tripless(struct thermal_zone_device *tz);
>  void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
>  				struct thermal_trip *trip, int temp);
>  
> 
> 
> 

-- 
Kind Regards,
Niklas Söderlund

