Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD61B61B3
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 19:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgDWRPd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 13:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbgDWRPd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 13:15:33 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374CBC09B042
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 10:15:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so7388523wml.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 10:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fsz6yPmVodHIAGKUEkvYHzu/ExufdaJ3lV6EfBbjr/M=;
        b=LS7t6pzEmK1UKWLE+ifdRC16uMDswKS7v+2IPC/TfosO7rAl+qZLKWbjscW8fVMt3v
         1ma+2i4218WDyTaV/Nz10zY4H9KwN0u+ZSJbgg+iuqYMRImmBIYJNaO+GRPQWuMQ7nEn
         EIONqnAxXg1Zp2PZZeAdugJxMad9J6bW2gsLRpfAY8WjqySQzErIR3g+hDarox9ZuWqR
         GnpnaUL95V7dBN0xZRAeWhHOTZeyLhRGhJzZ9oKaENvK3QAePz+ztUbyLI1n2HD+wHEF
         e6D2NNwm3CcIPwegKXhdh8ViXwMsS8Mgh0dzwsOBoq4UFCZZn+OwOqe34GGtYiZxNz0D
         Dn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fsz6yPmVodHIAGKUEkvYHzu/ExufdaJ3lV6EfBbjr/M=;
        b=C8P1g4XlnvlAmpu5+/WXlAgbi+HmicqUfmEBUavgXHzBC3+StTmT6emesF/y0ToQl/
         q1NZueIc3T7Z7uLLVaDg0T5h6BN/BUUEXReEqlac9fR1kWsyQ5kppwXu4xRMLr2jobhK
         7CRxe04xNuaVTzXnK1QQ+mW/Qdf73MKGQ6xKrYzGV4ARaWEqubwwkvd7JawjBz5okk7d
         7kEPY4WxROxO1nReLTW39oidqd3H4CqMnxzRw5D4B+4FWuOIrwIHYp46y9WekIRjVobE
         F9KHKO0t0RRYoXR2Qtlffsnd4qYbMuwvsCSQFbZEy99J6l5Dd/6SKIrfxZx2a7O7L8sJ
         +apg==
X-Gm-Message-State: AGi0PuZAi/10+nk7LawXyJ0C8ID/vLpWyfA1Lv5y7yNdUwI1IcjE2+G7
        X/nK0s2Igam2F4xCKmR7uasvcA==
X-Google-Smtp-Source: APiQypLpzfjeHcKORCtuutm1uyBf7sFOUFW7Mb8uOr8lGTYIICuH1CY1N6lSdxp/QVB17oX17RO+pA==
X-Received: by 2002:a05:600c:2194:: with SMTP id e20mr5154639wme.22.1587662130818;
        Thu, 23 Apr 2020 10:15:30 -0700 (PDT)
Received: from [192.168.43.23] ([37.167.216.250])
        by smtp.googlemail.com with ESMTPSA id a20sm4965935wra.26.2020.04.23.10.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 10:15:30 -0700 (PDT)
Subject: Re: [PATCH v6 04/10] PM / EM: add support for other devices than CPUs
 in Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        qperret@google.com, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
References: <20200410084210.24932-1-lukasz.luba@arm.com>
 <20200410084210.24932-5-lukasz.luba@arm.com>
 <20200423151250.GB65632@linaro.org>
 <ff1c8cc5-f64d-6156-7d30-97b8426c6f99@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ddf89887-4fa5-f2ca-d62a-9158f7d29db2@linaro.org>
Date:   Thu, 23 Apr 2020 19:15:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ff1c8cc5-f64d-6156-7d30-97b8426c6f99@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/04/2020 18:57, Lukasz Luba wrote:
> 
> 
> On 4/23/20 4:12 PM, Daniel Lezcano wrote:
>> On Fri, Apr 10, 2020 at 09:42:04AM +0100, Lukasz Luba wrote:
>>> Add support for other devices that CPUs. The registration function
>>> does not require a valid cpumask pointer and is ready to handle new
>>> devices. Some of the internal structures has been reorganized in
>>> order to
>>> keep consistent view (like removing per_cpu pd pointers). To track usage
>>> of the Energy Model structures, they are protected with kref.
>>
>> Why not add the energy model structure in the struct device directly?
> 
> Do you mean this structure?
> https://elixir.bootlin.com/linux/latest/source/include/linux/device.h#L537
> 
> and to put something like:
> struct device {
> ...
>     struct dev_pm_domain    *pm_domain;
> #ifdef CONFIG_ENERGY_MODEL
>     struct em_perf_domain    *em_pd;
> #endif
> ...
> };

Yes, exactly.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
