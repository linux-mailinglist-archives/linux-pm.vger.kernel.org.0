Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733551F16AA
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 12:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgFHK2E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 06:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbgFHK2D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 06:28:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3703C08C5C4
        for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2020 03:28:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so6496595plt.5
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2020 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=39m+2LLbv6DmBKnk5P51Aj/s0CDKaXKRY6RVZpmO47k=;
        b=WAGe9EfgYRXcs6oNuDgg+A5B5DLZKzh4sjoqPNRbHSPYUsD654Ef1u0NL1YTyBQJbH
         3AAQHDRAFqZYQHcRUlc7swh6QESQXgVdWti12n2MKx0W1qMmCYiJOf3wVNg3llo5qVzU
         jeLX7I4WOEoskkTxzZilOnuhERrqKx2CArW9Ay9eBSsErMEDyjfiinrbF1tbnOIfRVKT
         zYqOwFTR6JxFVjVfjYdV1Ozd+PV88T94fYPeucXCSGHFqpmfTc6v3FhZUeqIRJwyqwLC
         6pGwNOxhVFiddns9nUl45WEcBbvoHqPVAC2h8E95E+7t447c4eMegnPjx9xnAmolpzvJ
         4j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=39m+2LLbv6DmBKnk5P51Aj/s0CDKaXKRY6RVZpmO47k=;
        b=d7NyF3nhI4iKkT9DyLgt+Yr/HZjrfrKK9nu6NSdSITDRx5amrqK2eZUgX80D5d8+vl
         eXJZcRtbs6Pxo7PIOIIMzEfGyFDFqpYmfNPEdw1T7xz+Pi0PdX5SeWVX3TJF5EHijWAC
         UiNRzLOsgO6hnn5b99LNwEFIq/1H9/Gc5rgjgRcyWYKoXok+xrEHvkd/YV6WWbT+X8n9
         sXue5cMdCW2ZzDyY8JhD6ewxIwNLJaZn587J+/HRZ144Y1dDZVN26oQDdiobAxWZxf2E
         E5rFAY+U8GgXeb/Oa8ZKtsQRqgZJi2mrBIFdhQmPauD/e5rgXHPw5/DMytNJmX0B5VE+
         gq9A==
X-Gm-Message-State: AOAM533OSK+gSsXsZmDXQaFSrNMa+yGCuVIYFhmHybBH4cqM8KSutSWG
        +njwY6pPuJK4ol6LT0bmrwqkXQ==
X-Google-Smtp-Source: ABdhPJy7tUDmw7E2+N2dP4+jFgxDi565u5EZbJy/npJ1/aTQhfV9kSuAXl9CPg0tBQD4hXT6yfe9gg==
X-Received: by 2002:a17:902:6bc8:: with SMTP id m8mr20467004plt.138.1591612080996;
        Mon, 08 Jun 2020 03:28:00 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id n24sm14806270pjt.47.2020.06.08.03.27.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 03:28:00 -0700 (PDT)
Date:   Mon, 8 Jun 2020 15:57:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org, saravanak@google.com,
        mka@chromium.org, nm@ti.com, bjorn.andersson@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org
Subject: Re: [PATCH v6 0/5] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
Message-ID: <20200608102758.54vdswjievx3cc7l@vireshk-i7>
References: <20200605213332.609-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605213332.609-1-sibis@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-06-20, 03:03, Sibi Sankar wrote:
> This patch series aims to extend cpu based scaling support to L3/DDR on
> SDM845 and SC7180 SoCs.
> 
> Patches [1-2] - Blacklist SDM845 and SC7180 in cpufreq-dt-platdev
> Patches [3-5] - Update bw levels based on cpu frequency change
> 
> Based on Viresh's opp-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=opp/linux-next
> 
> V6:
>  * Add global flag to distinguish between voltage update and opp add.
>    Use the same flag before trying to scale ddr/l3 bw [Viresh]
>  * Use dev_pm_opp_find_freq_ceil to grab all opps [Viresh] 
>  * Move dev_pm_opp_of_find_icc_paths into probe [Viresh]

Picked for 5.9, will push to my branch after rc1 is out.

-- 
viresh
