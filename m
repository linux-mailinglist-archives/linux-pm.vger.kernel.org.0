Return-Path: <linux-pm+bounces-21730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A463A2F81F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 20:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827EE188989D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 19:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B41922C0;
	Mon, 10 Feb 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="n6DMcIHO"
X-Original-To: linux-pm@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361217E105;
	Mon, 10 Feb 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214115; cv=none; b=g8xlqJ5gIvdXUD8PFbP/jBLVLc1rdM+vqOA9j4yKmcwPVuALy9AjgQhH2mrnZt30Y5QEq477k/Sg7YR7fje8uwT47dcI7Yw0asSAPsS2li2Y8sbWHhDF+Fujp5jA1MCDqBwlrrr2Zbk/c+KR0xNBQvtFlxQdHIN0JQKZe9h6Qug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214115; c=relaxed/simple;
	bh=F9TNcoE8pCUSmMjWLOBOlXCKc+/DpC6SIhAeXtwFfq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WMrbnN8mJMXEG2AGlWnCx/J8vWqemboXP83EeZXDFsLL7HVx1ug1S0RbkqHqWBIboVZ9vE+uwORZvUcKeLeQwpc0d1r7ISnZcqDraUZtMIny3kefGjRj/KV5J/71Nr6vDGRls7tSm3AlGphPfFVuk/kF6JIkxPd50DBV926RxSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=n6DMcIHO; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7276FA037B;
	Mon, 10 Feb 2025 20:01:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=umBDdA7MKFQI8t0RyJeE
	BqV2fN8Tu7iXBtOUlukw9JM=; b=n6DMcIHOxd66k9cl8S0bzywqDmb/DjpZrdfm
	2mXLpbj1bcPgSxzNJ0imMgf+pK3vt8JyHSMG4Tv0VzaVFC7C8i4Av4/XT0kP46Fc
	5aHkMsai4EMNq6fTV+Kd84RhAK1fUa6ZKDkxSzb7HXzh+62sR6eqtZ0/ok8MM8Ku
	epGWLuAMubOzYGma862PL8gz7ie0OgXrRjnAn82rccEkEtj0Bo8xXoTHUjAbbZsl
	f+6e+BhfGuKmGdppsDWR5aJuCOrf3j7yP+zMsPVky0ZyDweJubkzgXh4R89q3dsf
	g23ZbVwUE1Bkqg/g/thw7XZIpEYU/HYVlgO0Kd5zq55f3h9ERK7ed/b+6hKkNzLp
	2PhphUx/QUyqkg5yNN8frvCZHygnsSjv1wHHAcV9QQDvXg81sLRRSD2bs5XT4t7x
	NGThU73SnAPZ17GIZulT4ZhtWuMmclYdYn5g6BYBZ2UXxLvATpw+0zw/uQckYI1i
	zVJumT1c432ScCZHkPxq1NKJ/zQczynDwS7kqThLEJD8J6yrRhT8oTZoTZw/LOMQ
	1y7pgprxobeXMkuJzm8zjVWPpFHPfNMOJmrjfhhSIX6iuvbIMDeLjmF9RbSW3oQA
	5NcS3K6TxRIXn6IQqP8LJO66/CD7WLKNZN/nRLLnLfSYYwWbe5z/OMcEH8iE7ufO
	pzLdSCQ=
Message-ID: <ee2afc4d-fe21-4ba9-8283-51a41f74937c@prolan.hu>
Date: Mon, 10 Feb 2025 20:01:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.14 v3 2/4] pm: runtime: Add new devm functions
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
References: <20250207124802.165408-1-csokas.bence@prolan.hu>
 <20250207124802.165408-3-csokas.bence@prolan.hu>
 <CAJZ5v0gEdo_BeZh2tnxJMzoosxL5zzJXyf6wi7SR9du7MoQmUw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <CAJZ5v0gEdo_BeZh2tnxJMzoosxL5zzJXyf6wi7SR9du7MoQmUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852617666

Hi,

On 2025. 02. 08. 12:30, Rafael J. Wysocki wrote:
> On Fri, Feb 7, 2025 at 1:48 PM Bence Csókás <csokas.bence@prolan.hu> wrote:
>>
>> Add `devm_pm_runtime_set_active()` and
>> `devm_pm_runtime_get_noresume()` for
>> simplifying common use cases in drivers.
>>
>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> 
> So I don't like this and it is not as straightforward as it looks, but
> let me have a look at the entire series again and see why you think
> this is useful.

What exactly don't you like? And did you have a chance to look at the 
rest of the series? I sent a cut-back version that should be easier to 
review (I took out the DMA parts):

https://lore.kernel.org/linux-kernel/20250210111008.248929-1-csokas.bence@prolan.hu/

Bence


