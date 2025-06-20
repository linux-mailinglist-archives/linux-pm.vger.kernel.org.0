Return-Path: <linux-pm+bounces-29159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 666A6AE193B
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 12:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C101BC76C1
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 10:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796E2266571;
	Fri, 20 Jun 2025 10:47:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67B62AF07
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750416421; cv=none; b=XUV1j3W1Z/UPZvs7rhrL05PC0thaV+/NYGHVGiiEMJWZJpAjpt04T3UU9A7KWVLumLGMqI/QBtkGEgNKByibAwX9Dtl8fT3fV7/UcNZStlD8aFo3vZ5ZUj+g7ex7z9TqknZ96V9YbxghmwKckDydWTrVffvwL304PY4e/vmKCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750416421; c=relaxed/simple;
	bh=8K+lKwckWfuWutfmZ63/z6hrsco7XbS2G0aXpnrRaW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYSha77MsjQgZTMDiA6CqSqgw6nr05fFWLtCW5NiFtNQhNF7Hz6wS8KPhrp9oVJasf43icDkwdGF6Oi/06tCDyJJOeFNQrdTOhRqzNT1cYtem3VfOqu5JPCKjEx3hKRBzJtTG7kZ9qWDcBKG8GVkI7iAqckX+AKGAlS8Ywnk6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 869CC176A;
	Fri, 20 Jun 2025 03:46:39 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA4DA3F58B;
	Fri, 20 Jun 2025 03:46:57 -0700 (PDT)
Date: Fri, 20 Jun 2025 11:46:54 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: =?utf-8?B?6buE5bCR5rOi?= <huangshaobo2075@phytium.com.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	lenb@kernel.org, deepthi@linux.vnet.ibm.com, khilman@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: Subject: [cpuidle] Limitation: cannot model asymmetric C-state
 latencies on big.LITTLE SoCs
Message-ID: <20250620-premium-curious-bison-9df0d4@sudeepholla>
References: <5d7534c.5492.1977796c43a.Coremail.huangshaobo2075@phytium.com.cn>
 <CAJZ5v0ix-QWgpq_FhnKhSWN5BtBmU_fSWSMJFkr8H1OUm6qJKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ix-QWgpq_FhnKhSWN5BtBmU_fSWSMJFkr8H1OUm6qJKw@mail.gmail.com>

On Mon, Jun 16, 2025 at 01:29:15PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 16, 2025 at 9:14 AM 黄少波 <huangshaobo2075@phytium.com.cn> wrote:
> >
> > From: huangshaobo2075@phytium.com.cn
> > To: linux-pm@vger.kernel.org
> > Cc: rafael@kernel.org, lenb@kernel.org, deepthi@linux.vnet.ibm.com, khilman@kernel.org
> > Subject: [cpuidle] Limitation: cannot model asymmetric C-state latencies on big.LITTLE SoCs
> >
> > Hi,
> >
> > I'm working on an ARM64 platform with a big.LITTLE CPU topology. While parsing the ACPI tables,
> > I noticed that the C-state latency and residency values differ between the big and LITTLE cores,
> > as expected.
> >
> > However, I found that the current cpuidle framework only allows a single global `cpuidle_driver`,
> > and all CPUs share the same `cpuidle_driver->states[]` array.
> 
> Not really, see bl_idle_init() in particular.
> 
> However, on systems with ACPI on which _CST is used for idle state
> description, there's only one cpuidle driver and one table of idle
> states for all CPUs.
> 

Indeed.

> > As a result, only the first core to
> > initialize (usually a LITTLE core) sets up the C-states, and the same values are applied to all cores,
> > including the big ones. This leads to incorrect idle behavior on asymmetric platforms.
> >
> > I believe this behavior was introduced by commit 46bcfad7a819
> > ("cpuidle: Single/Global registration of idle states").
> >
> > I understand this design was introduced in 2011 to simplify cpuidle and reduce memory usage:
> > https://lkml.org/lkml/2011/4/25/83
> >
> > However, on today's heterogeneous SoCs, this global model no longer suffices. For proper modeling,
> > we need support for per-cluster or per-core cpuidle drivers, or at least some mechanism to allow
> > different idle state parameters per CPU.
> >
> > Has there been any discussion or work toward lifting this limitation?
> 
> No, there's not been any discussion on this so far, but why does the
> platform firmware on this system use _CST for idle state description?
> _LPI would be a better option AFAICS.
> 

Absolutely _LPI is better and I believe _LPI is used in this case. However
at the time I added _LPI support, the expectation was to use ACPI on SMP
systems without such variations in the idle states. So even with _LPIs,
only one cpuidle driver and hence only one table of idle states for all CPUs
was added. We can enhance the support for HMP systems with different set of
idle states if required. All we need is to allocate the driver instead of
using acpi_idle_driver IIRC. The initialisation of the states is already done
per cpu.

-- 
Regards,
Sudeep

