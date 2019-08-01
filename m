Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D64B7D978
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 12:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfHAKiW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 06:38:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46139 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbfHAKiV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 06:38:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so45599763lfh.13;
        Thu, 01 Aug 2019 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=06wfPhg+8YjH4h0kTv6qRdHJjLnLiyI4NWYy6y8wg1Y=;
        b=BriPdV1yhHJYQB4Z9BgW9B06VWoQ/ZKX1J5C2AqUZu0ETfPHVz0wjKmMsRJmgJ3onV
         LbtO2Ejq2pRxIRm9POIGsXszrH/mX2Zxawml0S1fAt/iPZKSoI9Lp7jsVXeil2nR3XRf
         gF3OdOPNoU2PNEVbEFbDrEqjciYsTGpE453hP71eLo7HcjunvhnwNahHae9uzYIuDemR
         72pJ851nEYavzZQU41ZWTb5g9vPM8fAy2ieoGPpSsYz8UNBJzxKAw/C304q8Lee2iJhG
         CEcCqunT0Es3/TkVV738l5+vJJBoh1h1e0I+ecF0PwJsTbvMsfxIwIpOsxkbT2j0otXO
         aUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=06wfPhg+8YjH4h0kTv6qRdHJjLnLiyI4NWYy6y8wg1Y=;
        b=AWudZYJ5PB/wlz9Dzl09FzDytksTIjh+3ClU9hNGzASfKNIa0DqLnCj/ZHXk24HAkp
         /mCDojg13tcmGctvfOdwe6vTdXgQaxLsyR1Fq7rNATcleR//FFChPhPxhyd2jb1KNR4Z
         p4UxKYO+chEBuhtA5QZMjB/s7crFUN2sPAlcUG1oVDbiOsQXU2B2fpI9IkWXN0AHlaVG
         QCO0KHkoy7W5GmYZzfr8FeRo7bBdBm5Y+sSJAWy+izeTxtYr8PH22F45eF+sp7yGbVLZ
         b+KN+D8cn221+7mYHgbNwxa3GkYW8ZfKpQLjm91+e9BzLfULRaHt4BIkQmp2pgd9lwmJ
         fXqA==
X-Gm-Message-State: APjAAAUDjkg3cAp5KXKlhyJv6+iglAET46vKTMoY0xQRjk3s/9WQ5FQd
        QaqH4uyRYez+J4M26P8A2POM2ee+
X-Google-Smtp-Source: APXvYqxFS4iYmAZHfm5SgRy1kF1Uuca2SOtR1au6OhS7BBnO3ob0i57s1YV2or2HnHb4M5qEITLqeg==
X-Received: by 2002:ac2:5559:: with SMTP id l25mr59584262lfk.175.1564655898946;
        Thu, 01 Aug 2019 03:38:18 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id t137sm12182902lff.78.2019.08.01.03.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 03:38:18 -0700 (PDT)
Subject: Re: [PATCH v7 10/20] clk: tegra: clk-dfll: Add suspend and resume
 support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        linus.walleij@linaro.org, stefan@agner.ch, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
 <1564607463-28802-11-git-send-email-skomatineni@nvidia.com>
 <4400ffef-685f-b9e6-3b07-4790f851282c@gmail.com>
Message-ID: <501a9d0e-ce78-9b35-642d-dff7f9223926@gmail.com>
Date:   Thu, 1 Aug 2019 13:37:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4400ffef-685f-b9e6-3b07-4790f851282c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.08.2019 13:18, Dmitry Osipenko пишет:
> 01.08.2019 0:10, Sowjanya Komatineni пишет:
>> This patch implements DFLL suspend and resume operation.
>>
>> During system suspend entry, CPU clock will switch CPU to safe
>> clock source of PLLP and disables DFLL clock output.
>>
>> DFLL driver suspend confirms DFLL disable state and errors out on
>> being active.
>>
>> DFLL is re-initialized during the DFLL driver resume as it goes
>> through complete reset during suspend entry.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>  drivers/clk/tegra/clk-dfll.c               | 56 ++++++++++++++++++++++++++++++
>>  drivers/clk/tegra/clk-dfll.h               |  2 ++
>>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c |  1 +
>>  3 files changed, 59 insertions(+)
>>
>> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
>> index f8688c2ddf1a..9900097ec2aa 100644
>> --- a/drivers/clk/tegra/clk-dfll.c
>> +++ b/drivers/clk/tegra/clk-dfll.c
>> @@ -1513,6 +1513,62 @@ static int dfll_init(struct tegra_dfll *td)
>>  	return ret;
>>  }
>>  
>> +/**
>> + * tegra_dfll_suspend - check DFLL is disabled
>> + * @dev: DFLL device *
>> + *
>> + * DFLL clock should be disabled by the CPUFreq driver. So, make
>> + * sure it is disabled and disable all clocks needed by the DFLL.
>> + */
>> +int tegra_dfll_suspend(struct device *dev)
>> +{
>> +	struct tegra_dfll *td = dev_get_drvdata(dev);
>> +
>> +	if (dfll_is_running(td)) {
>> +		dev_err(td->dev, "dfll is enabled while shouldn't be\n");
>> +		return -EBUSY;
>> +	}
>> +
>> +	reset_control_assert(td->dvco_rst);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(tegra_dfll_suspend);
>> +
>> +/**
>> + * tegra_dfll_resume - reinitialize DFLL on resume
>> + * @dev: DFLL instance
>> + *
>> + * DFLL is disabled and reset during suspend and resume.
>> + * So, reinitialize the DFLL IP block back for use.
>> + * DFLL clock is enabled later in closed loop mode by CPUFreq
>> + * driver before switching its clock source to DFLL output.
>> + */
>> +int tegra_dfll_resume(struct device *dev)
>> +{
>> +	struct tegra_dfll *td = dev_get_drvdata(dev);
>> +
>> +	reset_control_deassert(td->dvco_rst);
>> +
>> +	pm_runtime_irq_safe(td->dev);
> 
> Please see my previous reply.
> 

Also, you should always bump version of the patches no matter what.
otherwise it turns out very confusing.
