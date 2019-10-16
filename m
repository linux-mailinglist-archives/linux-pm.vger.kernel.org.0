Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 627AFD9271
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 15:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405334AbfJPN3Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 09:29:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34309 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730142AbfJPN3Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 09:29:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so24061140lja.1;
        Wed, 16 Oct 2019 06:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0zuQ6WlphP3GLKAO64VehzUGUxpcevfofxKNJyniNKY=;
        b=ip5/2yuI67JEFe/mVoBmH4WWKAZPlmVUJvh65wnYuCA4EcZZqWNujbRa5T6z94wnTo
         dt47qXlThCanJRW+YOoy6SjpIpmhBBEhi37X3zRWN5HuqH6QUbFskNiYOROl/7ikk+H4
         X7PoIsY0uWEOF8Bzv8Qt11UX99eQ2yQf3ioZ5LaTo4Kdt25bp5eD+zitb7Owk6sfXwwA
         YGCBwAvbT3EZvrjAT79dYkGM1UZ10cbYafDAKa0byZXEtWYUGsfCetcPdRDEDTK5VCai
         H4XZaX/y00MKZ2pd3r233U2qf659JVx0m1MhIQnBupPPaYFRZKbhTw6z/I671OL2D+MC
         fJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0zuQ6WlphP3GLKAO64VehzUGUxpcevfofxKNJyniNKY=;
        b=qymmdYDuonH82hJiHtzTApSA++brwN6do1GyfL+3oxNwBATN9Pnd7t3Vh70BDKaUwh
         DvF/Y0kDOq6hZ1cl3+wWWVd866b3PSu9CsYUY0do1Cn4N5WV9xxC8wJT1C8K+xdFj5/m
         8aT6b+GjSITuX4z9i0mQYcesLs3r6MazR9l6czpUtPDkNjHOCkHZzsGfTjqmi10jsT6t
         56ijsylOSzgB/LNLTzd5pxUYWjPdH5NWdJ2E0+duwW1tnxSidYZD92SG0o3fzQJ/rEV7
         VI21LqcC2XEKl4Fi2LDx17vwkmmpoyPT0ixLc984IJvLndQL1iuPlAoPWXLKr9h9szgN
         eHsw==
X-Gm-Message-State: APjAAAVZBQt3boC/T5vxb81GXEyLBqDgSC4BBlWZGcGVG7CXW6YOS5GS
        NypOJhy4FoIRnL5+qouHe5Gsa6MX
X-Google-Smtp-Source: APXvYqwlcIVCIDajACVzs0yXeLGMk4o/kTl6pSqxAdmgs6AzOAeh0m77uNfrHbodavkF4OBPNTAHzQ==
X-Received: by 2002:a2e:569a:: with SMTP id k26mr26062243lje.256.1571232562125;
        Wed, 16 Oct 2019 06:29:22 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id z8sm7740724lfg.18.2019.10.16.06.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 06:29:21 -0700 (PDT)
Subject: Re: [PATCH v1 07/17] cpufreq: tegra20: Use generic cpufreq-dt driver
 (Tegra30 supported now)
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191015211618.20758-1-digetx@gmail.com>
 <20191015211618.20758-8-digetx@gmail.com>
 <20191016051802.rrxv56vtvxfm6qqe@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <13a9ebd6-8dce-0217-d306-defb8eb6fb96@gmail.com>
Date:   Wed, 16 Oct 2019 16:29:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016051802.rrxv56vtvxfm6qqe@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.10.2019 08:18, Viresh Kumar пишет:
> On 16-10-19, 00:16, Dmitry Osipenko wrote:
>> Re-parenting to intermediate clock is supported now by the clock driver
>> and thus there is no need in a customized CPUFreq driver, all that code
>> is common for both Tegra20 and Tegra30. The available CPU freqs are now
>> specified in device-tree in a form of OPPs, all users should update their
>> device-trees.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/cpufreq/Kconfig.arm          |   4 +-
>>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>>  drivers/cpufreq/tegra20-cpufreq.c    | 236 ++++++---------------------
>>  3 files changed, 55 insertions(+), 187 deletions(-)
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index a905796f7f85..2118c45d0acd 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -301,8 +301,8 @@ config ARM_TANGO_CPUFREQ
>>  	default y
>>  
>>  config ARM_TEGRA20_CPUFREQ
>> -	tristate "Tegra20 CPUFreq support"
>> -	depends on ARCH_TEGRA
>> +	bool "Tegra20 CPUFreq support"
> 
> Google is currently working on the GKI (generic kernel image) project where they
> want to use a single kernel image with modules for all kind of android devices.
> And for that they need all such drivers to be built as module. Since this is
> already an module, I would ask you to keep it as is instead of moving it to bool
> here. Else some google guy will switch it back as module later on.
> 
> LGTM otherwise. Nice work. Thanks.
> 

Okay, I'll keep the modularity in v2.

Although, tegra20-cpufreq isn't a driver anymore because now it merely
prepares OPP table for the cpufreq-dt driver, which is really a one-shot
action that is enough to do during boot and thus modularity is a bit
redundant here.
