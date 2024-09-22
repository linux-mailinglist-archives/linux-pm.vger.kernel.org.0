Return-Path: <linux-pm+bounces-14541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B5A97E2D8
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 19:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE42280DD4
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6EB33F7;
	Sun, 22 Sep 2024 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXJym+kn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217426AC1;
	Sun, 22 Sep 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727027703; cv=none; b=I9yOjLR/+depTHK3aEhI/EOYAQV+PddhzPRvaW4Omej2SOO+XK524e+1TGmRd2udgGDI9duZPWpTN7zgn46jGNvdWkiC/BLOzrxs1hdqxo5xe24Yd3IbTeSHCAh4jRajRMI9SCdU2ngcYcMFCEyYUQh6HJpg+mAaMpEDj4QktSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727027703; c=relaxed/simple;
	bh=WdKJR5wfOFdArskTokBkbsN9SgbRbGTBWepBKf4aS8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=da34nbyHrr92xoj8S/g8wnbDqHC8IpB+1gqig+HyYDo818pfnUMolWMKEqaAwV2Q3WFUajr0aPXSVB/RpE6GpzKEf6WqWkbgaG08iElOu0HrhKgKsQr5BHGES2TKtS7avVtjEE7XUCVkcHUQFLNzNQ9uCkqjuUCddI8XBKShspg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXJym+kn; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so503494466b.3;
        Sun, 22 Sep 2024 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727027700; x=1727632500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEI7Ebxsy0en8BGvpi2StRFfYjFwlCJwhzx9wE+OzkE=;
        b=dXJym+knyU9f/i39TTNKF4YJWQZj0Y5VauS9J/iFvZxpCeXZ8ASW7kW4K4xZZc4oWG
         5rxOxWKX2X3bfVd14d3UfizBeyzHCFjT+lZWnnxkkoWZ3zoWuedG35+1oDeYtW8I7kEN
         978Un1U5nHMpi5bYKd+3ylhztIN58fRAp4hN2bLxFej3FGqccJdf1BFOoc/aUZMkDDTX
         DHUKTwa0b8q3lSxUUGanSdkW6QQ9qPD3v5ObDQ5HuEEKUPFFHKlRQK8ochRVLL2yU8Rd
         VBiNuRUtix7zl6AIwEdXwLPAHzYLy5db72UkLxVPk/c/7JtYcdJv+jGPMUUOMe+wMdr2
         PBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727027700; x=1727632500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEI7Ebxsy0en8BGvpi2StRFfYjFwlCJwhzx9wE+OzkE=;
        b=iiszPaUA8N9q5Heu7EQKIZKwLMADMQeBDs4p3X0RmnrZS4f6ZI9a/bQE5k3WuY8VGq
         ZdGMG3S7OZqG+YvV6QAu1pUkmggbZf6Kfex1HB48E7OJ26q8Z8CttSvHVMJ3jpfZLRm/
         dc2ldXq60ELQt1UnMc6d4VF1jM5bNkCCJ6UGYPHkNx6EE0BGCKSsUS9coEvap3VtKXMG
         RPoIixSYeJvdJRa1Xq3tCMBZ6FdhuSpUzxV6cY6yz4UwNlyeuXY1DHje9rd0JrR5DEUq
         dbbsftQN4GY/LLigXzA2Sgr/JyEIo7hpRpOM1mPhrPb7EOX9SjvT24yPXhgIWiJD7e7I
         +d3A==
X-Forwarded-Encrypted: i=1; AJvYcCXnOGU7ncXpIXI4zwufC3FW/CWVIRP6SYO5GUzGsYc4r8N7MXd94SiDabrh74shcpCzb5W3SvFYlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy8CT0WiYCKEY4lUrGhPjvnwCwIwOgZ+q+kfRnDsfqXo23LDsL
	6wqH8s81qWkJtWeZbg+lccQf4ujsFq1x6la/8CYoTbprUhWQn9L1HVNyVZeX
X-Google-Smtp-Source: AGHT+IEMGwSTQLGq21PfvanJ46cHKa12cAfgQIpwBhxTI7yNr68QL37XtClY+CPWDYuiGvTf1QvpSQ==
X-Received: by 2002:a17:907:72d1:b0:a8d:60e2:396b with SMTP id a640c23a62f3a-a90d5167073mr1051525266b.65.1727027699922;
        Sun, 22 Sep 2024 10:54:59 -0700 (PDT)
