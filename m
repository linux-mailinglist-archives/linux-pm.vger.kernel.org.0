Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CCD2B6C2E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 18:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgKQRr5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 12:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbgKQRr4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 12:47:56 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A129AC0613CF
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 09:47:56 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s8so24040889wrw.10
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 09:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/nkpqjIgajzlSdFhAUa91rI3DlJHkmeiloPK1fP0SuU=;
        b=ITHEpjke8j1Fe0rmPjqnxJtQ56VYaMsryc4jDB4Y1zTbi2QPgQ2+KgVVLXghqB+XzG
         vRRqAMnuUTyv8y6QVXDYqXhXV6Kr8ifAuBwY2NvhzLp5PhT9TCHlfnZVm59AcdSatE5y
         ygapViTD6nj80KooOIoyv58gESQmaIV4yLBVM+x54832YUCTV9+EJIzp4EJA0hYEPaxI
         Znp0LY2kDgSLz9Jm/Q+KMwAYgTskuUVAK01BcvQ8b3iUZrfhuFuI/oHZ2NRQwHoQ8z3L
         uKeJ2iRtr2pnAnKxPspyT2gvKBQsnAh9LCSmrTPMLojK1vW0YZpsA+dSeld8qI6u9ymk
         527Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/nkpqjIgajzlSdFhAUa91rI3DlJHkmeiloPK1fP0SuU=;
        b=al7km/6SMBh+0FF5tCO4LpzkR/D2ZO5vJlcXTf4DUYjdoBEla8ukczUjETrv7bYcOt
         sz5dXsZIT6CqWxQWo5XfXhhcQa6/85GZFLCzWwYo+NC6cLCSAYD58n2DFuikafU/SNqC
         qJSplwhf7TdCwYnnEK/nXFW2cf34rx3PvPhIfO0pnvvKvdDs9CMllBcGeS2Nj+Fu9I59
         UrjsbzC8RTiWdiTv6sR61TBG3Dl187eBW776MQ/w7u+Bmg1F7zk9H2mlcsoCMBQoyxUm
         GaHsnHZh5LbazkdjwSlwfF/FC5odsTidvqBjp0the7c9bpdCjLd0U8kPsMQL17kW7WTb
         zd4A==
X-Gm-Message-State: AOAM533j93ax5ssmpqR3jwmTX6OrxybIVswnwqh65CLXvOS4X2LBIdT9
        b4Meg4G0PAEkc9+1uowwD9PiTQ==
X-Google-Smtp-Source: ABdhPJzhNHNPbz+hZfvLGzDAC2GIpacCKf+qLy2usgtuYSXjedZu0Xn3+JdU9qVQUahzlQbamiD49g==
X-Received: by 2002:adf:fd0e:: with SMTP id e14mr660096wrr.119.1605635275236;
        Tue, 17 Nov 2020 09:47:55 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:5150:1004:6c70:8db9? ([2a01:e34:ed2f:f020:5150:1004:6c70:8db9])
        by smtp.googlemail.com with ESMTPSA id o184sm4572351wmo.37.2020.11.17.09.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 09:47:54 -0800 (PST)
Subject: Re: [PATCH v2 2/4] Documentation/powercap/dtpm: Add documentation for
 dtpm
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilina@codeaurora.org, lukasz.luba@arm.com, rkumbako@codeaurora.org,
        rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org
References: <20201116152649.11482-1-daniel.lezcano@linaro.org>
 <20201116152649.11482-3-daniel.lezcano@linaro.org>
 <20201117090856.27eddac7@lwn.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <18603f39-a540-5425-2a56-58265f7881d3@linaro.org>
Date:   Tue, 17 Nov 2020 18:47:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117090856.27eddac7@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/11/2020 17:08, Jonathan Corbet wrote:
> On Mon, 16 Nov 2020 16:26:47 +0100
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> 
>> The dynamic thermal and power management is a technique to dynamically
>> adjust the power consumption of different devices in order to ensure a
>> global thermal constraint.
>>
>> An userspace daemon is usually monitoring the temperature and the
>> power to take immediate action on the device.
>>
>> The DTPM framework provides an unified API to userspace to act on the
>> power.
>>
>> Document this framework.
> 
> It's always refreshing to see documentation show up with a new feature! :)
> 
> That said, it's clear that you haven't built the docs with this new
> material.  There's a couple of little things I would ask you to do...

Thanks for the review, I'll take care of your comments and generate the
documentation to check the expected result.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
