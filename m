Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD3C52467D
	for <lists+linux-pm@lfdr.de>; Thu, 12 May 2022 09:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350655AbiELHH7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 May 2022 03:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350735AbiELHGC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 03:06:02 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE14310
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 00:05:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 7so3784362pga.12
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 00:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YI7qa/QXN/dczkT1YUrOOGjLkBD1yFf86CRdik/OXPc=;
        b=Y4apOYdNhXDppeVSa/hY0qEPuUky2k8Mg+NNjWBrW8mmFyzqzKMGoEWHE4GFn2zp4H
         cxj7pbd/24zF85Owm07osrmLRw6g2PD6EgaPzgQDGaeAukm6kGaAvSRpF2NXxyTATdTU
         lklv61EIttvQ3OGS2ci0xlBzXvhZPYzuqB223Cs7TnGxoZ9g/p9rgDbnwrNrTXTeUjwJ
         CRKFky5J7zDncf+87NEMYukF70kBixfmGKs31BrVSspYyJ9o+7maC2rRQCOfHoqf5KMN
         Sju56e+jlLk0zAiU3jppCPWN174v69+nsVIbDO+8ck5wqJunF68ADmKuV5IZmHvvH3Dz
         6pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YI7qa/QXN/dczkT1YUrOOGjLkBD1yFf86CRdik/OXPc=;
        b=4iCR0ykCA49ZqKqdH/Q7yfnjarx3T5EE8yurR8sj8Ov3XRQWnZwPhAlgirJUEM9lRM
         VJumchwYwgdu7arV/DQW0unyEZH3KU69Ko2VmwIUscpEb2Kp/RDl5n9KkwVKLkBmLLOH
         H2Q58dhFDYKIF5kawbiWAVYP9tmAKE2YqpmVcTqMfr/q1SXYdIcb0XxSbwMSPCbeBoKY
         WDLz3GZ0Wr6u4GvJ+vlT82p24EErKo/f/xAU0mCgbCuAskck0diPZowQ3P5Rijx/QXXa
         0rydO1CrPmrMMLpFEgRprHPDuaQq9ca1Esz//3QradGU4rJza6NCxKAlk+ZY4CbcxM4u
         BGhQ==
X-Gm-Message-State: AOAM5338V9ibcKyZBqcK9gsjtgEoUgSFINnTZICpX3HPzIvnJkVWIfxD
        hUy6eJF2yYH/rmT+VRw5jAh4Fg==
X-Google-Smtp-Source: ABdhPJxi5KQrydwI8y97PuNn+ZsXxv/4PCd0/jR6YnFfztko70nCMswOPSAAnlzmeSO1zoISQydwtQ==
X-Received: by 2002:a63:68c4:0:b0:3c6:c9a6:e316 with SMTP id d187-20020a6368c4000000b003c6c9a6e316mr13828351pgc.399.1652339139501;
        Thu, 12 May 2022 00:05:39 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902ceca00b0015e8d4eb285sm3251896plg.207.2022.05.12.00.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:05:38 -0700 (PDT)
Date:   Thu, 12 May 2022 12:35:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] cpufreq: Reorganize checks in cpufreq_offline()
Message-ID: <20220512070536.6mbzhllvr6vme5g7@vireshk-i7>
References: <5585781.DvuYhMxLoT@kreacher>
 <4756874.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4756874.31r3eYUQgx@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-05-22, 17:48, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that cpufreq_offline() only needs to check policy_is_inactive()
> once and rearrange the code in there to make that happen.
> 
> No expected functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
