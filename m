Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF476061
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 10:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGZII0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 04:08:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37177 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfGZII0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 04:08:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id i70so13657332pgd.4
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 01:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6GhmKWt6x6g4JeMnsdkEsHpQSie6HYXc08TEONF6ep4=;
        b=n6WXmFb6NJb1VDNPQg4jO1cjrEDb4DE4V1d3nSxW/tUAj9eTVtMjjNTCSj6+ASZCdl
         G/scPEuJI+Abaxi6NlVvFlnoIYsmxxtE89knUPK5NJbQIf+dRZRBG0igszN4qomenA/H
         2SrVjLOALgmb08gzV4+vi9TF4xsXqPcLyqS0cNFoz3OJETJLwCJj9ypLQPnYp4yzJS/u
         4gWQQU79QYRQbhul4Tz8t4v+krSOvI85dXy5PURGtflyjER6T7mTlZ0U84JwYDJC2fa9
         LVZhryGsJjM577AfdBHTm7wX8gjvGJYZ8n3736xs92Z4hHhha/man1T9uPe3xG8IurgI
         AmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6GhmKWt6x6g4JeMnsdkEsHpQSie6HYXc08TEONF6ep4=;
        b=fNPY19ukXbytEgf8SJJ6WGTATJVdHARoVfq+gYXLnb9oiFWR4NdrgHQc5S+ac3+kAL
         PKl//54m5cRomqdOGQAocZSziNOljdMRVUKYtYf6WmrPvpGZL3hKR7s1FSJqmmxqkPh2
         NNBtciC8meqSxr4XDyHp9fjx/wHdPC79oohrW7esBK2ELvM9POn0pjlqqH45sKVWvr7f
         sDRdQ70sNnRmy39NIU+it4ZX/NKMmk0XevoiRu827tWSPEBFj8qme2jcwWskP8u5kESR
         1CfHjJjC7VdNZ6NAD70nztUTm2xKTNTXY9/2yi4r+Ip5SDfYpbHZYm+9FPT8YhHQxqHt
         1hbg==
X-Gm-Message-State: APjAAAXrKEuM3q2dOVch3W0a/Sl3HLLgGnj0Xd3EekUNgyBgoLC+QoRI
        6a0l6USybgHd+BFvmHLz0IVSUQ==
X-Google-Smtp-Source: APXvYqyT9ZKXFFPNPq9JhH0XdJl1BiqKPW6iP2gtCefxpHHM+yjax7AxEbe1z2UP56YTq6iXpWC95A==
X-Received: by 2002:a62:3895:: with SMTP id f143mr20705053pfa.116.1564128505484;
        Fri, 26 Jul 2019 01:08:25 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id a1sm5500514pgh.61.2019.07.26.01.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 01:08:24 -0700 (PDT)
Date:   Fri, 26 Jul 2019 13:38:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/14] Add support for QCOM Core Power Reduction
Message-ID: <20190726080823.xwhxagv5iuhudmic@vireshk-i7>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725104144.22924-1-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-07-19, 12:41, Niklas Cassel wrote:
> This series adds support for Core Power Reduction (CPR), a form of
> Adaptive Voltage Scaling (AVS), found on certain Qualcomm SoCs.
> 
> This series is based on top of the qcs404 cpufreq patch series that
> hasn't landed yet:
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=137809
> 
> CPR is a technology that reduces core power on a CPU or on other device.
> It reads voltage settings from efuses (that have been written in
> production), it uses these voltage settings as initial values, for each
> OPP.
> 
> After moving to a certain OPP, CPR monitors dynamic factors such as
> temperature, etc. and adjusts the voltage for that frequency accordingly
> to save power and meet silicon characteristic requirements.
> 
> This driver has been developed together with Jorge Ramirez-Ortiz, and
> is based on an RFC by Stephen Boyd[1], which in turn is based on work
> by others on codeaurora.org[2].
> 
> [1] https://lkml.org/lkml/2015/9/18/833
> [2] https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/drivers/regulator/cpr-regulator.c?h=msm-3.10
> 
> Changes since V1:
> Added a new patch implementing dev_pm_opp_find_level_exact() in order to
> make the CPR OPP table in device tree cleaner.
> For more detailed changes, check the "Changes since V1" as comments in
> the individual patches, where applicable.

Applied patches [1-9/14] to cpufreq and OPP trees and done some
reordering as well to keep all binding patches together.

Rob's Ack is missing on two of the binding patches and I will add them
later once he provides it.

Everything should be available here for you to base rest of the stuff.

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

-- 
viresh
