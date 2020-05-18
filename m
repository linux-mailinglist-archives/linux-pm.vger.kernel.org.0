Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F8D1D778D
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 13:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgERLnw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 07:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgERLnw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 07:43:52 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAABC061A0C
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 04:43:52 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f4so4672723pgi.10
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 04:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/+h/QADilkLXAAqEbNjayFiUXOxdF0Ou6pFZQNdQMpw=;
        b=BohCfE7LN+qojReJbiEHPS1E31OWhUKd+62lCnoHK6LR3FKHuXwhhH1ROmi9SxW/F8
         nxwNqtHH3/Ubg5gzXQxy88TH+LwH3oK+aZ2Ur/lNR/H1lgapWWSly0Nh7p/BUunwkL6j
         YMG7OJ0jyMtkc5+/eT/1nL2RAZZpstd34xKl2PfksIMK8IqcEdzzsiIGH+zAvYo8Snq7
         HAc7I8yDOb11/+Bo8IJLUxNK0yuV8CeShO6JNFSw0bxihWcMqDE8I6yrG5fYvmfM/Jx0
         +JU/m7SQipisQniBueJ1qScnkeelCzIONkSZRi4o3o3VE7D7RjiYj8hUWizJCr0NXhwG
         V8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/+h/QADilkLXAAqEbNjayFiUXOxdF0Ou6pFZQNdQMpw=;
        b=BdlkLfEC7v9zuxIDXxZaYi61vFjEnCjOT8u/Y5S/UQ5SNeScilB3bjJHPr2QejqaT2
         URPtnkKzVGsUtCmcyfZssLefEJGgCTZ0BZ07XCV/4B81gCuvFLyc9B66jd5ohUw5TAsO
         w/xBgGgsELju2ONrsM4RV5xVDQ6YDSpjdqlJH6Pa1uAfixPvXmrrwiWxPqI6ql0fgcAJ
         +NY7LZg1aU7tYx9bqoPMaB9uwYRG7tAWfJYxDl7VP0xu2Gvl2xWp3a6F7KW1KSXieXJB
         xJ4UaXUmrBReVYnGkIZ26pWS+10fxgDXFsU2iFjZxEcMdBSb4HygCTexDwK+Y7oQrteL
         gA5A==
X-Gm-Message-State: AOAM531uILU/ZPu0QOP0kxoSoMBL3UHlvjfsx/bvaKSnQUxE+RUrpGnL
        6Pwf1B2FWjN51+l+KQhC505NqA==
X-Google-Smtp-Source: ABdhPJz+VDiR86iaZub4WRwHtt7bWEIR+rFXakE5zDFB8/kSJmgfCgLz0WxmmsOZoAKHxpTxdzPIaw==
X-Received: by 2002:a63:c04a:: with SMTP id z10mr14307442pgi.430.1589802231701;
        Mon, 18 May 2020 04:43:51 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id lj12sm8539173pjb.21.2020.05.18.04.43.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 04:43:50 -0700 (PDT)
Date:   Mon, 18 May 2020 17:13:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     rjw@rjwysocki.net, Souvik.Chakravarty@arm.com,
        Thanu.Rangarajan@arm.com, Sudeep.Holla@arm.com,
        guohanjun@huawei.com, john.garry@huawei.com,
        jonathan.cameron@huawei.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] cpufreq: handle the return value of
 '.set_boost()' properly
Message-ID: <20200518114348.z55kpbhgbfxenrhm@vireshk-i7>
References: <1589785808-12138-1-git-send-email-wangxiongfeng2@huawei.com>
 <1589785808-12138-2-git-send-email-wangxiongfeng2@huawei.com>
 <20200518074619.yznopcgqmoq6ds7t@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518074619.yznopcgqmoq6ds7t@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-05-20, 13:16, Viresh Kumar wrote:
> On 18-05-20, 15:10, Xiongfeng Wang wrote:
> > 'freq_qos_update_request()' called by 'cpufreq_boost_set_sw()' reutrns 1
> > when the effective constraint value of frequency QoS has changed. It's
> > not an error code. So handle the return value 1 of '.set_boost()' in
> > 'cpufreq_boost_trigger_state()' properly.
> > 
> > Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 4adac3a..bb6746e 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2540,7 +2540,10 @@ int cpufreq_boost_trigger_state(int state)
> >  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> >  
> >  	ret = cpufreq_driver->set_boost(state);
> > -	if (ret) {
> > +	if (ret == 1) {
> > +		pr_debug("The effective constraint value of frequency QoS has changed.\n");
> > +		return 0;
> > +	} else if (ret) {
> 
> Rafael, IMO it is better to pick patch from Sergey for this as this is
> implementation detail.
> 
> >  		write_lock_irqsave(&cpufreq_driver_lock, flags);
> >  		cpufreq_driver->boost_enabled = !state;
> >  		write_unlock_irqrestore(&cpufreq_driver_lock, flags);

This is already fixed in the PM tree with a different patch Xiongfeng.

-- 
viresh
