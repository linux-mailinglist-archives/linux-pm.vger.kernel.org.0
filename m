Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276DA4205E3
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 08:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhJDGjG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 02:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhJDGjG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 02:39:06 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1B9C061745
        for <linux-pm@vger.kernel.org>; Sun,  3 Oct 2021 23:37:17 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s16so13662713pfk.0
        for <linux-pm@vger.kernel.org>; Sun, 03 Oct 2021 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bo1AfZo2B0G6Qf7w5hIV2g2F/2qOqHeUUj32w/8pRyc=;
        b=J3FCPjvQ91Zm759hElGSstImuWo8dJLPQDskX+6fCdq3JReSGPzaXKZXpW3MNeqWKX
         16MDjPnmnbrgXjqL/fV39uX8nNjZ+UTYivCHqN0/2e2fXYC0YLiphn0Mb+eM+nRoWBW0
         /bUNr/naX+9Fwm2wqSRwg3bppRTkGdPjl534m7oTPeAvljymvWRUKWNDjK0g0ZD9AamN
         Z0rQ3+Gwahr0TY32w0/VpP3EcpnghufANXZ8IGhyjX4uCskP7buX//DwX8cPD9k8O9Cd
         9cfsBrPXeGAtXX1m6acV0+nXxcLM5ZRB/vXjfUF0F4sNbxUfJB6Mq+vC54JKfXmGRfbR
         W93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bo1AfZo2B0G6Qf7w5hIV2g2F/2qOqHeUUj32w/8pRyc=;
        b=XbZGWAl/RlPyeB7AotY5x7zqUR9WNfkWzjlhdm3yBWfNKOmLIBILPPfsF1aU3mUWWY
         IVwqyaJsl1AL1WUY7lB2TxfOtT7WmQAhCoEE9yJXwDVhR5LdYdKiWaePPkOoJRWRbVfQ
         +HuVHi/QvCnMwaUkjvQaW4Hqb3B1es4y4DEv2Jzv4JIm9JnVLHeBAjXc5K56Zu+07f0J
         ONhi8rQ8L3/M7oTwFNFDvWCBifn3IumddqDJxIhUNrejGq4C/rjdpLTmHH5oCSPj4DOX
         U+O71agr25VosfkrUi1mm4k7UQYsIVEDlG4OwUYzK3qfULYwEqWg1HlPy/wUI9y6dXZl
         BuDg==
X-Gm-Message-State: AOAM532IZc2piIBf5MP2o0pcp33DCJYy4+44ANEfqJEWxN1IB1Up2qP4
        s/s/G1d8Jv2gQ92ZVfDeArPqKA==
X-Google-Smtp-Source: ABdhPJy2PwdNkXBTM1trCwQuWiBzmQKtgRp85HM5DKtIzNpf5iMj9DZTHKHrtExQWgDfVT9U3l1Dfg==
X-Received: by 2002:aa7:914d:0:b0:44c:61e3:99b9 with SMTP id 13-20020aa7914d000000b0044c61e399b9mr3417268pfi.65.1633329437232;
        Sun, 03 Oct 2021 23:37:17 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id n9sm13233203pjk.3.2021.10.03.23.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 23:37:16 -0700 (PDT)
Date:   Mon, 4 Oct 2021 12:07:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mikko Perttunen <mperttunen@nvidia.com>
Cc:     rafael@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        krzysztof.kozlowski@canonical.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, p.zabel@pengutronix.de,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] cpufreq: tegra186/tegra194: Handle errors in BPMP
 response
Message-ID: <20211004063714.5bux4hwv3lchibnn@vireshk-i7>
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
 <20210915085517.1669675-4-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915085517.1669675-4-mperttunen@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-09-21, 11:55, Mikko Perttunen wrote:
> The return value from tegra_bpmp_transfer indicates the success or
> failure of the IPC transaction with BPMP. If the transaction
> succeeded, we also need to check the actual command's result code.
> Add code to do this.
> 
> While at it, explicitly handle missing CPU clusters, which can
> occur on floorswept chips. This worked before as well, but
> possibly only by accident.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/cpufreq/tegra186-cpufreq.c | 4 ++++
>  drivers/cpufreq/tegra194-cpufreq.c | 8 +++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)

Should I apply it alone ?

-- 
viresh
