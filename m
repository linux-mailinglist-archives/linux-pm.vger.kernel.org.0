Return-Path: <linux-pm+bounces-39160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7770EC9F272
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 14:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC763A6619
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C702FB621;
	Wed,  3 Dec 2025 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEC1Gztc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CC64204E;
	Wed,  3 Dec 2025 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768979; cv=none; b=WIZg67uqlzb0f6+Tuyh3reAg7EB2dLy3RDjeF8AwJuyPmgsDViAIcFFQ0SElrbUBemQRPUPU9F9p8T6IMoZiO0Hn1Xe7NOMDAh9IRsTZ90rkdBJCnMlZIDz7ihxrkHHOpP/DTN1h8W3q58Cgzy91PkoCcgP9d+Wt3Rm5awzbIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768979; c=relaxed/simple;
	bh=D4wpFHPA+FGGUzUx1VmzoaeL9TkCmQVcOmbY0jYZGiM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F1RceT/pbdi3oCztH5czjxgwbsDN4OMxs/iOSEA3GbJfxewocORqEw+r8z1fKFX+t/EzGpFtAxEfz6XYV0mNpDvVxHQRIo5ZvL1uKvBS9FtH9iuHaRLP0dhOQYmT9KeeTKIDCmfJAwwExMB2MvhbgtOfSB+oKuLaJK5TaeHMn+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEC1Gztc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764768977; x=1796304977;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=D4wpFHPA+FGGUzUx1VmzoaeL9TkCmQVcOmbY0jYZGiM=;
  b=SEC1GztcPcG7O8ssA+AaeWpSBSQJrKMQqOxHNZDt4Ss2nsTnA7dL8w5Y
   gu1IvH+/eMygo7jqsx5YjrtXYNyYm/Uwt9ZRra8qaUVinA9t5UaoNDWLt
   gkKcGF7MEZ5qiHM3giL+BRYPx3R4GWdpIBTFJXTaY6rOqPVdjnORLchfT
   NCdCOKHlQUrorrdUIoraS5Sg1XvtceyJDmEsFDXTZ+HtD6GaYIWvbnn/3
   r21EQ5A9tZw2gz6IJjeq8I5E/P33NWcK3wlocBAcL124S+EXStMMmyC/N
   oCyms1aeFkZZlV1erYenKdxwbtZ2Q0FSxHGec1Gl8hYuk9Qwc0yPNPovy
   g==;
X-CSE-ConnectionGUID: 8NvXbJq2S4e79cyui3fqtA==
X-CSE-MsgGUID: YACfaEICQam3h6lBtlFpfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84353556"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="84353556"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 05:36:16 -0800
X-CSE-ConnectionGUID: ZSt/L78JTma6XSExcNMW/A==
X-CSE-MsgGUID: 72Zg5L9nQfmljVMQepAE/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; 
   d="scan'208";a="194707155"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.226])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 05:36:12 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 brauner@kernel.org
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "Saarinen,  Jani" <jani.saarinen@intel.com>, "Kurmi, Suresh Kumar"
 <suresh.kumar.kurmi@intel.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: BISECTED REGRESSION on v6.18 (was: REGRESSION on drm-tip)
In-Reply-To: <c711e3ac455a552c130851d7a45916a3ac992390@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <03c013c0-be12-42ab-91d1-f87395c890e3@intel.com>
 <c711e3ac455a552c130851d7a45916a3ac992390@intel.com>
Date: Wed, 03 Dec 2025 15:36:09 +0200
Message-ID: <51f6228d8bb6df524995b5ad4c49cbdfcbafb952@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 03 Dec 2025, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Thu, 27 Nov 2025, "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com> wrote:
>> Hello Christian,
>>
>> This is Chaitanya (again!).
>>
>> This mail is regarding another regression we are seeing in our CI 
>> runs[1] on drm-tip (with both xe and i915).
>
> Referring to drm-tip is downplaying the problem. The bisected regression
> is in v6.18 release. It's breaking suspend/resume across a lot of
> platforms on two drivers, i915 and xe.
>
> a3f8f8662771 ("power: always freeze efivarfs")
>
> As far as regressions go, it's pretty bad. Please prioritize.

Added some missing Cc's.

