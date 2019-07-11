Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0584665776
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 14:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfGKM6l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 08:58:41 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39087 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfGKM6k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 08:58:40 -0400
Received: by mail-vs1-f68.google.com with SMTP id u3so4002633vsh.6
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2019 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VKUdY/fFrONctf+DomEmlrujLkDYISGzLsqm36mah/k=;
        b=zyBdyxRSjNS0x8+aWXBINusUfobblVdX3y4TpAa8sm/WMg4axoJiKDWXCdT33mWL0E
         M6HU6nw5Slk30P/fuv/SHCRtNy0Wx/KTgAlVh6J1zI9s8yNrTfAczx0rplyLc1Y0I5Cu
         OKLUJA2i0YB39wsV6wns88Gu/p5IsKJVCjuTbguftdKJsBGAiUbCUbO+ozkvtP0Sbsv+
         MSZeKke8G7EnFAVUfbr4cs/M0mG1Xyktt5cBH0dagGqhYIJdEA8jBZ0GyU2ful9mDziO
         q1uaozJtaETV/fhZl7pXB7gX/cWtTixkuWh5KoH5uc8kKE6yJLxNYlZDJQEC6Bjb6Ww3
         h5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKUdY/fFrONctf+DomEmlrujLkDYISGzLsqm36mah/k=;
        b=K7aldHVWFzWqKGUxe0X7anwf62j+gwlJl/4De11CGKqBjIVK/UdJ54m0SU3PDlcDfK
         KjkFoM9o9RVZFPJVOXkACmQ4YMaPEiX2+aGyo/s7uSDRWPmiUdxTp8PFH4IstRKd4d/c
         gfH8dS68iRe/t7x11iBL0LUEXC6CEW35LvwNdH3rKRWmfKbCZYLx/HNc4goOsUBLdKlp
         2PELtIOeJtRlS2bvZAYWKr9BmXByhAoQr1A4eV3uraZVNibvruwB15CDnXR3f8D3jpCB
         wMi7mVo3hhM/gDHGjgRwPzxYrOsYs2O72BUAvEGez7pErFpat9nE5kFUPU2vDjfCXx1X
         3wXA==
X-Gm-Message-State: APjAAAXVKJWW/YB6oW/oeba8FO7ILWNdvHN7HuV+PtTavnJk2OXgqgyj
        l7Q8yoMTyYOalJ5YOf22mTWEBNQ4tW7SvCmhHiw=
X-Google-Smtp-Source: APXvYqw5/EvIcuRHKo1NRexFzxAzUzqPXcfm7R2N4A7tLo2g+c9+Sm4aLdpkfY/LbUHhJQVkR99NZ9LQckF1pUQXw08=
X-Received: by 2002:a67:fb87:: with SMTP id n7mr4097640vsr.9.1562849919143;
 Thu, 11 Jul 2019 05:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562751312.git.amit.kucheria@linaro.org>
 <ed318d093fde671dc0bae0aeb8cf07e56a72cf27.1562751312.git.amit.kucheria@linaro.org>
 <CAJZ5v0hq2yLBOp1OVswS0u-PGOLjq65wfjUqWZB2Tf5oPhOQpQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hq2yLBOp1OVswS0u-PGOLjq65wfjUqWZB2Tf5oPhOQpQ@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 11 Jul 2019 18:28:28 +0530
Message-ID: <CAHLCerNrwzdmyPkjV6_U2OPX0k0hYZbtWN5i=Zp71_qL+tJT_Q@mail.gmail.com>
Subject: Re: [RFC PATCH] PM: QoS: Get rid of unused flags
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 11, 2019 at 5:45 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jul 10, 2019 at 12:12 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
> > The network_latency and network_throughput flags for PM-QoS have not
> > found much use in drivers or in userspace since they were introduced.
> >
> > Commit 4a733ef1bea7 ("mac80211: remove PM-QoS listener") removed the
> > only user PM_QOS_NETWORK_LATENCY in the kernel a while ago and there
> > don't seem to be any userspace tools using the character device files
> > either.
> >
> > PM_QOS_MEMORY_BANDWIDTH was never even added to the trace events.
> >
> > Remove all the flags except cpu_dma_latency.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>
> I agree with the rationale, but the patch will clash with some PM QoS
> changes from Viresh already in linux-next AFAICS.  Can you please
> rebase it on top of that material?

Sure, I'll rebase on linux-next and resend.

