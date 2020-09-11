Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8864265AF0
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 09:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgIKH6M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 03:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgIKH6I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 03:58:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6C9C061573
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2020 00:58:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so3832075wmb.4
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2020 00:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1IUSu/d3w6Wkl/EvaZBQs8+EfTzsdofYI5H0K7F7L1o=;
        b=G8EdYaLJeEp/GI1N1GuZ1b6OOHrLRNIm7B4ikRMq59wmBHu+2vXE0NCCGTbKaI0cDY
         i5rmWNN/1W1pgiRv91f7fwtLZ5IFfsG+QAZlx0iFPFKz/2hPlPsZ45vmCzjdIkkMpTqJ
         NoIyfmZIGHoRe3/GiYdqSpTV3WBNS9cJ0AGCMY/besJr2+jj8/RUnyBXhPOv/urktqvT
         REJN8+U/97Lt7BmQeF2SD8v63wLxGu6X2bZObIpqpcgx2OVE4EppIo6ac0nVmnJ1M6tm
         cD2lfKQ5oelMZAKuX0ksH9ci/b7GXigp1ojqJSldTdfvDvdjgtkFQFpAp6IpRr6sOsPt
         KYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1IUSu/d3w6Wkl/EvaZBQs8+EfTzsdofYI5H0K7F7L1o=;
        b=KFfoFWQ0LPOYpTYWE6Wt84uw6hbZklDd5YeUaegrWDE1XuT4uHdmiQFnd/8JWSAhGv
         aKJR4bXNrzni+9JVicqGJ+/YR9Y59iPDPcKH3VkxieSdgIk1qsmuGqsBphej8zoVQZdF
         ae2jR9WipGxh2ZnlVXlX/4XvCniKOuT/+X6hfBTWXr6lPAeQtUtpPJri0yDxTyjo+Xrg
         6RQaMpQ7yHkzjHd9XUioVDBYFDoKKmZxhrkOUF6tN4QudIbXsVbojYr/PcQvHp5+4b68
         W00fPQLF+0+YUgZ5fo+y+gtnoWi5xNE7Xh6o1tkllowxW2mKn5c3e+Co/NAsUZWN3bry
         LJuQ==
X-Gm-Message-State: AOAM531KOI0Lz5m2TSA+kTXUDhzOXZI5LMNz7x7GXnO/vmhSjBqhECws
        w2WO4gVL+GxlI3W2qrRGCPzZjKGvdJdKoiVr
X-Google-Smtp-Source: ABdhPJw/Gu3pU0oETNVFOVI21iaEBCzb7k6eX911WqCSdEToMWwhB+YQcOHFra5+8PgT6gg0FDX0KA==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr799532wmi.56.1599811085439;
        Fri, 11 Sep 2020 00:58:05 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d5d9:c908:efdc:8b45? ([2a01:e34:ed2f:f020:d5d9:c908:efdc:8b45])
        by smtp.googlemail.com with ESMTPSA id a85sm2831561wmd.26.2020.09.11.00.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 00:58:04 -0700 (PDT)
Subject: Re: [PATCH RFC] powercap/drivers/energy_model: protocode: Add
 powercap energy model based
To:     Amit Kucheria <amitk@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20200707171457.31540-1-daniel.lezcano@linaro.org>
 <CAHLCerPq_f3t=cgS0MXvWuRvPaBrAs2dZEyeNSOyZ3OXHgHNeg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d8338e31-3d9b-a0b4-bf0f-6e74a7ae4fbf@linaro.org>
Date:   Fri, 11 Sep 2020 09:58:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHLCerPq_f3t=cgS0MXvWuRvPaBrAs2dZEyeNSOyZ3OXHgHNeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Amit,

thanks for taking the time to review the series and read this long
description.

On 10/09/2020 11:48, Amit Kucheria wrote:

[ ... ]

>> +
>> +config POWERCAP_EM
>> +        bool "Energy model based power capping"
>> +       depends on ENERGY_MODEL
>> +       default y
> 
> Don't make it default ;-)

Thanks for pointing this out :D

[ ... ]

>> +       pc_package = powercap_em_register(pct, "package", pc_soc,
>> +                                         &zone_ops, 1, &constraint_ops);
> 
> Will the soc and package hierarchy eventually be dynamically read from
> devicetree or similar and these hardcoded registration removed?

Yes, that's correct.

> For the rest of the devices, IMO, it makes sense to use the genpd
> hierarchy to reflect the powercap hierarchy. I whipped up the
> following patch to show how it might be achieved. What needs to be
> done is to now reflect the parent-child/sibling relationships of genpd
> into powercap. Initially I thought we'd need to additional DT
> properties in the genpd bindings but I think we might be able to read
> the device-specific energy model data directly to populate the
> powercap constraints.

We need a way to describe the power constraints relationship of the
domains to populate the hierarchy of the powercap directories.

In the DT it may look like that (very roughly):

power-constraints {
	power-constraint: package {
		compatible = "power-constraint,virtual";
	};

	power-constraint: perfdomain0 {
		compatible = "power-constraint,cpu";
		device = <&cpu_l0>;
		parent = <&package>;
	};

	power-constraint: perfdomain1 {
		compatible = "power-constraint,cpu";
		device = <&cpu_b0>;
		parent = <&package>;
	};

	power-constraint: gpu {
		compatible = "power-constraint,gpu";
		parent = <&package>
	};
};


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
