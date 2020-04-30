Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7478A1BF3B0
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 11:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgD3JEH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 05:04:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36475 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgD3JEH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 05:04:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id s202so4609412oih.3;
        Thu, 30 Apr 2020 02:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPIctqtbjHbN+c6WsGMnZ4aDcQr0Dn9FvwQoBcXdb4k=;
        b=cWEchaky38a6ftNwmFGRftCwazWO2LC1n86PfbcJIlICh5bPgybL+cuaO+Egs4hFI1
         7yLX88FQS8BIrL8l8+f8+9Dx3OWcoosY/YTK3mBu6O4O6zQswgKAwi2PIOhysFur6Ccb
         8n5IStch8nTA4R42ojueTOudcJY0TMtdiYwasCBVRMCuFK4J8uR4SGg5oBBQTFHFvdQH
         hzFTcj7XvyrzuC5YlraFT/28Z7I+19DhIONeOG6CAHnOv+K/og/8ix7ig/5RnRcfamGg
         c+ik8DIFF62oR7nUNqfSU10IdwsKlGx1+57Z17QpSC52Z93v5E/G/oa7bogjp/76syTL
         o0fA==
X-Gm-Message-State: AGi0PuYlWhPme+BGipgKJv47SeWTe9R83Rqr49Bqvp2T/QD3giPinJhd
        tt6M52sYai/e6JnCIdlszVH7RwkXcyU5nBix1KU=
X-Google-Smtp-Source: APiQypJD2+GdHPcXAjdJ2otz/vhbS/df9CkF9oCL8wWT9gqhtZ1UAebHm6B/NCfiC2qhRAGhImTD5b2woCc+kgQvvjQ=
X-Received: by 2002:aca:aa8c:: with SMTP id t134mr1027807oie.103.1588237445928;
 Thu, 30 Apr 2020 02:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200424114058.21199-1-benjamin.gaignard@st.com>
 <7657495.QyJl4BcWH5@kreacher> <30cdecf9-703a-eb2b-7c2b-f1e21c805add@st.com>
 <70e743cf-b88e-346a-5114-939b8724c83d@arm.com> <6b5cde14-58b3-045d-9413-223e66b87bf0@st.com>
In-Reply-To: <6b5cde14-58b3-045d-9413-223e66b87bf0@st.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Apr 2020 11:03:54 +0200
Message-ID: <CAJZ5v0h6t6perZiibCWhEh1_V0pSXqFe-z22TFqH7KTFXYmqpQ@mail.gmail.com>
Subject: Re: [RFC 0/3] Introduce cpufreq minimum load QoS
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Hugues FRUCHET <hugues.fruchet@st.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 30, 2020 at 9:53 AM Benjamin GAIGNARD
<benjamin.gaignard@st.com> wrote:
>
>
>
> On 4/29/20 6:12 PM, Valentin Schneider wrote:
> > On 29/04/2020 16:57, Benjamin GAIGNARD wrote:
> >>
> >> On 4/29/20 5:50 PM, Rafael J. Wysocki wrote:
> >>> On Friday, April 24, 2020 1:40:55 PM CEST Benjamin Gaignard wrote:
> >>>> When start streaming from the sensor the CPU load could remain very low
> >>>> because almost all the capture pipeline is done in hardware (i.e. without
> >>>> using the CPU) and let believe to cpufreq governor that it could use lower
> >>>> frequencies. If the governor decides to use a too low frequency that
> >>>> becomes a problem when we need to acknowledge the interrupt during the
> >>>> blanking time.
> >>>> The delay to ack the interrupt and perform all the other actions before
> >>>> the next frame is very short and doesn't allow to the cpufreq governor to
> >>>> provide the required burst of power. That led to drop the half of the frames.
> >>>>
> >>>> To avoid this problem, DCMI driver informs the cpufreq governors by adding
> >>>> a cpufreq minimum load QoS resquest.
> >>> This seems to be addressing a use case that can be addressed with the help of
> >>> utilization clamps with less power overhead.
> >> Do mean clamping the policy frequencies ? I may have miss the API to do
> >> that...
> > IIUC Rafael is referring to uclamp, i.e. scheduler utilization clamping, see:
> >
> >    https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#cpu
> >
> > The above describes the cgroup interface, note that you can also set clamps
> > per task (via sched_setattr()).
> >
> > One thing that comes to mind however is that schedutil only "sees" the clamps
> > of runnable tasks, and from reading your changelog you may not have moments
> > without any (i.e. gears are grinding in HW). You'd have to try boosting
> > (setting a high uclamp.min) whatever tasks you have on the software side and
> > see how it all behaves.
>
> Relying on userland side means that various applications need to be aware
> of this specific hardware case and fix it. I was hoping to find a
> solution in side the kernel
> to not impact the software side.

That's not what I meant.

I suppose that the interrupt processing in question takes place in
process context and so you may set the lower clamp on the utilization
of the task carrying that out.

Alternatively, that task may be a deadline one.
