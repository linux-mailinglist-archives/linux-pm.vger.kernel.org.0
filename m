Return-Path: <linux-pm+bounces-40360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F23B4CFD7DD
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 12:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A603301722B
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 11:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4521F3128B0;
	Wed,  7 Jan 2026 11:52:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211052F7444;
	Wed,  7 Jan 2026 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786732; cv=none; b=dwds5F2aAYdHFuPXSIDmB0whQfoR2RGTJM1OEQxxmc4lupsSmgSkTwmpe4iI/fSQHAMRzmW2aKFuLvH4gYog6sZ5cikI5S08RvIpKgkuEKmrUjxne8sZaEQOOW0UG3HODWacFwwpxp2ICWCRzohsfl+iq9Fq0M22R5dHtRY/tSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786732; c=relaxed/simple;
	bh=1Fchlxf4hNZLgwVE8WYe2dz3lUN9r/xoRIw5B7bqDRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dO/2Tqu5GdcpqAsnjaEUXC2/YaIQwmYfqJSI9bAcw/dtLRNLXnGZgs+DlqV75oPaXMENhIfj4XOwOh1YKL4v2nrEd9WDZMQYswoUcV2fIQ/oAwzCL89OgI5usLkb6SkfJf9xpe08mb6xZUNW6dfm6niaXIITbDGDfk7FIlA3icE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1DF6497;
	Wed,  7 Jan 2026 03:52:02 -0800 (PST)
Received: from [10.57.12.220] (unknown [10.57.12.220])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FDD63F6A8;
	Wed,  7 Jan 2026 03:52:07 -0800 (PST)
Message-ID: <08b09d21-0c59-4c0d-8b21-3883e76964d2@arm.com>
Date: Wed, 7 Jan 2026 11:52:06 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 6.19 0/4] Revise the EM YNL spec to be clearer
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Changwoo Min <changwoo@igalia.com>, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, lenb@kernel.org,
 pavel@kernel.org, donald.hunter@gmail.com, kuba@kernel.org
References: <20251225040104.982704-1-changwoo@igalia.com>
 <849b576e-9563-42ae-bd5c-756fb6dfd8de@arm.com>
 <CAJZ5v0imU_DkW5-Pip3ze-MaHj+CAvc0LNkaLsTZuFbj33R0aA@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0imU_DkW5-Pip3ze-MaHj+CAvc0LNkaLsTZuFbj33R0aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 1/5/26 18:22, Rafael J. Wysocki wrote:
> On Tue, Dec 30, 2025 at 10:44 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Changwoo,
>>
>> On 12/25/25 04:01, Changwoo Min wrote:
>>> This patch set addresses all the concerns raised at [1] to make the EM YNL spec
>>> clearer. It includes the following changes:
>>>
>>> - Fix the lint errors (1/4).
>>> - Rename em.yaml to dev-energymodel.yaml (2/4).  “dev-energymodel” was used
>>>     instead of “device-energy-model”, which was originally proposed [2], because
>>>     the netlink protocol name cannot exceed GENL_NAMSIZ(16). In addition, docs
>>>     strings and flags attributes were added.
>>> - Change cpus' type from string to u64 array of CPU ids (3/4).
>>> - Add dump to get-perf-domains in the EM YNL spec (4/4). A user can fetch
>>>     either information about a specific performance domain with do or information
>>>     about all performance domains with dump.
>>>
>>> This can be tested using the tool, tools/net/ynl/pyynl/cli.py, for example,
>>> with the following commands:
>>>
>>>     $> tools/net/ynl/pyynl/cli.py \
>>>        --spec Documentation/netlink/specs/dev-energymodel.yaml \
>>>        --dump get-perf-domains
>>>     $> tools/net/ynl/pyynl/cli.py \
>>>        --spec Documentation/netlink/specs/dev-energymodel.yaml \
>>>        --do get-perf-domains --json '{"perf-domain-id": 0}'
>>>     $> tools/net/ynl/pyynl/cli.py \
>>>        --spec Documentation/netlink/specs/dev-energymodel.yaml \
>>>        --do get-perf-table --json '{"perf-domain-id": 0}'
>>>     $> tools/net/ynl/pyynl/cli.py \
>>>        --spec Documentation/netlink/specs/dev-energymodel.yaml \
>>>        --subscribe event  --sleep 10
>>>
>>> [1] https://lore.kernel.org/lkml/CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com/
>>> [2] https://lore.kernel.org/lkml/CAJZ5v0gpYQwC=1piaX-PNoyeoYJ7uw=DtAGdTVEXAsi4bnSdbA@mail.gmail.com/
>>
>> My apologies, I've missed those conversations (not the best season).
>>
>> So what would be the procedure here for the review?
>> Could Folks from netlink help here?
>>
>> I will do my bit for the EM related stuff (to double-check them).
> 
> I think that it'll be good to have this in 6.19 to avoid making a
> major release with an outdated EM YNL spec and I see that the review
> on the net side is complete, so are there any concerns about this?

I'm sorry for delay.
I don't see concerns. It LGTM so far, I can see that there will be v2
with minor change.

Regards,
Lukasz


