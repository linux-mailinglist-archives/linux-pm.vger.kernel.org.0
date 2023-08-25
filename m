Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A66B788010
	for <lists+linux-pm@lfdr.de>; Fri, 25 Aug 2023 08:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242058AbjHYGjm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Aug 2023 02:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbjHYGjc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2023 02:39:32 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1931FCB
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 23:39:30 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1c8d895a602so362688fac.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 23:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692945569; x=1693550369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1WgDAlgwru6Ubk2nOTTHuUzG0ifZyKXeoH3bmFI55mQ=;
        b=xWTap7b6KjGFd35uAPX1Yn9KWrq78hJY4xNw5NkbPEub9UgGozjUbF9N9i8OxKik+u
         +USIVF4B7TJfRTVVrFPfKvf82W4sDKockuWbrQQ5OKZiJ4z2Yd5etj0veUynni9mqJPL
         CoePRkRNs1PMTqL1uqHpq/s4nrUchUBlVeuYDcQu8nLDHLjt9CcmJAvnMnaTw76fzUts
         ClK543zARJd/UhU34mp0+bTBW8Me8wHxUz5FtD5elnAodXrBB2Vi+dhRuDVvICYZdRLd
         Efriu/xOPILeXGWM/ex8TkOMWSuQqpc+QhGibaPFlLZoG4MCAVhDcEIvEN2V/2EDF9BI
         OpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692945569; x=1693550369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WgDAlgwru6Ubk2nOTTHuUzG0ifZyKXeoH3bmFI55mQ=;
        b=RdTFV8JxtbOiLvHZEp8U9LLp1NrKALcPEUQN0Hl+Rws6xqy7v7AfD4Jb9vpJs9nVPr
         SNw+9NUkgsFFxJi6/S4h4lgJTkmWvXrIMdDXy5UGtd5T9TKl34P2E2e80vwdeN6beVO0
         y4hv+UwrrldVdPQTMCGFtqEBg7FUmaKCyy+hsNv6HgpJ/DA/2qqo8/JI2G3uiZrB47Jc
         LvwZU6Wrg8Her/ZQ3DAVBnCmPNafIUn7xLkiXQKSDhSxTydo4DJ4oag76OA5lrhGgyAn
         6Be88pz//x0hTDiBg2W+cAKz96dPGr8tgmH7eJ1TNulVWgQ7sHH8h5zv/D9tJgyr4oBE
         GQWg==
X-Gm-Message-State: AOJu0YyoLmKS/aubPDJH8Rq36ERra080PgdLex3gJbzi9gO0VugBtnTR
        Z6ogVex2najWBXmeft6WJQSANg==
X-Google-Smtp-Source: AGHT+IFufVvytaEwsJpH+al9V2KuRovl3mSJRnUVk55X3PudBOMaIgZHkzIJOrbKnS2pOnV/EtFM7Q==
X-Received: by 2002:a05:6871:5c6:b0:1c0:fe16:90f8 with SMTP id v6-20020a05687105c600b001c0fe1690f8mr2183814oan.57.1692945569460;
        Thu, 24 Aug 2023 23:39:29 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id x53-20020a056a000bf500b0064fde7ae1ffsm784566pfu.38.2023.08.24.23.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 23:39:28 -0700 (PDT)
Date:   Fri, 25 Aug 2023 12:09:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jie Zhan <zhanjie9@hisilicon.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        xuwei5@huawei.com, wanghuiqiang@huawei.com,
        jonathan.cameron@huawei.com, wangxiongfeng2@huawei.com
Subject: Re: [PATCH v2] cpufreq: Support per-policy performance boost
Message-ID: <20230825063926.n4o7cp6x56r5i2it@vireshk-i7>
References: <20230822124837.3016641-1-zhanjie9@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822124837.3016641-1-zhanjie9@hisilicon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-08-23, 20:48, Jie Zhan wrote:
> The boost control currently applies to the whole system.  However, users
> may prefer to boost a subset of cores in order to provide prioritized
> performance to workloads running on the boosted cores.
> 
> Enable per-policy boost by adding a 'boost' sysfs interface under each
> policy path.  This can be found at:
> 
> 	/sys/devices/system/cpu/cpufreq/policy<*>/boost
> 
> Same to the global boost switch, writing 1/0 to the per-policy 'boost'
> enables/disables boost on a cpufreq policy respectively.
> 
> The user view of global and per-policy boost controls should be:
> 
> 1. Enabling global boost initially enables boost on all policies, and
> per-policy boost can then be enabled or disabled individually, given that
> the platform does support so.
> 
> 2. Disabling global boost makes the per-policy boost interface illegal.
> 
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> Reviewed-by: Wei Xu <xuwei5@hisilicon.com>
> ---
> A possible question could be: why not just limiting 'scaling_max_freq'?
> Well, the fundamental difference is that per-policy boost could be more
> user-friendly.  When global boost is enabled, it is not straightforward
> to figure out the base frequency for setting 'scaling_max_freq' to a
> non-boost value. Also, this is supposed to take effect on the physical
> upper frequency limit, reflected through 'cpuinfo_max_freq'.
> 
> v1->v2:
> - Rename the interface from 'local_boost' to 'boost'.
> - Illegalize writing 0 to per-policy even if global boost is off.
> - Show the per-policy 'boost' file only when ->set_boost() is available.
> 
> v1: https://lore.kernel.org/linux-pm/20230724075827.4160512-1-zhanjie9@hisilicon.com/

Looks good now, thanks.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
