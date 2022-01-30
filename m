Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70174A3869
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jan 2022 20:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiA3TLB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jan 2022 14:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiA3TLA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jan 2022 14:11:00 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F04C061714
        for <linux-pm@vger.kernel.org>; Sun, 30 Jan 2022 11:10:59 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f22-20020a1c1f16000000b003525bf08b1eso3554060wmf.0
        for <linux-pm@vger.kernel.org>; Sun, 30 Jan 2022 11:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M/+f53STiBHRkcS4IGPMxd+HMPefmbpzrpbFyFpBgDI=;
        b=JMTUfDVt/jAgwE6uD4SQKeGTGPu7soib7jix16t/LCqXaNXsUpSoIujT9S/gPFBwqP
         LUDokxLx4PoH+naPh9+qEIKh3/ZHBpu+iNc9yihwLe+hC4hvQA9m8v8YjLLiyYBWIOXo
         lkhOJPj34zjSJVKgEnjzhVxVMws2CMhz/wjfLKRlZbNWu9wzThGdgAuRHibOiUsb3Xok
         2/9mgrQRgZz7CxkvcAinkyodzDwYAwihnbIigmUucFksQ/VUbOD92kQa4pWNg7T5cijK
         42YiEIVkrJ1DCBm6TUr4DI0FOtEMCIzO2/XBWfsACeNA87rYwgsSFV4m+5QCfUtIwTld
         4BeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M/+f53STiBHRkcS4IGPMxd+HMPefmbpzrpbFyFpBgDI=;
        b=4UH0743zBhD/cX22k9Vy4MT9KWGQofss7fBOwCmRF10DoAMeJ0P0f/tLeqGM/aQGk+
         2qLtEeFv0kxpUHfXOd8Slo4pkdkL7wc4e15oXSydVbvoSXl897fAEzuIdk1o09os+5TO
         yaXZIuw7+y5p6h6PMYPr9CrVgtkN+iYnZtIzPattkFZYDXBnezWySe4HmyG8e6z2Q739
         GVv5AAUB9aKaXOcb49ObJl7wZiJ6JIpvRlziipBIMErQ3NLzPYWMkWeUBHs2xwyiHKdR
         SdnAc2sL6rTjTO2mkDxUOGsvJXOOgL88K/URi6fvdpVM/LnRZkGln3Ks8GOGbvHtQicN
         KhBw==
X-Gm-Message-State: AOAM531n1CcMXrPqwUj74P4f/VD8l2XE5lonqqbSyaOpxJO2z4MnZomd
        OUKdQ3YB5Ukz16XhkLAjzIbOIA==
X-Google-Smtp-Source: ABdhPJyF3HluxL6TTy22PSoOozjmKOsKtmhCZSw2pLGT1B2Lpqu1z+prOt1AEOj1KxTjK+X6U4kgYg==
X-Received: by 2002:a05:600c:507:: with SMTP id i7mr15717932wmc.40.1643569858066;
        Sun, 30 Jan 2022 11:10:58 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:d3c5:fe0:78a4:5227? ([2a01:e34:ed2f:f020:d3c5:fe0:78a4:5227])
        by smtp.googlemail.com with ESMTPSA id u19sm6934055wmm.39.2022.01.30.11.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 11:10:56 -0800 (PST)
Message-ID: <8f448883-f8cf-76fc-6275-ed5d887f16c8@linaro.org>
Date:   Sun, 30 Jan 2022 20:10:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 0/6] powercap/drivers/dtpm: Create the dtpm hierarchy
Content-Language: en-US
To:     rjw@rjwysocki.net
Cc:     heiko@sntech.de, robh@kernel.org, lukasz.luba@arm.com,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220128163537.212248-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220128163537.212248-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/01/2022 17:35, Daniel Lezcano wrote:
> The DTPM hierarchy is the base to build on top of it a power budget allocator.
> It reflects the power consumption of the group of devices and allows to cap
> their power.
> 
> The core code is there but there is no way to describe the desired hierarchy
> yet.
> 
> A first proposal introduced the description through configfs [1] but was
> rejected [2].
> 
> A second proposal based on the device tree with a binding similar to the power
> domains [3] was proposed but finally rejected [4].
> 
> This version delegates the hierarchy creation to the SoC with a specific and
> self-encapsulated code using an array to describe the tree. The SoC DTPM driver
> defines an array of nodes pointing to their parents.  The hierarchy description
> can integrate a DT node and in the future a SCMI node, that means the
> description can mix different type of nodes.
> 
> As the DTPM tree depends on different devices which could be modules, the SoC
> specific description must always be compiled as a module and describe the
> module softdeps in order to let the userspace to handle proper loading
> ordering.
> 
> In addition to the hierarchy creation, the devfreq dtpm support is also
> integrated into this series.
> 
> This series was tested on a rock960 (revision B - rk3399 based) and a db845c
> (Qualcomm sdm845 based).
> 
> [1] https://lore.kernel.org/all/20210401183654.27214-1-daniel.lezcano@linaro.org/
> [2] https://lore.kernel.org/all/YGYg6ZeZ1181%2FpXk@kroah.com/
> [3] https://lore.kernel.org/all/20211205231558.779698-1-daniel.lezcano@linaro.org/
> [4] https://lore.kernel.org/all/YbfFapsmsjs4qnsg@robh.at.kernel.org/
> 

Applied for v5.18



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
