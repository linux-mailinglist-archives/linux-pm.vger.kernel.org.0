Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C06A2C5723
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 15:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391069AbgKZOaK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 09:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390058AbgKZOaK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 09:30:10 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3910C0613D4
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2020 06:30:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s8so2334960wrw.10
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2020 06:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qjw5BGAC1OUkdIRzZbjBG7uO0JS7gQo7z8PLbOgPVdI=;
        b=EyS7VzGk5OS+wfql1FLOoKeYvdNvog/Hw/jR40GT6uXA2EFvPQqmCg/8v4yn8OjoEU
         HtmSxJ/+k/iCqv2v70Bq0Vngpx8EoNyd66FoxioCW2bo4vsMJlc5Bhtb7d5fP39jKVBb
         4ABRg+zTUQ+nSZu0AEqwdLlvEyPWNCKavAjQNzGcagejujtJ3pBkZpibNEAChuem7hCd
         kuLH21hWrvkIs3HGnWaLg3hnX6tP9No0vxRbcv+773kn4yCFIbtsx/jP3w94eyFcNe/c
         SDYT5gOpsiGELv9nAAcHvLkV8T3pjHEITJYf+3QCqsHStgTtlOLy8zPiuRAKc+xSkDfj
         vYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qjw5BGAC1OUkdIRzZbjBG7uO0JS7gQo7z8PLbOgPVdI=;
        b=RCqVTVNcomrPBDjyKxWEKkPEG2iGD6Ixt/njHxVzy0/hFKwij/0OkySCOtP0pMUoDq
         kaSqsDMWqFd92aIBSmgOWu7+cKTsapiBvj04wgvArgdr232LmLiXhvOqG5Yd9x+jtjBJ
         7W33UFq6zjpIWLV5n71eymuCPpAjuDFXqgyBclxkGHnDKuqIJX490MJLW8nu+x4CYUzb
         PBfvJTkjFbzDvIbjPFuyNML6GGwx1XEf5ncoWiu+oTK8+EtTqQqxJebvO0oISVqjyteF
         2L5+J+5Mq6Nu+E7HGMgj/EKG29QJVGOhct3lNSxyCEeE4F99R+0H9W6TNsZiggW0EYOG
         Ju3w==
X-Gm-Message-State: AOAM5339KN+hct446kzZ4dyVmnTvO4w1o7ozLP76Qk3ANJ7Ma/1qQCpx
        T1jWUbS9XHrcCEI8RWjZ01XCfg==
X-Google-Smtp-Source: ABdhPJywrnVvV3+/kgozQi7zTGjBuawogmdUdh1QH2TsfW/amIudAmYPyYaILHVuPXdhACmIwNsy9w==
X-Received: by 2002:a5d:4802:: with SMTP id l2mr4139880wrq.424.1606401007282;
        Thu, 26 Nov 2020 06:30:07 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:c023:e75f:e8c4:d86? ([2a01:e34:ed2f:f020:c023:e75f:e8c4:d86])
        by smtp.googlemail.com with ESMTPSA id u129sm8211203wme.9.2020.11.26.06.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 06:30:06 -0800 (PST)
Subject: Re: [PATCH v4 0/3] Improve the estimations in Intelligent Power
 Allocation
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, Dietmar.Eggemann@arm.com, ionela.voinescu@arm.com
References: <20201124161025.27694-1-lukasz.luba@arm.com>
 <e953e887-0fc7-8375-9e5d-1be339f48216@arm.com>
 <f9899f7b-0bc9-40e2-4969-eb76bd11ed5b@linaro.org>
 <ef6bcc10-7034-0ac1-b832-938393682d2f@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fc3228c2-d668-6f32-8965-00896b630351@linaro.org>
Date:   Thu, 26 Nov 2020 15:30:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ef6bcc10-7034-0ac1-b832-938393682d2f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/11/2020 15:02, Lukasz Luba wrote:

[ ... ]

>>> changed via sysfs.
>>>
>>> Could you take it please? It should apply smoothly in your tree.
>>
>> Actually, I'm waiting for Ionela and Dietmar ack.
>>
>>
> 
> Are they maintainers of this file that you need their ACKs?
> Maybe I should drop mine then.

Ok let me clarify :)

In general when someone comments on the changes, I usually wait for the
consensus before merging the patches. If the persons who commented
before are unresponsive, depending on the context and my perception, I
apply the changes or not.

I'm giving the opportunity to Ionela to review the series again as she
commented the previous version (and gave a reviewed-by). I thought also
Dietmar commented the series but apparently I was wrong.

As you stated, you are the maintainer of the subsystem, so if there are
no acked-by or reviewed-by, the series will be applied anyway soon.

Meanwhile, they are in the 'testing' branch of the tree, the antechamber
of 'linux-next' and 'next' ;)





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
