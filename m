Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB81326D0A7
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 03:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIQBdF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 21:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgIQBdC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 21:33:02 -0400
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 21:33:01 EDT
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D320C06174A;
        Wed, 16 Sep 2020 18:23:44 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y2so291351lfy.10;
        Wed, 16 Sep 2020 18:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SNRBUgdDJ66c/cIrFoeyrf3MChph3aCHEg6mfhVZH1Y=;
        b=vdEpI53pty0UB/DyefVgZFKVqgHMNz1MPHdHrxJl3bYP74MB8/51rwIwVZjyR3IYw7
         UAb3j0NEbc4rUUiHxf+ScAtsLoZ9MWXsxWBtwSxCOkz2Zbtcfu0h0rmtIE0T5goLJqzv
         1it7YMR1CfW4x4StkOmWrf3PIB3YvDkeDxWUSfelWSyDjo0OnZkLT5LHmbIKJEsKyac9
         rJBZL9rkS137zBwRrcpOnj5SDwdwTRUPoEvkCIzQwIO9DyCE7Jl5lgPPxQ7zIhobejgx
         tVGQco6bjYHwUocjUR37dfGfseC2wejgUgWyZCmuCSOtthlM0VeFzRriCrqdjxKnAdEx
         CsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SNRBUgdDJ66c/cIrFoeyrf3MChph3aCHEg6mfhVZH1Y=;
        b=lo8786j09TUS6VdZymkI48A4LXBjhEF9zR6QgusL0j+w/1ABr1NACoh4KCPs+iiJCj
         E69eeWP8TEpHhD6lWB7MpSuSWnQ48up4Zx+G3haOiyfkeQ8+Yq+B4Onw20cM7CxO+t/i
         SZA89/LLSHbP6tzUZT/IuoFbu4VxeKm3E0/zi0RJ459wMv2midg1NOQ/lzIiFrk2UmVw
         rW0s3TEZS8FlW3qbEONsDDAQe4xIEdjKdi5ao/BdFLaJc/E/G2raD1ZZ6oqC2G3xLXVh
         VNkOq9cj5n9q15zP01Pe102nGO2WYXnDqqMaiS3fom9i8eyiP3YrtDVr31jMPj2qIpFU
         ygFA==
X-Gm-Message-State: AOAM5305tmcZqxtHMGj3dxKzJKRbf9ywl7xYtJUYgu0TMlZLnQH6T6O1
        cbPgEIS7TmnQamPVUXvqEznJjhcLw9k=
X-Google-Smtp-Source: ABdhPJzy+GyEnZ6IPeDl5hhfSVnb8+c8ni/NDnmd8Xq/5Eh/Ew2Z35eyw4ECrDh9l51vumU38IFJ+g==
X-Received: by 2002:a19:520c:: with SMTP id m12mr6984964lfb.166.1600305821645;
        Wed, 16 Sep 2020 18:23:41 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id 71sm5277034lfb.73.2020.09.16.18.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 18:23:41 -0700 (PDT)
Subject: Re: [PATCH RESEND v4] cpuidle: tegra: Correctly handle result of
 arm_cpuidle_simple_enter()
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20200831083832.17889-1-digetx@gmail.com>
Message-ID: <ed6583ff-dcf4-b60c-b9e4-b3bb43f98a10@gmail.com>
Date:   Thu, 17 Sep 2020 04:23:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831083832.17889-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

31.08.2020 11:38, Dmitry Osipenko пишет:
> The enter() callback of CPUIDLE drivers returns index of the entered idle
> state on success or a negative value on failure. The negative value could
> any negative value, i.e. it doesn't necessarily needs to be a error code.
> That's because CPUIDLE core only cares about the fact of failure and not
> about the reason of the enter() failure.
> 
> Like every other enter() callback, the arm_cpuidle_simple_enter() returns
> the entered idle-index on success. Unlike some of other drivers, it never
> fails. It happened that TEGRA_C1=index=err=0 in the code of cpuidle-tegra
> driver, and thus, there is no problem for the cpuidle-tegra driver created
> by the typo in the code which assumes that the arm_cpuidle_simple_enter()
> returns a error code.
> 
> The arm_cpuidle_simple_enter() also may return a -ENODEV error if CPU_IDLE
> is disabled in a kernel's config, but all CPUIDLE drivers are disabled if
> CPU_IDLE is disabled, including the cpuidle-tegra driver. So we can't ever
> see the error code from arm_cpuidle_simple_enter() today.
> 
> Of course the code may get some changes in the future and then the
> typo may transform into a real bug, so let's correct the typo! The
> tegra_cpuidle_state_enter() is now changed to make it return the entered
> idle-index on success and negative error code on fail, which puts it on
> par with the arm_cpuidle_simple_enter(), making code consistent in regards
> to the error handling.
> 
> This patch fixes a minor typo in the code, it doesn't fix any bugs.
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Hello, Daniel!

Pinging you just in a case if this patch slipped away from you :)
