Return-Path: <linux-pm+bounces-17386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BBA9C506E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 09:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C09B22F96
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 08:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B89120B816;
	Tue, 12 Nov 2024 08:21:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A3C20B21E;
	Tue, 12 Nov 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399678; cv=none; b=DAPMsxnxKdZEm2Xu1MdPZihRXAL5+A7kKWlzjXpVMs9hHqKS9/v7ofU32zKwCwOga4j65HEbmPh7qfSJfe/oVcdaYrE18pPzKVJqctcHm+i6ztesqlrd1FJZ0a70SbeaYr7vjZkT7aDWmzguQWrYPpMf6TtiW64zbCBw7TRhEOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399678; c=relaxed/simple;
	bh=LwG0KfMMVsCwy3MC23aOoNXjjooaFYF0+wlGlzjuQcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fa4G3XtBbuTHctDKTUUwVH5LVcT1xR06o3i9QOXEfO5NwtI/eHtPzMjEvNYj2/4j9G65WtAUobI3r6hh6CNCJj+KgKw7QdB+erdDkMLB4tq7MX4njRQA5S1tex1WZLtAALOqIi7Q6udSMxw/wR/ovysg1A3m/yOClZGhJdoQaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63AA51424;
	Tue, 12 Nov 2024 00:21:44 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC2EF3F6A8;
	Tue, 12 Nov 2024 00:21:12 -0800 (PST)
Message-ID: <5a8b9d35-dedf-4129-8100-ce71d32a13ff@arm.com>
Date: Tue, 12 Nov 2024 09:21:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v0.1 3/6] PM: EM: Add special case to
 em_dev_register_perf_domain()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <len.brown@intel.com>, Morten Rasmussen
 <morten.rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <3607404.iIbC2pHGDl@rjwysocki.net>
 <2017201.usQuhbGJ8B@rjwysocki.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <2017201.usQuhbGJ8B@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2024 17:38, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Allow em_dev_register_perf_domain() to register a cost-only stub
> perf domain with one-element states table if the .active_power()
> callback is not provided.
> 
> Subsequently, this will be used by the intel_pstate driver to register
> stub perf domains for CPUs on hybrid systems.

Looks like a 'stub' PD only distinguish itself from a normal PD by not
checking that all CPU in that PD have the same CPU capacity value?

I assume you do this since the Performance Cores (CPUs) can have
different CPU capacity values due to slightly different 'itmt prio' values?

So strictly speaking such a Intel hybrid machine would be tri-gear
system to fit the definition of a PD.

I thought initially by reading the word 'stub' that you only setup a
part of the default EM infrastructure.

[...]


