Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B04B561FA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 08:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFZGCL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jun 2019 02:02:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40139 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfFZGCK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2019 02:02:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so710905wmj.5
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JE+TOhUHIrATlxgPGqOdu0Mpkm1mI9mozh/VZYXKh0M=;
        b=TXXMM5A6pGGNULhqD5rmeJMODf9Y+j0nrPR+5/5psBvvfvso+tmVV9ML1siql6CzqQ
         QulKmUP4FzzBVUT4Vzk6uXFNaCi5THQ4EFPeqJCsEl7dHGfnRB7tDu2a3Uvd0y9jhhMu
         wAzSV7sRp8T3ROyDAvlxe97966yfzv7Ajh9XIslOYmB1HYw8QLmakdx+9t1TynPqbA4S
         kHVLRC+uXFA1pOPtK3WZkCTGwvL1c9aZhIaoXP8mdUc2KrraGdPQ/EtMg19Fn0Nal9hj
         yyTHjNCNsilQkXHEznt5rKG6NJYnAfxPkksx2oxf/LWmy/omZ87JIho6FsbF9haPc7xX
         8png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JE+TOhUHIrATlxgPGqOdu0Mpkm1mI9mozh/VZYXKh0M=;
        b=UXemnKy3cQ751z8mpEHnnn7zMX4RMiZT4LWWzmep50p5oTQagJYgfdXkeCg1v9L0fJ
         oeUMzrBx460ptt+F4k/N29cRdkpRGVBHO+bGYYrcucH+nkOnA7Gk/g9BtrH3o9yzuXZv
         xmRRC+62btHEwIeoC4f2/RhLhztoXcCxRGSCf8/+Oyk/Mej2EzST0RUS5AIVcygq3zKT
         bv+e/P/a2kmPDsfwctlP8XbZ64+aodCBBFuOBD7vstVau7CPbJJwmS+nrQGHCFDIwCfQ
         +XCQVlyVdnSCgqlF3ZYvs4PwJIL8JFY8fLuqh2wIhWtdsNvpypevwjPDzsmYYMD65/tF
         JRPg==
X-Gm-Message-State: APjAAAVuQYKB8Pue720JT0VGHyu3MJ0UaEouQO44arqCdUJXmViTysmw
        H1Z2aIDxHcJKNhzuXqUz418Gqg==
X-Google-Smtp-Source: APXvYqwc1QI2wKf0Z1qUM2fhZdejuMhb2mu8lEueS3C1ItnTa05hTFUW8CDyP150git5Laq+FgGbWQ==
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr1219098wme.102.1561528927278;
        Tue, 25 Jun 2019 23:02:07 -0700 (PDT)
Received: from [192.168.0.41] (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.googlemail.com with ESMTPSA id w23sm1033278wmi.45.2019.06.25.23.02.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 23:02:06 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] thermal/drivers/cpu_cooling: Unregister with the
 policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, edubezval@gmail.com,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Keerthy <j-keerthy@ti.com>,
        "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" 
        <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>
