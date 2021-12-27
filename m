Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EEF47FA15
	for <lists+linux-pm@lfdr.de>; Mon, 27 Dec 2021 05:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhL0ESI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Dec 2021 23:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbhL0ESI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Dec 2021 23:18:08 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88BEC061401
        for <linux-pm@vger.kernel.org>; Sun, 26 Dec 2021 20:18:07 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id k64so12667285pfd.11
        for <linux-pm@vger.kernel.org>; Sun, 26 Dec 2021 20:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hBwHcbOLbODluezLkfU899o5k+HtfijYIO+0bx3J3EA=;
        b=wO63sFsISf2zVMzmS2HzyM2Xf1Ao8xLtpBWfuR6oqkHeMlDibp35OIhrVZX7VJL/C4
         Yij7TZczAIxGmR62A1ZTUCaaCtHr20KwpKBRAQJIQQ1O3KNOXs+dzv59SHNPeDhcaBJ8
         hG8A+6wdHbVKPTRx+OWGiwWbA3DWYBsABEEVWBARkjieFAHPEy78wYRFDciazuqsqYGi
         buT7KNQXgE/O/WFJdRMt3CBSzGaiFYdDzlqihmkYHbUG4Xvka4Hvcl0HhzMWk+xuQ0rm
         i9e/1BQMMhqLB75CGfwS0wqOLoBuqR6UP7avtUQjd1WaI/ZOE1w2XBjq3i0KUARKOKyC
         6qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hBwHcbOLbODluezLkfU899o5k+HtfijYIO+0bx3J3EA=;
        b=WYxuZ0a//TG9zIDEWfpZ05W5rtAJxFCrvZ4L7036gqv7/rSuVE9e8BZB4JPJ7SMp2t
         o97bYXepGJwmsY8sMCEBjwUw1RsNOk4djBtPSm2rQYC45hsioFqkquTyGu8cPkDHgmzZ
         +mZT545c8DiTLZ4lJIinxWOIUicWXHlvg8Bccqq0xQzvv9kGBbRZnCC/LuhSP+EWc38I
         KYqaeaRONQl83mfhBbAbj1UPmgsiJHZZs8LHrPz3gCZmge0JQJJQ7gfg0gWEBMxUb7xy
         OZ1hDouc1oa3irt7E4vD5nQnqHH8B8OA2QTEAr0GB9nySZ0mohC7C0DCMwaZlmq88AOW
         DYNg==
X-Gm-Message-State: AOAM532+7kfTuzhJaUE9yMl+RYZJYgchN9TOKHaz87V/XiRzKDEEQMCx
        IK0/sqtbufIgDVeHC/nosUYHcg==
X-Google-Smtp-Source: ABdhPJwzdvVbN3OacQ1pmlJ8L62kW98FhV72kJKnoUS3A5ZCROz0j1Fbum4pCtSepUiKK9joOPhWUg==
X-Received: by 2002:a63:6f4d:: with SMTP id k74mr5645320pgc.208.1640578687348;
        Sun, 26 Dec 2021 20:18:07 -0800 (PST)
Received: from localhost ([106.201.42.111])
        by smtp.gmail.com with ESMTPSA id f20sm16446187pfe.166.2021.12.26.20.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 20:18:06 -0800 (PST)
Date:   Mon, 27 Dec 2021 09:48:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tang Yizhou <tangyizhou@huawei.com>
Cc:     rafael.j.wysocki@intel.com, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, zhengbin13@huawei.com
Subject: Re: [PATCH] Documentation: power: Update outdated contents in opp.rst
Message-ID: <20211227041805.47cquwvyfaqco7bm@vireshk-i7>
References: <20211226081839.13948-1-tangyizhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226081839.13948-1-tangyizhou@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-12-21, 16:18, Tang Yizhou wrote:
> Three problems have been revised:
> 1. CONFIG_PM_OPP no longer depends on CONFIG_PM.
> 2. opp_find_freq_{ceil, floor} is renamed as dev_pm_opp_find_freq_{ceil,
>    floor}.
> 3. Make it clear that the 'opp' struct is actually dev_pm_opp.
> 
> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
> ---
>  Documentation/power/opp.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied. Thanks.

-- 
viresh
