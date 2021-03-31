Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377D735051D
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 18:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhCaQwP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 12:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbhCaQwM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Mar 2021 12:52:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D35C061574
        for <linux-pm@vger.kernel.org>; Wed, 31 Mar 2021 09:52:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x13so20346406wrs.9
        for <linux-pm@vger.kernel.org>; Wed, 31 Mar 2021 09:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KW7KuRreeb79kGzMH/vng/RjmZZIp935J4i4tM6jC6g=;
        b=qnEUvEjj/xzG8LrnVtSeDVPIyff/heHBpXfIkbkH/Wf/QRY9vZDobrQMVTMn3Suj9A
         7mhQtaRY8Xe+yVBM5I8ndcXNbzXWMUTz4TreYTYeGaI8UTiMtD/+JFkNYn61ZHVqh9xo
         gssil2FijNu3h/w43eQIznzwojZ5y7RpmYZ8W3pO+gie+F6QAEitTpUuR1IJzm6wnZM3
         b5cKmwG5TWezMtr+B1GIBQ3Zo/JHK0R7Dc3mngUzjPX0Us+95Vr8MIiav+Q279merITh
         DdmskatNl3UogH+0LAyYI1Yrjo51MlJXWEZgdQVEaQYPjrcTfyPTPXkWUwBUXnPy99ny
         PUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KW7KuRreeb79kGzMH/vng/RjmZZIp935J4i4tM6jC6g=;
        b=BaZSo5o0SwOD/YBgIaV2P/kbOETtKDso5biA/aIEHNBVQiY1LFlQOG6AtMEI/yTp8L
         RTVRce3wjifzAkajC5rRLgsKsjY7JhJbAn/7kUAf+EaPEYXPS2pu7S/9p9qh15LsjiKA
         AYx73wt7VC2PChZOrLujaEd4TcWcCtHFuUOoUrdH7QzFBC4yoA/jh2FKxTSyieBjbe+C
         sgVqdAnX3CzCZAFQo4irGfbnEPoYPM+BJiIXe0zvXE0nj0hLsv5eKzZCQ/O9/gIUEgZE
         MtukR25qX3slYG+Y/yRE1BkhP41CW/xfOJKcrTyLrkceFOIhFbyJIz9+g57wk0yIFo1B
         9t3w==
X-Gm-Message-State: AOAM533PMqoe5fTx/7a7kHRvMliFEIYC6ctJnN+ZeTR8KBHLTOPb5Umd
        1P7nNytR276FmNLwu4SOozW/QQ1BWsQy+A==
X-Google-Smtp-Source: ABdhPJybpgeOKHptSYn9F2ESwHc1TgEAW+9Xq8rONln/zJYDOUEWbiNr6PP9E51rmgYdxVMr2HRyqw==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr4892008wrm.145.1617209529503;
        Wed, 31 Mar 2021 09:52:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1573:1dd5:899d:6362? ([2a01:e34:ed2f:f020:1573:1dd5:899d:6362])
        by smtp.googlemail.com with ESMTPSA id c8sm4681718wmb.34.2021.03.31.09.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 09:52:08 -0700 (PDT)
Subject: Re: [PATCH] thermal/drivers/hisi: Use the correct HiSilicon copyright
To:     Hao Fang <fanghao11@huawei.com>, edubezval@gmail.com,
        amitk@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com
References: <1617086733-2705-1-git-send-email-fanghao11@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <549a6349-c05c-9170-a288-59e3be8e5627@linaro.org>
Date:   Wed, 31 Mar 2021 18:52:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1617086733-2705-1-git-send-email-fanghao11@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/03/2021 08:45, Hao Fang wrote:
> s/Hisilicon/HiSilicon/g.
> It should use capital S, according to
> https://www.hisilicon.com/en/terms-of-use.
> 
> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
