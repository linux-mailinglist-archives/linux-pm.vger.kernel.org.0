Return-Path: <linux-pm+bounces-18792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAA19E8B2D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 06:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8AD1885799
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 05:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC4F20FAB6;
	Mon,  9 Dec 2024 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a8Q3lzw/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BE820FA99
	for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2024 05:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733723466; cv=none; b=ZKD9I5ZbzurZ1I8vyQBKcj/VOLsMkOIVtavFHrwUDRB2BtcuhXuoruHrrWEzXjcW//mOx4otr4OczDnmS9baOpyuFAFFjvhYlJR/fRkWQ3Ii436JM5w2KP7hjzzFGUWILfCOvXvRPKriqLRXEf9ujwGB1G3vfUvHPeiau8yRjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733723466; c=relaxed/simple;
	bh=vL6k/9Dw5bwMXo8gtCIxScl4RjhJ6uE04HEbW4RzQdA=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=e6o5/k13lDiAhXX7+EbEXCalmbTdSnx7nQ/N3TojQTxPyEawEtm3wE4o4qmQY+4YhvjZJCig3p9sPF0i1jO7uo970gcyZeC5HuImMHa0vMPRTtP5RDNf13N9fk8iKBQDVoUF7+fRa2ZrBMUjElr6hv2Qy0e4KESx/O0hSJ2ziuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=a8Q3lzw/; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241209055058epoutp03f22bed6fb5aeecf8e0ad92037340d004~PbEzbLwSj1656316563epoutp033
	for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2024 05:50:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241209055058epoutp03f22bed6fb5aeecf8e0ad92037340d004~PbEzbLwSj1656316563epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733723458;
	bh=Ch7x43kvW/RvmoknwdAqGNRWl0toOYy3Zz0NHsQDoss=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=a8Q3lzw/4qcaosezrDLymC2PHZjOpPt5aMq3veWS8BZyYsOWmoD1qnGXMImysll3a
	 7kqaws8MS6VMRzD1zeLnL0hodsqZv51U6PosYHbjwFzQ/xiG3eZhnoC3/S0XkIo+Gh
	 jQF0+tx0wn92dLQ7RrMLiOHita49Ej5QdCqNYRsA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241209055058epcas1p2a305bb37dbbc9197a68fb2320ec8399c~PbEy7-vQb1835618356epcas1p2N;
	Mon,  9 Dec 2024 05:50:58 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.231]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Y69vj2pz9z4x9Q0; Mon,  9 Dec
	2024 05:50:57 +0000 (GMT)
X-AuditID: b6c32a33-5b18370000005ad5-c2-6756853f55f0
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	CE.9C.23253.F3586576; Mon,  9 Dec 2024 14:50:55 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Re: [PATCH] PM / devfreq: Remove unused
 devm_devfreq_(un)register_notifier
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
CC: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi
	<cw00.choi@samsung.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <Z1RD3Ec1IJ2jY5TZ@gallifrey>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241209055055epcms1p2b90a71a4fa19ed5fb6870fd052e8a639@epcms1p2>
