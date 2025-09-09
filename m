Return-Path: <linux-pm+bounces-34280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992F4B50016
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD854E61C5
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0376343202;
	Tue,  9 Sep 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="EfoNbGvP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FIiXFy0g"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF523BCE3;
	Tue,  9 Sep 2025 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429521; cv=none; b=hOF5Z8S8vVR73127tku7NwWtIGy/p6Nbf96W806qtxaQuzZ9gqlCv1NJZmw0yUoLgOeiuXnvw3oxVnJcFmg21/Boz8++Qsu+X7a8xFN2Z+B5Q5Djzoaw/u06DFibUpZimJb1XuDknq0SaSKqR3LqJBsf35lffPOMvaG+ZkcSAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429521; c=relaxed/simple;
	bh=VSWtHhpYiRI7KRbr1AOvxnvKl403J0EHlv8PkQ36aCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGRdu59jvU4tJkAcnYI1bIMJXVIG8DPm988JdJPVw7iKJRF3E+AnbepuLU8uIcshQbfo1vJaBuTEQnWubUbBJ4043h3xPBS+AAEMo9FLDu1gLpUISj+QgKMdUqYjQEmhK2/dVyJWpW0y9eTHaYsbK70uxP8dtRy9IVEe5QaOP28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=EfoNbGvP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FIiXFy0g; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD9C67A00E4;
	Tue,  9 Sep 2025 10:51:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 09 Sep 2025 10:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757429518;
	 x=1757515918; bh=qd4aWT3KSKSenhrdAb14lzOfOHuewsf8lMSsp6ZrfWU=; b=
	EfoNbGvPFo4JPcqkvVWBX59/e1KDMAVklKOycjjO1B++2T7Ak6u7USoC2hiGryRc
	fPBvEOUzJ/sPSNkZC1IMCc+XUOc5axZUmbID62lYm08dZcpb2hh1QeqSodaGAFbt
	MYpMnkDXjoOhPIBt/LSRXRj5n6ppIsM0DgLnmMcYbIO4DMPrm0jLngQzgdslMfFI
	ajEWXQTHOJHYHDCZytEyf9VyWu3HLR9U8ti/16bP96YBeb7UIxb2lP1MAsbBzQKN
	4CRXDdxavC2HJx8hAqMYelkZAAcNWT8kJa5Uc1xGOILU9e7YvAxsufLMe5nKo2kk
	57Z5CRwKJxRaIIctSJhPKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757429518; x=
	1757515918; bh=qd4aWT3KSKSenhrdAb14lzOfOHuewsf8lMSsp6ZrfWU=; b=F
	IiXFy0gBcNnm3eAUZKOoY7lZPxtydFfzeCo0KelYIy54MGKX8GTMgkcPzFAcC/0B
	PDKALRLRi9WeEcDh8rS6RoZDCh70c0N5llwWmbsFTu24KB9jvsAN9WtCCLTyWVyg
	AYgkU+XOMEsg0MLxE//14FcJLxca7iQ/2b9HT70bDVXzSGqZ7mogCau2hJCG7jAU
	szo8uro2KBGNJ4CE2SL6aJSemEmB7Qr1lGPTN2RLcYhX8xdeJbQZSaw+D+mmRq5p
	8jIv42OHbNCF7A/UNAVqJz+leOEiOwzvK6zGtd/w9RUZLiamJwT+sHRssYbZvo9l
	7Fmwrnf1RM/M5jPqcVGWA==
X-ME-Sender: <xms:Dj_AaMRHZuOPIG2qIQW9g9riQ4y_RouKVP7K8McJWEsDlOA1H5mfzA>
    <xme:Dj_AaHJ-1DMFMbknb4khQsv__5Gw_oEb9JNmHGCIm-qx-9xR8bcgSGza7xs6ZTwMQ
    jesF9xSu0IIijZfMBc>
X-ME-Received: <xmr:Dj_AaBK6LkFU5SyTigP9JJdJOV1wNYaPUy8wAM1P-swY9Nk7SvgzjEarkhs-Opv8GoH0N_ZtFUwcbzIEBhLHuvqN1NNPSeLgOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheppfhikhhlrghs
    ucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlhhunhgusehrrghgnhgrth
    gvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepveetgedtvddvhfdtkeeghfeffeehteeh
    keekgeefjeduieduueelgedtheekkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhsohguvghrlhhunhgusehrrghgnhgr
    thgvtghhrdhsvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopeifshgrodhrvghnvghsrghssehsrghnghdqvghnghhinhgvvghrihhnghdr
    tghomhdprhgtphhtthhopehlihhnuhigqdhrvghnvghsrghsqdhsohgtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhgvkhdrvhgrshhuthesghhmrghilhdr
    tghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehr
    uhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhukhgrshiirdhluh
    gsrgesrghrmhdrtghomhdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhi
    uggvrhdrsggvpdhrtghpthhtohepmhgrghhnuhhsrdgurghmmhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Dj_AaKjOaXSYmFm1BWeG-zn9fpOnVbdsZ1ONekjaicu4CQ9tuxJRiA>
    <xmx:Dj_AaDP-CZanfhOfHwyqhR7CJa-dWsbg1764hAfKkKMZdpUFd8dUFw>
    <xmx:Dj_AaNrPIfcMNzpCQR5R3qXeEJY2as3VDfdBCAVEI0oYUduyMZ0upA>
    <xmx:Dj_AaN7hk6UqFsfPmJqK1ernp8RM7X2O4o6_t9JwB9zsB6ifo5FSFg>
    <xmx:Dj_AaC3Kf0PPSjDZ1-Sf-y78udGzyY7K4IB7pMO7KHzf0mOHgCDHMJKz>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 10:51:57 -0400 (EDT)
Date: Tue, 9 Sep 2025 16:51:56 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] thermal/drivers/rcar_gen3: use approved default
 values
Message-ID: <20250909145156.GB3476608@ragnatech.se>
References: <20250909084618.23082-4-wsa+renesas@sang-engineering.com>
 <20250909084618.23082-6-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250909084618.23082-6-wsa+renesas@sang-engineering.com>

Hi Wolfram,

Thanks for your work.

On 2025-09-09 10:46:20 +0200, Wolfram Sang wrote:
> The current default values for R-Car Gen4 are from a V4H Rev3.0 SoC.
> They seem incomplete because of the same values for all THS instances.
> Also, the bits to flag valid fuses were not set. So, better use the
> values from the Rev2.2 SoC which have the valid flags set.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/thermal/renesas/rcar_gen3_thermal.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
> index 07b53d4f2683..b7026ab733d4 100644
> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -372,12 +372,12 @@ static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_defaul
>  };
>  
>  static const struct rcar_gen3_thermal_fuse_default rcar_gen3_thermal_fuse_default_info_gen4 = {
> -	.ptat = { 3274, 2164, 985 },
> -	.thcodes = { /* All four THS units share the same trimming */
> -		{ 3218, 2617, 1980 },
> -		{ 3218, 2617, 1980 },
> -		{ 3218, 2617, 1980 },
> -		{ 3218, 2617, 1980 },
> +	.ptat = { 3146, 2076, 928 },
> +	.thcodes = {
> +		{ 3092, 2505, 1881 },
> +		{ 2181, 2609, 2001 },

If these values come from the board I think they do, s/2181/3181/ ?

> +		{ 3175, 2587, 1962 },
> +		{ 3163, 2592, 1986 },
>  	}
>  };
>  
> -- 
> 2.47.2
> 

-- 
Kind Regards,
Niklas Söderlund

