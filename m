Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93344397731
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 17:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhFAPxT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 11:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbhFAPxS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 11:53:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B497CC061574;
        Tue,  1 Jun 2021 08:51:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r5so22557351lfr.5;
        Tue, 01 Jun 2021 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=onn9keWb/5Q8h7P0USAwNaJ0t0PscCKrWQtmrQdUT8Q=;
        b=YQYgIWtmDRiNPQPiPtred3DvUbyBIZjo/kYv3X/GmB40n2V/6G4JCqIn0yWwef5vN7
         8k25LU5Awxaww/HKb171Ld/Pq764n/594z3PzRj4x88qNuDifgV81CkLPZYqOPlQOauJ
         D2iJaa5tGSuR43TsRpaACBXBGnhVoA3fmwcXske13VuybDT//P6wGqIbT0hEkAGqR1s0
         TTPIYgWyGHJ+5UKJJ1PjK7CYvy5WIAFatZKvEZkUA+lrS4did9zIwdHIWvKljtSCtQSx
         r9zILaZMGCq7S+tzqwk7WjWmfjdReOLpKivEGaJK5+4KRgDxJov560dyrZzQR/iNSqzF
         O3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=onn9keWb/5Q8h7P0USAwNaJ0t0PscCKrWQtmrQdUT8Q=;
        b=eM6P6sxNbkhajBEnl8ms7EcHrwKFQkJewkYBFMjzeo2Ywp9LycASCUcqtEAshtTJBX
         FrVe7/ss5x/IUGpdR+ReFZmWpq08ZwjjiVWcEBCtcbX+ATa4nT79to/Hqxku47Lvfdhj
         WULK3DMAI92e8B59yWtrc2A40C8Zu/BUOBpahGpoQHvYfVjybWL7ndAX4tzK4dMHLH9/
         OuhghcfWoZTvXtCXkGc/YkR8UQm/uPizrV3FysBEG2YjqiPYC0dsOUAuQreNFKacRBE4
         f1SgLVMGfSHOQw+n0RbW0H/BY1Mq79VlIg9DYLlOgUFEh+PmgxsJDCq4387iJr0PbliT
         R8Yg==
X-Gm-Message-State: AOAM532+tjxljrVbG/c4I25DJWuAVZmp2Nusapm1kaZ1Ru4LNqqPkAyX
        GC1wNujmttn9j0vMfXiPZwsqPDrk6l4=
X-Google-Smtp-Source: ABdhPJzWcGefIy4rlt9EkULr/wrcbgCFzxyFOCrxX+af3/DttDgPF+s9kSaWAbJ47C7QGDenlRZDrA==
X-Received: by 2002:a05:6512:a89:: with SMTP id m9mr18603701lfu.161.1622562694984;
        Tue, 01 Jun 2021 08:51:34 -0700 (PDT)
Received: from [192.168.2.145] (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.googlemail.com with ESMTPSA id c22sm2060757ljd.43.2021.06.01.08.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 08:51:34 -0700 (PDT)
Subject: Re: [PATCH v6 00/14] NVIDIA Tegra memory and power management changes
 for 5.14
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=c4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
References: <20210601023119.22044-1-digetx@gmail.com>
 <YLYZvFPyJFJgxI56@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <11206c96-9f56-ca6f-e5e3-658534356666@gmail.com>
Date:   Tue, 1 Jun 2021 18:51:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLYZvFPyJFJgxI56@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.06.2021 14:27, Thierry Reding пишет:
> On Tue, Jun 01, 2021 at 05:31:05AM +0300, Dmitry Osipenko wrote:
>> This series:
>>
>>   1. Adds CPU/core voltage bump before system is rebooted.
>>   2. Adds new devm_tegra_core_dev_init_opp_table() helper and switches
>>      Tegra memory drivers to use it.
>>   3. Adds compile-testing support to the Tegra memory drivers.
>>   4. Adds Tegra SoC core power domain support.
>>
>> Changelog:
>>
>> v6: - Fixed another compile-test trouble reported for v5. I double checked
>>       the clk stubs this time and compiled them locally.
> 
> Heh... I just fixed those locally on top of your v5. Let me see if I can
> roll back the changes and apply this new set instead.

Thank you! You probably saw already that Ulf Hansson suggested to remove
the lockdep annotation for now from the core PD, I'll make a v7 with
this small change.
