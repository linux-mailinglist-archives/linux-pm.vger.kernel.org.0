Return-Path: <linux-pm+bounces-34996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE417B86CA4
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 21:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D023ADE35
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E0306B03;
	Thu, 18 Sep 2025 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RObR7qdc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A719B303A32;
	Thu, 18 Sep 2025 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225442; cv=none; b=p/jxrqNTAy6pt3LyOUncjRlpxCk9+Ol/hD/lSRq3ZGVKCG43h8OXpZ+KZLTsfd4eiHG9bu1GAgsYy/2nBLZ2snaQ4mF08MR6GysZ3AU0y3lrNLs+saiB6Gnyo9MsF3+A7EmgSOoke3y6kv3HBHmUVd6m8EEmhOFQz8wv1+xWIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225442; c=relaxed/simple;
	bh=977rUY+qGkskf5HwPtTAx8X8oq7eFdQgZmaovQcXuRM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FQ20tsaduFJQYXKMPTTKXoZGXOW6yceKyZzklnvjvEFXbaoX2/WRs2b0c0iZXPjFfUA6MZ/ys/IrNy+VMRmEUSpfmjcE634tXvG6jDBAnE/OYI0hCiXP28NUqnUee/F4AwYicL8Eair0ucQCcknkQU4WsbzxLmzdiGkQzFDlhB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RObR7qdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EEAC4CEE7;
	Thu, 18 Sep 2025 19:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758225442;
	bh=977rUY+qGkskf5HwPtTAx8X8oq7eFdQgZmaovQcXuRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RObR7qdcwZCTIcR+R8sCJIiM1oBXI/wp5e7+eIt7aHoD9Em21/6KE2Y5or+/GibWd
	 D4R5IU1rG/M0jLekRZt2CFKVDi1zbPnJY0bCn8U/3dbM1CVMZUJumWK/g0zjQ9OR5I
	 Nw+qTUHADZ61IiGlwZPJyE3Iqp1VyEvYzOlWzyLE3xMoI9cYG02wBn91GHmdrdwq28
	 aV3FB7UpnleEcGqIMyUsIgQaE4pMrLiUnaNi9IQCcdi0yKayB8TMXJZwhQAOyRHGje
	 1wvmFd62NSJ8yoYVZGW73g+gJz2ZlcMB31kTpUj/eb8NZe6PXLMrSkkebpjAKOqnwf
	 i8Bk637Ooquzw==
Date: Thu, 18 Sep 2025 14:57:21 -0500
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
Subject: Re: [PATCH v8 1/4] PM: Introduce new PMSG_POWEROFF event
Message-ID: <20250918195721.GA1918283@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918034427.3226217-2-superm1@kernel.org>

On Wed, Sep 17, 2025 at 10:44:24PM -0500, Mario Limonciello (AMD) wrote:
> PMSG_POWEROFF will be used for the PM core to allow differentiating between
> a hibernation or shutdown sequence when re-using callbacks.

I think it would be useful to say something here about how the
hibernation and shutdown sequences are entered, e.g., what user
commands and syscalls are related?

> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v8:
>  * Break series into 3 parts
>  * Drop PMSG_NO_WAKEUP change
> v7:
>  * Reword commit
> v5:
>  * Re-order and split
>  * Add tags
> v4:
>  * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
> ---
>  drivers/base/power/main.c    | 7 +++++++
>  include/linux/pm.h           | 3 +++
>  include/trace/events/power.h | 3 ++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 2ea6e05e6ec9..86661c94e8ce 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -99,6 +99,8 @@ static const char *pm_verb(int event)
>  		return "restore";
>  	case PM_EVENT_RECOVER:
>  		return "recover";
> +	case PM_EVENT_POWEROFF:
> +		return "poweroff";
>  	default:
>  		return "(unknown PM event)";
>  	}
> @@ -369,6 +371,7 @@ static pm_callback_t pm_op(const struct dev_pm_ops *ops, pm_message_t state)
>  	case PM_EVENT_FREEZE:
>  	case PM_EVENT_QUIESCE:
>  		return ops->freeze;
> +	case PM_EVENT_POWEROFF:
>  	case PM_EVENT_HIBERNATE:
>  		return ops->poweroff;
>  	case PM_EVENT_THAW:
> @@ -403,6 +406,7 @@ static pm_callback_t pm_late_early_op(const struct dev_pm_ops *ops,
>  	case PM_EVENT_FREEZE:
>  	case PM_EVENT_QUIESCE:
>  		return ops->freeze_late;
> +	case PM_EVENT_POWEROFF:
>  	case PM_EVENT_HIBERNATE:
>  		return ops->poweroff_late;
>  	case PM_EVENT_THAW:
> @@ -437,6 +441,7 @@ static pm_callback_t pm_noirq_op(const struct dev_pm_ops *ops, pm_message_t stat
>  	case PM_EVENT_FREEZE:
>  	case PM_EVENT_QUIESCE:
>  		return ops->freeze_noirq;
> +	case PM_EVENT_POWEROFF:
>  	case PM_EVENT_HIBERNATE:
>  		return ops->poweroff_noirq;
>  	case PM_EVENT_THAW:
> @@ -1370,6 +1375,8 @@ static pm_message_t resume_event(pm_message_t sleep_state)
>  		return PMSG_RECOVER;
>  	case PM_EVENT_HIBERNATE:
>  		return PMSG_RESTORE;
> +	case PM_EVENT_POWEROFF:
> +		return PMSG_ON;
>  	}
>  	return PMSG_ON;
>  }
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index cc7b2dc28574..d001224c92fd 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -507,6 +507,7 @@ const struct dev_pm_ops name = { \
>   * RECOVER	Creation of a hibernation image or restoration of the main
>   *		memory contents from a hibernation image has failed, call
>   *		->thaw() and ->complete() for all devices.

Looks like there should be a blank line here to match formatting of
other messages.

> + * POWEROFF	System will poweroff, call ->poweroff() for all devices.
>   *
>   * The following PM_EVENT_ messages are defined for internal use by
>   * kernel subsystems.  They are never issued by the PM core.
> @@ -537,6 +538,7 @@ const struct dev_pm_ops name = { \
>  #define PM_EVENT_USER		0x0100
>  #define PM_EVENT_REMOTE		0x0200
>  #define PM_EVENT_AUTO		0x0400
> +#define PM_EVENT_POWEROFF	0x0800
>  
>  #define PM_EVENT_SLEEP		(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
>  #define PM_EVENT_USER_SUSPEND	(PM_EVENT_USER | PM_EVENT_SUSPEND)
> @@ -551,6 +553,7 @@ const struct dev_pm_ops name = { \
>  #define PMSG_QUIESCE	((struct pm_message){ .event = PM_EVENT_QUIESCE, })
>  #define PMSG_SUSPEND	((struct pm_message){ .event = PM_EVENT_SUSPEND, })
>  #define PMSG_HIBERNATE	((struct pm_message){ .event = PM_EVENT_HIBERNATE, })
> +#define PMSG_POWEROFF	((struct pm_message){ .event = PM_EVENT_POWEROFF, })
>  #define PMSG_RESUME	((struct pm_message){ .event = PM_EVENT_RESUME, })
>  #define PMSG_THAW	((struct pm_message){ .event = PM_EVENT_THAW, })
>  #define PMSG_RESTORE	((struct pm_message){ .event = PM_EVENT_RESTORE, })
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 82904291c2b8..370f8df2fdb4 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -179,7 +179,8 @@ TRACE_EVENT(pstate_sample,
>  		{ PM_EVENT_HIBERNATE, "hibernate" }, \
>  		{ PM_EVENT_THAW, "thaw" }, \
>  		{ PM_EVENT_RESTORE, "restore" }, \
> -		{ PM_EVENT_RECOVER, "recover" })
> +		{ PM_EVENT_RECOVER, "recover" }, \
> +		{ PM_EVENT_POWEROFF, "poweroff" })
>  
>  DEFINE_EVENT(cpu, cpu_frequency,
>  
> -- 
> 2.51.0
> 

