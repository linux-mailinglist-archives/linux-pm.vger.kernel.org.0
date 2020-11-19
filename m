Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755B92B9C77
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 22:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgKSVEP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 16:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgKSVEP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 16:04:15 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC926C0613CF;
        Thu, 19 Nov 2020 13:04:14 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id d17so10279226lfq.10;
        Thu, 19 Nov 2020 13:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vuoOcEDX9Qk97tEXio5KifV8glbdNQVJZyvTphvDqvk=;
        b=Z7nCUKE/RQ9qg0YGyxWOSuPZzYClCIPVG4dDKfgZzvnvTz+99/YQDvGHCnf2I8CnGW
         pkAsHgEoGSwjk8OYL63JspMqMqxAzRUP5d0wxkfE4lVzgYFcZMXxvfmRsSvUvWQPyP7x
         LahO0WpXbtbIKsm9ZwYvUbynYvK0V0wg/JbPCCP5/9fsQDK9lQ3hCVM+eaEDvrFjMMMt
         DjRG4PfvdeoM2ECV8SP01up2ardmTKM4KOC/SwGwFlTeWnVtvfcswkdL+mxdxijByohA
         49fnigdv7xhIi6jPOhXAN2/jDVK5yfVH2dXU5Zi4oxPj+yCg+xe9hQfco0qZEaGUeZfI
         NVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vuoOcEDX9Qk97tEXio5KifV8glbdNQVJZyvTphvDqvk=;
        b=IL18VSMELiBKzlrzQTROIRGPzjCEsSsWVOwCNma7bbBc5V6UAS+YcGgW5z+RYr4FFu
         xg2SZyYE6jhawyAc6paOBQ7n/uhimPK4uPRV0OyuIC4VyWEwB8xaHlZhmPdHavooJ5dt
         yWvtkrag/sW77jzkrHHCyYmyha3rQMW/h1tmG5UDEH7cABaAJJ2JK5ksO7M7+uG9PQed
         3qB3qLXzhzKA37IOxnqYEqwaGiXlmjrFAxALAC25hQ74OmtrkUZZr7IxvQKYKYlNzcOr
         lkg/zNEkpXa/hTXotE8bv6914PXiArLfO912DEXKcJizs2vPsbSQFIdrymNSN1U5Octn
         gWyg==
X-Gm-Message-State: AOAM530hYJWAzCZXHlAZMsujzYI6v7wUhBL9jBvUNr0SuKVDyjxuaSTp
        sJKoiOGjKq5e9Vl55xMm4q7XXL4wVDw=
X-Google-Smtp-Source: ABdhPJy+CtxWZMIEcLdTw+ve3E4A1aRfbrnZczo8enZeKkTgfMpY2z1d+lCeAwy727IwHQB3omIh1g==
X-Received: by 2002:a19:2390:: with SMTP id j138mr6480480lfj.390.1605819853222;
        Thu, 19 Nov 2020 13:04:13 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id y11sm91684lfl.119.2020.11.19.13.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 13:04:12 -0800 (PST)
Subject: Re: [PATCH v9 07/17] PM / devfreq: tegra30: Support interconnect and
 OPPs from device-tree
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201115212922.4390-1-digetx@gmail.com>
 <20201115212922.4390-8-digetx@gmail.com>
 <20201117100705.i62qr4gosvu76o22@vireshk-i7>
 <956315a9-e806-3b18-6792-f01057a6c511@gmail.com>
 <20201118042117.q6nkwm7exakgfvu3@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <150be162-cb1a-4e30-8937-e99cd1c4255b@gmail.com>
Date:   Fri, 20 Nov 2020 00:04:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201118042117.q6nkwm7exakgfvu3@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.11.2020 07:21, Viresh Kumar пишет:
...
>>>> +	/* legacy device-trees don't have OPP table and must be updated */
>>>> +	if (!device_property_present(&pdev->dev, "operating-points-v2")) {
>>>> +		dev_err(&pdev->dev,
>>>> +			"OPP table not found, please update your device tree\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>
>>> You forgot to remove this ?
>>
>> Yes, good catch. I'm planning to replace this code with a common helper
>> sometime soon, so if there won't be another reasons to make a new
>> revision, then I'd prefer to keep it as-is for now.
> 
> You should just replace this patch only with a version of V9.1 and you
> aren't really required to resend the whole series. And you should fix
> it before it gets merged. This isn't a formatting issue which we just
> let through. I trust you when you say that you will fix it, but this
> must be fixed now.
> 

Should be easier to resend it all. I'll update it over the weekend, thanks.
