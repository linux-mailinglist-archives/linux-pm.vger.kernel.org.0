Return-Path: <linux-pm+bounces-6411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A445D8A5194
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 15:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605A0288915
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BFA7318A;
	Mon, 15 Apr 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="I3AwUvCo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44E1BF2A
	for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187724; cv=none; b=Hzy9IykS3Jp1bEBasQl9tUCaipJb72mC0995q6B9AscV9gWKnbYjWMZVfMHewMf6xswWOq261NC4ISyXkPIVMmD7EO8p66D1+liqI5JtMZ/xIJaYZl/McB5Hmfmz3Kl0u4Q1m6ZBy97H9sHKAbMrQm1utkVRf9+yb6YGbjuk5hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187724; c=relaxed/simple;
	bh=ZBbeFVIOjyVaf4haKCpIxZa0Is1VqCVhp7Aov8IaPM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arCbUjqrwepxkTAcZhxfrF65+kUTX/gVd0dku1x+FTiawnKC8rXDCPL3edcDnakL+OU0HX234xc+Axl484YewG2VjV9fv8FOx4tL0qozQplbh/E20Awv0OCxRLp7XZug8hJXhY0Ja+kwyVaFSwsurC9649cy43LPITLSmZyrURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=I3AwUvCo; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.126.122] (ip72-219-82-239.oc.oc.cox.net [72.219.82.239])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4VJ7KW0Q47zLx7;
	Mon, 15 Apr 2024 09:28:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1713187711; bh=ZBbeFVIOjyVaf4haKCpIxZa0Is1VqCVhp7Aov8IaPM8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=I3AwUvCo7TXQAqgWQJURQ6yRZ9xLUwD97sNoUWOxmoXMLNt9AC8mrjpdMmL6EhfMx
	 LWBr8MSopb9EHOHIt/KIujnd+wOMsChebg+kDugBQJS+nr5AvP3q5uvBUnnMBWkoFI
	 gJ/L++lFzJeL1SDZXspRsD63C+qtP3qY1pkhxRu4=
Message-ID: <4548dee1-426f-4183-bf6f-4a62d35b9aa1@panix.com>
Date: Mon, 15 Apr 2024 06:28:29 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernels 6.8+ no longer resume fully after a hibernate
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
References: <b702c59f-7a5b-48f5-a726-a4840ce05c3f@panix.com>
 <CAJZ5v0j48UTHj1cFNUR=EUuW1zugYxktX_t_tJFhFG5rNExyWA@mail.gmail.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <CAJZ5v0j48UTHj1cFNUR=EUuW1zugYxktX_t_tJFhFG5rNExyWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/15/24 06:05, Rafael J. Wysocki wrote:

> Can you please try
> 
> # echo 0 > /sys/power/pm_async
> 
> and hibernate after that?
> 
> If it resumes correctly (and reproducibly), at least one device is
> resumed too early in the async case.

That worked. Nice, I can use that for a short-term fix.

Later this week I can help figure out which device(s) are the culprit; 
what method should I use to do that?

(I need hibernation as my laptop is one of those plagued with s2idle, 
which drains at ~1%/hr so I have it hibernate after 4 hrs of sleep)

-K

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

