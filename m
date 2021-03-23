Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939A334643F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 17:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhCWQAB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 12:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbhCWP77 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 11:59:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB5CC061763
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 08:59:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so11136713wmi.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EnmmDyggAPflRAaQCTg3wppfJzBgN0JGaB14tjos9c0=;
        b=Q+TmW/roG4k+tejpfFry3lutYo8+nsqkPocgK+U9Ez5mH9ey5+jTNs4GjWy3NlRN0k
         UlNrZvX6PNXX1dNwxmplhDKfYU+L1H1nQ4w2765jkRpdJdzzzCNQkWPZ9MOhKyA26n2V
         lhcSlSUFU7yE0PVB01quV9BN2ilxUOg2blO0qNqJehQB2KgpIrBiGdHxzL/r2tBFnMi/
         MZny2ap41FAbE7IaCnJZTwNB3QEQ7wQ38fa8NmiOa2sd2yJfJxXpbLkKqn+H1i1gyIi8
         uwyg9axR1h+J8UmOPdYsLa0KNB4iBXD6OYJpChmOwKAqz47HDdRCwuMHK9h3XIRqXNZW
         3TNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EnmmDyggAPflRAaQCTg3wppfJzBgN0JGaB14tjos9c0=;
        b=ZQhB2sP5x0SBx5JqpzkWaiQQILS0BlgfaCDzD0s1Rigd4/+RR1MRSLunHJ2iYd/ZEU
         S48YT1dSw6wGGncItwIvUP3oloy4QWk9qNI1IWHLNQNAmk9GQGaHWJhiPmLadstALjTk
         uzpKHV39iTJVoCiOhMjA04Cwv+M7Ce/uOj27NNI7Os5rYzCZ2LrWCYPccgp5DJfwQUKs
         Y2J88FaHSp204lCrIbNcPlOBkZlogVJlQqvgbSR9WpAqrnMFx/WdduDx3YfACFWTh+L2
         jzO2Jn7WfEQjcu+u9789loz0/srTOogQ4LMRIXGu5ikwBosBg2/CQXlQ609L6R2fN4HY
         7LJA==
X-Gm-Message-State: AOAM530zG2eyZ//wVOmCUQigx2KAnwF75gS/oRvkL3h69GH7lXKhRfR2
        lnlNdCorV3xoBNInEz1M10hs8w==
X-Google-Smtp-Source: ABdhPJxNCgPMDHZiGsXzDevWQJr0r951c/0Rvmbk8hQ+TO2TIhuPA8AFqJo1qAkmK4vk0bzTHeloNA==
X-Received: by 2002:a1c:541a:: with SMTP id i26mr3888198wmb.75.1616515197459;
        Tue, 23 Mar 2021 08:59:57 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:91e2:6a05:a4ac:7d0a? ([2a01:e34:ed2f:f020:91e2:6a05:a4ac:7d0a])
        by smtp.googlemail.com with ESMTPSA id c8sm25845957wrd.55.2021.03.23.08.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 08:59:56 -0700 (PDT)
Subject: Re: [PATCH] powercap/drivers/dtpm: Add dtpm devfreq with energy model
 support
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     cwchoi00@gmail.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org
References: <20210319162836.9364-1-daniel.lezcano@linaro.org>
 <9a9931f4-ece5-4fe9-5f88-871a2e759200@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <030ccf82-cc25-7287-7409-d33a2dbd2cee@linaro.org>
Date:   Tue, 23 Mar 2021 16:59:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9a9931f4-ece5-4fe9-5f88-871a2e759200@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/03/2021 16:56, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 3/19/21 4:28 PM, Daniel Lezcano wrote:
>> Currently the dtpm supports the CPUs via cpufreq and the energy
>> model. This change provides the same for the device which supports
>> devfreq.
>>
>> Each device supporting devfreq and having an energy model can register
>> themselves in the list of supported devices.
>>
>> The concept is the same as the cpufreq dtpm support: the QoS is used
>> to aggregate the requests and the energy model gives the value of the
>> instantaneous power consumption ponderated by the load of the device.
>>
> 
> 
> I've just started the review, but I have a blocking question:
> 
> Why there is no unregister function (like 'dtmp_unregister_devfreq')?
> Do you consider any devfreq drivers to be modules?
> 
> The code looks like an API that it's going to be called directly in
> e.g. GPU driver in it's probe function. In that case probably the
> module unloading should call dtmp unregister.
> 
> Could you explain this to me please? So I can continue the review.

Just forgot the unregister function :)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
