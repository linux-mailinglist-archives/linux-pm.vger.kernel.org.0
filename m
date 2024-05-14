Return-Path: <linux-pm+bounces-7853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CD28C5A56
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 19:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0CD1F218AE
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEFE17F39E;
	Tue, 14 May 2024 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnNNCeR8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923605A0F9;
	Tue, 14 May 2024 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708225; cv=none; b=tvc9uP+eJa+YdkDlDEOmOI1qdmxhSiPCgbsgdi442IyzxeR7VDp+6/KYLadaYrqVgQzysC5VbjNzVQoxxrBSudDF10Uak6g4FR+TNFjsI1jp+/3FwTxU2ViJGz9YIfXZWgU0htmSOFoYV7LhKTFXPoDknOBpZJHjUUe9bbXAnuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708225; c=relaxed/simple;
	bh=wPB6xa73wP34r6zbh4porjOgJAG59GDOLNIbRQDTbQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARCPvhC/6dX3CBmogXq76/KP0bfmdp9Pxug30GTHjGfRsPC88tqw0ngCeut1XGhnrch3lM9LHIu8LuwZYDzzGJhjSIsdpnvCsToKYrcgWwTmTc3t9kEks/8Upd7Q5oV6YTW3jphTqhGwDs2T+YF365ixQH7zrYfr0HIciBmmghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnNNCeR8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715708225; x=1747244225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wPB6xa73wP34r6zbh4porjOgJAG59GDOLNIbRQDTbQ0=;
  b=OnNNCeR8YN+UBaVD6hnhBG+N7XddIaHQ+nzAgv7hSLlU8XolB88ITn8f
   DnXAbTaFDJqdnF3uAwSw7kHXi6aARF5h0aY1qdbfG8+wZNE0HNxctsPsb
   p5nL7Qpz5ae89DLn1PqtouFMuvGyFIQb2tc+ygmogD7t97ZmXqDW2YS3M
   e4IKL+xYAuoyjuwztUVta++CDNN6UAxoxhY9Kxrv4PKSqHCg1o6Y8jlAk
   NiJykDF06cVsXqgHFrbrvA55TZo/uv42kK/MEu0Rife8p0sOurUwuMfEz
   luMxSRtmhM7gJ9EXxYZrHSSQVCrmD0SpTT2EVVy4dQ9VXEl79kybmTAei
   g==;
X-CSE-ConnectionGUID: QrQzmpSjSq+Gr334/mh7PA==
X-CSE-MsgGUID: TPELW5kHQdOzMGEVT/SjHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11567019"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11567019"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 10:37:04 -0700
X-CSE-ConnectionGUID: WTAK3KpsRSyOj+59XQqPsQ==
X-CSE-MsgGUID: 4XFxSp5ASCSeknca0ToY4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35640473"
Received: from coreypet-mobl.amr.corp.intel.com (HELO desk) ([10.209.66.221])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 10:37:03 -0700
Date: Tue, 14 May 2024 10:36:44 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Kalle Valo <kvalo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
Message-ID: <20240514173644.ej56ve2bkk22e7r4@desk>
References: <87o79cjjik.fsf@kernel.org>
 <20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
 <20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
 <87h6f4jdrq.fsf@kernel.org>
 <878r0djxgc.fsf@kernel.org>
 <874jb0jzx5.fsf@kernel.org>
 <20240514160555.GCZkOL41oB3hBt45eO@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514160555.GCZkOL41oB3hBt45eO@fat_crate.local>

On Tue, May 14, 2024 at 06:05:55PM +0200, Borislav Petkov wrote:
> + Pawan.
> 
> Top-posting so that the whole email is unchanged.
> 
> Pawan, do you have a box like that to try to reproduce it on?

I just saw this, I am trying to reproduce this on my end.

