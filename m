Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F0711E48C
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2019 14:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLMN1w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Dec 2019 08:27:52 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39893 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfLMN1v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2019 08:27:51 -0500
Received: by mail-lf1-f68.google.com with SMTP id y1so1953827lfb.6;
        Fri, 13 Dec 2019 05:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3a5X/HsBz/Jc1tMHJpbmDEO9eAeGDYj6GdIi3XHqmgk=;
        b=UDTr9nd5YdTb0v4Cj17QdUNasXorhaf3wFgqaZW+mh5qHk9tgTFVfXJT3QqZ8MIpvH
         NXrAFiKT68JxWuNnIA8IIhJnY7IzP/mqtAac+7QkKHZn9Lq2MatgeODHqxVT8wRzBf8X
         BTbQ+1JjFqPAuOCOxaM1SIWCiadtPhAh/mL8CBZF9dEP4iKqO4i1aEB71Hg5xEXWJNVL
         U7I02pje8D8nu0w09x5OxgiF3FQTxuMy0pb+5B1x9/VLA0I57ZgxX/RMGrnlSuTmtQvD
         DAxtqUoNakVHTLZkYfajb/4DJJbmIlSUifZCZV0UJb1rj0qEiCqUKiA0IxE8s8BPvs7P
         74Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3a5X/HsBz/Jc1tMHJpbmDEO9eAeGDYj6GdIi3XHqmgk=;
        b=YtZj4dp+J0YPfl+CSLp9LLkKCh8mjqwydIvN9bLDQYUC7fP42RBoKjtwukeeuDPNb2
         mOYhyGp76vGdkNvCKN4iYo0ky8KYH4s5epLOJhYlkIuPsN5KARt44eK1/3UKPyclRCb0
         hpe71YzI7HNiJWjjabUF66Dos9a6WZ20BMeVW30JF0gt0XdcnuxIPYqYbn18eJG5lig2
         +RP3x0GItlCgmN3o/cTkNDItZtczbhIgRWcLCdMxrqXH4Zjx6lg8UOgdU+8rPZRcCqUo
         WpIDduxAe+jJwxJFIK9hurcAwIoI5z/l/U19coatG3iYGoKyemxAc1gA/v8t0S7qKMTW
         yjIQ==
X-Gm-Message-State: APjAAAV3Ekm4EjCe24191+mjtaGXiNri+HOT88M4e+Yh5D8bwaCL3Ihb
        QC0pYAsHPmZfduix3tuTpdWoOJWH
X-Google-Smtp-Source: APXvYqzdJxJTo1vC8tE/6X67cFm/2BzOhMPwQfT4615iB1t6JDsbDMiKJl5e+NhYNhJGVufp+Zj/Fw==
X-Received: by 2002:a19:4ac2:: with SMTP id x185mr2761270lfa.131.1576243669708;
        Fri, 13 Dec 2019 05:27:49 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 2sm4774272ljq.38.2019.12.13.05.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 05:27:48 -0800 (PST)
Subject: Re: [PATCH v5 07/11] cpufreq: dt-platdev: Blacklist NVIDIA Tegra20
 and Tegra30 SoCs
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191118164512.8676-1-digetx@gmail.com>
 <20191118164512.8676-8-digetx@gmail.com>
 <2776e3c7-999e-5e6f-3a0e-211226dc30e6@gmail.com>
Message-ID: <aee736a0-444c-3d1a-1e51-c5b5259eb1b5@gmail.com>
Date:   Fri, 13 Dec 2019 16:27:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <2776e3c7-999e-5e6f-3a0e-211226dc30e6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.11.2019 19:51, Dmitry Osipenko пишет:
> 18.11.2019 19:45, Dmitry Osipenko пишет:
>> Both NVIDIA Tegra20 and Tegra30 SoCs should be blacklisted because CPU
>> OPPs use supported_hw and thus platdev isn't suitable for these SoCs.
>> Currently cpufreq-dt driver produces a bit annoying warning splats
>> during boot because valid OPPs are not found, this will be fixed once
>> tegra20-cpufreq driver will be update to support cpufreq-dt. The warnings
>> will also happen on older stable kernels using newer device-trees, thus
>> this patch should be backported to stable kernels as well.
>>
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>> Fixes: 4053aa65c517 ("ARM: tegra: cardhu-a04: Add CPU Operating Performance Points")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
>> index f1d170dcf4d3..aba591d57c67 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -121,6 +121,8 @@ static const struct of_device_id blacklist[] __initconst = {
>>  	{ .compatible = "mediatek,mt8176", },
>>  	{ .compatible = "mediatek,mt8183", },
>>  
>> +	{ .compatible = "nvidia,tegra20", },
>> +	{ .compatible = "nvidia,tegra30", },
>>  	{ .compatible = "nvidia,tegra124", },
>>  	{ .compatible = "nvidia,tegra210", },
>>  
>>
> 
> Hello Viresh,
> 
> Could you please pick up this patch for v5.5 fixes? Thanks in advance!
> 

Viresh / Rafael? Maybe I should send that patch separately?
