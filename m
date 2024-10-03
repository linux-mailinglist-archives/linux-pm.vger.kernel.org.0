Return-Path: <linux-pm+bounces-15086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADB098E9C8
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 08:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D9E1F24307
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 06:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FEA53363;
	Thu,  3 Oct 2024 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eocqt0n3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9C182BD;
	Thu,  3 Oct 2024 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938191; cv=none; b=ap4t/gut6KpQg+TnhmRr0SkZvOOJQzNAlRKftvBvgA7eRnAqkQUvoq3P1Gbp/PUEcoJe7Wu9eSGj+aVmy+zr8jnFJrvFmHe+3hdlQHz3k+oe0099UfW3p/NqY+Gpa7juBpew43n61BAUANQeq3Z/cu7dKsfNmGAlFsDm/4SalpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938191; c=relaxed/simple;
	bh=id394XafWKs5+IGxLhe/wjMGXBRD50Tn5M66uNYwUp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNxQDP0r/8gkMTRr2CynYn0fgT/MBhNVdTcfI9eKiuhaO83Ov3GzAwFwF91G/nCm50rX5OAvH6g4LNTQs1/8T8GHyw0ifhzaqMAFWZo5TfJoiVIgAV8XmjaIJbvZjERLE470ZE4qaBSIW85aW3gorN4ZNMvf2mf/OXMQXvgaU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eocqt0n3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BF3C4CEC7;
	Thu,  3 Oct 2024 06:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727938191;
	bh=id394XafWKs5+IGxLhe/wjMGXBRD50Tn5M66uNYwUp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eocqt0n3uAHiEzDzQ9YPQfF+WxHzge1hqa9d1x/xL89W92pAUCOh0KdEEMf8TUnTh
	 vqaEWVI68n3GI9NCTPA7/UbNPlMk82NBxrmgbuUEe4wbjJHkEnRNXVxsWdLuB1Vgyw
	 GOD/VGRXLuGd8eiDSdZPUdUVQptBYuSisC7ivb3E=
Date: Thu, 3 Oct 2024 08:49:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>, Vishal Mahaveer <vishalm@ti.com>,
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: QoS: Export dev_pm_qos_read_value
Message-ID: <2024100336-left-shadily-3321@gregkh>
References: <20241002194446.269775-1-msp@baylibre.com>
 <2024100333-maternity-equity-c7fa@gregkh>
 <tqsrnsvciupbovlalqsnrp5whst2mrpqntjblvymcunpesvake@o3gxa7vik7he>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tqsrnsvciupbovlalqsnrp5whst2mrpqntjblvymcunpesvake@o3gxa7vik7he>

On Thu, Oct 03, 2024 at 08:28:12AM +0200, Markus Schneider-Pargmann wrote:
> On Thu, Oct 03, 2024 at 08:02:04AM GMT, Greg Kroah-Hartman wrote:
> > On Wed, Oct 02, 2024 at 09:44:46PM +0200, Markus Schneider-Pargmann wrote:
> > > Export the function dev_pm_qos_read_value(). Most other functions
> > > mentioned in Documentation/power/pm_qos_interface.rst are already
> > > exported, so export this one as well.
> > > 
> > > This function will be used to read the resume latency in a driver that
> > > can also be compiled as a module.
> > 
> > We don't add exports for no in-kernel users, sorry.  Send this as part
> > of a series that requires it.
> 
> Sorry if this was unclear, it is for an in-kernel driver (ti_sci.c) that
> can be built as a module. When built as a module it can't use this
> function if it is not exported.

So the current kernel build is broken?  If so, please add a "Fixes:" tag
and say this in the changelog.

If not, again, just make it part of the series where it is needed.

thanks,

greg k-h

