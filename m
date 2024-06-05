Return-Path: <linux-pm+bounces-8642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D778FCDB9
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 14:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8F5284989
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 12:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249891ABCC6;
	Wed,  5 Jun 2024 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzLgZTVe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465A1ABE51;
	Wed,  5 Jun 2024 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589145; cv=none; b=KcZgVoRsW83gj1XYmKO6E4ToOXHCcXoezlHIQVAvi2HTpKSmgQufhs3yWYZtQTHQXIZOE3oISTZ3uytUjtM4z2zuuA76FlyP7LU4ilqz8j0C8/nR2OLPR65+X49Eo3iGffJklW5YDBReRqKBjlRDVj/uMqkO0zanjCm9e/z/GVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589145; c=relaxed/simple;
	bh=45Qxu3SUV28btauyWcXtEpirwvdvEsGhylhYJOYwpsw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DWmZAkoeMGu4e6NWJsjpT07Geb8QPGIhaX/DJLlR+TBeEJCqEWT66Vfr68XfO9poyfGKcssCCT4O0/zV53gAt4ggqO9Lw4zfzMdJEngLDp4xDJBCqWkSHaKwF4iRloynye0SW1mkkdD+H4foLMVvCH3oHJ1NKihx5g3iXSv5FcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzLgZTVe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717589143; x=1749125143;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=45Qxu3SUV28btauyWcXtEpirwvdvEsGhylhYJOYwpsw=;
  b=ZzLgZTVeaEo6W7PmgA99YFojZJX2n+uIMPrSYUdLi53cG7z7geMw2Y8S
   A5f0oqQ0bhwokAyCJ3zCsQbxAM/mGhAWFWLyhyOnuah2W8ys9u6Tyzr8/
   HX7vOMfoZ3YWTabgx/4LWW1qo52enkVzLcx/dRw/bq3ZN2KJDSAvJR9Gz
   pN+fwevipiFuMV8m8BiKced/F/bgWFYqou16J7KBHW5MRaKsmK5Fms1F9
   JAwXkKqPeTjzFEXC9eDM/HGs/qZCiclPpNOe0FyIAv+2zdVtZRSC5+hVR
   mmfrNgpLRo1RmJelCMXAvQ1VsX07Bv/VOVDbcGn10qRltD5zMM0LWG1j+
   g==;
X-CSE-ConnectionGUID: avP4x3BEQTG6TxNiIXvO7g==
X-CSE-MsgGUID: I/Bq0LATSk+jBg8PF2NaIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="17982309"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="17982309"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 05:05:42 -0700
X-CSE-ConnectionGUID: XHxk9G4XTL6rHgVPI6fowA==
X-CSE-MsgGUID: eUfEBgsWTxGiwqBGB9eF/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37577917"
Received: from salimix-mobl.ger.corp.intel.com ([10.215.124.113])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 05:05:39 -0700
Message-ID: <a2f992adc034063de7f63e9065976f39f9929503.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Xi Ruoyao <xry111@xry111.site>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Date: Wed, 05 Jun 2024 05:05:30 -0700
In-Reply-To: <1031cc4e4b507628531d9115ce7e4bc588dbab1c.camel@xry111.site>
References: <13494237.uLZWGnKmhe@kreacher> <8366982.T7Z3S40VBb@kreacher>
	 <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
	 <6d5ee74605bd9574baa5ed111cb54e959414437a.camel@linux.intel.com>
	 <6ebadacd8aaa307a5766cdb1b4d4a5c69acd87ac.camel@xry111.site>
	 <30a30c5107a47a2cc3fd39306728f70dd649d7fe.camel@linux.intel.com>
	 <f382e06635b3b52841d1e0c11dcf639d225edae0.camel@xry111.site>
	 <29d69252dcdc398f147c9139a8666d09e7bd831d.camel@linux.intel.com>
	 <0324bc3a88654855719cd48a5ed69a34eea31037.camel@xry111.site>
	 <c3526e7a0e80ec1a3a011259c38ab4b772040ea4.camel@linux.intel.com>
	 <48eba83030e155f703b4248e9c1ae65aa44b1a83.camel@xry111.site>
	 <CAJZ5v0jjLgG3VY_kBYc4mTrL2ybD2LfBTk2_H7xY0+Aq5g827A@mail.gmail.com>
	 <f34c20ae3feac0e3570125f124e440d51c5e4d9b.camel@linux.intel.com>
	 <1da736da33a61de92314934ecf7fa0420d6d6b81.camel@linux.intel.com>
	 <aa643910265b9d92a397d5148b31d37b2c421b8b.camel@xry111.site>
	 <63e98f2151ef64de92cf7e3da796937755ea5552.camel@linux.intel.com>
	 <258ce61c155c28937620f6abe57a39f2b4b0ff56.camel@xry111.site>
	 <101b903e58f2ebae60934edc374c7cda09f83de1.camel@linux.intel.com>
	 <CAJZ5v0jBBgjBny0Ps9bvHc7q1Un_6sdudpNL0==Z5HB+gHH0Hw@mail.gmail.com>
	 <651d11578646200cdb0a91c46ed09a22f29e94a0.camel@linux.intel.com>
	 <1031cc4e4b507628531d9115ce7e4bc588dbab1c.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 13:21 +0800, Xi Ruoyao wrote:
