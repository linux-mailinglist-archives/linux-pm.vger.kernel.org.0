Return-Path: <linux-pm+bounces-36521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1633BF3C5C
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 23:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A31B4F2F89
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 21:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BA52DE71B;
	Mon, 20 Oct 2025 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KJ7t5kIS"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8EB21ABD7;
	Mon, 20 Oct 2025 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760996147; cv=none; b=HdYeSTKR43VMdchVYuScNPr38O+vN+hmqrtv9M7hq2sGu5FCJaj2x8mYoR0rminIyD6nP+PFm+I8e6edZEMVVOk7wYRbR+LHxQ/Dezchhe0U2RJvFq+4eyweU2uZ82Gy3IgL4Rq3RXnkD9zvhC/8UwUu/Zj6e7nUIWScSYV9hmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760996147; c=relaxed/simple;
	bh=O3gKx5Rj2VOWiy+K0H59IGE1QBF6cjEbBSIJ2Vxbkns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDUFVi3z1386202LP8dZCU3QNCBRte8KSj1BFtRtTmUNCXZDsaU4moXnTcaMt+LWzoy88MkgiyOwMs6INiQHuS9tEue1Te05jOSY3GSbOClUyUVjqaANcODFUYIAz1lUL7yEKYcSJMnpi+o47xaeyUccoEZc+q7Ol3DTUBfSZ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KJ7t5kIS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Apw2ko+AxH0CsXs7vBtTeoN9MrrD1jme4QTPmBSX9yA=; b=KJ7t5kIS0nuNSItWb5IMKwFEEb
	xd0Jah9HUvMknufapOJo3x+MpBXpdrA/1uV9QWhneBUCmjF0qW6QPohN0uHSrQRoSMsQ4zLn+dWuR
	9c+IVTrwGFri/X62NsZJQJWpJIMrJOlUuv207ZEcr0ho0SZ60mM6A5If9P9d+31tJn0TKkK+xG+dE
	3YmOJ0OS3T0JFcxZgGFeKk5BSGRwDQqAedT+Zjwjcx/0CyyN2ZFssp5tS6FXhxAR/3HWZ6Q9K5bzo
	HbE/NbjfYyTf3Y5D6LjN2g+o61ZCGj30+lp6abHVR7PLDTMdXHCCqhkF4UKnNh1wIbqj+JFOy0bm9
	AljfkgFw==;
Received: from [58.29.143.236] (helo=[192.168.1.7])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vAxXW-00CGru-9Z; Mon, 20 Oct 2025 23:35:38 +0200
Message-ID: <57a19531-de5f-44ee-bff0-d3a956131d29@igalia.com>
Date: Tue, 21 Oct 2025 06:35:31 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] PM: EM: Add an iterator and accessor for the
 performance domain
To: "Rafael J. Wysocki" <rafael@kernel.org>, kernel test robot <lkp@intel.com>
Cc: lukasz.luba@arm.com, len.brown@intel.com, pavel@kernel.org,
 oe-kbuild-all@lists.linux.dev, christian.loehle@arm.com, tj@kernel.org,
 kernel-dev@igalia.com, linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251014001055.772422-6-changwoo@igalia.com>
 <202510151232.UNZ2J7TZ-lkp@intel.com>
 <CAJZ5v0hAnKEUP7n_d3bzVEi0HGmgZXC-+U=_RmS1n0wGniv8qQ@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <CAJZ5v0hAnKEUP7n_d3bzVEi0HGmgZXC-+U=_RmS1n0wGniv8qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 10/21/25 02:44, Rafael J. Wysocki wrote:
> On Wed, Oct 15, 2025 at 6:50 AM kernel test robot <lkp@intel.com> wrote:
>>
>> Hi Changwoo,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on amd-pstate/linux-next]
>> [also build test ERROR on amd-pstate/bleeding-edge linus/master v6.18-rc1 next-20251014]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Changwoo-Min/PM-EM-Assign-a-unique-ID-when-creating-a-performance-domain/20251014-082420
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
>> patch link:    https://lore.kernel.org/r/20251014001055.772422-6-changwoo%40igalia.com
>> patch subject: [PATCH v5 05/10] PM: EM: Add an iterator and accessor for the performance domain
>> config: i386-buildonly-randconfig-001-20251015 (https://download.01.org/0day-ci/archive/20251015/202510151232.UNZ2J7TZ-lkp@intel.com/config)
>> compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251015/202510151232.UNZ2J7TZ-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202510151232.UNZ2J7TZ-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>>> kernel/power/energy_model.c:1003:5: error: redefinition of 'for_each_em_perf_domain'
>>      1003 | int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
>>           |     ^~~~~~~~~~~~~~~~~~~~~~~
>>     In file included from kernel/power/energy_model.c:20:
>>     kernel/power/em_netlink.h:18:5: note: previous definition of 'for_each_em_perf_domain' with type 'int(int (*)(struct em_perf_domain *, void *), void *)'
>>        18 | int for_each_em_perf_domain(int (*cb)(struct em_perf_domain*, void *),
>>           |     ^~~~~~~~~~~~~~~~~~~~~~~
>>>> kernel/power/energy_model.c:1022:24: error: redefinition of 'em_perf_domain_get_by_id'
>>      1022 | struct em_perf_domain *em_perf_domain_get_by_id(int id)
>>           |                        ^~~~~~~~~~~~~~~~~~~~~~~~
>>     kernel/power/em_netlink.h:24:24: note: previous definition of 'em_perf_domain_get_by_id' with type 'struct em_perf_domain *(int)'
>>        24 | struct em_perf_domain *em_perf_domain_get_by_id(int id)
>>           |                        ^~~~~~~~~~~~~~~~~~~~~~~~
>>
> 
> Please update the patch to address this report and resend it, thanks!

Sure, I will send v6 with these two fixes in.

Regards,
Changwoo Min