References: <20190625113244.18146-1-daniel.lezcano@linaro.org>
 <20190625113244.18146-2-daniel.lezcano@linaro.org>
 <20190626025831.jmyzyypxr6ezpbtu@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 mQINBFv/yykBEADDdW8RZu7iZILSf3zxq5y8YdaeyZjI/MaqgnvG/c3WjFaunoTMspeusiFE
 sXvtg3ehTOoyD0oFjKkHaia1Zpa1m/gnNdT/WvTveLfGA1gH+yGes2Sr53Ht8hWYZFYMZc8V
 2pbSKh8wepq4g8r5YI1XUy9YbcTdj5mVrTklyGWA49NOeJz2QbfytMT3DJmk40LqwK6CCSU0
 9Ed8n0a+vevmQoRZJEd3Y1qXn2XHys0F6OHCC+VLENqNNZXdZE9E+b3FFW0lk49oLTzLRNIq
 0wHeR1H54RffhLQAor2+4kSSu8mW5qB0n5Eb/zXJZZ/bRiXmT8kNg85UdYhvf03ZAsp3qxcr
 xMfMsC7m3+ADOtW90rNNLZnRvjhsYNrGIKH8Ub0UKXFXibHbafSuq7RqyRQzt01Ud8CAtq+w
 P9EftUysLtovGpLSpGDO5zQ++4ZGVygdYFr318aGDqCljKAKZ9hYgRimPBToDedho1S1uE6F
 6YiBFnI3ry9+/KUnEP6L8Sfezwy7fp2JUNkUr41QF76nz43tl7oersrLxHzj2dYfWUAZWXva
 wW4IKF5sOPFMMgxoOJovSWqwh1b7hqI+nDlD3mmVMd20VyE9W7AgTIsvDxWUnMPvww5iExlY
 eIC0Wj9K4UqSYBOHcUPrVOKTcsBVPQA6SAMJlt82/v5l4J0pSQARAQABtCpEYW5pZWwgTGV6
 Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz6JAlcEEwEIAEECGwEFCwkIBwIGFQoJ
 CAsCBBYCAwECHgECF4ACGQEWIQQk1ibyU76eh+bOW/SP9LjScWdVJwUCXAkeagUJDRnjhwAK
 CRCP9LjScWdVJ+vYEACStDg7is2JdE7xz1PFu7jnrlOzoITfw05BurgJMqlvoiFYt9tEeUMl
 zdU2+r0cevsmepqSUVuUvXztN8HA/Ep2vccmWnCXzlE56X1AK7PRRdaQd1SK/eVsJVaKbQTr
 ii0wjbs6AU1uo0LdLINLjwwItnQ83/ttbf1LheyN8yknlch7jn6H6J2A/ORZECTfJbG4ecVr
 7AEm4A/G5nyPO4BG7dMKtjQ+crl/pSSuxV+JTDuoEWUO+YOClg6azjv8Onm0cQ46x9JRtahw
 YmXdIXD6NsJHmMG9bKmVI0I7o5Q4XL52X6QxkeMi8+VhvqXXIkIZeizZe5XLTYUvFHLdexzX
 Xze0LwLpmMObFLifjziJQsLP2lWwOfg6ZiH8z8eQJFB8bYTSMqmfTulB61YO0mhd676q17Y7
 Z7u3md3CLH7rh61wU1g7FcLm9p5tXXWWaAud9Aa2kne2O3sirO0+JhsKbItz3d9yXuWgv6w3
 heOIF0b91JyrY6tjz42hvyjxtHywRr4cdAEQa2S7HeQkw48BQOG6PqQ9d3FYU34pt3WFJ19V
 A5qqAiEjqc4N0uPkC79W32yLGdyg0EEe8v0Uhs3CxM9euGg37kr5fujMm+akMtR1ENITo+UI
 fgsxdwjBD5lNb/UGodU4QvPipB/xx4zz7pS5+2jGimfLeoe7mgGJxrkBDQRb/8z6AQgAvSkg
 5w7dVCSbpP6nXc+i8OBz59aq8kuL3YpxT9RXE/y45IFUVuSc2kuUj683rEEgyD7XCf4QKzOw
 +XgnJcKFQiACpYAowhF/XNkMPQFspPNM1ChnIL5KWJdTp0DhW+WBeCnyCQ2pzeCzQlS/qfs3
 dMLzzm9qCDrrDh/aEegMMZFO+reIgPZnInAcbHj3xUhz8p2dkExRMTnLry8XXkiMu9WpchHy
 XXWYxXbMnHkSRuT00lUfZAkYpMP7La2UudC/Uw9WqGuAQzTqhvE1kSQe0e11Uc+PqceLRHA2
 bq/wz0cGriUrcCrnkzRmzYLoGXQHqRuZazMZn2/pSIMZdDxLbwARAQABiQI2BBgBCAAgFiEE
 JNYm8lO+nofmzlv0j/S40nFnVScFAlv/zPoCGwwACgkQj/S40nFnVSf4OhAAhWJPjgUu6VfS
 mV53AUGIyqpOynPvSaMoGJzhNsDeNUDfV5dEZN8K4qjuz2CTNvGIyt4DE/IJbtasvi5dW4wW
 Fl85bF6xeLM0qpCaZtXAsU5gzp3uT7ut++nTPYW+CpfYIlIpyOIzVAmw7rZbfgsId2Lj7g1w
 QCjvGHw19mq85/wiEiZZNHeJQ3GuAr/uMoiaRBnf6wVcdpUTFMXlkE8/tYHPWbW0YKcKFwJ3
 uIsNxZUe6coNzYnL0d9GK2fkDoqKfKbFjNhW9TygfeL2Qhk949jMGQudFS3zlwvN9wwVaC0i
 KC/D303DiTnB0WFPT8CltMAZSbQ1WEWfwqxhY26di3k9pj+X3BfOmDL9GBlnRTSgwjqjqzpG
 VZsWouuTfXd9ZPPzvYdUBrlTKgojk1C8v4fhSqb+ard+bZcwNp8Tzl/EI9ygw6lYEATGCUYI
 Wco+fjehCgG1FWvWavMU+jLNs8/8uwj1u+BtRpWFj4ug/VaDDIuiApKPwl1Ge+zoC7TLMtyb
 c00W5/8EckjmNgLDIINEsOsidMH61ZOlwDKCxo2lbV+Ij078KHBIY76zuHlwonEQaHLCAdqm
 WiI95pYZNruAJEqZCpvXDdClmBVMZRDRePzSljCvoHxn7ArEt3F14mabn2RRq/hqB8IhC6ny
 xAEPQIZaxxginIFYEziOjR65AQ0EW//NCAEIALcJqSmQdkt04vIBD12dryF6WcVWYvVwhspt
 RlZbZ/NZ6nzarzEYPFcXaYOZCOCv+Xtm6hB8fh5XHd7Y8CWuZNDVp3ozuqwTkzQuux/aVdNb
 Fe4VNeKGN2FK1aNlguAXJNCDNRCpWgRHuU3rWwGUMgentJogARvxfex2/RV/5mzYG/N1DJKt
 F7g1zEcQD3JtK6WOwZXd+NDyke3tdG7vsNRFjMDkV4046bOOh1BKbWYu8nL3UtWBxhWKx3Pu
 1VOBUVwL2MJKW6umk+WqUNgYc2bjelgcTSdz4A6ZhJxstUO4IUfjvYRjoqle+dQcx1u+mmCn
 8EdKJlbAoR4NUFZy7WUAEQEAAYkDbAQYAQgAIBYhBCTWJvJTvp6H5s5b9I/0uNJxZ1UnBQJb
 /80IAhsCAUAJEI/0uNJxZ1UnwHQgBBkBCAAdFiEEGn3N4YVz0WNVyHskqDIjiipP6E8FAlv/
 zQgACgkQqDIjiipP6E+FuggAl6lkO7BhTkrRbFhrcjCm0bEoYWnCkQtX9YFvElQeA7MhxznO
 BY/r1q2Uf6Ifr3YGEkLnME/tQQzUwznydM94CtRJ8KDSa1CxOseEsKq6B38xJtjgYSxNdgQb
 EIfCzUHIGfk94AFKPdV6pqqSU5VpPUagF+JxiAkoEPOdFiQCULFNRLMsOtG7yp8uSyJRp6Tz
 cQ+0+1QyX1krcHBUlNlvfdmL9DM+umPtbS9F6oRph15mvKVYiPObI1z8ymHoc68ReWjhUuHc
 IDQs4w9rJVAyLypQ0p+ySDcTc+AmPP6PGUayIHYX63Q0KhJFgpr1wH0pHKpC78DPtX1a7HGM
 7MqzQ4NbD/4oLKKwByrIp12wLpSe3gDQPxLpfGgsJs6BBuAGVdkrdfIx2e6ENnwDoF0Veeji
 BGrVmjVgLUWV9nUP92zpyByzd8HkRSPNZNlisU4gnz1tKhQl+j6G/l2lDYsqKeRG55TXbu9M
 LqJYccPJ85B0PXcy63fL9U5DTysmxKQ5RgaxcxIZCM528ULFQs3dfEx5euWTWnnh7pN30RLg
 a+0AjSGd886Bh0kT1Dznrite0dzYlTHlacbITZG84yRk/gS7DkYQdjL8zgFr/pxH5CbYJDk0
 tYUhisTESeesbvWSPO5uNqqy1dAFw+dqRcF5gXIh3NKX0gqiAA87NM7nL5ym/CNpJ7z7nRC8
 qePOXubgouxumi5RQs1+crBmCDa/AyJHKdG2mqCt9fx5EPbDpw6Zzx7hgURh4ikHoS7/tLjK
 iqWjuat8/HWc01yEd8rtkGuUcMqbCi1XhcAmkaOnX8FYscMRoyyMrWClRZEQRokqZIj79+PR
 adkDXtr4MeL8BaB7Ij2oyRVjXUwhFQNKi5Z5Rve0a3zvGkkqw8Mz20BOksjSWjAF6g9byukl
 CUVjC03PdMSufNLK06x5hPc/c4tFR4J9cLrV+XxdCX7r0zGos9SzTPGNuIk1LK++S3EJhLFj
 4eoWtNhMWc1uiTf9ENza0ntqH9XBWEQ6IA1gubCniGG+Xg==
