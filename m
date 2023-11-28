Return-Path: <linux-pm+bounces-422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF847FCA99
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 00:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B685B214A6
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 23:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4DA57320;
	Tue, 28 Nov 2023 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsNWgoX+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27DE183;
	Tue, 28 Nov 2023 15:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701213049; x=1732749049;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ZQ7pjobZBzmg6qSv+zQYyIgwTJqgQXzpkZP/AuJ21dE=;
  b=CsNWgoX+w05LGvvSfxs19/yGqGSsvdqAyYbBxdyeb2cBB8iiNePdnZtE
   Hk6t1LsYOiSlSMxFY9o3GBYwjNGHy/MKC8IiDctGq9PGSiVuJvBl424d9
   Z/nW+aQYzmS50MOpr1ETkv/WUikIPCZC5ioNphLbKuCJsHewOOV43R4oH
   9hS5OGDIUV1oiHoLInRdSLSROMR8kloK8OP4YmO7cx312ooxuYV8Jl7Ne
   dZX+duwURImGKq8SvWOQM8Sfx+xyzdU1Y0cFNxwK1mI7NZVSrDmeBzQ83
   CsITKXrG7IsdFxJd+L2kJ/QLMmHYkpIAwesnpdTfNrycVIu2PnYMlSLac
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="479245605"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="479245605"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 15:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="892236858"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="892236858"
Received: from bmnolan-mobl.amr.corp.intel.com (HELO [10.209.106.201]) ([10.209.106.201])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 15:10:48 -0800
Message-ID: <c2a9ceb3d7b1f384ad94d10b7058bb1cebea3d07.camel@linux.intel.com>
Subject: Re: Fwd: Intel hybrid CPU scheduler always prefers E cores
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Ramses <ramses@well-founded.dev>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Regressions
 <regressions@lists.linux.dev>,  Linux Power Management
 <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>,  Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, Yu Chen
 <yu.c.chen@intel.com>, srinivas.pandruvada@linux.intel.com
Date: Tue, 28 Nov 2023 15:10:48 -0800
In-Reply-To: <NkN3JYx--3-9@well-founded.dev>
References: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com>
	 <b2b9121c6d2003b45f7fde6a97bb479a1ed634c7.camel@linux.intel.com>
	 <NkN3JYx--3-9@well-founded.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-28 at 23:33 +0100, Ramses wrote:

> I applied the patch on top of 6.6.2, but unfortunately I see more or less=
 the same behaviour as before, with single-threaded CPU-bound tasks running=
 almost exclusively on E cores.
>
> Ramses

I suspect that you may have other issues. I wonder if CPU priorities are ge=
tting
assigned properly on your system.

Saw in the original bugzilla=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D218195
that you don't see /proc/sys/kernel/sched_itmt_enabled which
may be a symptom of such a problem.

+Srinivas, is there something Ramses can do to help
find out if there are issues with cppc?

Tim

