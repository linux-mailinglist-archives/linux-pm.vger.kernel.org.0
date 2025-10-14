Return-Path: <linux-pm+bounces-36069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D882CBD9D5E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 15:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599D518A5B9E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21101313E1D;
	Tue, 14 Oct 2025 13:59:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8224930CD9E;
	Tue, 14 Oct 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450348; cv=none; b=XNcNqXb7ForXY5gaFhoviFG4B/cXVe1KrtEIIKg59iUywQaOAwzCybN3tw8aATYebLXl/4Y+hFSivC97gD637k1bStZORO1oHrx2EiO8cPteH9ZJCdF/c+Fyysl7F7c/Ja5jBexxAiGWyzM9JW0ua6zVFdZjLvgKYm9v5TKOIA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450348; c=relaxed/simple;
	bh=cGdB21WnnJcDdE+0LNLKsEd9owU5n7b7DS7o9YBM6ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5h+whP9uqx67iinqhmziiXhjyKgh0AQxAf66XdFJ842pLFtuO+VgPAdC/GcDAM/cMZrBMVYOVjRMsc4K0JiX/rcq7tSZ1stGzhjlvfFGJHlZaOOuJrVmvjhf6koUhyxxORLTqtVxqoSU6DTtDYEkdnmuIpWRGvQ/qpYZbgIFjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 014DD1A9A;
	Tue, 14 Oct 2025 06:58:57 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2FBD3F6A8;
	Tue, 14 Oct 2025 06:59:02 -0700 (PDT)
Message-ID: <a9857ceb-bf3e-4229-9c2f-ecab6eb2e1b0@arm.com>
Date: Tue, 14 Oct 2025 14:58:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>
 <ns2dglxkdqiidj445xal2w4onk56njkzllgoads377oaix7wuh@afvq7yinhpl7>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <ns2dglxkdqiidj445xal2w4onk56njkzllgoads377oaix7wuh@afvq7yinhpl7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/14/25 14:56, Sergey Senozhatsky wrote:
> On (25/10/14 15:47), Rafael J. Wysocki wrote:
>> On Tue, Oct 14, 2025 at 12:23 PM Sergey Senozhatsky
>> <senozhatsky@chromium.org> wrote:
>>>
>>>> Any details would be much appreciated.
>>>> How do the idle state usages differ with and without
>>>> "cpuidle: menu: Avoid discarding useful information"?
>>>> What do the idle states look like in your platform?
>>>
>>> Sure, I can run tests.
>>
>> Would it be possible to check if the mainline has this issue?  That
>> is, compare the benchmark results on unmodified 6.17 (say) and on 6.17
>> with commit 85975daeaa4 reverted?
> 
> I don't think mainline kernel can run on those devices (due to
> a bunch of downstream patches).  Best bet is 6.12, I guess.

Depending on what Rafael is expecting here you might just get
away with copying menu.c from mainline, the interactions to other
subsystems are limited fortunately.