> > ---
> > I've looked around for use of /dev/network_throughput and
> > /dev/network_bandwidth) and not found any userspace programs that seem to
> > use this currently. So this shouldn't be breaking our ABI contract with
> > userspace.
> >
> >  Documentation/power/pm_qos_interface.txt |  5 +--
> >  include/linux/pm_qos.h                   |  6 ---
> >  include/trace/events/power.h             |  8 +---
> >  kernel/power/qos.c                       | 48 ------------------------
> >  4 files changed, 4 insertions(+), 63 deletions(-)
> >
> > diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
> > index 19c5f7b1a7bab..ac53ca4ae24e1 100644
> > --- a/Documentation/power/pm_qos_interface.txt
> > +++ b/Documentation/power/pm_qos_interface.txt
> > @@ -5,8 +5,7 @@ performance expectations by drivers, subsystems and user space applications on
> >  one of the parameters.
> >
> >  Two different PM QoS frameworks are available:
> > -1. PM QoS classes for cpu_dma_latency, network_latency, network_throughput,
> > -memory_bandwidth.
> > +1. PM QoS classes for cpu_dma_latency
> >  2. the per-device PM QoS framework provides the API to manage the per-device latency
> >  constraints and PM QoS flags.
> >
> > @@ -74,7 +73,7 @@ cleanup of a process, the interface requires the process to register its
> >  parameter requests in the following way:
> >
> >  To register the default pm_qos target for the specific parameter, the process
> > -must open one of /dev/[cpu_dma_latency, network_latency, network_throughput]
> > +must open /dev/cpu_dma_latency
> >
> >  As long as the device node is held open that process has a registered
> >  request on the parameter.
> > diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> > index 6ea1ae373d77c..2a3c237b1910d 100644
> > --- a/include/linux/pm_qos.h
> > +++ b/include/linux/pm_qos.h
> > @@ -13,9 +13,6 @@
> >  enum {
> >         PM_QOS_RESERVED = 0,
> >         PM_QOS_CPU_DMA_LATENCY,
> > -       PM_QOS_NETWORK_LATENCY,
> > -       PM_QOS_NETWORK_THROUGHPUT,
> > -       PM_QOS_MEMORY_BANDWIDTH,
> >
> >         /* insert new class ID */
> >         PM_QOS_NUM_CLASSES,
> > @@ -33,9 +30,6 @@ enum pm_qos_flags_status {
> >  #define PM_QOS_LATENCY_ANY_NS  ((s64)PM_QOS_LATENCY_ANY * NSEC_PER_USEC)
> >
> >  #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE       (2000 * USEC_PER_SEC)
> > -#define PM_QOS_NETWORK_LAT_DEFAULT_VALUE       (2000 * USEC_PER_SEC)
> > -#define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE        0
> > -#define PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE  0
> >  #define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE    PM_QOS_LATENCY_ANY
> >  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT    PM_QOS_LATENCY_ANY
> >  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS PM_QOS_LATENCY_ANY_NS
> > diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> > index f7aece721aed7..7457e238e1b74 100644
> > --- a/include/trace/events/power.h
> > +++ b/include/trace/events/power.h
> > @@ -379,9 +379,7 @@ DECLARE_EVENT_CLASS(pm_qos_request,
> >
> >         TP_printk("pm_qos_class=%s value=%d",
> >                   __print_symbolic(__entry->pm_qos_class,
> > -                       { PM_QOS_CPU_DMA_LATENCY,       "CPU_DMA_LATENCY" },
> > -                       { PM_QOS_NETWORK_LATENCY,       "NETWORK_LATENCY" },
> > -                       { PM_QOS_NETWORK_THROUGHPUT,    "NETWORK_THROUGHPUT" }),
> > +                       { PM_QOS_CPU_DMA_LATENCY,       "CPU_DMA_LATENCY" }),
> >                   __entry->value)
> >  );
> >
> > @@ -426,9 +424,7 @@ TRACE_EVENT(pm_qos_update_request_timeout,
> >
> >         TP_printk("pm_qos_class=%s value=%d, timeout_us=%ld",
> >                   __print_symbolic(__entry->pm_qos_class,
> > -                       { PM_QOS_CPU_DMA_LATENCY,       "CPU_DMA_LATENCY" },
> > -                       { PM_QOS_NETWORK_LATENCY,       "NETWORK_LATENCY" },
> > -                       { PM_QOS_NETWORK_THROUGHPUT,    "NETWORK_THROUGHPUT" }),
> > +                       { PM_QOS_CPU_DMA_LATENCY,       "CPU_DMA_LATENCY" }),
> >                   __entry->value, __entry->timeout_us)
> >  );
> >
> > diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> > index 33e3febaba53f..9568a2fe7c116 100644
> > --- a/kernel/power/qos.c
> > +++ b/kernel/power/qos.c
> > @@ -78,57 +78,9 @@ static struct pm_qos_object cpu_dma_pm_qos = {
> >         .name = "cpu_dma_latency",
> >  };
> >
> > -static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
> > -static struct pm_qos_constraints network_lat_constraints = {
> > -       .list = PLIST_HEAD_INIT(network_lat_constraints.list),
> > -       .target_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
> > -       .default_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
> > -       .no_constraint_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
> > -       .type = PM_QOS_MIN,
> > -       .notifiers = &network_lat_notifier,
> > -};
> > -static struct pm_qos_object network_lat_pm_qos = {
> > -       .constraints = &network_lat_constraints,
> > -       .name = "network_latency",
> > -};
> > -
> > -
> > -static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
> > -static struct pm_qos_constraints network_tput_constraints = {
> > -       .list = PLIST_HEAD_INIT(network_tput_constraints.list),
> > -       .target_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
> > -       .default_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
> > -       .no_constraint_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
> > -       .type = PM_QOS_MAX,
> > -       .notifiers = &network_throughput_notifier,
> > -};
> > -static struct pm_qos_object network_throughput_pm_qos = {
> > -       .constraints = &network_tput_constraints,
> > -       .name = "network_throughput",
> > -};
> > -
> > -
> > -static BLOCKING_NOTIFIER_HEAD(memory_bandwidth_notifier);
> > -static struct pm_qos_constraints memory_bw_constraints = {
> > -       .list = PLIST_HEAD_INIT(memory_bw_constraints.list),
> > -       .target_value = PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE,
> > -       .default_value = PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE,
> > -       .no_constraint_value = PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE,
> > -       .type = PM_QOS_SUM,
> > -       .notifiers = &memory_bandwidth_notifier,
> > -};
> > -static struct pm_qos_object memory_bandwidth_pm_qos = {
> > -       .constraints = &memory_bw_constraints,
> > -       .name = "memory_bandwidth",
> > -};
> > -
> > -
> >  static struct pm_qos_object *pm_qos_array[] = {
> >         &null_pm_qos,
> >         &cpu_dma_pm_qos,
> > -       &network_lat_pm_qos,
> > -       &network_throughput_pm_qos,
> > -       &memory_bandwidth_pm_qos,
> >  };
> >
> >  static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
> > --
> > 2.17.1
> >
