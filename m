Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A0649E81
	for <lists+linux-pm@lfdr.de>; Mon, 12 Dec 2022 13:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiLLMPu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Dec 2022 07:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiLLMPt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2022 07:15:49 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C06D4C
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 04:15:48 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id pv25so2141834qvb.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 04:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ehf/W6Lak+N/EyMFH1VPaCVJjhV1qYJdjY5pgpsY2U=;
        b=WELSFWviJicXQK+g8L2m/uqcLlgph8OxFMWuX4wg8P59yIWwj8JO0t0PAedY10PjLA
         9xeN5TBC/a6p0ff7nGMc4ORrBd3FzvLTjyf3Bboomg5/qFX4lEIKwjM8+Vfmo6eO+zD0
         9/ResmYspmCfGis242Uw0EIY7BAysUPXN40YBN6Is/gtgJwXY5DOERpWTPhG+LruQQ/h
         Dhnc08/oJmlA1Nj4CF5MHrX5VmGbUmJD4KGBJkljwoVAN6YsfOYkAyP04NwgJmN2RDVn
         EZkBxsuA5PHF41KJzPD5he6lwcYLbNvrJ3zvVTx83eW1EKDIdgO3S4jWwaQSznOl29aF
         YYxA==
X-Gm-Message-State: ANoB5pm79+6aoxFfQ+iUT8J7aXejfxSOuYDGJoz+xT6gA5sdvWFWzpal
        TD+BsGrgHx5W6kw1lPo5DuOlPKAD1uhy3AwC/AM=
X-Google-Smtp-Source: AA0mqf5yj1Rbgs8vPxbgFVA1ZVMxBS6PDr0OPoqn+3m7LKVCj3p4K1kmesf7YRmH3JbAZjktcGUFeU6h4dz7SrKdQV4=
X-Received: by 2002:a05:6214:2b90:b0:4c7:27cf:dfca with SMTP id
 kr16-20020a0562142b9000b004c727cfdfcamr29731590qvb.3.1670847348022; Mon, 12
 Dec 2022 04:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20221108033332.27760-1-rui.zhang@intel.com> <20221108033332.27760-2-rui.zhang@intel.com>
 <CAJZ5v0hOzCRnoH52EEMZm+CRDNKSYg2iZax2CnowzdMXjX8QYA@mail.gmail.com>
 <c827d96fcf50a39ebd219cd09d9b4bd1db2f0398.camel@intel.com>
 <CAJZ5v0gFMewt-paH4D3sDpgUSAfGJojGHOdUxXH9ahSHA6P7+Q@mail.gmail.com>
 <015c7c006b0bbe935a31c837ed0fc5da9d7e43cd.camel@intel.com>
 <fd4b11f8f9ce4b592c6fdfed2d14f7b8a6c3e4f0.camel@linux.intel.com> <5c0e237bc3338ea61e04643b0077e4d55479e4fc.camel@intel.com>
In-Reply-To: <5c0e237bc3338ea61e04643b0077e4d55479e4fc.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Dec 2022 13:15:31 +0100
Message-ID: <CAJZ5v0hbu-bakBt4d-NxgYQo1a5Zsu6oDs4g6XmbMCbeihZN0g@mail.gmail.com>
Subject: Re: [PATCH 1/6] thermal/intel: Introduce Intel TCC library
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 11, 2022 at 8:50 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Fri, 2022-12-09 at 08:28 -0800, srinivas pandruvada wrote:
> > On Fri, 2022-12-09 at 21:32 +0800, Zhang Rui wrote:
> >
> > [...]
> >
> > > > > > Well, what if somebody change tjmax on this cpu while this
> > > > > > function
> > > > > > is running?
> > > > >
> > > > > tjmax is read only. Only firmware can change its value at
> > > > > runtime,
> > > > > say
> > > > > this field is updated when SST-PP level is changed.
> > > >
> > > > Do we get any type of notification on tjmax changes, or do we
> > > > need
> > > > to
> > > > poll for it?
> > >
> > > I'm not aware of such a notification.
> > > Srinivas, do you know if there is one?
> > There is no explicit notification. You can infer from HWP guaranteed
> > change interrupt.
>
> But
> 1. tjmax may or may not change when HWP guaranteed change interrupt
> fires. And it does not change in most cases, right?
> 2. HWP guaranteed change interrupt is per CPU, so if we update tjmax in
> the interrupt handler, we also need to cache the timestamp to avoid
> duplicate updates from multiple CPUs in the same package/die.
>
> Given that the TCC lib APIs may or may not be called, depends on the
> usersapce behavior, do you think this is a win by adding this extra
> cost?

Not really.

> Instead, update the tjmax value only when the API is called, and then
> cache it to handle frequent read is sufficient. what do you think?

Yes, that should be sufficient, but I wouldn't do it in this series anyway.
