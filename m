Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5177E7EBD14
	for <lists+linux-pm@lfdr.de>; Wed, 15 Nov 2023 07:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjKOG3l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Nov 2023 01:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjKOG3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2023 01:29:40 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F1AE7
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2023 22:29:35 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c194b111d6so2378099a12.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2023 22:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700029775; x=1700634575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ijWgB/n7wQWOhBbaV1md72p8BCrVtoBj2gz5Jm1idO0=;
        b=BrLPsIcbbxEeDIlp/W6DNYnO7aFe9v/lWyJ9wXQfaHy54r50+uLkAZfeeY9P1lAhBn
         S9+G2/jnK2ZaDjho2gMvEYxlniqc2qT9Ty9VMUVgBfSGerEly11jSY/0TU5+MnsNl0yT
         S0256uC4zYisWcT10Z+uz2XW/xpZkSwONPhZCxcqKDwrrMeDa4ujhK5USuhTvmjdtTuH
         D/LeRBeHntStjb63XuvRPQdyLYXJ1soFFSjvD+iNnfVwkviglGfkPQhnHZWIc2wUeECM
         Uhj4VPju1NxAF4lVVrxgpvmHRdjndMyFdGtnBOiHbYJFj4ogEi61KuA7KkWb0gWTo/Qi
         JsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700029775; x=1700634575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijWgB/n7wQWOhBbaV1md72p8BCrVtoBj2gz5Jm1idO0=;
        b=HQpV99esQ9wE6C0RBR30F6P2l3t09Qwv4+PN3KtYn/aq2x4eSQZJMuXToUvt+j2ozz
         vcWqEINCOe8IMXDf8Qs2wKo/8nAFCU/zfsW1eWOPBVC1GSu05o2SApo2LNCiHCOn5X21
         JoV5gGkckU31OvitJRNzaiiiTptRKSMVMqGhNEWVkUaQcMU+pbxFhjRDxADmSYcOsdpR
         OJFSWy1AXeQvBJgj5f1CPKAWAXWva18r08Lw6jZ3hdytrOmUVZT3z5EdJsmsekdyKkqr
         ML6R+RytRQc8TeZqhDlETPcPOfbyeZMaTv93yeumf2hUpKOQze6ghnjhDdjGHV+Nsx4O
         nRwg==
X-Gm-Message-State: AOJu0YxtA49rzJerTE2cu83GrRetDy1Wdjjvihvzz85rWW61hKCNGgmx
        G7pxxqDWuDdCS9VluQOPuId2Qw==
X-Google-Smtp-Source: AGHT+IHNQoS9uDAn0ReyTwQP6t3z0RVvRg7vMQN4mCOr0kGFtghMcGt9yzA+q1gHzzOarfaJd1+BRw==
X-Received: by 2002:a05:6a20:244e:b0:15e:d84:1c5e with SMTP id t14-20020a056a20244e00b0015e0d841c5emr15202326pzc.38.1700029775212;
        Tue, 14 Nov 2023 22:29:35 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id oo3-20020a17090b1c8300b0028328057c67sm5810344pjb.45.2023.11.14.22.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 22:29:34 -0800 (PST)
Date:   Wed, 15 Nov 2023 11:59:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     David Dai <davidai@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] cpufreq: add virtual-cpufreq driver
Message-ID: <20231115062932.vz2tyg6wgux5lx6t@vireshk-i7>
References: <20231111014933.1934562-1-davidai@google.com>
 <20231111014933.1934562-3-davidai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111014933.1934562-3-davidai@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-11-23, 17:49, David Dai wrote:
> diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
> +static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *policy)
> +{
> +	writel_relaxed(policy->cached_target_freq,

Drivers shouldn't be using the cached_target_freq directly. Use the target freq
or index passed from cpufreq core.

> +static int virt_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_VIRT, policy->related_cpus);
> +	kfree(policy->freq_table);
> +	policy->freq_table = NULL;

No need of doing this. Also the order of above two calls is wrong anyway.

-- 
viresh
