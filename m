Return-Path: <linux-pm+bounces-38690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0167C89293
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 11:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD033AD553
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 10:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5B12E284B;
	Wed, 26 Nov 2025 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKAS426d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B9C2874F6;
	Wed, 26 Nov 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764151283; cv=none; b=RA5l7U2/nY0KmR2OU62zSxEUEPXZhhJrVdX18sqRCibDUu0HhreT3W9zj54lb2+sQjRDD8siYAOd5cQ+GVlQjQ/HPya4j0a/A4gwrlrDiI1daEJRvxvofh3glJyj3S5MHUrLdIWbCSOBqmdGkZhdhHpYGMhuZyhFiVe6ek3TlEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764151283; c=relaxed/simple;
	bh=e4cSdFEpo2kqlF5v6+j+zFUBcsT+moYHxEeI0riTT7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adSZVVD8/ULkTgvQDDD+rFbgmgpqNdeex0OVw7mrVlt98WcmloVd5l5CXnRcP+ws7MsSfa4wgjXwNX91HrBcYZTiLDCalQGcyFIMsIA5s1OYlrPgeOLCERxnBLYDocTOlc06Nd2vBESnKiTGTVnOfLe63mre8a5f3TIOX6zB/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKAS426d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764151282; x=1795687282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e4cSdFEpo2kqlF5v6+j+zFUBcsT+moYHxEeI0riTT7Y=;
  b=dKAS426dyEU3rIHWKnzToP4/hSgdEbMdVVDQiFlbFoMWbRyDhcRHagjt
   EktW4sqfgOt4naz168e7auWcG+6Z5bvUWbCQtB7R+7mbI6ZRGiPTLdn/L
   PIADpVRPvxROpP7ZvX2DKEK1hqWS6qs0YlOOxWFfrT0fk8lncdCdMlxYo
   GVMEc2HDPVUnzsS94FUrByR+FVuyO/kwl/8xlROemxQ40C9VE4T068zcv
   AUxMzEKQJddM2XP66JMNOX5Ghz+VISoGbGNwzTeV1L+9Y6EkJ3lyxNkea
   Nk5D5I93vT+y14KEim8bNoCLpPei4DfpINNjEYOQ7Zo3QNF5dEtqfYZsr
   g==;
X-CSE-ConnectionGUID: LiYMwGu4Sxmwq01uArf12A==
X-CSE-MsgGUID: LwcW/V9MQWaR2hh1MB2SbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="76806452"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="76806452"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 02:01:21 -0800
X-CSE-ConnectionGUID: t9JDLjGRT8yGW+fJ5xCWzA==
X-CSE-MsgGUID: JdFY+pn8TA2cP8IiLg/HxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="192916164"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha) ([10.124.223.25])
  by orviesa007.jf.intel.com with SMTP; 26 Nov 2025 02:01:14 -0800
Received: by kuha (sSMTP sendmail emulation); Wed, 26 Nov 2025 12:01:08 +0200
Date: Wed, 26 Nov 2025 12:01:08 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: amitsd@google.com
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH 3/6] dt-bindings: usb: maxim,max33359: Add supply
 property for VBUS in OTG mode
Message-ID: <aSbP5OanDUGhEXXV@kuha>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
 <20251123-max77759-charger-v1-3-6b2e4b8f7f54@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-max77759-charger-v1-3-6b2e4b8f7f54@google.com>

Sun, Nov 23, 2025 at 08:35:50AM +0000, Amit Sunil Dhamne via B4 Relay kirjoitti:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Add a regulator supply property for VBUS when usb is in OTG mode.

What is "OTG mode"?

OTG is usually used to refer to the USB in device role, even though the
specification actually defines OTG device as a device capable of both
host and device roles. So the term was confusing already before.
Nevertheless, the emphasis is always on data-role, _not_ power-role.

Here it seems MAX33359 uses the term OTG as a synonym for "source", so
power-role?

Please don't use the term OTG unless you really have to - it's too
confusing. I know the MAX33359 datasheet uses it, but what you really
do here is regulate VBUS. So please:

        s/otg-vbus/vbus/

thanks,

> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> index 3de4dc40b791..a529f18c4918 100644
> --- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> +++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> @@ -32,6 +32,9 @@ properties:
>      description:
>        Properties for usb c connector.
>  
> +  otg-vbus-supply:
> +    description: Regulator to control OTG VBUS supply.
> +
>  required:
>    - compatible
>    - reg
> @@ -53,6 +56,7 @@ examples:
>              reg = <0x25>;
>              interrupt-parent = <&gpa8>;
>              interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> +            otg-vbus-supply = <&otg_vbus_reg>;
>  
>              connector {
>                  compatible = "usb-c-connector";
> 
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
> 

-- 
heikki

