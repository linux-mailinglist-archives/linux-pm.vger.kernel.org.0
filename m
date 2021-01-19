Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143832FBDCD
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 18:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390864AbhASRge (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 12:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390678AbhASRgO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 12:36:14 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B992C061573;
        Tue, 19 Jan 2021 09:35:34 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b26so30250867lff.9;
        Tue, 19 Jan 2021 09:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gMgwlQyoUBPXZTnesEHGejV06vBVQO6z3YHE6lnNlA8=;
        b=m+odlVeeIwd/iWZY8EUBSSPZ50JljTtjRALJNl0uHJMiKBXYWqjk4lJ6bFvC7AGKpE
         v0VEwo2A6coM1VA8JK2EHOGtkV3IHKEcS1wn80qXqyPMNdrZ4bE/BVSyLbcxH9StLAfp
         pvdTLnBHUiIJeXCknyBw7jsOGAI785JXb80ogKdmck8sKGe1//yzh/KxkmYmgxx2fCWN
         UtaQfCRWmq4fW9RAHebWgJ8cSQjMHJsKNUozQGppsS9vMP6vLtcZwIZ32ou0MBOjfDqk
         Tnaej0vhE6USsm+HD2b7DKIaECKqr6xMolVX/VKcD94bEq6kKtIyhLMcHPb+fk9XjtUK
         MJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gMgwlQyoUBPXZTnesEHGejV06vBVQO6z3YHE6lnNlA8=;
        b=BrmrovHAMrS8cjXZ8Fh2tUf4vAm8skvZCCGaKAcCCwpp3g8IR44qbpzsgbV8V5tdHa
         vxTh2Pcn6I0aUMOfBwTjpFcKgodiaQoji/BfFMFzoHP2M73hPLbvNH3zUvGionNX3z4P
         8HTOlCqkHYVflXMN6CE594basEPofZZMy+JH4rM1M/agKkMT8Vs1nXiuD9xNDXGxyy6g
         sg2lrHIZHp2CUqaaQCBhc2fuaUbWbSvDeWKceMcAt7SYz7eJaYgDQVhGdTwiqCWhoeBO
         4siRlVhlRqbPfnVzl+nIwunjKqDTNf1JZ85yGvSKS1HvewAGFbhsK103cl56sC5yVtAn
         PJfg==
X-Gm-Message-State: AOAM532nOw19k4VC462to9NpIF8hBPjE+n8TO3+xGMG1MIg4bVO97o4G
        VQm1n+9g764Z4LrqfU5kPxEN2bsx7Wo=
X-Google-Smtp-Source: ABdhPJypJleEMjoXlixlan9dKgAjCS8aG2pk0Q8rneBgP9GZa6qxN8L9BOUsK7BSpV2xNESqpMFvUA==
X-Received: by 2002:a05:6512:368d:: with SMTP id d13mr2162278lfs.414.1611077732803;
        Tue, 19 Jan 2021 09:35:32 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id f5sm2031874lft.218.2021.01.19.09.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 09:35:32 -0800 (PST)
Subject: Re: [PATCH v3 00/12] OPP API fixes and improvements
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118114613.fzq7nkrdfm53upkr@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1d17901f-6341-d278-f517-33d9c7aadf42@gmail.com>
Date:   Tue, 19 Jan 2021 20:35:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210118114613.fzq7nkrdfm53upkr@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.01.2021 14:46, Viresh Kumar пишет:
> On 18-01-21, 03:55, Dmitry Osipenko wrote:
>> Hi,
>>
>> This series fixes problems and adds features to OPP API that are required
>> for implementation of a power domain driver for NVIDIA Tegra SoCs.
>>
>> It is a continuation of [1], where Viresh Kumar asked to factor OPP
>> patches into a separate series. I factored out the patches into this
>> series, addressed the previous review comments and re-based patches
>> on top of [2], which replaced some of my patches that added resource-managed
>> helpers.
>>
>> [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130
>> [2] https://lore.kernel.org/linux-pm/20210101165507.19486-1-tiny.windzz@gmail.com/
> 
> Hi Dmitry,
> 
> I have applied 9 out of 12 patches already. Thanks.
> 

Thanks, I checked that everything is applied properly using today's
linux-next.
