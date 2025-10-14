Return-Path: <linux-pm+bounces-36057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 167B2BD8C0F
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 12:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E7B74FE3B1
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B65B3BB40;
	Tue, 14 Oct 2025 10:25:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D10E2E2EF8;
	Tue, 14 Oct 2025 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437512; cv=none; b=ouL/u17KqSRzxEoeN7x3/9Yt5nIsKNqSlJRhvoAWIjhBZ/ZkuCi90WFIrdUsAW0EqK9o5s6chWRo1QolWHIrXEkVLVL2j9GJ+3k0+mn4KWFW65m4hCElbg2C3+I3d9rzAPQRrKTe9IKwnp9FVdiL9myuRI90+be9R6aDnGwYA9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437512; c=relaxed/simple;
	bh=GrPWHejUInShSTEIrfwfdYR823L0J0oxHEJVM90GmJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTsKOAkhoRFGYBROChRH5aNGaYm9CSWXmuuXtbmooT0rM20A8dGgiO6ZD3g+NTA9BkA50/k1AGreIibOvHXiMXEvTjBU7h1pPBxZFKcBPJ1FSc7DLYJ3kGauDy05HshSZYHR/9aBpEJGNMjGH0mp6jIppT2dyEm6CV42kczGcT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70DBE1A9A;
	Tue, 14 Oct 2025 03:25:02 -0700 (PDT)
Received: from [10.57.66.74] (unknown [10.57.66.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E88D33F6A8;
	Tue, 14 Oct 2025 03:25:08 -0700 (PDT)
Message-ID: <8da42386-282e-4f97-af93-4715ae206361@arm.com>
Date: Tue, 14 Oct 2025 11:25:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 11:23, Sergey Senozhatsky wrote:
> On (25/10/14 10:50), Christian Loehle wrote:
>>> Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
>>> invalid recent intervals data") doesn't address the problems we are
>>> observing.  Revert seems to be bringing performance metrics back to
>>> pre-regression levels.
>>
>> Any details would be much appreciated.
>> How do the idle state usages differ with and without
>> "cpuidle: menu: Avoid discarding useful information"?
>> What do the idle states look like in your platform?
> 
> Sure, I can run tests.  How do I get the numbers/stats
> that you are asking for?

Ideally just dump
cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
before and after the test.

