Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB73264E88
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 21:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgIJTSQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 15:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgIJTO7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 15:14:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4767DC061573
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 12:14:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so1370120wmi.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2020 12:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NHiy0wGH0Z2PSWBSFDkr8vLYPebD0GpJug29FxTRcRE=;
        b=cWm3mdOojlugDs8+acBDLk29ETxfONeSctt4U3ukGpeaGbTukDCUj5c36jtb5OM7qq
         2ubNfIl7Wkf1vqZ5QWFoEVxXNyprjG3T9Fv7GeS9Onsjz2F/EFrRmvQnq78CQjxvWCda
         dZwoLWf9A64IWB2OXLIN0WBzepkQFLGC21oI9w+cfzpKStwHVw2SFqdjjtJ/OIRaM3ek
         05FWBDxiafcGejF96W1LWWNrSFWuRJFVoC5S9HuEQ9CqEnDtYJXohPRHjqbWHghBxApb
         sdN5KZVEJZ89lwHfufyZ7gZanRWIzAlNinvXydN3dfdc5EowzwGLpb4DZj6tk2COwFCJ
         9yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NHiy0wGH0Z2PSWBSFDkr8vLYPebD0GpJug29FxTRcRE=;
        b=GiqPjcaZokLV8OuIqBwB/RWKOdLfDaN4JbqM0+utVys6FkpZz5zCErY71VEVzKg6sl
         M2X2MUoeOnKjkjx0LdHHSDKiTMiD+mrJgh/WYhHsAOrRdpEMlkrcoJVrqNQCu+bPxK1t
         1nvpJljGrX1Ijp9l2Rt/owsiOZcvlAydln1Z4cxWZO0ph4MhhvHZNVlXQPF4HPGFVK3a
         DLOmL1ZEcM/CWJI5LX/YFq2pz2/FsRb6wDeNzuwaH3Q5QWpiuQMR02bAUpKa/0XIiQX8
         rCoT3ICOxRxIVNwZHVws7ct8DF3Y+RdM4wekWOukVYfyjHLRjCJNM9SWKEdPNU6TYbm4
         t4DA==
X-Gm-Message-State: AOAM5331eo747jZ4Qlgf7UU0dIH2RN3z3L/e9ScUFKlLpbSvyzR9DOPh
        aEomT6nxsc6bos+sVTwjhF10eA==
X-Google-Smtp-Source: ABdhPJyzel4iOt0f1YOCRvX0c73LHI9kOU2nk9MtFaf2OSJgI6rjVeqrNDOQzeRzwi7A+ZtNb2brFg==
X-Received: by 2002:a05:600c:2109:: with SMTP id u9mr1413131wml.147.1599765296745;
        Thu, 10 Sep 2020 12:14:56 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d5d9:c908:efdc:8b45? ([2a01:e34:ed2f:f020:d5d9:c908:efdc:8b45])
        by smtp.googlemail.com with ESMTPSA id y1sm5074204wmd.22.2020.09.10.12.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 12:14:56 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] thermal: ti-soc-thermal: Enable addition power
 management
To:     Andreas Kemnade <andreas@kemnade.info>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-pm@vger.kernel.org, aford@beaconembedded.com,
        hns@goldelico.com, kernel test robot <lkp@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200819125925.2119434-1-aford173@gmail.com>
 <20200910200152.72cc5d9f@aktux>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4770327e-84fb-0543-097c-6525d762a01f@linaro.org>
Date:   Thu, 10 Sep 2020 21:14:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910200152.72cc5d9f@aktux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/09/2020 20:01, Andreas Kemnade wrote:
> On Wed, 19 Aug 2020 07:59:23 -0500
> Adam Ford <aford173@gmail.com> wrote:
> 
>> The bandgap sensor can be idled when the processor is too, but it
>> isn't currently being done, so the power consumption of OMAP3
>> boards can elevated if the bangap sensor is enabled.
>>
>> This patch attempts to use some additional power management
>> to idle the clock to the bandgap when not needed.
>>
>> Signed-off-by: Adam Ford <aford173@gmail.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>> V2: Fix issue where variable stating the suspend mode isn't being
>>     properly set and cleared.
>>
> hmm, it is not in linux-next. Can we expect that for v5.10?

The reason I did not pick this patch is because lkp reported an error on it.

https://marc.info/?l=linux-pm&m=159788472017308&w=2




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
