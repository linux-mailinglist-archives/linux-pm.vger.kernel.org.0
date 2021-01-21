Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD32FF5EF
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 21:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbhAUUbJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 15:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbhAUUa7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 15:30:59 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B502BC061756;
        Thu, 21 Jan 2021 12:30:18 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id p13so4045112ljg.2;
        Thu, 21 Jan 2021 12:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ncuN3q0XceaY9ggh+tm+Ev293jqoGIYd3EDFC0agv+8=;
        b=XKOVOxiUz0nhvScW7IxyHz0YePIUkKrlgc8yTRNnxKU7b9obsPM8lSpM9UV2M5wWgB
         jW/d6aHo5RBFHKBQ6k18BqhECvfj5DHZfYylFSVYjjq2jsRKE8+soUseHzMMPPuR/Fa5
         JRhbqmFg0doLwx9RMuEW83DxCXCxQyOg9t8WY0YlRtIczW3sZzh82rlfHL5Z75BSjx8v
         FnbtDzi6//UEdBOcgIoIKubcTSUbNYuQw5Bt7ROdHwMD6Alv0e2RSLb77LG0oCfwupeW
         sVLXPjvUpVwgD5LdsB3S7hoNhZW8ayaeQ1IUuBiH6ECMnreKZbrqmKocfkziS5Y7VAoR
         eBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ncuN3q0XceaY9ggh+tm+Ev293jqoGIYd3EDFC0agv+8=;
        b=eoyQIcoD2EMhEdtNSGjLz/kZnnORobLoaJldh5vnhIF+YQ2ERIvrwJcByYTqppu6ck
         zcxZHkKGcLjFQUsgFo07tPkwCJ+c+kjySSGovBfmhBEL/zRzj3f3GRw0r/xG0jvhImRm
         d5VH1aRD784R2KCpRwd428ylAhE1+M4oTGgJf4dkwq2cf3JjyT46zlNl/FZyx0/maNZy
         hjyK4eyi38Ej9dhdxGLlc92ipqpDPETD3pX2+WPtFB3YMw+HYv4bCpm4BC4YpnlMwAKN
         a++D7ztTzngHaqY2X1247Q+TJAvgo18EYbUs6k6qvha24fb9ti4QAflsj9IILpBFIgZ8
         yTLQ==
X-Gm-Message-State: AOAM530hBjaEgFwjoBrB0OYnht6C8RGoBv1ObvEdv/vI09HQK8O0pztx
        1NQB8d3LQR85Cudxzd1/Ani8Vuv91sY=
X-Google-Smtp-Source: ABdhPJwN+PZ9d/L2w8lMmJHhfLFI97i3sl8f4xDaTJlSWgaKtMjcewJXaLzcqzcBSbLAsHUIxMNAdA==
X-Received: by 2002:a2e:2a46:: with SMTP id q67mr520802ljq.331.1611261016997;
        Thu, 21 Jan 2021 12:30:16 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id e9sm631312lfc.253.2021.01.21.12.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 12:30:16 -0800 (PST)
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
 <1d17901f-6341-d278-f517-33d9c7aadf42@gmail.com>
 <af1044be-263e-0aa2-7061-0b217f94197b@gmail.com>
 <20210121075112.jspo3klaewev6ger@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <54f2e75e-71f0-3a87-292b-75e540efcf65@gmail.com>
Date:   Thu, 21 Jan 2021 23:30:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210121075112.jspo3klaewev6ger@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.01.2021 10:51, Viresh Kumar пишет:
> On 20-01-21, 18:41, Dmitry Osipenko wrote:
>> 19.01.2021 20:35, Dmitry Osipenko пишет:
>>> 18.01.2021 14:46, Viresh Kumar пишет:
>>>> On 18-01-21, 03:55, Dmitry Osipenko wrote:
>>>>> Hi,
>>>>>
>>>>> This series fixes problems and adds features to OPP API that are required
>>>>> for implementation of a power domain driver for NVIDIA Tegra SoCs.
>>>>>
>>>>> It is a continuation of [1], where Viresh Kumar asked to factor OPP
>>>>> patches into a separate series. I factored out the patches into this
>>>>> series, addressed the previous review comments and re-based patches
>>>>> on top of [2], which replaced some of my patches that added resource-managed
>>>>> helpers.
>>>>>
>>>>> [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130
>>>>> [2] https://lore.kernel.org/linux-pm/20210101165507.19486-1-tiny.windzz@gmail.com/
>>>>
>>>> Hi Dmitry,
>>>>
>>>> I have applied 9 out of 12 patches already. Thanks.
>>>>
>>>
>>> Thanks, I checked that everything is applied properly using today's
>>> linux-next.
>>>
>>
>> Turned out that one minor issue was actually introduced, the
>> devm_pm_opp_attach_genpd() lost the export. I'll make a patch to fix this.
> 
> I have fixed the original patch for that.
> 

Okay, thank you.
