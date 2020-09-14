Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A662C268CAF
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgINOAA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 10:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgINN5o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 09:57:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579FDC06174A;
        Mon, 14 Sep 2020 06:56:30 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x69so13548583lff.3;
        Mon, 14 Sep 2020 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uArJZUWJNsNwbNRDiP6iCEIY7hPr+mzob4EFGdtLq2w=;
        b=qGBffOTgUyz69knXNB8/iJB1YZl+BZ58HcVNg8MtMX9YXAFXu6qAUexC6zRVvWUxlX
         3MET1EViRmFkbjyw6eVwhWfIfRl3jVzZ81rJB1eoWc6vh6UnNmaaCbUmbRTESjqeqla3
         +YEBgC8wSBOtMcVpRobXotmz1+YKbhTQrnpnUnSzeB+QYkjxgV8UXGCoebpuVtVv8ZQp
         WpVXlvzSF8DjWv8jh2nKmNFZe802EzaHyM7YWCkj/q05jsAuGy/dmtcjqOjn9UxZVBiV
         PH8zkyJtK8QwJsptKYfjjEGYPPXarw9fEya1vRtx5C9V2lallevuYSo+l+uzBYyZZLOS
         TscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uArJZUWJNsNwbNRDiP6iCEIY7hPr+mzob4EFGdtLq2w=;
        b=JSaUys4JWXuZ25YTC/w+sUhP98udFhAVJ4GMIIvUpR5BAnreSBISigrs01xQgG26ng
         l/8hDzXgblSUCz8/Do+mz7NNy3lljbDDh8D9q3Yi43MNCekHn1efPm8enzXe4gpmgAd0
         12xK8I8xT3eg3BIQPn7CTRZ3l1h97X9lvamu7T8EwiHQfUYpEHNSrtIOdcDaOXzRRoge
         eXEWeUdGEYifP5fKsHwiepS3La4spVmz8jKnFZVPJcpVsuotlWcMOZy3jXf2kXxkfQsU
         p1tjUrH/7/wd10QxPB56RVIyJ9qjJ9/oFFc0ydNBn8FroYlW+LACNpv9uuq+KDmg76g0
         o9mQ==
X-Gm-Message-State: AOAM533BRAf5TNSiu2dRBdXABphjoLNXXuVvzxCmN8kAcQqx1GirjP94
        E0jvsfYtkCiHqwaiM8E2blQBgsI20sI=
X-Google-Smtp-Source: ABdhPJzmb13YMA0mRV1PjF97gh4YRC/HLFtjLBFwesZwU8PIw+AtUvcN28KU0zbyBTDqOPL6wcQ0WA==
X-Received: by 2002:a19:fc02:: with SMTP id a2mr4148916lfi.443.1600091788493;
        Mon, 14 Sep 2020 06:56:28 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id q7sm3674161lfr.16.2020.09.14.06.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 06:56:27 -0700 (PDT)
Subject: Re: [PATCH] PM / devfreq: tegra30: disable clock on error in probe
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <CGME20200908072627epcas1p41f2c8c2730d42bd8935a40b0ab8122f7@epcas1p4.samsung.com>
 <20200908072557.GC294938@mwanda>
 <2ceb045a-ebac-58d7-0250-4ea39d711ce8@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <44560522-f04e-ade5-2e02-9df56a6f79ba@gmail.com>
Date:   Mon, 14 Sep 2020 16:56:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2ceb045a-ebac-58d7-0250-4ea39d711ce8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.09.2020 10:09, Chanwoo Choi пишет:
> Hi,
> 
> On 9/8/20 4:25 PM, Dan Carpenter wrote:
>> This error path needs to call clk_disable_unprepare().
>>
>> Fixes: 7296443b900e ("PM / devfreq: tegra30: Handle possible round-rate error")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index e94a27804c20..dedd39de7367 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -836,7 +836,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>>  	if (rate < 0) {
>>  		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
>> -		return rate;
>> +		err = rate;
>> +		goto disable_clk;
>>  	}
>>  
>>  	tegra->max_freq = rate / KHZ;
>> @@ -897,6 +898,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  	dev_pm_opp_remove_all_dynamic(&pdev->dev);
>>  
>>  	reset_control_reset(tegra->reset);
>> +disable_clk:
>>  	clk_disable_unprepare(tegra->clock);
> 
> Is it doesn't need to reset with reset_contrl_reset()?

Hello, Chanwoo!

It's reset just before the clk_round_rate() invocation, hence there
shouldn't be a need to reset it second time.
