Return-Path: <linux-pm+bounces-38001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C14C5A206
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 22:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9628B354102
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 21:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A972B321426;
	Thu, 13 Nov 2025 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/b2DECE"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8462C3245;
	Thu, 13 Nov 2025 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069518; cv=none; b=nU/fxppe47IpvVWai9+j4pQor3Wxfn4SpR0WgFWmIcfneUZixPDVF8mzPnZ69EHScLUOti88Z+56kGLo7j5kSZQoKlQYvVUJOozwtOT0dZF0NMImc+8oLaUQLz3tSkhKpLr2mo6Y7cNznk7IzxFReKDbJD9+Z9RmmXUWjlf0oIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069518; c=relaxed/simple;
	bh=1PaNgAsE4bV2pPD0GaIKW/6uLJLfI8nyo88kMzvuR00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haEMdOE5ZZsaNFJSsWL3r/4gU8bPAq+EYf6YPSnGtPdcf442gWJUhCrpkJgobd006VFY2ox/5MPrOR987tiogYuk8PAlblkARLB3VhPsN1co7yt+IEY3wB9qKlZ+Ufr7Fbmnrhg64BaTbB4ki7N/LsfXPPdSVMw54RWrCLiPByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s/b2DECE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=jJ0AzZvghoJNG8jFkrIba86SzrfhhDCl7SANiuJAqy0=; b=s/b2DECEbQS3rWr/ybTNMaU3hn
	iznyM3PeXw6MpIifJffTPC1uqu+Q6zdjolyJftDmQT2Ef+SRm0wtccOS2DKC0Cv76n7m81n5K7aVH
	ydonr19Nj0mDukH+x/CQ7pgYxvExHl0g6Jg6QfG10voAb3bfFCNmGH6CZNImXCV4cCqISMjSRfGnR
	welnwI5r2MENNBvqJygeWe4Sbem0NoFo2e6thcLK3YCtRwFDWaFpiza8xXJComp9QczNVKsJNDgEx
	bW091ZwTyJSPXP6ZujCEDrV+KHlkM2y82lSpV087idp/6OpZRxXJw+V0JCv1v3+uBliwNap7Hrl5K
	KVtqtnRw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJev4-0000000B8Ej-22te;
	Thu, 13 Nov 2025 21:31:54 +0000
