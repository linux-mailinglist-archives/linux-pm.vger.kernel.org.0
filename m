Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F6928CCC5
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 13:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgJMLxu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 07:53:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37939 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgJMLxu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 07:53:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id i12so18773820ota.5;
        Tue, 13 Oct 2020 04:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKcxVZXcGjKnM/UI9lTzx4pQlxixhKKz1kfyIC+NkEo=;
        b=K9hU8vc2OhKUyACN/O+KlBJ9tve2NTGJjDtF3L27RQk7MxhIUiOsx7xJbqyctC7Bnh
         trM0meU/01ZCp5eQy1LkD5rrNWf89clgg+cbuPwXyyqaOr/i4yUXTNbJPT3NKbnEOj4U
         zgwIDQiYppettb3EUuaqen4TizxO1ha98Cz9zVI9Vu8jSUA4F+zrG0UG5d+hSrtgEk3d
         m2AYzSGC9iy31LNQE2if7Tqrt/8X3szgJQlALwvkjQjxbrfRdOe4/Bfi3RdRD834BbGb
         ZIl7lSjQvCdnvbbUtzO3p4HP5R7D0VJwi2Q5AnozHCHwp3xFIFJznJUGnGsVnsx/RW8v
         JFyQ==
X-Gm-Message-State: AOAM5313ImJ9AfJeyA1/QprqsTV2sXhwXkk1n7kbruPpaS3MjBjDHPhD
        S+p8q9fLmLuHxVbPxeP3hM5a8R4rI7uF5znI9qQ=
X-Google-Smtp-Source: ABdhPJy0vR6s0N4OFATlsxlScbQJBRduTTaV8DeSQXHIEZSmyqHSck8Ni3Ty1HeIUoEYjx+VYLYl1RYVYdDWV6slfyw=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr22997616otk.260.1602590029397;
 Tue, 13 Oct 2020 04:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201008150317.GB20268@arm.com> <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7> <42e3c8e9-cadc-d013-1e1f-fa06af4a45ff@arm.com>
 <20201009140141.GA4048593@bogus> <2b7b6486-2898-1279-ce9f-9e7bd3512152@arm.com>
 <20201012105945.GA9219@arm.com> <500510b9-58f3-90b3-8c95-0ac481d468b5@arm.com>
 <20201012163032.GA30838@arm.com> <9fe56600-ba7d-d3b6-eea3-885475d94d7a@arm.com>
 <20201012220132.GA1715@arm.com>
In-Reply-To: <20201012220132.GA1715@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 13 Oct 2020 13:53:37 +0200
Message-ID: <CAJZ5v0hMtPARYezJEZqeUZBsyaSggQvtvvfEvONhz6Z=Y32bhQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for cpu-perf-dependencies
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
        Nicola Mazzucato <nicola.mazzucato@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 13, 2020 at 12:01 AM Ionela Voinescu
<ionela.voinescu@arm.com> wrote:
>
> Hey Lukasz,
>
> I think after all this discussion (in our own way of describing things)
> we agree on how the current cpufreq based FIE implementation is affected
> in systems that use hardware coordination.
>
> What we don't agree on is the location where that implementation (that
> uses the new mask and aggregation) should be.
>
> On Monday 12 Oct 2020 at 19:19:29 (+0100), Lukasz Luba wrote:
> [..]
> > The previous FIE implementation where arch_set_freq_scale()
> > was called from the drivers, was better suited for this issue.
> > Driver could just use internal dependency cpumask or even
> > do the aggregation to figure out the max freq for cluster
> > if there is a need, before calling arch_set_freq_scale().
> >
> > It is not perfect solution for software FIE, but one of possible
> > when there is no hw counters.
> >
> [..]
>
> > Difference between new FIE and old FIE (from v5.8) is that the new one
> > purely relies on schedutil max freq value (which will now be missing),
> > while the old FIE was called by the driver and thus it was an option to
> > fix only the affected cpufreq driver [1][2].
> >
>
> My final argument is that now you have 2 drivers that would need this
> support, next you'll have 3 (the new mediatek driver), and in the future
> there will be more. So why limit and duplicate this functionality in the
> drivers? Why not make it generic for all drivers to use if the system
> is using hardware coordination?
>
> Additionally, I don't think drivers should not even need to know about
> these dependency/clock domains. They should act at the level of the
> policy, which in this case will be at the level of each CPU.

The policies come from the driver, though.

The driver decides how many CPUs will be there in a policy and how to
handle them at the initialization time.

The core has no idea whether or not there is HW coordination in the
system, the driver is expected to know that and take that into
account.

Accordingly, it looks like there should be an option for drivers to
arrange things in the most convenient way (from their perspective) and
that option has gone away now.
