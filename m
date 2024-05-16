Return-Path: <linux-pm+bounces-7914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B7F8C79A1
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 17:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BC1283C36
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 15:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2737214D6FF;
	Thu, 16 May 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdwgMiBf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B61C14D452;
	Thu, 16 May 2024 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874119; cv=none; b=kFtWVSM4o5MC9XkUUJO60Qx4xZu8j+s9V0TJJLVHV13mfZhnyoDSI6TdtZzhHNyHvWGc36/Y5lqDIU2a9IePy2vGkxT/q4LbbXZ7RtM+B4mgxeeNRuMcUKom8OQr3QOyS0HThY0uXe5xwFnpagTHlJYpfvtDnBSgM28FlTlLky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874119; c=relaxed/simple;
	bh=Hn7/vCbl6NJlnjzeYD+Ur3zP/ut2JNfZwZRZ8ytN7LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw8Bkto6A84elmuKT80M244761LmbRkLv2PL2uRoPjbpb0J4u5XkTj47nvZn68ZeW1Pp0n4PnHYJeUQRnF/Z/MqgDdxyRjh4YzbtVpZkEUvyWtv9ZlHUxpCiKFuUthvBNe9kvB6Eze3c2SUKRIodsdWBAC83hfPNb8Qrg8OSCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdwgMiBf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715874118; x=1747410118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Hn7/vCbl6NJlnjzeYD+Ur3zP/ut2JNfZwZRZ8ytN7LI=;
  b=JdwgMiBfiZLsBCPF7TphMK5Nvz1UQjXqOb/eWONagf3l/Q8lXYaR1jBp
   /zgShH1SU73tvB33NLRUPYX0XAQBHmfy4B0Vh77CrpQZ0IdJrDQzQ2Rdv
   3+3KeT1X0hG9yNgWV/1tvWJBKv/ZLkT5BIeXilC4AjISgPJXIzsZYB2Ye
   3Lxez43TzlA+dshVaNTrRElVCos8FV5aUjRlKbynh6+YxIisMATl8mWP3
   rtPzbLVmF4u7mGAmmtLAhfU7pFSs24/tNPabQy9nIaZdR3Lg+L0VuEFWN
   zKqmqFi/zS6gpwLEDoJYqEx71rBovwPQC/gBC4jzu8tghI/UJddnkoxuY
   Q==;
X-CSE-ConnectionGUID: i+BGohMvSveJGos3VltXcQ==
X-CSE-MsgGUID: eQklBbbwSJe3BzOQBbqf4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23403787"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="23403787"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 08:41:57 -0700
X-CSE-ConnectionGUID: UjuNcKFuSGGH3e6htSU5PQ==
X-CSE-MsgGUID: h9KSI5c5Qzi2CoBjhYktow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="62301778"
Received: from josephjo-mobl1.amr.corp.intel.com (HELO desk) ([10.212.146.49])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 08:41:57 -0700
Date: Thu, 16 May 2024 08:41:50 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
Message-ID: <20240516154150.46w4h2ro6sm5yyzx@desk>
References: <878r0djxgc.fsf@kernel.org>
 <874jb0jzx5.fsf@kernel.org>
 <feaefaae-e25b-4a48-b6be-e20054f2c8df@intel.com>
 <20240515072231.z3wlyoblyc34ldmr@desk>
 <529C9374-DA6F-49C8-9B32-91741800F8E4@alien8.de>
 <20240515162747.6shmaoelc4mt7nro@desk>
 <878r0bhvjq.fsf@kernel.org>
 <20240516070315.swz2golcrfp3uvfd@desk>
 <20240516142513.qqy7wbmja5frizuj@desk>
 <ab00d8e5-8400-451e-9435-becb0b3fa80c@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab00d8e5-8400-451e-9435-becb0b3fa80c@intel.com>

On Thu, May 16, 2024 at 07:32:54AM -0700, Dave Hansen wrote:
> On 5/16/24 07:25, Pawan Gupta wrote:
> > On Thu, May 16, 2024 at 12:03:22AM -0700, Pawan Gupta wrote:
> >> I am running the suspend test now and will update in the morning if I
> >> could reproduce the hang.
> > Completed 500 suspend iterations, but the hang is not reproduced 🙁
> > I have restarted the test.
> > 
> > BTW, could you please share your /proc/cmdline? Also, was there any
> > workload running with the suspend test? If I could not reproduce it in the
> > next run, I will run stress-ng with the suspend test.
> 
> I'd suggest two things:
> 
>   * Run everything in tools/testing/selftests/x86 in a loop during the
>     suspend test.
>   * Run perf or something else to generate some NMIs.

Will do.

> Those will ensure the dark corners of the entry code are being
> sufficiently prodded.
> 
> I also have sneaking suspicion that microcode updates during resume are
> the aggravating factor.

Lets see if Kalle is able to reproduce the hang with "dis_ucode_ldr".

