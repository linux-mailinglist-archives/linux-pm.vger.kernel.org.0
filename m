Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB026D3C6F
	for <lists+linux-pm@lfdr.de>; Mon,  3 Apr 2023 06:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjDCE3N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Apr 2023 00:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDCE3M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2023 00:29:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EF383F0
        for <linux-pm@vger.kernel.org>; Sun,  2 Apr 2023 21:29:11 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id cu12so18181920pfb.13
        for <linux-pm@vger.kernel.org>; Sun, 02 Apr 2023 21:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680496151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MILQu40Gh4yj7702Jdu6F34VVeOYqufLKnQvxf105Ts=;
        b=q41nz+2B1XoLmAa2N7p2FiyUBnDkEtrf8PU/OpuuhBFb4BYKVkztPpcvXBF0inDCj1
         rCnrAYs8SyWflKFTByMcFUgo/Yl+MIAsFZlXmq+zItRUJx9DC697PX/E0B8TK5vWoBY5
         oMYNAovMkY3GeCMflmRXSlIzp0Mm2wJBGRQjNVZJ7jAeOMghkIhaNSFbtnIj6mixRpWv
         HATXclyhrO8f38QjStUjb7x5TvAf1pTiloxEHqo1z6hqCNxrkUx9gb7na9+x1GAZHowV
         bRhv03cHZAs6SI6IuTnvD11s47IHhzLd5E0/vSq1gNKhaqBnAOzw9FWWrxERMNevvSJY
         rWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680496151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MILQu40Gh4yj7702Jdu6F34VVeOYqufLKnQvxf105Ts=;
        b=jpAG0uS4IfrmLnlJHEUn7P7YTl4JDqxRcUSFIyhnNzJrY06R/lHI/UL60S16KkCx22
         tlkmnrWjVq2/2mXD5dRTlqDDB3wz1Kmq4JfRLmo1fW8UP7iXoqGsTXe0rYwpUdNvje/P
         LhmY8gkjJwhdNkQFiUimaMbHyOlwC/23JQnAVhiCMtW0N3uM3vqsz7Zm6TDLzCppIixH
         6Kwo0sUs1LqpnoqNDBAp6V7NI6j7WzbqBmrqOMWWXJWEYVbMERMnyOWFev288q/O1MWJ
         EmQVSCtkAgJSne8A56aoA+cJf2z5t/RGHNhoyXZOiXAy7rifpK/Rn1D5jjrpCJkDEXhj
         CoRw==
X-Gm-Message-State: AAQBX9e9vUrCcPKQzOga2qNIFvbNBiJ7bkjwGAOyYBC6mYEPUNlQAYbM
        M3B5jl+IUsqWm7mdEaYjHB5V0A==
X-Google-Smtp-Source: AKy350aAZE1RHbT63fnauKHs9qgzZBikHY/Yz0J2Gd9Y5k+cjEr1/1XnIiJ22hutWBTZtdV5Dt86wg==
X-Received: by 2002:aa7:95a9:0:b0:62d:af5a:27bf with SMTP id a9-20020aa795a9000000b0062daf5a27bfmr16211432pfk.6.1680496150910;
        Sun, 02 Apr 2023 21:29:10 -0700 (PDT)
Received: from localhost ([122.172.85.168])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7828e000000b005a8bf239f5csm5745261pfm.193.2023.04.02.21.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 21:29:10 -0700 (PDT)
Date:   Mon, 3 Apr 2023 09:59:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jun Nie <jun.nie@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] OPP: Move required opps configuration to specialized
 callback
Message-ID: <20230403042908.x4jpoywmalfbveia@vireshk-i7>
References: <cover.1677063656.git.viresh.kumar@linaro.org>
 <56b9926836652e9dbf56ca6b7628e836cddca351.1677063656.git.viresh.kumar@linaro.org>
 <CAPDyKFoQu1=XVCueOaUDgke3xdDy3bt9VRHPo2xdqkLbSbP8CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoQu1=XVCueOaUDgke3xdDy3bt9VRHPo2xdqkLbSbP8CA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-03-23, 14:06, Ulf Hansson wrote:
> On Wed, 22 Feb 2023 at 12:07, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The required-opps configuration is closely tied to genpd and performance
> > states at the moment and it is not very obvious that required-opps can
> > live without genpds. Though we don't support configuring required-opps
> > for non-genpd cases currently.
> >
> > This commit aims at separating these parts, where configuring genpds
> > would be a special case of configuring the required-opps.
> >
> > Add a specialized callback, set_required_opps(), to the opp table and
> > set it to different callbacks accordingly.
> >
> > This shouldn't result in any functional changes for now.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> This looks reasonable to me, but I guess it also depends on whether
> you will land patch3 or not?

Not necessarily, its better to have a clear error path to avoid
unnecessary confusion.

I have applied first two patches now. Thanks.

-- 
viresh
