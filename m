Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922A77185F0
	for <lists+linux-pm@lfdr.de>; Wed, 31 May 2023 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjEaPRN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 31 May 2023 11:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjEaPQ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2023 11:16:58 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B5712B
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 08:16:56 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-30ad48957f5so934242f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 08:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685546214; x=1688138214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRVUCKm5G4TE5Z1Y3aznNHFOc4m5Kox+GeF/qSbtCqg=;
        b=j0dCIUsGHmGPpsp0grA0tmJWQ8R3JEc7z6V00rfPrzvGSmYRBxNnFOqHwltvrXH/l4
         Uo72D3n2p7TaGGj+/6+uGMPoCOpIXnTqeDfRWdKMrH6AGj46GMHQpjSskDfWsHuZt15e
         Odp0PvvtdK2sFYURpJqrmeUrWJzJt3r7EpeF+pLpdi2+VPsnELuJVlfEzny1N7MFmN7I
         8zZMeKN2Oa4XmpanhRK2bzsYtYarQVXTdrhrIhlbFaW8xrVZgKhZe138SuezCA3DFf5A
         TNNCcAppBd2LU83fhriI76J0uXcbpLGSUfgxlfDIlE+3yT/ceiYO/OsvXJniWwWe/0c8
         7B4A==
X-Gm-Message-State: AC+VfDwFwpc9y6YuYPrahlEc7vmj5Pik4UYFiopC6d+MgiDZGHdfHXF1
        JRD+xj0qAFf/L2LSDu8yjY6w2pKDQZLVYXODWBENhl4A
X-Google-Smtp-Source: ACHHUZ4obhYWMuZet9sft+oENxOEVmscgDm/Ch4cnysJaTjAuhPgjkFSm7MVFBvn9+aJI0L8kf8CLtiqSBfG/eT3MTU=
X-Received: by 2002:a5d:4805:0:b0:307:cf5e:28a9 with SMTP id
 l5-20020a5d4805000000b00307cf5e28a9mr1906610wrq.5.1685546214238; Wed, 31 May
 2023 08:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
 <ZHcebApf6WCPMxPa@R5WKVNH4JW>
In-Reply-To: <ZHcebApf6WCPMxPa@R5WKVNH4JW>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 31 May 2023 17:16:41 +0200
Message-ID: <CAJZ5v0hNEHFutnceMY5wG0Z6+GHTKSuT_MsjoJyOyZWahyBtRw@mail.gmail.com>
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Morten,

On Wed, May 31, 2023 at 12:16 PM Morten Rasmussen
<morten.rasmussen@arm.com> wrote:
>
> Hi Rafael,
>
> Thanks for organizing the micro-conference at LPC again this year.
>
> On Mon, May 22, 2023 at 07:12:39PM +0200, Rafael J. Wysocki wrote:
> > Hi Folks,
> >
> > I'm going to submit a Power Management and Thermal Control
> > micro-conference proposal for LPC2023 along the lines of what happened
> > in the previous iterations of it.
> >
> > If you have topics that you'd like to be discussed there, please let
> > me know by Friday, May 26.
> >
> > Please note that LPC MC topics are expected to cover work in progress
> > or at the concept stage.  They are not supposed to be about work that
> > has been done already.
>
> A late proposal, if the agenda isn't already full, is to discuss the
> deeper implications of uclamp in CFS relating to fairness, latency, and
> energy savings. uclamp is being adopted in the Android community for
> controlling performance/energy savings but alignment with upstream is
> lacking behind.

There will be a proper CfP just for the MC later I think (at least
that was the case previously), at this time it's just a collection of
topics.

> "uclamp in CFS: Fairness, latency, and energy efficiency."

OK, I'll add it.  It can be moved to the "RT and scheduling" MC later
or submitted there when the MCs get accepted.
