Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33374343B45
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 09:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCVIIm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 04:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVIIk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 04:08:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CD3C061574
        for <linux-pm@vger.kernel.org>; Mon, 22 Mar 2021 01:08:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso8724304wmi.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Mar 2021 01:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b7CN6JdpOmja3Ya9/8A0Yc6qp4xL6xo6CnNKb5MDcgU=;
        b=Qw9T73UaV1U8h8LxfGhg+9skYAOyd6FhNRHGzS4USWYsbHsCjClsUwuTZe58023L2x
         jfJ76qnzVXyYwINInQ3FwPaBMCdLhJfnzwcKrLrSutmCMf9CXDZGsElLC8gML9xnUPjw
         bUOUnZCl2LhHlq7VjJBqOj0h4nRIlhWnfBccMdDByAvmxboyybHI7vFlZmiKIn+SkhZt
         9yWNmGwUZBtkyeg+8y6P+CFg6/7TVQDcZYo6vKNR5TLFVUFr3L7JoLULclDYO+tLcNsX
         TQQYvgSAnn3l1yzRKXJDsmmFU2xK4XLnD4D1Nc59SPi5RB/isg2iMmCK1pqeopAmq0Ql
         Dk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b7CN6JdpOmja3Ya9/8A0Yc6qp4xL6xo6CnNKb5MDcgU=;
        b=XLDGwb7oKuBXcfm0gPS6KTZwn1/0KFMTIy1FkuzMzPGUReM6CVOxxolJNvjK27F2Cj
         YtAFbfpRBrD5h41Bbri/qpkt9fuNvl+2txYkHCUjDeDVz1J32RsVKvEXwKG3XySfsBKP
         dnljFHIN8vThoxcx6Iqgu5NAdAm/EAndtWoQlv+EgO65NYT2JuaAc2RQMokllFD7qRht
         /2R/mHIfFTs+XNNZy2qRAlsZeS74jd6pQNKN6SGVn+O6yX1POtGY8lYYTNflywwUq7kE
         3XBQbgJTE4vpPDcLGAWyXXDjBzIzWI/MMF7qVUTi5qxxWNslbb1dOFBpTfgdHKAAnl9e
         BmhQ==
X-Gm-Message-State: AOAM531ppQr1MPWCukzcOKyQURKQjsR372cuieBk37YN+FVBx7bUrwl3
        QbGKijAm6IFxBUAPvqwoT/3/bA==
X-Google-Smtp-Source: ABdhPJz2mztkkc3xYlJs3i61gDWH1UuGnnW5WMrLPF7qAO52KtghzeIEso0c8MS13TDrtALhC7NbYQ==
X-Received: by 2002:a05:600c:2cd8:: with SMTP id l24mr14511400wmc.88.1616400518535;
        Mon, 22 Mar 2021 01:08:38 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d8b:d5f9:2138:169c? ([2a01:e34:ed2f:f020:d8b:d5f9:2138:169c])
        by smtp.googlemail.com with ESMTPSA id v7sm16067242wme.47.2021.03.22.01.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 01:08:38 -0700 (PDT)
Subject: Re: [PATCH] thermal/drivers/cpuidle_cooling: Fix use after error
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <YFMpUDNGIiLOzr0/@mwanda>
 <20210319202522.891061-1-daniel.lezcano@linaro.org>
 <20210322032946.jstyrnc6dctq4fzj@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dcbf21e2-e2da-7e0d-66bb-ae7f4dc28858@linaro.org>
Date:   Mon, 22 Mar 2021 09:08:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210322032946.jstyrnc6dctq4fzj@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/03/2021 04:29, Viresh Kumar wrote:
> On 19-03-21, 21:25, Daniel Lezcano wrote:
>> When the function successfully finishes it logs an information about
>> the registration of the cooling device and use its name to build the
>> message. Unfortunately it was freed right before:
>>
>> drivers/thermal/cpuidle_cooling.c:218 __cpuidle_cooling_register()
>> 	warn: 'name' was already freed.
>>
>> Fix this by freeing after the message happened.
>>
>> Fixes: 6fd1b186d900 ("thermal/drivers/cpuidle_cooling: Use device name instead of auto-numbering")
> 
> Why not merge this with the Fixes patch itself since it isn't there in Linus's
> tree yet ?
> 
> Or is your branch strictly immutable ?

Hi Viresh;

The changes follow the path:

testing -> linux-next -> next

The branch next is never rebased. The patch above reached it. This is
notified by the thermal-bot [1].

  -- Daniel

[1]
https://lore.kernel.org/linux-pm/20210314111333.16551-3-daniel.lezcano@linaro.org/T/#ma257519efc70ee60faca47dbd458b05de5449bf8


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
