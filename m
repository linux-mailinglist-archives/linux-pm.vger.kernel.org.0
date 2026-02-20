Return-Path: <linux-pm+bounces-42931-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKBTGS89mGkWDwMAu9opvQ
	(envelope-from <linux-pm+bounces-42931-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:53:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B43C61670C9
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33B4A30B8B24
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523AA33F36E;
	Fri, 20 Feb 2026 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoVp4+b3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921C1DE3B7;
	Fri, 20 Feb 2026 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584624; cv=none; b=j4eCe1Xnz8eUOb7WHS621Ng2XocTEbpG4GK4sBa2xYr737S38uP9hi2WcHHisXZKXz04/52dpaVl8JZt5IGx4kTgACfWlWIoaW+9Q9sboPSs4dfj5fU6KxKqHzeLeAa8wIVm8XBvjO5Fwb6p6Rgtj6dC9DuF4FGrYH2qV/TJcCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584624; c=relaxed/simple;
	bh=+UZBJw/BXCNSn9kcbG/zZMo2iDvH8/ZoMIB+O39xZM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWHx9Nd6uWBoTQuUhhek0ALgzoeXzKzH8eNqXGEc550/tN5FPP4pW65yUo5TAo4QAXdldOpycARvhe20j0/SvJPW/B8YS9OlrZgpoi7uZEjdnMQz/fCIEnet9xMQOqEht7LjufTRiDHFqvDXRoFEJ66sSHhUdYkfjjrEbAPCyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EoVp4+b3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771584623; x=1803120623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+UZBJw/BXCNSn9kcbG/zZMo2iDvH8/ZoMIB+O39xZM8=;
  b=EoVp4+b3RYtGw2oXOFVxRk3qaWuMjIvYfwYhib7xLDaKn/WR4eyXfFQv
   af+eRjp+t97yttcuXfafZnIm7qjHDHhdBV5tlNpnHL109pbt39fhtgIXy
   TkBLDc9qrZjjWtmNRDzl/P2+cJrwqHLXKyF3qEzKm+aTo3uxler5xOMOe
   TaNSeg/DLtZUX4Na02OUzUbv9b0nkm5GLMarc3smLkWe1lyOCmtie3G4h
   9suui4yuI8r+BwXLj7KQn8dwnKlhHjcT+VAnhcUBAIa5ExNt4dU1SDAbB
   gzYieiHxrbqkpcDE26Ev4IwCaGUArQLaGQr2YH9LiE2hjUvioMuEl7pdH
   Q==;
X-CSE-ConnectionGUID: eGQjVpJWRzy5arDN0DWavg==
X-CSE-MsgGUID: 4h7vjWSaS0uAeO1/hYNaYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="60251129"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="60251129"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 02:50:22 -0800
X-CSE-ConnectionGUID: SLG868wDSgSsOv3FEOMpsw==
X-CSE-MsgGUID: izd9q49QRYWVWpK0SfUvGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="212602197"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 02:50:16 -0800
Date: Fri, 20 Feb 2026 12:50:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Jens Reidel <adrian@mainlining.org>,
	Casey Connolly <casey.connolly@linaro.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] thermal/drivers/generic-adc: Allow probe without
 TZ registration
Message-ID: <aZg8ZqckhGbvkdel@smile.fi.intel.com>
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-3-fe34ed4ea851@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-bat-temp-adc-v2-3-fe34ed4ea851@fairphone.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42931-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,fairphone.com:email]
X-Rspamd-Queue-Id: B43C61670C9
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:19:07AM +0100, Luca Weiss wrote:
> If the devicetree node is not referenced in a zone under /thermal-zones,
> devm_thermal_of_zone_register will fail with -ENODEV.

devm_thermal_of_zone_register()

> Since the driver is now also registering as an IIO device[0], allow the
> probe to continue without the thermal zone.

Isn't it dangerous?

> We also can't use gadc_thermal_get_temp anymore because we haven't

gadc_thermal_get_temp()

> necessarily initialized tz_dev.

> [0] commit 3762f5851ac5 ("thermal/drivers/thermal-generic-adc: Add temperature sensor channel")

You can make it a Link tag:

Link: https://git.kernel.org/torvalds/c/3762f5851ac5 [0]

> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

...

>  	if (IS_ERR(gti->tz_dev)) {
>  		ret = PTR_ERR(gti->tz_dev);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev,
> -				"Thermal zone sensor register failed: %d\n",
> -				ret);
> -		return ret;
> -	}
> +		if (ret == -EPROBE_DEFER)
> +			return ret;

I believe it's better to return all possible errors. If you see the
similarities with regulator APIs, then use an explicit check for -ENODEV.

> -	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
> +		dev_info(dev, "Thermal zone sensor register failed: %d\n",
> +			 ret);
> +	} else {
> +		devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
> +	}

-- 
With Best Regards,
Andy Shevchenko



