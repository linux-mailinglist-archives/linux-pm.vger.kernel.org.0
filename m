Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE99D1A6BE1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 20:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbgDMSGe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 14:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387498AbgDMSGc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 14:06:32 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF6CC0A3BDC
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 11:06:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a201so10495139wme.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 11:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q0D26fyaAIiTwbvFDpemvGzTvhTLQ2mWpZWWLig+LSk=;
        b=e1VlO/z2ja5OF8Xxd2q5mFlNfnIu+IowBOXF8gnD9TM+63h2ZhCsVoXCqnFc12UoaL
         dSeTSr1hRUeIv5ZwsmpT+mUcQ44zNlZmfxC7gspX8GWbUxLjg4Asm/h3cV+7kkxDPST9
         LxefygA+BrV84CUE9CSeXcrObGL1e4FMGepI61NbEaDHMgT2TrrYBi47Q0UoYoew+1B3
         +Z01Htc2mRs88Pwdu1HDS2WRw7kXd+G+TG1+2451yCK2o5Ikn44lrbadfTEXkTmhHLyt
         a7gRMbc0CSCton+IpvsFa5z3x57prFeoXlmWNyBSX68RuZdIYzAUj8RVwRsPYptHE+ji
         gdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q0D26fyaAIiTwbvFDpemvGzTvhTLQ2mWpZWWLig+LSk=;
        b=BGMJfPU72K4la5mFBYq7YWxFiHRYUr4u8fLRUdTBe5Vq6Gbu0Zt1XSG7u8fTy4V2l+
         ETBcC0AIY7afA0NS2474dk0IX6nrLRiENwlZQXOhIWj6iTtnKRQQlxSxMIrGMld241ev
         AiihlUQ0rkqBA1YHOULFaPO7GFnjcB5hQ7qmeu/o6TIwsqpltAEcz2wWficFlkk4vf8u
         3HnYwjGs/yFjeN5vO2uGp//U2RCLloo0vEo6XbN3GcfNj7TQpTeuvdDE+PfLb6IPF6PY
         T4RKVih5NgBX5eoa4ZC1Qia7D1uAJkdS1ZpL7g+Km4gzU5X/uV0pKihk3ypHoGYSMp12
         Y3pA==
X-Gm-Message-State: AGi0PuY0jgrYreBgnIyaka55RitpSXByzqP8J0RkWRl+OVLIDCKuUfhv
        Xet4JyFXT7AQF0MrA2rb89Ep6uOcKtg=
X-Google-Smtp-Source: APiQypLEc3yDoQR2rctcavatj6UYGY0jIVTlIyrE6FXSUaswA7e7nT1mbH9O+UbUEzqPdXIqviX4ng==
X-Received: by 2002:a1c:4e06:: with SMTP id g6mr19388073wmh.186.1586801189078;
        Mon, 13 Apr 2020 11:06:29 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id w6sm11776606wrm.86.2020.04.13.11.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 11:06:28 -0700 (PDT)
Subject: Re: [RFC PATCH 5/5] ACPI: processor: do update when maximum cooling
 state changed
To:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc:     tiwai@suse.de, viresh.kumar@linaro.org
References: <20200408041917.2329-1-rui.zhang@intel.com>
 <20200408041917.2329-5-rui.zhang@intel.com>
 <5cd80df7-775e-96bd-cec5-b14965de2a67@linaro.org>
 <2bef9553fcf7ccd7c9811ad1d572af2e5a811917.camel@intel.com>
 <a15dee60-8d20-0f56-0037-276830c613cd@linaro.org>
 <fee68438572796c71089571e0ff0add6cbbd3e0c.camel@intel.com>
 <e264d4a2-b0d9-8adf-b44f-7501c4407029@linaro.org>
 <17727142fac13f641d7cd5c3713cfadef77aa75c.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1e65a2c3-fdeb-4f48-f477-a7ec67cffd4e@linaro.org>
Date:   Mon, 13 Apr 2020 20:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <17727142fac13f641d7cd5c3713cfadef77aa75c.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/04/2020 04:01, Zhang Rui wrote:
> On Sun, 2020-04-12 at 12:07 +0200, Daniel Lezcano wrote:

[ ... ]

> why we can not have a cdev->max_state field, and get it updated right
> after .get_max_state().
> and .get_max_state()  is only invoked
> a) during cooling device registration
> b) when cooling device update its max_state via the new API.
> 
>>
>> In the function thermal_cooling_device_stats_update():
>>
>>   Is it possible to just compare the 'new_state' parameter with
>> stats->max_state and if it is greater increase the stats table and
>> update max_state to the new_state ?
>>
> the problem is that thermal_cooling_device_stats_update() is invoked
> only if thermal zone are updated or the cur_state sysfs attribute is
> changed.
> There is no way for a cooling device driver to tell thermal framework
> that it has changed.
> Say, for the problem on hand, the statistics table will not be updated
> in time when cpufreq driver probed.

Except I'm missing something, the statistics are only read from
userspace via sysfs.

userspace is not notified about a stat change. Is it really a problem
the table is not updated right at the probe time ? Does it really matter
if the user sees the old table until an update happens on a new higher
max state ?

The table is always consistent whenever the userspace reads the content.

A new entry will appear only if it is used, no?






-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
