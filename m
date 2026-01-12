Return-Path: <linux-pm+bounces-40662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E8AD12BAE
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 14:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDAD93009138
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 13:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF13D358D19;
	Mon, 12 Jan 2026 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mT87Ntba"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B692D9784;
	Mon, 12 Jan 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224084; cv=none; b=qN9gzv/6j4FxR9Obcf8ooylkUjIcpU+9n2Js3j63IoROJ+5tCLx4aE3at0wMPVF9HjRhNQPtXIH+YlDo/21Gz6XA30jql1hxMh04UtL56rUsz0AESGXmHJIUU4TQ5A1Tz6k1u2c0gwvHb/uJ8x0zlGyEdK41L4BjtF5c0AstSC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224084; c=relaxed/simple;
	bh=dYBaoZSy4sn/OXpQRGQxS/cy6FPFm3kwjKBIX2vR0+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o34Qxi+ljJS2JkCuIZJtEPVaNoA5ehSEHmbTr2r+QLhJNqSTzA7FMHD744oAygSKlICm6vJnH/YFlrhLugdZTrmILOMdQGk7QZq47Qq7ssFmjqZ2XojtSQmKCLRCxSG7HZ4hx3E3XF+vsmts8BnKQpMANJQ0XeFpIpMtWSRV6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mT87Ntba; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768224083; x=1799760083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dYBaoZSy4sn/OXpQRGQxS/cy6FPFm3kwjKBIX2vR0+g=;
  b=mT87Ntba4af/Sg2XviDOa0YCXK0IhSd0f0aH6DWQ0whFleJE1mwy5J06
   AXamFz58/LhaAQPw1SelUvDcLiNkY8nqAH9nfIuwsIKLXZgCHs/VqABKG
   UXPn0afe0DxjNSjfXfyztkjk57nxQnv8W9wFrb0RIjNycz/vOAT2LW+DK
   HDEDT70p46WpS5gY6zDG4X/UZAgcLotSFhq/jZtpWVb+TCRSqAfmqaHfE
   E+gyGU1hBjwmdRCICBk2tybILR6e1T9lurUcB+WeUN7mf7L3NGYNaHYp2
   Mxlf9UL9xDDdeyi8g0Ln4DhwSGp9s3GrFkB8fRQE0JRCI3SrVYP0BAIZ/
   w==;
X-CSE-ConnectionGUID: dVFKc87wTIeoirPjjmibhA==
X-CSE-MsgGUID: 1Q4vr0AaS6aViPR64y7+Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="68501058"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="68501058"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 05:21:23 -0800
X-CSE-ConnectionGUID: 56w8+M7ZTsuqAhpz10IJ5A==
X-CSE-MsgGUID: O7xf8PsOSzaiQQK5gKXM4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="209164543"
Received: from jjgreens-desk21.amr.corp.intel.com (HELO kuha) ([10.124.223.232])
  by orviesa005.jf.intel.com with SMTP; 12 Jan 2026 05:21:16 -0800
Received: by kuha (sSMTP sendmail emulation); Mon, 12 Jan 2026 15:20:54 +0200
Date: Mon, 12 Jan 2026 15:20:54 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Amit Sunil Dhamne <amitsd@google.com>
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
Message-ID: <aWT1NgxDSaU7LL2g@kuha>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
 <20251227-max77759-charger-v3-5-54e664f5ca92@google.com>
 <aWD_RIPp1ULH9St1@kuha>
 <9f94993e-dd69-4c9e-b467-aad6031c83d4@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f94993e-dd69-4c9e-b467-aad6031c83d4@google.com>

Fri, Jan 09, 2026 at 06:16:57PM -0800, Amit Sunil Dhamne kirjoitti:
> Hi Heikki,
> 
> Thanks for the review!
> 
> On 1/9/26 5:14 AM, Heikki Krogerus wrote:
> > Hi,
> >
> >> +	if (source) {
> >> +		if (!regulator_is_enabled(chip->vbus_reg))
> >> +			ret = regulator_enable(chip->vbus_reg);
> >> +	} else {
> >> +		if (regulator_is_enabled(chip->vbus_reg))
> >> +			ret = regulator_disable(chip->vbus_reg);
> >> +	}
> > It looks like you have to do one more round, so can drop the
> > regulator_is_enabled() checks and just always enable/disable it
> > unconditionally.
> >
> >         if (source)
> > 		ret = regulator_enable(chip->vbus_reg);
> > 	else
> > 		ret = regulator_disable(chip->vbus_reg);
> 
> The regulator framework uses refcounting on the number of enables. If
> the number of times regulator is disabled > enabled, a warning will be
> thrown. Also, I don't want to call regulator_enable more than once for
> the same refcounting reason (will have to call disable those many number
> of times to actually disable).
> 
> > I don't think you need the check in any case, but if I've understood
> > this correctly, you should not use that check when the regulator does
> > not support that check because then the API claims it's always
> > enabled. So I guess in that case "if (!regulator_is_enabled())" may
> > not work as expected, and you may actually be left with a disabled
> > regulator. This may not be a problem on current platforms, but who
> > knows what happens in the future.
> 
> I don't think this should be an issue in the future as this driver is
> specifically meant for max77759_tcpci device and should only be used
> with max77759 charger (they both exist only in the same package). And
> that the max77759_charger driver does implement the callback. However,
> if you think that regulator_is_enabled() is unreliable, I could track
> the state within the tcpci driver instead of calling
> regulator_is_enabled() and call enable/disable regulator accordingly.
> 
> Let me know wdyt and I'll update the next revision accordingly.

Let's go with this then as is.

thanks,

-- 
heikki

