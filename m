Return-Path: <linux-pm+bounces-16563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A1C9B2D31
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 11:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2582818E0
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 10:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE361D54D1;
	Mon, 28 Oct 2024 10:45:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBCC1D460B;
	Mon, 28 Oct 2024 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112301; cv=none; b=qv+6zJ565NQj9OYEABn+K6hHWgrOusK1+f1sV+LmyxLX9LOQNnvXbVCYFQlE/4rrHg8sMf2eqjPMfQaX7b4j/r94fT/rzJZ+A3zmnlqYxnj2xrMRHAI+1wgkFxWHmYNcl3Exm8fMfg1F3RHG2JU/NE7g4vPLp1xX7J6BSEQHqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112301; c=relaxed/simple;
	bh=nPQSkTwYV8GatkxX8yrqRH94Km4B8yS/qcv7O7i6WnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa/0oBnZKYnIHkfDPKXEfBTk7dKvyJgOnOjJoyXpdgEKO9n7AmTGb+W5aOAsPeLTz1XMN73NtpStlbwgbMT93O7+6bB3Twk56HxOxXNCgssV3z1M7kGShatEe3sxZNqSE1Ob7ljdXuJEk5SvnmE3XHZhfym99S9ITvM7BeToLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6DD6497;
	Mon, 28 Oct 2024 03:45:24 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 862603F73B;
	Mon, 28 Oct 2024 03:44:52 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:44:50 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: David Dai <davidai@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Quentin Perret <qperret@google.com>,
	Masami Hiramatsu <mhiramat@google.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>,
	kernel-team@android.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] cpufreq: add virtual-cpufreq driver
Message-ID: <Zx9rIjen30ArZd6k@bogus>
References: <20240919000837.1004642-1-davidai@google.com>
 <20240919000837.1004642-3-davidai@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919000837.1004642-3-davidai@google.com>

On Wed, Sep 18, 2024 at 05:08:33PM -0700, David Dai wrote:
> Introduce a virtualized cpufreq driver for guest kernels to improve
> performance and power of workloads within VMs.
> 
> This driver does two main things:
> 
> 1. Sends the frequency of vCPUs as a hint to the host. The host uses the
> hint to schedule the vCPU threads and decide physical CPU frequency.
> 
> 2. If a VM does not support a virtualized FIE(like AMUs), it queries the
> host CPU frequency by reading a MMIO region of a virtual cpufreq device
> to update the guest's frequency scaling factor periodically. This enables
> accurate Per-Entity Load Tracking for tasks running in the guest.
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

