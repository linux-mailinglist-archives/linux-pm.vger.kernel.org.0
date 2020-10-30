Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB372A0C3F
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 18:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgJ3RMw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 13:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgJ3RMw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 13:12:52 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8C4C0613D2
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 10:12:52 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id p7so8263483ioo.6
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FUbzL5XdQ1f8YYBKU5C0sP8LGZcBt1qJvGhftOqGF4E=;
        b=aNbLbx6aajXxMw9iAkrV9bGley0HzSnyUh4Qz92ibH9zFMbBOmbUxysZ+za3eA6/D4
         M37pzUQRVEb+i3WPAFry4wJ5J44lAb1M6S2Loajb2npO2n6ugKsni97Fc8wFh8eRn9n9
         Ihw8IkvMQtK3fKBv3FMn700tiChrhL+MF94uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FUbzL5XdQ1f8YYBKU5C0sP8LGZcBt1qJvGhftOqGF4E=;
        b=MGwEAL5GHBJepbl1+esgfVEu56rUsUjWl+CO6WHfYDV/QMeIACVVY5C6l/ZGSFk2CM
         +92F/aYOnXnA/MjPTyh+1ksbtRAShIgC1uJSRvzql2ax1lNM+tOUBIAFAvraxOmEmwWE
         JlvEhlXvwbtHu5SeOo0lXskz1IJ2/FDg0oxtgPkcxKxXnBRQVMklIFWqVJcakYMJZ+im
         QbHchIxBgvwExMm04TTN7i7GkaoMygiQPg2/S4cXCF1nZ3g4RpGmcV/NUFe+RT+T8amI
         /+lqfyAaJ8+lbSJHwFRBik6exQE4Mn60vo6kosnP+5UOZAlB3QXTi1MLnTohS8iAsd/l
         0osw==
X-Gm-Message-State: AOAM532fLLeZj/J8dywfNw8W4t0rLkKogfbUfJD1x228Zd6KDiCJ2bIR
        1q8iyxIiPT7k0PwrA69XX+VRbQ==
X-Google-Smtp-Source: ABdhPJzYWtoBbDYvzZ3xNeVMyVANpnHjx84A3cXKcNETpEhPGLmyVqezsvv/c80LwFhG2z8oErxZcw==
X-Received: by 2002:a02:c80a:: with SMTP id p10mr2701625jao.114.1604077971626;
        Fri, 30 Oct 2020 10:12:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e12sm5004102ilq.65.2020.10.30.10.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 10:12:51 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] x86/msr: Do not allow writes to
 MSR_IA32_ENERGY_PERF_BIAS
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201029190259.3476-1-bp@alien8.de>
 <20201029190259.3476-5-bp@alien8.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f259f033-c62e-e1a2-2f46-85b7961ac0ad@linuxfoundation.org>
Date:   Fri, 30 Oct 2020 11:12:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029190259.3476-5-bp@alien8.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/29/20 1:02 PM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Now that all in-kernel-tree users are converted to using the sysfs file,
> remove the MSR from the "allowlist".
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>   arch/x86/kernel/msr.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
> index c0d409810658..b1147862730c 100644
> --- a/arch/x86/kernel/msr.c
> +++ b/arch/x86/kernel/msr.c
> @@ -99,9 +99,6 @@ static int filter_write(u32 reg)
>   	if (!__ratelimit(&fw_rs))
>   		return 0;
>   
> -	if (reg == MSR_IA32_ENERGY_PERF_BIAS)
> -		return 0;
> -
>   	pr_err("Write to unrecognized MSR 0x%x by %s (pid: %d). Please report to x86@kernel.org.\n",
>   	       reg, current->comm, current->pid);
>   
> 

Thanks. Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
