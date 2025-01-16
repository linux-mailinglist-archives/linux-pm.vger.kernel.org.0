Return-Path: <linux-pm+bounces-20577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC31A14006
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042CE1646F5
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AEE22C9F7;
	Thu, 16 Jan 2025 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fZ9J6d2g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F622D4CF;
	Thu, 16 Jan 2025 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046549; cv=none; b=GuW79QyS79tuMf+86ph8Q1AqZZYvW0elDAT5OL9olr+ZRol8raeBuDOrTg7a5vYwgEbgYhuRN3y6S3B7RLmIzh26b2sB8BVcK2WjFK28ogSQD7+teNU8vh5snQuBhP2kTVWW8tFu5L54xtlbWq/WRRtIscjgwbu9eQ1h5QOrecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046549; c=relaxed/simple;
	bh=gtuZ+hsVLLsX0xEXqwJE0UJuE36ll5XqCz5O165H4Vg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=gkqyB4i00uohn5Aj9MsXVdd/iqYBCCpx2Kqtcghe92tvtiurr+x8kROsA3Tgx014bEvV8vJzO30wJlCQNkjxt2zI7oNh5V/uVTfTSLZDd+FTsK/9D4OITbW51eQ5rNVWIT0CPr32XSmrXfmrylDQOOed16kqiIoJl2P79JODdrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fZ9J6d2g; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G7Qcxm023850;
	Thu, 16 Jan 2025 10:55:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=czWs0Opb2V8LGfOqqS71wjGfzuuftPcG6sRh80tPJIk=; b=
	fZ9J6d2gOTz23oovLGhGpBYUj4qiaNVIYrsY4uGk9y6LNLnko5+KSqS/oRq8dTop
	dHOl40t/yuP70ZXG3g1GCmpveFpq4rGSaHZp6tqVY13AZeSg2iOAZqMt9Z1luwG5
	+4Lk6Gi8Jle88Az8GhP9booTErPZXQ65BpcNKIkDqWUaRhO7z+D11wu0tyJx2MYL
	/R6Kbc6WlvFedQ8GagotfctVH37FF/9E+jFaSKHqZpal8mYk0ak2q2bbJ5BMtL3g
	x6HGsXNv1idfiWrg8LzRoZSoFaml7kuDUWEH9I+KAAOhCVPjEP7BgJXhy4gTdQ0F
	F4s9qXciOgqaGv62AuQfIQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 443px4par6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 10:55:26 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 16 Jan
 2025 16:55:24 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 16 Jan 2025 16:55:24 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 17E05822562;
	Thu, 16 Jan 2025 16:55:24 +0000 (UTC)
Message-ID: <3968b172-01f7-4a75-a6f0-9be7ccc0ff5e@opensource.cirrus.com>
Date: Thu, 16 Jan 2025 16:55:24 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/6] mmc: sdhci: Use EXPORT_PM_FN_NS_GPL() for
 exporting PM functions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Victor Shih
	<victor.shih@genesyslogic.com.tw>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
 <20241101101441.3518612-2-andriy.shevchenko@linux.intel.com>
 <7b5fcb3e-e3e7-4d87-9a7b-5570e2e85a0e@intel.com>
 <Z1ccjxyxO0NMNbkm@smile.fi.intel.com>
 <4ee01e24-176e-46ac-9ecd-a0976490cbdc@intel.com>
 <Z4kiVLrPTDZr3J2K@smile.fi.intel.com>
Content-Language: en-GB
In-Reply-To: <Z4kiVLrPTDZr3J2K@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5xJtSbFD2MXYf9zSk6CG8QdHMvUU-lHO
X-Proofpoint-GUID: 5xJtSbFD2MXYf9zSk6CG8QdHMvUU-lHO
X-Authority-Analysis: v=2.4 cv=XdhzzJ55 c=1 sm=1 tr=0 ts=678939fe cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=PRKCl3ImHmY6QAcEmcwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Reason: safe

On 16/01/2025 3:14 pm, Andy Shevchenko wrote:
> On Mon, Dec 09, 2024 at 07:11:41PM +0200, Adrian Hunter wrote:
>> On 9/12/24 18:36, Andy Shevchenko wrote:
>>> On Mon, Dec 09, 2024 at 12:38:59PM +0200, Adrian Hunter wrote:
>>>> On 1/11/24 12:11, Andy Shevchenko wrote:
>>>>> Switch from ugly ifdeffery to using EXPORT_PM_FN_NS_GPL()
>>>>> for exporting PM functions. This helps cleaning up the other
>>>>> SDHCI drivers in the future.
>>>>
>>>> It seems sdhci is the first code in the kernel to use
>>>> EXPORT_PM_FN_NS_GPL() but it was not asked for ;-)
>>>>
>>>> As such, can you fill in a little background.  I am not
>>>> sure what it achieves.  Why have CONFIG_PM if not to
>>>> #ifdef dependent code behind it?
>>>
>>> It makes sure that the code elimination happens at compile time and
>>
>> Does it eliminate the code?  Maybe I am missing something,
>> but it looks like it is still there:
> 
> Hmm... Indeed. My tests show the same. I believe these new macros were never
> tested (and we have no users in the kernel).
> 
> Richard?
> 

As I recall the intention wasn't to eliminate the code. It was to
eliminate the EXPORT for code that had already been eliminated by other
macros.

A bunch of ugly macros were added a while back by someone to create PM
callback functions so that the code would be eliminated if CONFIG_PM=n,
without having to use __maybe_unused or ifdefs in the .c, And together
with this, drivers were being zealously changed to use these macros to
eliminated unused PM callbacks.

But the macros assumed the PM functions were always local static.
Sometimes a family of drivers for similar hardware share common code and
the PM functions are exported so I added these macros to make the EXPORT
also disappear. It's not great but it was based on an existing similar
pattern.

I did also have patches that used the macros with the PM wrapper macros
to eliminate the code and exports in the cs35l56 codec driver. But they
got held up behind a large backlog of other work and are basically still
sitting in a dark corner somewhere. At this point it doesn't seem worth
the trouble to eliminate the PM callbacks, especially as we don't know
of any platform that is using codecs like cs35l56 without PM. So really
I don't mind if you remove these EXPORT macros.

>>> at the same time gives developer less uglified (by ifdeffery) code.
>>> It means there is less risk to miss anything of that which make become
>>> a compile-time warning of unused function, or even issues during linking
>>> with modules, etc.
>>>
>>> Should I update a commit message with that?
> 


