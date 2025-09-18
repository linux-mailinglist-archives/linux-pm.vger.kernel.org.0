Return-Path: <linux-pm+bounces-34994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C21B86C83
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 21:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FAE18993A9
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3332E266A;
	Thu, 18 Sep 2025 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poWkNhV9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E3264A72;
	Thu, 18 Sep 2025 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225311; cv=none; b=V9Ba8dk4cF596kZ4uz+Fr624ormuf0ztB/cAkp/6wlCtJnF1EV5+Nz+22viiY+mHVCim23RbtURCFmjwGuu6HMePxNkNutbc7nthCJYctBdjdVQpsBhGs8NivsIdzpwuB9KMGL0QP4x07T/sjuGgsn95mfQBIzn098cL8xaC/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225311; c=relaxed/simple;
	bh=0XjeHWc7Ujz6cslBYlKoJ6z/2iHTu3+LdywlTfZMjcA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iDN86s+fNRrHmkgPEHgC9C2pse94eNX78XhLMi+dOx3ULgdpaUy4rqGFeDEzFoIr5+Tz4k/X5oYSQ1akqjttWZFMltk8Optcpr2RNDoybj/qTwIm/GK7msdV12O80QJ5QF11l57L15gyU23hVcr5so/BbNySoFj/JNuFqh9Sahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poWkNhV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46DAC4CEE7;
	Thu, 18 Sep 2025 19:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758225310;
	bh=0XjeHWc7Ujz6cslBYlKoJ6z/2iHTu3+LdywlTfZMjcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=poWkNhV9UH/yVw9GvWbwOpWUpmJyuVwCTGnJNjlCwZgUVKdABnveWULD6BIfR6aGg
	 sMY8urXOYx1nd6UbwTVmGkd1hRT1uBOrERvVEOzG6vv8syPHkL6gjJF5Rnnrh7/0Ip
	 H4S34SEIgk3u6UGahBbeegL4vbhYP0sv68Nn/1JTh7BYuovhn3QITNQ8WMqWN9aq/9
	 NgGeOv2PMVUqkJwdAyL6Lr4/LTiYuzsrYyYdApNCFgypsqWzXacyumxMZDXq+gbEYk
	 1NWueEm6003ZR5KSyoHnkBb2rleNWAFSRPhfGzMHpQx9f85t4O3p7Nshw7fKvSZ3hO
	 pYzVIC7i5CVDg==
Date: Thu, 18 Sep 2025 14:55:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>,
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Merthan =?utf-8?Q?Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v8 4/4] USB: Pass PMSG_POWEROFF event to suspend_common()
Message-ID: <20250918195509.GA1918371@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918034427.3226217-5-superm1@kernel.org>

On Wed, Sep 17, 2025 at 10:44:27PM -0500, Mario Limonciello (AMD) wrote:
> suspend_common() passes the a PM message indicating what type of event
> is occurring.  Add a new callback hcd_pci_poweroff() which will
> determine if target state is power off and pass PMSG_POWEROFF as the
> message.

Something is missing in "passes the a".

> There are no functional changes in this patch.

Maybe so, but the .poweroff() path previously called
"suspend_common(dev, PMSG_SUSPEND)" and now may call
"suspend_common(dev, PMSG_POWEROFF)", so it's not completely obvious
that this is a functional no-op.

It seems sort of weird that apparently we can call .poweroff() for
either a "suspend" or a "power-off" event.

Maybe it would be helpful to explain how we get to .poweroff() when
system_state is something other than SYSTEM_POWER_OFF, and what that
means?

> +static int hcd_pci_poweroff(struct device *dev)
> +{
> +	if (system_state == SYSTEM_POWER_OFF)
> +		return suspend_common(dev, PMSG_POWEROFF);
> +	return suspend_common(dev, PMSG_SUSPEND);
> +}
> +
>  static int hcd_pci_suspend_noirq(struct device *dev)
>  {
>  	struct pci_dev		*pci_dev = to_pci_dev(dev);
> @@ -602,6 +610,7 @@ static int hcd_pci_restore(struct device *dev)
>  #define hcd_pci_suspend		NULL
>  #define hcd_pci_freeze			NULL
>  #define hcd_pci_suspend_noirq	NULL
> +#define hcd_pci_poweroff	NULL
>  #define hcd_pci_poweroff_late	NULL
>  #define hcd_pci_resume_noirq	NULL
>  #define hcd_pci_resume		NULL
> @@ -639,7 +648,7 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
>  	.freeze_noirq	= check_root_hub_suspended,
>  	.thaw_noirq	= NULL,
>  	.thaw		= hcd_pci_resume,
> -	.poweroff	= hcd_pci_suspend,
> +	.poweroff	= hcd_pci_poweroff,
>  	.poweroff_late	= hcd_pci_poweroff_late,
>  	.poweroff_noirq	= hcd_pci_suspend_noirq,
>  	.restore_noirq	= hcd_pci_resume_noirq,
> -- 
> 2.51.0
> 

