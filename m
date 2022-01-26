Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5485149C6ED
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jan 2022 10:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbiAZJ6F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 04:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbiAZJ6E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 04:58:04 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495DFC061744
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 01:58:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so1640301wmb.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 01:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ARleMNp44KlMl6F3BCFO3u+GyyJQUa6qimUwmZ0NEoE=;
        b=RHuHyuSWNStBP0UIRFM9k2rxdN90Jmxxif+b+FZNwtvojfAR58aFrXsOvmBmkuZtY5
         /0NS9Hcus1UFbb5MM2icQrPIirbRpArX2FozDCOkOYpzd1EX2kPynaRhoiUJCrevmRYz
         yCUJa8NceZzBwt0q3gZWGzHrzCsg1oUJgoiQA3MrNS83GE018qhDX4TgX6moRDMU5Pja
         /TmPKPv+J22/VCcKgTUUMH14nbA3gPWAaVUfrpBUcMsdGW5E7mhO26FimCCHAS/AJKIK
         soJDSG+Ya+seyAn6OzMPcfRNe7eZ56QuDqxb/3DXMJW0Vb/EQKvSyHFR07F4VNFISl4v
         AbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ARleMNp44KlMl6F3BCFO3u+GyyJQUa6qimUwmZ0NEoE=;
        b=GVUkR2L/EK8rt4QTqaHD5pmiqCrYWXo0YyLD+AjZv+w35rVkm6Yss162kiE6NdtSG7
         kzV8z7M+c66XcQ1hzIkoVhJr/rnzLJiJZddKg2z8SAsEUvlXmTc+9RNipcBF14PRstgb
         LZMRtZgI5BPlT0xtq4H0xdjp0xRfCsgwEBKbLs+yHLR15s471EXbaVXtyyZBvoA42m8R
         H6qTlFW0/PaU15uI/VyJ80KIFYu617St89JJoBHsz41fURtGvQtwYhoRUBBfDWKz+aQg
         sm5bkOFZwT129a6peSxm7Hp3LhLf5+WNYAJENPpAhmJ9WhYOcLwmZlH9NDLTedYwf8fL
         5xhg==
X-Gm-Message-State: AOAM532lkAguwlqZ+k+IqtaUiGNHU32ajKlrgmvm6N2N1HFP/C459lG7
        NOHBBe1YAdQEDptF93uKAGJntg==
X-Google-Smtp-Source: ABdhPJxKsNc1gAQKS8O1k2JMAgG+xaSFr57soS4gyfXzq9Yn9kT1C+cKSY2BdeKQzRQc8MwfP227Fw==
X-Received: by 2002:a05:600c:a47:: with SMTP id c7mr6709918wmq.23.1643191082783;
        Wed, 26 Jan 2022 01:58:02 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e? ([2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e])
        by smtp.googlemail.com with ESMTPSA id p2sm2706409wmc.33.2022.01.26.01.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 01:58:02 -0800 (PST)
Subject: Re: [PATCH v7 5/5] rockchip/soc/drivers: Add DTPM description for
 rk3399
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>, lukasz.luba@arm.com,
        Heiko Stuebner <heiko@sntech.de>, arnd@linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
References: <20220125171809.1273269-1-daniel.lezcano@linaro.org>
 <20220125171809.1273269-6-daniel.lezcano@linaro.org>
 <CAMuHMdXZEYNjFh2T4beWdfn8av_qXaPbg4yFk=9whESnLBaFAQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <31c6898b-e6f0-5118-119a-13e01e9fa507@linaro.org>
Date:   Wed, 26 Jan 2022 10:58:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXZEYNjFh2T4beWdfn8av_qXaPbg4yFk=9whESnLBaFAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/01/2022 10:40, Geert Uytterhoeven wrote:
> Hi Daniel,
> 
> On Tue, Jan 25, 2022 at 6:18 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> The DTPM framework does support now the hierarchy description.
>>
>> The platform specific code can call the hierarchy creation function
>> with an array of struct dtpm_node pointing to their parent.
>>
>> This patch provides a description of the big / Little CPUs and the
>> GPU and tie them together under a virtual 'package' name. Only rk3399 is
>> described now.
>>
>> The description could be extended in the future with the memory
>> controller with devfreq.
>>
>> The description is always a module and it describes the soft
>> dependencies. The userspace has to load the softdeps module in the
>> right order.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Thanks for your patch!
> 
>> ---
> 
> Can you please insert a changelog here, especially if you don't CC all
> parties on the cover letter?

Ah yes, will do in the future

> Yes, I can get it from lore, but it's easier for the audience if it's included
> here.

Changelog:
   V7:
   - No changes

   V6:
   - Made rk3399 always as a module and added module softdeps

   V5:
   - Module creation





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
