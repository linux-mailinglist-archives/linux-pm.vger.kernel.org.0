Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4815E321008
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 05:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhBVEjs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Feb 2021 23:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhBVEjr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2021 23:39:47 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C45C061786
        for <linux-pm@vger.kernel.org>; Sun, 21 Feb 2021 20:39:07 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id t25so9493598pga.2
        for <linux-pm@vger.kernel.org>; Sun, 21 Feb 2021 20:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rHR/hBdQwM37tuzoR2JFYoJ3S9CP5BdPWbteP4d6NZY=;
        b=KfS0O6oJgq1gLGOPbLz0ylgzLs1AC9D2WkTdESI9tVcCV29uUd4Xsxi5gZPVkGDw+E
         d2116ZMbXfldY2ExN/V7P4Q/jcV8/0Xen9facHCe4TWJHyxQYC7aAADXCeupZaXApFi2
         ordeieG7XaFPxu5XUxeW2QWGFRAzy5mbVCpe9mkuDBZrQLSGYGqKDU/ByXk3174jo29V
         7mkSf4wOGgMzaiaM8014dVI5sI/oZKup++RJRPJfzOX1gvEDaqdQrf5vcsUU74e+LIwk
         SOgLMyCyREN1wuIewkSv53PJXaVh26tvjz/UavavCSs6g9+BzECJhoJb8MbZ7LGLvOPb
         jXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rHR/hBdQwM37tuzoR2JFYoJ3S9CP5BdPWbteP4d6NZY=;
        b=S2rhHdUGDMB/NcPcxpHFXyVeU4vJ5kEbNSd6kxhmL0FEo7GuEfJVdFlSiP1/nREcvz
         i1kT0xDB8rFazA9ALNj8TLi3dPlz4Fp+D60/+i0wcKtbTEBIwFguoqFeSXd3dsiDJJNY
         VSeju6thDFie2LZFnjhU6MTIQP4ONRgx0FTKB4mjVAQO/kCcmWhoWrioBanlhwfNBIgz
         t/dRkRTEOuh7C7wOjzBKfTD2UWABShQAcs/BtEFRQIYavCoPoANLk5nrgOkSh5PDgb/0
         HYP3NigPcvxL2CnYv92RSIsL8hTqOVnd9n9BC7HKQ81oFYE60nD38vtREZMkfwOgWcAq
         BSEw==
X-Gm-Message-State: AOAM532OxbBLru0syE9p7JrI2/8UVi6+vuQw4vOliFb84XHH3Tw9rNAU
        ZQ3kgS0Ax0EUozOeqK8T2Vz8qTcL1ouoiQ==
X-Google-Smtp-Source: ABdhPJx6KlnebKx8hqFh1OSBi0TL1Knw23OfbdUQYj0FzNSxavjiHfMdteCPIY748Iq4tl7IMtEi4g==
X-Received: by 2002:a63:1a07:: with SMTP id a7mr18156961pga.167.1613968746460;
        Sun, 21 Feb 2021 20:39:06 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id t7sm16554202pgr.53.2021.02.21.20.39.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Feb 2021 20:39:05 -0800 (PST)
Date:   Mon, 22 Feb 2021 10:09:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, vireshk@kernel.org,
        cristian.marussi@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, ionela.voinescu@arm.com
Subject: Re: [PATCH v8 0/3] CPUFreq: Add support for opp-sharing cpus
Message-ID: <20210222043904.j36d6btl2v64xg6q@vireshk-i7>
References: <20210218222326.15788-1-nicola.mazzucato@arm.com>
 <20210219041944.uox45mesrabvfm72@vireshk-i7>
 <20210219191650.q7bu6ogbhh2hcmww@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219191650.q7bu6ogbhh2hcmww@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-02-21, 19:16, Sudeep Holla wrote:
> Hi Viresh,
> 
> On Fri, Feb 19, 2021 at 09:49:44AM +0530, Viresh Kumar wrote:
> > On 18-02-21, 22:23, Nicola Mazzucato wrote:
> > > Hi Viresh,
> > > 
> > > In this V8 I have addressed your comments:
> > > - correct the goto in patch 1/3
> > > - improve comment in patch 2/3 for dev_pm_opp_get_opp_count()
> > 
> > LGTM. I will apply them after the merge window is over. Thanks.
> 
> I am planning to merge the series on scmi[1] which changes scmi-cpufreq.c
> and will conflict with these changes I think. If possible either,
> 
> 1. Share a branch with these changes that I can merge or
> 2. I can take patch 1/3 and 2/3 with other scmi changes with your Ack.
> 
> I am fine either way, let me know by v5.12-rc1

I have applied 3/3, you can take first two and add my Ack.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
