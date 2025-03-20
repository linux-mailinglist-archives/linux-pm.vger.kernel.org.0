Return-Path: <linux-pm+bounces-24353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DBFA6B123
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 23:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E787788684E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 22:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4399722A7FE;
	Thu, 20 Mar 2025 22:43:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5F1B664;
	Thu, 20 Mar 2025 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510581; cv=none; b=cBB/1rRxKjsiJ6bMXv3QxeJE2smBIj0U5Xums8dsuct1FbJu1Vp1PLSoX2HX9s6EHGk01qzExBfexIxRQIwaeYTbLTFJFgKOPp0JZ6F1+dyWUGxsI3IcqCHro9trMKp3/niZCoAsP0lEJfpK4l/RuooMY6l2JRsB37mKGC0+ycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510581; c=relaxed/simple;
	bh=9HnISz5Xm24XDuQV6I5n9bGkpRqy9DBw/a8/hH26MVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTgNLvVoYrLJiiJLDxjkB2OQhFBej0hSCvUlam0UdnDzJhRC1a0cY4sREwa55vnAr0mlj2VYPa231C55bNz2CFTGZsUvgWBQnWOklIjoKIU4fXnCAvbpQKs2mtPnE+7Zj1gAK2jXPPyBDbHbmCxrPriaAzdejN91KzljP0mvjDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFE30113E;
	Thu, 20 Mar 2025 15:43:05 -0700 (PDT)
Received: from [10.57.15.35] (unknown [10.57.15.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA8193F673;
	Thu, 20 Mar 2025 15:42:52 -0700 (PDT)
Message-ID: <6332a08a-8c80-41e8-b36a-96f358f4ea2c@arm.com>
Date: Thu, 20 Mar 2025 22:42:47 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/13] Add support for AMD hardware feedback interface
To: Mario Limonciello <superm1@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
 Huang Rui <ray.huang@amd.com>, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
References: <20250218190822.1039982-1-superm1@kernel.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250218190822.1039982-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 19:08, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
> provide behavioral classification and a dynamically updated ranking table
> for the scheduler to use when choosing cores for tasks.
> 
> Threads are classified during runtime into enumerated classes.
> Currently, the driver supports 3 classes (0 through 2). These classes
> represent thread performance/power characteristics that may benefit from
> special scheduling behaviors. The real-time thread classification is
> consumed by the operating system and is used to inform the scheduler of
> where the thread should be placed for optimal performance or energy efficiency.
> 
> The thread classification helps to select CPU from a ranking table that describes
> an efficiency and performance ranking for each classification from two dimensions.

Where is that happening in the series? (Using the per-thread classification
for task placement.)
Am I missing something?


