Return-Path: <linux-pm+bounces-14678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36D598603D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 16:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F4B2843DF
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 14:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CE019DF73;
	Wed, 25 Sep 2024 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="PAzZOwTa"
X-Original-To: linux-pm@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334F19C555;
	Wed, 25 Sep 2024 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268424; cv=none; b=Pgbcp/qu0jPuhR0zzc6a7xBuYUQ/DWpmoz6XHO/H/AdioW15Ss9o2R9Rutd1crvHWRqy9uj1+yN1+nWNmluX+Xz5BriKrr6HrLMChqBPpJJucBtUusRskWT3Vh2KG6vNMfQyHArbfsrILfefBtBL7z0qMkSebWFp02h5AnwYHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268424; c=relaxed/simple;
	bh=TrkEjay2GfhES+h5BtYv+sbJK6D1aZx7ULOKgmFyL6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bV80zz6luj0Zz0mA/w1MkNqsUPpwuGvKYTa4rq1Ri95GWaS49nNV+kWeCB1qH6vPwpIdT2dBoCnRrSp37bp/ftdnFR1XYzuusj0j6dHE+q/VY921q1KBkmmyTLfH8OrPpUPEiBeX9nRxSiilaIqMTcuSWjxI0BGHOBhVXnDKvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=PAzZOwTa; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=/BeLDB6Wj/LTgzJByqjGbABjlrhCO+nzOYHVdJXFR80=; t=1727268422;
	x=1727700422; b=PAzZOwTabVmalxfwBscevAY6TVWTiqbAZUyEQZvTCjBB69hGPalExm0NEDmjv
	/s1zIdJYpfeXxq6rncBHUuOCxFJKRdq6sl9YnhbBoGKUKm707OcvGdqgI9Lh3I7q1hYAVJTWqtFLC
	Mp93fmnPz153m6Ul28ec4QyEOj9i5rvHhXrJTDG4ahpKMYIKIXavM05DEDqSCXOCh7Ii70XMHs63E
	u4KoK0+ots40dKCWC5CYV609hw0gX+4PzY6W7SblzR26UjmrH8/ucUWFdW12nbjvSQG8ZACMm700O
	WFCSlmt9kzGtBuDTmGKBfjIbfwtqnR1eGr5Uz7sL1q4Ihgr2LA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1stRQ2-0002tO-Gc; Wed, 25 Sep 2024 14:46:58 +0200
Message-ID: <fe6a4b57-ccee-407f-9ed4-4e3deff72e51@leemhuis.info>
Date: Wed, 25 Sep 2024 14:46:57 +0200
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
 <f037f25b-153d-4fb7-92fd-e3900c9488f6@leemhuis.info>
 <b92b57d0-41ee-46a3-ac44-4705a116a593@redhat.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <b92b57d0-41ee-46a3-ac44-4705a116a593@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1727268422;c158ba6c;
X-HE-SMSGID: 1stRQ2-0002tO-Gc

On 25.09.24 14:36, Hans de Goede wrote:
> On 25-Sep-24 12:46 PM, Thorsten Leemhuis wrote:
>> On 19.09.24 18:55, Hans de Goede wrote:
>>> On 19-Sep-24 6:53 PM, Hans de Goede wrote:
>>>> On 19-Sep-24 4:03 PM, Paul Menzel wrote:
>>>>> Am 19.09.24 um 13:57 schrieb Hans de Goede:
>>>>>> On 19-Sep-24 1:03 PM, Paul Menzel wrote:
>>>>>>> Am 19.09.24 um 10:17 schrieb Paul Menzel:
>>>>>>>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
>>>>>>>>> Am 19.09.24 um 07:51 schrieb Paul Menzel:
>>>>>> So I think we can fix this by limiting the new handling to s0ix suspend.
>>>>>> Can you please give the attached patch a try?
>>>>> Thank you so much for the instant reaction. Indeed, your patch makes ACPI S3 suspend work.
>>>>> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> # Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>>>
>>>> Thank you for testing. I've submitted this upstream now.
>>>>
>>>> I'll include this in the first pdx86 fixes pull-request over 6.11-rc1 is out.
>>>
>>> That should be 6.12-rc1 of course.
>>
>> Out of curiosity: why not send the fix to Linus this week to get it into
>> 6.12-rc1 (and thus on track for stable backporting too, assuming Greg
>> will pick it up)? Just asking, as I have seen some developers wrongly
>> assuming it's not okay to queue fixes due to our "no newly developed
>> patches should be merged to -next or mainlined during the merge window"
>> rule.
> 
> The commit/regression this fixes is only in 6.12 (1), so there is no need
> to backport the fix.

Ahh, sorry, you are right, with the conferences last week I got confused
here.

> Which means that AFAICT there is no big hurry to fix this

Well, would be nice to prevent others from running into this, but well,
you are right, no big hurry, especially considering this:

> and I'm currently traveling (I'm at kernel recipes in Paris atm).

Enjoy! Guess next year I'll go again too. :-D

Ciao, Thorsten

