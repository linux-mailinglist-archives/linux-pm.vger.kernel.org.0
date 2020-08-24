Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E91A2501E9
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgHXQXA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 12:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgHXQW6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 12:22:58 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA7EC061573;
        Mon, 24 Aug 2020 09:22:57 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j15so4798901lfg.7;
        Mon, 24 Aug 2020 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8SE2/PBYTcg3YOOGVssHW9UdXmQ9vzkd0F1vzB4ywX0=;
        b=DnnoeX87A92PXfQdNg94MVeLYDAT3zqKbPKbpHGZ1FuIrV4WzlqZVzOGNoozEFsnm2
         ED75DE/5XDhnG8rdvn8Y9kpCziRwd2N/G2dHYzq/Nur0sJjLIUylqrUTHpxvMl7rULpA
         /EnnRVAkUjgDcN+ScF3wR9jW3sHUo9427B+u1CUUOHA2/ftPWIaANvFn6e7MzCWfOHwH
         dg509aUThMclSy+TaAsfT637zjnXrzrwCQPkOAvmO5/dkoeD2R0ODp6UVP+FJlm2FHt6
         EXNPImxGFft5HjcMQKDlJl7R2NTj8A4NUaJHuayayTS/2nL0PgY9nkRMfrFiL3CeWxyM
         5z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8SE2/PBYTcg3YOOGVssHW9UdXmQ9vzkd0F1vzB4ywX0=;
        b=K6ACY7ECnuXQ4he1L3IFQL9XNncFHLU1VNSjXgK3ch5DHXT10SqL2Gt6FAYGrOP1Jt
         q8RVzmy00NaPbhtZkFnSVP96hY9XPY3IAga3ik8K4XPToOPiG8tmCadvP2wlNIFixKpU
         jOwJDAVTHe+5/5YMX0xLkUw4WzAcz91dCAtVOeeFp1/tpmPO8Phtor9gdvW23pK/0oDx
         Iv63rpfjDmcw5xsZj5+MJY0dvi0kUfPTVSPvExjy5F4a5EwLiaGolF9I6w51EDOWTHtW
         EErPVKhKhqUt9QLYPi4WJLHANneuaYlIdoa0EdzzQaF/9qawj/+mhmUogmlhQPktQI1f
         6Siw==
X-Gm-Message-State: AOAM531X1AzaU+ejJarsgsBh522rh7Re29pZSqHyn44gRFO7kyVw2xsF
        C/tDndDirGETkWfKx5/9IPFD+dBjMbg=
X-Google-Smtp-Source: ABdhPJyTB7OeM6e/0yyqMX24QqKUrWykp5KkGVjiypWExtGCjYMNFSGGdklt4RHFZ6A/jaA4ghujbw==
X-Received: by 2002:a19:ae0a:: with SMTP id f10mr2935544lfc.100.1598286171416;
        Mon, 24 Aug 2020 09:22:51 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id u17sm2272041ljk.56.2020.08.24.09.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 09:22:50 -0700 (PDT)
Subject: Re: [PATCH v3] cpuidle: tegra: Correctly handle result of
 arm_cpuidle_simple_enter()
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20200709173532.15431-1-digetx@gmail.com>
 <69c57c9c-a8e4-2367-3f72-232b6b3456b8@gmail.com>
 <c7e79586-f948-3681-6046-a51852ab2523@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <988cf17e-c824-cd6c-f682-084aab97afc1@gmail.com>
Date:   Mon, 24 Aug 2020 19:22:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c7e79586-f948-3681-6046-a51852ab2523@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.08.2020 19:02, Jon Hunter пишет:
> 
> On 14/08/2020 18:53, Dmitry Osipenko wrote:
>> 09.07.2020 20:35, Dmitry Osipenko пишет:
>>> The enter() callback of CPUIDLE drivers returns index of the entered idle
>>> state on success or a negative value on failure. The negative value could
>>> any negative value, i.e. it doesn't necessarily needs to be a error code.
>>> That's because CPUIDLE core only cares about the fact of failure and not
>>> about the reason of the enter() failure.
>>>
>>> Like every other enter() callback, the arm_cpuidle_simple_enter() returns
>>> the entered idle-index on success. Unlike some of other drivers, it never
>>> fails. It happened that TEGRA_C1=index=err=0 in the code of cpuidle-tegra
>>> driver, and thus, there is no problem for the cpuidle-tegra driver created
>>> by the typo in the code which assumes that the arm_cpuidle_simple_enter()
>>> returns a error code.
>>>
>>> The arm_cpuidle_simple_enter() also may return a -ENODEV error if CPU_IDLE
>>> is disabled in a kernel's config, but all CPUIDLE drivers are disabled if
>>> CPU_IDLE is disabled, including the cpuidle-tegra driver. So we can't ever
>>> see the error code from arm_cpuidle_simple_enter() today.
>>>
>>> Of course the code may get some changes in the future and then the
>>> typo may transform into a real bug, so let's correct the typo! The
>>> tegra_cpuidle_state_enter() is now changed to make it return the entered
>>> idle-index on success and negative error code on fail, which puts it on
>>> par with the arm_cpuidle_simple_enter(), making code consistent in regards
>>> to the error handling.
>>>
>>> This patch fixes a minor typo in the code, it doesn't fix any bugs.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>
>>> Changelog:
>>>
>>> v3: The tegra_cpuidle_state_enter() now returns entered idle-index on
>>>     success instead of 0. Hence the error message will be shown by the
>>>     tegra-cpuidle driver if arm_cpuidle_simple_enter() will ever fail.
>>>     Again thanks to Jon Hunter!
>>
>> Hello, Jon! Do you see anything else that could be improved in this patch?
>>
> 
> Sorry for the delay. Looks good to me ...
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

No problems, thank you! :)

