Return-Path: <linux-pm+bounces-27890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 421FBAC939B
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 18:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78502A42940
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8231A314D;
	Fri, 30 May 2025 16:31:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA0260DCF;
	Fri, 30 May 2025 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748622677; cv=none; b=aeY2w4KcpaLNnO0cZEIWxu+++mm0pfcXIMbeFQakcx4ZUy6FPpu5rtJNsNTOv6aQr17DhdPuiekwSwqMMGzXeXBPTocZlnfun6IzmQAPneWLPIOCkKXZpOhTRY2PmzdCH96YJMVAqEsMw2yLX3kHq0bkrmDDWSNH70pgox7D6sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748622677; c=relaxed/simple;
	bh=h7WSdEUjvaNh2gxuZQVQRFKNgRhta3p8CfQOFKUI8l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRzfrTiCsBi0+jsspUGe6CIwt0neXOia0MU0i0NnVw0aJY4lF5qIURg2EZHKlKNVo58oZemc3VlkiMEJhTh2nU6N1e6ybPzS+nYRulZrC47bx8icRSApTTZvU0TtVtSDyVsY0XJSIOIdYClEWokT/b3EsLNeVXeHV4H+rcgMWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA0ED1424;
	Fri, 30 May 2025 09:30:58 -0700 (PDT)
Received: from bogus (unknown [10.57.47.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE6813F673;
	Fri, 30 May 2025 09:31:13 -0700 (PDT)
Date: Fri, 30 May 2025 17:31:08 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pmdomain: arm: scmi_pm_domain: Do lazy init as part
 of probe
Message-ID: <20250530-honest-chital-of-growth-db31e1@sudeepholla>
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
> 
> Key changes:
> - Scan device tree to identify which power domains are actually referenced

How do this work with runtime DT overlays ?

> - Use bitmap to track needed domains instead of initializing all
> - Only perform state queries and initialization for referenced domains
> - Maintain proper array sizing for power domain framework compatibility
> - Keep full provider structure to support late binding
> 
> This optimization reduces probe time and unnecessary firmware interactions
> by only initializing power domains that are actually used in the system.

Why is this very specific to power domains only ? This must apply for other
domains like perf or clock or reset ?

> For example, in a system with 100 possible domains but only 3 referenced
> in the device tree, we now only initialize those 3 domains instead of
> all 100.
> 

Well, how much of these PD will get used in the final products ? I can
understand the need to use just 3 in devel platforms. Just trying to see
how realistic is the scenario ? Is there any other optimisation possible
from the firmware ? Does getting the state of a PD takes so much time
on the platform in question ?

> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> Hi all,
> The approach of doing a lazy init was briefly proposed in this [1] 2024
> Embedded Open Source talk. It was also brought up in the monthly ARM
> SCMI meetings that take place and it didn't recieve too much opposition.
> 

Sorry, I must have missed that one.

-- 
Regards,
Sudeep

