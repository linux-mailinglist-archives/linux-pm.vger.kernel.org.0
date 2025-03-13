Return-Path: <linux-pm+bounces-23957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B59C8A5EB91
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 07:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C539C7A9AB0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 06:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FAF33F3;
	Thu, 13 Mar 2025 06:15:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ED4147C9B
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 06:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846530; cv=none; b=RrHskVJN5sUVWwOwLduAGSbqXV3Muc6kbpjWSnrizlY0kX8I4LTy52V/DKzfMTuYH1/Dlzg8L4LjvVo4XtCAwzYXnwZhhWpvWE2Ndn1YTjk8NX6/jycafMT8YBEZrqwCDp/b6+wRONny89CwubpVLoqsiU4xU8SZ6bbphVVITmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846530; c=relaxed/simple;
	bh=J07LJixRFrMEq+h78TsoNZznPJmHPCc7YIVYdUBwtOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1lN1E+l/JXjnbQSV19WOWQ9h5SV6HXqzon+B3+JSemj81pnLH7c8MjOSmoNYogeGWC3Gucttvegmhw2Tf1O4bG5vrJQKIisGb6KAQ1cnBwoPucYogIITvmLMMciV0OTs01oYqktHifqhElYyweMyhoZMIEa2tdd559xOwe/T1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7A331516;
	Wed, 12 Mar 2025 23:15:31 -0700 (PDT)
Received: from [192.168.188.123] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BB803F673;
	Wed, 12 Mar 2025 23:15:20 -0700 (PDT)
Message-ID: <e1ce9edb-db24-46cc-b33f-f0fbce938f9a@arm.com>
Date: Thu, 13 Mar 2025 06:15:18 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TEO as default governor ?
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Doug Smythies <dsmythies@telus.net>
References: <483602d6-4ac2-4785-b205-912b59fbd6f1@linaro.org>
 <4a50de85-0deb-4864-b7b5-ee81cec7f167@arm.com>
 <CAJZ5v0jBFOZ-z29-KwgHN9cL4sEPsW9K5TG6XeT7Y-ADbVPcCw@mail.gmail.com>
 <9b4a15c4-4e0c-43f6-b2ec-e98bc02f67cc@linaro.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <9b4a15c4-4e0c-43f6-b2ec-e98bc02f67cc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/11/25 18:00, Daniel Lezcano wrote:
> On 11/03/2025 18:34, Rafael J. Wysocki wrote:
>> On Tue, Mar 11, 2025 at 5:47 PM Christian Loehle
>> <christian.loehle@arm.com> wrote:
>>>
>>> On 3/11/25 16:31, Daniel Lezcano wrote:
>>>>
>>>> Hi,
>>>>
>>>> I think we can agree the teo governor is better then the menu governor.
>>>>
>>>> Would it make sense to make the teo governor the default governor ?
>>>>
>>>>
>>>
>>> Rafael's position seems to be quite conservative here.
>>> Fact is menu is still the default on many systems.
>>> Even worse, the really bad performance disadvantage when
>>> using menu in an intercept-heavy workload has been fixed by Rafael :)
>>> https://lore.kernel.org/lkml/bc7f915b-8d9f-4e05-9939-8b7ecc078f85@arm.com/
>>>
>>> FWIW I proposed this a while ago:
>>> https://lore.kernel.org/lkml/20240905092645.2885200-3-christian.loehle@arm.com/
>>
>> It will help if one can make a really convincing case for this change
>> (that is, show that menu with the most recent fixes included is really
>> significantly worse on their platform).
> 
> For all the platforms I've been testing, the teo governor is always the best one.
> 
> Using the menu governor has also an impact on the user experience as it lags on mobile.
> 
> After studying the history of the menu governor few years ago, it appeared the menu governor was introduced before the SMP was widely used. The strength of the menu governor was the ability to find repeating intervals but with he multiplication of the cores, the IPIs were introduced which increased the entropy of the busy-idle cycles duration, thus making the duration much more random and altering the menu governor prediction accuracy.

Cross-posting Doug's reply here and +CC
https://lore.kernel.org/lkml/005801db9397$266ddac0$73499040$@telus.net/

Daniel if you're testing both and struggle to find a strong advantage
for teo:
teo currently has the intercept-mechanism, trying to find a shallower state
until we are at < 1/2 intercepts as wakeups.
Rafael's idea was to make this configurable, e.g. allowing only 20%
intercepts (more aggressive in selecting shallow states) or 80% (less
aggressive in selecting shallow states).
This would be a minimal change in code and the rest of teo is unaffected,
but gives users a choice, something menu won't offer.

