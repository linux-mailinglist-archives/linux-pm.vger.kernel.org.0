Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ECB59B8C6
	for <lists+linux-pm@lfdr.de>; Mon, 22 Aug 2022 07:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiHVFjZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Aug 2022 01:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiHVFjZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2022 01:39:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C54B193E9
        for <linux-pm@vger.kernel.org>; Sun, 21 Aug 2022 22:39:24 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y141so9312627pfb.7
        for <linux-pm@vger.kernel.org>; Sun, 21 Aug 2022 22:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=fligshsn2XCImgFvItWx33xcWI/jlzXUqMfl1TLpXkY=;
        b=kyK168j0SDg4TCdKpYFY9ds/wfu26Qx5h0uxF7Tz4ODrxraYdt0fhSgf3bpQEbl6E0
         h3h/XCh2ulNEbwyXYCmyuVLXsSzWhYALJRx6+HMTcqWjqM1fHxchYiu0yH599AxLJMUQ
         QppWaGe/kbUvJYScx9HcMzvauWUxvaR7WAem63IWYGvVR8kwDGsrOx97y0Tljauq555M
         gwJTQ0cmLMSfiOBqqGVJ4lw8RSeCkJ77lN53/M+Oh0pwH42IiF6qp+4S1VJQo7uFeDeG
         kCYQdL+bktgu8nNy96bzK32Uf/YzgldL0KPfZyVyxhvixvQYNuEjAZ+hHJh62oAbAH4h
         Apog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=fligshsn2XCImgFvItWx33xcWI/jlzXUqMfl1TLpXkY=;
        b=nIUKod7Fz38z+XeFCf6qKT+1JyYjCMrs100gncArHywGdCQjtMuLJ+Vlsf3pBLigau
         um0cg+Ix3MMnrc2BfXLd6m0HJt8cY9BNePFB4TBx/sMCXmpkMewBgbHSa92NfuE6lSFV
         CMq3vjljzQ9SmR3uMEgGjI/DlSFZ7E7CxOcpRzI9hAgp5Hk3P/iDoH45Yot2JwljY9rF
         5TGCCpaSGpWZm5hD/o3kvDsNY76fH2VwtcICvu3pmyDMbhLvQQo3Vbs58nQzg5KYab4T
         X/dzRlM+yM8ydn41JHNfyeABc9t3rGLaqwCTTAdhNuBzJ1r+2PnbtxeeI/tY9HqElY0X
         jf+Q==
X-Gm-Message-State: ACgBeo1IvNSqJn8Mt3E6bbA0EqPPas03elXsR34XndRjH6HchQHpLOMW
        8mCwnvaZB7QmbAD4P1z/eI4VHO9M2oMIbg==
X-Google-Smtp-Source: AA6agR7wpVz/H/dVAHBGqp/+Y7gmgKKQiR0X+dh00ghdkKCBLp3HNqrDQ0NEFG8pbfeMWkF/ulPMEA==
X-Received: by 2002:a63:5348:0:b0:422:68d6:ea3c with SMTP id t8-20020a635348000000b0042268d6ea3cmr16046079pgl.73.1661146764058;
        Sun, 21 Aug 2022 22:39:24 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id b1-20020aa78ec1000000b0053692028ec1sm1689223pfr.34.2022.08.21.22.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 22:39:23 -0700 (PDT)
Date:   Mon, 22 Aug 2022 11:09:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chris Hyser <chris.hyser@oracle.com>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: cppc_cpufreq: prevent crash on reading
 freqdomain_cpus
Message-ID: <20220822053920.y6us5rsi6u5cdapi@vireshk-i7>
References: <1660935837-7481-1-git-send-email-chris.hyser@oracle.com>
 <1660935837-7481-2-git-send-email-chris.hyser@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660935837-7481-2-git-send-email-chris.hyser@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-08-22, 15:03, Chris Hyser wrote:
> From: chris hyser <chris.hyser@oracle.com>
> 
> While running stress-ng --sysfs on an ARM system following a cpu offline,
> we encountered the following NULL pointer dereference in the cppc_cpufreq
> scaling driver:
> 
> [ 1003.576816] Call trace:
> [ 1003.579255]  _find_next_bit+0x20/0xc8
> [ 1003.582909]  cpufreq_show_cpus+0x78/0xf4
> [ 1003.586830]  show_freqdomain_cpus+0x20/0x30 [cppc_cpufreq]
> [ 1003.592318]  show+0x4c/0x78
> [ 1003.595104]  sysfs_kf_seq_show+0x9
> 
> This is the exact issue described in commit e25303676e18 ("cpufreq:
> acpi_cpufreq: prevent crash on reading freqdomain_cpus") with the fix
> described there also solving this issue. I tracked the root cause to the
> following: a scaling driver which provides a struct freq_attr sysfs
> attributes array passed via struct cpufreq_driver during driver
> registration, has .init() and .exit() functions and does _not_ provide
> .online()/.offline() routines. cpufreq core creates the attributes, but
> does not remove them even though .exit() frees the underlying memory. The
> core functions and most drivers have corresponding NULL data pointer
> checks.
> 
> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 24eaf0e..4210353 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -876,6 +876,9 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
>  
> +	if (unlikely(!cpu_data))
> +		return -ENODEV;
> +
>  	return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
>  }
>  cpufreq_freq_attr_ro(freqdomain_cpus);

What kernel version are you testing this on ?

We merged a patch sometime back:

commit d4627a287e25 ("cpufreq: Abort show()/store() for half-initialized policies")

which I believe should have fixed this issue. I will be surprise if it
doesn't.

-- 
viresh
