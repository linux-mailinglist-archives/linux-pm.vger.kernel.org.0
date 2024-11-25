Return-Path: <linux-pm+bounces-18079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131239D884B
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9CE2862E3
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37EE1922E9;
	Mon, 25 Nov 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vk9mW/Vg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3716419;
	Mon, 25 Nov 2024 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545826; cv=none; b=HWn9c7SO6vxT/vCvSvWFyMRH22dwYLc3HrPGXBEBeZzNuOi/v4B81wQxh6t4Tpn/vN52tpxW4LkPOBU59HYPPteYEBXPTJbMY74pSvkanXrGeac61CvO3eamtUicWIuMyw3uJQnphTKOuWntMum5O/1MUMvIWAA89KuGc/g9crY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545826; c=relaxed/simple;
	bh=qNsE6z1OR/kXQFwA6ct5lLN1n1fexTCAU2iaWlnaU1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfK8q+sYSW2MN4yf1Fw+1qW8k2SyW8UEFCH9IppaEl3cVNHFNyasHTpIdNl4TwKZp5MApuV7zUhDlv81aMuIOSTERuDl9eTvacyelloFozggDD3blZaaVKPXJjq1GuRGoQ4Fzt7h9odL2K6L2v7SHQLupRoMEwgGOA3s0OPha0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vk9mW/Vg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732545826; x=1764081826;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qNsE6z1OR/kXQFwA6ct5lLN1n1fexTCAU2iaWlnaU1U=;
  b=Vk9mW/Vg1FsR6H1g8q3QKf8nIxh/mo4G5IpeiUzWY0SkC8pjGTTzee8t
   gpItC56JQkc0zzGrKK8gN6dfghXRFkoHGCB3GcoL9/Yx4aHX0RCy+cj6M
   HYI+q09mFSqR3X/3QwcPWlCyHoNDoDuAk31l5PR5Fxm7ikzjSetCyy98+
   4EJGumP5W6pR9YiODdN2j7RjzP2/YSgfNwIhoPXOfeCBOs6AKBEcmHBay
   1gzPTugTwysO6O99TTWMlf2+DadRk1seqsE4dIWCUto+0lewfCe8KLuR0
   7GraT9yXS0oR9XkB6bIz21cFlB8facIqzlQSqoZLhLKm31Dn8YZkdGKcy
   Q==;
X-CSE-ConnectionGUID: 77CvRG+dQHO3QJM5wq5V9g==
X-CSE-MsgGUID: jCuHsGTBSCOfRCD8ZZZpwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="36314821"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="36314821"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 06:43:45 -0800
X-CSE-ConnectionGUID: bpEC9gmkTkuGrFNsp9Q/Aw==
X-CSE-MsgGUID: bibrCFFmQc+Ko67uHax6BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="95699680"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.245.34]) ([10.245.245.34])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 06:43:40 -0800
Message-ID: <883447da-aeca-41ba-99ef-038dd8ddc6b3@linux.intel.com>
Date: Mon, 25 Nov 2024 15:43:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 5/8] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
 peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-6-patryk.wlazlyn@linux.intel.com>
 <CAJZ5v0iJ7hca68Pk1g1m=FNX6Psr3Ow-K7fvXZCcRM8PFM7EjQ@mail.gmail.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <CAJZ5v0iJ7hca68Pk1g1m=FNX6Psr3Ow-K7fvXZCcRM8PFM7EjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> If you first make intel_idle provide :enter_dead() for all CPUs on all
> platforms and implement it by calling mwait_play_dead_with_hint(), you
> won't need mwait_play_dead() any more.
Crossed my mind, but because mwait_play_dead doesn't filter on Intel
vendor specifically, I thought that I might break some edge case.


I am all for simplifying.

