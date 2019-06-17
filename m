Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03DB149464
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 23:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfFQViF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 17:38:05 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41719 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbfFQVTA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 17:19:00 -0400
Received: by mail-ot1-f68.google.com with SMTP id 107so11206974otj.8
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2019 14:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lx3ZMGHHpL+zr0i6JCDXuAYbsW7y/9/U7aquyGvQmdw=;
        b=oi3DqvlifzsIlUwRqtSh/XOR4epmR17QT/xTfqWF6CFI1QSHOuPEi9PRIGjxAqQMeW
         PvrSDET6xZ/4y2Ktkzxnn9ohvraXas1BQNawYXjGWZdiDSE7pS47zVBIMkvuw62lkGih
         vesOix3gdPkfxMNeXsHpw8YsB47clVXOXJfsrAo1nFWXbzIzG0/H2sc2moRU9EaZOtie
         tp64TxNKwKMG7XlBeQvAgkrUSHP3i/aB/SNNQfOU1sFCsgL+0OWCKS4CsSVmYLPcN1wy
         KFRHfMssPCam5ZONYyZTeBpO8CnjUVaD6qKR7DWId5YbvhTVfUHoY7s9teKqbua/++0r
         rAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lx3ZMGHHpL+zr0i6JCDXuAYbsW7y/9/U7aquyGvQmdw=;
        b=HMmkAdwQ1ZN5h7BzNsLV4PAmVIjCnTdyu9gJvpusbFB1R1ALyd/ixEpnapG2d9Egmq
         HJAzj3DYtwKjuXq8kBkTh6DYBAzzvCzvoJHZ5Jumy8IzoGedT6WCYGaLG9j+rNIJUOvE
         ckezNgrtHd7P8kiPPcghCcYRePr/uA7i3LxRdvPeWpfZKrT9DD30l+KwSRnTg7wQ3WAI
         s6MpfOAtZJwPbr7lI6TzNgMxqM/2QHnSE4xnkHegi5AMtizxKblLNHnO/So3a/WRG/ug
         ceEDzcpBmfFDsHXOnZKuMQW4oXP0lpUyLhPUJf0D+gRPeN0zYOn1F6c5X5sCtjgLAjxc
         FW4w==
X-Gm-Message-State: APjAAAXPP7jvdNoRUWS/hPDX63/ZphzfPGwvCiD7/WTCqQY3shwWg6df
        57IdZW6sJ1c1hCSOFSMuUH7g4Y3NbIZrsFdmNrfvfQ==
X-Google-Smtp-Source: APXvYqx+n7PVXUHXlfGbnhTJpJHw8ZcgJkSRIzcYPpqw0RtkzqWTWL+uTvnbD6uj4WKEkEx8P9eyU9HdkLCl39r63F8=
X-Received: by 2002:a9d:6201:: with SMTP id g1mr2577934otj.195.1560806339322;
 Mon, 17 Jun 2019 14:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com> <20190614041733.120807-12-saravanak@google.com>
 <5dc6c820-ead8-d0dc-44de-4d13f86df042@linaro.org>
In-Reply-To: <5dc6c820-ead8-d0dc-44de-4d13f86df042@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 17 Jun 2019 14:18:23 -0700
Message-ID: <CAGETcx-xU9i1FJB5JecUoyZEfWpD8f+o9bC3SQmb-=3fLVbmQw@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] interconnect: Add devfreq support
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org,
        Android Kernel Team <kernel-team@android.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 17, 2019 at 8:44 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Saravana,
>
> On 6/14/19 07:17, Saravana Kannan wrote:
> > Add a icc_create_devfreq() and icc_remove_devfreq() to create and remove
> > devfreq devices for interconnect paths. A driver can create/remove devfreq
> > devices for the interconnects needed for its device by calling these APIs.
> > This would allow various devfreq governors to work with interconnect paths
> > and the device driver itself doesn't have to actively manage the bandwidth
> > votes for the interconnects.
>
> Thanks for the patches, but creating devfreq devices for each interconnect path
> seems odd to me - at least for consumers that already use a governor.

Each governor instance always handles one "frequency" (more like
performance) domain at a time. So if a consumer is already using a
governor to scale the hardware block, then using another governor to
scale the interconnect performance points is the right way to go about
it. In fact, that's exactly what devfreq passive governor's
documentation even says it's meant for. That's also what cpufreq does
for each cluster/CPU frequency domain too.

> So for DDR
> scaling for example, are you suggesting that we add a devfreq device from the
> cpufreq driver in order to scale the interconnect between CPU<->DDR?

Yes in general. Although, CPUs are a special case because CPUs don't
go through devfreq. So passive governor as it stands today won't work.
CPU<->DDR scaling might need a separate governor (unlikely) or some
changes to the passive governor that I'm happy to work on once we
settle this for general devices like GPU, etc. But the DT format for
CPUs will be identical to GPUs or any other device.

> Also if the
> GPU is already using devfreq, should we add a devfreq per each interconnect
> path? What would be the benefit in this case - using different governors for
> bandwidth scaling maybe?

When saying "separate/different governors" in this email, I mean both
different instance of the same governor logic with different tunables
AND actually different algorithms/governor logic entirely.

The heuristics to use for each interconnect path might be (more like,
will be) different based on hardware characteristics (Eg: what voltage
domains the interconnect is sitting on) and what interconnect
information is available (Eg: Just busy time vs bandwidth count vs no
information etc) -- so having separate governors for each interconnect
path makes a lot of sense. It also allows userspace to control the
policy for scaling each of those paths based on product use cases.

For example, when the GPU is just doing simple UI rendering, userspace
can use the max_freq sysfs file for the devfreq device to disallow high
bandwidth OPPs on the GPU<->DDR path, but those higher OPPs could be
allowed by userspace when the GPU is used for games. Having devfreq
device for each interconnect path also make it easy to debug
performance issues -- you can independently change the votes for each
path to figure out what is causing the bottleneck, etc.

Adding a devfreq device for interconnect voting with a few lines gives
all these features "for free".

This doesn't mean all users of interconnect framework NEED to use
devfreq for interconnect. They might do it simply based on
calculations based on the use case (Eg: display driver from display
resolution). But if they are trying to use any kind of
algorithm/heuristics, writing it as a devfreq governor should be
encouraged.

Also want to point out that BW OPPs also work for drivers that don't
use devfreq at all. The interconnect-opp-table just lists the
meaningful OPP leveld for the path and the device driver can pick one
entry from the table based on the use case.

Thanks,
Saravana
