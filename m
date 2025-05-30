Return-Path: <linux-pm+bounces-27858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4435AAC8D66
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 14:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCA03B4317
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 12:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136DF21C9EE;
	Fri, 30 May 2025 12:15:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C2138DF9;
	Fri, 30 May 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748607346; cv=none; b=kH1ks4jC3wbX5cHMX7KBSBKaAjrDUrHoPxo1fOjk7DJSBt7GQsHaXqede7+aBDvJCtxY2bssL93kOxhZVKlCYhUGxXRl9m+3Y6WfU3COoS+RRUsYG1prv7WOwpkVrJW4p9cXFTW+l645NT8OVN9SOKW93QpIdM1dWng10K5lXWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748607346; c=relaxed/simple;
	bh=lKh1MaLoHTuWz4bXZAs1UoSFb+4z9JDbRlsE434QzHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAkwajP2GdLHP0vgbCV2IDtuzNVsFjd4i/Me+uPRcgFE7jZKTJICkaITcHKWOow45LQfbPuY+c7whsFigm/OE4Z0cl2tHWIW5PMnIT3JkXJ8BjKv4S4a+uCG5b2CnEBzOI4/wqWdla3yTDlQfRyO+9iiAZ2Ryu0ArvzlhwK9rJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D31616F2;
	Fri, 30 May 2025 05:15:26 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78BF93F673;
	Fri, 30 May 2025 05:15:41 -0700 (PDT)
Date: Fri, 30 May 2025 13:15:29 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, sudeep.holla@arm.com,
	Ulf Hansson <ulf.hansson@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pmdomain: arm: scmi_pm_domain: Do lazy init as part
 of probe
Message-ID: <aDmhYZydu5UlTxF1@pluto>
References: <20250530103527.2244951-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530103527.2244951-1-d-gole@ti.com>

On Fri, May 30, 2025 at 04:05:27PM +0530, Dhruva Gole wrote:
> Optimize the SCMI power domain driver to only initialize domains that are
> actually referenced in the device tree. Previously, the driver would
> initialize all possible domains up to the maximum ID, which could lead to
> unnecessary firmware calls and longer probe times.

Hi Dhruva,

this in general mostly fine to me.

> 
> Key changes:
> - Scan device tree to identify which power domains are actually referenced
> - Use bitmap to track needed domains instead of initializing all
> - Only perform state queries and initialization for referenced domains
> - Maintain proper array sizing for power domain framework compatibility
> - Keep full provider structure to support late binding
> 
> This optimization reduces probe time and unnecessary firmware interactions
> by only initializing power domains that are actually used in the system.
> For example, in a system with 100 possible domains but only 3 referenced
> in the device tree, we now only initialize those 3 domains instead of
> all 100.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> Hi all,
> The approach of doing a lazy init was briefly proposed in this [1] 2024
> Embedded Open Source talk. It was also brought up in the monthly ARM
> SCMI meetings that take place and it didn't recieve too much opposition.
> 
> This greatly helps to improve the boot time, and I have some data to
> back this up as well. This[2] experiment was done on a TI AM62L SoC
> (which is yet to make it upstream) to measure the time taken in the scmi
> pm domain probe function when it does a full 0..N scmi pd init vs just
> the ones being used in the device tree.
> 
> If you have any feedback on this, please let me know. If not, I will go
> ahead and post a "non-RFC" patch assuming everyone is mostly on board
> with this. Also request other SCMI consumers to test this out as much as
> possible to see if it breaks in any situations.

I'll post a few minor remarks on the upcoming non-RFC.

Thanks,
Cristian

