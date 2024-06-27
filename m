Return-Path: <linux-pm+bounces-10132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC53591AD3F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 18:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E43281182
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23099199E92;
	Thu, 27 Jun 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K75O8/mF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6317A14EC40;
	Thu, 27 Jun 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507305; cv=none; b=cLqFiazJlfNGLOLTHMdxER7RUMZyQIpV+pOcbwSJmdhCXsBLYkJVoefgK5rJmnvRy8EVmuEqvQSApmWCTwNYsIDfKOcUNSZ9ixrEk9ABJzVEScvgZEBBViByIk6sFG/O45EZDi05TE10gm0hbW0wQ5kWRWtvzBMbGblwjSrFsog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507305; c=relaxed/simple;
	bh=p7aqannr0lUjLl+rcRoaZNni4CY6onv0/jo/CI7k+YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubqREzzIq4M0o00GeENdpv/hy5KhDVrUrakkTWvqGCE2KpyCCgLTrfGoofbykP6yDYG1HKTnSJBx1XRSk3Bjf9w6O1VwseYL0ah2Lb1UgTLmJFRlbqPmn2z+wM1jXnj7++v+hQM0dtaLvE+UJoDmY7QIJgA9CjKrSG/TrkqQwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K75O8/mF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719507304; x=1751043304;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p7aqannr0lUjLl+rcRoaZNni4CY6onv0/jo/CI7k+YI=;
  b=K75O8/mFlxGB4O0FU6b7w+gQ5V66QrWiipamy7PMnHxFKeVeOG2O9juB
   qrezs7Ny+bbq9+INQTUqwBYf0qp+eo79hmHATh72TsVic4h0cB9wqm480
   ku5aROHnZa+SJm1B60Y67vujkexiRgsFtz3BjW5AThVT4ffnar4IkpqXP
   kiJv8a8txJh6JMwIRzp6rL7s1ABFfAF7ZHmIQzG+xeJo74tEMRU1PhjfJ
   wsBpJi1+GRE1WKqYisciOnzHmAsDLNb1luDkfz0JNTFnaktul8BR/9+4d
   3AOSJeFCSyyQDpfbY1XqYp6hTeBXs2c7ZMT7DNxA/5HO5+a1fHJN6K2Ko
   A==;
X-CSE-ConnectionGUID: bjzMq5rqQpObjeJy3qTLvw==
X-CSE-MsgGUID: 5fzc/TXHTvWGnaumjZ7G0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16333524"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16333524"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 09:55:02 -0700
X-CSE-ConnectionGUID: LAye6lDRS7yps3/Tn0GO3A==
X-CSE-MsgGUID: Lhhhil/sQ9KWQ+DyT2dp+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="81988578"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 09:55:02 -0700
Received: from [10.212.74.51] (kliang2-mobl1.ccr.corp.intel.com [10.212.74.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 5AC5F20B5703;
	Thu, 27 Jun 2024 09:54:59 -0700 (PDT)
Message-ID: <6cfb0c8a-d739-4eef-bd25-32c84a38d6c7@linux.intel.com>
Date: Thu, 27 Jun 2024 12:54:57 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Add CPU-type to topology
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Brice Goglin
 <brice.goglin@gmail.com>,
 srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, daniel.sneddon@linux.intel.com, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <8d757ea3-87a3-4663-ac76-66b04e33e6b3@gmail.com>
 <20240619015315.3ei5f6rovzdnxovo@desk>
 <bc75ff55161671e4470849ed51baa547f619889d.camel@linux.intel.com>
 <0021f5f2-67c5-4b20-939d-48c9c1c60cdb@gmail.com>
 <1b99017a-6964-46de-ba3a-09552e7cf072@intel.com>
 <20240627125154.GA4743@ranerica-svr.sc.intel.com>
 <20240627132230.hondzls5bt3jspay@desk>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240627132230.hondzls5bt3jspay@desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-27 9:22 a.m., Pawan Gupta wrote:
> On Thu, Jun 27, 2024 at 05:51:54AM -0700, Ricardo Neri wrote:
>> ARM gives userspace specific details. This makes more sense to me. Instead
>> of reading these details, user space would have to infer these details if
>> a CPU type was given in sysfs.
>>
>> Having said that, Intel does have a CPUID leaf that gives the CPU type. Such
>> leaf also has a "Native Model ID". Exposing only the CPU type may not be
>> sufficient.
> 
> Do we know if there are applications that would benefit from this information?
> 

Perf should needs it in the kernel to distinguish between different type
of e-cores on ARL-H.

+Dapeng, who is working on ARL-H PMU enabling.

Thanks,
Kan

