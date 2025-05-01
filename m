Return-Path: <linux-pm+bounces-26505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B686AA5E6C
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 14:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A20F9A7883
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 12:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9251EA90;
	Thu,  1 May 2025 12:30:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE0B1DA53;
	Thu,  1 May 2025 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746102638; cv=none; b=REC2bBwZHNlcHhYW91osgKpIP04eCZAUhBV0ayYdg2bNGAwpBG7wEY1MkJGVZvYYPOvj2agcat36Yp0NnUXW9rHPRlK3DwnPBHK6hcp0vA6kzEQcGxTlF2u5bc9rTE8c3YYOoasRkeFY3QcTjBId300prCwSUdPmBn9jvK8vXJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746102638; c=relaxed/simple;
	bh=KnQE95qVoJVNX8ZCH72+8W7tHrtRe/I3nmQ2e0u34lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cz0ZbfEtHjapFZ9/S03SUzQ8ggz+rNVNvpdNSSt47Gm3ktM+gkaMdAxVBDBgN/kbRWK0A3R5oDvGyF1tYinaxjpH/Y3Yakm16z7wN8eapwjOl0bGVmfOyGkmxK4JJhvrrxf2OgAZwhklTqp2GrE40i9Zp4sIvS4lBWPUP+6Wvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BC3A1D14;
	Thu,  1 May 2025 05:30:29 -0700 (PDT)
Received: from [192.168.178.25] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C10A3F673;
	Thu,  1 May 2025 05:30:34 -0700 (PDT)
Message-ID: <c8ea80f0-66ee-4c13-ae52-eefab161faf4@arm.com>
Date: Thu, 1 May 2025 14:30:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1 7/8] cpufreq: intel_pstate: Align perf domains
 with L2 cache
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Tim Chen <tim.c.chen@linux.intel.com>
References: <3344336.aeNJFYEL58@rjwysocki.net>
 <1964444.taCxCBeP46@rjwysocki.net>
 <a8f11abd-758e-4e5e-bf78-419b95100918@arm.com>
 <CAJZ5v0g+pRw4H39-BNKKD9KhtRm78y9Q9a3K+yjjK1jskcbJnw@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0g+pRw4H39-BNKKD9KhtRm78y9Q9a3K+yjjK1jskcbJnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/04/2025 21:29, Rafael J. Wysocki wrote:
> On Sun, Apr 27, 2025 at 6:23 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 16/04/2025 20:10, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[...]

>> There seems to be an issue with late CPU-hotplug-in and this alignment
>> on L2 cache boundaries.

[...]

> I see.
> 
> What happens is that cpu_cacheinfo hides information on offline CPUs,
> so when CPU20 goes online, it doesn't see any other CPUs sharing the
> L2 with it.  Accordingly, a PD is created just for itself.
> 
> When CPU21 goes online, it sees that CPU20 shares the L2 with it, so
> the code attempts to create a PD for them both which fails.
> 
> This could be addressed, but the code would need to be a bit more
> complex and the current hardware seems to do better with a PD per CPU,
> so I'll drop the $subject patch for now.

Ah OK, thanks!

