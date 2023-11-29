Return-Path: <linux-pm+bounces-509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C52357FDAC0
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 16:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7031CB210D8
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 15:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE6D37171;
	Wed, 29 Nov 2023 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMY33eFM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDF7D66;
	Wed, 29 Nov 2023 07:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701270345; x=1732806345;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fuBRJoZc8zYA4dA1/vrdLgmtDN9b8lrYs3XPfP7VKUY=;
  b=JMY33eFMy0Rhe4IsJiRejHdrcz5bdURd+g2rKsypW/bMw5Gh1Ke/Jn12
   j/LeT/+cahKQUVc+5AJ4tHDblsFxlGoIIVnswi7VMt0fKdYN0Tl3ZCZET
   wrdm16ju23cFbkSbxEMwO/gFj3TtWkmUqxTIUUX8dxDMFsUs1CsXOZAX8
   hBKqz8ff4TzZ2W5jlOhEesL8ipvYb6yoWeikqyVIcFYSh/JNSvhRenDhQ
   wTCGi4G0WL35Hu5Z2gRdL9Cg+7VAO/JenixsjPboEeBBh8ztpZehSgZnE
   RhoYHt5dJPzelbBg402P8UNJJwDpoTm1qWnZ3N0OQLBvAjHfAwW2eByjS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="378207311"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="378207311"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 07:05:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="892479673"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="892479673"
Received: from besamani-mobl2.amr.corp.intel.com (HELO [10.212.113.90]) ([10.212.113.90])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 07:05:43 -0800
Message-ID: <a106fb4733d0a3f0d6d5792705cdb5cee13731f8.camel@linux.intel.com>
Subject: Re: Fwd: Intel hybrid CPU scheduler always prefers E cores
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Tim Chen <tim.c.chen@linux.intel.com>, Ramses <ramses@well-founded.dev>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Regressions
 <regressions@lists.linux.dev>,  Linux Power Management
 <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>,  Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, Yu Chen <yu.c.chen@intel.com>
Date: Wed, 29 Nov 2023 10:05:42 -0500
In-Reply-To: <c2a9ceb3d7b1f384ad94d10b7058bb1cebea3d07.camel@linux.intel.com>
References: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com>
	 <b2b9121c6d2003b45f7fde6a97bb479a1ed634c7.camel@linux.intel.com>
	 <NkN3JYx--3-9@well-founded.dev>
	 <c2a9ceb3d7b1f384ad94d10b7058bb1cebea3d07.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-28 at 15:10 -0800, Tim Chen wrote:
> On Tue, 2023-11-28 at 23:33 +0100, Ramses wrote:
>=20
> > I applied the patch on top of 6.6.2, but unfortunately I see more
> > or less the same behaviour as before, with single-threaded CPU-
> > bound tasks running almost exclusively on E cores.
> >=20
> > Ramses
>=20
> I suspect that you may have other issues. I wonder if CPU priorities
> are getting
> assigned properly on your system.
>=20
> Saw in the original bugzilla=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218195
> that you don't see /proc/sys/kernel/sched_itmt_enabled which
> may be a symptom of such a problem.
>=20
> +Srinivas, is there something Ramses can do to help
> find out if there are issues with cppc?
I have updated the bugzilla with the findings. The ACPI config on this
system is telling us that CPPC v2 is not supported. Current
implementation depends on CPPC v2.

Even in 6.4 kernel, ITMT is not enabled.

Thanks,
Srinivas


>=20
> Tim
>=20