> On Tue, 2024-06-04 at 09:56 -0700, srinivas pandruvada wrote:
> > > > With such a delay, I am not sure how this even worked before.
>=20
> It didn't work out of box but it worked after manually writing 0 to
> no_turbo after 20 seconds, see
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218702.

That make sense. So it never worked out of box. The store_no_turbo()
has additional read for turbo flag before, which is removed now. I
think adding that back will will restore old behavior.

diff --git a/drivers/cpufreq/intel_pstate.c
b/drivers/cpufreq/intel_pstate.c
index 4b986c044741..0d5330e5b96b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1301,6 +1301,8 @@ static ssize_t store_no_turbo(struct kobject *a,
struct kobj_attribute *b,
=20
        no_turbo =3D !!clamp_t(int, input, 0, 1);
=20
+       global.turbo_disabled =3D turbo_is_disabled();
+
        if (no_turbo =3D=3D global.no_turbo)
                goto unlock_driver;


Need to adjust the mutex around it also.

Regarding the bugzilla, I disabled turbo and no_turbo shows 1. Not sure
how it shows "0" to you.

Thanks,
Srinivas


>=20
> > > > Can you revert the patch in question and use kernel dynamic
> > > > debug
> > > > dyndbg=3D"file intel_pstate.c +p" kernel command line and collect
> > > > log
> > > > for
> > > > 30 seconds?
>=20
> Attached.=C2=A0 The related part seems:
>=20
> [=C2=A0=C2=A0=C2=A0 0.553606] intel_pstate: Intel P-state driver initiali=
zing
> [=C2=A0=C2=A0=C2=A0 0.553630] intel_pstate: controlling: cpu 0
> [=C2=A0=C2=A0=C2=A0 0.553640] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 0.553642] intel_pstate: cpu:0 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 0.553643] intel_pstate: cpu:0 global_min:0 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 0.553644] intel_pstate: cpu:0 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 0.553680] intel_pstate: controlling: cpu 1
> [=C2=A0=C2=A0=C2=A0 0.553702] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 0.553703] intel_pstate: cpu:1 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 0.553704] intel_pstate: cpu:1 global_min:0 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 0.553705] intel_pstate: cpu:1 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 0.553742] intel_pstate: controlling: cpu 2
> [=C2=A0=C2=A0=C2=A0 0.553763] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 0.553764] intel_pstate: cpu:2 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 0.553765] intel_pstate: cpu:2 global_min:0 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 0.553766] intel_pstate: cpu:2 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 0.553809] intel_pstate: controlling: cpu 3
> [=C2=A0=C2=A0=C2=A0 0.553830] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 0.553831] intel_pstate: cpu:3 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 0.553831] intel_pstate: cpu:3 global_min:0 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 0.553832] intel_pstate: cpu:3 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 0.553868] intel_pstate: controlling: cpu 4
> [=C2=A0=C2=A0=C2=A0 0.553892] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 0.553893] intel_pstate: cpu:4 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 0.553894] intel_pstate: cpu:4 global_min:0 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 0.553895] intel_pstate: cpu:4 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 0.553943] intel_pstate: controlling: cpu 5
> [=C2=A0=C2=A0=C2=A0 0.553967] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 0.553968] intel_pstate: cpu:5 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 0.553968] intel_pstate: cpu:5 global_min:0 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 0.553969] intel_pstate: cpu:5 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 0.554009] intel_pstate: controlling: cpu 6
> [=C2=A0=C2=A0=C2=A0 0.554034] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 0.554035] intel_pstate: cpu:6 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 0.554036] intel_pstate: cpu:6 global_min:0 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 0.554037] intel_pstate: cpu:6 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 0.554077] intel_pstate: controlling: cpu 7
> [=C2=A0=C2=A0=C2=A0 0.554098] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 0.554099] intel_pstate: cpu:7 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 0.554099] intel_pstate: cpu:7 global_min:0 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 0.554100] intel_pstate: cpu:7 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 0.554104] intel_pstate: HWP enabled
> [=C2=A0=C2=A0=C2=A0 2.183669] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 2.183675] intel_pstate: cpu:6 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 2.183677] intel_pstate: cpu:6 global_min:4 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 2.183679] intel_pstate: cpu:6 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 2.183710] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 2.183711] intel_pstate: cpu:4 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 2.183713] intel_pstate: cpu:4 global_min:4 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 2.183715] intel_pstate: cpu:4 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 2.183742] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 2.183744] intel_pstate: cpu:2 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 2.183745] intel_pstate: cpu:2 global_min:4 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 2.183747] intel_pstate: cpu:2 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 2.183773] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 2.183775] intel_pstate: cpu:0 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 2.183776] intel_pstate: cpu:0 global_min:4 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 2.183777] intel_pstate: cpu:0 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 2.183803] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 2.183805] intel_pstate: cpu:7 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 2.183806] intel_pstate: cpu:7 global_min:4 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 2.183807] intel_pstate: cpu:7 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 2.183831] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 2.183833] intel_pstate: cpu:5 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 2.183834] intel_pstate: cpu:5 global_min:4 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 2.183836] intel_pstate: cpu:5 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 2.183862] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 2.183864] intel_pstate: cpu:3 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 2.183865] intel_pstate: cpu:3 global_min:4 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 2.183867] intel_pstate: cpu:3 max_perf_ratio:31 min_p=
erf_ratio:4
> [=C2=A0=C2=A0=C2=A0 2.183893] intel_pstate: set_policy cpuinfo.max 310000=
0 policy-
> >max 3100000
> [=C2=A0=C2=A0=C2=A0 2.183895] intel_pstate: cpu:1 min_policy_perf:4
> max_policy_perf:31
> [=C2=A0=C2=A0=C2=A0 2.183896] intel_pstate: cpu:1 global_min:4 global_max=
:44
> [=C2=A0=C2=A0=C2=A0 2.183898] intel_pstate: cpu:1 max_perf_ratio:31 min_p=
erf_ratio:4
>=20
> > > I think that it worked because the MSR was read every time
> > > intel_pstate ran, so it got updated at one point and stayed that
> > > way.
> >=20
> > But here HWP in active mode is getting used. So it should have
> > fewer
> > request calls to set accept via cpufreq set_policy()
> >=20
> > =C2=A0callback or with some HWP interrupt.
>=20