Message-ID: <b5d51b80-2d9f-498d-b4eb-6b1ccd4bbbbe@infradead.org>
Date: Thu, 13 Nov 2025 13:31:54 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: thermal: Add documentation for thermal
 throttle
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 rafael@kernel.org, daniel.lezcano@linaro.org
Cc: corbet@lwn.net, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251113212104.221632-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251113212104.221632-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/13/25 1:21 PM, Srinivas Pandruvada wrote:
> Add documentation for Intel thermal throttling reporting events.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> v2:
>  - Addressed comments from Rafael
>  - Limit line lengths ~80 columns
> 
>  Documentation/admin-guide/thermal/index.rst   |  1 +
>  .../admin-guide/thermal/thermal_throttle.rst  | 92 +++++++++++++++++++
>  2 files changed, 93 insertions(+)
>  create mode 100644 Documentation/admin-guide/thermal/thermal_throttle.rst
> 
> diff --git a/Documentation/admin-guide/thermal/index.rst b/Documentation/admin-guide/thermal/index.rst
> index 193b7b01a87d..2e0cafd19f6b 100644
> --- a/Documentation/admin-guide/thermal/index.rst
> +++ b/Documentation/admin-guide/thermal/index.rst
> @@ -6,3 +6,4 @@ Thermal Subsystem
>     :maxdepth: 1
>  
>     intel_powerclamp
> +   thermal_throttle
> diff --git a/Documentation/admin-guide/thermal/thermal_throttle.rst b/Documentation/admin-guide/thermal/thermal_throttle.rst
> new file mode 100644
> index 000000000000..cac2bc3176ce
> --- /dev/null
> +++ b/Documentation/admin-guide/thermal/thermal_throttle.rst
> @@ -0,0 +1,92 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +=======================================
> +Intel thermal throttle events reporting
> +=======================================
> +
> +:Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> +
> +Introduction
> +------------
> +
> +Intel processors have built in automatic and adaptive thermal monitoring
> +mechanisms that force the processor to reduce its power consumption in order
> +to operate within predetermined temperature limits.
> +
> +Refer to section "THERMAL MONITORING AND PROTECTION" in the "Intel® 64 and
> +IA-32 Architectures Software Developer’s Manual Volume 3 (3A, 3B, 3C, & 3D):
> +System Programming Guide" for more details.
> +
> +In general, there are two mechanisms to control the core temperature of the
> +processor. They are called "Thermal Monitor 1 (TM1) and Thermal Monitor 2 (TM2)".
> +
> +The status of the temperature sensor that triggers the thermal monitor (TM1/TM2)
> +is indicated through the "thermal status flag" and "thermal status log flag" in
> +the MSR_IA32_THERM_STATUS for core level and MSR_IA32_PACKAGE_THERM_STATUS for
> +package level.
> +
> +Thermal Status flag, bit 0 — When set, indicates that the processor core
> +temperature is currently at the trip temperature of the thermal monitor and that
> +the processor power consumption is being reduced via either TM1 or TM2, depending
> +on which is enabled. When clear, the flag indicates that the core temperature is
> +below the thermal monitor trip temperature. This flag is read only.
> +
> +Thermal Status Log flag, bit 1 — When set, indicates that the thermal sensor has
> +tripped since the last power-up or reset or since the last time that software
> +cleared this flag. This flag is a sticky bit; once set it remains set until
> +cleared by software or until a power-up or reset of the processor. The default
> +state is clear.
> +
> +It is possible that when user reads MSR_IA32_THERM_STATUS or
> +MSR_IA32_PACKAGE_THERM_STATUS, TM1/TM2 is not active. In this case,
> +"Thermal Status flag" will read "0" and the "Thermal Status Log flag" will be set
> +to show any previous "TM1/TM2" activation. But since it needs to be cleared by
> +the software, it can't show the number of occurrences of "TM1/TM2" activations.
> +
> +Hence, Linux provides counters of how many times the "Thermal Status flag" was
> +set. Also presents how long the "Thermal Status flag" was active in milliseconds.
> +Using these counters, users can check if the performance was limited because of
> +thermal events. It is recommended to read from sysfs instead of directly reading
> +MSRs as the "Thermal Status Log flag" is reset by the driver to implement rate
> +control.
> +
> +Sysfs Interface
> +---------------
> +
> +Thermal throttling events are presented for each CPU under
> +"/sys/devices/system/cpu/cpuX/thermal_throttle/", where "X" is the CPU number.
> +
> +All these counters are read-only. They can't be reset to 0. So, they can potentially
> +overflow after reaching the maximum 64 bit unsigned integer.
> +
> +``core_throttle_count``
> +	This shows number of times "Thermal Status flag" changed from 0 to 1 for this
> +	CPU since OS boot and thermal vector is initialized. This is a 64 bit counter.
> +
> +``package_throttle_count``
> +	This shows number of times "Thermal Status flag" changed from 0 to 1 for the
> +	package containing this CPU since OS boot and thermal vector is initialized.
> +	Package status is broadcast to all CPUs; all CPUs in the package increment
> +	this count. This is a 64-bit counter.
> +
> +``core_throttle_max_time_ms``
> +	This shows the maximum amount of time for which "Thermal Status flag"
> +	has been set to 1 for this CPU at the core level since OS boot and thermal
> +	vector is initialized.
> +
> +``package_throttle_max_time_ms``
> +	This shows the maximum amount of time for which "Thermal Status flag"
> +	has been set to 1 for the package containing this CPU since OS boot and
> +	thermal vector is initialized.
> +
> +``core_throttle_total_time_ms``
> +	This shows the cumulative time for which "Thermal Status flag" has been
> +	set to 1 for this CPU for core level since OS boot and thermal vector
> +	is initialized.
> +
> +``package_throttle_total_time_ms``
> +	This shows the cumulative time for which "Thermal Status flag" has been set
> +	to 1 for the package containing this CPU since OS boot and thermal vector is
> +	initialized.
> +

-- 
~Randy

