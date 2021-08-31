Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAAA3FCAE6
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 17:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbhHaPeG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 11:34:06 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:47062 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239158AbhHaPeG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 11:34:06 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Aug 2021 11:34:06 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id EC6011807C27B
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 15:25:46 +0000 (UTC)
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2552C253D4;
        Tue, 31 Aug 2021 15:25:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id D7C6A255100;
        Tue, 31 Aug 2021 15:25:42 +0000 (UTC)
Message-ID: <1c5b485cc9b8836b09f99278233d9dc0ae991da7.camel@perches.com>
Subject: Re: [PATCH V6 1/1] interconnect: intel: Add Keem Bay noc driver
From:   Joe Perches <joe@perches.com>
To:     pandith.n@intel.com, georgi.djakov@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mgross@linux.intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Date:   Tue, 31 Aug 2021 08:25:40 -0700
In-Reply-To: <20210831063615.1021-1-pandith.n@intel.com>
References: <20210831063615.1021-1-pandith.n@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.06
X-Stat-Signature: wrt8d4hktnqgu6mjx4hi8abedwxiz8sx
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: D7C6A255100
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19/Ih3lgzedQTxeHUMZmH61JF8v3mnvv2U=
X-HE-Tag: 1630423542-295277
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-08-31 at 12:06 +0530, pandith.n@intel.com wrote:
> From: Pandith N <pandith.n@intel.com>
> 
> Add support for Network on Chip(NOC) counters. Enable features to configure
> and capture NOC probe counters, needed for DDR bandwidth measurement. NOC
> driver is specific to Intel Keem Bay SOC. NOC hardware counters are used
> for DDR statistics profiling, it is not related to timers.
> Interface details are provided in include/uapi/linux/noc_uapi.h

trivial notes:

> diff --git a/drivers/interconnect/intel/Kconfig b/drivers/interconnect/intel/Kconfig
[]
> +config INTERCONNECT_INTEL_KEEMBAY
> +	tristate "Intel Keem Bay Enable DDR profiling using NOC"
> +	depends on INTERCONNECT_INTEL || ARCH_KEEMBAY || COMPILE_TEST
> +	help
> +	  Enable this option for DDR bandwidth measurements using NOC
> +
> +	  Add support for Network-on-chip (NOC) in DDR Subsystem(DSS).
> +	  DSS NOC has capabilities to enable and get statistics profiling.
> +	  NOC driver enables features to configure and capture NOC probe
> +          counters, needed for DSS bandwidth measurement.

Inconsistent tab/space indentation on this line

> diff --git a/drivers/interconnect/intel/keembay-bwmon.c b/drivers/interconnect/intel/keembay-bwmon.c
[]
> +/**
> + * flex_noc_setup() - Setup two counters for the NOC probe
> + * @noc: NOC type to setup counters
> + * @counter: Counter number to set up counter n and n+1
> + * @trace_port: trace port number to setup counters
> + *
> + * This function will setup the counters for the trace port given.

This seems to be unnecessary kernel-doc and if it is useful,
the return value isn't described.

> +int flex_noc_setup(enum noc_ss_type noc, enum noc_counter counter, int trace_port)
> +{
> +	int offset;
> +
> +	if (noc >= NOC_TYPE_MAX || counter >= NOC_COUNTER_MAX)
> +		return -EINVAL;
> +
> +	offset = f_offset[counter / 2];
> +
> +	/* Stop ongoing stats */
> +	noc_writel(MAINCTL, 0);
> +	noc_writel(CFGCTL, 0);
> +
> +	/* Setup trace port and counters port select */
> +	noc_writel(TRACEPORTSEL, trace_port);
> +	noc_writel((c_offset[counter] + C_PORTSEL), trace_port);

Lots of unnecessary parentheses

> +	noc_writel((c_offset[counter + 1] + C_PORTSEL), trace_port);
> +
> +	/* Setup counter sources & triggers, Alarm mode - OFF */
> +	noc_writel((c_offset[counter] + C_SRC), COUNTERS_0_SRC_VAL);
> +	noc_writel((c_offset[counter] + C_ALARMMODE), COUNTERS_ALARMMODE_VAL);
> +	noc_writel((c_offset[counter + 1] + C_SRC), COUNTERS_1_SRC_VAL);
> +	noc_writel((c_offset[counter + 1] + C_ALARMMODE),
> +		   COUNTERS_ALARMMODE_VAL);

[]

> +enum noc_status flexnoc_counter_capture(enum noc_ss_type noc,
> +					enum noc_counter counter, u32  *value)
> +{
> +	unsigned long j0, j1, delay;
> +	u32 c0_0, c0_1;
> +
> +	if (noc >= NOC_TYPE_MAX ||
> +	    counter >= NOC_COUNTER_MAX  ||
> +	    !value)
> +		return NOC_PROBE_ERR_INVALID_ARGS;
> +
> +	delay = msecs_to_jiffies(NOC_CAPTURE_TIMEOUT_MSEC);
> +	j0 = jiffies;
> +	j1 = j0 + delay;

j0 and j1 seem unnecessary

	timeout = jiffies + msecs_to_jiffies(NOC_CAPTURE_TIMEOUT_MSEC);

> +	do {
> +		c0_0 = noc_readl((c_offset[counter] + C_VAL));
> +		usleep_range(10000, 11000);

Seems a long time.

> +		c0_1 = noc_readl((c_offset[counter] + C_VAL));
> +		/* If mainctrl is zero , return error */
> +		if (noc_readl(MAINCTL) == 0)
> +			return NOC_PROBE_ERR_IN_PROGRESS;
> +		/* If counters are zero, keep reading */
> +		if (0 == c0_0 && 0 == c0_1) {
> +			break;
> +		} else if (c0_0 != c0_1) {
> +			continue;
> +		} else {
> +			/* counters look good break the while */
> +			break;
> +		}
> +	} while (time_before(jiffies, j1));

	} while (time_before(jiffies, timeout);

[]

> +static long noc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct flexnoc_countercapture capture_data;
> +	void __user *argp = (void __user *)arg;
> +	struct flexnoc_probestart probe_data;
> +	struct flexnoc_setup setup_data;
> +	int rc;
> +
> +	if (!arg) {
> +		pr_err("NOC: Null pointer from user\n");

Perhaps useful to add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
near the top of the file.


