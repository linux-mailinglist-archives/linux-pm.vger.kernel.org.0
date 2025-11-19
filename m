Return-Path: <linux-pm+bounces-38200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AE1C6C8D1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 04:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 790C32C4F8
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 03:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696D42E7631;
	Wed, 19 Nov 2025 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Elehsyoe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD13260588;
	Wed, 19 Nov 2025 03:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522277; cv=none; b=THsFycL3hxYMVTHKEGk5T1D7fRi5skpXfEpBZ5uOzxgRyGSxhcSDIb2lJE2IT+S/5nF/HT/H2tCvez5tW11TS/Scx05C03KuVQ7qutzg9u3pKwWvjmMgIVXJNN0P4nk2EUv+lNzLoH5GFq3VAJdgfMZevkF67ZQsc8Xwg6/Bm48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522277; c=relaxed/simple;
	bh=MIjgvuB0KiPtZ+6xNAoLd+3B/qJ5CymJwizx6U/famA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoflqlQAfBnzyD0QnxceLMpd/AnGjUHkJsbvA/3DSuqXUehEpUqM46lhC6B3veVUwGfVBf7C90GPlrXYzePtkRIuW8cUAWbLclGPlE3/58jBRvPzfEUyljkOEE+XVfldA9DeSZSlpEy2e88hTG81Iu6xJqych8uf1xaqSw1caGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Elehsyoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC73C16AAE;
	Wed, 19 Nov 2025 03:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763522276;
	bh=MIjgvuB0KiPtZ+6xNAoLd+3B/qJ5CymJwizx6U/famA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElehsyoeaGF+JHCONkNRqSVn1gQIGVBnFS9qAFy6URSKQJmngam1W2OcbVTebjrdd
	 2wFTCGurf47Aae50x8fCw0Glg2zLptoK36bcYjy91BmjgzWAizru4RDuZLpgUZa+Va
	 aKMEjwctuhpctR05cXw5zAjI2b3yh7b2cdGzqz6G+jgolxjNa839itURDoob6+aY/D
	 I05q2hVqdBdbtx8qRTWoPyCV+fKYzQwVsAArokPSIRK+Pz87/HjqwcVaNjk/jJ3wUX
	 vREy5KykxaOf5iOkdFvTa5zoVdbjS2t8vhDFktH7HegBPOAmbpKxcYnvq6IBREGIyq
	 y+wS/vnlVooMw==
Date: Tue, 18 Nov 2025 21:22:46 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Sebastian Reichel <sre@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/2] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Message-ID: <yxy7b4pdv4o7dvfjndi5awg5tcobkzwuewn6sal2v2eydv4aes@wkaknlotycrk>
References: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
 <20251116-next-15nov_expose_sysfs-v1-1-3b7880e5b40e@oss.qualcomm.com>
 <t3hfhlp27numfxurtmtcwrovvlgwdvnujain46kwmi37zehdak@xt3vngtkxpsm>
 <virjbkkpdmufx2midadzwiml4boyuxtokikcvupswapwehnv65@d2ppyiaeti22>
 <1ddb483e-3c09-ff45-9d36-cf29a40ba55d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ddb483e-3c09-ff45-9d36-cf29a40ba55d@oss.qualcomm.com>

On Tue, Nov 18, 2025 at 10:07:51PM +0530, Shivendra Pratap wrote:
> 
> 
> On 11/18/2025 2:18 AM, Bjorn Andersson wrote:
> > On Sun, Nov 16, 2025 at 07:44:24PM +0200, Dmitry Baryshkov wrote:
> >> On Sun, Nov 16, 2025 at 08:49:47PM +0530, Shivendra Pratap wrote:
> >>> Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes, a
> >>> read-only sysfs attribute exposing the list of supported reboot-mode
> >>> arguments. This file is created by reboot-mode framework and provides a
> >>> user-readable interface to query available reboot-mode arguments.
> >>>
> >>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> >>> ---
> >>>  .../testing/sysfs-class-reboot-mode-reboot_modes   | 39 ++++++++++++++++++++++
> >>>  1 file changed, 39 insertions(+)
> >>>
> >>> diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
> >>> new file mode 100644
> >>> index 0000000000000000000000000000000000000000..28280ffe9bf962ef9d2136ea5d7c6aef77c4bd34
> >>> --- /dev/null
> >>> +++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
> >>> @@ -0,0 +1,39 @@
> >>> +What:		/sys/class/reboot-mode/<driver>/reboot_modes
> >>> +Date:		November 2025
> >>> +KernelVersion:	6.18.0-rc5
> >>> +Contact:	linux-pm@vger.kernel.org
> >>> +		Description:
> >>> +		This interface exposes the reboot-mode arguments
> >>> +		registered with the reboot-mode framework. It is
> >>> +		a read-only interface and provides a space
> >>> +		separated list of reboot-mode arguments supported
> >>> +		on the current platform.
> >>> +		Example:
> >>> +		 recovery fastboot bootloader
> >>> +
> >>> +		The exact sysfs path may vary depending on the
> >>> +		name of the driver that registers the arguments.
> >>> +		Example:
> >>> +		 /sys/class/reboot-mode/nvmem-reboot-mode/reboot_modes
> >>> +		 /sys/class/reboot-mode/syscon-reboot-mode/reboot_modes
> >>> +		 /sys/class/reboot-mode/qcom-pon/reboot_modes
> >>
> >> This part is obvious, isn't it?
> >>
> >>> +
> >>> +		The supported arguments can be used by userspace
> >>> +		to invoke device reset using the reboot() system
> >>> +		call, with the "argument" as string to "*arg"
> >>> +		parameter along with LINUX_REBOOT_CMD_RESTART2.
> >>> +		Example:
> >>> +		 reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2,
> >>> +		        LINUX_REBOOT_CMD_RESTART2, "bootloader");
> >>
> >> So, does one need to write a tool for invoking reboot with the corerct
> >> set of args?
> > 
> > Here's an implementation of such tool
> > https://github.com/systemd/systemd/blob/main/src/shared/reboot-util.c#L80
> 
> Should i include this link for an example of existing tools or i just add
> add a line saying that such tools are already available?
> 
> > 
> > Many other implementations of reboot provides the same.
> > 
> >> If we are adding a sysfs interface, wouldn't it be logical
> >> to also add another sysfs file, setting the argument?
> >>
> > 
> > The inclusion of the example indicates that we need to expose it in an
> > accessible form, but I don't think we should, as it's already a
> > widespread standard interface.
> > 
> > As such, I don't think the example adds any value, but it would be
> > valuable to clarify that this is a standard interface.
> 
> ok. Will remove this example of reboot syscall and add a line to
> indicate that this is standard interface.
> 

This sounds good to me.

Thanks,
Bjorn

> thanks,
> Shivendra