>
>
> BR,
> Jani.
>
>
>
>>
>> `````````````````````````````````````````````````````````````````````````````````
>> <4> [157.687644] ------------[ cut here ]------------
>> <4> [157.687768] WARNING: CPU: 5 PID: 2277 at kernel/freezer.c:139 
>> __set_task_frozen+0x7f/0xb0
>> ...
>> <4> [157.687923] PKRU: 55555554
>> <4> [157.687924] Call Trace:
>> <4> [157.687925]  <TASK>
>> <4> [157.687926]  ? __pfx___set_task_frozen+0x10/0x10
>> <4> [157.687929]  task_call_func+0x6d/0x120
>> <4> [157.687932]  ? cgroup_freezing+0x89/0x200
>> <4> [157.687937]  freeze_task+0x98/0x100
>> <4> [157.687940]  try_to_freeze_tasks+0xd2/0x440
>> <4> [157.687946]  freeze_processes+0x56/0xd0
>> <4> [157.687948]  hibernate+0x129/0x4a0
>> <4> [157.687951]  state_store+0xd3/0xe0
>> <4> [157.687954]  kobj_attr_store+0x12/0x40
>> <4> [157.687959]  sysfs_kf_write+0x4d/0x80
>> <4> [157.687963]  kernfs_fop_write_iter+0x188/0x240
>> <4> [157.687967]  vfs_write+0x283/0x540
>> <4> [157.687969]  ? free_to_partial_list+0x46d/0x640
>> <4> [157.687976]  ksys_write+0x6f/0xf0
>> <4> [157.687980]  __x64_sys_write+0x19/0x30
>> <4> [157.687982]  x64_sys_call+0x79/0x26a0
>> <4> [157.687984]  do_syscall_64+0x93/0xd60
>> <4> [157.687987]  ? putname+0x65/0x90
>> <4> [157.687990]  ? kmem_cache_free+0x553/0x680
>> <4> [157.687995]  ? putname+0x65/0x90
>> <4> [157.687997]  ? putname+0x65/0x90
>> <4> [157.687999]  ? do_sys_openat2+0x8b/0xd0
>> <4> [157.688003]  ? __x64_sys_openat+0x54/0xa0
>> <4> [157.688007]  ? do_syscall_64+0x1b7/0xd60
>> <4> [157.688009]  ? __fput+0x1bf/0x2f0
>> <4> [157.688012]  ? fput_close_sync+0x3d/0xa0
>> <4> [157.688015]  ? __x64_sys_close+0x3e/0x90
>> <4> [157.688017]  ? do_syscall_64+0x1b7/0xd60
>> <4> [157.688019]  ? putname+0x65/0x90
>> <4> [157.688021]  ? putname+0x65/0x90
>> <4> [157.688023]  ? do_sys_openat2+0x8b/0xd0
>> <4> [157.688024]  ? __fput+0x1bf/0x2f0
>> <4> [157.688028]  ? __x64_sys_openat+0x54/0xa0
>> <4> [157.688032]  ? do_syscall_64+0x1b7/0xd60
>> <4> [157.688034]  ? do_syscall_64+0x1b7/0xd60
>> <4> [157.688036]  ? irqentry_exit+0x77/0xb0
>> <4> [157.688038]  ? exc_page_fault+0xbd/0x2c0
>> <4> [157.688042]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> <4> [157.688044] RIP: 0033:0x72523c91c574
>> `````````````````````````````````````````````````````````````````````````````````
>> Details log can be found in [2].
>>
>> After bisecting the tree, the following patch [3] seems to be the first 
>> "bad" commit
>>
>> `````````````````````````````````````````````````````````````````````````````````````````````````````````
>> commit a3f8f8662771285511ae26c4c8d3ba1cd22159b9
>> Author: Christian Brauner <brauner@kernel.org>
>> Date:   Wed Nov 5 14:39:45 2025 +0100
>>
>>      power: always freeze efivarfs
>> `````````````````````````````````````````````````````````````````````````````````````````````````````````
>>
>> We also verified that if we revert the patch the issue is not seen.
>>
>> Could you please check why the patch causes this regression and provide 
>> a fix if necessary?
>>
>> Thank you.
>>
>> Regards
>>
>> Chaitanya
>>
>> [1]
>> https://intel-gfx-ci.01.org/tree/drm-tip/index.html?testfilter=suspend
>> [2]
>> https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_17595/shard-mtlp-6/igt@gem_exec_suspend@basic-s4-devices.html
>> [3] 
>> https://gitlab.com/freedesktop-mirror/drm-tip/-/commit/a3f8f8662771285511ae26c4c8d3ba1cd22159b9

-- 
Jani Nikula, Intel

