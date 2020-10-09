Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0752899B7
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 22:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733021AbgJIU0O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 16:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387846AbgJIU0O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2020 16:26:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5318C0613D2
        for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2020 13:26:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v12so11015219wmh.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2020 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hYOxM4PpYJSaeSQ+XPte6Uj4UYHx5vN6QsY6Km7XsLk=;
        b=RhJIbuoP0KsitKkPaGbKDgqu5hJPfYFOTaLkPbYjK4Sh9AMdupXbOieF5DC/LSC+Fh
         PnpHiXAV6qQPFJh1JlDek34BgT7HL3X+3llmpDbcpU7vRTgUw+NakNNiPraWbzWzsDH4
         PpTAQ1jUhfnNmc5QPsjXX8WzSImUXGhknHL9A6neKdsTuoKt7XQMa1E+gPPN6qn3NxXu
         /18edD8SPPKQSPU4BXSqtUeeW+V7sWPt7eJwQ0jIocsSsSb0TgUW55PpUpcDiPJjDw5t
         0WiHSMi9DXp0WnUz26uRvrSgl3ZTHp6n8ZCBZirvWLsDRUMYdMZc/hwYmhhgCjs1S+eb
         fu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hYOxM4PpYJSaeSQ+XPte6Uj4UYHx5vN6QsY6Km7XsLk=;
        b=NVSUMBlczQFg7eCEneG/NTOF2wi76OtJXF+6LoO+tAegd53Z8qs+gmEjN7Lj00+rT4
         6mI5tdE2PcTcGbYnPeqDrZU2AHZ4hTvDy1+pQJ040utS0qtNUGzTz8FKBaTkvS39IFBD
         s0cRP1/1TM2EU6hOew2kVEBHRl/UkvRSM0XOaf/AmrOgjV59oz6sWtzBcC+EiSgWMGQ4
         IKxgRXIhwpC8ICX07tS3mt2TGeERingCJOsbbW3uQX8skXX+yw0bcBmSOLODvZO+7hrb
         UkzynsV3Yx7+84Q3X/forbJ94rEHRfJWCriKIJNJNb2+cFN8Hir3j91F6kbgbSFVNZI2
         V3fg==
X-Gm-Message-State: AOAM531+IxkY5Y9hK6YYNwye6aLEZJLYgEGcNFkQUuqhigBe11nCfO14
        jQmeyBqo6nb4nbXyq3+A7quHuSKJAPkOdQ==
X-Google-Smtp-Source: ABdhPJxbnsENi0PeWaWCNMl2NYvOrAm2/8Yiih0OdRteX/qKpRSYO0H97neU1SW2E6bfQUVjrc/QFw==
X-Received: by 2002:a7b:ce97:: with SMTP id q23mr15507627wmj.19.1602275171470;
        Fri, 09 Oct 2020 13:26:11 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9c49:1413:45db:f86a? ([2a01:e34:ed2f:f020:9c49:1413:45db:f86a])
        by smtp.googlemail.com with ESMTPSA id f14sm14536712wrt.53.2020.10.09.13.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 13:26:10 -0700 (PDT)
Subject: Re: [PATCH] cpuidle: governor: export cpuidle governor functions
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <010101746fc98add-45e77496-d2d6-4bc1-a1ce-0692599a9a7a-000000@us-west-2.amazonses.com>
 <CAJZ5v0hJJxxb+J5UtyZe2S_Tn7ARoGvjwDjw4dq601VJrriH9g@mail.gmail.com>
 <20200922161215.GD30658@codeaurora.org>
 <CAJZ5v0ipDRkPe6N9B6RzvHyCBobz8B9EoBfPh4DANrL_e86+Ww@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bd62ffea-9736-f8f7-6a48-13e81f802aea@linaro.org>
Date:   Fri, 9 Oct 2020 22:26:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ipDRkPe6N9B6RzvHyCBobz8B9EoBfPh4DANrL_e86+Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael,

On 22/09/2020 19:27, Rafael J. Wysocki wrote:
> Hi Lina,
> 
> On Tue, Sep 22, 2020 at 6:12 PM Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> Hi Rafael,
>>
>> On Tue, Sep 22 2020 at 10:00 -0600, Rafael J. Wysocki wrote:
>>> Sorry for the delay.
>>>
>>> On Wed, Sep 9, 2020 at 12:15 AM Lina Iyer <ilina@codeaurora.org> wrote:
>>>>
>>>> Commit 83788c0caed3 ("cpuidle: remove unused exports") removed
>>>> capability of registering cpuidle governors, which was unused at that
>>>> time. By exporting the symbol, let's allow platform specific modules to
>>>> register cpuidle governors and use cpuidle_governor_latency_req() to get
>>>> the QoS for the CPU.
>>>
>>> Which platform-specific modules may want to do that and why?
>>>
>> We are planning a custom cpuidle governor for QCOM SoCs. With Android,
>> the idea is to make them loadable modules so they can be in a separate
>> partition.
> 
> Well, the $subject patch is not applicable without a mainline user
> requiring this, so it needs to be posted along with that user.

Putting apart the custom cpuidle governor mentioned above, would it make
sense to convert the governors into modules ? It is pointless to have
all of them compiled in, especially with distros doing make
allmodconfig, no?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
