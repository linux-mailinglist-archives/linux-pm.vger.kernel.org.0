Return-Path: <linux-pm+bounces-23822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273E5A5B9CD
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 08:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0528D7A2F4B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 07:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87601EF388;
	Tue, 11 Mar 2025 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSQkougT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3B1EB195;
	Tue, 11 Mar 2025 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678246; cv=none; b=shcwUtpMsyoQJFZeEsGjBs8HheZtcUP72iP7mrqxlJzcNR0J5xV9W50dnp7X7zW7wybJW3SRltHbU3ByDsvrHjGaFNy3fNVNFXaVgLDL2de0MTRRDqxe3PNmVFwBUkmawcJG/zXUrbKgxys/0Ho04/1+BzZCILWWNlkWASAn8w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678246; c=relaxed/simple;
	bh=NoGVWw/otYogFtApnw5uHgZvKY5tV6lPTEjKZTBVYFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJVRnpNn8/u5Ki4et1yP57LcXDbXKsrrKs8OVssHDjv/e15HrYI2fxLK6UoBeRyHd0ooRjqGhsccrAGSJWdV0vqmD0rv+cpvlI5y9FuPhOgDSm2tzFZjoHBVk8MHXtkVciojOfTC3mBLhXGwJXy0OEAq/S6YEerK6a0/dTtxjcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSQkougT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F0CC4CEEA;
	Tue, 11 Mar 2025 07:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741678246;
	bh=NoGVWw/otYogFtApnw5uHgZvKY5tV6lPTEjKZTBVYFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fSQkougTsnyi5bU35qR+Zjtp9lL5mxbBhPLwMqg9ZVL3fKgHKGjqYj6oEPJoB465n
	 vZKMh79KEuAAS5jeNNQI/2oBY//zWBEjMzQ3fiF116bvdykjmLoJh8+BpbX+66MkDD
	 CAIfue5cFidcpc9dsDeahZY6L2H7baNZOAAOGdbOdCfDavMOUfSzOSw5DEIQXb44T3
	 taNehDowiVrFLS6ZZ/dyfuOBiQgZLv1hnHEO/k9bNs9eVZc6ym8riTP6S0WdHERx/h
	 Isr4ijGTjQ/azjRCSfZmJwux09Ht8rz0DF2RdHzut6x2siueXY951eHCuR6DUA82hm
	 HIsi2XUFxTwxQ==
Message-ID: <424c0acd-61c4-40d9-b39d-f3b6dce2b3f8@kernel.org>
Date: Tue, 11 Mar 2025 08:30:37 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] thermal/cpuplog_cooling: Add CPU hotplug cooling
 driver
To: John Madieu <john.madieu.xa@bp.renesas.com>, geert+renesas@glider.be,
 niklas.soderlund+renesas@ragnatech.se, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org
Cc: magnus.damm@gmail.com, claudiu.beznea.uj@bp.renesas.com,
 devicetree@vger.kernel.org, john.madieu@gmail.com, rui.zhang@intel.com,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 biju.das.jz@bp.renesas.com, linux-pm@vger.kernel.org
References: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
 <20250309121324.29633-2-john.madieu.xa@bp.renesas.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250309121324.29633-2-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/03/2025 13:13, John Madieu wrote:
