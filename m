Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23E62AD988
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 15:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgKJO7U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 09:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJO7U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 09:59:20 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F4FC0613CF
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 06:59:19 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 19so1747934wmf.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 06:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IdLgaRbW4nEaCIcc+Kl+IljF0AKQ9c4kOuJIqFJ4XQQ=;
        b=zE6BW1MXgSBPi6HFNs/bFM9mV0opihuPEMpa9blC8mLW9qOpazn6K8JS6h6SKf5yGf
         3Yj98J4V2XWwhBvmIMaKmSna1vqKdzE2M9Qi6xn2YCI9p40INPY6PCi9OB/zwvAxyccj
         YmvQwGTzk/Y4PQ25QOHWw3o8bWOAWv/3DY7XTW8j/yfIt1dUdzOUIGJ5j5YAj8yr+YD4
         /sm6TJACtN5T1Qd67KPUbFoanilicnmzf4ZoS8Olc0OFazxEjAXXvbDji5FRHJmygO5v
         8poTXkB8Eej+YMMI1ufXUdvN/J+iYDadMpcjnsqHbeN83gIZuym17+K5VYtJgQA2PwVF
         RGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IdLgaRbW4nEaCIcc+Kl+IljF0AKQ9c4kOuJIqFJ4XQQ=;
        b=hXp7CcWIYYTnyUBbDETN9m4/mPxcVFz9CrXw9UPwPaELHE78qO/ST4vR4bb38Ll35w
         EC+P8894Kzr90ah/SuGZsIbMRSL1G1kmREg8FkUclN7G7ijx9tmEVzEUcfPFX6cxCtXA
         M6pqVxXOgHaNLlvvxo4XyEHppdt8/VWdahb7EBCIPGQkMtXhKLyzTXkrxluvw0dRId3m
         wWpEebOLjUs0Jye1OUAjz2tf8o3D3zYbF4fcSUrjrZ+bDGD/oIETdLP++idGp8zFuddK
         6c6ypSvVmJlUHUpPKV/nqk5Ms4nd4padLb/jriym3po7XQ2oloyB+woWe4wdG4+qjXR1
         sDRg==
X-Gm-Message-State: AOAM53096MQ7l62s/elPr24ZQnUc6wGU2Nnb5PWf/uILdBpRY/HxZs2v
        ieEd/N9MuCXw63Jq+hZzQ05wYw==
X-Google-Smtp-Source: ABdhPJxMjHi9px4ve94r4lzwF0KBkof3AuKcVHvqTov0sVXZfIVWNNeQSwqEOMtZQc+y6NiObyT9uA==
X-Received: by 2002:a1c:dc43:: with SMTP id t64mr37525wmg.93.1605020358599;
        Tue, 10 Nov 2020 06:59:18 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1087:e960:613c:926b? ([2a01:e34:ed2f:f020:1087:e960:613c:926b])
        by smtp.googlemail.com with ESMTPSA id v67sm3381795wma.17.2020.11.10.06.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 06:59:17 -0800 (PST)
Subject: Re: [PATCH 3/4] powercap/drivers/dtpm: Add API for dynamic thermal
 power management
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <20201006122024.14539-4-daniel.lezcano@linaro.org>
 <8fea0109-30d4-7d67-ffeb-8e588a4dadc3@arm.com>
 <313a92c5-3c45-616f-1fe8-9837721f9889@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2495f9b8-327d-bf92-a159-ac3202d30ee0@linaro.org>
Date:   Tue, 10 Nov 2020 15:59:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <313a92c5-3c45-616f-1fe8-9837721f9889@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/11/2020 12:05, Lukasz Luba wrote:
> 
> Actually I've found one issue when I have been trying to clean
> my testing branch with modified scmi-cpufreq.c.

IMO, those errors are not the dtpm framework fault but the scmi-cpufreq.

You should add a component in the drivers/powercap which does the glue
between the scmi-cpufreq and the dtpm. No stub will be needed in this
case as the component will depend on CONFIG_DTPM.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
