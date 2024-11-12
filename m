Return-Path: <linux-pm+bounces-17385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1872E9C5069
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 09:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CF41F2297B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 08:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3B20A5E6;
	Tue, 12 Nov 2024 08:21:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE18079C4;
	Tue, 12 Nov 2024 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399675; cv=none; b=KQ6702ifZ1iIOzVzVc4szybC5rbxwrJw7Sz04lM/MNzg0Up4jAEaGGaQSZby2sZ/GuI/5QfwbsigQRZAGarHSYXtcQ9J5Mw43QL8Y+KWXAGeNstbNXDRvQiqsJOrxf6IclvZ+JR8xU1xtBpdFObiOwztk1fagkroVQgD08fmLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399675; c=relaxed/simple;
	bh=m3Kwm25d9MQbLfy8dkgOBKH4jNlX+GSOrop7fV+jQJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkK5+rlHvTTd3eACgaCCckHc6U/WVOPNqbtonyqGM8M3XwXmaGnC6dqmaNfnuao8gRkhGvqsvXYqUtNT/Iz2sLR5zzSaG+9hu+UvnELPmNs/4lrmTNjSJRdogsBDQVeRxVN38+t9cklCqZtLdFQWIitid7ftLoZHuRbjBhdqTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 608EF12FC;
	Tue, 12 Nov 2024 00:21:40 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 005B83F6A8;
	Tue, 12 Nov 2024 00:21:08 -0800 (PST)
Message-ID: <03c00c7c-d0f8-4002-8fe0-7d06ac2e030b@arm.com>
Date: Tue, 12 Nov 2024 09:21:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v0.1 2/6] PM: EM: Call em_compute_costs() from
 em_create_perf_table()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <len.brown@intel.com>, Morten Rasmussen
 <morten.rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <3607404.iIbC2pHGDl@rjwysocki.net>
 <1821040.VLH7GnMWUR@rjwysocki.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <1821040.VLH7GnMWUR@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2024 17:37, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In preparation for subsequent changes, move the em_compute_costs()
> invocation from em_create_perf_table() to em_create_pd() which is its
> only caller.

You have to do this since em_create_perf_table() is only called when 'if
(cb->active_power) != NULL'.

And 'cb->active_power == NULL' is what you use for your new 'stub' PD case.

Maybe worth mentioning already here? You do mention this in the
following patch though.

[...]

