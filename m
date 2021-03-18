Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F609340328
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 11:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCRK1q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 06:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhCRK10 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 06:27:26 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C4AC06174A;
        Thu, 18 Mar 2021 03:27:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q13so3713102lfu.8;
        Thu, 18 Mar 2021 03:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+G5VKNAaAyEgyOk4kXK4F5H9gvSmpSo6KZM19Tya+Lk=;
        b=aD929HKe7uY3AZfVyxFMPdWuC9U1T//tmhP7QxvkO0F6yRCI8jfaNPIq7lGNlaqTTO
         h2nUkumC4xFTgxZ91CfUFlbj7iJPaoKpYPX2fcrKhQooiZ2PLqL9++9Z1d9ODETuCovr
         iTB4nqgkXPsOnRMd4QnhwwXuzQFo0A4G9urpIxGtCXF/H8HtRpBXzKsLOPUF1LYGbVqa
         4MXvsYdlq+A2q2AMx74KA4apsgOta8eg2mgdZAInKYg78VekJNaV2OSRZUL10TYFRGAq
         PI1hbT/CkLdT1qxvrw+St0YQsP5BJGcnObVt/OYbHwSMtrO/iiVwo9jtdwXLcMW6GOvG
         Gh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+G5VKNAaAyEgyOk4kXK4F5H9gvSmpSo6KZM19Tya+Lk=;
        b=oFXi9j9pOZL/fauobyg7IgF4M5POUExmFxlEbKYaTjyfM+ef6I6ohFdUkFZyMb2C7u
         Tka3oNPCf5+rAbATZgPU4ZIZJhcVNQaCKLTLSEb0MbkRGxUnmZ9t622lKRs48Do+5HIy
         rOvWQz3lSOMc0eqiQW3G26AtIGzis2KnWtLk4KLwAopEOZtiFTCpXa85s27t0dxAZQSm
         MgUtQAZdx2Ks2heXBT92lwEPCg8Wf8RblHkl+MeIwW8dmchgQdMEuVueBN3jL5Lf0T0N
         wQwuAjwj+3NCqtYBvjpOQW5kTipaC1InUcHfx+1T+VT6qdTklIjypkIyxEs35jdBmbeE
         cV4g==
X-Gm-Message-State: AOAM5332WyI91BdT3kQD1bpy49bFqSFrkCU5mlP5gCmOrRp8kfq3nDqo
        AVHFWRwe6JGejv80nVuy4ArZeVYjpOE=
X-Google-Smtp-Source: ABdhPJy9yoZ8KvENtEhAIDIIhdTp1HL+oReVacHd00IDhBi0w5ioO6SGToZwLeOBVyylCE4ZAfUo/Q==
X-Received: by 2002:a05:6512:1094:: with SMTP id j20mr5223574lfg.442.1616063243556;
        Thu, 18 Mar 2021 03:27:23 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id e18sm184915ljl.92.2021.03.18.03.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 03:27:22 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] soc/tegra: Add
 devm_tegra_core_dev_init_opp_table()
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Fertser <fercerpav@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210314164810.26317-1-digetx@gmail.com>
 <20210314164810.26317-2-digetx@gmail.com>
Message-ID: <8f78a014-eeab-d788-7d3b-b52b8109cb2c@gmail.com>
Date:   Thu, 18 Mar 2021 13:27:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210314164810.26317-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.03.2021 19:48, Dmitry Osipenko пишет:
> Add common helper which initializes OPP table for Tegra SoC core devices.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/soc/tegra/common.c | 137 +++++++++++++++++++++++++++++++++++++
>  include/soc/tegra/common.h |  30 ++++++++
>  2 files changed, 167 insertions(+)

Viresh, do you think it will be possible to take this patch via the OPP
tree along with the devres patches if Thierry will give an ack? This
will allow us to start adding power management support to Tegra drivers
once 5.13 will be released.
