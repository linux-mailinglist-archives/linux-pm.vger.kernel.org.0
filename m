Return-Path: <linux-pm+bounces-36940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43004C12C46
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 04:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B83C03540CB
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 03:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC24620F08C;
	Tue, 28 Oct 2025 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVtL5zvE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980D23AD;
	Tue, 28 Oct 2025 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622307; cv=none; b=kSmFNvMfG/XPhjgErRdU4rWT0zBR/n9kBeC1uJMO9iBdfLK9hrf+D/HIpzuCFC9sn9CIJtyfz0uhgQPf1d1ySHRSLTnabXopAghUvPfbJOmiPLpPFyzOEIMKMmYtlNPVEX/PSGhOJ1fBwkRkVuLbqTbOFL0ZNT1ps7yxDql2sXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622307; c=relaxed/simple;
	bh=Jl/8CHVAK7+L4vEEBKRiYKyCXkLAMwmArYnWsTUg74Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryhTCNerjog3O5aGuVDm5LksoRWERdbkotXvzu+Dq0PC7te/zqbmPyRRoBWfLS5ObjB7nRBTig6usEx/37KE7GjnrlaPBdavpHIv2V1fM/3fdLrhVZx1ibp9pCgsrdRqxy7Su++dDyH/mGJ/6XVdHwe+Wdw+miEBPvjsPOsnNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVtL5zvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DD9C4CEF1;
	Tue, 28 Oct 2025 03:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761622307;
	bh=Jl/8CHVAK7+L4vEEBKRiYKyCXkLAMwmArYnWsTUg74Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVtL5zvE2Sw10TJD4SsYkiqzTAQtue5QkhxVXBEMu6PGR98ZO4hWUeFWZ1nd9sJhU
	 IUMLgzg7shdljsdXSmXyEkx4UowbgfK3a55oOQz/HORjnlSw+gluAVF8uz/nWc4vCc
	 nt/Oq9ddADgIDxNddJQI0lswU8CKJP1iiTG8bNwtqLhuMISeYZbOcvk8kTPzb7soD0
	 I30ItpvPehfnNBrUnJLfHzGqu13Di0MCZIY6VAxF6HOsMKVtsFQxESr9FuI/Qr87Ap
	 jvYm47igU8kBy6q4V/7kScMlRm0SsujXqm/fOr4bUg4qzsjHRjte7Yo13OXl0Vy+md
	 +5E+MQ8sJKgQA==
Date: Mon, 27 Oct 2025 22:34:41 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Vinod Koul <vkoul@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Moritz Fischer <moritz.fischer@ettus.com>, John Stultz <john.stultz@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, 
	Stephen Boyd <swboyd@chromium.org>, Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Elliot Berman <quic_eberman@quicinc.com>, 
	Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v16 01/14] power: reset: reboot-mode: Synchronize list
 traversal
Message-ID: <5l2tcjbdtikkhkuhuz64ymk5et6wtl4kwf2mc265su27oh57rt@3shmo3wfx7fb>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-1-b98aedaa23ee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-1-b98aedaa23ee@oss.qualcomm.com>

On Wed, Oct 15, 2025 at 10:08:16AM +0530, Shivendra Pratap wrote:
> List traversals must be synchronized to prevent race conditions
> and data corruption. The reboot-mode list is not protected by a
> lock currently, which can lead to concurrent access and race.

Is it a theoretical future race or something that we can hit in the
current implementation?

> 
> Introduce a mutex lock to guard all operations on the reboot-mode
> list and ensure thread-safe access. The change prevents unsafe
> concurrent access on reboot-mode list.

I was under the impression that these lists where created during boot
and then used at some later point, which at best would bring a
theoretical window for a race... Reviewing the code supports my
understanding, but perhaps I'm missing something?

> 
> Fixes: 4fcd504edbf7 ("power: reset: add reboot mode driver")
> Fixes: ca3d2ea52314 ("power: reset: reboot-mode: better compatibility with DT (replace ' ,/')")
> 

Skip this empty line, please.


And given that you have fixes here, I guess this is a problem today. In
which case, this shouldn't have been carried for 16 versions - but have
sent and been merged on its own already.

So please, if this is a real issue, start your commit message with a
descriptive problem description, to make it clear that this needs to be
merged yesterday - or drop the fixes.

> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 96 +++++++++++++++++++++------------------
>  include/linux/reboot-mode.h       |  4 ++
>  2 files changed, 57 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index fba53f638da04655e756b5f8b7d2d666d1379535..8fc3e14638ea757c8dc3808c240ff569cbd74786 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -29,9 +29,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>  	if (!cmd)
>  		cmd = normal;
>  
> -	list_for_each_entry(info, &reboot->head, list)
> -		if (!strcmp(info->mode, cmd))
> -			return info->magic;
> +	scoped_guard(mutex, &reboot->rb_lock) {
> +		list_for_each_entry(info, &reboot->head, list)
> +			if (!strcmp(info->mode, cmd))
> +				return info->magic;
> +	}
>  
>  	/* try to match again, replacing characters impossible in DT */
>  	if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
> @@ -41,9 +43,11 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
>  	strreplace(cmd_, ',', '-');
>  	strreplace(cmd_, '/', '-');
>  
> -	list_for_each_entry(info, &reboot->head, list)
> -		if (!strcmp(info->mode, cmd_))
> -			return info->magic;
> +	scoped_guard(mutex, &reboot->rb_lock) {
> +		list_for_each_entry(info, &reboot->head, list)
> +			if (!strcmp(info->mode, cmd_))
> +				return info->magic;
> +	}
>  
>  	return 0;
>  }
> @@ -78,46 +82,50 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>  
>  	INIT_LIST_HEAD(&reboot->head);
>  
> -	for_each_property_of_node(np, prop) {
> -		if (strncmp(prop->name, PREFIX, len))
> -			continue;
> -
> -		info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
> -		if (!info) {
> -			ret = -ENOMEM;
> -			goto error;
> -		}
> -
> -		if (of_property_read_u32(np, prop->name, &info->magic)) {
> -			dev_err(reboot->dev, "reboot mode %s without magic number\n",
> -				info->mode);
> -			devm_kfree(reboot->dev, info);
> -			continue;
> -		}
> -
> -		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
> -		if (!info->mode) {
> -			ret =  -ENOMEM;
> -			goto error;
> -		} else if (info->mode[0] == '\0') {
> -			kfree_const(info->mode);
> -			ret = -EINVAL;
> -			dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
> -				prop->name);
> -			goto error;
> +	mutex_init(&reboot->rb_lock);
> +
> +	scoped_guard(mutex, &reboot->rb_lock) {

I don't see how this can race with anything, reboot_mode_register() is
supposed to be called from some probe function, with reboot_mode_driver
being a "local" object.

The guard here "protects" &reboot->head, but that is not a shared
resources at this point.

> +		for_each_property_of_node(np, prop) {
> +			if (strncmp(prop->name, PREFIX, len))
> +				continue;
> +
> +			info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
> +			if (!info) {
> +				ret = -ENOMEM;
> +				goto error;
> +			}
> +
> +			if (of_property_read_u32(np, prop->name, &info->magic)) {
> +				dev_err(reboot->dev, "reboot mode %s without magic number\n",
> +					info->mode);
> +				devm_kfree(reboot->dev, info);
> +				continue;
> +			}
> +
> +			info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
> +			if (!info->mode) {
> +				ret =  -ENOMEM;
> +				goto error;
> +			} else if (info->mode[0] == '\0') {
> +				kfree_const(info->mode);
> +				ret = -EINVAL;
> +				dev_err(reboot->dev, "invalid mode name(%s): too short!\n",
> +					prop->name);
> +				goto error;
> +			}
> +
> +			list_add_tail(&info->list, &reboot->head);
>  		}
>  
> -		list_add_tail(&info->list, &reboot->head);
> -	}
> -
> -	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
> -	register_reboot_notifier(&reboot->reboot_notifier);
> +		reboot->reboot_notifier.notifier_call = reboot_mode_notify;
> +		register_reboot_notifier(&reboot->reboot_notifier);

Once register_reboot_notifier() has been called, &reboot->head is
visible outside the specific driver instance.

So, there's no reason to lock in reboot_mode_register().

>  
> -	return 0;
> +		return 0;
>  
>  error:
> -	list_for_each_entry(info, &reboot->head, list)
> -		kfree_const(info->mode);
> +		list_for_each_entry(info, &reboot->head, list)
> +			kfree_const(info->mode);
> +	}
>  
>  	return ret;
>  }
> @@ -133,8 +141,10 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>  
>  	unregister_reboot_notifier(&reboot->reboot_notifier);
>  
> -	list_for_each_entry(info, &reboot->head, list)
> -		kfree_const(info->mode);
> +	scoped_guard(mutex, &reboot->rb_lock) {

get_reboot_mode_magic() is only called from reboot_mode_notify(), which
is only invoked by blocking_notifier_call_chain().

blocking_notifier_call_chain() takes a read semaphore.
unregister_reboot_notifier() take a write semaphore.

So, if we're racing with a shutdown or reboot, I see two possible
things:

1) blocking_notifier_call_chain() happens first and calls
   reboot_mode_notify(), blocking unregister_reboot_notifier(). Once it
   returns, the unregister proceeds and we enter case #2

2) unregister_reboot_notifier() happens first (or after the
   blocking_notifier_call_chain() returns). Our reboot object is removed
   from the list and blocking_notifier_call_chain() will not invoke
   reboot_mode_notify().

In either case, the list has a single owner here.


As far as I can see, the only race left is if multiple concurrent calls
happens to blocking_notifier_call_chain(), the behavior of
reboot->write() might be undefined. But I think that is reasonable.


Please let me know if I'm missing something.

Thanks,
Bjorn

> +		list_for_each_entry(info, &reboot->head, list)
> +			kfree_const(info->mode);
> +	}
>  
>  	return 0;
>  }
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..b73f80708197677db8dc2e43affc519782b7146e 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -2,11 +2,15 @@
>  #ifndef __REBOOT_MODE_H__
>  #define __REBOOT_MODE_H__
>  
> +#include <linux/mutex.h>
> +
>  struct reboot_mode_driver {
>  	struct device *dev;
>  	struct list_head head;
>  	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
>  	struct notifier_block reboot_notifier;
> +	/*Protects access to reboot mode list*/
> +	struct mutex rb_lock;
>  };
>  
>  int reboot_mode_register(struct reboot_mode_driver *reboot);
> 
> -- 
> 2.34.1
> 

