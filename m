Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E036568A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 14:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfGKMPV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 08:15:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43432 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfGKMPU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 08:15:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id w79so4284319oif.10;
        Thu, 11 Jul 2019 05:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13tAYVAzEeE1jz6kXjnZWkMBObht4qqKsVB3VpRfnmE=;
        b=h4jTkF9CLzzuS4TXQukHKhEIQpXpqSEo7LIbRXmgDKptyn2z9KwPdMbnKnupHzlNnc
         hgex/j3kKelo7sJmYWtYxriy7i6vtEOHxVOfcOVwrt3Bixqltg9tGSoYH9Cc60QBsaaa
         HV5kuuRwHA8lkkvm7L6Ge7N+66Q6eSLHnxoO8z15OqRQqLN6Ux/dYOQLqmnSthDZuP13
         dLC27zwL/MQslbKUnUje/OgoJNJh7Ooh6rHQFdBKVk7niZ2cl8ORdwvcYD73fFQ81S+e
         3XhKyJfAtP6Pw/NeX9b9bXK1XMxmJ3K+sbgvnKOIJkZlsMB2hjEPlFvV3KWaHJOMnvXi
         2VKA==
X-Gm-Message-State: APjAAAUxWAjNXN3Mltsj5cqliA8ma20XoR7lvhzbRfDe/oqLTpvRfJFP
        S/5JhtIM+xRIpxEzPN9PlNPrsCqyNgrRSx/Y5sY=
X-Google-Smtp-Source: APXvYqzdK2CQq61826CRbr01vnBj/ymkGOHfnIRoa/RscJQcUVrYJmXWq7QIWSPEn3cOdkau8BJBSnKIwFvFLEFuW4g=
X-Received: by 2002:aca:cdd3:: with SMTP id d202mr1947808oig.115.1562847319746;
 Thu, 11 Jul 2019 05:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562751312.git.amit.kucheria@linaro.org> <ed318d093fde671dc0bae0aeb8cf07e56a72cf27.1562751312.git.amit.kucheria@linaro.org>
In-Reply-To: <ed318d093fde671dc0bae0aeb8cf07e56a72cf27.1562751312.git.amit.kucheria@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 Jul 2019 14:15:08 +0200
Message-ID: <CAJZ5v0hq2yLBOp1OVswS0u-PGOLjq65wfjUqWZB2Tf5oPhOQpQ@mail.gmail.com>
Subject: Re: [RFC PATCH] PM: QoS: Get rid of unused flags
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 10, 2019 at 12:12 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> The network_latency and network_throughput flags for PM-QoS have not
> found much use in drivers or in userspace since they were introduced.
>
> Commit 4a733ef1bea7 ("mac80211: remove PM-QoS listener") removed the
> only user PM_QOS_NETWORK_LATENCY in the kernel a while ago and there
> don't seem to be any userspace tools using the character device files
> either.
>
> PM_QOS_MEMORY_BANDWIDTH was never even added to the trace events.
>
> Remove all the flags except cpu_dma_latency.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

I agree with the rationale, but the patch will clash with some PM QoS
changes from Viresh already in linux-next AFAICS.  Can you please
rebase it on top of that material?

