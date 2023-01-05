Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5475165E467
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jan 2023 05:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjAEEI2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Jan 2023 23:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjAEEHo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jan 2023 23:07:44 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E26865A4
        for <linux-pm@vger.kernel.org>; Wed,  4 Jan 2023 20:06:20 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso820805pjc.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Jan 2023 20:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2WUgdRzrI/SUWdkfU2zzU2jqPB+xytPHTHn/UO5u/4=;
        b=XNoz8y0PCffV7ZZXe930Y7iJiChf9FYhQ6uQTYbcNs9DLBWx+BcX1p7lPEm8qiXZ4/
         vqnUcL3zWnCjRrzEcSPlv64cLkOJjgZCg+7I0Bbbp8H1qQIgNMyGU2EiLyQyne+RqCwH
         NcWsDasjyTWZfQVCk0qoAgzoHAKzN1cQ53exmF44Zk9DxgPnc33w/X7bxgAX9/ukfQtb
         aCPjLHB6AmRoq1Uhwm80N7xyLs4YNmiuolyui2yDOgK1SzlH1koSC/nIRIaJthXiX0Ss
         PRJqnoYMb/1V0GsFu5XkqURo/lo1/70dQoX45fOTGVgGCztPBZtL4+TrcSds0jVurGr/
         CPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2WUgdRzrI/SUWdkfU2zzU2jqPB+xytPHTHn/UO5u/4=;
        b=jTsLcGzb1kuxclpVZnErTSo00scr6bpxnG5uAGbeVxBGMrQS44yFxUztnQ12KclryL
         Sni8EegLBikbY+tQcpDYj3k+zbnFz9EXAeRcUZQxvlhR8drFD1GIHTdPB+Bp3366leyH
         kVkw8zQ/5OScNu+C6vwRgbtvRxsGlJlhWMXiCzThEDolXRcUTJ6wbPx/IzfFFy4227KD
         7ARxUNzV831M7NtUwIh8jHB8NScdCZooeqMS16Vs02bG6jbouQu7+K7ltyX7DXG3ckmT
         eSpNeB2MoAGZJPfJnTB2NYLyvMflufKSpdzSYmYA/yqL47kKKlNajYhFCxQ3QCqxqDiV
         n8hA==
X-Gm-Message-State: AFqh2kok1kAOT17GL3BnEg2J3ZsCiFSDlIpQx5BfrqvsavEdkleCxyCX
        Dg7AqAhCyuLdLnHA+pO2Qkk4mA==
X-Google-Smtp-Source: AMrXdXudTvKaDmu940BwQOcoLq8kE1E7GGTuVkpTfjGA1jeqmrgNi73HV/JfeO0TaaUVCN4mZPphhg==
X-Received: by 2002:a05:6a20:94c3:b0:ad:dcdf:aaad with SMTP id ht3-20020a056a2094c300b000addcdfaaadmr65117893pzb.19.1672891579639;
        Wed, 04 Jan 2023 20:06:19 -0800 (PST)
Received: from localhost ([122.172.82.107])
        by smtp.gmail.com with ESMTPSA id 27-20020a63115b000000b00477bdc1d5d5sm21039648pgr.6.2023.01.04.20.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 20:06:19 -0800 (PST)
Date:   Thu, 5 Jan 2023 09:36:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH rcu 16/27] drivers/opp: Remove "select SRCU"
Message-ID: <20230105040616.7algt4tvswpzal6d@vireshk-i7>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-16-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105003813.1770367-16-paulmck@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-01-23, 16:38, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: <linux-pm@vger.kernel.org>
> ---
>  drivers/opp/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/opp/Kconfig b/drivers/opp/Kconfig
> index e8ce47b327359..d7c649a1a981c 100644
> --- a/drivers/opp/Kconfig
> +++ b/drivers/opp/Kconfig
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config PM_OPP
>  	bool
> -	select SRCU
>  	help
>  	  SOCs have a standard set of tuples consisting of frequency and
>  	  voltage pairs that the device will support per voltage domain. This

Paul,

Should I apply this in my tree ? Or you plan to merge all the patches
yourself ?

-- 
viresh
