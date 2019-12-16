Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F550120832
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 15:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfLPOLb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 09:11:31 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41617 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfLPOLb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 09:11:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so6953850ljc.8;
        Mon, 16 Dec 2019 06:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HhL5GMKIFDddfWEaX7NT4E3scjRhU5x3XuH72/9QCyo=;
        b=jrqJzc+/u/LblZplRKW3eR4/Ge+b4/2IipInHNNk7BL2mZZnJtPHF2ZpEvr4zsXT1J
         uNT59SvM5Amun90YFgy8GJzXdI5uoQJyXExaUd7leci+peFjiC7FlTNA92UA8SXbq3eU
         MOegPJ7i/pv8To6BHlKcZOUywqyxx7q8eDcm/w8IcgvKWVKOInasra8tqfsDnbVAZCeo
         FpIablaEjBiUFVOb5Oc0Dbr0b4mJ8ZAykZ3nLPICiBB6XgqFk8G8mN64aUBY5aLZxTf+
         nO2neK1yMlESAkGPyxew4xii+fD4A3cY7oTtZWnvBa7G3H6/qK9o1TnCZa/65H7yPpe+
         HIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HhL5GMKIFDddfWEaX7NT4E3scjRhU5x3XuH72/9QCyo=;
        b=gmfTl1Diu40j8X3EqhewKQ99dyOTAVcsxIrFljpKAgAUOFq/CnD0DxoTQZWeuxz16W
         fAlbjPcLxHH7qq4N62UHzR/o1/Ee8tVrH98cW/8xZEmN/oIDykf4YBsxWXSpb/+v2rI9
         5drstD3nEfMo1zkvnowEvLO+DPHR/aY93DT9rzAPOkniKhwcu2tTAyhYqVbMqmNTkRZa
         vM8EKHYWPfLmsjHc/B3PzoNnwEJhDiK5EeftziQp3QbSFEp+COfUeX/WV8Qor0n3g7hU
         eh//W/XGa9Em2Od0OUtx5yDsSRLoHNKhZ82CeQwnIuN26Cmv0bc/88Phtq5ATxSTJTpO
         7ERQ==
X-Gm-Message-State: APjAAAWGUxGmuzNr0oPQm8xyNkxmEMsvOWJr6YuFSLwWxAl7sLLn2ETz
        TdYFbTNghitDNCD3oWitdq4fNQQe
X-Google-Smtp-Source: APXvYqxVulbjGD7qBtkHu8dFjhoK+mY8pmMw7WHa5Lz77cd2cK6am3IF8jv4B0zPS4UWLTmlFAOg1g==
X-Received: by 2002:a2e:9216:: with SMTP id k22mr19606187ljg.52.1576505488021;
        Mon, 16 Dec 2019 06:11:28 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id z9sm10499851ljm.40.2019.12.16.06.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 06:11:27 -0800 (PST)
Subject: Re: [PATCH v5 07/11] cpufreq: dt-platdev: Blacklist NVIDIA Tegra20
 and Tegra30 SoCs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191118164512.8676-1-digetx@gmail.com>
 <20191118164512.8676-8-digetx@gmail.com>
 <20191216040532.mzdovqoub5rdztwb@vireshk-i7>
 <20191216040808.w67jxu7oapxgm7yh@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a57c80f0-59a7-c758-c914-025f12c85ba8@gmail.com>
Date:   Mon, 16 Dec 2019 17:11:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191216040808.w67jxu7oapxgm7yh@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.12.2019 07:08, Viresh Kumar пишет:
> On 16-12-19, 09:35, Viresh Kumar wrote:
>> On 18-11-19, 19:45, Dmitry Osipenko wrote:
>>> Both NVIDIA Tegra20 and Tegra30 SoCs should be blacklisted because CPU
>>> OPPs use supported_hw and thus platdev isn't suitable for these SoCs.
>>> Currently cpufreq-dt driver produces a bit annoying warning splats
>>> during boot because valid OPPs are not found, this will be fixed once
>>> tegra20-cpufreq driver will be update to support cpufreq-dt. The warnings
>>> will also happen on older stable kernels using newer device-trees, thus
>>> this patch should be backported to stable kernels as well.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>>> Fixes: 4053aa65c517 ("ARM: tegra: cardhu-a04: Add CPU Operating Performance Points")
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
>>> index f1d170dcf4d3..aba591d57c67 100644
>>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>>> @@ -121,6 +121,8 @@ static const struct of_device_id blacklist[] __initconst = {
>>>  	{ .compatible = "mediatek,mt8176", },
>>>  	{ .compatible = "mediatek,mt8183", },
>>>  
>>> +	{ .compatible = "nvidia,tegra20", },
>>> +	{ .compatible = "nvidia,tegra30", },
>>>  	{ .compatible = "nvidia,tegra124", },
>>>  	{ .compatible = "nvidia,tegra210", },
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Oops, pasted the wrong register here :(
> 
> Applied. Thanks.
> 

Thanks!