> ---
> I've looked around for use of /dev/network_throughput and
> /dev/network_bandwidth) and not found any userspace programs that seem to
> use this currently. So this shouldn't be breaking our ABI contract with
> userspace.
>
>  Documentation/power/pm_qos_interface.txt |  5 +--
>  include/linux/pm_qos.h                   |  6 ---
>  include/trace/events/power.h             |  8 +---
>  kernel/power/qos.c                       | 48 ------------------------
>  4 files changed, 4 insertions(+), 63 deletions(-)
>
> diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
> index 19c5f7b1a7bab..ac53ca4ae24e1 100644
> --- a/Documentation/power/pm_qos_interface.txt
> +++ b/Documentation/power/pm_qos_interface.txt
> @@ -5,8 +5,7 @@ performance expectations by drivers, subsystems and user space applications on
>  one of the parameters.
>
>  Two different PM QoS frameworks are available:
> -1. PM QoS classes for cpu_dma_latency, network_latency, network_throughput,
> -memory_bandwidth.
> +1. PM QoS classes for cpu_dma_latency
>  2. the per-device PM QoS framework provides the API to manage the per-device latency
>  constraints and PM QoS flags.
>
> @@ -74,7 +73,7 @@ cleanup of a process, the interface requires the process to register its
>  parameter requests in the following way:
>
>  To register the default pm_qos target for the specific parameter, the process
> -must open one of /dev/[cpu_dma_latency, network_latency, network_throughput]
> +must open /dev/cpu_dma_latency
>
>  As long as the device node is held open that process has a registered
>  request on the parameter.
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 6ea1ae373d77c..2a3c237b1910d 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -13,9 +13,6 @@
>  enum {
>         PM_QOS_RESERVED = 0,
>         PM_QOS_CPU_DMA_LATENCY,
> -       PM_QOS_NETWORK_LATENCY,
> -       PM_QOS_NETWORK_THROUGHPUT,
> -       PM_QOS_MEMORY_BANDWIDTH,
>
>         /* insert new class ID */
>         PM_QOS_NUM_CLASSES,
> @@ -33,9 +30,6 @@ enum pm_qos_flags_status {
>  #define PM_QOS_LATENCY_ANY_NS  ((s64)PM_QOS_LATENCY_ANY * NSEC_PER_USEC)
>
>  #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE       (2000 * USEC_PER_SEC)
> -#define PM_QOS_NETWORK_LAT_DEFAULT_VALUE       (2000 * USEC_PER_SEC)
> -#define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE        0
> -#define PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE  0
>  #define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE    PM_QOS_LATENCY_ANY
>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT    PM_QOS_LATENCY_ANY
>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS PM_QOS_LATENCY_ANY_NS
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index f7aece721aed7..7457e238e1b74 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -379,9 +379,7 @@ DECLARE_EVENT_CLASS(pm_qos_request,
>
>         TP_printk("pm_qos_class=%s value=%d",
>                   __print_symbolic(__entry->pm_qos_class,
> -                       { PM_QOS_CPU_DMA_LATENCY,       "CPU_DMA_LATENCY" },
> -                       { PM_QOS_NETWORK_LATENCY,       "NETWORK_LATENCY" },
> -                       { PM_QOS_NETWORK_THROUGHPUT,    "NETWORK_THROUGHPUT" }),
> +                       { PM_QOS_CPU_DMA_LATENCY,       "CPU_DMA_LATENCY" }),
>                   __entry->value)
>  );
>
> @@ -426,9 +424,7 @@ TRACE_EVENT(pm_qos_update_request_timeout,
>
>         TP_printk("pm_qos_class=%s value=%d, timeout_us=%ld",
>                   __print_symbolic(__entry->pm_qos_class,
> -                       { PM_QOS_CPU_DMA_LATENCY,       "CPU_DMA_LATENCY" },
> -                       { PM_QOS_NETWORK_LATENCY,       "NETWORK_LATENCY" },
> -                       { PM_QOS_NETWORK_THROUGHPUT,    "NETWORK_THROUGHPUT" }),
> +                       { PM_QOS_CPU_DMA_LATENCY,       "CPU_DMA_LATENCY" }),
>                   __entry->value, __entry->timeout_us)
>  );
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 33e3febaba53f..9568a2fe7c116 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -78,57 +78,9 @@ static struct pm_qos_object cpu_dma_pm_qos = {
>         .name = "cpu_dma_latency",
>  };
>
> -static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
> -static struct pm_qos_constraints network_lat_constraints = {
> -       .list = PLIST_HEAD_INIT(network_lat_constraints.list),
> -       .target_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
> -       .default_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
> -       .no_constraint_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
> -       .type = PM_QOS_MIN,
> -       .notifiers = &network_lat_notifier,
> -};
> -static struct pm_qos_object network_lat_pm_qos = {
> -       .constraints = &network_lat_constraints,
> -       .name = "network_latency",
> -};
> -
> -
> -static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
> -static struct pm_qos_constraints network_tput_constraints = {
> -       .list = PLIST_HEAD_INIT(network_tput_constraints.list),
> -       .target_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
> -       .default_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
> -       .no_constraint_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
> -       .type = PM_QOS_MAX,
> -       .notifiers = &network_throughput_notifier,
> -};
> -static struct pm_qos_object network_throughput_pm_qos = {
> -       .constraints = &network_tput_constraints,
> -       .name = "network_throughput",
> -};
> -
> -
> -static BLOCKING_NOTIFIER_HEAD(memory_bandwidth_notifier);
> -static struct pm_qos_constraints memory_bw_constraints = {
> -       .list = PLIST_HEAD_INIT(memory_bw_constraints.list),
> -       .target_value = PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE,
> -       .default_value = PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE,
> -       .no_constraint_value = PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE,
> -       .type = PM_QOS_SUM,
> -       .notifiers = &memory_bandwidth_notifier,
> -};
> -static struct pm_qos_object memory_bandwidth_pm_qos = {
> -       .constraints = &memory_bw_constraints,
> -       .name = "memory_bandwidth",
> -};
> -
> -
>  static struct pm_qos_object *pm_qos_array[] = {
>         &null_pm_qos,
>         &cpu_dma_pm_qos,
> -       &network_lat_pm_qos,
> -       &network_throughput_pm_qos,
> -       &memory_bandwidth_pm_qos,
>  };
>
>  static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
> --
> 2.17.1
>
