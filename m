Return-Path: <linux-pm+bounces-9401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 636FB90C265
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 05:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD790B22AD2
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 03:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E33B19B5A7;
	Tue, 18 Jun 2024 03:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2L22yhI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD719B5A1;
	Tue, 18 Jun 2024 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718680778; cv=none; b=KW1vXDTvPVr6U/0Vc20o2YTLFAI/4XrpGHUtuc+nfHL7ybEXj/91lH+w+dfMSkILaYXcbzG8ahrDgCpkEur9HAyMU1RY215kUu6tMHGZeMby4TpRvqJY8iXFu8/8H4lcBKeQz0/YVOYdAHm9e0RkfnyBfpxx17KlRao4asEE/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718680778; c=relaxed/simple;
	bh=99N3wYgXfmP8yLL2zt9y6M00HE8MEtz5oXGsxIcsNAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOSEesOtceyjhdFUJKH/pH/5Y4uPdTHAI4ATHC1ffd4I0vogLXgXQfUNVY+KvRXfBE0dEF2RfC5bXtkik4EJUqs1Te4cfr4b4ChviGLbfLObbiSryTxFsF+tI7RIzvhHj4Y3b9htNXEXq+FuNzAoIrTESARkaapyvDWTAKJZdpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2L22yhI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718680777; x=1750216777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=99N3wYgXfmP8yLL2zt9y6M00HE8MEtz5oXGsxIcsNAY=;
  b=U2L22yhIs9G4LTakxLYv0a6rgtClfDmeOtWTGn96HQGlb8BR/iSS0JDT
   90ZJxHgWusV1iFhSwPMZt0ky14uKc0GgmAcK1nITbDAQ6E+yx2wSLPqc9
   z2c2gWk5hhbRg1DVWLHij2mvgQRET2QBupS+v7ZFpJBS7wZrt3FR59vi5
   4BvIT5hdr29x18HIWGDE6kPhnvf+JKWDEdnOrW+gMQrbWkpnP5KUajR56
   /77vewWiTRG/m6mA+5kKrCuifky+BWPN2mrTRe4Ao1TdMj27INxriLezs
   ruNNdKNmoNcRKjopG5OSGksy4t1o+qiWbXVHrOu/qYrqkca4zmQBRKfIC
   Q==;
X-CSE-ConnectionGUID: mlXVFsAHQUSD+Jn4vJycHw==
X-CSE-MsgGUID: LBxU4RPcQzOZD/CZnKi5SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="26165737"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="26165737"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 20:19:36 -0700
X-CSE-ConnectionGUID: TIYcuCUNSlK3O7/CnpfH8Q==
X-CSE-MsgGUID: 5ANnw6iAS7uqRzdTDXiOiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41516482"
Received: from jdoman-desk1.amr.corp.intel.com (HELO desk) ([10.124.220.84])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 20:19:35 -0700
Date: Mon, 17 Jun 2024 20:19:24 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Hansen, Dave" <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH PATCH 8/9] x86/bugs: Declutter vulnerable CPU list
Message-ID: <20240618031924.be57xugsmcq4kmxh@desk>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-8-b88998c01e76@linux.intel.com>
 <fb789f0a-0c80-49f3-ab7e-d22fc2793a49@intel.com>
 <20240617235216.qqvfh2nvffuh7oot@desk>
 <SJ1PR11MB6083ECEC27A376E2CA898F93FCCE2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083ECEC27A376E2CA898F93FCCE2@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Tue, Jun 18, 2024 at 12:08:18AM +0000, Luck, Tony wrote:
> > $ size vmlinux.before vmlinux.after
> > text		data		bss		dec		hex	filename
> > 33128289        23039446        19767300        75935035        486ad3b vmlinux.before
> > 33128289        23039446        19767300        75935035        486ad3b vmlinux.after
> 
> Same size != same contents.

Right. I did get that thought, but did not act on it :\

> What if you:
> 
> $ cmp -l arch/x86/kernel/cpu/before-common.o arch/x86/kernel/cpu/after-common.o
> 
> Or
> 
> $ diff <(objdump -d arch/x86/kernel/cpu/before-common.o) <(objdump -d arch/x86/kernel/cpu/after-common.o)

Thanks for pointers. I am not seeing any difference in the disassembly too.

