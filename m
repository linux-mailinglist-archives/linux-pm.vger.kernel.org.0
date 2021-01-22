Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D351D300750
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 16:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbhAVP3M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 10:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbhAVP3B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 10:29:01 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B576AC061786;
        Fri, 22 Jan 2021 07:28:20 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o10so8011695lfl.13;
        Fri, 22 Jan 2021 07:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ISQKWjgPbcA/Ev2c4Dpj7JuqMDl83n77M+ggmuFw+pg=;
        b=dmzoTzYkZa7zRgygbr3mVegm7/sSaiMmR4RVw3M0mqAtfAoDB6XXewgJnlYDtkBuam
         F9bWa423mWu4Wijewx2OnQDBOIZuy9V/4v673kVolbgAankkGZhMZdeR+BMlOdtGICe1
         Eksl/DHbz7pG8KNfGc9Fh0o9IjVB3UwI6IECSx7Y1C3p1TH0bnwyGfw1ysNkTgmfnc8C
         kNpIIrtnmEB/Ww/FDgjE10+JmGaNJawt2KpUfBdXgyrnZK1HnWpg9PJWBO360XYAdR+0
         Cknwdaltai7YIbG2ojLtq1UrywWnOnd8c89KoKJBwt4OJlBoUsSmcHeARDvK5K5wDlBU
         Nl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ISQKWjgPbcA/Ev2c4Dpj7JuqMDl83n77M+ggmuFw+pg=;
        b=bwaquGBytYcbDAy1izD3d4P8Rh+6cdyVg1SZ98A8X1hjmMJh5uEK0+C5cElYI3pBkX
         L/yGPdX4xGShk5QnncnBcz919O/IkhRQX2DFLpdqes3PtB2xb5L03FOYGUilgPcHLwqt
         CLEoyqLB/gc1wPa64MB1VFDIYKS1dWEWWPtn4DKKtjrq2TCs+yfdaXB9mRPJuL5hZSnr
         2FXklmC7D7HmKQ/ay+tUe18uHV6DyrQ0dK6VpnwDk4wwIpYkd9F+ZsugCBJ2gncX4gCk
         b3DycWOwuyKQ8oiNoum8MRnUlCbykLk8GKAF6nQ7Qw+8ggyI/97ktJgKOnRkcpjIRDxz
         NDhw==
X-Gm-Message-State: AOAM530cRZ2otYHCXOGXxH2w40ze7wVOu9PUjP/JelSpa8au/+DP1s71
        QgWhXVYjpUDzT/rTXOanXzk1TZh5LtA=
X-Google-Smtp-Source: ABdhPJzwGQlG1MHqbBIRIHds0kbrQeg1FOtQon6lZaFzU702grDxctXDFHfPTYD/1lhQxfZk3d3pqg==
X-Received: by 2002:ac2:5e2a:: with SMTP id o10mr93571lfg.481.1611329299125;
        Fri, 22 Jan 2021 07:28:19 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id a23sm920989lfm.125.2021.01.22.07.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:28:18 -0800 (PST)
Subject: Re: [PATCH 11/13] devfreq: tegra30: Migrate to dev_pm_opp_set_opp()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <3345fd49f7987d022f4f61edb6c44f230f7354c4.1611227342.git.viresh.kumar@linaro.org>
 <71451eb2-46b2-1ea0-efcc-0811568159a4@gmail.com>
 <20210122062659.qss3hef4kltfgciu@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f33334e7-bd28-af82-b557-681a2b4132da@gmail.com>
Date:   Fri, 22 Jan 2021 18:28:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210122062659.qss3hef4kltfgciu@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

22.01.2021 09:26, Viresh Kumar пишет:
> On 22-01-21, 00:36, Dmitry Osipenko wrote:
>> 21.01.2021 14:17, Viresh Kumar пишет:
>>> dev_pm_opp_set_bw() is getting removed and dev_pm_opp_set_opp() should
>>> be used instead. Migrate to the new API.
>>>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>  drivers/devfreq/tegra30-devfreq.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>>> index 117cad7968ab..d2477d7d1f66 100644
>>> --- a/drivers/devfreq/tegra30-devfreq.c
>>> +++ b/drivers/devfreq/tegra30-devfreq.c
>>> @@ -647,7 +647,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>>>  		return PTR_ERR(opp);
>>>  	}
>>>  
>>> -	ret = dev_pm_opp_set_bw(dev, opp);
>>> +	ret = dev_pm_opp_set_opp(dev, opp);
>>>  	dev_pm_opp_put(opp);
>>>  
>>>  	return ret;
>>>
>>
>> This patch introduces a very serious change that needs to be fixed.
>>
>> Now dev_pm_opp_set_opp() changes both clock rate and bandwidth, this is
>> unacceptable for this driver because it shall not touch the clock rate.
>>
>> I think dev_pm_opp_set_bw() can't be removed.
> 
> I am wondering here on what would be a better solution, do what you
> said or introduce another helper like dev_pm_opp_clear_clk(), which
> will make sure the OPP core doesn't play with device's clk.
> 

Either way will work, but maybe keeping the dev_pm_opp_set_bw() is a bit
more straightforward variant for now since it will avoid the code's
changes and it's probably a bit more obvious variant for the OPP users.
