Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FB22205DE
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 09:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgGOHJn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 03:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgGOHJm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 03:09:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D997DC08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 00:09:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g67so2624981pgc.8
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3/+/JizBB9UQLJfhtqguGOljzJveaCcNdmGC7ffhA2o=;
        b=a4tMopG+oXnDuDX+F1azBv1ggm+c1KoU9xitqNX6wtNaqyMC/O7/O5g3usYzPvR8oP
         WFPScCAnrDgo7HL+weSnzF97a+oLajDLj/F3cghrcTbPdbjQbTY94cH0AtDieRUfUJ/u
         gw4ziMVx25R+rDrK6C4KaRcZwiO2wjfgp1eBBOQCCbvJbl7V5DwjXdjjgpHh6LPwSQxI
         4oA1tfpZ6Ptti9af1Z/kWo1NiHxdsYR8OJr36y4Y/GrCg56pQ/ADJCLBpdHcLEVMF1MJ
         9EUBwVU5wreWUAjTQWOl1ZbF+lMjj+cl4X8VSngSDFew0EUHnJddNp88gxbwXgLUY5Ui
         BVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3/+/JizBB9UQLJfhtqguGOljzJveaCcNdmGC7ffhA2o=;
        b=fjwkfyWAXn98l6cIguTp687Q5PuL9aI1I9FW1H+fSnWZb+bJktpo/UzuWHGQnPrynb
         tTaO3VVx5TBUH66IokfK0rUln5vY1JqV+E1XtHKcM6zj1V2+100AoTZi9CATildDSz9B
         RFBL6v5MO8GGZhKRnneR+N7goUJNXbdLCk3ELlurwGTIC7LHjlsafCTTpmvJdJpxp7ZI
         r07r+Jk38yf1RhFxdcazkuTnyUtQl59VkLS/MuVZSly4Wcus5/PySu1EiKDtvFtPzpKU
         J24SIuFNCxmLoYJks0J/SODk8EBrtuorCeXNABb+C4hDAS4qq0cUTtmQcqE4Q/qoagzY
         n71g==
X-Gm-Message-State: AOAM5300yXddCv6vfmE3n5hOOp6VSlDDP6bdkPIsJAfVA2Q9RscWtmQ1
        fqaNajTjudKzytQRRWoI95jE1Q==
X-Google-Smtp-Source: ABdhPJxHdbacRbRq1btUZ46xKsE1jmPTXxacVtnB3TaMKFvudSxtfQe5zuPohnqNN8b5slN2XxnrBg==
X-Received: by 2002:a63:7a57:: with SMTP id j23mr6790300pgn.408.1594796982392;
        Wed, 15 Jul 2020 00:09:42 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id b13sm1092458pjl.7.2020.07.15.00.09.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 00:09:41 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:39:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dominik Brodowski <linux@brodo.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Shin <jacob.shin@amd.com>
Subject: Re: [PATCH 02/13] cpufreq: cpufreq: Demote lots of function headers
 unworthy of kerneldoc status
Message-ID: <20200715070938.d2rtkvsk7n4sla3h@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-3-lee.jones@linaro.org>
 <20200715024951.zr36iuagany5ii56@vireshk-i7>
 <20200715064716.GT1398296@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715064716.GT1398296@dell>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-07-20, 07:47, Lee Jones wrote:
> On Wed, 15 Jul 2020, Viresh Kumar wrote:
> 
> > On 14-07-20, 15:50, Lee Jones wrote:
> > > -/**
> > > +/*
> > >   * cpufreq_remove_dev - remove a CPU device
> > 
> > Because cpufreq_add_dev() is part of kernel doc, we better keep it.
> > 
> > >   *
> > >   * Removes the cpufreq interface for a CPU device.
> > > @@ -2373,6 +2374,7 @@ EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);
> > >   * cpufreq_get_policy - get the current cpufreq_policy
> > >   * @policy: struct cpufreq_policy into which the current cpufreq_policy
> > >   *	is written
> > > + * @cpu: CPU to find the policy for
> > >   *
> > >   * Reads the current cpufreq policy.
> > >   */
> > > @@ -2759,7 +2761,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
> > >  }
> > >  EXPORT_SYMBOL_GPL(cpufreq_register_driver);
> > >  
> > > -/**
> > > +/*
> > >   * cpufreq_unregister_driver - unregister the current CPUFreq driver
> > 
> > And this should be there for sure.
> 
> Where is the *.rst file that references this kerneldoc entry?
> 
> Also, what do you mean by "there"?  We're not removing the function
> header.  It's still documented, it's just not kerneldoc.

Yeah, I meant from kernel-doc by "there".

Lets conclude the discussion on the other patch for what should be in
kernel-doc.

> > >   *
> > >   * Unregister the current CPUFreq driver. Only call this if you have
> > 
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog

-- 
viresh
