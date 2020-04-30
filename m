Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785101BF39F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 11:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgD3JAT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 05:00:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33853 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgD3JAS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 05:00:18 -0400
Received: by mail-ot1-f67.google.com with SMTP id 72so4306278otu.1;
        Thu, 30 Apr 2020 02:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KQACPLN/GZpi+FYGmYG62Ze5DkTEi4wV710+OZY2aQ=;
        b=H3Jrnez4+57h4GGsGlUKjBUCzgCWRyEy6JDWuCmKOCUwez6SKQkM17Y0T4lZYkM+3/
         U4vZQnqImo3eBrs+Ia2oUL/dju4W8ziszY+cnBNYNA47hbTjvd9X0eS6zcQFYB4QTHF0
         o+msu24phfMWs/i/Rb9SoKhf1O/TMa12x79vd1Msgn42LseBhvKVz+TbJaJu8uNgpFSL
         AoZiHg7TzuKitI1VP7RIjEtRs7qV5Y5iQjbDxYfF3Cu/mXxUsL2wzB5TFO/AtqcoWRPG
         Gv2InbBZN8+ZURT3Kek0CDOPH7tpWuSYn8S9AhwB8MaZg33w6ypVtCqokvlSp4qLKRMP
         25EQ==
X-Gm-Message-State: AGi0PuZ/6WYvKDfchk5YdRNXQF+OKEYiYpF+ah6eQ9rFZ3kCPO0QYV0r
        ENSw71cjgK1fJsovF8cELACBs1r5AYHNIpCuL0qQDA==
X-Google-Smtp-Source: APiQypION7scbqEm7NDh6Gggg+1C2ij+NE18vee8aBc9XS9X5f4dFoPNeOl0elV99+hw6k1aQNEtvFSivkjKAlKGNyw=
X-Received: by 2002:a9d:112:: with SMTP id 18mr1274967otu.167.1588237217674;
 Thu, 30 Apr 2020 02:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200424114058.21199-1-benjamin.gaignard@st.com>
 <7657495.QyJl4BcWH5@kreacher> <CAKfTPtBNH8x=83RVQajgK859qQGjMTyvEdP4GioMONEZp9t-NA@mail.gmail.com>
In-Reply-To: <CAKfTPtBNH8x=83RVQajgK859qQGjMTyvEdP4GioMONEZp9t-NA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Apr 2020 11:00:05 +0200
Message-ID: <CAJZ5v0g+9DYuGS8URoXYecOxcnu5-kC-D=gvYTuMvxMZbYXR9w@mail.gmail.com>
Subject: Re: [RFC 0/3] Introduce cpufreq minimum load QoS
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, hugues.fruchet@st.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 29, 2020 at 7:08 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 29 Apr 2020 at 17:50, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Friday, April 24, 2020 1:40:55 PM CEST Benjamin Gaignard wrote:
> > > When start streaming from the sensor the CPU load could remain very low
> > > because almost all the capture pipeline is done in hardware (i.e. without
> > > using the CPU) and let believe to cpufreq governor that it could use lower
> > > frequencies. If the governor decides to use a too low frequency that
> > > becomes a problem when we need to acknowledge the interrupt during the
> > > blanking time.
> > > The delay to ack the interrupt and perform all the other actions before
> > > the next frame is very short and doesn't allow to the cpufreq governor to
> > > provide the required burst of power. That led to drop the half of the frames.
> > >
> > > To avoid this problem, DCMI driver informs the cpufreq governors by adding
> > > a cpufreq minimum load QoS resquest.
> >
> > This seems to be addressing a use case that can be addressed with the help of
> > utilization clamps with less power overhead.
>
> Can't freq_qos_update_request() be also used if you don't have cgroup
> enabled on your system ?

It can.

The problem here is that imposing a global minimum frequency limit
generally causes the power draw of the system to increase regardless
of what is going on, including the CPUs that are not involved in the
handling of the interrupt in question.

That seems a bit excessive ...
