Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BDB34F062
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhC3SAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 14:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhC3SA0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 14:00:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF88EC061574
        for <linux-pm@vger.kernel.org>; Tue, 30 Mar 2021 11:00:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so17131518wrd.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Mar 2021 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VUV5pK/QuRU2ZR99eXxkAP9hIr+VztkZsf8oLI/qjbc=;
        b=TSaWl2q5amHTKrdskGiMaZYwPK2tjwCd2jQwS0afuforfjqhH+Zb+jDkCvIpD7uf6E
         9qwyugtWHISrTF44ZoCnlM9i7nZr1Ro6e/XVd8CCUj0Zng2y55N+P0B+TbVEVZ9IQ4Gn
         xlrbVjRklwEHSUJWC5qhAdszWI+gt2UGh0q5nyHglwQqi3Sa97mOCdoWicwB57MivsZu
         2HrlEVTRUwayi196Ij6DZVrOlruSC4VaxnrHM5OSojd/rAhXhK7RSP++22KOXxB7XQz2
         Z12RWSpTsm6S0kImg1AstfF9jvFnuOWm9FRRELOQAjSXdm0RpraMMHiIVhmz1YhlvIf2
         RQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VUV5pK/QuRU2ZR99eXxkAP9hIr+VztkZsf8oLI/qjbc=;
        b=PEIZJtjbB9/CDU2yykhqQk5pH+yzmvQvy008W1xw9xTBgNlr18J7G7R2WeX0EptnRx
         sbqlIfEGyBetUciRXeiXaqkTDX0LrmYQrkrtsz8tO2t3DRU8Z5DQ1+C9B3TNaWKf8qaq
         ouVIVClStYOEURGYngzt7J8ypG+IGDtTe/7MhZkQJeGdJr212HnGPh0wHbfGc5fiTzpO
         UvSsH3Uefj1eo8oDqVXG+22wuKk/HrRZEYG3vTb/oio30Qxn+kgvIWkl2WutUQ/9Dvgb
         ktJc6ZoRBu6oYaRE2sA9gSOU40S8S9ElqtCmz8XqLXfxU+3OfdNwWLsNd1SlitvTfWzY
         49FA==
X-Gm-Message-State: AOAM532RwNgJVOrZTz2lmGcM4lSaaGh8F0AQ8xFL4BIhzrvru8SCTVan
        CWiLNLU7BTDQ2MdAmKo0LyHcDw==
X-Google-Smtp-Source: ABdhPJzkSVAIwBrOZjm9dD4pe4f5NBkShS9L4cQLFl/zd12YEgo4YwNXfzRymLRPhCkR22MkLTpKSg==
X-Received: by 2002:a05:6000:5:: with SMTP id h5mr36054541wrx.97.1617127224233;
        Tue, 30 Mar 2021 11:00:24 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cc47:54a6:8827:9be5? ([2a01:e34:ed2f:f020:cc47:54a6:8827:9be5])
        by smtp.googlemail.com with ESMTPSA id g15sm4725218wmq.31.2021.03.30.11.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 11:00:23 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] thermal: qcom-spmi-temp-alarm: add support for
 GEN2 rev 1 PMIC peripherals
To:     Guru Das Srinagesh <gurus@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org
References: <944856eb819081268fab783236a916257de120e4.1596040416.git.gurus@codeaurora.org>
 <69c90a004b3f5b7ae282f5ec5ca2920a48f23e02.1596040416.git.gurus@codeaurora.org>
 <159661011044.1360974.2399567989389491381@swboyd.mtv.corp.google.com>
 <20210330174914.GA28865@codeaurora.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4b5ee914-5947-aee9-94ce-9cdc8a73952f@linaro.org>
Date:   Tue, 30 Mar 2021 20:00:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210330174914.GA28865@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/03/2021 19:49, Guru Das Srinagesh wrote:
> On Tue, Aug 04, 2020 at 11:48:30PM -0700, Stephen Boyd wrote:
>> Quoting Guru Das Srinagesh (2020-07-29 09:52:52)
>>> From: David Collins <collinsd@codeaurora.org>
>>>
>>> Add support for TEMP_ALARM GEN2 PMIC peripherals with digital
>>> major revision 1.  This revision utilizes a different temperature
>>> threshold mapping than earlier revisions.
>>>
>>> Signed-off-by: David Collins <collinsd@codeaurora.org>
>>> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
>>> ---
>>
>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> 
> + Daniel Lezcano
> 
> Hi Daniel,
> 
> I just checked Linus' tree and discovered that this patch has not been
> applied - only the other patch in this series. Since this patch has been
> reviewed already, could you please check if it's good to be applied as
> well?

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
