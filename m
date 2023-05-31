Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE69717FEE
	for <lists+linux-pm@lfdr.de>; Wed, 31 May 2023 14:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjEaMbg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 May 2023 08:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjEaMbf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2023 08:31:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E378E
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 05:31:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-256a41d3e81so2257350a91.1
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685536294; x=1688128294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HqieH+9iZVXcIGYHo94VHF+5HuL9j5veOHlorFzqiSg=;
        b=CgWhS3xVwNiB2bBvohFXjP7N59WeGo34v9BpFef4/81XKt1R8u7JyGvrVpT8OHrBje
         FLY3x+2FPToy83spbc6lmbnhb6n6MKR0H8FUgatXTKUxM9o39aG4otCxCeUicEpYDgoM
         0HlyIFxh+oe1AHXjeX48IBMaL1gkXGdSJELvz1n3sTBsfOA4Co0IMiEWnH5qQfiYjs1h
         M3eK4gREIMuid+oUcOjjevUt0vvmjGqfZgcAoalgA3HQPYb/27j4zgf0YbwQMRQnAXDL
         7IUFaIwMfnSqrdX3bBAZUwjJoxHVCmAfbKksfy61H+lRGStQwTyHSqSrEEuxJ61uAi/R
         zALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685536294; x=1688128294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqieH+9iZVXcIGYHo94VHF+5HuL9j5veOHlorFzqiSg=;
        b=ihTAPyTOJNLX6k46lr20n3SZ/aTZe8js3hcv+jD8tAYYiFoiWASO9Q+5k7p6SBWIBy
         u4G60gkFCf4IXtSSyWygHfi9JDJ6VsHBTwkv/xUEaFlhW3O8KexcB2Ok3ntk/nid5dqo
         t9x+ureYrBlEFZHv7fZj3S7QCoWnb+S6u8WY/66VWz++XQqysg4+UKU7XL4tPasrNrTi
         H4fpA2g2EsFWCwfF/QnaBnLnhDKfKnsGuBRDSVX34wMgV6tAK6CvQnx8as3Zyd2UmDI/
         o3LtsXehPHpW2NQwRm4OWa3quDfzQR0cFWVBqpxyrgMyM58L9g+AUylZR3zLb0OHztwh
         LJgA==
X-Gm-Message-State: AC+VfDzA011trzWMp1TL4oDRmCfybj95pIEG4q5FWSJUVF8hwUt+iJRM
        B6w8KBYYSbXOdbhmQa61zz3dhaHwg+jk5KqaMLKvmA==
X-Google-Smtp-Source: ACHHUZ7oQMUlp6HlDjGvlnhMSOENc4/KRivjZPT+Lcgo2EPvHXuNaYBG7H41Ejv2WxIlBT5FM4EaeDPuvWxu4rxqvxg=
X-Received: by 2002:a17:90a:194a:b0:258:8609:f1e4 with SMTP id
 10-20020a17090a194a00b002588609f1e4mr754977pjh.24.1685536293865; Wed, 31 May
 2023 05:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
 <ZHcebApf6WCPMxPa@R5WKVNH4JW> <CAKfTPtAkCTE+Ef1yqc-CqftfmQnCzm85gpMrWWm5s=qK85Xk1A@mail.gmail.com>
 <ZHc4SqgVUe56P8lc@R5WKVNH4JW>
In-Reply-To: <ZHc4SqgVUe56P8lc@R5WKVNH4JW>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 31 May 2023 14:31:22 +0200
Message-ID: <CAKfTPtB8+b2uLrNYaP4wut82MWdVY_BMVvALKUSvZ8_uAySp_A@mail.gmail.com>
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
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 31 May 2023 at 14:09, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>
> Hi Vincent,
>
> On Wed, May 31, 2023 at 01:07:26PM +0200, Vincent Guittot wrote:
> > Hi Morten,
> >
> > On Wed, 31 May 2023 at 12:16, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > Thanks for organizing the micro-conference at LPC again this year.
> > >
> > > On Mon, May 22, 2023 at 07:12:39PM +0200, Rafael J. Wysocki wrote:
> > > > Hi Folks,
> > > >
> > > > I'm going to submit a Power Management and Thermal Control
> > > > micro-conference proposal for LPC2023 along the lines of what happened
> > > > in the previous iterations of it.
> > > >
> > > > If you have topics that you'd like to be discussed there, please let
> > > > me know by Friday, May 26.
> > > >
> > > > Please note that LPC MC topics are expected to cover work in progress
> > > > or at the concept stage.  They are not supposed to be about work that
> > > > has been done already.
> > >
> > > A late proposal, if the agenda isn't already full, is to discuss the
> > > deeper implications of uclamp in CFS relating to fairness, latency, and
> > > energy savings. uclamp is being adopted in the Android community for
> > > controlling performance/energy savings but alignment with upstream is
> > > lacking behind.
> >
> > With Daniel, Juri and Steven, we have submitted a "Real-time and
> > Scheduling MC" which is not yet accepted (so it's not yet publicly
> > visible).  But this could be a better place to discuss CFS changes.
>
> That could work too. It is closely related to PM though as uclamp is
> essentially putting the power/performance policy directly in the
> scheduler. With the right people around it doesn't matter where it is
> discussed :-)

Probably depends of what you want to discuss indeed but the " in CFS "
triggers to me that it could implies scheduler changes

>
> Morten
