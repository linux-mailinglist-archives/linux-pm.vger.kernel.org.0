Return-Path: <linux-pm+bounces-8589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4F8FB9A6
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 18:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0264D284E9D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 16:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D59E14900F;
	Tue,  4 Jun 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZfSA1xJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB72AF16;
	Tue,  4 Jun 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520241; cv=none; b=tAnt1S789e3LdagUFY9dQUYo1OqzWUryqhrRoAu6KrQvG+bPLDkLLdX/wY5lMW7oDOyu5XyW5PLLWb6A+I+fi9lSJ9DbAdKngcEj1C6GUvnzhC4JExE5La+ucfVNwkEBsTZPRMVZOK4W809YNHGiR8LpwBHFXpzWjqHu9ZNF3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520241; c=relaxed/simple;
	bh=8d5FrD3zoZXY2kRruuxHEQtoIcximE7vznRzibmSxHg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BpzRQl1fHMLVNpqh27Jk1itlpsoTVCzhujvSWInWsiycTIjfroV2OulKKlcEjCVZQFWAxkzLRy9qRj2zLmddC5XdI6Bxr/MbYCSf6zN9D0kdvbgKQW4BshoqHg/7k8pTtgsULilytp4Qp92v4gw8E3r/4aZLVliHdkVmhLZgKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZfSA1xJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717520239; x=1749056239;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=8d5FrD3zoZXY2kRruuxHEQtoIcximE7vznRzibmSxHg=;
  b=AZfSA1xJ++t8oLpCyNGkXfcxTAWLTvISdk1bCCg/L9AOxWcHff5iGM9y
   VT1q7swskDPMDRoQckFa3e3msQJ54tAmj4qY6nZlCQudQeA1m6zSb/uHW
   tKRhz+NkhwOU2C8FxEygi4yc5ULeSqy2TZzeDvuJoX8c7PLbA/HDTpbId
   Wgn13X7B+yv6AvlghRSQ4yz2bVcQVWsa8fqJ6chCAOabkIfHjpxb3pBuT
   WucN5TGIV5+4iP66xmFHO34JJm3jbyuYktzACm0GwF1/ydfsEtlSe/7MR
   LndTmmULUI5cCE7Bgw5rAVc1wV5+YrJIYp3Qg+CKVvPhIe8ahSUSgGBda
   Q==;
X-CSE-ConnectionGUID: wuvU5ZzlRo6bbm6A0vCCfw==
X-CSE-MsgGUID: WiITed4wRQm1zPVAlesTEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="24658814"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="24658814"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:57:19 -0700
X-CSE-ConnectionGUID: rIdYWhGMQ4O2e7AiyxFRFw==
X-CSE-MsgGUID: owmQ4ar9QN+6e9E2Ti2HHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="41734897"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:57:18 -0700
Message-ID: <651d11578646200cdb0a91c46ed09a22f29e94a0.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
  Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Date: Tue, 04 Jun 2024 09:56:36 -0700
In-Reply-To: <CAJZ5v0jBBgjBny0Ps9bvHc7q1Un_6sdudpNL0==Z5HB+gHH0Hw@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 18:46 +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 4, 2024 at 6:41=E2=80=AFPM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > On Tue, 2024-06-04 at 18:32 +0800, Xi Ruoyao wrote:
> > > On Tue, 2024-06-04 at 03:29 -0700, srinivas pandruvada wrote:
> > > > On Tue, 2024-06-04 at 17:30 +0800, Xi Ruoyao wrote:
> > > > > On Mon, 2024-06-03 at 21:31 -0700, srinivas pandruvada wrote:
> > > > >=20
> > > > > > > > Second, a delayed work can be added to check the MSR
> > > > > > > > long
> > > > > > > > enough
> > > > > > > > after
> > > > > > > > initialization and update global.turbo_disabled if it
> > > > > > > > is 1.
> > > > > > > > However,
> > > > > > > > that would require some code surgery.
> > > > > > >=20
> > > > > > Something like the attached which does same way as user
> > > > > > space
> > > > > > no_turbo
> > > > > > update.
> > > > >=20
> > > > > > =C2=A0static int intel_pstate_register_driver(struct
> > > > > > cpufreq_driver
> > > > > > *driver)
> > > > > > =C2=A0{
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > > > > @@ -3114,6 +3137,9 @@ static int
> > > > > > intel_pstate_register_driver(struct cpufreq_driver *driver)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 global.turbo_disable=
d =3D turbo_is_disabled();
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 global.no_turbo =3D =
global.turbo_disabled;
> > > > > >=20
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (global.turbo_disabled=
)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 schedule_delayed_work(&turbo_work, HZ);
> > > > > > +
> > > > >=20
> > > > > I have to change it to 20 * HZ to make it work for me.=C2=A0 15 *
> > > > > HZ
> > > > > does
> > > > > not
> > > > > work.
> > > >=20
> > > > Is there any consistency or it is changing every time?
> > >=20
> > > It seems consistent.
> > With such a delay, I am not sure how this even worked before.
> > Can you revert the patch in question and use kernel dynamic debug
> > dyndbg=3D"file intel_pstate.c +p" kernel command line and collect log
> > for
> > 30 seconds?
>=20
> I think that it worked because the MSR was read every time
> intel_pstate ran, so it got updated at one point and stayed that way.

But here HWP in active mode is getting used. So it should have fewer
request calls to set accept via cpufreq set_policy()

 callback or with some HWP interrupt.


