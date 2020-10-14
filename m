Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE16028DC50
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 11:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgJNJEn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 05:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbgJNJEg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 05:04:36 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352F7C041E6B
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 21:25:35 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ds1so784422pjb.5
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 21:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jqWcpa42URbsJYkeNmmPzi1+jlodeSMihJOMagBFEDU=;
        b=s6HeF1SGVHGC2oyxQ8WdZxfrtDy2ZitX5zAuOzD9yQHVn4I2hw7IgAiExwnQDPTNwp
         BQzt1X6Lqj/bV5R9WfIkgLiAMwGl79iatHK+6F34QMdfB2gEJBvUWHlF7OMek+eg7XNh
         Zf8bOdnzDhDDd84GGrP30nYG6HAupQEe9duBKveBLqZZ5ub4YyYxUqs1GY8HXqlje7EG
         9Srbo+QHUZcuAJdu2s2DY6uuTS2dCRk9JeEzXJz7g5Z5v3ROQW0wqrImBTQda6BpPv4B
         gqgHetIwJDrXe31u47pP9izHMISBFfQNdl3cn7gFxF8oPNSm27NnMaim7WaboldcjiLt
         FVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jqWcpa42URbsJYkeNmmPzi1+jlodeSMihJOMagBFEDU=;
        b=AcQUbZstPqVAeuwKVz37t5PUQjQtkK3sO6jAQ7gJs/J0NtsUj2UDeEC6PgU/WxJZYb
         o5VCF5PfqgtLDlXTx0HRnr9v2EG80DvgPpxzepNtJbzzvd3/Ou3vd/UUbMUYNDS5c442
         BTm6u2WJTwuyyHqrpiyXTLeMPiEtP2/MIKTI8wQzbUUQDdLiKOABmtevZrF+mLb6gmD4
         ecjiA5gyD21TnWztOt+o2CKSNFx//v2JsBXc+JI5C7mnsjsShgPeRer8+yfCaaqJ4OGh
         4IdqZJypyYw1/dbxac3nyVLx+Zz7cEL23RTq/v5eBvXGkP4WSUGZGMhgBWNV/lvu8WlH
         kYCQ==
X-Gm-Message-State: AOAM532bP/HBBM+xAYUwtylNjFGvExPjzXZGtxrybhzgj3Ulo4eJTIc9
        cSaunAG1UnTTcdPCU4yzcMMfQA==
X-Google-Smtp-Source: ABdhPJwZV7/AgPKuIFGMcWKwWD0cpwn6OGmDMCdsyMZsRdpT0FErCuGiayAGS2xywEAgwCY+6FKuRA==
X-Received: by 2002:a17:902:7002:b029:d5:3e:3b0c with SMTP id y2-20020a1709027002b02900d5003e3b0cmr2581898plk.52.1602649534683;
        Tue, 13 Oct 2020 21:25:34 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id n203sm1443308pfd.81.2020.10.13.21.25.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2020 21:25:33 -0700 (PDT)
Date:   Wed, 14 Oct 2020 09:55:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicola Mazzucato <nicola.mazzucato@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        chris.redpath@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201014042531.r7iykzygkvmpsqck@vireshk-i7>
References: <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7>
 <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
 <20201012154915.GD16519@bogus>
 <20201012165219.GA3573@arm.com>
 <17819d4d-9e7e-9a38-4227-d0d10a0749f1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17819d4d-9e7e-9a38-4227-d0d10a0749f1@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-10-20, 18:18, Lukasz Luba wrote:
> On 10/12/20 5:52 PM, Ionela Voinescu wrote:
> > On Monday 12 Oct 2020 at 16:49:30 (+0100), Sudeep Holla wrote:
> > > On Fri, Oct 09, 2020 at 11:09:21AM +0530, Viresh Kumar wrote:
> > > > - I wonder if we can keep using that instead of creating new bindings
> > > >    for exact same stuff ? Though the difference here would be that the
> > > >    OPP may not have any other entries.
> > > 
> > > Well summarised, sorry for chiming in late. I could have not summarised
> > > any better. Just saw the big thread and was thinking of summarising.
> > > If the last point on OPP is possible(i.e. no OPP entries but just use
> > > it for fetch the information) for $subject patch is trying to achieve,
> > > then it would be good.

Under normal circumstances, I wouldn't have suggested empty opp-tables
for sure but it doesn't seem worth adding another binding to get this
information out :)

> > 
> > Just to put in my two pennies worth: using opp-shared (in possibly empty
> > OPP table) as alternative to cpu-perf-dependencies sounds good enough
> > to me as well.
> 
> +1

Now that (almost) everyone agrees, I don't think we need to make any
change anywhere, in code or bindings. This should work right now as
well.  The code should never try to create OPP tables and the core
will not create one. Your driver (which want to get this information
out of empty OPP tables) shall call dev_pm_opp_of_get_sharing_cpus(),
which just parses the DT to get this information out.

-- 
viresh
