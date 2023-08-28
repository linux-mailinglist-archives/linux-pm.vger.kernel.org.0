Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB06F78A9F7
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 12:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjH1KR4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 06:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjH1KRg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 06:17:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEFE1A1
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 03:17:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68becf931d0so2109863b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 03:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693217844; x=1693822644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eZsxRxv+CQTRUY7A/T7Jkd4dX0Ikc5XaKyAkP131uo=;
        b=To/JKiCa2vTswPz+vcuEe9l1osMwbns2sF0xYnhfBBoe0lG5Z7w4ekpCaEmHlP/0Je
         Iej4LW0sbaMP5RkUoW3mqytTouTf6mYvAAkMya4XQoqtZ7+LOH3Yv0OSIMt4lIdfJthY
         EOBE1q69DG/phunf5iFI7y5aqs20Qc7M0YMsE/qEIdxaZxCZEa1V3YnXDHY6gsN2xqXl
         yCorBOZ9MNrNWL71cv4UFotVAWaD7GcCdJ+387W6Uf4Br6fKgLKoGZH+wQm8utatzx+n
         ZR/2s28mBVN6vJtLVnCtaXINLPwAxSZuwsyR9LbyrclQtH6eXb4W3oIPxrq+khYZ+Wxt
         7YnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693217844; x=1693822644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eZsxRxv+CQTRUY7A/T7Jkd4dX0Ikc5XaKyAkP131uo=;
        b=IcM1+lbB0YpPjz6g1TTlewT/qMQ7Us48hC+/WIgGg+DctrnfR3seLmqttUm+tjBieR
         tZi4sU/kmZBAGdRLreyKcimKK/bwjOvf/0d5dEG++cl8WnL1NJki7pkbvv6eQnZi9KEN
         9a8v+gaLtTRHwciQaoMTBex5vcRTdI1o8LDAwsxtGlqJoJRSz4Yb28bwRa7f+XcnthnQ
         LGddUDRDHUdUFMsFi78j7nMA6YSrKV0hCbPPa2kp3THoE2RvIfVAdPcs1qTVS7DqHM/d
         MpFxANpbYZHWMjxo1Uj70gTdkZ/TwriNFA8DOIf6q/ozwz1iWGAdHcQkiHAOuinsH94w
         DY0Q==
X-Gm-Message-State: AOJu0Yz/2C1iZz60Nw1jR2CBvZnf9r9shASsLze4QXUOdU2PhMPQZhlV
        dZQpQ2M5khmxsBbsqNIanrguaw==
X-Google-Smtp-Source: AGHT+IG5eYyKxQ7v4BeSYTP68ZLyOM0a+2UD6jhzG4o1aaQzmzh48JM6+NSHjC/PrFyhQzDxn0ocYQ==
X-Received: by 2002:a05:6a20:2449:b0:13f:3d25:d83 with SMTP id t9-20020a056a20244900b0013f3d250d83mr24662771pzc.19.1693217844123;
        Mon, 28 Aug 2023 03:17:24 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id t25-20020a63a619000000b0056da0ae25cdsm6984680pge.80.2023.08.28.03.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 03:17:23 -0700 (PDT)
Date:   Mon, 28 Aug 2023 15:47:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com
Subject: Re: [Patch v2] cpufreq: tegra194: remove opp table in exit hook
Message-ID: <20230828101721.zq5vlc53p5umi63c@vireshk-i7>
References: <20230825111617.8069-1-sumitg@nvidia.com>
 <20230828061115.vsepgtexyv3hvffu@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828061115.vsepgtexyv3hvffu@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-08-23, 11:41, Viresh Kumar wrote:
> On 25-08-23, 16:46, Sumit Gupta wrote:
> > Add exit hook and remove OPP table when the device gets unregistered.
> > This will fix the error messages when the CPU FREQ driver module is
> > removed and then re-inserted. It also fixes these messages while
> > onlining the first CPU from a policy whose all CPU's were previously
> > offlined.
> > 
> >  debugfs: File 'cpu5' in directory 'opp' already present!
> >  debugfs: File 'cpu6' in directory 'opp' already present!
> >  debugfs: File 'cpu7' in directory 'opp' already present!
> > 
> > Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > ---
> > 
> > v1[1] -> v2:
> > - updated commit description.
> > 
> > [1] https://lore.kernel.org/lkml/20230809153455.29056-1-sumitg@nvidia.com/
> > 
> >  drivers/cpufreq/tegra194-cpufreq.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> > index c90b30469165..66a9c23544db 100644
> > --- a/drivers/cpufreq/tegra194-cpufreq.c
> > +++ b/drivers/cpufreq/tegra194-cpufreq.c
> > @@ -454,6 +454,8 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
> >  		if (ret < 0)
> >  			return ret;
> >  
> > +		dev_pm_opp_put(opp);
> > +
> 
> Missed this earlier, can you please do this in a separate patch please
> ?

I have pushed rest of this commit and dropped this part. Send it
separately. Thanks.

-- 
viresh
