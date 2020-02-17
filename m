Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16A8016160D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 16:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgBQPZG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 10:25:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42973 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgBQPZG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2020 10:25:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so20200172wrd.9
        for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2020 07:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1NzMH/9EC7li2bGicgTPFAtZ3/NH66Utjge6Qs2QOo0=;
        b=ZL1GqfQga8cUY7xe8Nwmv/q0yHaf77lGF+6A7Lh4oH046Ako/UCO6m0eTX7nFp9tdC
         zCRtixLBOgPoTCOKEjTG9q9sC3LLDr7qgCcIRaUmmVRCr7iex5/6irjkQYToWRU34924
         uG3H6vGAh+4+h/R+SjFFfiLuiYK8mSjGM6YlKPZAVViIZhl5Z+vSdUZZUIj9l4ZfjU2y
         hlW49OjvVb/7zwnTIzXofpC1Y7Ip8SCtNtdQQ2FHW9q3NvhNpmXCnomKKPYG3obIZOYj
         GAITrceqA9e9EafxpoX4I1bdd5dB6VatRxbunl9IsW2oxflVLfAG7zt7kGxetOxQG44Y
         3xRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1NzMH/9EC7li2bGicgTPFAtZ3/NH66Utjge6Qs2QOo0=;
        b=qs/6v5IJf/qeNq5oieKeOU7+DQBIyiujq9uO0269nRGgTTlwnNW5+kIAtBGZmJAVjq
         9xTCa/bCLkYVXBxDJfotl/UC0cBi9CFtvSzKDym8/qBotyeDKXSQWTpybSO5fTqetEb8
         H4P1+vuzwEl7sMDc9eqr5XdMBERtFJd2asQUANsvuHL51RbO/576+OM8ahJjbH0j2h1R
         qaBzuxZVbTlVFP6tZd34YkIvZ9uFajftLRpH61nGomkO02mXaHvwsEXNFXHXvvVsVRdW
         lMyytMzAbSgFkN6fiBvcp47HtwM7H0xH4xz8QG/zfdv0/lLkM/R1q3VGd5CoBV4RMPmb
         /CXA==
X-Gm-Message-State: APjAAAWIUq4bPiCcqD1uBPJfjHh46qvPUDYT1YQ5gISsi+V2tFV2kLUq
        d2GT+Pbvo6/6yQoW+OLhlg75v+eyhW0=
X-Google-Smtp-Source: APXvYqyPFhYXkn2wxinFTcX98OVgWXoHnv1SBFpxpXjWL+gInm18pqo22Po9uktE9XT4QaNLUBMopQ==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr21599304wrn.50.1581953102210;
        Mon, 17 Feb 2020 07:25:02 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:9dbe:964b:c22d:ab7e? ([2a01:e34:ed2f:f020:9dbe:964b:c22d:ab7e])
        by smtp.googlemail.com with ESMTPSA id m68sm952887wme.48.2020.02.17.07.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 07:25:01 -0800 (PST)
Subject: Re: [PATCH v4 0/7] thermal: tsens: Handle critical interrupts
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
References: <cover.1580390127.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9d4f69cd-fb00-6216-5621-fa6d5b42ce19@linaro.org>
Date:   Mon, 17 Feb 2020 16:25:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1580390127.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Amit,

can you respin the series against v5.6-rc2?

Thanks

  -- Daniel


On 30/01/2020 14:27, Amit Kucheria wrote:
> TSENS IP v2.x supports critical interrupts and v2.3+ adds watchdog support
> in case the FSM is stuck. Enable support in the driver.
> 
> This series was generated on top of linux-next from 20200130 to integrate
> some patches that that are queued currently.
> 
> Changes from v3:
> - Remove the DTS changes that are already queued
> - Fix review comments by Bjorn
> - Fixup patch description to clarify that we don't use TSENS critical
>   interrupts in Linux, but need it for the watchdog support that uses the
>   same HW irq line.
> - Separate kernel-doc fixes into a separate patch.
> 
> Changes from v2:
> - Handle old DTBs w/o critical irq in the same way as fix sent for 5.5
> 
> Changes from v1:
> - Make tsens_features non-const to allow run time detection of features
> - Pass tsens_sensor around as a const
> - Fix a bug to release dev pointer in success path
> - Address review comments from Bjorn and Stephen (thanks for the review)
> - Add msm8998 and msm8996 DTSI changes for critical interrupts
> 
> 
> 
> Amit Kucheria (7):
>   drivers: thermal: tsens: Pass around struct tsens_sensor as a constant
>   drivers: thermal: tsens: use simpler variables
>   drivers: thermal: tsens: Release device in success path
>   drivers: thermal: tsens: Add critical interrupt support
>   drivers: thermal: tsens: Add watchdog support
>   drivers: thermal: tsens: kernel-doc fixup
>   drivers: thermal: tsens: Remove unnecessary irq flag
> 
>  drivers/thermal/qcom/tsens-8960.c   |   2 +-
>  drivers/thermal/qcom/tsens-common.c | 191 ++++++++++++++++++++++++----
>  drivers/thermal/qcom/tsens-v2.c     |  18 ++-
>  drivers/thermal/qcom/tsens.c        |  26 +++-
>  drivers/thermal/qcom/tsens.h        |  94 +++++++++++++-
>  5 files changed, 300 insertions(+), 31 deletions(-)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

