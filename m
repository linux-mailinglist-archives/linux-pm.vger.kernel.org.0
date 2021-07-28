Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49E03D8FAF
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jul 2021 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbhG1Nxc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jul 2021 09:53:32 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:37388 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbhG1NxG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jul 2021 09:53:06 -0400
Received: by mail-ot1-f49.google.com with SMTP id z6-20020a9d24860000b02904d14e47202cso2157650ota.4;
        Wed, 28 Jul 2021 06:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQ2uTtmQSF7eeJSxOaPiuG0wacoqEZYWK0ECaKxTctU=;
        b=oGQB6gE01Ppa7kZS+0sq873X5i13SWu6OdEI7jh84/o4C7zxrnxWUKkR8JjZEi0MsD
         rGeOZh7HjXu5uZvP2DlgS2JGxMOcCsL4ktUUuXSUpBJTvC5DCwN8MnT/mpEHFUG1UrOL
         +jkOCRcQHtgSHWyzRwHFNZd0jV941DpVOSHameUmPCIHtdv0+Y36SlEl3ahkbV9NiyuN
         F/+CFt5NYevyB4WE7pje9qU9qqIjp1GnqYpsaKXqnrN4FcFTEXPPM0MpLS6JjixCWoEa
         kUCCQdsbYn5xF3eAMG1z5RPiErqFL9BPk8dE08VCcLMBo0P3hJ9LV6MpSZdjZmnrqbTc
         d/bw==
X-Gm-Message-State: AOAM5339Bq2R+Ue/2c2Hw6L4XWgB+X6tbc5OkMpEF7+bzaJRT3oQT8m2
        iDj4hRFXf+mFMOdcAFq/Ilf0iSpmVnfqYlOvAgI=
X-Google-Smtp-Source: ABdhPJwTnNGP3qLFPqtkpJp48iEuk+9w1bYwKVJ49seRbatZVwQgS1znIJlIzRN9T5GaQemDotp88A5AaHT/SXUqpzY=
X-Received: by 2002:a05:6830:9a:: with SMTP id a26mr82592oto.260.1627480383227;
 Wed, 28 Jul 2021 06:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <1867445.PYKUYFuaPT@kreacher> <000801d78322$e9b94980$bd2bdc80$@telus.net>
In-Reply-To: <000801d78322$e9b94980$bd2bdc80$@telus.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Jul 2021 15:52:51 +0200
Message-ID: <CAJZ5v0jashhvE4vRNAft1qfZ_Ud==tG1Yh29ad7BSfhk5xjx4A@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] cpuidle: teo: Rework the idle state selection logic
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 27, 2021 at 10:06 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> Further to my reply of 2021.07.04  on this, I have
> continued to work with and test this patch set.
>
> On 2021.06.02 11:14 Rafael J. Wysocki wrote:
>
> >This series of patches addresses some theoretical shortcoming in the
> > TEO (Timer Events Oriented) cpuidle governor by reworking its idle
> > state selection logic to some extent.
> >
> > Patches [1-2/5] are introductory cleanups and the substantial changes are
> > made in patches [3-4/5] (please refer to the changelogs of these two
> > patches for details).  The last patch only deals with documentation.
> >
> > Even though this work is mostly based on theoretical considerations, it
> > shows a measurable reduction of the number of cases in which the shallowest
> > idle state is selected while it would be more beneficial to select a deeper
> > one or the deepest idle state is selected while it would be more beneficial to
> > select a shallower one, which should be a noticeable improvement.
>
> I am concentrating in the idle state 0 and 1 area.
> When I disable idle state 0, the expectation is its
> usage will fall to idle state 1. It doesn't.
>
> Conditions:
> CPU: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> HWP: disabled
> CPU frequency scaling driver: intel_pstate, active
> CPU frequency scaling governor: performance.
> Idle configuration: As a COMETLAKE processor, with 4 idle states.
> Sample time for below: 1 minute.
> Workflow: Cross core named pipe token passing, 12 threads.
>
> Kernel 5.14-rc3: idle: teo governor
>
> All idle states enabled: PASS
> Processor: 97 watts
> Idle state 0 entries: 811151
> Idle state 1 entries: 140300776
> Idle state 2 entries: 889
> Idle state 3 entries: 8
>
> Idle state 0 disabled: FAIL <<<<<
> Processor: 96 watts
> Idle state 0 entries: 0
> Idle state 1 entries: 65599283
> Idle state 2 entries: 364399
> Idle state 3 entries: 65112651

This looks odd.

Thanks for the report, I'll take a look at this.
