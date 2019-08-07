Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E459984E4E
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 16:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbfHGOKA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 10:10:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43160 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388004AbfHGOKA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 10:10:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so16957932wru.10
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2019 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8P+JKtORiZRJabp4sESC8XKmOksCngbysZjXEptja+0=;
        b=R5aNVQR/Zr5XXg+JSCwyOrBgkarTJu4ymMWR1oyqVZt9sPBs0M4CJhc6feTDUU09vw
         HakGXm9ThUB8dUJqsXHf0GPSgInIMSGjDNgQhZWNjYn+Ixh5PpRD1OlNnxb6mdzvsEJP
         MWjdIkqp1lJaQgxR7+d4NCH9gVhtRbLkirGPWYe1jQf/0YHfd294j9lyjz0LFBSKNZWn
         pFzPhLUV2QdEInpATUfjHjFX1VafcUh8bs3ryiAfvzK2NElmL+W9zGE3b2oCdqc/yB7r
         tgcYbvaoRw6Av8jnhkxZqMBxi2XTQ0j4OhrUM0y0wnN1rUq5spEbtbJRJTBVkB8LgG4H
         oVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8P+JKtORiZRJabp4sESC8XKmOksCngbysZjXEptja+0=;
        b=Mnlw8vzYIA+wTtagDqgOQ9zTAcSEGaJgTZufIlrIPXLT5dbeZgInHSdFXi6zO2MFDI
         2thrdetwOBEM2bqDeKAe1gdvYcvVPli/P/sUKXwof5VxdS71NT6NfhwReP2xwg9C4RU9
         MlrA5DxttHg2LZqbxsagWLoxdotM9Q3vnSD8xQhe5QzCzz02ddEs8Vg61S/Cdy9jznxI
         8pPAqslJiBSZmmIY+UG6f9aQpdcQbNKmlU7+tNVSF+1BBtOtdojEeaddITSr0thEigO2
         xlQLYUaEupe/M3E/siuSg06G527XERl/p39nLvyKmQ6ySuD9xmsRgxCyiWqrLRRte/L2
         LR9A==
X-Gm-Message-State: APjAAAXgnmcgwMhuEXfso3Gfq8Q8BEVdY05VDy9FGyg2LSdlNc6NheVJ
        wRSFBg+bbp8q3T2VTZ52QRChQw==
X-Google-Smtp-Source: APXvYqw1zu7dyeOWbUlt6iOQ3bmwEov7DZ6aOdAYqu9LGuZMuC9LroPrFK0sQlCSwpzHSD4tRPsCdg==
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr11066543wrw.323.1565186997270;
        Wed, 07 Aug 2019 07:09:57 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:90cb:64c9:c238:a704? ([2a01:e34:ed2f:f020:90cb:64c9:c238:a704])
        by smtp.googlemail.com with ESMTPSA id f7sm92809346wrv.38.2019.08.07.07.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 07:09:56 -0700 (PDT)
Subject: Re: [PATCH 3/6] drivers: firmware: psci: Decouple checker from
 generic ARM CPUidle
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
 <20190722153745.32446-4-lorenzo.pieralisi@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fe87dffb-91f9-01b3-b1b8-7f5776e1274c@linaro.org>
Date:   Wed, 7 Aug 2019 16:09:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722153745.32446-4-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/07/2019 17:37, Lorenzo Pieralisi wrote:
> The PSCI checker currently relies on the generic ARM CPUidle
> infrastructure to enter an idle state, which in turn creates
> a dependency that is not really needed.
> 
> The PSCI checker code to test PSCI CPU suspend is built on
> top of the CPUidle framework and can easily reuse the
> struct cpuidle_state.enter() function (previously initialized
> by an idle driver, with a PSCI back-end) to trigger an entry
> into an idle state, decoupling the PSCI checker from the
> generic ARM CPUidle infrastructure and simplyfing the code
> in the process.
> 
> Convert the PSCI checker suspend entry function to use
> the struct cpuidle_state.enter() function callback.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/firmware/psci/psci_checker.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
> index f3659443f8c2..6a445397771c 100644
> --- a/drivers/firmware/psci/psci_checker.c
> +++ b/drivers/firmware/psci/psci_checker.c
> @@ -228,8 +228,11 @@ static int hotplug_tests(void)
>  
>  static void dummy_callback(struct timer_list *unused) {}
>  
> -static int suspend_cpu(int index, bool broadcast)
> +static int suspend_cpu(struct cpuidle_device *dev,
> +		       struct cpuidle_driver *drv, int index)
>  {
> +	struct cpuidle_state *state = &drv->states[index];
> +	bool broadcast = state->flags & CPUIDLE_FLAG_TIMER_STOP;
>  	int ret;
>  
>  	arch_cpu_idle_enter();
> @@ -254,11 +257,7 @@ static int suspend_cpu(int index, bool broadcast)
>  		}
>  	}
>  
> -	/*
> -	 * Replicate the common ARM cpuidle enter function
> -	 * (arm_enter_idle_state).
> -	 */
> -	ret = CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, index);
> +	ret = state->enter(dev, drv, index);
>  
>  	if (broadcast)
>  		tick_broadcast_exit();
> @@ -301,9 +300,8 @@ static int suspend_test_thread(void *arg)
>  		 * doesn't use PSCI).
>  		 */
>  		for (index = 1; index < drv->state_count; ++index) {
> -			struct cpuidle_state *state = &drv->states[index];
> -			bool broadcast = state->flags & CPUIDLE_FLAG_TIMER_STOP;
>  			int ret;
> +			struct cpuidle_state *state = &drv->states[index];
>  
>  			/*
>  			 * Set the timer to wake this CPU up in some time (which
> @@ -318,7 +316,7 @@ static int suspend_test_thread(void *arg)
>  			/* IRQs must be disabled during suspend operations. */
>  			local_irq_disable();
>  
> -			ret = suspend_cpu(index, broadcast);
> +			ret = suspend_cpu(dev, drv, index);
>  
>  			/*
>  			 * We have woken up. Re-enable IRQs to handle any
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

