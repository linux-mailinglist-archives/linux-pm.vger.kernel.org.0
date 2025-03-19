Return-Path: <linux-pm+bounces-24281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A130BA68E4D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 14:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC3542338C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756481531E3;
	Wed, 19 Mar 2025 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDliM1mY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448BD1EF1D;
	Wed, 19 Mar 2025 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392465; cv=none; b=FMSCm8MZqejA4E90eTumRAYvHr9aRG3wsmNq7Mdg0zjtZHM7nB4iRArhtdF648yXUStveQEXccFdPnfAb9eLTFOxeJ27rYQPIJVTaiMcv/iQozZH7LWzkF3Q8MZw0B5MhM7LQd1F30HuInjgDE6R3KGWdhhZ4rYDeYAhdNpGUV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392465; c=relaxed/simple;
	bh=bcifr8S4Mb7kY/ExELY32tHcrvskcaRdRJ9ODW1TKuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r32ZnW34wi+k6gXmigDAsSlI9Ha8t94vCJFynP5mxomBoZc7vn17i+5xSe0hJczNNI+adYC/zgtaHgUo4u3t+AFfN/YoSiyKZJQWqLmIEU/0KE64u0kZh+SKQJBal+BAcAvwv3b0hOhX7rNzGw3f744HZN3C/4tWFCfj3jDy9Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDliM1mY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742392464; x=1773928464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bcifr8S4Mb7kY/ExELY32tHcrvskcaRdRJ9ODW1TKuA=;
  b=LDliM1mYBVQKUGPbjmuD7nrWJvtlzc8/w5VQPVf1g4F9KoPbEuqcJfDe
   d0mXoJAEkgpDALN0Rt8qx09y5Rtoas74DlrY+UmHesch42jikxd8l5ApK
   3YG3SXY5B0P0CpAelhm0mYDZlGoTfpmNRDnUJKJu5siWATmHyFwat3u9I
   RbFXsKp7byU0KomlQqAUxfgGWuiEV+AyGet1x2Ls//+1A/WETziN9fIzT
   vCPP9v7OCMpf/zTQBTUh30+kzuiwbK4us2gxpMu8/43mbC9Zze0FrmsJd
   nOAuJJM0rcFgG2+U1jdsBqZHuphXXkoFB0CgVkEx24Z6I89FrWmkjYgkQ
   Q==;
X-CSE-ConnectionGUID: jFQ2uXK7RYqiZ3vbTEJSwA==
X-CSE-MsgGUID: JdUnqBDUSe28JuTLG+dHag==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="42754394"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="42754394"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 06:54:23 -0700
X-CSE-ConnectionGUID: h3mmb4ItRlmBb7GMIaTZ5g==
X-CSE-MsgGUID: TYOhSRNEQ6ifJfCeT4ys4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127449990"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa003.jf.intel.com with SMTP; 19 Mar 2025 06:54:17 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 19 Mar 2025 15:54:16 +0200
Date: Wed, 19 Mar 2025 15:54:16 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: amitsd@google.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Sebastian Reichel <sre@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH 2/5] power: supply: core: add function to get supplies
 from fwnode
Message-ID: <Z9rMiONSFDJInPYM@kuha.fi.intel.com>
References: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
 <20250312-batt_ops-v1-2-88e0bb3129fd@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312-batt_ops-v1-2-88e0bb3129fd@google.com>

On Wed, Mar 12, 2025 at 04:42:02PM -0700, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Add a new helper function power_supply_get_by_fwnode_reference_array()
> to retrieve a list of power_supplies associated with the fwnode's
> property. The property can contain multiple nodes where each node is
> associated with a power_supply. The list of power_supply objects will be
> stored in an array supplied by the caller and the return value will
> indicate the size of the resulting array.

I don't think this API is necessary. If I've understood what you are
after here, the batteries should simply have the Type-C psy(s) listed
in the supplied_to and/or supplied_from.

So you just need to make sure your battery nodes have the USB Type-C
node(s) listed in the "power-supplies" property in your DT, no?

thanks,

> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  drivers/power/supply/power_supply_core.c | 60 ++++++++++++++++++++++++++++++++
>  include/linux/power_supply.h             |  5 +++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 76c340b38015af0a67a0d91305e6242a8646bf53..df1a52f85125748c4fdcb10687aa7ed2f626ded1 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -593,6 +593,66 @@ struct power_supply *devm_power_supply_get_by_phandle(struct device *dev,
>  EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
>  #endif /* CONFIG_OF */
>  
> +static int power_supply_match_fwnode(struct device *dev, const void *data)
> +{
> +	return dev && dev->parent && dev->parent->fwnode == data;
> +}
> +
> +/**
> + * power_supply_get_by_fwnode_reference_array() - Returns an array of power
> + * supply objects associated with each fwnode reference present in the property
> + * @fwnode: Pointer to fwnode to lookup property
> + * @property: Name of property holding references
> + * @psy: Resulting array of power_supply pointers. To be provided by the caller.
> + * @size: size of power_supply pointer array.
> + *
> + * If power supply was found, it increases reference count for the
> + * internal power supply's device. The user should power_supply_put()
> + * after usage.
> + *
> + * Return: On success returns the number of power supply objects filled
> + * in the @psy array.
> + * -EOVERFLOW when size of @psy array is not suffice.
> + * -EINVAL when @psy is NULL or @size is 0.
> + * -ENODATA when fwnode does not contain the given property
> + */
> +int power_supply_get_by_fwnode_reference_array(struct fwnode_handle *fwnode,
> +					       const char *property,
> +					       struct power_supply **psy,
> +					       ssize_t size)
> +{
> +	int ret, index, count = 0;
> +	struct fwnode_reference_args args;
> +	struct device *dev;
> +
> +	if (!psy || !size)
> +		return -EINVAL;
> +
> +	for (index = 0; index < size &&
> +	     !(ret = fwnode_property_get_reference_args(fwnode, property, NULL,
> +							0, index, &args));
> +	     ++index) {
> +		dev = class_find_device(&power_supply_class, NULL, args.fwnode,
> +					power_supply_match_fwnode);
> +		fwnode_handle_put(args.fwnode);
> +		if (!dev)
> +			continue;
> +
> +		if (count > size)
> +			return -EOVERFLOW;
> +
> +		psy[count] = dev_get_drvdata(dev);
> +		atomic_inc(&psy[count]->use_cnt);
> +		++count;
> +	}
> +
> +	if (ret != -ENOENT)
> +		return ret;
> +
> +	return index ? count : -ENODATA;
> +}
> +EXPORT_SYMBOL_GPL(power_supply_get_by_fwnode_reference_array);
> +
>  int power_supply_get_battery_info(struct power_supply *psy,
>  				  struct power_supply_battery_info **info_out)
>  {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 6ed53b292162469d7b357734d5589bff18a201d0..3f062607e5cd7c7f04384e34128ae0953e25d981 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -820,6 +820,11 @@ devm_power_supply_get_by_phandle(struct device *dev, const char *property)
>  { return NULL; }
>  #endif /* CONFIG_OF */
>  
> +extern int
> +power_supply_get_by_fwnode_reference_array(struct fwnode_handle *fwnode,
> +					   const char *property,
> +					   struct power_supply **psy,
> +					   ssize_t size);
>  extern const enum power_supply_property power_supply_battery_info_properties[];
>  extern const size_t power_supply_battery_info_properties_size;
>  extern int power_supply_get_battery_info(struct power_supply *psy,
> 
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog
> 

-- 
heikki

