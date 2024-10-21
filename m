Return-Path: <linux-pm+bounces-16163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B7C9A9388
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F360B1C22DA3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FAE1FF033;
	Mon, 21 Oct 2024 22:44:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA0A1FF027;
	Mon, 21 Oct 2024 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550693; cv=none; b=GfJ1AlyL66FZR8PX93gz2uSXPPvWF834JvWzN0LtvRL10pWLqtdxAyAQ2OaFYXWHBbqLcM9M8aCPV8SgFgRwFKZY7HB+AJHihdLe7Q+2Gv7XVO+SWYfmZBwy1uBVIk/vrF5sl71DMCzuX/VCrp2wSIBqt/G6jKfpZifkPEnin3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550693; c=relaxed/simple;
	bh=acAw/44I1oLwjeL5x81Va7waaF1wBIBcPPenBS0EQ7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmJ1IgFPSmKQsak2xhXwDP0pu03apGB4C4mXCaWNzXMVcFmN5iwJY6l9QZkaOcxlrPfgMx6Wo6K3U22g9U092fNWu0E2ZP2JaVgOjeTjuZXTxZRdsNaFMpyrdeyvbp8Ilh41DPizWT1R++4iSEvNmq4xUFZJMB5uKt1mryrPo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83AD4497;
	Mon, 21 Oct 2024 15:45:20 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B5B23F71E;
	Mon, 21 Oct 2024 15:44:49 -0700 (PDT)
Message-ID: <e77b2e7d-771e-40dc-8953-8f2cded7cb7f@arm.com>
Date: Mon, 21 Oct 2024 23:45:59 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] thermal: core: Fixes and cleanups, mostly
 related to thermal zone init and exit
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2215082.irdbgypaU6@rjwysocki.net>
 <CAJZ5v0jYzw7hXaX+5AvO407d8vo725_-wHLQW6Q1fqXXJGSb6g@mail.gmail.com>
 <CAJZ5v0gEgr7Q49JSQQ37_2VbdXBTDPZmoYHuCSACJW_3gdmuwQ@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0gEgr7Q49JSQQ37_2VbdXBTDPZmoYHuCSACJW_3gdmuwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 10/21/24 12:05, Rafael J. Wysocki wrote:
> On Fri, Oct 11, 2024 at 8:50 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Fri, Oct 4, 2024 at 10:11 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>
>>> Hi Everyone,
>>>
>>> After posting the two series of thermal core patches for 6.13:
>>>
>>> https://lore.kernel.org/linux-pm/4920970.GXAFRqVoOG@rjwysocki.net/
>>>
>>> and
>>>
>>> https://lore.kernel.org/linux-pm/6100907.lOV4Wx5bFT@rjwysocki.net/
>>>
>>> before the 6.12 merge window, I have decided to reorder the changes included in
>>> these series, so that fixes and more significant cleanups (for example, changing
>>> they layout of data structures) go first, followed by the changes related to
>>> using guards for locking, and the optimization involving sorted lists becomes
>>> the last piece.
>>>
>>> This series is the first part and the majority of patches in it come from the
>>> second (RFC) series mentioned above.  Of course, they needed to be rebased to
>>> be applied in the new order.  It is on top of 6.12-rc1 with
>>>
>>> https://lore.kernel.org/linux-pm/12549318.O9o76ZdvQC@rjwysocki.net/
>>>
>>> applied and it will be added to my thermal-core-testing branch.  It is in v2
>>> to start with because all of the patches in it have already been posted in
>>> some form.
>>>
>>> The first 10 patches fix some potential issues related to thermal zone
>>> initialization and exit (for example, user space may start to interact with
>>> a thermal zone during its initialization before it's ready and system suspend
>>> taking place at a wrong time may skip a new thermal zone so it is not suspended)
>>> and do some cleanups related to that.  This concludes with the removal of the
>>> need_update field from struct thermal_zone_device.
>>>
>>> The last two patches move lists of thermal instances from thermal zones to
>>> trip point descriptors and clean up some code on top of that.
>>>
>>> Please refer to the individual patch changelogs for details.
>>
>> This material is now present in the thermal-core-testing and
>> thermal-core-experimental branches in linux-pm.git.
> 
> I gather that it is not controversial and it has been around for quite
> a while, and it was discussed during the PM+TC session at the LPC, so
> I've just applied it for 6.13.

I hope it wasn't too late. The patch set looks good and I have
added my reviewed tags.

Regards,
Lukasz

