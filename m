Return-Path: <linux-pm+bounces-13886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D59971A3A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 15:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33568284E44
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206AF1B86EA;
	Mon,  9 Sep 2024 13:01:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED841B78F7;
	Mon,  9 Sep 2024 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886912; cv=none; b=IeZeReBN2LpIWliiPzP8QreLU5q1moYVVYDuZQuFiai5nXuOVijNKFd6eJVVvB33sgS5tBhBX0Vevis2vADmXbPemg0+ZoQoItZaMaAKJgbaPYZDbbiwaMIrFLrwacMmw6LjO3aoUewHua1C9ufIz5pqpAKPE9cP6AgkIE6gtP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886912; c=relaxed/simple;
	bh=2qK7iuRG4sIpqwJOBL5BB32FvL7kK5EgrLz3GIJWy/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfseTweX4Qesolz3kM5FUzj5EGJfWXXmTzn1V2dAqMb4mjlN0hJFToVSFbHTPX5JtGuyEnIodTw6WcDwr+t3eT/SY16djxqPIjTh3iY0qKU0QdjT+wZQsWtxaNNqfxWPDAmD6AuN6E32ri343tMwJ65pPwSoGtpwO2rOje0TEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E2E2FEC;
	Mon,  9 Sep 2024 06:02:11 -0700 (PDT)
Received: from [10.1.39.38] (e127648.arm.com [10.1.39.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9DCD3F64C;
	Mon,  9 Sep 2024 06:01:40 -0700 (PDT)
Message-ID: <1f5f7643-8743-40f4-80ac-0534affd70cd@arm.com>
Date: Mon, 9 Sep 2024 14:01:38 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] sched/deadline: nanoseconds clarifications
To: Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael@kernel.org, vincent.guittot@linaro.org, qyousef@layalina.io,
 peterz@infradead.org, daniel.lezcano@linaro.org, rostedt@goodmis.org,
 dietmar.eggemann@arm.com, Juri Lelli <juri.lelli@redhat.com>
References: <20240813144348.1180344-1-christian.loehle@arm.com>
 <ZruDkw2XB8iXMepz@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <ZruDkw2XB8iXMepz@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/24 17:02, Juri Lelli wrote:
> Hi,
> 
> On 13/08/24 15:43, Christian Loehle wrote:
>> A couple of clarifications about the time units for the deadline
>> parameters uncovered in the discussion around
>> https://lore.kernel.org/lkml/3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com/
>>
>> While at it I changed the documentation example to chrt instead
>> of the schedtool fork.
>>
>> No functional changes.
> 
> Looks good to me!
> 
> At least for docs/uapi,
> 
> Acked-by: Juri Lelli <juri.lelli@redhat.com>

(gentle ping)
Peter, do you want to take {1,2} and Rafael {3,4}?

Thanks,
Christian

