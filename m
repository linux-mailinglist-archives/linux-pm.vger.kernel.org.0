Return-Path: <linux-pm+bounces-24217-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E5AA65BA8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 18:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6BA189CAB4
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735CD1B3939;
	Mon, 17 Mar 2025 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="J4ir1V1N"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0041A38E3;
	Mon, 17 Mar 2025 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234254; cv=none; b=A8LMEgV4Ary0zuDelB8XdP+bf7B/gin/naM1z5jVBS19Vx5QORnvcaBCt7XzpocHKPmUc9cJkLy0SulQRpqxE9+1cdFB8npSDi2jpKNHmDATfLLHayixexMvKRkfC0ZuYqL6PJaH3wDOf+09vYGa9YHauvTxhmVhCrfXm/7mI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234254; c=relaxed/simple;
	bh=hm3dL6UzDDNSHp2i5TtwBJQefX+U5wxitjITfilfjXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJvQFOTrkQn7GVSKjNhEQOcCL7SEMpQ9o1AZhk45P6SdWNwEmffR1cldiyZ6DmOvVWs1gZoKBPhhAk6U8m99L4cTIG4DYMzppvZlV7yXLnzf0m2Jta0uKwJYNzOwMEIpHQXt5cX4lRiwDTcAwNVwqFpRI/Mc926QY8bGYb4vfDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=J4ir1V1N; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742234250;
	bh=hm3dL6UzDDNSHp2i5TtwBJQefX+U5wxitjITfilfjXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4ir1V1NC7bKT/TXMOdVWcSlztZvfONlx8GPt+iaLCJ5GzYtUZpr5MpI57L5P9YE+
	 Ahyz8deS6jTDApHEJ4uQPA5XX56GuDEtGnSNQIzMo33EAzlwDLlSryl22j8rJvRnGu
	 3drWqSsymgR1Zq0zqewAqVRxImy2a9doud9hppwg=
Date: Mon, 17 Mar 2025 18:57:29 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Joaquin Ignacio Aramendia <samsagax@gmail.com>, Derek J Clark <derekjohn.clark@gmail.com>, 
	Kevin Greenberg <kdgreenberg234@protonmail.com>, Joshua Tam <csinaction@pm.me>, 
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org, 
	sre@kernel.org
Subject: Re: [PATCH v5 12/13] power: supply: add inhibit-charge-awake to
 charge_behaviour
Message-ID: <141a8bee-cc2c-4e46-86ed-60fde4beb5b3@t-8ch.de>
References: <20250317155349.1236188-1-lkml@antheas.dev>
 <20250317155349.1236188-13-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317155349.1236188-13-lkml@antheas.dev>

On 2025-03-17 16:53:48+0100, Antheas Kapenekakis wrote:
> OneXPlayer devices have a charge inhibit feature
> that allows the user to select between it being
> active always or only when the device is on.
> 
> Therefore, add attribute inhibit-charge-awake to
> charge_behaviour to allow the user to select
> that charge should be paused only when the device
> is awake.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 11 ++++++-----
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  drivers/power/supply/test_power.c           |  1 +
>  include/linux/power_supply.h                |  1 +
>  4 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 2a5c1a09a28f9..78afb2422fc5a 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -508,11 +508,12 @@ Description:
>  		Access: Read, Write
>  
>  		Valid values:
> -			================ ====================================
> -			auto:            Charge normally, respect thresholds
> -			inhibit-charge:  Do not charge while AC is attached
> -			force-discharge: Force discharge while AC is attached
> -			================ ====================================
> +			===================== ========================================
> +			auto:                 Charge normally, respect thresholds
> +			inhibit-charge:       Do not charge while AC is attached
> +			inhibit-charge-awake: inhibit-charge only when device is awake
> +			force-discharge:      Force discharge while AC is attached
> +			===================== ========================================
>  
>  What:		/sys/class/power_supply/<supply_name>/technology
>  Date:		May 2007
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index edb058c19c9c4..8d036faf220ec 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -140,6 +140,7 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
>  static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = {
>  	[POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO]		= "auto",
>  	[POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE]	= "inhibit-charge",
> +	[POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE]	= "inhibit-charge-awake",
>  	[POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE]	= "force-discharge",

Please keep the alignment.

>  };

<snip>

