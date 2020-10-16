Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0632B29058C
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 14:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406381AbgJPMug (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 08:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405632AbgJPMuf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 08:50:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBB2C0613D4
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 05:50:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so2810178wmj.5
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CrMlB8wZnz1QSRMDLaaqihjuRkl23NGRAQ7yTr/KKgU=;
        b=Clni0cNlsKDQqQNx9Z1oea1qbI5trbL18Iwm/RppeJEeDU5onspHP+KN+DucCmqcpr
         83zcVFENnk98nG7FAfwFElxxybgV2pzT2pSgM81VeOQzDSMxo3KvK/oBUr6gZENqPREC
         Qkfm1jEKyT9XhdjMCrNsYLL4T+qZTbXTOOm+PYNIyqgd9H+V5BiMUcGSlQBkNyj9kBHS
         HJu9xFj7y65JJdwxs8rQkmrNYeKw8u6w4LcCr+IKygGQmg6FCDKpfEsjYX58XNWbY+MS
         fznHd8MrGWW6vLo0g1BieoHkqw4Rk9MDTCiFEdSwEsYwURoaoU9zpKfa4hxH3a57OMDJ
         9kBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CrMlB8wZnz1QSRMDLaaqihjuRkl23NGRAQ7yTr/KKgU=;
        b=JJEsh/PQh+skNMP1NCi/QPo/He60lOz3C2PukEtRtiMx/amaybsF35RwXwp0oBfnG2
         hVgoTGsPivgAkRaa5fgHOLarzuXOqKSDaYokovItlcLPJ+k5UQGHrhxHSNGXb4KQDdv2
         mXF5Pvj6Ds3s7nJm/j+DJDw++GggQCDu26Y8SksS5B7Ku+VGJV2RY6GJKvH68xcOTQlb
         +MZt+Y+35c6kv0sUOwpGMlqkdaskU0kO3QFMOew8Qai4tvjtcXWvV+vj2vvRQCmaBw5C
         lw2BY5CwFyXl7xlc1fvGyTIwZ6GijmbKZSKNTFpo8Vow+nV7HuJC4be/u7sWtii2Mp1F
         Vx+A==
X-Gm-Message-State: AOAM531wnwxm7bh7+AqiAhC4pSWBkxSMoUBMiTSUuagew0M8dEbVsHno
        p3Tx673pQsn0Em1gsmQgZEGGxA==
X-Google-Smtp-Source: ABdhPJwc6OQCnkD3OpBg2RnakL6syJWoFj3OemWf0bJrqBo0e6K5q4D9gFKaC16wyZgW5X4c9QHMMw==
X-Received: by 2002:a1c:495:: with SMTP id 143mr3543475wme.63.1602852631989;
        Fri, 16 Oct 2020 05:50:31 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c9d8:1700:5168:39b? ([2a01:e34:ed2f:f020:c9d8:1700:5168:39b])
        by smtp.googlemail.com with ESMTPSA id 14sm2610405wmf.27.2020.10.16.05.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 05:50:31 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     Quentin Perret <qperret@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
References: <d2960f6a-1805-1fb4-98ae-4a756d20370b@arm.com>
 <765e6603-b614-fb72-64ff-248b42474803@linaro.org>
 <b19c1f12-b7cf-fcae-4ebb-617019effe2e@arm.com>
 <55d3fb0f-f7d8-63c5-2bdb-53eaa62380e0@linaro.org>
 <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
 <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
 <3e3dd42c-48ac-7267-45c5-ca88205611bd@arm.com>
 <00ceec64-3273-bb4a-6f38-22de8d877ab5@linaro.org>
 <CAJZ5v0hV8fwRnADdjiiF=zapO3AE6=_W_PeOQ_WhUirCcFkgdA@mail.gmail.com>
 <e321191c-61d2-a15d-47c2-653b277984ca@linaro.org>
 <20201016121844.GA2420691@google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b3c6d7a5-0564-6e84-77ff-9afe10d7ee27@linaro.org>
Date:   Fri, 16 Oct 2020 14:50:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016121844.GA2420691@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/10/2020 14:18, Quentin Perret wrote:
> On Friday 16 Oct 2020 at 13:48:33 (+0200), Daniel Lezcano wrote:
>> If the SCMI is returning abstract numbers, the thermal IPA governor will
>> use these numbers as a reference to mitigate the temperature at the
>> specified sustainable power which is expressed in mW in the DT. So it
>> does not work and we can not detect such conflict.
>>
>> That is why I'm advocating to keep mW for the energy model and make the
>> SCMI and DT power numbers incompatible.
> 
> I think it's fair to say SCMI-provided number should only be compared to
> other SCMI-provided numbers, so +1 on that. But what I don't understand
> is why specifying the EM in mW helps with that?

It is already specified in mW. I'm just saying to not add the
'scale'/'abstract'/'bogoWatt' in the documentation.

> Can we not let the providers specify the unit? 

Yes, it is possible but the provider must give the 'unit' and the energy
model must store this information along with the "power" numbers, so we
can compare apple with apple.

Today, the energy model is using the mW unit only and the providers are
not telling the 'unit', so both are missing.

Because both are missing, it does not make sense to talk about
'abstract' values in the energy model documentation until the above is
fixed.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
