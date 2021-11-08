Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7A64478F2
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 04:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbhKHDkX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Nov 2021 22:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhKHDkX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Nov 2021 22:40:23 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B2AC061570
        for <linux-pm@vger.kernel.org>; Sun,  7 Nov 2021 19:37:39 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g18so9918160pfk.5
        for <linux-pm@vger.kernel.org>; Sun, 07 Nov 2021 19:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T+K4kQ4gep707bJTE1vjo26fF51QTEGx+nfAyfvwMlc=;
        b=zWf561erl6y1G7Ez+gOW5CiI59BdiDbRH1MG7k3u4UvT5IYmTmRuYSAYShV9/tfgRe
         +218U87VMGBrO1dmHBrB4SayQZ108tiwoxcJXRq9e4xT1vfF83dRAmHgUSYsWiEGKhsU
         8CTXW2gQuStgQBtx2V6fW0OmljJ1+siFL21s7DNuVT6ynS4TLEFlQf1lVSyc4D8UlWj+
         qzCAGMjTJUjb43Mt+jNIGFfE759dT1HYLF7JngIxok0B5jNgmb6yvV0QbQfqOezLyUAH
         kwoDQZnX3qwLNtXCmiX6l5UjOB1bwsFCNb27tJRAdxs7vGHXXTGKJOmeU7ltg5n60QIU
         MSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T+K4kQ4gep707bJTE1vjo26fF51QTEGx+nfAyfvwMlc=;
        b=7+1g95GK/Tu/1o40K6BhXXo7MzWX99yCPru8SKoerWjyewra3lTCP3PFZ8mj/AIVup
         j7zT05Ub51CzJjDbinNYbX+EMRdEs6xRNEo9xnB2/YLlRxIgg6gX+ogoU/I2JI9RAujv
         TCLI7pzzMcFzBJxTLiZbxyoM1oSWGHgbPvSK5ZxoxUvszZQ74deKv3ERTzP9jwu4WNeC
         K+HzvKGW8NacbJk2RC4DvQDCpT9e/zTaKyXa7wIduN9McOO8wSS1F6DIZJNqGZUSkcw6
         iJLK4Exx591xMu3hp+wcXBw66LlF2t0pq6p+rFBuN94hyIsOSCymPCWJ/0qTEMOklJ6R
         Jpxg==
X-Gm-Message-State: AOAM530KiVAtQz1xhDalCrBBv5XEkZJLAsdmxM2q3IMZzw6zqwUBJZrI
        axnU2f+SRaJa0ckT6L+pnYR+Cra8bZmMkQ==
X-Google-Smtp-Source: ABdhPJw9x2AdLQH4Kv5b/lF7IhxiOegrA3izNXl0YrBVw+/UnmUSFnvFzN9jFWyTBmO1xlCcdyzUWg==
X-Received: by 2002:a63:618d:: with SMTP id v135mr40577435pgb.241.1636342659345;
        Sun, 07 Nov 2021 19:37:39 -0800 (PST)
Received: from localhost ([223.226.77.81])
        by smtp.gmail.com with ESMTPSA id i185sm5216511pfg.80.2021.11.07.19.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 19:37:38 -0800 (PST)
Date:   Mon, 8 Nov 2021 09:07:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: Re: OPP updates for 5.16-rc1
Message-ID: <20211108033736.dxybjouoepofgdnl@vireshk-i7>
References: <20211102035847.52yvfw4ywbxrtqhf@vireshk-i7>
 <CAJZ5v0inzRNAU3SAFahmobEkudHgzRETWHPZED4jgcBFN9S5Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0inzRNAU3SAFahmobEkudHgzRETWHPZED4jgcBFN9S5Xg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-11-21, 17:55, Rafael J. Wysocki wrote:
> On Tue, Nov 2, 2021 at 4:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Hi Rafael,
> >
> > This pull request contains following changes:
> >
> > - Fix return value of _opp_add_static_v2() helper (YueHaibing).
> >
> > - Fix required-opp handle count (Pavankumar Kondeti).
> >
> > - Resource managed OPP helpers, type update to
> >   dev_pm_opp_attach_genpd() and update to their devfreq users, and
> >   minor DT binding change (Dmitry Osipenko).
> >
> > Thanks.
> >
> > --
> > Viresh
> >
> > -------------------------8<-------------------------
> >
> > The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> >
> >   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
> >
> > for you to fetch changes up to 7ca81b690e598fdf16a6c738a466247ef9be7ac7:
> >
> >   dt-bindings: opp: Allow multi-worded OPP entry name (2021-11-02 09:25:05 +0530)
> 
> Pulled, thanks!

I don't see this in pm/linux-next.

-- 
viresh
