Return-Path: <linux-pm+bounces-18556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6867D9E3E67
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 16:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE80282EB6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C931FAC30;
	Wed,  4 Dec 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZy0pfLe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E226187561;
	Wed,  4 Dec 2024 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326522; cv=none; b=XZ962z7F6CInYdz2kNIlXQu18LmkM6fkWCuSxobjduj0ifzPFpdCW8zf08fhyevIlRcWhUFYOOi+Pttz5xbXIqVGBEokv/N0zlHHgYgF4BaYSfEdHJm6HAvLpBqiF4/+5pH8UcG4wlG808KkRNeziiuAAVl2/KHjQmt7RmNvMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326522; c=relaxed/simple;
	bh=MrTgvWmbwwAjTN5G3G5cJ1/uSq1bFHVmglgj8+GwzEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h440GLyLQMyMuDRpoBwPC2liq+6eipLTKEl6uW1SR6mgpNfXcFJ2AqHTgrC75Rl2+gHSL5wchuJwRwvglZmOB41ndCzGeLZMKfdKTypAh4B/P/LcgfJf0dMpAeL+eb9jFiHzmYfalI2PctYuflRvkSH0NpWc6UJcHsWYYF/ngcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZy0pfLe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733326521; x=1764862521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MrTgvWmbwwAjTN5G3G5cJ1/uSq1bFHVmglgj8+GwzEo=;
  b=ZZy0pfLeh+tA84TIypemKVWZhyLy/IY8iM/7DuDPbCU3H9wK2HO0Tsrl
   wMg/IYosuZ/D4Tnn0SrY0jr7qhhJVLCRo5okleZEgbBdUmX4ZQyoBRHDO
   cIyBmEcS70zJeaMsx+ZU30a5JvjuxNZtq9qH/Hb/qUVScfF5bvUMS0ZRG
   2XHrjQ/HaAQWc3gKT/cZEf9MGMU+m0JClaKAMTM1nJCTi51+CW5GG1dQB
   xh+wtZiFMcYloZQwTX0wW0prC56yCb3OB1jq5m+17Am2e+yU5QDdLZwQW
   0SD8NBJu04SFGpVSujCwUkufHbzXKxZxQylQexssR9JqNRajJ6xDctdPq
   Q==;
X-CSE-ConnectionGUID: r9EwxRQIThqF/r4aExsSVw==
X-CSE-MsgGUID: RO3tEqKPT7mr/4ktSToobw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="51015795"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="51015795"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 07:35:20 -0800
X-CSE-ConnectionGUID: 8DWI0JlUS8SyHhDjzIUMTQ==
X-CSE-MsgGUID: YCAN8GBcRW+cSnbHVU3OgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93672275"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO [10.245.245.116]) ([10.245.245.116])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 07:35:18 -0800
Message-ID: <0010a78d-2c84-4e78-8c62-163dc9ebb82e@linux.intel.com>
Date: Wed, 4 Dec 2024 16:35:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] SRF: Fix offline CPU preventing pc6 entry
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, gautham.shenoy@amd.com, tglx@linutronix.de,
 len.brown@intel.com, artem.bityutskiy@linux.intel.com
References: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com>
 <e45dbc7c-5506-4343-b6b1-ba610e5088af@intel.com>
Content-Language: en-US
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
In-Reply-To: <e45dbc7c-5506-4343-b6b1-ba610e5088af@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Hey Patryk,
>
> I know this series is up to v8 and we all know what it's about. But it
> would be much appreciated in the future if you could send along a cover
> letter. It's important and really does help reviewers dive into a series
> more efficiently.

ACK. I'll keep that in mind for the next time. Thanks.


