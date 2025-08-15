Return-Path: <linux-pm+bounces-32425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83CB27A92
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 10:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0458EAE2AC5
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 08:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330622451F0;
	Fri, 15 Aug 2025 08:08:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0304027713;
	Fri, 15 Aug 2025 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245332; cv=none; b=FdY4ld1hNUjSr6QelmIa4N8vfoWAlJqAMwXY6idSuTNSL2NUsCq86AJ405vQ7LyE2gzRMjlygeWiBzgw7PSlEtYwCCIqdRsH3jYxwDF9STxjuqTYyBO6GasKN2dfPi6jfnFlnbSwhmBe2mnpLsrxXnnYu7+h86EpnWqNjZJba/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245332; c=relaxed/simple;
	bh=40fD8nbq/dWtvqI1KOI36Ogw4sIwgQnynO/0TfAhQsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GquU5SYSOQHNVWP9XcbHrbyVIywahQkEFi0NyFzAYLUcW7DEuoQtxqSBaSprkWygvs5V3w2kiyLSkQvdWpx5Zbr94oUidATf9OegFOooqWmwGw0jVg1XdxsISsSStWWXsFcpxD04AzK9gbwI9ZHvth5f3exmxFTXuk2Jf9m/eQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3E1C1C25;
	Fri, 15 Aug 2025 01:08:40 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B89E3F738;
	Fri, 15 Aug 2025 01:08:46 -0700 (PDT)
Date: Fri, 15 Aug 2025 09:08:38 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, james.quinlan@broadcom.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Peng Fan <peng.fan@nxp.com>,
	Mike Tipton <quic_mdtipton@quicinc.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scmi: Add quirk to disable checks in
 scmi_dev_used_by_cpus()
Message-ID: <aJ7rBgce5eWSkkk3@pluto>
References: <20250814225155.3519000-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814225155.3519000-1-florian.fainelli@broadcom.com>

On Thu, Aug 14, 2025 at 03:51:55PM -0700, Florian Fainelli wrote:
> Broadcom STB platforms were early adopters of the SCMI framework and as
> a result, not all deployed systems have a Device Tree entry where SCMI
> protocol 0x13 (PERFORMANCE) is declared as a clock provider, nor are the
> CPU Device Tree node(s) referencing protocol 0x13 as their clock
> provider.
> 
> Leverage the quirks framework recently introduce to match on the
> Broadcom SCMI vendor and in that case, disable the Device Tree
> properties checks being done by scmi_dev_used_by_cpus().
> 

Hi,

> Suggested-by: Cristian Marussi <cristian.marussi@arm.com>
> Fixes: 6c9bb8692272 ("cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c     | 13 +++++++++++++
>  drivers/firmware/arm_scmi/quirks.c |  2 ++
>  drivers/firmware/arm_scmi/quirks.h |  1 +
>  3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index ef078426bfd5..80647511d3c3 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -22,6 +22,8 @@
>  #include <linux/types.h>
>  #include <linux/units.h>
>  
> +#include "../drivers/firmware/arm_scmi/quirks.h"
> +

I will post a patch to move this header up to avoid the uglyness of this
include....

>  struct scmi_data {
>  	int domain_id;
>  	int nr_opp;
> @@ -34,6 +36,7 @@ struct scmi_data {
>  static struct scmi_protocol_handle *ph;
>  static const struct scmi_perf_proto_ops *perf_ops;
>  static struct cpufreq_driver scmi_cpufreq_driver;
> +static bool __maybe_unused scmi_cpufreq_dt_props_check_disable;
>  

Not sure why you introduce an intermediate global bool to check...this
defeats a bit the whole idea of the quirks framework which is based on
static_keys and is supposed to be mostly transarent when quirks are not
enabled....

Couldn't you just move the quirk inside the get_rate ?
(maybe I am missing something around compiler behaviours..)
 
#define QUIRK_SCMI_CPUFREQ_CHECK_DT_PROPS		\
({							\
	if (true)					\
		return true;				\
})

>  static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
>  {
> @@ -400,6 +403,9 @@ static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
>  	struct device *cpu_dev;
>  	int cpu, idx;
>  

+	SCMI_QUIRK(scmi_cpufreq_no_check_dt_props, QUIRK_SCMI_CPUFREQ_CHECK_DT_PROPS);

>  	if (!scmi_np)
>  		return false;
>  
> @@ -427,12 +433,19 @@ static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
>  	return false;
>  }
>  
> +#define QUIRK_SCMI_CPUFREQ_CHECK_DT_PROPS			\
> +	({							\
> +		scmi_cpufreq_dt_props_check_disable = true;	\
> +	})
> +
>  static int scmi_cpufreq_probe(struct scmi_device *sdev)
>  {
>  	int ret;
>  	struct device *dev = &sdev->dev;
>  	const struct scmi_handle *handle;
>  

> +	SCMI_QUIRK(scmi_cpufreq_no_check_dt_props, QUIRK_SCMI_CPUFREQ_CHECK_DT_PROPS);
> +

...removing this of course

>  	handle = sdev->handle;
>  
>  	if (!handle || !scmi_dev_used_by_cpus(dev))
> diff --git a/drivers/firmware/arm_scmi/quirks.c b/drivers/firmware/arm_scmi/quirks.c
> index 03960aca3610..aafc7b4b3294 100644
> --- a/drivers/firmware/arm_scmi/quirks.c
> +++ b/drivers/firmware/arm_scmi/quirks.c
> @@ -171,6 +171,7 @@ struct scmi_quirk {
>  /* Global Quirks Definitions */
>  DEFINE_SCMI_QUIRK(clock_rates_triplet_out_of_spec, NULL, NULL, NULL);
>  DEFINE_SCMI_QUIRK(perf_level_get_fc_force, "Qualcomm", NULL, "0x20000-");
> +DEFINE_SCMI_QUIRK_EXPORTED(scmi_cpufreq_no_check_dt_props, "brcm-scmi", NULL, "0x2");

Also, are you sure about using version as "0x2" ? That is supposed to
indicate the (optional) SCMI FW Version to which this quirk will
apply...and with that it means whatever FW versioning you use in
Broadcom to identify build versions....it is NOT the SCMI Protocol
Version, so that also means that if/when you will change the advertised
version, this quirk wont apply anymore...or equally if there are older
version than 0x2 that are buggy they wont be quirked...

One more doubt I have (despite me having suggested this solution) is
that here you are quirking against a malformed deployed DT really,
not against some SCMI FW anomaly in the Broadcom FW, but using the
SCMI Quirks framework you are tying the quirk to the SCMI FW Vendor
and maybe some specific SCMI FW Version....

...so what will happen when you will update/fix your DT in the future ?
Will you also take care to bump the BRCM SCMI FW version to disable the
quirk in the DT deployed by your FW binary ?

Thanks,
Cristian

