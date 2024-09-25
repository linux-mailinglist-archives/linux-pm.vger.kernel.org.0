Return-Path: <linux-pm+bounces-14665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0025985757
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 12:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C485B2201C
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 10:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC87513BC3F;
	Wed, 25 Sep 2024 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="sYqJeciW"
X-Original-To: linux-pm@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F24C77107;
	Wed, 25 Sep 2024 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261198; cv=none; b=WbamCzFRL6ecabKQ6nOvz3T1/ev8unxvgqmuDB4rJavKgTy7qKwApX6PlWNsqoAosLPDo2ISX59LvyAOThtO0e/UaFiZp/Pzfd8a51fxMveUshcGHgXfNShucpKs4nudP7OItcHLPP45w3C7u1vQv/5p/NAR/bpY8Nqt5XWf3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261198; c=relaxed/simple;
	bh=SWqWWzBjCprqZ1fW0k2ZoOqt9RUXMUE/R/y7EdPVlUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3IpkWoV1G/vfyCO5SBvHlrBiXT0K4e7U+AIu95JWsCSWP+XsM4nnkIpipWpsJi7aVSs5XZANrfYC3AonkaUAeXLh0lLX0UB8Tgx93QmxKV+69+MR81LwGiPhNGrToo2J6nSc2IhMG8OHotLRaPOtDXguAEZ0sC2jAPi+6fspS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=sYqJeciW; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=0OVXVlpvXCgQ9uuKa1lTkdFYJh3tlujOpkrdEUoBgsE=; t=1727261196;
	x=1727693196; b=sYqJeciWknAsE5Q2mEVqqADgY8OyCchwpW6Lx134KcXt2BZeCmieUUfal0ZDl
	5X0m7R4f7rNIbNNKf7237toG7IBxLhxwEtDFwE7wGiJUKtRxxIFvFnE/HVIWHy0Okh/Nyogz25Mjq
	ZihywvdHCZIzakCjBQ+OxDIq3xoytK+qUiq3O4RJMMtzliZVzxk706lukoXxOq79h6D5OzZ2wEriq
	EZ0XcFSh6HwmI9F0bzpJk83f4osIwMa/JR8Wq4zI0mP3CPKMCHhKNKFlXvPdnM/Ur2SZmsEuxQK84
	ZHsoJyLFr1Nqcj1sW4NhOFS1b1jhrqBxb80S4fFFzCs9eHTDFw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1stPXR-0000rL-Ny; Wed, 25 Sep 2024 12:46:29 +0200
Message-ID: <f037f25b-153d-4fb7-92fd-e3900c9488f6@leemhuis.info>
Date: Wed, 25 Sep 2024 12:46:28 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux fails to ACPI S3 supend on Dell XPS 13 9630
 (6.11.0-04557-g2f27fce67173)
To: Hans de Goede <hdegoede@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Marek Maslanka <mmaslanka@google.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 regressions@lists.linux.dev, Petr Mladek <pmladek@suse.com>
References: <18784f62-91ff-4d88-9621-6c88eb0af2b5@molgen.mpg.de>
 <154114fb-276f-45f6-bba0-98133c7c5d4d@molgen.mpg.de>
 <3b600845-77d5-42d3-8556-53cc0b2eab25@molgen.mpg.de>
 <1c10c0c4-f4d7-490f-85d2-0278c062fb87@molgen.mpg.de>
 <aa60da75-7931-462d-addd-49adfbd9893b@redhat.com>
 <b3cc0791-6334-4143-90bc-d3ae04aae0de@molgen.mpg.de>
 <10f1c736-33e9-4e04-a31e-0f095cdd08d2@redhat.com>
 <28bef0a7-bc6c-47b8-9545-e6d867922e14@redhat.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <28bef0a7-bc6c-47b8-9545-e6d867922e14@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1727261196;5058bb2c;
X-HE-SMSGID: 1stPXR-0000rL-Ny

On 19.09.24 18:55, Hans de Goede wrote:
> On 19-Sep-24 6:53 PM, Hans de Goede wrote:
>> On 19-Sep-24 4:03 PM, Paul Menzel wrote:
>>> Am 19.09.24 um 13:57 schrieb Hans de Goede:
>>>> On 19-Sep-24 1:03 PM, Paul Menzel wrote:
>>>>> Am 19.09.24 um 10:17 schrieb Paul Menzel:
>>>>>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
>>>>>>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
>
>>>> So I think we can fix this by limiting the new handling to s0ix suspend.
>>>> Can you please give the attached patch a try?
>>> Thank you so much for the instant reaction. Indeed, your patch makes ACPI S3 suspend work.
>>> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> # Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>
>> Thank you for testing. I've submitted this upstream now.
>>
>> I'll include this in the first pdx86 fixes pull-request over 6.11-rc1 is out.
> 
> That should be 6.12-rc1 of course.

Out of curiosity: why not send the fix to Linus this week to get it into
6.12-rc1 (and thus on track for stable backporting too, assuming Greg
will pick it up)? Just asking, as I have seen some developers wrongly
assuming it's not okay to queue fixes due to our "no newly developed
patches should be merged to -next or mainlined during the merge window"
rule.

Or did I misunderstood you plan or missing another reason why waiting
might be wise? If so: sorry!

Ciao, Thorsten

