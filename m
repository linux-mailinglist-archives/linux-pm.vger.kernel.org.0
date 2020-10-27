Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C619529A70C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 09:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509550AbgJ0Iyy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 04:54:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41827 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509545AbgJ0Iyy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 04:54:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id s9so914221wro.8
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 01:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YlMgE4ppo7MlVQWfq5CEJGy3SNLKHCbh9joy1n3UStg=;
        b=m0KVs/9yZ8OKFotOH/qrqzH0gTb83r9uYRcXbBtFWL9gTbMDm1+qwna4OX/Cs264gd
         yPNXo4soQfhoi3XIdGNsQ4gLuVVAF8HsmBJTQdCYgg3c8oLMjaOXPcL+HAqFWB2y0O9I
         vewiTkzY7MZmbbGZda0k1IM/NmBa2srAT4jbJVW9pwZzw2269/7heqtJrOInMeNaiXcp
         9BSoy6/o1NPomhDffBfWzikSisc1lCttQxn2gUDxW/PWImq4GNh5e3qFxQIIO57dEb7k
         XEoT+8qhlFquWP/mFUtF8GufxfJhg6cDPd/S8aq9veeWZVP/8iXOAc5B1gTuUQcotJir
         ZX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YlMgE4ppo7MlVQWfq5CEJGy3SNLKHCbh9joy1n3UStg=;
        b=jRtO/IZQemMIGGbBN6o0c8AbFQ1LlyKklyLM3vLS0UA0KiHFe6av1xfR0kS27cyKK0
         recGguZFb/c3kFeZI9p0nGDedDEWkmDlgUsaaeVdtsBIBVkneYzq1+WzVgj+CBeTJ9wU
         aC4N/7Wl//dfDTss+jwn5LR4PENw+4DzmZX7caOcmysKZtZ+S4Et92RSaafQXYTNYpEj
         6gIU9MhplvSQ9gVr6ge8aEmgntW4odEpZeVnicsJ6zW2Gs7Jy9gNUDKqTKruVDbIwy4K
         k8dlNg36zJhSE76/uedDl7aabrhDN3rHFA/NuBTwv55o9q4mShs7r26d9jq+1DnGkBz1
         nArg==
X-Gm-Message-State: AOAM532n33/n4GN+xw5fHpmhjdpnrebP6dYUtB8uh58TTtUdAMIGqA0b
        cFgwAXd88m2wrXb2ooTEaQDhMg==
X-Google-Smtp-Source: ABdhPJypWtJn/cuPU7mPyxPMd2RFbt2QsX7vI7Bl4AedIthAYHyvrkDB+hjzcxJ3WhE1L/Aa1ixx7w==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr1423257wro.291.1603788892011;
        Tue, 27 Oct 2020 01:54:52 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451? ([2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451])
        by smtp.googlemail.com with ESMTPSA id c1sm1130197wru.49.2020.10.27.01.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 01:54:51 -0700 (PDT)
Subject: Re: [PATCH v2] drivers/thermal: optimize the for circle to run a bit
 fast
To:     Bernard Zhao <bernard@vivo.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20201027013743.62392-1-bernard@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f35cd499-aedd-7286-98bf-68fbaa270a44@linaro.org>
Date:   Tue, 27 Oct 2020 09:54:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027013743.62392-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/10/2020 02:37, Bernard Zhao wrote:
> Function thermal_zone_device_register, in the for circle, if the
> first if branch set the count bit in tz->trips_disabled, there is
> no need to set in the other if branch again.
> This change is to make the code run a bit fast and readable.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> 
> Changes since V1:
> *make the code more clear and readable
> 
> Link for V1:
> *https://lore.kernel.org/patchwork/patch/1324507/
> ---

Applied with the patch description massaged.

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=testing&id=37b2539e63d6570c9ee51b1d48bdecb334df367d


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
