Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D364DB202
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 18:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406399AbfJQQLU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 12:11:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40938 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405983AbfJQQLU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 12:11:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id m61so4366383qte.7
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=L9pt9Z55SHz6CG8upac+m8pqudIdzOY9Z9V3JtoTFX8=;
        b=CWD0eZJmqBiH2XE8MyKfBza0dcM0g01SotBgRXr/jbjJ/BOwr06jeARYbxsc/fJ4k/
         TReD3Pbkg3ynJIY2bI/So7Q7DG5+/WASBbvlAiMhoGHBHrXWD4m4AFPXTkOF6Hvofd4m
         OH3eI2jzaBfJx3R8k4uds85G6pKmgdUVzAr5zwjcxExp3qjxJkfqYcKLR5Zq5Ohyy3aE
         g0fXnM0cjyILXWCs0x0XCoRZ+5yJHf7IIx1+mZoGhm8YQvXiKKt82frSAiBaATeT8D4M
         sBi4OR+8isHHgHJQfzVq64qsVtKCfCfrKm8iD5Sawsj96w1w0kaklB3kcanvbcmHX11w
         IbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=L9pt9Z55SHz6CG8upac+m8pqudIdzOY9Z9V3JtoTFX8=;
        b=KSOZVhTS9rNpHSN38jHHo/Rw7t9N/GwT47gV1+8zHrg4t3e7dwIUQHdVlWJf+0LCLH
         Hd4uKoQP7Z5JEON310XA9X950okZbqvDkq9vIiRRKDzTPhkYBpjZrO0tixbkAMBUdyq+
         7tPMpomv3HPqwucyrOQ13Fw8g/sqf4+u/dBsS1arQGOHQC+/ZMbD+nTcwxclHwq8+0G4
         iv/irUdY502pqCiuTxVpVAzsO0LuaClMmotoLhh3rcH9f/OwYcfucvlk6QqN0MSf7uSe
         qFvSyl9/vhHJt2fOs9anBLFDVEDtKcSbjY8O/tJucD+XHg0mf2C2WIbfHFsw3grjPfhC
         nrgg==
X-Gm-Message-State: APjAAAXPVp5zkdW4kr6A/J4MsaY8UXP+kfbIDm9+68DX/y0wcJaucBY5
        tcasJAJEGZAFLzC0vJ8YiVJVJw==
X-Google-Smtp-Source: APXvYqxYhvCvZWcFbwrydpNgASDDloMQUYWOtz8vH+NDsrbwUIQjGAXIfppyoDcdfl0T4JGQ5gT6+Q==
X-Received: by 2002:a05:6214:2c:: with SMTP id b12mr4686466qvr.10.1571328679237;
        Thu, 17 Oct 2019 09:11:19 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id g3sm1219423qkb.117.2019.10.17.09.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 09:11:18 -0700 (PDT)
Subject: Re: [PATCH v3 1/7] PM/Domains: Add support for retrieving genpd
 performance states information
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-2-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFr76VHypqGxYL-1HS3uu3_KYeO+dGJ7q1Nj=uXiQgY98A@mail.gmail.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, amit.kucheria@verdurent.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DA892A5.5070007@linaro.org>
Date:   Thu, 17 Oct 2019 12:11:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr76VHypqGxYL-1HS3uu3_KYeO+dGJ7q1Nj=uXiQgY98A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/17/2019 04:49 AM, Ulf Hansson wrote:
> On Wed, 16 Oct 2019 at 21:37, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> Add two new APIs in the genpd framework,
>> dev_pm_genpd_get_performance_state to return the current performance
>> state of a power domain and dev_pm_genpd_performance_state_count to
>> return the total number of performance states supported by a
>> power domain. Since the genpd framework does not maintain
>> a count of number of performance states supported by a power domain,
>> introduce a new callback(.get_performance_state_count) that can be used
>> to retrieve this information from power domain drivers.
>>
>> These APIs are added to aid the implementation of a power domain as
>> a warming device. Linux kernel cooling device framework(into which
>> warming device can be plugged in) requires during initialization to be
>> provided with the maximum number of states that can be supported. When
>> a power domain acts as a warming device, the max state is the max number
>> of perfomrance states supported by the power domain. The cooling
>> device framework implements API to retrieve the current state of the
>> cooling device. This in turn translates to the current performance
>> state of the power domain.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
Thanks Ulf! Do you think this patch be merged separate from the series.
Then I can drop it from the series.

-- 
Warm Regards
Thara
