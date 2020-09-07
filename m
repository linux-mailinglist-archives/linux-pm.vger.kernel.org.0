Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF6F25F30C
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 08:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgIGGMF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Sep 2020 02:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgIGGMD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2020 02:12:03 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CEDC061573
        for <linux-pm@vger.kernel.org>; Sun,  6 Sep 2020 23:12:02 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id r24so1063068pls.1
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2020 23:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nwfDt8r0FFxI94uOTy5nUUE9dpoo9ucjDC826xRAHEs=;
        b=RdWmnUTRghIGlypN/+rErqMOa0Yg9EhOyyB+9YiIc89y5b/84E69P00KPUURWt45vI
         1i6hlDIqilO/79vhKrR1bBxm5KIIFxkw23ziv6o6zgUhRLOvwNAxY4kUu5Tel0/9/xl8
         ff+0U2b2bBGiSCpZ5hyf3A3ovBOeAsSgRRrwqyAbptAr9Ah2YmDgI5DNU5l2qdH1f7hs
         IZJCbkScUN5Jjv8U19S0vO5l+nV+ZhLO+ArKdwpUvP9ZKudLRJGN9nm0plIOEKKOakr6
         TBsZfrnEZpU1SN8pbt8APKcNfv87D6F2ldHk1TLPoYUz7nuVzG7ZRj1u8xghCHgI5ird
         fJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nwfDt8r0FFxI94uOTy5nUUE9dpoo9ucjDC826xRAHEs=;
        b=sPO7T9exNc8c4cDEgd8HZb5/hiPKTrVmkADlLLi7ml1mibZ69ZyOFJA5o+k6qrbE47
         EpQoO4J8MZ+JftRPrJS6sR0KZn0iqtfo2u4/n92PJspko/MxVnOGJS99MYPPqFQnUIXO
         bB5S0Mc+3rkOGxi8SqzGEZ9HQL/kJ1GdUfN2NmKOM4IeO3Wtb1+e0xZXBlZaxxbBjt44
         y/ZD4U499AeNk1o1J8m6SiY2bjc3TSVSymJmt+xNHsxpuWIQXKjAunReayM1G4y6PQVp
         J6q6CtchCvazIiuduvUHy6pU8smDROVjlzg+Hu0PvNmW/0N1pE2xGbMYCXuZTibipy12
         i7/A==
X-Gm-Message-State: AOAM530jNd9meYOFTDmlyZzgp+/azsAo6mCPlwaHOdIbL/nfl/kDQdQm
        CI9Z/GST4k5vWIVJpaHzo57YwCwWS6mvVw==
X-Google-Smtp-Source: ABdhPJyXIcxBcY1dyA6eSqz/P+UKb/0TLMDBhuiYIHDbS48jQyDmiKFYOrcEZo0Qr12Qcr58IQ41xw==
X-Received: by 2002:a17:90a:ad8b:: with SMTP id s11mr18924661pjq.40.1599459122404;
        Sun, 06 Sep 2020 23:12:02 -0700 (PDT)
Received: from localhost ([122.181.47.55])
        by smtp.gmail.com with ESMTPSA id l20sm13907048pfc.72.2020.09.06.23.12.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Sep 2020 23:12:01 -0700 (PDT)
Date:   Mon, 7 Sep 2020 11:41:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, sudeep.holla@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq,cppc: fix issue when hotplugging out policy->cpu
Message-ID: <20200907061154.iiyaq4m3vjtrlkp4@vireshk-i7>
References: <20200903111955.31029-1-ionela.voinescu@arm.com>
 <20200904050604.yoar2c6fofcikipp@vireshk-i7>
 <20200904094303.GA10031@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904094303.GA10031@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-09-20, 10:43, Ionela Voinescu wrote:
> Do you know why it was designed this way in the first place?

No.

> I assumed it was designed like this (per-cpu cppc_cpudata structures) to
> allow for the future addition of support for the HW_ALL CPPC coordination
> type. In that case you can still have PSD (dependency) domains but the
> desired performance controls would be per-cpu, with the coordination
> done in hardware/firmware. So, in the HW_ALL case you'd end up having
> different performance controls even for CPUs in the same policy.
> Currently the CPPC driver only supports SW_ANY which is the traditional
> cpufreq approach.

Then the person who would add that feature will take care of fixing the issues
then. We should make sure we handle the current use-case optimally. And a
per-cpu thing isn't working well for that.

-- 
viresh
