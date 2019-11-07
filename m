Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C445CF23A4
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 01:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfKGAyJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 19:54:09 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35186 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfKGAyJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 19:54:09 -0500
Received: by mail-lf1-f66.google.com with SMTP id y6so183501lfj.2;
        Wed, 06 Nov 2019 16:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WQhkDsKZrkd8TdxE2xc3dtoaBDRq8YTpJQNlzZYmMQw=;
        b=GCq9q+Few97eqD4meVi9vr6WXF86OJWKPepBpJq2bST6zm532Bf+rW18Vv/GFWldBQ
         x23hBWeI563PFN4/5Jz8qPQEa7utPzvJcVfne9cywHFgiRbhiYZJWpeupr4BpH86JubU
         tX6S2yzfsKyboUJ5rfZpHNXbbRxr8ieGiQUMtHL4XtmJybGmuj4YuoDzwXQNWH7BBdMO
         x39BGyk4Ap/TzrRuGrm8j+VR+7mO6B+u4Daz2AkfGT5LHRE+/7DJN2V3zyPppfE3rpgH
         ++qtEMpxzSEfkUZUDvS9SMIO/FXadF6FirpIEV8EvaA2quWfJKFpSa+6APIpswftHG0V
         sfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WQhkDsKZrkd8TdxE2xc3dtoaBDRq8YTpJQNlzZYmMQw=;
        b=TLdh/gNVKij56gmGcXENtWxZ+1GRIhP4yf9xY1xoTD4H2sStJlkBlUqBz4JWNEWflj
         6shdtvkmwxlBX+WsxriXf9scKWZqDDCMKi+xJ80hf7XvPweR6nVfjIbfsmbGm0jD8hox
         l29nDgPY7//Rq/qFyuXkAw8UMwXhgPJCRJoNQhkhcey6BrpOHJt+HnXe8tEXZmAoUnbs
         IKUpWfcnuJfyRTeWf+WdEzOzOowE26RFmi8zrkPb6vZ2sVh175cZPUhEXwujje8uymqV
         ogpn2J7jZi+Nl4RMskm5JmBiT9fVfvRfQ8CEEP9t9eu9BGdQinJb07QVM9QWWlhpjWH/
         88fg==
X-Gm-Message-State: APjAAAWOuEhrXjRb5wjvLpo7hR8nG8/hdDbvHFeDexQqOMBdv8MeptC1
        SIo2LctMpM9zlGEAfJU+1ivsIP4x
X-Google-Smtp-Source: APXvYqwSDxsXmzI4SWeAa6XTM1UPrLMKJFFjcYjACzxgTxJr0xgjPyPe8Ycsw9Y3hBHkx1n12bZAOA==
X-Received: by 2002:a19:820e:: with SMTP id e14mr210299lfd.29.1573088046030;
        Wed, 06 Nov 2019 16:54:06 -0800 (PST)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id f25sm198094lfm.26.2019.11.06.16.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 16:54:04 -0800 (PST)
Subject: Re: [PATCH v9 07/22] clk: Add API to get index of the clock parent
To:     Stephen Boyd <sboyd@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        jason@lakedaemon.net, jonathanh@nvidia.com,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, stefan@agner.ch, tglx@linutronix.de,
        thierry.reding@gmail.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
 <1565984527-5272-8-git-send-email-skomatineni@nvidia.com>
 <20191106231005.F2CD820869@mail.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fcc43ccb-8c6e-d518-4c70-503501706ffd@gmail.com>
Date:   Thu, 7 Nov 2019 03:54:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106231005.F2CD820869@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.11.2019 02:10, Stephen Boyd пишет:
> Quoting Sowjanya Komatineni (2019-08-16 12:41:52)
>> This patch adds an API clk_hw_get_parent_index to get index of the
>> clock parent to use during the clock restore operations on system
>> resume.
>  
> Is there a reason we can't save the clk hw index at suspend time by
> reading the hardware to understand the current parent? The parent index
> typically doesn't matter unless we're trying to communicate something
> from the framework to the provider driver. Put another way, I would
> think the provider driver can figure out the index itself without having
> to go through the framework to do so.

Isn't it a bit wasteful to duplicate information about the parent within
a provider if framework already has that info? The whole point of this
new API is to allow providers to avoid that unnecessary duplication.

Please note that clk_hw_get_parent_index is getting used only at the
resume time and not at suspend.

[snip]
