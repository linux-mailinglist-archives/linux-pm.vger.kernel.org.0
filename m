Return-Path: <linux-pm+bounces-33754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD5CB428DE
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 20:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D5A16B772
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 18:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E401B2D47E4;
	Wed,  3 Sep 2025 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="IJbYB7zu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FEB1547C9
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924755; cv=none; b=T87V7lEwoRKp2xSnKGqlWF3K4cVd+hYr/fZV3F2vQyl3HVSRIqFKis4z0tv3tFO9KUoJErv8Sx4Giea73hqb6oiMNNPBXqwRNI3S+CFx3cXPtFAj5JyWMyOMyWbA22vCu1ixCz1x4hxrDyiHbUBPIqDeKg7uRz+JzU26XZH+rZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924755; c=relaxed/simple;
	bh=fAa9OBjaARAyL3jWyV3710esExxwbPbYD/1c0AXfMuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=S4iFXZVZWSEyhpuvCE4EOnvlyEydVj6K4Rg5/xw3oa9UyouX07F52BJpgh4dOczWLfOAm3aM3qVzdHYYm3zqRZunXIB7RKKJBQEsGRV0XayQKNV2079N+2M17KK5brGHo/55/MZ+NwHyTGJYFffESTLzedl87Q8qRZArsrK1HRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=IJbYB7zu; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.36] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cHBGQ29JSzJZC;
	Wed,  3 Sep 2025 14:39:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1756924750; bh=fAa9OBjaARAyL3jWyV3710esExxwbPbYD/1c0AXfMuA=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=IJbYB7zuNIkkpV4DBMoXWz6eC77OR530765BsLYAePC7Ak9reh7+aKE8vfnxOIddz
	 J6D9LIDZcCbn/GwJLCWlKWVIHywXVCL14iqQXfhjqJOEkk1nlmp4x2tRlDEOpKyz3t
	 gOVrx9DzC4K2u33GwaMsR/A62qFk4OpZ7jRPE040=
Message-ID: <d9e8f92f-08d1-4006-accd-7a2b65b0bc6c@panix.com>
Date: Wed, 3 Sep 2025 11:39:09 -0700
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
To: Christian Loehle <christian.loehle@arm.com>, lukasz.luba@arm.com,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
 <27809ad9-2a35-475d-bef8-47a06e81d647@arm.com>
 <3d87a8c3-ecb9-4ee5-917c-f944915ee684@panix.com>
 <d23e3fe9-a8b8-49fd-8198-8868b41ee57f@arm.com>
 <03d67820-1e21-4361-b539-10b3ad346155@panix.com>
 <fbf349ec-f200-4eff-9a5b-6674a1eef52a@arm.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
Cc: Kenneth C <kenny@panix.com>
In-Reply-To: <fbf349ec-f200-4eff-9a5b-6674a1eef52a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/3/25 10:26, Christian Loehle wrote:

> Yeah looks like we're dropping that debug message.

Huh. Then I guess the whole thing's a non-issue after all- but that 
being said, the whole point of the reschedule is in case cores come up 
later, right? So in a case like mine, won't it just keep constantly 
rescheduling?

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


