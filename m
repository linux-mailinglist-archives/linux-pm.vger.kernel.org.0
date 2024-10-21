Return-Path: <linux-pm+bounces-16141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84629A9020
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 21:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B11BB20EC4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 19:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43881C9EB4;
	Mon, 21 Oct 2024 19:50:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CFD1C9DE5
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540210; cv=none; b=hNX10frJClqKAX3E9vrrBLHuki2JRDj1DEXeJjGFIlAALXuUM5FsSD+Iy9KUT46DybHqAWg0JvZMTAJpmBjW5BwGYzKcIvDFyWfi34gu4H2v2pUN4we1eFZu5IRIZqgsI7rLLoUVMpGhbBrHSIR8Aq7Kmb8eSmFfD35qTdY5b5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540210; c=relaxed/simple;
	bh=WbkDSMMKRkW3sxRrfXETyGtrH5yhN6NqjK9WlYy05b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hj8AzhsgDqVvRIRC1A4MU28OmT891Zexq/iy1P0AylCGUo5x8T5Y1jSgk/TlqwaDAWkPCKiR2wk2tmATEUx5fJ4wdLMNx+I3njZwpJI6zGM8QljG77a4BXAjHC6hfhNo9r7sHuMyPVB1AkX8mr6EcBOkANkuiJiTvOSeAdTSZug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BACD497;
	Mon, 21 Oct 2024 12:50:37 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBFAD3F73B;
	Mon, 21 Oct 2024 12:50:06 -0700 (PDT)
Message-ID: <2643564a-0c52-4ebd-865e-621dad666a8a@arm.com>
Date: Mon, 21 Oct 2024 20:51:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] thermal/netlink: Add the commands and the events
 for the thresholds
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 quic_manafm@quicinc.com
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-2-daniel.lezcano@linaro.org>
 <41b2ca3d-523d-40e3-81d3-5959942d9eb8@arm.com>
 <CAJZ5v0iqNhMfOiWQN=xTD71DDM4NoLLwGKmEJEbZ+fML3aHr9w@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iqNhMfOiWQN=xTD71DDM4NoLLwGKmEJEbZ+fML3aHr9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/21/24 20:47, Rafael J. Wysocki wrote:
> On Mon, Oct 21, 2024 at 9:41 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Daniel,
>>
>> On 10/14/24 10:43, Daniel Lezcano wrote:
>>> The thresholds exist but there is no notification neither action code
>>> related to them yet.
>>>
>>> These changes implement the netlink for the notifications when the
>>> thresholds are crossed, added, deleted or flushed as well as the
>>> commands which allows to get the list of the thresholds, flush them,
>>> add and delete.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>    drivers/thermal/thermal_netlink.c    | 236 ++++++++++++++++++++++++++-
>>>    drivers/thermal/thermal_netlink.h    |  34 ++++
>>>    drivers/thermal/thermal_thresholds.c |  36 ++--
>>>    drivers/thermal/thermal_thresholds.h |   2 +-
>>>    include/uapi/linux/thermal.h         |  27 ++-
>>>    5 files changed, 307 insertions(+), 28 deletions(-)
>>>
>>
>> Since Rafael asked to wait a bit for the other
>> changes to go first, I will skip the detailed review
>> of that patch. I will do that after you add that
>> new locking scheme.
> 
> Well, this is almost orthogonal to my locking changes and can be
> easily rebased on top of them, so I don't see a need to respin it.
> 
> Please review.

OK, I will then.
I have an issue with the build process (cross compiling the libthermal)
but I will manage that differently for testing. I suspect some memory
leak in patch 2/4, so testing would help me...

> 
>> In general the code looks good.
> 
> OK

