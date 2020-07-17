Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64804223280
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 06:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgGQEl4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 00:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgGQElz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2020 00:41:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF8C061755
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 21:41:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so15238653wml.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 21:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e92SkAAyZTPdbiUDDLKt4ub11HxoW06Bz+od+u+J3rk=;
        b=QYlBGm2n1WOvNPFxDMHEX5j3VsP2tSLKuUYmhOWujHtdQn5gIwgmcCpynAyj+paJ5k
         HS1/1SPIVem4wy3VkGTEPOW8DGuheluydFgtiyZDpIWhr+PdnmiQbPqqTTS3QlJ+3muH
         ZO1CKwOIpTgPpIx8TGCnwMoI4eBFZs0xMosVkPbNbmH9AjiByt5MFwzxBHCnx6278DbL
         euO66DN5RSmAwpLYAw+jMWNU7EmoOzK+c91EunAxlmzMqKz2bqKRj2A+Ttaw+jFDiGLY
         KVNAarLaNzSLjLKga2mu4SOCk+pSJ16UzdxoPw83Nd/b/pVMMSlyC/yudQq1oGZlrHws
         DeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e92SkAAyZTPdbiUDDLKt4ub11HxoW06Bz+od+u+J3rk=;
        b=A8uRb9F4D36FDm3Hr9rytQHomCLbjchiM59gjJC5OHxv5E+enk14dbf0o18zs5SymG
         xG9pu05evZyOA0GhYgrLfOyp/aVC2yjCAIUuhuB7HMOSaKh1kVwKst9HCtOxWT3TA71N
         8rp+qAkWbbf30QedbrzRMQrFoIB6wgw2N8dPKwU4S2AQV2mnucIdC/XOyEHFT4+yvfjV
         g3+iK/v+yzCgBvu5r/9T71BzuydI29CTKexvR0LQA7i/UHL4golYqhFzaN4hqq1WKx80
         HdKwoOqWx1trgnaFyhwlusWEgkJMTw6d0GO8Rj3A6MmMnww9cVKxbECSPgnNKBn2+kfR
         u7BA==
X-Gm-Message-State: AOAM53295JbajoGNL/MtKXNwNm8RY/WxzTlYzjBsT44tmQO3/VhVAbnt
        e2Inbv5sCnA5CmFRRhOtZadPmsYbiOY=
X-Google-Smtp-Source: ABdhPJyhdG/qFhVvJwxDNm3W2ApPczeqwAnc0F2Kwz7lRaHf6kvkVNG/Vb56gm/e4WPhAmTujcfNoQ==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr7425817wmi.49.1594960914036;
        Thu, 16 Jul 2020 21:41:54 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9880:a643:3e69:6393? ([2a01:e34:ed2f:f020:9880:a643:3e69:6393])
        by smtp.googlemail.com with ESMTPSA id z8sm12071528wmg.39.2020.07.16.21.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 21:41:53 -0700 (PDT)
Subject: Re: [PATCH -next] cpuidle/pseries: Make symbol 'pseries_idle_driver'
 static
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20200714142424.66648-1-weiyongjun1@huawei.com>
 <159490401706.3805857.7133480973769495238.b4-ty@ellerman.id.au>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <90efd96c-ebd5-3fa2-12fa-d76cf82e1cc2@linaro.org>
Date:   Fri, 17 Jul 2020 06:41:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159490401706.3805857.7133480973769495238.b4-ty@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/07/2020 14:56, Michael Ellerman wrote:
> On Tue, 14 Jul 2020 22:24:24 +0800, Wei Yongjun wrote:
>> The sparse tool complains as follows:
>>
>> drivers/cpuidle/cpuidle-pseries.c:25:23: warning:
>>  symbol 'pseries_idle_driver' was not declared. Should it be static?
>>
>> 'pseries_idle_driver' is not used outside of this file, so marks
>> it static.
> 
> Applied to powerpc/next.
> 
> [1/1] cpuidle/pseries: Make symbol 'pseries_idle_driver' static
>       https://git.kernel.org/powerpc/c/92fe8483b1660feaa602d8be6ca7efe95ae4789b

Rafael already picked the patch.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
