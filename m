Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E67421891
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 22:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbhJDUm6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 16:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbhJDUm6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 16:42:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F21AC061745;
        Mon,  4 Oct 2021 13:41:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i24so27357227lfj.13;
        Mon, 04 Oct 2021 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DTnf8eIYyTQrJG9ptKGfHykXnms5M5UwHTkWE902OpY=;
        b=EibEwA9aFwdr1rEgVN6jaFywzdYRyr37aiv7MJd/JCCLvfKu09dl3AOH08ooPOpEMD
         pnROaMjDgSrkmAdTG3upyfYpaTLQKKCYTPY39N3s8ABN1V1lkzLLF2tLizvj89uSY0hZ
         VoiBHw0liQEPSPe0dQOAt5k8dKQb48dMEnwnXGKfrPZPMNlG66TAfdNyQqd55NcnIvHI
         +G4YM/eKG5o74z8ORGQVZfYagky9IopnaFwwqdvAHW6prlIA7ghCCLkoiw9/fApkb9aY
         pV1PnoJQU7u+eSYft9JASxjKi0I4e37ha78uW6Lhf/8jFUD29GvPedXilaN+yOd4TK0a
         2Nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DTnf8eIYyTQrJG9ptKGfHykXnms5M5UwHTkWE902OpY=;
        b=MlOLmugXo1Gb84b1L9sIIF0V82stqhIgbiIcuRoJxdemM6Yqmmd7VJ8MGVDdMXHgl2
         oKyOuUsruhbONWvwkh5FC3wR8vKUzwJ2AHkXscUO1KltU2OpitKMsvGHkVR3R1S/fXkB
         7lohtzT+ErbZa3laFBrndVmCg30D1FqMpQ97Ycnc+OkC/JYTELwhh+bqDNJWgeJO3qe4
         ODxRaKjDmCaSFESZ5eaJY1KYezd7JOoEGjyTJPM8MGJ3bpheDoxNjt52T9+IJuOWsZnb
         IehHM25LvA8LypXWpMFhDlZmC+uiOmPCyRDqVYz37xXKNvjc0rSWrkMamw1qFX9Ur9qx
         gF6w==
X-Gm-Message-State: AOAM530iivV9Wfmv6Bz1vSbf4c075b5GTTd7oI29ASpwGYePApNTTD/M
        NIFg+PoyYd8ji+AG09lHFVY52PQZaYI=
X-Google-Smtp-Source: ABdhPJyYZWZoJYPQgCVFMWdiV7hO6uIH+Nr2GqSjeAvpZlHkQzzjEIDQxN83FkYL0aOQLPiSl10+lg==
X-Received: by 2002:a2e:92d5:: with SMTP id k21mr18201457ljh.83.1633380065416;
        Mon, 04 Oct 2021 13:41:05 -0700 (PDT)
Received: from [192.168.2.145] (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.googlemail.com with ESMTPSA id j27sm110347lfp.261.2021.10.04.13.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 13:41:05 -0700 (PDT)
Subject: Re: [PATCH v1 4/6] clk: tegra: Add stubs needed for compile testing
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210912202907.28471-1-digetx@gmail.com>
 <20210912202907.28471-5-digetx@gmail.com> <YVtXJVeK2qdy8E1q@orome.fritz.box>
 <YVtd67B0Ac+ChBEA@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fe54d967-4fd0-5129-2d15-b1271490306a@gmail.com>
Date:   Mon, 4 Oct 2021 23:41:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVtd67B0Ac+ChBEA@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.10.2021 23:02, Thierry Reding пишет:
> On Mon, Oct 04, 2021 at 09:33:57PM +0200, Thierry Reding wrote:
>> On Sun, Sep 12, 2021 at 11:29:05PM +0300, Dmitry Osipenko wrote:
>>> Add stubs needed for compile-testing of tegra-cpuidle driver.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  include/linux/clk/tegra.h | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
>>> index d128ad1570aa..9bd06d8a5436 100644
>>> --- a/include/linux/clk/tegra.h
>>> +++ b/include/linux/clk/tegra.h
>>> @@ -42,7 +42,11 @@ struct tegra_cpu_car_ops {
>>>  #endif
>>>  };
>>>  
>>> +#ifdef CONFIG_ARCH_TEGRA
>>>  extern struct tegra_cpu_car_ops *tegra_cpu_car_ops;
>>> +#else
>>> +static struct tegra_cpu_car_ops *tegra_cpu_car_ops __maybe_unused;
>>> +#endif
>>
>> Ugh... this one seems a bit over the top, to be honest. The only place
>> where this seems to be used is in arch/arm/mach-tegra/pm.c, but that
>> already uses one of the stubs from include/linux/clk/tegra.h, so I'm
>> wondering if we can't define that latter stub in a way to make it
>> unnecessary to declare this bogus pointer.
>>
>> I'll play around with this a little bit.
> 
> The below does the trick for me as well:
> 
> --- >8 ---
> diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
> index d128ad1570aa..d261db7e6060 100644
> --- a/include/linux/clk/tegra.h
> +++ b/include/linux/clk/tegra.h
> @@ -42,6 +42,7 @@ struct tegra_cpu_car_ops {
>  #endif
>  };
> 
> +#ifdef CONFIG_ARCH_TEGRA
>  extern struct tegra_cpu_car_ops *tegra_cpu_car_ops;
> 
>  static inline void tegra_wait_cpu_in_reset(u32 cpu)
> @@ -83,6 +84,27 @@ static inline void tegra_disable_cpu_clock(u32 cpu)
> 
>  	tegra_cpu_car_ops->disable_clock(cpu);
>  }
> +#else
> +static inline void tegra_wait_cpu_in_reset(u32 cpu)
> +{
> +}
> +
> +static inline void tegra_put_cpu_in_reset(u32 cpu)
> +{
> +}
> +
> +static inline void tegra_cpu_out_of_reset(u32 cpu)
> +{
> +}
> +
> +static inline void tegra_enable_cpu_clock(u32 cpu)
> +{
> +}
> +
> +static inline void tegra_disable_cpu_clock(u32 cpu)
> +{
> +}
> +#endif
> 
>  #ifdef CONFIG_PM_SLEEP
>  static inline bool tegra_cpu_rail_off_ready(void)
> --- >8 ---
> 
> Do you mind if I replace your version with that? I think that's a little
> bit cleaner because it should be easier for the compiler to completely
> compile it out.

I don't mind, please choose what you prefer more. This was one of the
first variants of this patch, it adds more lines and it won't be
compiled with ARCH_TEGRA=n and COMPILE_TEST=n anyways.
