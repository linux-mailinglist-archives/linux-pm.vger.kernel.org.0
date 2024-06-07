Return-Path: <linux-pm+bounces-8764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047708FFF63
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188A51C22C1D
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 09:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7868015B567;
	Fri,  7 Jun 2024 09:26:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D23615B143;
	Fri,  7 Jun 2024 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752393; cv=none; b=Nm97j0oyXBEyn3/iYAmGFgw+J0bA5WaeUEx8XwejgBRAhyLLi3S6e992ALwvmIXopMULm52MxPaGUP7vm9Fh1wqC38HImB+RGAeFOqjEcQRSeIJyRVP1n8cLP02uDULJYaK20r5t20Yw9oXIj3CZxLjJ+EeG6W3ejbGDQ/JSH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752393; c=relaxed/simple;
	bh=ifpj+jgfGYFHg0GMeN55oZEARVvQW1fbD6S+0y/2aO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hwz1SsG+JmAEMMLuXhufRWPgp4SSS1HbvFphveunTG7BtDkg1j31VBIaoxTTCuHKOqlQeEfFeH8DdSv/PRI9VbrEhwFpYTw4CGos/8XY6j0Ox9JvVGQrZE4pzr8nl7i9kRjH6MPq4NQ6zgkduTTYxTJW7sUm4S4tZmUPSlhUAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC8022F4;
	Fri,  7 Jun 2024 02:26:55 -0700 (PDT)
Received: from [10.57.70.22] (unknown [10.57.70.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F23D3F762;
	Fri,  7 Jun 2024 02:26:29 -0700 (PDT)
Message-ID: <a9e06f49-c94c-4f73-a164-0998e78914bb@arm.com>
Date: Fri, 7 Jun 2024 10:26:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] cpuidle: teo: Remove recent intercepts metric
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, anna-maria@linutronix.de,
 kajetan.puchalski@arm.com, lukasz.luba@arm.com
References: <20240606090050.327614-1-christian.loehle@arm.com>
 <20240606090050.327614-6-christian.loehle@arm.com>
 <96eb4e13-e1c7-4c64-a4bf-0d2b5610d390@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <96eb4e13-e1c7-4c64-a4bf-0d2b5610d390@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/24 09:57, Dietmar Eggemann wrote:
> On 06/06/2024 11:00, Christian Loehle wrote:
>> The logic for recent intercepts didn't work, there is an underflow
>> that can be observed during boot already, which teo usually doesn't
>> recover from, making the entire logic pointless.
> 
> Is this related to:
> 
> https://lkml.kernel.org/r/0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com ?
> 
> In this case, a link here would be helpful to get the story.

It is!
Will include. To my defense, it is included in the cover letter.

> 
>> Furthermore the recent intercepts also were never reset, thus not
>> actually being very 'recent'.
>>
>> If it turns out to be necessary to focus more heavily on resets, the
>> intercepts metric also could be adjusted to decay more quickly.
>>
>> Fixes: 77577558f25d ("cpuidle: teo: Rework most recent idle duration values treatment")
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> 
> [...]
> 


