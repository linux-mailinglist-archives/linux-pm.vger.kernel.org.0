Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39C040F3A0
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 09:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbhIQH5c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 03:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbhIQH53 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Sep 2021 03:57:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10E9C061574
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 00:56:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d207-20020a1c1dd8000000b00307e2d1ec1aso6234554wmd.5
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OFx3SnvSEsaPAlzfle7T2BQ4boIe1CP3FodekGYyb/0=;
        b=eFzkuMmdf/6JA+T/kB9rUfbXMficAMnnA5Dg818j2oiqoxjPB2ym2a5JzPzL/HvTwQ
         uJQrldSNNdraw4cwEkyH+f4CtY21JlkEmmNgKfmLBNYgyR5poI/JJJoGHN7q4rm7kAEZ
         lGtxQjeQnJdliIHC0N1nOrLd/olec+8P14o6aglzhYf2OxvQJkd5c7JWT9pTwepjdk/U
         B3e+w0bbm75t+VO6NgPqdAduPv65qYJIST2eGvNInQ8ewjicM9rGgmuwSIeeYJhpLpXl
         obkZanazA0AsvrBkZ9pIU/Nrt0Fr/UY0VqCrEU6GsEFacGQhsuyia2mCerHBU6AskXtl
         CJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OFx3SnvSEsaPAlzfle7T2BQ4boIe1CP3FodekGYyb/0=;
        b=s48uKAr1KuWOnb7qWvF+FSG7bLKnF1/+VYbN/lQVuyfv47iSGIMtCvRccQ/rt1BJwY
         mBzjmgFYyI/aLBgzwbk/QLw1bVmmM1r2BZbDUvN/ViOHpBfHhTAzZV8Vrtl2OkXAJqKu
         e9nQmU2UroDMPay/hgY4VqsGQifSZRZo1nAkVpqV9XLOlS74ARtM5vyPH/53gFhfcVVy
         lkoWkmmvbx6fe3ixw+pbwr9v3vdy7Qncxcj/lsxOHq356Sfs7ug/+GfRLczm3XBWUhSx
         1FUt7N3EkPqVDr4eCxlB+xn28dct3vcWnLxVSkukalDw1GtBxgqAPT5Sk2u7Vh+hrGzx
         z8Jg==
X-Gm-Message-State: AOAM53271elgXjbNRMKvJqUc5kcuZgflFXtfj5gwiIOYAvB+lbXBhIcd
        txD2tBXkzVc4w7HQzEJVe+Pxy3CQhSW5ug==
X-Google-Smtp-Source: ABdhPJzYbuCIj6mvruOmS7ZSQoHxAMnl9yW/YIl/P2o591+H+r7+mNRbCVZ/Vc4yXEFP0CXaE97TEA==
X-Received: by 2002:a05:600c:2298:: with SMTP id 24mr8722546wmf.177.1631865366351;
        Fri, 17 Sep 2021 00:56:06 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cf95:6508:8470:7171? ([2a01:e34:ed2f:f020:cf95:6508:8470:7171])
        by smtp.googlemail.com with ESMTPSA id g143sm9987526wme.16.2021.09.17.00.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 00:56:05 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] thermal: int340x: fix tcc offset on resume
To:     Antoine Tenart <atenart@kernel.org>, rui.zhang@intel.com,
        amitk@kernel.org, srinivas.pandruvada@linux.intel.com
Cc:     linux-pm@vger.kernel.org
References: <20210909085613.5577-1-atenart@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c75002e5-18a6-da14-b903-207f68c2d1cc@linaro.org>
Date:   Fri, 17 Sep 2021 09:56:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210909085613.5577-1-atenart@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Applied, thanks

On 09/09/2021 10:56, Antoine Tenart wrote:
> Hi,
> 
> This is a follow-up of [1]. As discussed in the initial thread, the fix
> is now split into two commits: the two commits combined are fixing the
> issue in a nice way for 5.15, but only the first one is meant to be
> applied on stable kernels (to avoid conflicts).
> 
> The issue this is fixing is described in patch 1. Tl;dr: a
> suspend/resume cycle can end-up in setting a wrong tcc offset value,
> which can lead to machines shutting down because of overheating (when
> they should not).
> 
> I've stripped the Acked-by/Tested-by flags from v1 as the patch was
> split. But the end result for 5.15+ kernels should be the same.
> 
> Thanks,
> Antoine
> 
> [1] https://lore.kernel.org/linux-pm/20210908161632.15520-1-atenart@kernel.org/T/
> 
> Antoine Tenart (2):
>   thermal: int340x: do not set a wrong tcc offset on resume
>   thermal: int340x: improve the tcc offset saving for suspend/resume
> 
>  .../intel/int340x_thermal/int3401_thermal.c   |  8 +++-
>  .../processor_thermal_device.c                | 39 ++++++++++++++-----
>  .../processor_thermal_device.h                |  1 +
>  .../processor_thermal_device_pci.c            | 18 ++++++++-
>  .../processor_thermal_device_pci_legacy.c     |  8 +++-
>  5 files changed, 62 insertions(+), 12 deletions(-)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