Date: Mon, 09 Dec 2024 14:50:55 +0900
X-CMS-MailID: 20241209055055epcms1p2b90a71a4fa19ed5fb6870fd052e8a639
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmga59a1i6wYszFhbXvzxntTjb9Ibd
	YmHbEhaLy7vmsFl87j3CaLH++Q0mBzaPvi2rGD1WLp/A7vF5k1wAc1S2TUZqYkpqkUJqXnJ+
	SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
	fmlJqkJGfnGJrVJqQUpOgWmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsafvmUsBdf4Kt6e/sPe
	wPiau4uRk0NCwERi2qfj7F2MXBxCAjsYJaa/Xs7WxcjBwSsgKPF3hzBIjbBApMSpHVvYQWwh
	ASWJhpv7mCHi+hIdD7YxgthsAroSWzfcZQGxRQQMJDb/2s8EMpNZoItJ4uz6M8wQy3glZrQ/
	ZYGwpSW2L98K1swpoCkx7+VNqBpRiZur37LD2O+PzWeEsEUkWu+dhaoRlHjwczdUXFKi785e
	sGUSAtsYJXYcmcMG4exnlJjysA1qkr7Embkn2UBsXgFfiabb65lAbBYBVYkPrz5C1bhInJu4
	EmwDs4C8xPa3c5hBIcEMdN36XfoQYT6Jd197WGGe2THvCROErSZxaPcSqDEyEqenL4Q61ENi
	/vI2aOj+Z5Q4snw78wRG+VmIAJ6FZNsshG0LGJlXMYqlFhTnpqcmGxYYwuM0OT93EyM45WkZ
	72C8PP+f3iFGJg7GQ4wSHMxKIrwc3qHpQrwpiZVVqUX58UWlOanFhxhNgf6cyCwlmpwPTLp5
	JfGGJpYGJmZGxiYWhmaGSuK8Z66UpQoJpCeWpGanphakFsH0MXFwSjUwsX/5LpiTEy+5g/vP
	pENKX89mFuz+OWdd9kY/mcALMTKXpEx1pbZdVlw73+W4x7Ji3rZaFcFPghXlSzhmrdHK+uS9
	dn5p+9uN1TF+S5KNT5lJvH7q+YlTZHHT54NH9/+LZtqkflkj592d+y8rfnM4K22/rfBtaXZ/
	j01S7v5FPnblrEcLRA/vbwg5MnnnrciHG4RZHSZsCpDrWevBe1huCcdbrQ3Nuy4+6jUTeVu5
	+ZL11qz6A+UrHz+7wCUc9vZq1WN29jBPPu/gCy6tU4XyWw1XX7p6roHdjWODpSnH5x8x25RP
	xLyrfvtm1b7ObzXKtt2a7r9kU82s3ToWNRhM5iu+dffT8uBfjiHMj2IeKbEUZyQaajEXFScC
	APlhyVYCBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241128161146epcas1p46768d7685092deaa817119db30fd12f2
References: <Z1RD3Ec1IJ2jY5TZ@gallifrey> <Z0iWPCzjv9YQ4kO_@gallifrey>
	<20241028021344.477984-1-linux@treblig.org>
	<20241207052209epcms1p45818db425ba84821003b6d735bc0e957@epcms1p4>
	<CGME20241128161146epcas1p46768d7685092deaa817119db30fd12f2@epcms1p2>

From: "Dr. David Alan Gilbert" <linux@treblig.org>
>* MyungJoo Ham (myungjoo.ham@samsung.com) wrote:
>> >* linux@treblig.org (linux@treblig.org) wrote:
>> >> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>> >> 
>> >> devm_devfreq_register_notifier() and devm_devfreq_unregister_notifier()
>> >> have been unused since 2019's
>> >> commit 0ef7c7cce43f ("PM / devfreq: passive: Use non-devm notifiers")
>> >> 
>> >> Remove them, and the helpers they used.
>> >> 
>> >> Note, devm_devfreq_register_notifier() is still used as an example
>> >> in Documentation/doc-guide/contributing.rst but that's just
>> >> an example of an old doc bug rather than anything about the function
>> >> itself.
>> >> 
>> >> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>> >
>> >Ping.
>> >
>> >Thanks,
>> >
>> >Dave
>> 
>> When I search github, it appears that vendors are using this API.
>
>Hmm OK.
>Of course there's a lot of random junk on github, so it can be tricky
>to know what's current/real/relevant.
>
>> NVIDIA:
>> Samsung:
>> Realtek:
>> 
>> Please don't remove ABIs used by vendors even if
>> they didn't upstream their drivers.
>
>Hmm OK.
>Do you think they should be using this ABI or do they have the same bug as 
>is fixed in 0ef7c7cce43f ?
>I guess they don't care.
>
>Dave

They will suffer from the same bugs mentioned in 0ef7x7cce43f.
Anyway, they probably don't care if they build these
code as built-in for their product binries.

Vendors of embedded devices, including mobile phones, usually
do not care upstreaming their device drivers, and we have too many
Linux embedded device vendors.
Even in my affiliation, we have too many different instances of
Linux kernel source repositories and binaries built
simultaneously, and I do not know how they are using the
given devfreq APIs.

Cheers,
MyungJoo

