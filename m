Return-Path: <linux-pm+bounces-7912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FDD8C7865
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 16:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01576B212F7
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1818414A088;
	Thu, 16 May 2024 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rt6iIaG2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E8148FE8;
	Thu, 16 May 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715869524; cv=none; b=cXDJFO3hlb/lfVC8qgnEwn2dgJiEIKMMzS/TKXQflTC59kqEbRk1h8EkbUqlgcDwnjtLFb42ffDfGACvX32DV/NUrLq2IxS3BU4WR17M+c+cc9/8nLV5IhhoJnpDVCgQcMr8K6eVkQZI9lDMe8A2LVZyICTE6WnphH3474KVWhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715869524; c=relaxed/simple;
	bh=5fHQsIHYU8+nDkKcXAqHVb/v8aEp4fGKBTbCRFlPQK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tn5i4obAu/AoKgBzPc0+rjMpuI0aPmdeB+QtMf5pmM5Eopf/8c83Zdg0fppj8GepvnT/325Y640MoaWQtSTu6zrOD4iE7xNmPfvU/8xMAXBvzwga/qB8937dzOm/ogWlomJ7+N7OVh6B9ljsmMWCRsjxAZiiia/TGPz4AJ6MuXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rt6iIaG2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715869522; x=1747405522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5fHQsIHYU8+nDkKcXAqHVb/v8aEp4fGKBTbCRFlPQK8=;
  b=Rt6iIaG20ypT4IuiRbtyiPDaq3ub39xMAmhFwwK1LY2DDtwFagoF7yjt
   FJSZXrpWZHb6Nawe1J+8p737nWO9v/1CHY18rB9Gitxi5/3MSl1LSQUQD
   7FtGvVzC3tT7fmBmnTmpxcVWBiTHO2PJKdj3eQFzpbVk7GxPG4a2kSiNw
   jIaH0bZeiV4S/kWjMDdKQ3i9NwD/U5/K6SpOsGFa3Ezbr0UoPq6uiMpQ/
   6xiF8IBUjMxIWpLP5a22BUWgD+khV4Zu2lDdkSvig/GtGVnCPF70YVGck
   ZFRCfXJoSmaxZYvFEBfDF+m1MJQGvEJpCaWum6cSJnHTKX+caKnbC1SNb
   A==;
X-CSE-ConnectionGUID: qWKaFLebQSWb2e2KhKAo6w==
X-CSE-MsgGUID: RxshtPPwR3mAv64gsJo2og==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11827830"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="11827830"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 07:25:21 -0700
X-CSE-ConnectionGUID: w78hxxVoSamUbiU2MxckHA==
X-CSE-MsgGUID: Kf2qwgYsTLSbCoiVuUt6og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31547384"
Received: from josephjo-mobl1.amr.corp.intel.com (HELO desk) ([10.212.146.49])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 07:25:21 -0700
Date: Thu, 16 May 2024 07:25:13 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
Message-ID: <20240516142513.qqy7wbmja5frizuj@desk>
References: <20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
 <87h6f4jdrq.fsf@kernel.org>
 <878r0djxgc.fsf@kernel.org>
 <874jb0jzx5.fsf@kernel.org>
 <feaefaae-e25b-4a48-b6be-e20054f2c8df@intel.com>
 <20240515072231.z3wlyoblyc34ldmr@desk>
 <529C9374-DA6F-49C8-9B32-91741800F8E4@alien8.de>
 <20240515162747.6shmaoelc4mt7nro@desk>
 <878r0bhvjq.fsf@kernel.org>
 <20240516070315.swz2golcrfp3uvfd@desk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516070315.swz2golcrfp3uvfd@desk>

On Thu, May 16, 2024 at 12:03:22AM -0700, Pawan Gupta wrote:
> I am running the suspend test now and will update in the morning if I
> could reproduce the hang.

Completed 500 suspend iterations, but the hang is not reproduced :(
I have restarted the test.

BTW, could you please share your /proc/cmdline? Also, was there any
workload running with the suspend test? If I could not reproduce it in the
next run, I will run stress-ng with the suspend test.

