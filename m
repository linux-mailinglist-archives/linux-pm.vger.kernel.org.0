Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6852F20A05A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405268AbgFYNxN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 09:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404803AbgFYNxM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 09:53:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF344C08C5C1
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 06:53:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g18so5965148wrm.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hYoZcrzGFRdaStmvr5BOkIKNL3anG7XJu45/FDtHx8o=;
        b=GAtQAwvuy/EiFCc5qUSZ+0tL5aqXdZ1mWw3DwSz5jvtGEPn5F/VAcL3C6tPmRNvSYu
         CeiI6iJ38VhkJYFbnoVSLw4+yTUmLFsbZNjQvjFwOXrDmiFi2HDtGhOPt65M6ULh2zJK
         2akP2Apxt/LB1ghunywo6Z4UI/0xy1ZwQgt3VR1bisWoV0TyGRA5yZNgf2x0bNHCrtz5
         bc0YHKwxA5W7fC0pIAQsYDuwzSIx23CYOc2dyrt+lM1rJ7GcCm0J570bVi9CP9e5xi/T
         O6LA2IDjmiD4AloydaIeRSznTgPdiFntVIMENhdmj6/ZCRD74V8mfHsZ6RSjdCoyGSlM
         M2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hYoZcrzGFRdaStmvr5BOkIKNL3anG7XJu45/FDtHx8o=;
        b=a1yl5DOhVhw9OwcCBgZ6Bhe+wP2Z4G/QpKATAh6xAYmlaAM+Q4ArNcfiNquuhQi+ui
         zoZoqBlOiQlnvqi522dyQ71jJAznhd9T8LmAtDDtenot5DHxgyr+04jmP/BqQbWb0fxi
         PKTYtp1p0mcsSZgmhINvvZy39RBFaaBM1d8gKp+/3HulVhJa8GtqDvl0lu6nBn2sqJZF
         hxFRVPZ2A0Nj/DlhqK7mivDKt+SlOKUb5UupsyA49JYurlV7yTI1CGiPz1i2rlzcSxn0
         ytNuYDDpjxLALxVycSNKVFVWUttxZbM5N1trzFnLGH9SQrZIAcxPxGx0HnltZPaUfdN9
         dlpw==
X-Gm-Message-State: AOAM532u4okC/iGoC8AvlUlaxHx3MDt2mQyf44uPUnfV3+hmzHRBzggl
        3sJ55fE9Pc3ftx5DYxd+s71zFhrJHclHEQ==
X-Google-Smtp-Source: ABdhPJxA1B3Qv8sXzELwr+4by0M3c4VykokWKkxoP4jiOzZpxvtER8sB2Q8z6vk+MxGhiFhIArT4HQ==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr37790780wru.27.1593093189448;
        Thu, 25 Jun 2020 06:53:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id u20sm11320118wmm.15.2020.06.25.06.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 06:53:08 -0700 (PDT)
Date:   Thu, 25 Jun 2020 14:53:05 +0100
From:   Quentin Perret <qperret@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Fix locking issues with governors
Message-ID: <20200625135305.GB242742@google.com>
References: <49c7d64460cdb39b006991e5251260eb0eea9f2a.1593082448.git.viresh.kumar@linaro.org>
 <20200625111452.GA200288@google.com>
 <CAJZ5v0gdJ2gtxjpzHCZ6C0LCZ0SYeR1LZcb=CwjrS2aa86fmdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gdJ2gtxjpzHCZ6C0LCZ0SYeR1LZcb=CwjrS2aa86fmdA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 25 Jun 2020 at 15:32:43 (+0200), Rafael J. Wysocki wrote:
> On Thu, Jun 25, 2020 at 1:14 PM Quentin Perret <qperret@google.com> wrote:
> >
> > Hey Viresh
> >
> > On Thursday 25 Jun 2020 at 16:24:16 (+0530), Viresh Kumar wrote:
> > > The locking around governors handling isn't adequate currently. The list
> > > of governors should never be traversed without locking in place. Also we
> > > must make sure the governor isn't removed while it is still referenced
> > > by code.
> >
> > Thanks for having a look at this!
> >
> > This solves the issue for the reference to policy->last_governor, but
> > given that your patch is based on top of
> > 20200623142138.209513-3-qperret@google.com, 'default_governor' needs a
> > similar treatment I think.
> 
> So I would prefer to rebase the $subject patch from Viresh on top of
> the current mainline, apply it first and rebase the "default governor"
> series on top of it - and include the changes needed for the default
> governor handling in there.

Right, and Viresh's patch might be -stable material too? In any case,
making it standalone makes a lot of sense.

Thanks,
Quentin
