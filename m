Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B15E27726E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 15:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgIXNew (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 09:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgIXNev (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 09:34:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B81C0613CE
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 06:34:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so3884531wrm.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2020 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AHmQxIHTPufi+UR2RfGLNgHO/eGPtc+JmSaoagltYVc=;
        b=wWMf+nQe5B/34hqIN8sqpervlaXL5/2jAPnWv88YCj6AJTvL9Viemp26b9S/QzgjJT
         Kvn0I9+JfmDm7IvImZnITMdUtGXfvGsZv2gBPwDhzaXG2bUGvPWjyCQwN0sYWdJu57IX
         ViFp2j1SODpDHoK2ZMPTh6/j229FaCU9pHDQBdjdytT+Eo1dFyqwKKl0WXdelRTT6f1J
         x5Hs8COVRdDhy1UQwpQ+0itqy9Cj6GBMRZHLHWSJWuyoAEToYU5lm4OVDCZb+HPvJ+n1
         1A7qBk0UVwrsz9a3Ci56pRhlnuCLuVtG0gNbu4se+m2dhLTI/GO4IC/PAkIRIOIR6WxK
         QQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AHmQxIHTPufi+UR2RfGLNgHO/eGPtc+JmSaoagltYVc=;
        b=NjbuTYYqHc4ZMCxCZJP6qEuzgs3N2oxnLiVEhgWtP+NL8u68npi8a6VCWkM+Q8ATaH
         aNeSLb3x/gzya5z/z+6ERMkqxBde4KzK8RQrvGWADZUIBo6rZM9VxZVbu0haWpV1NSr9
         67av4q0hGJa1M3meGiOq4Nw0OLuMCNimp1KGb67shBjOCZEBiIFZp0l73REbGUgnQ8Es
         30i9/PGwcp6GrfhQXtWj0LTQnpZhzIngcZxdfmQl4CbWUM/cQdVxS/J769GV1aGK0spy
         zPE/iY10CgVP2Bf+VSioMKXzsmoj3I1XVnmdZbW7UXcePIaP4A08esEJAKLsDDioFpYg
         LKtA==
X-Gm-Message-State: AOAM531LThuA+pWEusdtPfA79g1iEM+wTFu9huW2C14Z46/7TdOos8Wc
        uh6VU7T6E7oxg0y85w5q+ZmRnQ==
X-Google-Smtp-Source: ABdhPJzz1iuxB8yMgk8VfJVBob6+7W+AlkLoqZKC4tAXB33eouYnScSHMBpBmeoACCVJjNkW7/U/eg==
X-Received: by 2002:adf:f986:: with SMTP id f6mr4949309wrr.270.1600954490182;
        Thu, 24 Sep 2020 06:34:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id j26sm4411495wrc.79.2020.09.24.06.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 06:34:49 -0700 (PDT)
Date:   Thu, 24 Sep 2020 14:34:46 +0100
From:   Quentin Perret <qperret@google.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/topology,schedutil: wrap sched domains rebuild
Message-ID: <20200924133446.GA3920949@google.com>
References: <20200924123937.20938-1-ionela.voinescu@arm.com>
 <20200924123937.20938-2-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924123937.20938-2-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 24 Sep 2020 at 13:39:35 (+0100), Ionela Voinescu wrote:
> @@ -433,6 +437,7 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
>  }
>  #else
>  static void free_pd(struct perf_domain *pd) { }
> +void rebuild_sched_domains_energy(void) { }

Nit: maybe make that stub static inline in a header instead? I guess LTO
and friends ought to clean that up for you, but it shouldn't hurt to give
the compiler a little bit of help here.

Otherwise, LGTM:

Acked-by: Quentin Perret <qperret@google.com>

>  #endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL*/
>  
>  static void free_rootdomain(struct rcu_head *rcu)
> -- 
> 2.17.1
> 
