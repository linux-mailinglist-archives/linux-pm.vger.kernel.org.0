Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5351F3B46D4
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhFYPrW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 11:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhFYPrW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jun 2021 11:47:22 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A16C061767
        for <linux-pm@vger.kernel.org>; Fri, 25 Jun 2021 08:45:01 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bm25so19715783qkb.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Jun 2021 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qSf9Hb89Xvgz4RD0vbZliBhiS0IdcUUlpwW5LDw/NZk=;
        b=vMvWFhL3hrQ2d9on+2SJXtZauw0KvoKA33a/n2K/T0rAnwDpMW6ZOyZAnvoOzyFKlZ
         xSAttO7INFBNysQaglBAlUWKMvKMAYWr8hARRkEzvcTtF+roNUK3hwdF+7kcxde6NeN8
         mZdbdITR3GdVWUv1BJR5NE6ZVlW+4lRuvxCDXFnyFpgVaPVeuABGVKGfLyqY5y81zWa3
         hlXjk8kHCSws3FUr/vMIVp97dLC0F7r1K/F3y095cmJqgfdZdwvwMOa9F5+IO3ILdFlx
         vw97epES8gMju58AE2T5y+R+qC4O3JMzV6Yr5mXvqSW1Qhl7Xx4otY06HLeEydFNQkxa
         bynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qSf9Hb89Xvgz4RD0vbZliBhiS0IdcUUlpwW5LDw/NZk=;
        b=iYE9DkTuBBW7u5GwQCZFfCaJ79StntJHeLmSxv1RCSsbLHMOki8EZxhPKXdlOl5sg0
         HhtSAzTm+swGft7GCCKUJkcFRNF3c2WJkIWhQluFpUJFuoR48YUWqTIjA95x5JVTG1jF
         yijtyZqyJunpCllH/7Js5Pi66xxanZCpg9dYkgNa9raOlBmjdNpknGNk+5CAddxmDqfA
         xWPGxUlsRM8eFKkc7UntOcsEtZw1JbqRVj/VFw2EnJgo35DOqxlAj1wuULN2vRF6P+Cl
         /9bISIBamWTJkk0a2LUeeYTVkIxIo9fVJ7jYtlKC5kpSALZ1ux0lQmaSXLoaZPNv5Eai
         IXaA==
X-Gm-Message-State: AOAM5334P68mq3ZeB/k2FKWhi5lFklmrpmb2JFTCjAJTdUQswdNhEjEU
        UysrUlOL0EJMG0QcvAdc9MUlgA==
X-Google-Smtp-Source: ABdhPJxp4bC6f3KpDQBZ95/st94EeUgklP+Hy2R9giYDMnPyCNasy8cMOXCrU3v0Dq+Q0MPlqyGS5A==
X-Received: by 2002:a37:9381:: with SMTP id v123mr12119650qkd.64.1624635900080;
        Fri, 25 Jun 2021 08:45:00 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id k9sm4018604qtq.30.2021.06.25.08.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 08:44:59 -0700 (PDT)
Subject: Re: [Patch v2 5/5] arm64: boot: dts: qcom: sdm845: Remove passive
 trip points for thermal zones 0-7
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210624115813.3613290-1-thara.gopinath@linaro.org>
 <20210624115813.3613290-6-thara.gopinath@linaro.org>
 <YNS4DeHdxWY1XvvT@google.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <dfc80029-fc40-826a-c9ee-0c843a0a65b5@linaro.org>
Date:   Fri, 25 Jun 2021 11:44:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YNS4DeHdxWY1XvvT@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/24/21 12:51 PM, Matthias Kaehlcke wrote:
> On Thu, Jun 24, 2021 at 07:58:13AM -0400, Thara Gopinath wrote:
> 
>> Subject: arm64: boot: dts: qcom: sdm845: Remove passive trip points for thermal zones 0-7
> 
> The patch doesn't remove the passive trip points (anymore?), but the cooling
> maps/devices. Also talking about 'thermal zones 0-7' doesn't really convey
> any useful information (and the enumeration could potentially change in the
> future), better talk about the CPU thermal zones.

Hi Matthias,

Yes you are right. I forgot to change the subject. Will fix the subject 
and provide better description of the zones in the next rev

> 
>> Now that Limits h/w is enabled to monitor thermal events around cpus and
>> throttle the cpu frequencies, remove cpufreq cooling device for the cpus which
>> does software throttling of cpu frequencies.

-- 
Warm Regards
Thara (She/Her/Hers)
