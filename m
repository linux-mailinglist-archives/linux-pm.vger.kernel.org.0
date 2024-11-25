Return-Path: <linux-pm+bounces-18083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19E79D888F
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CCB28337A
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602441B2192;
	Mon, 25 Nov 2024 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRFEbkRd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C871B0F30;
	Mon, 25 Nov 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546598; cv=none; b=T4q1mm1+hZaPegOFIMtdlcXtz5ltN1qxsKZZRDDZkyyYojhgPvoNwgYACexQ77t+2N9c0NzLyN3wHOMGUUWZDl1J6W13F3HDn/fJq305Brbwq9N5cxD5U8T8vwVDXLKG8GCeC0XlqkO/3enjKYudNPQ68QK1LyVlScYxiUONOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546598; c=relaxed/simple;
	bh=t1dep8pStfXEPcSgbEEgowdaG41eydlmGCXSIfxnx9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImVOG+qw8ZTfZFK1gBE877umYem2jaWu1OJ3mwoeBasghNeJ/rTze6FmJjj8hN1ztsCyAfDFFXwLDVDyCTAi+Irn5X5APngXhnJrT8dHs7XPQhQKA6ETTx2rYp9VNj2KHRGU41oqm62S25XMS5Tpnq9Cw+g3hlayOI6EEOGW7Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRFEbkRd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732546596; x=1764082596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t1dep8pStfXEPcSgbEEgowdaG41eydlmGCXSIfxnx9k=;
  b=IRFEbkRdP9GNOw8WF+2BxkDWILBh6zXE/pGqN3I9XmYsJ51VNUmF9tX2
   iSt2XHf5JwGqIearD7sEcOStGQZIOM3rnaCeQ65J+wrrq0T6rPwzFFZ1n
   isRaat7TWvFH5q1gw/4xMwbKianNrm69xPDruU4B2hJw89YNcpVSU7+W+
   DNF5/06fByxNOqsD7dmK8JiOuLYfHSUr7VXS2BgbsMoosnbApN1sGrl7b
   IHsPWu2gME99oEmAy2Et09N90lfMJ18PsYQKOVrXLyi1iB2Os0BGX+kjC
   yRC3+Rv3iP0L390tK3NLZaxk9zrMRWcqX7JEuVFd/YnMeHbUE3OBdLt/I
   A==;
X-CSE-ConnectionGUID: TOszqrnjQW6CecCnkbASdQ==
X-CSE-MsgGUID: ot3xtuTVQ2KVjf6vylygtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="44051664"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="44051664"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 06:56:35 -0800
X-CSE-ConnectionGUID: 2EOnOIAWRYWVb3RZyr6fjQ==
X-CSE-MsgGUID: qjVBh5BgSxKHgVhdm0Ripg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="91078443"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.245.34]) ([10.245.245.34])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 06:56:30 -0800
Message-ID: <55157183-b756-454c-89b7-aba05a293b3f@linux.intel.com>
Date: Mon, 25 Nov 2024 15:56:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 8/8] acpi_idle: Disallow play_dead with FFH cstate
 on AMD platforms
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, len.brown@intel.com,
 artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
 tglx@linutronix.de, gautham.shenoy@amd.com
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-9-patryk.wlazlyn@linux.intel.com>
 <20241125135454.GE38837@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20241125135454.GE38837@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> So I don't like this. Less exceptions is better.
>
> This *SHOULD* never trigger on AMD anyway, because they recommend IO
> port C[23]. But if their partner BIOS engineer does a wobbly and they
> end up in MWAIT anyway, it *should* all work regardless.
Agreed.
I thought relaying on BIOS to not put FFH states there was a concern.
I believe Gautham confirmed that AMD would be fine executing that,
it's just that they prefer ioidle (or hlt?).

