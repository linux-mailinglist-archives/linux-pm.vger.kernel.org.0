Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B57218A30
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 16:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgGHOcY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 10:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbgGHOcX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 10:32:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6182AC061A0B;
        Wed,  8 Jul 2020 07:32:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d17so39784019ljl.3;
        Wed, 08 Jul 2020 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3vo3v2gUpXTsGv9HEg+ZxcDhpelWM8yHjo5MmDXFQZc=;
        b=qIhzMq7mxzUvaH9wBVr+UUBjF0JKCJlkM6vOkH5X0BbxHxrCKIISLULQUJDKpuRMp6
         GD70gA4b6zwzYIsAjpbeBcPZAMduvxP36hYGdJRYFTlMrjZy4CfdXuPWylxN8vqbCFTi
         Tt9Ag6gRFWbQiITbWtIsQfETtnMvXOH6CdtSo8Ye1+Qs/I0kZpelXqxSZkv3PvWvXXz5
         OtrZtN8+/N8vUlYf/hMsYQmcITDZSFJZYzhTIIb46EzNQLjIAPk1dOVH0lynwC0qS1D7
         IdyXVmM8ir8yPP/s2tvEzVhcHxml7ioaEH6LwxGlWPoOElmIlzywiueaeMF7mwnGpjnu
         MliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3vo3v2gUpXTsGv9HEg+ZxcDhpelWM8yHjo5MmDXFQZc=;
        b=TPu2SZyeVm5sAs4O8jE5jlLy2HqOwVNuBgrdsCcKM0sVGvJ68T27QBBQU/pCFNh4OZ
         PdGwRDb3sSFy24HHSZeU/OcYlAlEA90Qwz6pCHkKsZsuNVUZxFubf/G6DAr/OBXRNDws
         EmRSaxyZAm/ScoZ3UxrmLXCzvtPofB611Q67M9/ZW0qVMw0ntFNO/3sPaX1dD6RbBNz7
         0E4225nxC4TJvkI9DRRdHLk5nprMhAc9ic8/N+3YzJ99gMa/awIHOS78xEw1Mzvbyr4Q
         umOx/ykmPqQNNXxt8hwINkm8C730+NqWlGnGu6/mXcq1VDE/rPapu6DhqP+5SGtDTKcw
         fjew==
X-Gm-Message-State: AOAM53237zjMxBb6cmZE6JnQCif6YeTDOkhN12EfWpVGdPm3JwR5VKwV
        1IjF342X61GoZhytErqpFwH2CGU2
X-Google-Smtp-Source: ABdhPJy+hGEaaPOPeYxQ3sg/bga9VsjGH3uNqo4EYXHLeyy18vPbGfJ2n877RCH26hoOmWkWRSceHg==
X-Received: by 2002:a2e:81d7:: with SMTP id s23mr32068685ljg.398.1594218741332;
        Wed, 08 Jul 2020 07:32:21 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.googlemail.com with ESMTPSA id n25sm960063lji.28.2020.07.08.07.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 07:32:19 -0700 (PDT)
Subject: Re: [PATCH v2] cpuidle: tegra: Correctly handle result of
 arm_cpuidle_simple_enter()
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20200702001354.27056-1-digetx@gmail.com>
 <4ffff3d8-2d41-3fb2-ed16-c9662d18d261@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3bc2064e-e94d-984c-edab-50b4dc2fd2dd@gmail.com>
Date:   Wed, 8 Jul 2020 17:32:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4ffff3d8-2d41-3fb2-ed16-c9662d18d261@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

08.07.2020 15:34, Jon Hunter пишет:
> 
> On 02/07/2020 01:13, Dmitry Osipenko wrote:
>> The enter() callback of CPUIDLE drivers returns index of the entered idle
>> state on success or a negative value on failure. The negative value could
>> any negative value, i.e. it doesn't necessarily needs to be a error code.
>> That's because CPUIDLE core only cares about the fact of failure and not
>> about the reason of the enter() failure.
>>
>> Like every other enter() callback, the arm_cpuidle_simple_enter() returns
>> the entered idle-index on success. Unlike some of other drivers, it never
>> fails. It happened that TEGRA_C1=index=err=0 in the code of cpuidle-tegra
>> driver, and thus, there is no problem for the cpuidle-tegra driver created
>> by the typo in the code which assumes that the arm_cpuidle_simple_enter()
>> returns a error code.
>>
>> The arm_cpuidle_simple_enter() also may return a -ENODEV error if CPU_IDLE
>> is disabled in a kernel's config, but all CPUIDLE drivers are disabled if
>> CPU_IDLE is disabled, including the cpuidle-tegra driver. So we can't ever
>> see the error code from arm_cpuidle_simple_enter() today.
>>
>> Of course the code may get some changes in the future and then the typo
>> may transform into a real bug, so let's correct the typo in the code by
>> making tegra_cpuidle_enter() to directly return the index returned by the
>> arm_cpuidle_simple_enter().
> 
> Are you suggesting that arm_cpuidle_simple_enter() could be updated to
> actually return an error? Sorry it is not clear to me what you are implying.

Hello, Jon!

Yes, I'm saying that *potentially* arm_cpuidle_simple_enter() could be
updated to actually return error.

The implication is that the current code is wrong and it may strike back
in the future if we won't fix it. Is this more clear? :)
