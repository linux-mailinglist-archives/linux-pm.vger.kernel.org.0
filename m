Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990042FAF28
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 04:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbhASDhB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 22:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbhASDg4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 22:36:56 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A140EC061574
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 19:36:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id x20so5846437pjh.3
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 19:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O8ACAv1aWfbK9Rs7Y+aAuUGuGcosOM4J9jZOjP5M3U8=;
        b=om6gGSHHrxaXSPUAL/3eO3VZyhvnGl1a6yD1JC13co3Z9hzMI6573z4S94kFxmvUFr
         QUGWYkr3i1z5TpSQHUK7jAjqBEo1iT+HkBkwg2hYasb8t/1W0xNvCnlh/3MxEEke91qE
         jzzOYahqdpxOJS9OcEY4+WzpD95SpQidOA2uhjC4fcCE+H+ruVnMuk4WGr7x+OcyCPKE
         047ielDqgs5rq8bDu986mE6Kj9jTJ1zBjE6fm7q+C9mKnaMp2tNu7fup4+T/n3bcGtrG
         lie2JP3e8V/GGE/J899LdIRxmhFc9uUZJBYky/7y1oRuj8nDy1SFGMhwRjHhYnXt/36m
         YlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O8ACAv1aWfbK9Rs7Y+aAuUGuGcosOM4J9jZOjP5M3U8=;
        b=XWxImIDst3fshKY88QkLPqRbTLps5NmKEb3c6WiNHSJrbOOAteyVEnqScfKCW1kESn
         MSZ0g9CpxqtLIwInFTY/vWXa59NeGHl4ctwQQv2mHiAyNPjNI+z2zfaoKelj/CgJ3/pV
         rgq//+RSP3GObTckkC8JjSwNaGMtzQYKliiT0aeRHWoXS2nBSWdeligVdDTl/owNhfY8
         7T3UXTnyc95unSjYoVTK9lCaQ6MQoPUg50Zlc+c+WMzAITidvIWyFquRJB9/4hTzNJkS
         QFVuERG863vKcJtZkhjnN0PBA2G7Q8dTzAJEuxMEhmbEIV4nWrnR4NGFQaMxsorjcc6H
         IWEg==
X-Gm-Message-State: AOAM532GdDdrMLAMd8RWFve3egveSYNIUvBcDI7vGMKV4Ow92mGml3NA
        quJnXVp+gn/4CHPUu52f2FhDyQ==
X-Google-Smtp-Source: ABdhPJxcgsegIDhpobB7OQjtVQotwMPh4m6cTsQpTfNlqDP+A7OvQpYCGDGnG6oWDQOnzGH8JHe/jQ==
X-Received: by 2002:a17:902:9f86:b029:de:2919:a6ac with SMTP id g6-20020a1709029f86b02900de2919a6acmr2392297plq.41.1611027376177;
        Mon, 18 Jan 2021 19:36:16 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 123sm7140597pfg.139.2021.01.18.19.36.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 19:36:15 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:06:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: add missing devm_release_mem_region()
 call
Message-ID: <20210119033612.2inqiq77dioqisq6@vireshk-i7>
References: <20210112095236.20515-1-shawn.guo@linaro.org>
 <X/210llTiuNt3haG@builder.lan>
 <20210113043143.y45mmnw3e2kjkxnl@vireshk-i7>
 <X/5+GbueKg66DoEE@builder.lan>
 <20210113050651.q2txref3d6bifrf3@vireshk-i7>
 <20210118121710.GD2479@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118121710.GD2479@dragon>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-01-21, 20:17, Shawn Guo wrote:
> On Wed, Jan 13, 2021 at 10:36:51AM +0530, Viresh Kumar wrote:
> > On 12-01-21, 22:59, Bjorn Andersson wrote:
> > > But that said, why are the ioremap done at init and not at probe time?
> > 
> > These are some hardware registers per cpufreq policy I believe, and so
> > they did it from policy init instead.
> > 
> > And yes I agree that we shouldn't use devm_ from init() for the cases
> > where we need to put the resources in exit() as well. But things like
> > devm_kzalloc() are fine there.
> 
> I'm not sure why devm_kzalloc() is fine there.  IIUIC, the memory
> allocated by devm_kzalloc() in init() is not freed up from exit(), as
> &pdev->dev is alive across init/exit cycles and will not trigger devres
> auto free-up.

Yes, but reallocating it again if ->init() get called again isn't a bug and will
only block a part of memory for sometime, i.e. until the time driver isn't
removed.

Though it is better I think to get rid of it as well.

-- 
viresh
