Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276E32D1CED
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 23:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgLGWMC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 17:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGWMC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 17:12:02 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C5EC061749;
        Mon,  7 Dec 2020 14:11:21 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id h19so476115lfc.12;
        Mon, 07 Dec 2020 14:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6EwZVkyZDi8giolSpIEZVZKekJNvv34CCb0A7z+ogOo=;
        b=HHRSWZQViQ36MCqkFBdhwO5WZfuBerDebz8XYis8B/LNgFKFn2zXlsGa3gTscca12P
         Sk1cLU5iTaC3Ot6LInMNt9xDaBv0NdtLyoCcx5WvXlItb2zXrDUN/drRtvOI78V3IhaU
         V9HIVSRGLtcur4C3gWyIzH0d6ho6T7qTUnNMHiU96Oths/MkxyGMOM4IKPxE76zrSmQd
         rXz0O7YLQI5Lwl/Q6/bym18GTrERFgzA+iqUUNeMNi+O9aVtnEmpEe5P40jWpdAuFtaM
         vAZQvCGUGb3elZtjEfqRiGBDdAygx3UF+nQm58CgWxh0gW4Gqje2TM/DZXjxquKQom4m
         3FMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6EwZVkyZDi8giolSpIEZVZKekJNvv34CCb0A7z+ogOo=;
        b=Km+LIqcA7GqUFgr5gSRzcmiKMtHX8BN5GosJ0GHA9LcCtsWWkYGQPMVdYpUQG/D8YJ
         u1cKd3/exp7v08Q/BBvZi5VOL7out6V1gVMaeTSMMvPKxDQLmWcThRRIZyQm3as7OjOJ
         WtyDGiyQHdv/lMc82Wdi/W57WT4R4mWhkQTVILsrlfJwbrGxmgjkhrmhxQ77JjZdtcAF
         0fzNU99c59rE/urIwNkEteMZtGWN76rZIASOneQPzBQksAdx3cYxZeCIRlts+Yn5AnNK
         4pLM52VcM8vRbX1I+LqCHN2RLdn3xgNCLVC0XFEbus+vDRYuW+r+NpRKF8wboNqhXP1/
         NKJA==
X-Gm-Message-State: AOAM530zlZLqnyifCpK+1PN6XjS85CXT+SHCRltWml7Se7vud51gV2eE
        VAZt6RfkfAwwHk3gh2lU3K2ghOtAu/U=
X-Google-Smtp-Source: ABdhPJw+9jw+AR2uLqB2wed29KybJWtA5Z8pjqyAD8LWAYc2tJiLGiT58naimP05pyR1vLGlW03TAw==
X-Received: by 2002:a19:6d05:: with SMTP id i5mr8577181lfc.524.1607379080300;
        Mon, 07 Dec 2020 14:11:20 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-53.dynamic.spd-mgts.ru. [109.252.192.53])
        by smtp.googlemail.com with ESMTPSA id y23sm11226ljc.119.2020.12.07.14.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 14:11:19 -0800 (PST)
Subject: Re: [PATCH v11 00/10] Introduce memory interconnect for NVIDIA Tegra
 SoCs
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20201203192439.16177-1-digetx@gmail.com>
 <160717730565.9414.18193998919736710677.b4-ty@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2128b898-ee5f-fd71-77af-4a3d957088a5@gmail.com>
Date:   Tue, 8 Dec 2020 01:11:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <160717730565.9414.18193998919736710677.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

05.12.2020 17:09, Krzysztof Kozlowski пишет:
> On Thu, 3 Dec 2020 22:24:29 +0300, Dmitry Osipenko wrote:
>> This series brings initial support for memory interconnect to Tegra20,
>> Tegra30 and Tegra124 SoCs.
>>
>> For the starter only display controllers and devfreq devices are getting
>> interconnect API support, others could be supported later on. The display
>> controllers have the biggest demand for interconnect API right now because
>> dynamic memory frequency scaling can't be done safely without taking into
>> account bandwidth requirement from the displays. In particular this series
>> fixes distorted display output on T30 Ouya and T124 TK1 devices.
>>
>> [...]
> 
> Applied, thanks!
> 
> [01/10] dt-bindings: memory: tegra20: emc: Document opp-supported-hw property
> [02/10] memory: tegra20: Support hardware versioning and clean up OPP table initialization
> [03/10] memory: tegra30: Support interconnect framework
>         commit: 01a51facb74fb337ff9fe734caa85dd6e246ef48
> 
> Best regards,
> 

Awesome, thanks! Good to have the warning splat silenced.
