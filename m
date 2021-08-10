Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C1A3E5123
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 04:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhHJCrw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 22:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbhHJCru (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 22:47:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACFFC061799
        for <linux-pm@vger.kernel.org>; Mon,  9 Aug 2021 19:47:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d1so18999464pll.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Aug 2021 19:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aLz3R/PfInuBDOwjVvzSA+K2mOEipBXOGKBTYuR/UjQ=;
        b=u82RUKq0Cu9k+cH1e/nJUGAYPe+uSr9FwNA/i2Ax5QbR7bnnC5z9Abbug2YTjQxgPQ
         UaI9ruWDRXjrJxQ+E6kokRmM2Olb4t6VPWQiS/R+xMnOg7xskW5sHupXISw6uVhJZVQR
         EeQaz++xbMfFDdseC+9Ya8r4VHLrJ714j/gKVemJFr23QOdzZ32E37pa3+bKyUHekFQP
         t+aELbDGjXDOcLnSJ+YzZBmYsAbxepz1MVngI+I2YZgchl+1mZsm9ZkDFH6PyQA7bd76
         k9RHg4S1IWkgKQ+ptJyXMlhkEOuYP4n+A2vDTRqsJbL4TItoyW+doNNtr02TIXI7gyqN
         vXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aLz3R/PfInuBDOwjVvzSA+K2mOEipBXOGKBTYuR/UjQ=;
        b=mTP7xaIaJDlDcjUUoO/g0EAVmpNu689cAl1RXcu+2M2UsZvC5+7LNtdHDfVeAiVhLL
         Upbe3tnJ3c1dnMrpgA8dvo4Ps7grW6NImYJZydLAqr/ZKQhFFZpddZiSW6KkCVnmL8K6
         xoWLw+lbSu7KCHdfose/R8h4YlU/Gkt6HnUt5qbTAJrAHWA6rv/WuhSfFDBP51K+bMHy
         qKbvFf/iRIASTKbM2o3DWNQCbkHzMAHdFFi1KnQw4kn82V7PQlGMPvv9pkQUQ6OSwOde
         JMk8ZVWKsk1qGXQOxO/ZCYp55MweC26ZyUeMyrezCAsBrJdfhgMxspajLtPyLqyWpprr
         26lw==
X-Gm-Message-State: AOAM530XeDna+qtqBdiAzKjiW2LuosRx0fVvVc6xOHh9jzMzkiIbJbTt
        JUEG2OxBERXT5GBMtDDBG/qAXrgG163/DQ==
X-Google-Smtp-Source: ABdhPJw4qsk6dKbmfyAQJNyBrmv6RENs2/OaroTuk2V8kwmx42VX7YmwQechtP9JeFUoTNE8Hm7Tdw==
X-Received: by 2002:a63:594e:: with SMTP id j14mr491424pgm.249.1628563648525;
        Mon, 09 Aug 2021 19:47:28 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id c23sm21805549pfn.140.2021.08.09.19.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 19:47:28 -0700 (PDT)
Date:   Tue, 10 Aug 2021 08:17:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        steev@kali.org, tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [Patch v5 3/6] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt
 support
Message-ID: <20210810024723.qne6ntjtv5zxf576@vireshk-i7>
References: <20210809191605.3742979-1-thara.gopinath@linaro.org>
 <20210809191605.3742979-4-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809191605.3742979-4-thara.gopinath@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-08-21, 15:16, Thara Gopinath wrote:
> Add interrupt support to notify the kernel of h/w initiated frequency
> throttling by LMh. Convey this to scheduler via thermal presssure
> interface.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v4->v5:
> 	- Changed throttle_lock from a spinlock to mutex to take potential
> 	  race between LMh de-init sequence and reenabling of
> 	  interrupts/polling after a thermal throttle event.
> 	- Other cosmetic fixes as pointed out by Viresh.

How do you expect this to get merged ? I pick up this patch alone ?

-- 
viresh
