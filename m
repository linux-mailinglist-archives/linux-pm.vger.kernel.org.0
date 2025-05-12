Return-Path: <linux-pm+bounces-27057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C571AB3EF4
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 19:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F494639D5
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 17:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C89248F49;
	Mon, 12 May 2025 17:24:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD524EF7F;
	Mon, 12 May 2025 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070693; cv=none; b=UHVWWMLTF7TS9Pn7CPXB+rDA8cyph564AYJ5dmDQV//5xbdPyqZ4jae8fpil0XWYnoG/GfI+vohSVpsQGwg8Klc6iJ5/pgEgRr0HLhJ76pvsq/GlzuN/PkWhJW9O1/TvNJVIYKBrKLIvlET8vDO0K0V8NS8HDe1gfjPbmQo5v8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070693; c=relaxed/simple;
	bh=6TmfCMCAyxoixsYWShG6j4nRgGDyDLi3rtHlHjWz6VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/y+Ct+SOVJ38HAoCgjfprlSHSQVKRjPQRXuMuQwCvQ8sA9DoK2g+aWVw3r7yOUb9fzUHqfE8z/DWZ5SvY7WkNpHHqzJjM4wNjxD1sYHF7BP0PtMOtYXdmxcE6dnuUAjihvdZTfb3Pud2kRMzacMDwLS7MFLLtEKJjVP3HMOO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E14E14BF;
	Mon, 12 May 2025 10:24:39 -0700 (PDT)
Received: from [192.168.178.25] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFA493F673;
	Mon, 12 May 2025 10:24:47 -0700 (PDT)
Message-ID: <70cadfd8-8d5c-4685-b3d0-23cde6edc522@arm.com>
Date: Mon, 12 May 2025 19:24:35 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] cpufreq/sched: Move cpufreq-specific EAS checks to
 cpufreq
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
References: <2999205.e9J7NaK4W3@rjwysocki.net>
 <CGME20250509234915eucas1p2846ecef88f268d78ab2e96d4a67002b0@eucas1p2.samsung.com>
 <2317800.iZASKD2KPV@rjwysocki.net>
 <1bf3df62-0641-459f-99fc-fd511e564b84@samsung.com>
 <CAJZ5v0j_fFk=EX0Z9_w1twQH-FpntHJvr4d0WSMBM6PevfEqNg@mail.gmail.com>
 <c00ec721-1193-4cfb-87ec-fd98f215720e@samsung.com>
 <CAJZ5v0iLr3JZ49gX9XbkjPNr_wRDMyAtMZDZ6Aoxz1KgQZ_moA@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0iLr3JZ49gX9XbkjPNr_wRDMyAtMZDZ6Aoxz1KgQZ_moA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/05/2025 14:53, Rafael J. Wysocki wrote:
> On Mon, May 12, 2025 at 8:48 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>>
>> On 10.05.2025 13:31, Rafael J. Wysocki wrote:
>>> On Sat, May 10, 2025 at 1:49 AM Marek Szyprowski
>>> <m.szyprowski@samsung.com> wrote:
>>>> On 06.05.2025 22:37, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[...]

>>>>    *** DEADLOCK ***
>>> Well, it turns out that trying to acquire policy->rwsem under
>>> sched_domains_mutex is a bad idea.  It was added to
>>> cpufreq_policy_is_good_for_eas() to address a theoretical race, so it
>>> can be dropped safely.  A theoretical race is better than a real
>>> deadlock.
>>>
>>> Please test the attached patch.
>>
>> This fixed the observed issue. Thanks!
>>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Thanks for the confirmation!

See this on my Hikey 960 as well. I was wondering why Christian L. and I
didn't catch this with RFT v1.0 (*) on i7-13700K.

But it looks like that

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=experimental/intel_pstate/eas-take2-extended

mentioned in the patch-header of (*) didn't have this line in its

commit 9ad047cade6b ("cpufreq/sched: Move cpufreq-specific EAS checks to
cpufreq")

