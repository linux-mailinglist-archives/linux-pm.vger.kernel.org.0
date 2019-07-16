Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875916A934
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 15:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfGPNJ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 09:09:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46917 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfGPNJ0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 09:09:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id z15so9383929lfh.13;
        Tue, 16 Jul 2019 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Aro7keGuhkcq5L8X8QU6tiy3pifRBQgLd9LgfbCkFEk=;
        b=u78n1t2AEOwncDi6eVNAylRaa5RC9vxyKN/OLrZMqQW8rzT7unYb7sMR+KQc7bgVEG
         iSoSnKA+XMXXzWugYzWfNsT7y1ILHLxIK2b74WTuv/NRQNfO6vbeFF11w2CvVsHB8ksN
         fIOmHfGECZchGjDE8kxAYu6yh6IgqKs4GRc5Te/tFTL6cccrn+Ne8SlDn9mXmIR/+F57
         h+sbK0lieuJ8s+TJ31DPb4Sd4r0vak3CxD5Mr9Vq4ApP/no9CyG2lWNr/XRrhKVEOfOh
         5h6/2G1/xw495q1kfdZJQwvk/1D11whNiMT1O3Wth4BgeA2rULMLksUtsVNggjJHvwVJ
         jwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aro7keGuhkcq5L8X8QU6tiy3pifRBQgLd9LgfbCkFEk=;
        b=DftOBhVnSuIpb3cFTBcfOwU4LyOz9ZrsohE/Ip8yRBpDTjhLqNivwPN1C4sSOF3re6
         dVJwI0oTx5JFqwexUVaSthQj8lCvbqEO2hCz9WfU6yko2XhQhUJoYQ8D2TyKoeN9EtPW
         8bXslriSBLG4sT9Qh0gua5FjO0OU5cXrcQrJuj+5b64N+QdJwFlGbX2XJHu4RwN2S+2V
         nLBS3f0tpGmWnQQgbaeT/VV7C8dDPpl4t2A+aiKZkKdXHsFaQKySkB//jYuzodbqSe6d
         ygrS2oVALaX5tuILmtIIYz9OZZpO3r8V4lNgirP3J7ZO0Fkgg3RrjCIF1jvTj2EVY0yE
         fbYg==
X-Gm-Message-State: APjAAAUQm8YMXpYWjI8I2NG3Scj8os6zrf64Oyr0OHh+sOVHyh/x5BFH
        94xk6b85kktzxvx2geKWJUiDiyck
X-Google-Smtp-Source: APXvYqx922/pQmKDf7f5m8sRlMn6H2+6fwa3vtgS3KF+9hqyw3/Mm9LAzAVe9fvK+4Ua8bArfBHOEg==
X-Received: by 2002:a19:ca1e:: with SMTP id a30mr14407487lfg.163.1563282563642;
        Tue, 16 Jul 2019 06:09:23 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id i9sm2830924lfl.10.2019.07.16.06.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 06:09:23 -0700 (PDT)
Subject: Re: [PATCH v4 03/24] PM / devfreq: tegra30: Handle possible
 round-rate error
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707223303.6755-1-digetx@gmail.com>
 <CGME20190707223726epcas4p1790944443c61b34e6c8dd4d64200a2a2@epcas4p1.samsung.com>
 <20190707223303.6755-4-digetx@gmail.com>
 <f28470ca-93dc-cdf9-b008-54c7b50cfd83@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e9fd7f68-8ad1-058f-7c87-ccd280ba0b0e@gmail.com>
Date:   Tue, 16 Jul 2019 16:09:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f28470ca-93dc-cdf9-b008-54c7b50cfd83@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.07.2019 14:50, Chanwoo Choi пишет:
> On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
>> The EMC clock rate rounding technically could fail, hence let's handle
>> the error cases properly.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 5e2b133babdd..5e606ae3f238 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -592,8 +592,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  	struct tegra_devfreq_device *dev;
>>  	struct tegra_devfreq *tegra;
>>  	struct devfreq *devfreq;
>> -	unsigned long rate;
>>  	unsigned int i;
>> +	long rate;
>>  	int err;
>>  
>>  	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
>> @@ -650,8 +650,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  
>>  	reset_control_deassert(tegra->reset);
>>  
>> -	tegra->max_freq = clk_round_rate(tegra->emc_clock, ULONG_MAX) / KHZ;
>> +	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>> +	if (rate < 0) {
>> +		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
>> +		return rate;
>> +	}
>> +
>>  	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
>> +	tegra->max_freq = rate / KHZ;
>>  
>>  	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
>>  		dev = tegra->devices + i;
>> @@ -662,6 +668,13 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
>>  		rate = clk_round_rate(tegra->emc_clock, rate);
>>  
> 
> Please remove unneeded blank line.

I can remove it, but it was added specifically to ease reading of the code.

>> +		if (rate < 0) {
>> +			dev_err(&pdev->dev,
>> +				"Failed to round clock rate: %ld\n", rate);
>> +			err = rate;
>> +			goto remove_opps;
>> +		}
> 
> Also, this patch doesn't contain code which restore the previous
> tegra->cur_freq/max_freq when error happen.

The error here results in abortion of the driver's probing, hence
nothing need to be restored in that case because nothing was changed at
this point yet.
