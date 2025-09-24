Return-Path: <linux-pm+bounces-35293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E94B9B7DB
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 20:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4EB3BEE20
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC10A20FA81;
	Wed, 24 Sep 2025 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blzgtiUE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45BE1FDD;
	Wed, 24 Sep 2025 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738760; cv=none; b=Q6tMqcTnWs04i9OngKrV/TI2GJ2X90RNBhCOOYwHqO3lrdhYSY8Dijdnghf4zXpx4oLVCLGYtei3b/pCILmhElhZMdcWiktYt7c+gNf94IilhykjhPH/JZkwj8G2KmTW6Grxj8UbENfBw78ZGxUsyKqUUum2m2k5EpBtmaZIv5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738760; c=relaxed/simple;
	bh=bWIP0s6qalOqwGClINFJAxRrfc9GlOcLTVMnDwKSddc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWLYCMUlSWH98XNA4DfFRqUDBJsUQuRnqP0FvLvsiKDVBZCbFUksxlJtE4lPsCx/X+RuV1QxcHQzpg9l5Hv2MIz7SgPzwF1GdUCyx+qoxfgn2VYUc/F5S4B/4GQ6tW6msxM2E84Iu5GvVLJrihtQZ3As0uSuulcqlcoBnrmQTwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blzgtiUE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758738759; x=1790274759;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bWIP0s6qalOqwGClINFJAxRrfc9GlOcLTVMnDwKSddc=;
  b=blzgtiUEGnx8qO6OTLP9ztwgvDs3/JLki4ZipS/fC0i2ZhruVF2d5pc9
   mPZTRXeHgiv47pjSdW1gyB8yy/VpDr6+0hNcROzuHYIhryo85zL0fF50v
   hbQZWdXi1vODBNU/Cq1TXpz1bBQieZ1Mpl8+P2WkFvLM+yEZHOSs05hqR
   zWPV+YKfkz61+PQ7itrPuke4wGlqWDrEkwAXRM+IzyX2Qp7vcLKdhK+Sc
   X6FykMNMmc8Zg2amkdIzSvz9hYviP6+VvJ2Z4OCMsuxdQ2vQLZyo8LR9W
   LvYxXrUMKQhwN8/OcsEbmABkDnU+pj5+jyARAaV/gdZiE1xEcD8nnRxKB
   Q==;
X-CSE-ConnectionGUID: hMI0beWjSWuBJ+q540HHwQ==
X-CSE-MsgGUID: xXA89S2uSXmpjFztJg/HfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="71291185"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="71291185"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 11:32:38 -0700
X-CSE-ConnectionGUID: gDmB2CbwT/+7lDKkxN4p+A==
X-CSE-MsgGUID: wmLqxbxnQieeaEOwqUbiyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="182386249"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.108.203]) ([10.125.108.203])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 11:32:37 -0700
Message-ID: <5490118a-7185-44fe-b816-b01c8ff75979@intel.com>
Date: Wed, 24 Sep 2025 11:32:36 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC 0/5] parker: PARtitioned KERnel
To: Fam Zheng <fam.zheng@bytedance.com>
Cc: linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
 linyongting@bytedance.com, songmuchun@bytedance.com,
 satish.kumar@bytedance.com, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, yuanzhu@bytedance.com,
 Ingo Molnar <mingo@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, fam@euphon.net,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, liangma@bytedance.com,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, guojinhui.liam@bytedance.com,
 linux-pm@vger.kernel.org, Thom Hughes <thom.hughes@bytedance.com>
References: <20250923153146.365015-1-fam.zheng@bytedance.com>
 <40419dea-666e-4a8d-97a7-fa571d7122f4@intel.com>
 <CAG+v+KZ4bRgVNiMDhNTeiOqqbEXCBD72K5SQZCo=m0xaQ2vauQ@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <CAG+v+KZ4bRgVNiMDhNTeiOqqbEXCBD72K5SQZCo=m0xaQ2vauQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/25 09:21, Fam Zheng wrote:
...
> The model and motivation here is not to split the domain and give
> different shares to different sysadmins, it's intended for one kernel
> to partition itself. I agree we shouldn't have different kernels here:
> one old, one new, one Linux, one Windows... All partitions should run
> a verified parker-aware kernel. Actually, it may be a good idea to
> force the same buildid in kexec between the boot kernel and secondary
> ones.
Uhhh.... From the cover letter:

> Another possible use case is for different kernel instances to have
> different performance tunings, CONFIG_ options, FDO/PGO according to
> the workload.

Wouldn't the buildid change with CONIFG_ options and FDO/PGO?

Thank you for posting this series. It's interesting and a thought
provoking. But, that's where it stops for me. I don't think this
approach has any future upstream. I probably won't look at it again,
even if it hits my inbox. (I hope it _isn't_ sent again unless there is
some *MAJOR* *MAJOR* change to the approach).

