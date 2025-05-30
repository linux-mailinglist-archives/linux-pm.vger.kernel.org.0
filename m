Return-Path: <linux-pm+bounces-27891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC5BAC93B4
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 18:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64121C2117B
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8703D1B85FD;
	Fri, 30 May 2025 16:37:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E65C258A;
	Fri, 30 May 2025 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623047; cv=none; b=RBPW9xbfCOhI/Kk9VZqn+6Vo2OxUEWovW+5Gb6F+0mHBbsyPiHdvIyy08eAKCEeHrlNiQpSelRS3Nx31tjzDKE/uqRKxvAEi88+merwpDrn8UH+Ndi9o+bt6EMQybKXw6QGgrKBL4dPUs5lwKosJoe5m4KSvEbO2HHq/wtX0ieU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623047; c=relaxed/simple;
	bh=8SZJR1MfPVisJg+h/AnBC8D7GE/X1xIn1GnI5EXN2RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmBDdp5AlIYlBgYK/S8S/qIKVBFdUJu44Kh/QAcqBUYHrdyRyXO/Qx/e56Xqcn+gS/U1BoiylK5QQYoveNGHY3MFbik1VOUV/XFjeV6WfILq8Ck+FbivksC3n0/QXRgXJqTgGaIkVcXP/GyALe6VMv5mKHO4pdp7cSd7W2Jp/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47DCC150C;
	Fri, 30 May 2025 09:37:08 -0700 (PDT)
Received: from bogus (unknown [10.57.47.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2EFA3F673;
	Fri, 30 May 2025 09:37:22 -0700 (PDT)
Date: Fri, 30 May 2025 17:37:16 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] pmdomain: arm: scmi_pm_domain: Do lazy init as part
 of probe
Message-ID: <20250530-pelican-of-rampant-greatness-d80aec@sudeepholla>
References: <20250530103527.2244951-1-d-gole@ti.com>
 <20250530-honest-chital-of-growth-db31e1@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530-honest-chital-of-growth-db31e1@sudeepholla>

On Fri, May 30, 2025 at 05:31:08PM +0100, Sudeep Holla wrote:
> On Fri, May 30, 2025 at 04:05:27PM +0530, Dhruva Gole wrote:
> > Optimize the SCMI power domain driver to only initialize domains that are
> > actually referenced in the device tree. Previously, the driver would
> > initialize all possible domains up to the maximum ID, which could lead to
> > unnecessary firmware calls and longer probe times.
> > 
> > Key changes:
> > - Scan device tree to identify which power domains are actually referenced
> 
> How do this work with runtime DT overlays ?
> 
> > - Use bitmap to track needed domains instead of initializing all
> > - Only perform state queries and initialization for referenced domains
> > - Maintain proper array sizing for power domain framework compatibility
> > - Keep full provider structure to support late binding
> > 
> > This optimization reduces probe time and unnecessary firmware interactions
> > by only initializing power domains that are actually used in the system.
> 
> Why is this very specific to power domains only ? This must apply for other
> domains like perf or clock or reset ?
> 
> > For example, in a system with 100 possible domains but only 3 referenced
> > in the device tree, we now only initialize those 3 domains instead of
> > all 100.
> > 
> 
> Well, how much of these PD will get used in the final products ? I can
> understand the need to use just 3 in devel platforms. Just trying to see
> how realistic is the scenario ? Is there any other optimisation possible
> from the firmware ? Does getting the state of a PD takes so much time
> on the platform in question ?
> 

And I missed another point. Someone will soon complain Linux no longer
turns off unused power domains. So I am inclined against this optimisation.
We need to consider all the above point before .

-- 
Regards,
Sudeep

