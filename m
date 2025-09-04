Return-Path: <linux-pm+bounces-33892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30AB44854
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 23:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D45A425CA
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 21:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7F03081C2;
	Thu,  4 Sep 2025 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="X6EjsRL5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96C30499B
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020461; cv=none; b=USznSd9Ily0QdExhSe9feVvyE4Meb83Ob070kQhSqhbRkPgVuosG48wI+UQLbh3/Xsc0UaIEQyzHT/UsQy4S8FvxZrLkMw3TrzpmGgr4P/ZCkYwS2YOkmz8AY7tAZL/MY/6igdhB2TbXOrnpWHlPIg+F4Uh3S8roK2Se+1aLCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020461; c=relaxed/simple;
	bh=Px5pMVwkP7qMhlfsE2kHIeep1+DmdbNPPU3yrOlrtQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9jCufETf1VqcJJAW1xMcTcwOkTnUtzfFP8r6O0t7ybYsSD7//snR8epGcKZTr9/oI9fecBz0jQ2MV5bs9QesrmceMKMNrtOkOt+J02FbIlxuxnv+uYDCvweiIYbRo3q+5XCFTf0qpumo+LqqMGuw438CAESgaI3AYCo6MxMmG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=X6EjsRL5; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.8.212] (kenny-tx.gotdns.com [162.196.229.233])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cHsfy2r3pz1CJG;
	Thu,  4 Sep 2025 17:14:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1757020458; bh=Px5pMVwkP7qMhlfsE2kHIeep1+DmdbNPPU3yrOlrtQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=X6EjsRL5/ICcJ/xQypRcbKXP8TbT1/k0lTIvri2XtHfHWtcdLI8OaAnQXug9ZKzQV
	 wNIdyAx/te453durpc9+774YzPxNia4n4w/n7hi0uErKzDhhKIafKDFQDGFvSykWAj
	 ucqLjWgiLDqpR18ImJgPoaIUf6YuV7tgel52gG4M=
Message-ID: <9c22020a-84d9-492a-9f66-77b03fd81f87@panix.com>
Date: Thu, 4 Sep 2025 14:14:15 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: I think there's an issue with e3f1164fc9e ("PM: EM: Support late
 CPUs booting and capacity adjustment") if there's "holes" in your CPU
 topology
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, lukasz.luba@arm.com,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
 <27809ad9-2a35-475d-bef8-47a06e81d647@arm.com>
 <3d87a8c3-ecb9-4ee5-917c-f944915ee684@panix.com>
 <d23e3fe9-a8b8-49fd-8198-8868b41ee57f@arm.com>
 <03d67820-1e21-4361-b539-10b3ad346155@panix.com>
 <fbf349ec-f200-4eff-9a5b-6674a1eef52a@arm.com>
 <d9e8f92f-08d1-4006-accd-7a2b65b0bc6c@panix.com>
 <CAJZ5v0jmMbWjFZUZe56ZYzjsHYE1=fSb+5MWNLMN_K4ZCJPu+Q@mail.gmail.com>
 <e08a1424-6873-4c61-b97b-94c4e9a9077c@panix.com>
 <CAJZ5v0iw0SZAZd9HvwZdT=kqPq0AUJp_8LjWA6byOX3K4BVjrg@mail.gmail.com>
 <CAJZ5v0j8PGqHYN-XR=pkBCyvhN9kwUDupeU6MJTJoCbiJv8F7Q@mail.gmail.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <CAJZ5v0j8PGqHYN-XR=pkBCyvhN9kwUDupeU6MJTJoCbiJv8F7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Tested-by: Kenneth R. Crudup <kenny@panix.com>

On 9/4/25 10:40, Rafael J. Wysocki wrote:

> So AFAICS, this can be addressed by something like the attached patch
> (the majority of changes in it is just moving kerneldoc comments
> around and function renaming).
> 
> Since intel_pstate handles capacity updates itself, it can do without
> em_check_capacity_update().

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


