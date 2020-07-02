Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BA8211A84
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 05:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGBDF4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 23:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGBDFz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 23:05:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5028CC08C5DB
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 20:05:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f2so10703484plr.8
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 20:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LSIXeJkTyhS8zDoxVph+aH1Bdmz06pqtIU5eHol2+kg=;
        b=IHna+nXuiFtXsW8Y44jarGOecmrNRjmRg+BPWhVHX8oo0+pm750A347UxP8cdyRZtz
         1rpywCjS09JJX3W5xYBHW4fN6qh+vM7hi/H2OD6gpAR1d3u9DiA5Pm47zTSAAtfjjdt+
         DZn8k+LOezD7Jt0KucWr934HnBmU0a1UWPHWGTBh8BAcZHGguAvIeqc/nh3qnVhehZlm
         GWaWs1LN+68mh6kQISH/hddLDYkvv5FgdSG3ICOb2papaV+z/hAE8QEkPQaFCdRM7+Kx
         9c25ktltyB+cMJEEt0dgNCB6qWPzOBd9cjrq/NU7P6fCRV5baY33f4wuYawgduP7EGxd
         XeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LSIXeJkTyhS8zDoxVph+aH1Bdmz06pqtIU5eHol2+kg=;
        b=bOsKWNtGAMwS3UEjd4rFZokRD83Qprw1wrwGiG3zRGyJFUS/OY6azjMAJdBUQWBAcw
         qKwdm2frBFmSMFLfMbmraLd38FdSGjyup5IF1ZcUacvvR4pkcYdK1I/ouE0I664meCSc
         +Fra/rhwb+o5AJrnPCVU+NquZnCYBL37sDzzEYkXfu/ccwcak3CmalEE+rHh6WiqTgbR
         q8/rZkUAmLSaW3phXUBJdTRxU3y3u4pdAJxHrcKkL/6KtuWbAOHhhJSJre9g+s724ShD
         dLBU8/DvZp++onq+7Pc0EEWQYiOxhpIqbmU5S8EyN9AVTxaqlSWGxTCh2DFN6N3h+EI3
         BGDg==
X-Gm-Message-State: AOAM532pS5WEWBGaM0iup0BHBlKxsuk/Zvg+7GXT68D6jxLVR2QCysn1
        tSdVzxpgEtmR1jCGYShavdAqqA==
X-Google-Smtp-Source: ABdhPJxvwixRnu5/bd9/OEJGu9MtVDUrqOpsYEcjxi3jhAkd3T2UijJV0Xq35KWKIh1AqiCM6n9Qlw==
X-Received: by 2002:a17:902:a987:: with SMTP id bh7mr12452608plb.197.1593659154871;
        Wed, 01 Jul 2020 20:05:54 -0700 (PDT)
Received: from localhost ([223.235.247.110])
        by smtp.gmail.com with ESMTPSA id n9sm2804781pjo.53.2020.07.01.20.05.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 20:05:54 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:35:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, sudeep.holla@arm.com,
        will@kernel.org, linux@armlinux.org.uk, valentin.schneider@arm.com,
        mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH 4/8] cpufreq,vexpress-spc: fix Frequency Invariance (FI)
 for bL switching
Message-ID: <20200702030551.p4cevaahgfvpum4o@vireshk-i7>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-5-ionela.voinescu@arm.com>
 <20200701095414.2wjcnyhndgcedk2q@vireshk-i7>
 <20200701140735.GB32736@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701140735.GB32736@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-07-20, 15:07, Ionela Voinescu wrote:
> On Wednesday 01 Jul 2020 at 16:16:19 (+0530), Viresh Kumar wrote:
> > Is there anyone who cares for this driver and EAS ? I will just skip doing the
> > FIE thing here and mark it skipped.
> 
> That is a good question. The vexpress driver is still used for TC2, but
> I don't know of any users of this bL switcher functionality that's part
> of the driver. I think there were a few people wondering recently if
> it's still used [1].

Even if it is used by some, there is no need, I believe, to enable
freq-invariance for it, which wasn't enabled until now.

And considering that we are going to enable the flag only for the
interested parties now, as from the discussion on 1/8, this shouldn't
be required.

-- 
viresh
