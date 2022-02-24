Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8824C2308
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 05:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiBXEam (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Feb 2022 23:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiBXEak (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Feb 2022 23:30:40 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D171B71A7
        for <linux-pm@vger.kernel.org>; Wed, 23 Feb 2022 20:30:11 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 132so741212pga.5
        for <linux-pm@vger.kernel.org>; Wed, 23 Feb 2022 20:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=77P2JI+MyxRqWwyJzILWsMrPWI1o+ce61O2JTaPSvAQ=;
        b=TPlqsYcEVfDCM0ihBfeUhtrw/lPll3vq+t4q/NTb1mET+tgGSzklKnwGsKNK8je7KF
         YLmPlSfbbb+Cwyb3vr0MVGN3BY/52j0Rw3+3nNi6VRnhyfMhaum3drXpRWeK2YfZC+Um
         ls+A6RQnosFrQTyEtPNLtpx1XkvHzz4L/WiXoMDZVKoBEU67ZPAOKb2ZZjNGVqa8fxLx
         LtaMmIyWUPuJv9R3llX155mpNCiMyb8wMTJVVJPTcENyGbdng+BF+AWbpqhUz4iwltPh
         3Vfq19GtMOf6rkpndGipRMap1gjJ10f5Yg1OAJzNILMi1iTQHNSYoYtxBP3ClXMIkwul
         Yx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=77P2JI+MyxRqWwyJzILWsMrPWI1o+ce61O2JTaPSvAQ=;
        b=TFCYp7sk3DnfdmmWfCNAO4UtGVOfTMmhoAu5FFk3Lzgw8W42nxO6UAsjg1k+JV4npp
         zSBbD0EFR3ytJtLPB6lxC1kYQskulmT3Qt8dknjg0QhiqpNgUrttGaDmzhx8GzD2ayWy
         RQA/vzRSbhDgUm7uH6zHkPHKBm/PNUxlehM5KBu8wmGZgdG9Io7L1KvauDe5Ce81MN+t
         mGQ1h9KfpgJCKA4IeRdcL0WH0EzhfIxl1okF/sK4PeQH6pz3F7Cp6Wqm8fOwu/LdVDvS
         tS++SUQTpxS8505gvkkV6KKtmi7mjTvjM1sFcY+Gu+nzh+hoUWqfLPLZni1eQKXYicKR
         n0iA==
X-Gm-Message-State: AOAM530MrWxZn6Uz3VXR7jTGjCb67ap2CjJUrTtHSXfuJeO73+/6ZJMh
        4swRYrkYdvctmUfeQgZIsSRXKA==
X-Google-Smtp-Source: ABdhPJytq8B48Scyl8uOOxMNpUYQGbfIAT8QYo9CDFTOyEWhqfNtkl6oIri9xLAAyoaKM/PuLVc0xg==
X-Received: by 2002:aa7:8d54:0:b0:4e0:bd6:cfb9 with SMTP id s20-20020aa78d54000000b004e00bd6cfb9mr858266pfe.60.1645677010703;
        Wed, 23 Feb 2022 20:30:10 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id ng16sm992291pjb.12.2022.02.23.20.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 20:30:09 -0800 (PST)
Date:   Thu, 24 Feb 2022 10:00:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: Add support for per-core-dcvs
Message-ID: <20220224043007.2s3jrwork4zxxlsq@vireshk-i7>
References: <20220210050117.747569-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210050117.747569-1-bjorn.andersson@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-02-22, 21:01, Bjorn Andersson wrote:
> The OSM and EPSS hardware controls the frequency of each cluster in the
> system based on requests from the OS and various limiting factors, such
> as input from LMH.
> 
> In most systems the vote from the OS is done using a single register per
> cluster, but some systems are configured to instead take one request per
> core.  In this configuration a set of consecutive registers are used for
> the OS to request the frequency of each of the cores within the cluster.
> The information is then aggregated in the hardware and the frequency for
> the cluster is determined.
> 
> As the current implementation ends up only requesting a frequency for
> the first core in each cluster and only the vote of non-idle cores are
> considered it's often the case that the cluster will be clocked (much)
> lower than expected.
> 
> It's possible that there are benefits of performing the per-core
> requests from the OS, but more investigation of the outcome is needed
> before introducing such support. As such this patch extends the request
> for the cluster to be written to all the cores.
> 
> The weight of the policy's related_cpus is used to determine how many
> cores, and hence consecutive registers, each cluster has.
> 
> The OS is not permitted to disable the per-core dcvs feature.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Applied. Thanks.

-- 
viresh
