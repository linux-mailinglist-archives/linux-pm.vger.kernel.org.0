Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B1C2FD6AD
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 18:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbhATPql (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 10:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbhATPm0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 10:42:26 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEC8C0613C1;
        Wed, 20 Jan 2021 07:41:46 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id f17so26568807ljg.12;
        Wed, 20 Jan 2021 07:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9sJ1ScRq8N/XaLEQifnGC6kRifQqptOQ2pXix1nlQlY=;
        b=Uajiq292D24xViZSilHw5Nw54/tYtaDcIPIzm0DmQ1axRpfxwauVk6W3xes7SPa8ME
         /Qdm+mMXRCwcadGLIWF8ocpHiR24QX5YLae+1HzZwWnKQztag6cmwfKZbONjTi7Ga3fH
         q5RP5Oy90ofLvcDP3vqOxS3TLOGic5cXgVIogUXp/KQrop3QNZIJet0XLVPeu7nD0TbD
         D+ebXCuRzp1A3rlGZmbgc0KU7yLtuJ1A2G4F+M+6jSzOBqkP+P2AsM9JXL7BD78B91O5
         3ehukk8m/3jWoqMe0tB+VjLGd8sIfjaBrGBx8TIMWxIBRBQ+H7AxMJCw1RextufG0Hc2
         rRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9sJ1ScRq8N/XaLEQifnGC6kRifQqptOQ2pXix1nlQlY=;
        b=J5Tl1owmaH5flvbn/Xed5ltELFrv2dEaRrFAuIY/+FXglX8Dxa/jBMwwW19WbJZcO6
         T0yfFeFL76FmMXNx9m5LoiapzJSS3FPi06Hfs+0+tvlGx+E4RJdQRIll79LuY+2vJkwe
         AtsCDWPrs4Ahff9f972DU8Igq8F7iv5UpI/C5QGvgZU4zUlyFY935GNY7iNkkoyiUP8D
         1SwrjCFZyrvZ7KQt7gE2GP/E3ynVZdZg61i+RNeho5K2S0MAacMQFa29BQlRC1X6mtT9
         GnZrMi/3/6m0G21k0vhjSyxNumxwNNvmNOYH4LmCmvVfX9ZE0LEJyv302s/aW0EeQc3Q
         IpZA==
X-Gm-Message-State: AOAM531RQiq94fBGiowe8DfQybf/jdqF3WYDb0hMd/ufMjdGZhD4g9z3
        kHeCAz4KloA66Q7Qep2Dx1YVpRGPBZE=
X-Google-Smtp-Source: ABdhPJwS4Qe/V4DTqXpHPpVFyBynrwBLREgqIfYmzBAewWBaQBUksbpctc33wZx6P9VYWEGo5ma19g==
X-Received: by 2002:a2e:b4cd:: with SMTP id r13mr1564048ljm.273.1611157304363;
        Wed, 20 Jan 2021 07:41:44 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id 29sm229492lfr.304.2021.01.20.07.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:41:43 -0800 (PST)
Subject: Re: [PATCH v3 00/12] OPP API fixes and improvements
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <1d17901f-6341-d278-f517-33d9c7aadf42@gmail.com>
Message-ID: <af1044be-263e-0aa2-7061-0b217f94197b@gmail.com>
Date:   Wed, 20 Jan 2021 18:41:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <1d17901f-6341-d278-f517-33d9c7aadf42@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.01.2021 20:35, Dmitry Osipenko пишет:
> 18.01.2021 14:46, Viresh Kumar пишет:
>> On 18-01-21, 03:55, Dmitry Osipenko wrote:
>>> Hi,
>>>
>>> This series fixes problems and adds features to OPP API that are required
>>> for implementation of a power domain driver for NVIDIA Tegra SoCs.
>>>
>>> It is a continuation of [1], where Viresh Kumar asked to factor OPP
>>> patches into a separate series. I factored out the patches into this
>>> series, addressed the previous review comments and re-based patches
>>> on top of [2], which replaced some of my patches that added resource-managed
>>> helpers.
>>>
>>> [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130
>>> [2] https://lore.kernel.org/linux-pm/20210101165507.19486-1-tiny.windzz@gmail.com/
>>
>> Hi Dmitry,
>>
>> I have applied 9 out of 12 patches already. Thanks.
>>
> 
> Thanks, I checked that everything is applied properly using today's
> linux-next.
> 

Turned out that one minor issue was actually introduced, the
devm_pm_opp_attach_genpd() lost the export. I'll make a patch to fix this.