> +
> +/* Check if a trip point is of type "plug" */
> +static bool is_plug_trip_point(struct device_node *trip_node)
> +{
> +	const char *trip_type_str;
> +
> +	if (!trip_node) {
> +		pr_err("Trip node is NULL\n");
> +		return false;
> +	}
> +
> +	if (of_property_read_string(trip_node, "type", &trip_type_str)) {
> +		pr_err("Trip node missing 'type' property\n");
> +		return false;
> +	}
> +
> +	pr_info("Trip type: '%s'\n", trip_type_str);
> +
> +	if (strcmp(trip_type_str, "plug") != 0) {

type is object, not string. Where is ABI documented? For the type and
its value?


> +		pr_debug("Trip type is '%s', not 'plug' - skipping\n",
> +			 trip_type_str);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/* Init function */
> +static int __init cpu_hotplug_cooling_init(void)
> +{
> +	struct device_node *thermal_zones, *thermal_zone;
> +	int ret = 0;
> +	int count = 0;
> +
> +	bitmap_zero(cpu_cooling_registered, NR_CPUS);
> +
> +	thermal_zones = of_find_node_by_name(NULL, "thermal-zones");
> +	if (!thermal_zones) {
> +		pr_err("Missing thermal-zones node\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Process each thermal zone */
> +	for_each_child_of_node(thermal_zones, thermal_zone) {
> +		struct device_node *trips, *trip;
> +		struct device_node *maps, *map;
> +		bool found_plug = false;
> +
> +		/* First find trips and get a specific plug trip */
> +		trips = of_find_node_by_name(thermal_zone, "trips");
> +		if (!trips)
> +			continue;
> +
> +		/* Find the emergency trip with type="plug" */
> +		for_each_child_of_node(trips, trip) {
> +			if (is_plug_trip_point(trip)) {
> +				found_plug = true;
> +				break;
> +			}
> +		}
> +
> +		/* If we didn't find a plug trip, no need to process this zone */
> +		if (!found_plug) {
> +			of_node_put(trips);
> +			continue;
> +		}
> +
> +		maps = of_find_node_by_name(thermal_zone, "cooling-maps");
> +		if (!maps) {
> +			of_node_put(trip);
> +			of_node_put(trips);
> +			continue;
> +		}
> +
> +		pr_info("Found 'plug' trip point, processing cooling devices\n");

dev_info, or just drop. You are not supposed to print successes of
standard DT parsing.

> +
> +		/* Find the specific cooling map that references our plug trip */
> +		for_each_child_of_node(maps, map) {
> +			struct device_node *trip_ref;
> +			struct of_phandle_args cooling_spec;
> +			int idx = 0;
> +
> +			trip_ref = of_parse_phandle(map, "trip", 0);
> +			if (!trip_ref || trip_ref != trip) {
> +				if (trip_ref)
> +					of_node_put(trip_ref);
> +				continue;
> +			}
> +			of_node_put(trip_ref);
> +
> +			if (!of_find_property(map, "cooling-device", NULL)) {
> +				pr_err("Missing cooling-device property\n");
> +				continue;
> +			}
> +
> +			/* Iterate through all cooling-device entries */
> +			while (of_parse_phandle_with_args(
> +				       map, "cooling-device",
> +				       "#cooling-cells", idx++,
> +				       &cooling_spec) == 0) {
> +				struct device_node *cpu_node = cooling_spec.np;
> +				int cpu;
> +
> +				if (!cpu_node) {
> +					pr_err("CPU node at index %d is NULL\n",
> +					       idx - 1);
> +					continue;
> +				}
> +
> +				cpu = of_cpu_node_to_id(cpu_node);
> +				if (cpu < 0) {
> +					pr_err("Failed to map CPU node %pOF to logical ID\n",
> +					       cpu_node);
> +					of_node_put(cpu_node);
> +					continue;
> +				}
> +
> +				if (cpu >= num_possible_cpus()) {
> +					pr_err("Invalid CPU ID %d (max %d)\n",
> +					       cpu, num_possible_cpus() - 1);
> +					of_node_put(cpu_node);
> +					continue;
> +				}
> +
> +				pr_info("Processing cooling device for CPU%d\n", cpu);
> +				ret = register_cpu_hotplug_cooling(cpu_node, cpu);
> +				if (ret == 0)
> +					count++;
> +
> +				of_node_put(cpu_node);
> +			}
> +			break; /* Only process the first map that references our trip */
> +		}
> +		of_node_put(maps);
> +		of_node_put(trip);
> +		of_node_put(trips);
> +	}
> +	of_node_put(thermal_zones);
> +
> +	if (count == 0) {
> +		pr_err("No cooling devices registered\n");
> +		return -ENODEV;
> +	}
> +
> +	pr_info("CPU hotplug cooling driver initialized with %d devices\n", count);

Drop. Why would you print this on MIPS machine which does not care about
it, just because someone loaded a module?

> +	return 0;
> +}
> +
> +/* Exit function */
> +static void __exit cpu_hotplug_cooling_exit(void)
> +{
> +	cleanup_cooling_devices();
> +	pr_info("CPU hotplug cooling driver removed\n");

No, drop


> +}
> +
> +module_init(cpu_hotplug_cooling_init);
> +module_exit(cpu_hotplug_cooling_exit);
> +
> +MODULE_AUTHOR("John Madieu <john.madieu.xa@bp.renesas.com>");
> +MODULE_DESCRIPTION("CPU Hotplug Thermal Cooling Device");
> +MODULE_LICENSE("GPL");
> \ No newline at end of file

Warning here

> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 0eb92d57a1e2..41655af1e419 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -28,6 +28,7 @@ static const char * const trip_types[] = {
>  	[THERMAL_TRIP_ACTIVE]	= "active",
>  	[THERMAL_TRIP_PASSIVE]	= "passive",
>  	[THERMAL_TRIP_HOT]	= "hot",
> +	[THERMAL_TRIP_PLUG]	= "plug",
>  	[THERMAL_TRIP_CRITICAL]	= "critical",
>  };
>  
> diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_trace.h
> index df8f4edd6068..c26a3aa7de5f 100644
> --- a/drivers/thermal/thermal_trace.h
> +++ b/drivers/thermal/thermal_trace.h
> @@ -12,6 +12,7 @@
>  #include "thermal_core.h"
>  
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL);
> +TRACE_DEFINE_ENUM(THERMAL_TRIP_PLUG);
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_HOT);
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_PASSIVE);
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
> @@ -19,6 +20,7 @@ TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
>  #define show_tzt_type(type)					\
>  	__print_symbolic(type,					\
>  			 { THERMAL_TRIP_CRITICAL, "CRITICAL"},	\
> +			 { THERMAL_TRIP_PLUG,     "PLUG"},	\
>  			 { THERMAL_TRIP_HOT,      "HOT"},	\
>  			 { THERMAL_TRIP_PASSIVE,  "PASSIVE"},	\
>  			 { THERMAL_TRIP_ACTIVE,   "ACTIVE"})
> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
> index 4b8238468b53..373f6aaaf0da 100644
> --- a/drivers/thermal/thermal_trip.c
> +++ b/drivers/thermal/thermal_trip.c
> @@ -13,6 +13,7 @@ static const char *trip_type_names[] = {
>  	[THERMAL_TRIP_ACTIVE] = "active",
>  	[THERMAL_TRIP_PASSIVE] = "passive",
>  	[THERMAL_TRIP_HOT] = "hot",
> +	[THERMAL_TRIP_PLUG]	= "plug",
>  	[THERMAL_TRIP_CRITICAL] = "critical",
>  };
>  
> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> index 46a2633d33aa..5f76360c6f69 100644
> --- a/include/uapi/linux/thermal.h
> +++ b/include/uapi/linux/thermal.h
> @@ -15,6 +15,7 @@ enum thermal_trip_type {
>  	THERMAL_TRIP_ACTIVE = 0,
>  	THERMAL_TRIP_PASSIVE,
>  	THERMAL_TRIP_HOT,
> +	THERMAL_TRIP_PLUG,
>  	THERMAL_TRIP_CRITICAL,
>  };
>  


Best regards,
Krzysztof

