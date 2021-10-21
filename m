Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FAA4359BB
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 06:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhJUEMW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 00:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhJUEMW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 00:12:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27996C06161C
        for <linux-pm@vger.kernel.org>; Wed, 20 Oct 2021 21:10:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f21so17603228plb.3
        for <linux-pm@vger.kernel.org>; Wed, 20 Oct 2021 21:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yLK4NxbVqDLH3nRLVYQccxDS/5AO+FQ5rIKLjjCYFX0=;
        b=jfZWIuznt21Lek3cIqItyOPu5IOr0TBTScrFk1fyO29je7a+YB158rIbSrQ3p8IUCR
         RPWttendbmEAlB0am37fji3QCDgtRuJIHPmCsYVZYI4qj2o7Nj+odrQRAWFh5S9D5ii7
         io+MBLQt3oOz+yM3qKHtYi+SxX3SV5uF/2m1kwjMwvmyKXqp+UaGQ77LsBg6uvcj5c6g
         MQckYoZmlMyjYNgrIadAr+juQbuEVrnJi27bhJ4l0Ct59mtf7aEL161ozflqPSN3Rd1E
         RvpyIO+BFhxbFP1ydxnYIPZq9ZEp4dqm1K+UQS78qOvy9Rd1yayucIg5nZ3vGO7Tvt/B
         kCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yLK4NxbVqDLH3nRLVYQccxDS/5AO+FQ5rIKLjjCYFX0=;
        b=C2kaXCjEvmTRjJV+48DdpayEuZylwt0rpq8ZcnPmrjzDbT4ZO00+2Fr3Xt5SXZcVka
         Ogxo+ENeEYDHmmVBvk+y6dmkKujabFwo3Y3gAzaWLfoylG1CEK9PX/9T9s8ZwL41znO4
         EF1lI8j3rmD85jYIWqc3mBW5LuHnAu7keSHrdU/7gcwaxReOLzXtAC2OQdcpcBge2qkN
         EmWj5YrGoXeZ8qaiTl6DTN2a69nO9OsEZ+sIZAlwIb92JhNYWeGzrznMwQZ441JCLeb4
         iUbsIaXciRdJTYFbEexoiz/VZ6YHWgFRlE4knPCJPCO2mseW5d5ie6ZhmNVSvElZJ63t
         UnCQ==
X-Gm-Message-State: AOAM531NWfHRNi7syDZHwgpoNDoAHrY+mpQYIY/Hwi3oLh8Qe1crm9fh
        Wzo7fX25/uvWWtmS9kqnYjLxdA==
X-Google-Smtp-Source: ABdhPJy+Bk9B2LacGLYy31NgFsLeXyeX3jUeC89nXJZGJcjbQCASaWxgmUhmeCJUSwOdq5oy4qD6ZA==
X-Received: by 2002:a17:902:6808:b0:13e:a85b:52bd with SMTP id h8-20020a170902680800b0013ea85b52bdmr2940449plk.76.1634789406546;
        Wed, 20 Oct 2021 21:10:06 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id p25sm4986407pfh.86.2021.10.20.21.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 21:10:05 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:40:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Fix typo in cpufreq.h
Message-ID: <20211021041001.nbtra55ziwi2d7xb@vireshk-i7>
References: <11860065.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11860065.O9o76ZdvQC@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-10-21, 21:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> s/internale/internal/
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/cpufreq.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -398,7 +398,7 @@ struct cpufreq_driver {
>  /* flags */
>  
>  /*
> - * Set by drivers that need to update internale upper and lower boundaries along
> + * Set by drivers that need to update internal upper and lower boundaries along
>   * with the target frequency and so the core and governors should also invoke
>   * the diver if the target frequency does not change, but the policy min or max
>   * may have changed.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
