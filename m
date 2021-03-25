Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0249E348852
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 06:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCYFYW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 01:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCYFYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Mar 2021 01:24:20 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1643C06174A
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 22:24:19 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f10so641239pgl.9
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 22:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tq8vn+5f9oX33yzgFPXAiKFwU/LaZuKd2l3zSLx5y3c=;
        b=KIXjvxFjejK8sYeWMw06166y0X5QSw7lKzwFeMn67YY612EN4MVLr6Z6+gXxj8OKGA
         7IAxeKRlpZmkqMbo6e35xdDp9woZyJF6E5diMjN93BhHODYupdnCGwu8Itg1zP8Nus6E
         mBW5UhbZ9CfLflLiEGeaz3Q73IdQnu7aeniPBVK3nPot3WguCz34ja4ISy/WKq8z0OGF
         jf/116O2xDIFIXavSf1cprE170+LZ+PmP+GBM6bilpc22zfje/Nh6THub5OZgguIlTt5
         HjlccTLisf804bvbQ1xKVdj5ZLO/JkXJWAY7hhynwEGyChlZUrIKUU0lsyQcRL8ONUHK
         DYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tq8vn+5f9oX33yzgFPXAiKFwU/LaZuKd2l3zSLx5y3c=;
        b=ZEBMrjooQDWq+eVAX1UVuZiaugbCsGqAHYfqM6SWNmaXUSQUql0ep8CYhGvjCdMkSH
         Rtlc7xn4tKG0f1cHrJHPUjFt5coE0wa1fC0zlszgmC9uIKq2t/LfaNOvdhBLEVPBMHwN
         iX30SOjCWkJa5e1WLw9p08Jfohd4Fe/tHSAnkYIahmjdVIIOS8ne76/dSEHE5HHKTloV
         aV09IHkFPch3FfrkiNB3yLRZ12LWhU3ykPUwvhIn/x/P/moyIOSQK1rIHzAaXkiFpYGT
         gb/aHBXxc/s4fH9bdTbSNopJTP2L/YTpJt3okXn/h+2gH27q/4XBOtm3rW+5iRZ56nOU
         9OdA==
X-Gm-Message-State: AOAM530iSOIntk3tnKd4uksVJOkn4BkhS9Odd8C7qqmvRN3gxr9B1jai
        kymHIhxQiSwZHr26khay3poKdw==
X-Google-Smtp-Source: ABdhPJzI+Y+hT9bsUv3c2JMbUKfGShAxXBkf1LSnqINorsqbTtO07Io65JzIFFNseJUXtFdC6mkaoA==
X-Received: by 2002:a17:902:6b44:b029:e6:931c:2a4d with SMTP id g4-20020a1709026b44b02900e6931c2a4dmr7561351plt.77.1616649859538;
        Wed, 24 Mar 2021 22:24:19 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id z11sm4127836pgj.22.2021.03.24.22.24.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 22:24:19 -0700 (PDT)
Date:   Thu, 25 Mar 2021 10:54:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "quanyang.wang" <quanyang.wang@windriver.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: dt: check the error returned by
 dev_pm_opp_of_cpumask_add_table
Message-ID: <20210325052417.xyctxztqbozut3ck@vireshk-i7>
References: <20210325043129.2255918-1-quanyang.wang@windriver.com>
 <20210325044541.rsncitrmkpaes4dm@vireshk-i7>
 <2da8eb92-6082-35f3-b190-c7218edb35a3@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2da8eb92-6082-35f3-b190-c7218edb35a3@windriver.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-03-21, 13:15, quanyang.wang wrote:
> Thank you for pointing it out.  Do you mean that even if
> dev_pm_opp_of_cpumask_add_table returns
> 
> an error, dev_pm_opp_get_opp_count may still return count > 0 because
> someone may call dev_pm_opp_add
> 
> to add OPP to cpu succcessfully at somewhere else?

Yes.

There are two ways we can add OPPs today:

- Statically via device tree. This is what
  dev_pm_opp_of_cpumask_add_table() tries to do.

- Dynamically via call to dev_pm_opp_add(), which I described earlier.

What failed here is the static way of adding OPPs, we still need to
check if OPPs were added dynamically.

-- 
viresh
