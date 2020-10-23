Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3945C296D18
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 12:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462242AbgJWK4B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 06:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462228AbgJWK4B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 06:56:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F65C0613CE
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 03:56:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b26so892835pff.3
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2020 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=crEDGhyBUhLs82hOA5p2atD6qb7HgnevPTexL8NWbOk=;
        b=olEIy9q0OlIir57WvFLnPOCpyWngGQim55jWmHSi/GX3YZ90xzw/ycnIqmSSutGoyq
         Hmr4BI5gMWDJhEhRdgEnc34r9Tpn1OIvQ1I02T1dXcV3vUnMjVipbSr7+pNi/T0W6dmw
         54k5ULwL+9MSXCWPnB17XQcZaPxEndCRPPd1huH+yZ+p7GM71Tg5WS6G1+nssYQ+NF/E
         E866qK2MKV/qgFyAhpkMhX9Bhskx3MukanxULihmrVk1w5HdNtWYqzmjPEMCUuTfBnSz
         3x/+uk5P6F45Z/aYNweYzr/3HGMCgEmDZT2+dWmn5me6alHh67+g6kzWCivqCTFOwGds
         9v8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=crEDGhyBUhLs82hOA5p2atD6qb7HgnevPTexL8NWbOk=;
        b=O8juyVy2Upu+fvSNZb30dD49MnfSPdhPZdsc5RSN8MjPKmi66SCupuCDEeWO8p3Qxa
         nz8aMQ4UVeRHYbcEzgaHYXahfDhsBiL+rvozzFvUBGWhxazMY+Qjct4VQ0va9IzGI7cy
         GdB8K+zmV0nQ1ADS5iozWDe/tZLeQj2Y9X34aamCIAfDuZMx5H4JhGLcjdJA9Gv79BP6
         1DuQ98LRJWO07lKKBazwTou/oikNZiP1iUD5XGTXH5nqP+qntcWHlp6boFRmha05ObPG
         MBWqMcBxKQ0o+cs3dFV4+sVfqDuvjc9X2TP6okacq54TIbyY3On85/FZZvApw2GzHt65
         2xCQ==
X-Gm-Message-State: AOAM530Un8ebVpNPzl2SbudsS2lRtLrMxD9ZV3REMtXNwYlwsC6xIKFm
        Sd29dDAo3u8xVe0JkQmbExI7kA==
X-Google-Smtp-Source: ABdhPJy6WHoVSxaaRerQHPB9kxMyOFoqDEhQyYH/nicYMqNCF8fAZMXd5FGcZKeExWuNdDCKTeELrg==
X-Received: by 2002:a17:90a:3804:: with SMTP id w4mr1891705pjb.171.1603450560869;
        Fri, 23 Oct 2020 03:56:00 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z12sm1736001pfr.197.2020.10.23.03.55.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 03:55:59 -0700 (PDT)
Date:   Fri, 23 Oct 2020 16:25:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] sched/core: Rename and move schedutil_cpu_util()
 to core.c
Message-ID: <20201023105558.uxc5umeekfqj4nhx@vireshk-i7>
References: <cover.1603448113.git.viresh.kumar@linaro.org>
 <80c66f55ac7f04b3ecd4ebf12d69d86c89480fa7.1603448113.git.viresh.kumar@linaro.org>
 <CAKfTPtBxhofb0mVz4Dc=Fqycgf8p5F3s2J4LBxNTL+uBHBU3Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBxhofb0mVz4Dc=Fqycgf8p5F3s2J4LBxNTL+uBHBU3Ww@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-20, 12:43, Vincent Guittot wrote:
> On Fri, 23 Oct 2020 at 12:20, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > There is nothing schedutil specific in schedutil_cpu_util(), move it to
> > core.c and rename it to sched_cpu_util(), so it can be used from other
> 
> I wonder if pelt.c would be a better place for this than core.c ?

Wherever you guys ask me to move it :)

-- 
viresh
