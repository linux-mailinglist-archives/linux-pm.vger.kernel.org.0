Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2131686DB
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 19:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgBUSmg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 13:42:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46770 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgBUSmf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 13:42:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id x14so3184239ljd.13;
        Fri, 21 Feb 2020 10:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uxWqAKH0hMLsDN81qJeO9ImscElDpY2jN3fTSj4y32U=;
        b=lYmXDNa0FPwfYKQ711T2/bwN6XnaLTXXtmeBrqym+hsYRnFLHsYGWfQDuEU/Auioma
         njUTHlTMGxK8VBgNdS2pdSFyKhKti5CApNH5cBcxv6XJyY5tXtyq7t+9OEWHRhcEgCoy
         VRZkWxsjFLt53du5yxpJ/ymM6U/mF90jyU+XphWM9ueR2zSiGBWFZztWi9AMo0JI9Gd2
         HH44rxfzE4hRXiQ1UrQtZjUY+eBKfH2dCCDpetMrevtSofatQcrHshyzdHr2w3pqNEfD
         sq1Yb6/AImLDgFBerYNuK9TE+B0I3SKx1niKYwXBh0ToEcWpY1T++xVr2YE3Oj69EQVF
         e2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uxWqAKH0hMLsDN81qJeO9ImscElDpY2jN3fTSj4y32U=;
        b=ZOpKDXdg16sEF+s5Muv9TudyeYoKjHeHJqKfGC6+hGLv6wcbGNMDGi5yT6L6kxbBw5
         oNukJq1nvQdOYDmtyqP7A4mlzz2L94EajDfixCmAlokg0cZv22KyvTJf0tKEacXbTj+p
         emUhTtcwEUJTngnbdwX9tQmbzlrIHK2CKUafLOO873A9eX6G6mdH39SLY1QBxr0FYiSC
         LYykftv8xspHcyFQyU4dMV8ZJma/uxDa44Q0ELm9PX3STKiBz2xI67+ejDSamGY6A3LS
         Es8rypGJoxmS8JUiimzPfjsZNm3VL/am1Cl5bD6rFIUGdw2Bg6CtyTiWVvtc3IYz+Lim
         1CRw==
X-Gm-Message-State: APjAAAUXe5Gvt+zsRPGROzA0sIw5gkNCLmLztcHAGUZPJWGTEuUuFYWN
        GMPQMD0QoJBoFKFkB5z8mV0HJc7N
X-Google-Smtp-Source: APXvYqxyZh+UjK4x0WMgy3frQUZXJ18F6shiNpJcJyS0EQkx8EMh1AS7oSHNf95niqFOL4p0WRcAUQ==
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr22973592lji.177.1582310551964;
        Fri, 21 Feb 2020 10:42:31 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id x29sm2386819lfg.45.2020.02.21.10.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 10:42:31 -0800 (PST)
Subject: Re: [PATCH v9 05/17] ARM: tegra: Propagate error from
 tegra_idle_lp2_last()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-6-digetx@gmail.com> <20200221151612.GJ10516@linaro.org>
 <1a8c81ab-6f6a-8221-6a4e-c080ba595836@gmail.com>
 <20200221174033.GV10516@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <535bff1a-cb38-a36e-4c8e-1e656618588e@gmail.com>
Date:   Fri, 21 Feb 2020 21:42:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200221174033.GV10516@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.02.2020 20:40, Daniel Lezcano пишет:
> On Fri, Feb 21, 2020 at 08:21:41PM +0300, Dmitry Osipenko wrote:
>> 21.02.2020 18:16, Daniel Lezcano пишет:
>>> On Thu, Feb 13, 2020 at 02:51:22AM +0300, Dmitry Osipenko wrote:
>>>> Technically cpu_suspend() may fail and it's never good to lose information
>>>> about failure. For example things like cpuidle core could correctly sample
>>>> idling time in the case of failure.
>>>>
>>>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>>>> Tested-by: Jasper Korten <jja2000@gmail.com>
>>>> Tested-by: David Heidelberg <david@ixit.cz>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>
>>> [ ... ]
>>>
>>>>  	cpu_cluster_pm_enter();
>>>>  	suspend_cpu_complex();
>>>>  
>>>> -	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
>>>> +	err = cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
>>>>  
>>>>  	/*
>>>>  	 * Resume L2 cache if it wasn't re-enabled early during resume,
>>>> @@ -208,6 +210,8 @@ void tegra_idle_lp2_last(void)
>>>>  
>>>>  	restore_cpu_complex();
>>>
>>> If the cpu_suspend fails, does restore_cpu_complex() need to be called ?
>>
>> Yes, because suspend_cpu_complex() didn't fail. I don't see any reason
>> why restore_cpu_complex() shouldn't be called, please clarify yours thought.
> 
> If the suspend fails, the power down does not happen, thus the logic is not
> lost and then it not necessary to restore something which has not been lost.
> 
> I don't know the hardware details, so that may be partially correct.

At quick glance, the restore_cpu_complex() is only used for restoring
the GIC's state on Tegra.

I don't think it's really worth the effort to handle
restore_cpu_complex() specially in a case of the error condition because
the chance that the error will ever happen is very small and restoring
the cluster's state won't cause any trouble in that case.

Let's keep this patch as-is for simplicity :)
