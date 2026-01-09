Return-Path: <linux-pm+bounces-40538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2659CD0A63F
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 14:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C8913016222
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC4535BDCC;
	Fri,  9 Jan 2026 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Js9LxSzO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F70835B137;
	Fri,  9 Jan 2026 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964514; cv=none; b=eKNEzL67CMWEetkSLWZwrAbS5j8AJlCWzOCCXuzyMGBUeeJC36Y0/RkUx33UK07QcYW9m9Ys4kPp0GukR7SF8Rfvhsnya69Qk35Eh6/MIAVuHxzTal9VUdyMuur6lP7ROhyVbO2w2GxNdn7DE6MNCJE9wJMMKKp42/ik5njo3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964514; c=relaxed/simple;
	bh=MJStCIZmQ7PngNhFtsuW1zFBiSqzPLcTWAfWV/VvXr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfaKgNAicGji1cS2f4ayTlxFHYg4m2B3sz1PXM8AgrZhetxqQTzr89lGOEFiKiW4XiAbnyXFaWwdbz7SQIQstO+zrHYYsb9+jMNmwVw45PTx14yJ8vEGzcPTLckVUDV/peJod5yTmjkbKAyRztifnSelBU69r2WrLZI5E9SHVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Js9LxSzO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767964512; x=1799500512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MJStCIZmQ7PngNhFtsuW1zFBiSqzPLcTWAfWV/VvXr8=;
  b=Js9LxSzOVhNCBDHPHcWElKq58eXEipE7+RWlMqInLDK/9LlXgVKm4hPB
   tqzom4AF0BRFNFgWGPBGkp35JgMrNjAm49m2nf0761Rtf/iRhbe4TNg5Z
   Ock+p3mLowhVGxQLycmMbv0afzFm4Sf2gWpBWSAX8zlZt8tOAB3gCbPsC
   4P22oypY0e2T53RU1LQ/cLzZQK7W8GsxU2EUVrMikCBuKUXu4urEuXl9/
   FEaBlt1EcQ5UPmOm3yWK8d6CtxLoyqrrXBC93t1/e33Kw/Htp+ojprAoX
   C+Vw5twXo/GPYgVTE/0N1nnr19bBAysAZXOEenodbqw9GpWgxsC+jNIIv
   g==;
X-CSE-ConnectionGUID: ymK+dPm3RACeICPKSPQ2YQ==
X-CSE-MsgGUID: heJOkgSIT+WPcpO52eAxMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="71920545"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="71920545"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 05:15:11 -0800
X-CSE-ConnectionGUID: 08MobHMCRUqmHqgXvw+L8g==
X-CSE-MsgGUID: Yah7IGNCQyidLxn0wPz3gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="203384669"
Received: from khuang2-desk.gar.corp.intel.com (HELO kuha) ([10.124.223.90])
  by fmviesa006.fm.intel.com with SMTP; 09 Jan 2026 05:15:05 -0800
Received: by kuha (sSMTP sendmail emulation); Fri, 09 Jan 2026 15:14:44 +0200
Date: Fri, 9 Jan 2026 15:14:44 +0200
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
Subject: Re: [PATCH v3 5/5] usb: typec: tcpm/tcpci_maxim: deprecate WAR for
 setting charger mode
Message-ID: <aWD_RIPp1ULH9St1@kuha>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
 <20251227-max77759-charger-v3-5-54e664f5ca92@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-max77759-charger-v3-5-54e664f5ca92@google.com>

Hi,

> +	if (source) {
> +		if (!regulator_is_enabled(chip->vbus_reg))
> +			ret = regulator_enable(chip->vbus_reg);
> +	} else {
> +		if (regulator_is_enabled(chip->vbus_reg))
> +			ret = regulator_disable(chip->vbus_reg);
> +	}

It looks like you have to do one more round, so can drop the
regulator_is_enabled() checks and just always enable/disable it
unconditionally.

        if (source)
		ret = regulator_enable(chip->vbus_reg);
	else
		ret = regulator_disable(chip->vbus_reg);

I don't think you need the check in any case, but if I've understood
this correctly, you should not use that check when the regulator does
not support that check because then the API claims it's always
enabled. So I guess in that case "if (!regulator_is_enabled())" may
not work as expected, and you may actually be left with a disabled
regulator. This may not be a problem on current platforms, but who
knows what happens in the future.

thanks,

-- 
heikki

