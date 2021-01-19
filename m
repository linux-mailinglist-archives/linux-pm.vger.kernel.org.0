Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3BA2FC272
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbhASRsX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 12:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733305AbhASPFC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 10:05:02 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392B7C061793;
        Tue, 19 Jan 2021 07:01:45 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id n8so13444455ljg.3;
        Tue, 19 Jan 2021 07:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=agax0qDZZ1HTQS1TRVOBs2nRNybT0RGhbGz+ScANHiY=;
        b=JbAT8eo1xsybV+5hUgnBoKDnIyhXzO26OssnYp4d+Bqbr6dHfuvBOHSXhgUE45IV0W
         0hILwOTKO1qg3pOedRgyr0xt20F0AuShvFYVsAp/89AAEcbIQZcT2TpXPRy1nao8udp5
         0ef/WG3NxVBApxwyYBzpXfBGB3MQxwybajFVzMq6Yoo2K19J5pJ7CG7TSjeESrNdv7Qd
         tDEARrBqsuG8b5Ieq9QU8A3S+98P+aBrV7aSRbsEZ6ujvWL6hZwg9UC/bFKip1KkKTZR
         S6d8CLF75LOnpTUlRTCyq+al3uFvMFoZlpddvKupknzNRFjtz+P3OGsoAF4RsQMS9ClV
         PcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=agax0qDZZ1HTQS1TRVOBs2nRNybT0RGhbGz+ScANHiY=;
        b=nbfr9N55eS/oyp10YRhWu5YP8YnRXPL0Dl6I3lJkF7idfKKFDEpGvx9V3PiwbtEhiy
         PGct1m7cCopPK8mygyuhk20Vm124zNi7no/XBoE6be4Vf6tb91CBl0T2uml+aeitezDQ
         aLKN9u4m6QLKtvKLhp0Mvi8Z6TIKgOZ0hFHKe98RyO+ljjK98uyoUNT1/zCx73OwDfvV
         d8d2L0YbEYdXrIGHvMbzGsP0APy3Y1WCv8uhgC1SMdENzZHEBkORtbsI+T2NlTRGU0to
         fTsNTLcuhcfzz3eO0qqi/wQpfmoc/vzm1CTlrmS1Z8tqBmspuCzpZ0At5J7Kda66n+EO
         XhMA==
X-Gm-Message-State: AOAM5338k1qb35ty+B3uNwd42mtADPNLUdBWZUo13tGzfzTTKpXzoGW2
        N22dsI6BuLWulnpuU+7/LMruBcSnlG0=
X-Google-Smtp-Source: ABdhPJwtRUF5RuzhWYimF2pqSoi13VxtUrCsr9Z0WThi1C56EGUdSDCFPxs7fhBTdWvUicVJeputxw==
X-Received: by 2002:a2e:988d:: with SMTP id b13mr415555ljj.176.1611068503203;
        Tue, 19 Jan 2021 07:01:43 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id a10sm2308462lfs.18.2021.01.19.07.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 07:01:42 -0800 (PST)
Subject: Re: [PATCH v1] cpufreq: tegra20: Use resource-managed API
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210117231825.28256-1-digetx@gmail.com>
 <20210118063910.on4vgbllfmsduezo@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <09f93579-9de0-d541-1331-e2b45518c270@gmail.com>