Message-ID: <da1d2603-e30a-d877-54c3-1fad218f9d57@linaro.org>
Date:   Wed, 26 Jun 2019 08:02:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626025831.jmyzyypxr6ezpbtu@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Viresh,


On 26/06/2019 04:58, Viresh Kumar wrote:
> On 25-06-19, 13:32, Daniel Lezcano wrote:
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index aee024e42618..f07454249fbc 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1379,8 +1379,8 @@ static int cpufreq_online(unsigned int cpu)
>>  		cpufreq_driver->ready(policy);
>>  
>>  	if (cpufreq_thermal_control_enabled(cpufreq_driver))
>> -		policy->cdev = of_cpufreq_cooling_register(policy);
>> -
>> +		of_cpufreq_cooling_register(policy);
>> +	
> 
> We don't need any error checking here anymore ?

There was no error checking initially. This comment and the others below
are for an additional patch IMO, not a change in this one.

>>  	pr_debug("initialization complete\n");
>>  
>>  	return 0;
>> @@ -1468,10 +1468,8 @@ static int cpufreq_offline(unsigned int cpu)
>>  		goto unlock;
>>  	}
>>  
>> -	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
>> -		cpufreq_cooling_unregister(policy->cdev);
>> -		policy->cdev = NULL;
>> -	}
>> +	if (cpufreq_thermal_control_enabled(cpufreq_driver))
>> +		cpufreq_cooling_unregister(policy);
> 
> And we unregister unconditionally, even if we failed ? What if this
> routine prints error messages for such an case ?
>>  
>>  	if (cpufreq_driver->stop_cpu)
>>  		cpufreq_driver->stop_cpu(policy);
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> index 83486775e593..007c7c6bf845 100644
>> --- a/drivers/thermal/cpu_cooling.c
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -78,6 +78,7 @@ struct cpufreq_cooling_device {
>>  	struct cpufreq_policy *policy;
>>  	struct list_head node;
>>  	struct time_in_idle *idle_time;
>> +	struct thermal_cooling_device *cdev;
>>  };
>>  
>>  static DEFINE_IDA(cpufreq_ida);
>> @@ -606,6 +607,7 @@ __cpufreq_cooling_register(struct device_node *np,
>>  		goto remove_ida;
>>  
>>  	cpufreq_cdev->clipped_freq = get_state_freq(cpufreq_cdev, 0);
>> +	cpufreq_cdev->cdev = cdev;
>>  
>>  	mutex_lock(&cooling_list_lock);
>>  	/* Register the notifier for first cpufreq cooling device */
>> @@ -699,18 +701,18 @@ EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
>>   *
>>   * This interface function unregisters the "thermal-cpufreq-%x" cooling device.
>>   */
>> -void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>> +void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
>>  {
>>  	struct cpufreq_cooling_device *cpufreq_cdev;
>>  	bool last;
>>  
>> -	if (!cdev)
>> -		return;
>> -
>> -	cpufreq_cdev = cdev->devdata;
>> -
>>  	mutex_lock(&cooling_list_lock);
>> -	list_del(&cpufreq_cdev->node);
>> +	list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
>> +		if (cpufreq_cdev->policy == policy) {
>> +			list_del(&cpufreq_cdev->node);
>> +			break;
>> +		}
>> +	}
> 
> What if we reach here without a match for the policy ? We shouldn't
> continue and error out, right ? Print an error message as well ?
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

