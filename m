Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C009CC4E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 11:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbfHZJL6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 05:11:58 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44814 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730670AbfHZJL6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 05:11:58 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 774bfcd347dd994c; Mon, 26 Aug 2019 11:11:25 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PM: QoS: Get rid of unused flags
Date:   Mon, 26 Aug 2019 11:11:24 +0200
Message-ID: <2564741.zVmb8Zpms3@kreacher>
In-Reply-To: <e9e7bc3be3b51e68ae1a0f934c3724bd86f5f9af.1562854650.git.amit.kucheria@linaro.org>
References: <cover.1562854650.git.amit.kucheria@linaro.org> <e9e7bc3be3b51e68ae1a0f934c3724bd86f5f9af.1562854650.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, July 11, 2019 4:21:25 PM CEST Amit Kucheria wrote:
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
> ---
> Changes from v1:
> - Rebased on linux-next to deal with .rst conversion of docs
> 
> I've looked around for use of /dev/network_throughput and
> /dev/network_bandwidth) and not found any userspace programs that seem to
> use this currently. So this shouldn't be breaking our ABI contract with
> userspace.
> 
> 
>  Documentation/power/pm_qos_interface.rst |  5 +--
>  include/linux/pm_qos.h                   |  6 ---
>  include/trace/events/power.h             |  8 +---
>  kernel/power/qos.c                       | 48 ------------------------
>  4 files changed, 4 insertions(+), 63 deletions(-)
> 
> diff --git a/Documentation/power/pm_qos_interface.rst b/Documentation/power/pm_qos_interface.rst
> index 945fc6d760c9..a00d607107ec 100644
> --- a/Documentation/power/pm_qos_interface.rst
> +++ b/Documentation/power/pm_qos_interface.rst
> @@ -7,8 +7,7 @@ performance expectations by drivers, subsystems and user space applications on
>  one of the parameters.
>  
>  Two different PM QoS frameworks are available:
> -1. PM QoS classes for cpu_dma_latency, network_latency, network_throughput,
> -memory_bandwidth.
> +1. PM QoS classes for cpu_dma_latency
>  2. the per-device PM QoS framework provides the API to manage the per-device latency
>  constraints and PM QoS flags.
>  
> @@ -79,7 +78,7 @@ cleanup of a process, the interface requires the process to register its
>  parameter requests in the following way:
>  
>  To register the default pm_qos target for the specific parameter, the process
> -must open one of /dev/[cpu_dma_latency, network_latency, network_throughput]
> +must open /dev/cpu_dma_latency
>  
>  As long as the device node is held open that process has a registered
>  request on the parameter.
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 6ea1ae373d77..2a3c237b1910 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -13,9 +13,6 @@
>  enum {
>  	PM_QOS_RESERVED = 0,
>  	PM_QOS_CPU_DMA_LATENCY,
> -	PM_QOS_NETWORK_LATENCY,
> -	PM_QOS_NETWORK_THROUGHPUT,
> -	PM_QOS_MEMORY_BANDWIDTH,
>  
>  	/* insert new class ID */
>  	PM_QOS_NUM_CLASSES,
> @@ -33,9 +30,6 @@ enum pm_qos_flags_status {
>  #define PM_QOS_LATENCY_ANY_NS	((s64)PM_QOS_LATENCY_ANY * NSEC_PER_USEC)
>  
>  #define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
> -#define PM_QOS_NETWORK_LAT_DEFAULT_VALUE	(2000 * USEC_PER_SEC)
> -#define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE	0
> -#define PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE	0
>  #define PM_QOS_RESUME_LATENCY_DEFAULT_VALUE	PM_QOS_LATENCY_ANY
>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT	PM_QOS_LATENCY_ANY
>  #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS	PM_QOS_LATENCY_ANY_NS
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index f7aece721aed..7457e238e1b7 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -379,9 +379,7 @@ DECLARE_EVENT_CLASS(pm_qos_request,
>  
>  	TP_printk("pm_qos_class=%s value=%d",
>  		  __print_symbolic(__entry->pm_qos_class,
> -			{ PM_QOS_CPU_DMA_LATENCY,	"CPU_DMA_LATENCY" },
> -			{ PM_QOS_NETWORK_LATENCY,	"NETWORK_LATENCY" },
> -			{ PM_QOS_NETWORK_THROUGHPUT,	"NETWORK_THROUGHPUT" }),
> +			{ PM_QOS_CPU_DMA_LATENCY,	"CPU_DMA_LATENCY" }),
>  		  __entry->value)
>  );
>  
> @@ -426,9 +424,7 @@ TRACE_EVENT(pm_qos_update_request_timeout,
>  
>  	TP_printk("pm_qos_class=%s value=%d, timeout_us=%ld",
>  		  __print_symbolic(__entry->pm_qos_class,
> -			{ PM_QOS_CPU_DMA_LATENCY,	"CPU_DMA_LATENCY" },
> -			{ PM_QOS_NETWORK_LATENCY,	"NETWORK_LATENCY" },
> -			{ PM_QOS_NETWORK_THROUGHPUT,	"NETWORK_THROUGHPUT" }),
> +			{ PM_QOS_CPU_DMA_LATENCY,	"CPU_DMA_LATENCY" }),
>  		  __entry->value, __entry->timeout_us)
>  );
>  
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 33e3febaba53..9568a2fe7c11 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -78,57 +78,9 @@ static struct pm_qos_object cpu_dma_pm_qos = {
>  	.name = "cpu_dma_latency",
>  };
>  
> -static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
> -static struct pm_qos_constraints network_lat_constraints = {
> -	.list = PLIST_HEAD_INIT(network_lat_constraints.list),
> -	.target_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
> -	.default_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
> -	.no_constraint_value = PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
> -	.type = PM_QOS_MIN,
> -	.notifiers = &network_lat_notifier,
> -};
> -static struct pm_qos_object network_lat_pm_qos = {
> -	.constraints = &network_lat_constraints,
> -	.name = "network_latency",
> -};
> -
> -
> -static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
> -static struct pm_qos_constraints network_tput_constraints = {
> -	.list = PLIST_HEAD_INIT(network_tput_constraints.list),
> -	.target_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
> -	.default_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
> -	.no_constraint_value = PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
> -	.type = PM_QOS_MAX,
> -	.notifiers = &network_throughput_notifier,
> -};
> -static struct pm_qos_object network_throughput_pm_qos = {
> -	.constraints = &network_tput_constraints,
> -	.name = "network_throughput",
> -};
> -
> -
> -static BLOCKING_NOTIFIER_HEAD(memory_bandwidth_notifier);
> -static struct pm_qos_constraints memory_bw_constraints = {
> -	.list = PLIST_HEAD_INIT(memory_bw_constraints.list),
> -	.target_value = PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE,
> -	.default_value = PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE,
> -	.no_constraint_value = PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE,
> -	.type = PM_QOS_SUM,
> -	.notifiers = &memory_bandwidth_notifier,
> -};
> -static struct pm_qos_object memory_bandwidth_pm_qos = {
> -	.constraints = &memory_bw_constraints,
> -	.name = "memory_bandwidth",
> -};
> -
> -
>  static struct pm_qos_object *pm_qos_array[] = {
>  	&null_pm_qos,
>  	&cpu_dma_pm_qos,
> -	&network_lat_pm_qos,
> -	&network_throughput_pm_qos,
> -	&memory_bandwidth_pm_qos,
>  };
>  
>  static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
> 

Applied, thanks!




