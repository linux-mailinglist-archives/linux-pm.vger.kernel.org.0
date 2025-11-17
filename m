Return-Path: <linux-pm+bounces-38141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE15C66221
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 21:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 09D1E296C7
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 20:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E383314B9;
	Mon, 17 Nov 2025 20:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJRaTK9Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114CA328B51;
	Mon, 17 Nov 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763412213; cv=none; b=GbCglUzA/iHW3wW4G5v+OJQyHlMoccgxt0rK2nVaJ//Yo80pm6lSSN7oqgshq+YRKpNQF+vaIMyG5q4XFKQw5+GhYJJRMeVHBGNLUm2ZzOFUzn0S2ELrNKXgP+PU5o4SXqUgTyXBMQuq7w/cZdyFvPO0HEdWvLcX50jOcsw1s4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763412213; c=relaxed/simple;
	bh=U4tr+lgT7dhe7PqRFZFHjgf6eAkQ3fpbvo3Kb5hMZJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvfZGr11WNkaeMwGODQBA8cxYXr0kOFO6hwV2McydZ6hBVIzMOavA41c+nMDxpZMFzgEoOaUGQlzzyjxC+t4EnGCyNe07R4bS+Oj+3rIYKZDteAvCfx1j2JqafeJT2SXFxRHJpoJFOapJRbY7ymnRa1ksbXvdSYa9DyLeSgYVrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJRaTK9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C8DC19424;
	Mon, 17 Nov 2025 20:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763412212;
	bh=U4tr+lgT7dhe7PqRFZFHjgf6eAkQ3fpbvo3Kb5hMZJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJRaTK9QV9U+WKid6C7DPyH2eOzCTVGSTyT0aTrGqhXwTKe1Nq2hW4FUWbQ0U8p3J
	 NLuOhAhPxN+d9DjEyfDjKjk6t6JtPCsqLA0Q9JVbU5nKiuZM0SvXHPZOnM6eIL0WlX
	 D4MDwbciEULgy+JJO2cdJ5ZJt/EPrQZHHWDoIOcvo/PXFlVzqIvE6vDpaYbfwhCKBN
	 ZfOJEfzUJWIzxmztkjLuFgYuTeF54HoClpQGQJdwJsR2NlSxe0Ba8ylEZL7L3DH246
	 cYtLQVyvLupsWaX47f+FvE+os2bsT3MzQpzSDOSz37iMgAUUixSDb6Cct2tgeSPBdd
	 2YBAC4hfcuofw==
Date: Mon, 17 Nov 2025 14:48:15 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>, 
	Sebastian Reichel <sre@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/2] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Message-ID: <virjbkkpdmufx2midadzwiml4boyuxtokikcvupswapwehnv65@d2ppyiaeti22>
References: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
 <20251116-next-15nov_expose_sysfs-v1-1-3b7880e5b40e@oss.qualcomm.com>
 <t3hfhlp27numfxurtmtcwrovvlgwdvnujain46kwmi37zehdak@xt3vngtkxpsm>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t3hfhlp27numfxurtmtcwrovvlgwdvnujain46kwmi37zehdak@xt3vngtkxpsm>

On Sun, Nov 16, 2025 at 07:44:24PM +0200, Dmitry Baryshkov wrote:
> On Sun, Nov 16, 2025 at 08:49:47PM +0530, Shivendra Pratap wrote:
> > Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes, a
> > read-only sysfs attribute exposing the list of supported reboot-mode
> > arguments. This file is created by reboot-mode framework and provides a
> > user-readable interface to query available reboot-mode arguments.
> > 
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> > ---
> >  .../testing/sysfs-class-reboot-mode-reboot_modes   | 39 ++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..28280ffe9bf962ef9d2136ea5d7c6aef77c4bd34
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
> > @@ -0,0 +1,39 @@
> > +What:		/sys/class/reboot-mode/<driver>/reboot_modes
> > +Date:		November 2025
> > +KernelVersion:	6.18.0-rc5
> > +Contact:	linux-pm@vger.kernel.org
> > +		Description:
> > +		This interface exposes the reboot-mode arguments
> > +		registered with the reboot-mode framework. It is
> > +		a read-only interface and provides a space
> > +		separated list of reboot-mode arguments supported
> > +		on the current platform.
> > +		Example:
> > +		 recovery fastboot bootloader
> > +
> > +		The exact sysfs path may vary depending on the
> > +		name of the driver that registers the arguments.
> > +		Example:
> > +		 /sys/class/reboot-mode/nvmem-reboot-mode/reboot_modes
> > +		 /sys/class/reboot-mode/syscon-reboot-mode/reboot_modes
> > +		 /sys/class/reboot-mode/qcom-pon/reboot_modes
> 
> This part is obvious, isn't it?
> 
> > +
> > +		The supported arguments can be used by userspace
> > +		to invoke device reset using the reboot() system
> > +		call, with the "argument" as string to "*arg"
> > +		parameter along with LINUX_REBOOT_CMD_RESTART2.
> > +		Example:
> > +		 reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
> > +		        LINUX_REBOOT_CMD_RESTART2, "bootloader");
> 
> So, does one need to write a tool for invoking reboot with the corerct
> set of args?

Here's an implementation of such tool
https://github.com/systemd/systemd/blob/main/src/shared/reboot-util.c#L80

Many other implementations of reboot provides the same.

> If we are adding a sysfs interface, wouldn't it be logical
> to also add another sysfs file, setting the argument?
> 

The inclusion of the example indicates that we need to expose it in an
accessible form, but I don't think we should, as it's already a
widespread standard interface.

As such, I don't think the example adds any value, but it would be
valuable to clarify that this is a standard interface.

Regards,
Bjorn

> > +
> > +		A driver can expose the supported arguments by
> > +		registering them with the reboot-mode framework
> > +		using the property names that follow the
> > +		mode-<argument> format.
> > +		Example:
> > +		 mode-bootloader, mode-recovery.
> > +
> > +		This attribute is useful for scripts or initramfs
> > +		logic that need to programmatically determine
> > +		which reboot-mode arguments are valid before
> > +		triggering a reboot.
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> With best wishes
> Dmitry

