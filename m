Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BCC392742
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 08:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhE0GRn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 02:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbhE0GRl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 02:17:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C6AC061574
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 23:16:06 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id m190so2922201pga.2
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tEgoCJPrkbj468jw5ZRaghDQYOJhlKkf09tP5KMXWrg=;
        b=KRA9sRUlnTqOcC+Yf0KTX0/9997t/giEk6N3PJXi5TNDCLPw34DGD+5UYuZFd4lAq3
         AGCNNJCMQ8jKVGRRoIYJVkqthFVcYxuIeZm+nrMFQe5GdU0t4FPJYiz1/AXY+dvHCAqY
         cMa/SCSkmigQ8/2f6018HpcUjijmN/dDVCzfb0cxDbSudLOBMOJK3Y3HT5J8qhO3gGEF
         yrlehal2VMd+bfJDmO580sgc4vquHnwomuLVuZatfp2HCECI/GTkSsLCQY8SIzEUO7aA
         Zl6GfZHENAvKyYh9QmF2nIciFvYH9BosQgG6bOUAk8w/89YyZNpt/YV8OsO9RvF8EcTH
         6aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tEgoCJPrkbj468jw5ZRaghDQYOJhlKkf09tP5KMXWrg=;
        b=F+Afs5feO8Mq7Ztd7EhLnMnl05o1gVOXMHFodCANLRWB+YLv8qjXL86onqsrKJZ4Vr
         dsdSek+NVwXJUtMeigDgajtMspGpNYZLDRAcoxoIZeMHjOrwGmLid7ckm6M6gxSNX/Uy
         Di2SrctqmAsiztSlLRACA7H+ZftWmB+OUVKavKvMYWvPe8Vk7qfDZNHdkd8Y6xxRZasf
         oM8Gc0fIDLsH7Ex5DXhLQfSZEed0+qsygaDSOoGwBOoeW0veBcdtTBNvRlEOxUkTlSyo
         49WyNs+Hgrdz6vIOgTx3hgu9WTYqYe/t1fEkRWcbXoVNzPyoipLNHGe2nmzwCS9FrG0J
         Zp3g==
X-Gm-Message-State: AOAM531StD6w5Xd2XsNKdQS2zoqzc+k8v0CAJYzAVaOg9Ctc+bv5Q4UX
        1Gg7phi9S3Fr/003/4BUTNBRhQ==
X-Google-Smtp-Source: ABdhPJx8c5QM+oBaoB1pUUUhkeQZpohfFjqie5R+kAsPFqk7RHG130IPvlKyXFyNAXD8VR+/yTEFAQ==
X-Received: by 2002:a63:5c49:: with SMTP id n9mr2235895pgm.223.1622096165735;
        Wed, 26 May 2021 23:16:05 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id i16sm856826pji.30.2021.05.26.23.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 23:16:05 -0700 (PDT)
Date:   Thu, 27 May 2021 11:46:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        rojay@codeaurora.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Introduce
 'assigned-performance-states' property
Message-ID: <20210527061603.cuy5q2jo3pfom7vf@vireshk-i7>
References: <1622095949-2014-1-git-send-email-rnayak@codeaurora.org>
 <1622095949-2014-2-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622095949-2014-2-git-send-email-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-05-21, 11:42, Rajendra Nayak wrote:
> While most devices within power-domains which support performance states,
> scale the performance state dynamically, some devices might want to
> set a static/default performance state while the device is active.
> These devices typically would also run off a fixed clock and not support
> dynamically scaling the device's performance, also known as DVFS techniques.
> Add a property 'assigned-performance-states' which client devices can
> use to set this default performance state on their power-domains.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  .../devicetree/bindings/power/power-domain.yaml    | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
> index aed51e9..88cebf2 100644
> --- a/Documentation/devicetree/bindings/power/power-domain.yaml
> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
> @@ -66,6 +66,19 @@ properties:
>        by the given provider should be subdomains of the domain specified
>        by this binding.
>  
> +  assigned-performance-states:

Why is this named assigned and not "default"? Just curious :)

-- 
viresh
