Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391CA2FBA24
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 15:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbhASOob (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 09:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730796AbhASJ4H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 04:56:07 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367FBC061575
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 01:55:15 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g3so10213206plp.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 01:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xAqXt2hrMnUwGHY4K/vXVEtDT5xO+PqICWyHvp6jNI4=;
        b=yLyMj40c8dpxG49080WIa+e1h0pdwJbbPb6WrmW/NlllBflJkMeezxlqx/j4D5Eu+f
         UVjn8MO4sm0KngRQxbChnQghGE8x7cuFzzgtIWVDa4mwXm+TnRc3LgZNKRDKwjDIWqk/
         xd1U0afI3Wfh4S7IEVlwnL6i/FE6p/oj8XtHRhcJDpvC45IRYws7FU6ZBKyBFqPyed4U
         MoieLszFLBCu2JWPzofsc8lwyRT7UFSDBPMDaoTmg4iGU+VoBu3jjofvFwH1C2en01Mf
         UePfcVcZW4+RGC2J74FvKjBsbvFQ0mWIWrfMWdyEpT6tW6pjxGN2/N1X2RjaVTPIu+SA
         92aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xAqXt2hrMnUwGHY4K/vXVEtDT5xO+PqICWyHvp6jNI4=;
        b=GSlX9a4jdOzZa+93aieHSa0KWAIY1yTlvRDlf6hDNSrgqA/P66unWaBZsk4BV+NiTa
         7/8yfWoyW7AEyJjlT4HeUgFnI0CcKzeGLFKugX3JYgVgue+JF4tAeujFPoldtOso1RKl
         ECBaNjlWBa2H2Y6GnTjnsj1k3GjcBUNFq7k8dnE0YfegxB2XJRWFW1f2g6uKK/ZLDA4t
         i4dzdFd+RUeUGIX877KgzdTIICE5LFpj8YlPkCi31vE0PZZDiYrjuodszrpeMbR9AsMJ
         iFCXaO1DOaU2EVFCaxKD6BksnC/0bPkUqwRuZvpMc2/rXnSh2rnw4t2Mmi1AWyLM5O0e
         UX7A==
X-Gm-Message-State: AOAM531AiUhSG70+eSphY58FJYMZcVvfh4I766ujTr3ohcQhy7nOAftU
        8y3KQOJL1u1baDzzyIiC8ROg+A==
X-Google-Smtp-Source: ABdhPJzzA9SrNQFl+F6LdDy36vNrtNXWt6cwOvgIfknJpkBo8QX65rmWDW606+FJKruuIfh0mqyekA==
X-Received: by 2002:a17:90a:fa84:: with SMTP id cu4mr4536724pjb.0.1611050114175;
        Tue, 19 Jan 2021 01:55:14 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id q9sm18869325pgb.82.2021.01.19.01.55.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 01:55:13 -0800 (PST)
Date:   Tue, 19 Jan 2021 15:25:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] PM: domains: Make set_performance_state()
 callback optional
Message-ID: <20210119095511.s3xntwwq4g65dcoa@vireshk-i7>
References: <20210118011330.4145-1-digetx@gmail.com>
 <20210118011330.4145-2-digetx@gmail.com>
 <20210118072855.anncyl6z3e5uznvd@vireshk-i7>
 <CAPDyKFquCGUSTvcCpmN0vm1eGEz9B_hYSNm7wojhgwuXT=jkEQ@mail.gmail.com>
 <20210118110506.linvsoca7jbl42iq@vireshk-i7>
 <CAPDyKFr7SD_A9sKD2+90XfjP09T+PCLE=8qvn=M-yPEPXvBhsg@mail.gmail.com>
 <20210119034428.qgjjlvti6sirsnzy@vireshk-i7>
 <CAPDyKFp3OpV5qgfB_EGf=fyCR5b0b0zntbsXAJJsWbJX09gF6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFp3OpV5qgfB_EGf=fyCR5b0b0zntbsXAJJsWbJX09gF6A@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-01-21, 10:52, Ulf Hansson wrote:
> That would work if the topology is built from top to bottom, but I
> don't think we can rely on that.
> 
> For example, when a domain A is added as a child to domain B, domain B
> doesn't have a parent yet (and the "can-handle-pstates" don't get set
> for neither domain A or domain B). Next, domain B is added as child
> domain to domain C. Domain C has the "can-handle-pstates" set, which
> means domain B gets the "can-handle-pstates" set as well. This means
> domain A, will not have "can-handle-pstates" set, while it probably
> should have.

Okay, I missed that part.

> >
> > > So, maybe we should simply just stick to the existing code, forcing
> > > the parent to have a ->set_performance() callback assigned if
> > > propagation should continue?
> >
> > I think it would be better to fix the issue even if we aren't fully optimized
> > and making the change to make sure we keep propagating is rather important.
> 
> Alright, let's continue with Dmitry's patches and discuss this further
> when v4 is out, as he seems to have it almost ready.

Right.

-- 
viresh
