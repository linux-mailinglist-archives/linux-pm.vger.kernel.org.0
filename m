Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B16B245BCC
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 07:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgHQFFo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 01:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgHQFFo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 01:05:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F230C061388
        for <linux-pm@vger.kernel.org>; Sun, 16 Aug 2020 22:05:44 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so7542358pgl.11
        for <linux-pm@vger.kernel.org>; Sun, 16 Aug 2020 22:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g8h0LxTHh1VYQ18oyvTbKZV+T1OgJq5ncEakFn9bhww=;
        b=Lx8D5Aof22eg7lNb06Y7snkOOKoZO1wUAMTd3RBpyFBJcl6QsdoaUPCOFEpDJtCOsx
         fE6QxUd1usxfTHmq43Te/t0kJfvsWz/zOD59QVZqEuaPcLbmyAdr/Q7lzDhvwy4oQQLC
         Rs37LGymucVaYTaqBUiVyZ+/GkZmbCss6X5d4aDKBbGpmEm/NEpXiMRQ8QqQWLdeAad6
         YQ0HsF4HDCVPusFjI/9LNgo6SrGMD8+a4yGLTrvpUhdMBkm8sjXclsaktxw1guFtYlfF
         qJhIBjSwUK940XEZ93k0BFsLiHUbh3i2kf/OVYxkBAIO9yd3CG7R9yzjFMwRF6ymQojn
         3O1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g8h0LxTHh1VYQ18oyvTbKZV+T1OgJq5ncEakFn9bhww=;
        b=BRWXXGr25byofNATZb7KwOgTteE/24OnOVXfQ7frORqUNRrYUqqXjuhmB5NqAo+q5f
         RpBIxziQx73t/pN3lmrS4zUK31jsZTuS8DJ4CXizXkaq82cUwYIM/ULF00tHbfBmcbJx
         /nek9tx4k8wvytuZsBXTu9+xIDbnKzR3MpHIiAJV/9aJmxgnhF/s5FjPEtAsAfaTpH8G
         thZA7svfMwtApsHCALubHkt+dt8AJsdYrMoglk0PbnsNg0xvwkPKHFpr12nebWw/DHzt
         MDX53DGcSrkiBip6OntelZozVRb6VSb9y50JeqNZAMXqd4Ddn4FiNNSuMSvG0qWH9qEx
         ILjg==
X-Gm-Message-State: AOAM533pIbbIndA2yRIM2J9jHFThRPfa9WOZRYAOTYOfAGrB9lGsVRpv
        tMTexDyY775bDpmhA+zKlF3l1g==
X-Google-Smtp-Source: ABdhPJwd0VaaPyl+i/kmEZW2gPmdcCPDQtV6AdhKtsMs0/M0yIRHIAxpqTiDpLWH3FImxxt4fG2Qdw==
X-Received: by 2002:a63:1d23:: with SMTP id d35mr8527870pgd.291.1597640742156;
        Sun, 16 Aug 2020 22:05:42 -0700 (PDT)
Received: from localhost ([182.77.16.215])
        by smtp.gmail.com with ESMTPSA id g4sm16273713pjh.32.2020.08.16.22.05.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Aug 2020 22:05:41 -0700 (PDT)
Date:   Mon, 17 Aug 2020 10:35:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, mka@chromium.org,
        sibis@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] opp: Track device's resources configuration status
Message-ID: <20200817050434.cisjgwo4lxl652fb@vireshk-mac-ubuntu>
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
 <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
 <453b3897507838e95359d891ef967165bd167a4e.1597292833.git.viresh.kumar@linaro.org>
 <159747859192.33733.13232258434530046392@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159747859192.33733.13232258434530046392@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-08-20, 01:03, Stephen Boyd wrote:
> Quoting Viresh Kumar (2020-08-12 21:28:59)
> > The OPP core needs to track if the resources of devices are enabled or
> > configured or not, as it disables the resources when target_freq is set
> > to 0.
> > 
> > Handle that with a separate variable to make it easy to maintain.
> > 
> > Also note that we will unconditionally call clk_set_rate() in the case
> > where the resources are getting enabled again. This shouldn't have any
> > side effects anyway.
> 
> Any reason to want to do that?

To avoid more flags, code paths and simplicity of the code. And this
should normally happen in a corner case as well, like calling
set-rate(0) from suspend and then reinitializing things again in
resume.

> We'll have to grab the prepare lock in
> the clk framework to figure out that there's nothing to do sometimes. If
> anything, a comment may help to indicate that we call clk_set_rate()
> again, but don't expect it to matter much.

Ok.

-- 
viresh