Date:   Tue, 19 Jan 2021 18:01:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210118063910.on4vgbllfmsduezo@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.01.2021 09:39, Viresh Kumar пишет:
> On 18-01-21, 02:18, Dmitry Osipenko wrote:
>> Switch cpufreq-tegra20 driver to use resource-managed API.
>> This removes the need to get opp_table pointer using
>> dev_pm_opp_get_opp_table() in order to release OPP table that
>> was requested by dev_pm_opp_set_supported_hw(), making the code
>> a bit more straightforward.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/cpufreq/tegra20-cpufreq.c | 45 +++++++++++++++----------------
>>  1 file changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
>> index 8c893043953e..e8db3d75be25 100644
>> --- a/drivers/cpufreq/tegra20-cpufreq.c
>> +++ b/drivers/cpufreq/tegra20-cpufreq.c
>> @@ -32,6 +32,16 @@ static bool cpu0_node_has_opp_v2_prop(void)
>>  	return ret;
>>  }
>>  
>> +static void tegra20_cpufreq_put_supported_hw(void *opp_table)
>> +{
>> +	dev_pm_opp_put_supported_hw(opp_table);
>> +}
>> +
>> +static void tegra20_cpufreq_dt_unregister(void *cpufreq_dt)
>> +{
>> +	platform_device_unregister(cpufreq_dt);
>> +}
>> +
>>  static int tegra20_cpufreq_probe(struct platform_device *pdev)
>>  {
>>  	struct platform_device *cpufreq_dt;
>> @@ -68,42 +78,31 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
>>  		return err;
>>  	}
>>  
>> +	err = devm_add_action_or_reset(&pdev->dev,
>> +				       tegra20_cpufreq_put_supported_hw,
>> +				       opp_table);
>> +	if (err)
>> +		return err;
>> +
>>  	cpufreq_dt = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>>  	err = PTR_ERR_OR_ZERO(cpufreq_dt);
>>  	if (err) {
>>  		dev_err(&pdev->dev,
>>  			"failed to create cpufreq-dt device: %d\n", err);
>> -		goto err_put_supported_hw;
>> +		return err;
>>  	}
>>  
>> -	platform_set_drvdata(pdev, cpufreq_dt);
>> -
>> -	return 0;
>> -
>> -err_put_supported_hw:
>> -	dev_pm_opp_put_supported_hw(opp_table);
>> -
>> -	return err;
>> -}
>> -
>> -static int tegra20_cpufreq_remove(struct platform_device *pdev)
>> -{
>> -	struct platform_device *cpufreq_dt;
>> -	struct opp_table *opp_table;
>> -
>> -	cpufreq_dt = platform_get_drvdata(pdev);
>> -	platform_device_unregister(cpufreq_dt);
>> -
>> -	opp_table = dev_pm_opp_get_opp_table(get_cpu_device(0));
>> -	dev_pm_opp_put_supported_hw(opp_table);
>> -	dev_pm_opp_put_opp_table(opp_table);
>> +	err = devm_add_action_or_reset(&pdev->dev,
>> +				       tegra20_cpufreq_dt_unregister,
>> +				       cpufreq_dt);
>> +	if (err)
>> +		return err;
>>  
>>  	return 0;
>>  }
>>  
>>  static struct platform_driver tegra20_cpufreq_driver = {
>>  	.probe		= tegra20_cpufreq_probe,
>> -	.remove		= tegra20_cpufreq_remove,
>>  	.driver		= {
>>  		.name	= "tegra20-cpufreq",
>>  	},
> 
> Applied. Thanks.
> 
> Though please remember to update this to use the devm_ variant when it comes
> out.

The regular devm_opp_* helpers won't be usable for CPUFreq drivers because OPP is applied to the CPU device and not the device of the CPUFreq driver.

But maybe we could support such cases by the helpers?

I CC'd Yangtao Li.

For example we could do this:

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ca8c6acc29f4..e2eb0f9cf46c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1771,7 +1771,8 @@ static void devm_pm_opp_supported_hw_release(void *data)
 
 /**
  * devm_pm_opp_set_supported_hw() - Set supported platforms
- * @dev: Device for which supported-hw has to be set.
+ * @dev: Device which manages allocated resources.
+ * @opp_dev: Device for which supported-hw has to be set.
  * @versions: Array of hierarchy of versions to match.
  * @count: Number of elements in the array.
  *
@@ -1783,13 +1784,14 @@ static void devm_pm_opp_supported_hw_release(void *data)
  * The opp_table structure will be freed after the device is destroyed.
  */
 struct opp_table *devm_pm_opp_set_supported_hw(struct device *dev,
+					       struct device *opp_dev,
 					       const u32 *versions,
 					       unsigned int count)
 {
 	struct opp_table *opp_table;
 	int err;
 
-	opp_table = dev_pm_opp_set_supported_hw(dev, versions, count);
+	opp_table = dev_pm_opp_set_supported_hw(opp_dev, versions, count);
 	if (IS_ERR(opp_table))
 		return opp_table;