Received: from [192.168.1.127] ([176.206.82.32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061331b7csm1104485066b.225.2024.09.22.10.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 10:54:59 -0700 (PDT)
Message-ID: <9b47ee96-f789-4e96-890f-f3dcf9da2e02@gmail.com>
Date: Sun, 22 Sep 2024 19:54:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] acpi/x86: s2idle: add quirk table for modern
 standby delays
To: Antheas Kapenekakis <lkml@antheas.dev>, linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, luke@ljones.dev,
 me@kylegospodneti.ch
References: <20240922172258.48435-1-lkml@antheas.dev>
 <20240922172258.48435-4-lkml@antheas.dev>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <20240922172258.48435-4-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/09/24 19:22, Antheas Kapenekakis wrote:
> Unfortunately, some modern standby systems, including the ROG Ally, rely
> on a delay between modern standby transitions. Add a quirk table for
> introducing delays between modern standby transitions, and quirk the
> ROG Ally on "Display Off", which needs a bit of time to turn off its
> controllers prior to suspending (i.e., entering DRIPS).
> 
> Reported-by: Denis Benato <benato.denis96@gmail.com>

I told you privately that as stated here: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
Reported-By tags are to be followed by a Closes tag stating that the issue is solved.

What has been presented to me today was not about solving bugs, but changing how they manifests and therefore permission was not granted to you to represent me as satisfied with the work as it would be wrong to assume issues are solved and this is worth merging.

Furthermore everybody can see my answers to your v1 patch and there is no need to attach a Reported-by when the issue has been reported publicly and is not resolved.

I will add my Tested-off-by by myself whenever I will be fully satisfied by work presented: in the current state I am not.

> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  include/linux/suspend.h |  5 +++++
>  kernel/power/suspend.c  | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 8f33249cc067..d7e2a4d8ab0c 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -144,6 +144,11 @@ struct platform_s2idle_ops {
>  	int (*display_on)(void);
>  };
>  
> +struct platform_s2idle_quirks {
> +	int delay_display_off;
> +	int delay_display_on;
> +};
> +
>  #ifdef CONFIG_SUSPEND
>  extern suspend_state_t pm_suspend_target_state;
>  extern suspend_state_t mem_sleep_current;
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 610f8ecaeebd..af2abdd2f8c3 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/string.h>
>  #include <linux/delay.h>
> +#include <linux/dmi.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
>  #include <linux/console.h>
> @@ -61,6 +62,30 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
>  enum s2idle_states __read_mostly s2idle_state;
>  static DEFINE_RAW_SPINLOCK(s2idle_lock);
>  
> +// The ROG Ally series disconnects its controllers on Display Off, without
> +// holding a lock, introducing a race condition. Add a delay to allow the
> +// controller to disconnect cleanly prior to suspend.
> +static const struct platform_s2idle_quirks rog_ally_quirks = {
> +	.delay_display_off = 500,
> +};
> +
> +static const struct dmi_system_id platform_s2idle_quirks[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> +		},
> +		.driver_data = (void *)&rog_ally_quirks
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
> +		},
> +		.driver_data = (void *)&rog_ally_quirks
> +	},
> +	{}
> +};
> +
> +
>  /**
>   * pm_suspend_default_s2idle - Check if suspend-to-idle is the default suspend.
>   *
> @@ -589,12 +614,26 @@ static int enter_state(suspend_state_t state)
>  	if (state == PM_SUSPEND_TO_IDLE)
>  		s2idle_begin();
>  
> +	/*
> +	 * Windows transitions between Modern Standby states slowly, over multiple
> +	 * seconds. Certain manufacturers may rely on this, introducing race
> +	 * conditions. Until Linux can support modern standby, add the relevant
> +	 * delays between transitions here.
> +	 */
> +	const struct dmi_system_id *s2idle_sysid = dmi_first_match(
> +		platform_s2idle_quirks
> +	);
> +	const struct platform_s2idle_quirks *s2idle_quirks = s2idle_sysid ?
> +		s2idle_sysid->driver_data : NULL;
> +
>  	/*
>  	 * Linux does not have the concept of a "Screen Off" state, so call
>  	 * the platform functions for Display On/Off prior to the suspend
>  	 * sequence, mirroring Windows which calls them outside of it as well.
>  	 */
>  	platform_suspend_display_off();
> +	if (s2idle_quirks && s2idle_quirks->delay_display_off)
> +		msleep(s2idle_quirks->delay_display_off);
>  
>  	if (sync_on_suspend_enabled) {
>  		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> @@ -624,6 +663,8 @@ static int enter_state(suspend_state_t state)
>   Unlock:
>  	mutex_unlock(&system_transition_mutex);
>  
> +	if (s2idle_quirks && s2idle_quirks->delay_display_on)
> +		msleep(s2idle_quirks->delay_display_on);
>  	platform_suspend_display_on();
>  	return error;
>  }


