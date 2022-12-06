Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3994B644121
	for <lists+linux-pm@lfdr.de>; Tue,  6 Dec 2022 11:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLFKQg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Dec 2022 05:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiLFKQe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2022 05:16:34 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B7D1CE
        for <linux-pm@vger.kernel.org>; Tue,  6 Dec 2022 02:16:33 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y4so13472484plb.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2022 02:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pN6IhImBKsrk1Eo5/1DUY+8IvLXyhacd5dYyhSLWzTg=;
        b=RYURwSMjG4tW1hFv5iYwoRJPYf6chtrCwJGrnnJlENYL4n6j7sENkzTHvYuYZkw1Vn
         Al+VicNVV3T0v43T+OWv3DHaAOm3mnZSEs+i8ql0GD4/O4GxtjzxTr1/2s/nMn8YiHJ7
         wOX8tGuyaJjLdhtqc+nMXdz/9tTt4onGjEfQntZCEQhuFG2t9dJrmD8G4y1/mlhbJHSR
         Rep6iaQ+UlPIDQ5V+fCGvcNKGUbVQwnYRMGDtyB2+kqjb7efnxmImHRAT/eQBzoBn7iZ
         3GVLwqj8tAmvCxEu9f2hIX89IUZJZKcB4tJz5pw/CNrX3DIiEy2HCWx6d6yC220ECFO3
         gQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN6IhImBKsrk1Eo5/1DUY+8IvLXyhacd5dYyhSLWzTg=;
        b=yEJB/MLc4rW6zJmxYj4RQEQv316XqNepiaYHgJqDqt/HQ1TxG1ZMjVrbafyLS9jjWG
         ic04ZTpoSGmpdbL1bQVTN6JwmsTnDqNyv5qbeVQ5LKROZPbZWmFuinxJ2zz5+gdyaXhm
         GiElXb80KCL4oMgmrEAf9VMlALVdOYcRsq6FEJrCWivsf/aEXJyrXMhjTaLfV4FSrRQZ
         tU6+tgNrgKy6a9oiUHEA2nLCd3c/ZpkwOnid11lYHGb5f16kfQ9TLewusRPgGZn87/uz
         5BH2sOi7h9yh1bv7QObB1DyrxD3EJ7jj5RG595cRP+0gINFNlmMQ4oxpTheSDRwd3ZuX
         U5pQ==
X-Gm-Message-State: ANoB5pn6vXk40cjahYjQqAE1xTQ09Q0VXf3qgCQJ+wH63cbxn61dbVt0
        xbgaES7tTbLWwgxFoUuwPl5GYA==
X-Google-Smtp-Source: AA0mqf4xPPdhz+v13Xt4vQdKecxKyl1FxW3RsaYobQ3KErB/lCfR9LYIg67YcYoXYdc507XoUrzK5A==
X-Received: by 2002:a17:902:bc84:b0:17f:700a:2cd3 with SMTP id bb4-20020a170902bc8400b0017f700a2cd3mr71763689plb.36.1670321792718;
        Tue, 06 Dec 2022 02:16:32 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001782398648dsm6825490plh.8.2022.12.06.02.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 02:16:31 -0800 (PST)
Date:   Tue, 6 Dec 2022 15:46:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, saravanak@google.com,
        wusamuel@google.com, isaacmanjarres@google.com,
        kernel-team@android.com, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de
Subject: Re: [PATCH] cpufreq: schedutil: Optimize operations with single max
 CPU capacity
Message-ID: <20221206101629.dbcuv3zdso44w3cq@vireshk-i7>
References: <20221206101021.18113-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206101021.18113-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-12-22, 10:10, Lukasz Luba wrote:
> The max CPU capacity is the same for all CPUs sharing frequency domain
> and thus 'policy' object. There is a way to avoid heavy operations
> in a loop for each CPU by leveraging this knowledge. Thus, simplify
> the looping code in the sugov_next_freq_shared() and drop heavy
> multiplications. Instead, use simple max() to get the highest utilization
> from these CPUs. This is useful for platforms with many (4 or 6) little
> CPUs.
> 
> The max CPU capacity must be fetched every time we are called, due to
> difficulties during the policy setup, where we are not able to get the
> normalized CPU capacity at the right time.
> 
> The stored value in sugov_policy::max is also than used in
> sugov_iowait_apply() to calculate the right boost. Thus, that field is
> useful to have in that sugov_policy struct.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Can you please divide this into two patches, one for just moving max
and one for looping optimization ? Else we may end up reverting
everything once again.

-- 
viresh
