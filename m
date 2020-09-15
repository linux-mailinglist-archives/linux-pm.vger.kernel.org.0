Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B6826AB21
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 19:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgIORvY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 13:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbgIORuV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 13:50:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25235C06174A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 10:50:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a17so4249420wrn.6
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ra0UwZMSA18qjDYK2AtGt6BQncZY1tBEKXF6zPEuSQo=;
        b=YwKVl4GeDkAYzX8+Xr7omJYjhQPzOKZaZZTBPR6WHuYJVvKOklBaZx/c/DTylR2jWN
         ALjHoraylidjTnkGHY50QKUKtkQwIZ3Z3ydhZufdcUHbgVCV0WqWTB7zSdD5f5IfwaJN
         vKMUn/qdSQuOYN6hY9pOCrX2ohILXF/SgkhzbG5fQHFakcnE/9tEqpLwbFkfydLPFPrT
         MRhxfA6Mb+3Mk60km0jJuT6n0vbyXn1X8yj3niZG2C7FFL5ZAqSwfQM76MBb8k8e7MHf
         2QdB8OanVyDr6UbHsSxJg0muPhGUS4Ytyot/jAKcbCsIU3nzZk5Pq7Da5zS6QlGn8w+H
         Is+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ra0UwZMSA18qjDYK2AtGt6BQncZY1tBEKXF6zPEuSQo=;
        b=k838hS/yIWIh3ZOTU7ZJOkfcfMMBHe150yoTKpMKvGQdnWKYaHlgZWuVM0yP1KyzdB
         5T4RGTUSJbRltvCJn13HjBADE2W6W3CnczVjeL/g6qg8xjAQ33w//+h44OPB4CHNNV9r
         ThgiT32vX4rhAWZ12+dNwrD3w3t21jYoFkleAkjL9GAkumMRqMTEyqrfn7Hm/IzPtCF7
         uGTNWLPukfW063RXEdZ+dxy6Xe24YSEEt2yrn1ja2HsT18RZ8ad1e+sgkWp/XAReBg0c
         p6bFecQXgsS/gZMoX6CqXLXjRFcgwO8AX3w6F5yoL6qjUoTOJ2dyqxbRMVmgJk4gyvCX
         YOrg==
X-Gm-Message-State: AOAM533DRiDXVOZ2+GKgfrx91Oho3v0q6t2W1kTjWtHIgqZwyAQs6RXy
        +t2oQx2XnDaa2PvLgZP5Ys53uQ==
X-Google-Smtp-Source: ABdhPJx1YNcWQv0a8DqwHPEsoCstBIsXnKGLWt8dcuNbAYSyGZEFGGK5zfs9EbVq2XcAtMSEzWUxrg==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr22412835wrx.173.1600192212643;
        Tue, 15 Sep 2020 10:50:12 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a402:e7fb:d494:d130? ([2a01:e34:ed2f:f020:a402:e7fb:d494:d130])
        by smtp.googlemail.com with ESMTPSA id y2sm501910wmg.23.2020.09.15.10.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:50:12 -0700 (PDT)
Subject: Re: is 'dynamic-power-coefficient' expected to be based on 'real'
 power measurements?
To:     Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>
References: <248bb01e-1746-c84c-78c4-3cf7d2541a70@codeaurora.org>
 <20200915172444.GA2771744@google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <406d5d4e-d7d7-8a37-5501-119b734facb3@linaro.org>
Date:   Tue, 15 Sep 2020 19:50:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915172444.GA2771744@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/09/2020 19:24, Matthias Kaehlcke wrote:
> +Thermal folks
> 
> Hi Rajendra,
> 
> On Tue, Sep 15, 2020 at 11:14:00AM +0530, Rajendra Nayak wrote:
>> Hi Rob,
>>
>> There has been some discussions on another thread [1] around the DPC (dynamic-power-coefficient) values
>> for CPU's being relative vs absolute (based on real power) and should they be used to derive 'real' power
>> at various OPPs in order to calculate things like 'sustainable-power' for thermal zones.
>> I believe relative values work perfectly fine for scheduling decisions, but with others using this for
>> calculating power values in mW, is there a need to document the property as something that *has* to be
>> based on real power measurements?
> 
> Relative values may work for scheduling decisions, but not for thermal
> management with the power allocator, at least not when CPU cooling devices
> are combined with others that specify their power consumption in absolute
> values. Such a configuration should be supported IMO.

The energy model is used in the cpufreq cooling device and if the
sustainable power is consistent with the relative values then there is
no reason it shouldn't work.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
