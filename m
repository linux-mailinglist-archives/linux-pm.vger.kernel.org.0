Return-Path: <linux-pm+bounces-8746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ED78FFDBE
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 10:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D004283925
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7868C1581E3;
	Fri,  7 Jun 2024 08:01:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EF715AAC7;
	Fri,  7 Jun 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747301; cv=none; b=fMO13MWTqqsLUdAwft89rCKy0AR27upqw9jd+/WRTa3qx7Awktg98ozuVo16F1JmFqr+OicPyXYuy32/3sDOFyFSWC8y3gzVGi7z21RjpDTdFHLtOVi1lk4xUzNhKW11a7KkkKF2Z0RugBI7pq4GXddEMV84PF81GvzsMrhXvwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747301; c=relaxed/simple;
	bh=qfO5B+ddYaxpzHvaEPVjfRrfPkXTjGkIeqggJGx9Ymk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCUu0OsDzyVoRVK/LEGMLHuwv6KI+qrKP7VY83fYPmlvMTlmvmsagMqFb/a0SJKfybcHdeo8J3g52hhm44e2pHF10bVbBffpXiz1oQ3yyWVj6s2xr7fm2Sv+p81NWnKIVrMy3AsGM/8+sOwnu2d7oPbxwkpNW655uAMgzQgCzko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 438E32F4;
	Fri,  7 Jun 2024 01:02:03 -0700 (PDT)
Received: from [192.168.2.88] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 204FB3F64C;
	Fri,  7 Jun 2024 01:01:36 -0700 (PDT)
Message-ID: <19d87e24-7c2b-4396-9514-74150b896cf3@arm.com>
Date: Fri, 7 Jun 2024 10:01:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] cpuidle: teo: Increase util-threshold
To: Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, anna-maria@linutronix.de,
 kajetan.puchalski@arm.com, lukasz.luba@arm.com
References: <20240606090050.327614-1-christian.loehle@arm.com>
 <20240606090050.327614-2-christian.loehle@arm.com>
Content-Language: en-US
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240606090050.327614-2-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2024 11:00, Christian Loehle wrote:
> Increase the util-threshold by a lot as it was low enough for some
> minor load to always be active, especially on smaller CPUs.

We see the blocked part of the CPU utilization as something telling the
task scheduler that the corresponding tasks might be runnable soon again
on this CPU.

This model seems to be used here as well. I guess folks are still
debating whether the amount of blocked utilization is a good enough
indicator for the length of idle time.

> For small cap CPUs (Pixel6) the util threshold is as low as 1.
> For CPUs of capacity <64 it is 0. So ensure it is at a minimum, too.

So before this threshold was 16 on a 1024 CPU, now it's 256?

A <= 200 CPU has now a threshold of 50.

Where do those numbers come from? Just from running another workload on
a specific device?

[...]

