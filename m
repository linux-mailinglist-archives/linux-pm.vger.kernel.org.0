Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935D11DED9A
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 18:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgEVQps (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 12:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgEVQps (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 12:45:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B93CC061A0E
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 09:45:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i15so10757290wrx.10
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6GR7HmOw0vXex6U/cofpWanbE4mJ+fAlXyaVxc3rmoo=;
        b=NpqBOWpwojM3LZTZCer6cwQuU9Dfk1PLl0mrthDrget8CeNH7MzEpwyyOdNyQN4oLh
         tt3nB1FEWebWGLUxl8I+9w+zng9TfV9LUoju/5OVWAjc/5uyhpFcRydeEmUUL7oKHw5M
         qJ7bW4Zh4BRJjnlFgneqd+Su1h+XvhUlO8pqnOGjhHvOaupupW1ce079blAkO9epqZnE
         TjYBIlEcsq3pkRNUxW1idDro7u9J+BugJFpw/X0okhleEiuVTdbQT6RMbmii0ubjd0YM
         9FkmN497bB8UNU7GmqJMHmxidVRaML5jJmA1nRkCeLtd4cI8TIDVEFJrYSJ3revpk8X6
         K+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6GR7HmOw0vXex6U/cofpWanbE4mJ+fAlXyaVxc3rmoo=;
        b=lE2ogbi7JnN3Oiy7VVVlLv5ZTUxoIl0ndJigyL5HgeHB4odOvKjU3cPgez0TTlScht
         gefuK1OKbHAQKuV0ZyHdXF1c87565QclADrIUskOxpW/g8efPIhW76hJZET2Vvt+C0du
         R7S6HbA9EUeYy9ZjvTvO3bkFu7s6Mgc70ujO2ogAEuIYOfRBGYA6HptO8SZXaAg7Q2jA
         nqEsxQMy1r3Yv8s+cU/lfsCTwBi2GPHSzN+qRlo4Uc8OiE3ClmjgylAKQs0PY6DKt6a0
         D8g2cCCBX1Z+8EdkiXsSgpOOeiNFzj4ENRHqx0nWqDnV0gyLwNyifSbmbayvbz5yrHuQ
         d96Q==
X-Gm-Message-State: AOAM530lu0Gq5Gz3AzbhfWNJbZem3NnPPaURsagWjUiYfWxys3Z7PdQD
        Bfg5+Yh0WFwbSMSJet3rNhQNiw==
X-Google-Smtp-Source: ABdhPJyLiO4hYgR2VrqVwoiZ28msGE7VhjnrrBlGyww3F4/QoNednCytSwz5z9BFpSWThz5DUcBoZA==
X-Received: by 2002:a5d:4b04:: with SMTP id v4mr4369245wrq.182.1590165945140;
        Fri, 22 May 2020 09:45:45 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a82f:eaec:3c49:875a? ([2a01:e34:ed2f:f020:a82f:eaec:3c49:875a])
        by smtp.googlemail.com with ESMTPSA id h137sm16308123wme.0.2020.05.22.09.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 09:45:44 -0700 (PDT)
Subject: Re: [PATCH] thermal: imx8mm: Replace zero-length array with
 flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200507192517.GA16557@embeddedor>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9d0df1d5-cbe9-9ddd-2b1c-81298506c28f@linaro.org>
Date:   Fri, 22 May 2020 18:45:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507192517.GA16557@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/05/2020 21:25, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/thermal/imx8mm_thermal.c |    2 +-

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
