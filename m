Return-Path: <linux-pm+bounces-17054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DFF9BE01C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 09:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D521F23C4C
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0FA1D2F42;
	Wed,  6 Nov 2024 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f45ltnXW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9F1D2F6F;
	Wed,  6 Nov 2024 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880876; cv=none; b=mk62ZZM4gqtgEBy3wk/k9Z+dujSZ4QbFgIS7RWBBAf1NVT3Z5+X1PhQnHiye0+cOR40RWJjiMRNJr/6fX1BjGZ9CC/UV8t5+P7jvIgq8PfGmE+FTXv2+muVOj0rKbtvI3Vw6TY9GiJqoJSyKhd/yHKqtpRbsZyuQRTCZtCbcw8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880876; c=relaxed/simple;
	bh=dBb+Eo0n9VoDVRZwbPGpxepQHjSFWfDooJNru94cP7g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qItAddVYuYkRsrDsSmPqQ5CbS0Dhc4wKdOwzyJiqLwGjKG8NAwSYLDhMc4cR0hIqtvQjbmrDjLw1eErmOmoQmaqWh5JO+6AvAQ6izeMiU5tHKGIAofwEgg5EcWpoJRJZq0l/6nbec6OkKCds2XMhAM6D2npx+4cA88Faxb2OylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f45ltnXW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730880874; x=1762416874;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dBb+Eo0n9VoDVRZwbPGpxepQHjSFWfDooJNru94cP7g=;
  b=f45ltnXWitNg9d+5vg6CuKQpR+BXnc+ul7fcTL2PgBC1BVKXoQG3hR3t
   ++zRmDWAKaHvmjlH+rLRHiV3QZIJb2iddkJj19Mq07ecIrpfh7zu1ghGh
   jQU/hrIWMxQ9MTNTP6D3IyUntV7/YsxnWNnfjGyfdnOTPCdp2HLx54DBu
   hFEXIzWY3F0Vbot4yjcc1pqFR+lQsmfIKoNnPALBn7m0IoqnK/7dVCZef
   ksi2VitvZoOWAWDk+QAewuhCJGPqwKr5Gwn6QVsLDTI+wpLqwxo4uHOO5
   yL6b0Lo3Q5aTfHJRseir2zHDbmkkKVguZHdv4Iy7FPK4mQQ8DUR1yygzn
   A==;
X-CSE-ConnectionGUID: lXwtP/caRVGBCWqUcI36dQ==
X-CSE-MsgGUID: qk5Y1J1DRpCptryueKA7YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="56061421"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="56061421"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 00:14:34 -0800
X-CSE-ConnectionGUID: KSB8vZjDR669tBstctNo+g==
X-CSE-MsgGUID: BM75w0c6QoeT4hGmMtgU4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="89249743"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 00:14:34 -0800
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
	by linux.intel.com (Postfix) with ESMTP id 6A70B20B5703;
	Wed,  6 Nov 2024 00:14:31 -0800 (PST)
Message-ID: <9272406507bca4eb284cd75759d8d9479b937da9.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/3] x86/smp: Allow forcing the mwait hint for play
 dead loop
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>, Patryk Wlazlyn
	 <patryk.wlazlyn@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 rafael.j.wysocki@intel.com, len.brown@intel.com, dave.hansen@linux.intel.com
Date: Wed, 06 Nov 2024 10:14:30 +0200
In-Reply-To: <000fd68e-2b24-4eb3-b2d7-e4856b403212@intel.com>
References: <20241029101507.7188-1-patryk.wlazlyn@linux.intel.com>
	 <20241029101507.7188-3-patryk.wlazlyn@linux.intel.com>
	 <e332a243-5a98-49ed-81be-b6db305d5dc5@intel.com>
	 <35946efe3b8b8b686ba4ea0ed5c9f15c50ca6ef8.camel@linux.intel.com>
	 <000fd68e-2b24-4eb3-b2d7-e4856b403212@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dave, community,

I'll cover general questions, and let Patryk cover the specific core-relate=
d
comments.

On Wed, 2024-10-30 at 12:32 -0700, Dave Hansen wrote:
> On 10/30/24 02:58, Artem Bityutskiy wrote:
> > On Tue, 2024-10-29 at 11:30 -0700, Dave Hansen wrote:
> > 1. Could we at least set up a few rules here?=C2=A0 Like, say what the =
hints
> > are, what values can they have?
> >=20
> > The hints are 8-bit values, lower 4 bits define "sub-state", higher 4 b=
its
> > define the state.
> >=20
> > The state value (higher 4 bits) correspond to the state enumerated by C=
PUID
> > leaf
> > 5 (Value 0 is C0, value 1 is C1, etc). The sub-state value is an opaque
> > number.
> >=20
> > The hint is provided to the mwait instruction via EAX.
>=20
> OK, so can you distill that down to something succinct and get it in a
> comment above the new function, please?

Yes, that was my idea to write a long e-mail to cover your and other review=
er's
questions, and let Patryk turn this into nice comments at the right places.

> > 2. Where do they come from?
> >=20
> > Hardware C-states are defined by the specific platform (e.g., C1, C1E, =
CC6,
> > PC6). Then they are "mapped" to the SDM C-states (C0, C1, C2, etc). The
> > specific
> > platform defines the hint values.
> >=20
> > Intel typically provides the hint values in the EDS (External Design
> > Specification) document. It is typically non-public.
> >=20
> > Intel also discloses the hint values for open-source projects like Linu=
x,
> > and
> > then Intel engineers submit them to the intel_idle driver.
> >=20
> > Some of the hints may also be found via ACPI _CST table.
>=20
> What about the mwait_play_dead() loop that calculates the hint?=C2=A0 Doe=
sn't
> that derive the hint from CPUID?

The mwait_play_dead() hint calculation algorithm is the root of the problem=
. It
calculates a sub-optimal hint for some platforms, such as Sierra Forest Xeo=
n.

So at high level, mwait_play_dead() calculates the hint, saves it in the 'e=
ax'
variable, and then just eeps issuing 'mwait(eax, ecx=3D0)' with that hint.

So the mwait hint calculation code is between lines [1303] and [1313] (see =
links
below).

The code basically finds the highest C-state index ('highest_cstate' variab=
le)
and count of sub-states within that C-state ('highest_subcstate' variable),=
 and
forms the mwait hint out of them.

You should also check leaf CPUID Leaf 5 SDM doc for more clarity.

Example #1.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Sapphire Rapids Xeon, where the algorithm calculates the correct hint.

'highest_cstate' ends up being 2 (corresponds C3 in CPUID leaf 5 terms, not=
e
that C0 is ignored), and highest_subcstate ends up being 1 (1 sub-state), s=
o the
mwait hint ends up being 0x20. The math is at line [1311]:

eax =3D (highest_cstate << MWAIT_SUBSTATE_SIZE) | (highest_subcstate - 1) =
=3D
(2 << 4) | (1 - 1) =3D 0x20

This ends up being the deepest available C-state hint (C6). No problem here=
.

Code lines.
1303:
https://elixir.bootlin.com/linux/v6.9/source/arch/x86/kernel/smpboot.c#L130=
3
1313:=20
https://elixir.bootlin.com/linux/v6.9/source/arch/x86/kernel/smpboot.c#L131=
3
1311:
https://elixir.bootlin.com/linux/v6.9/source/arch/x86/kernel/smpboot.c#L131=
1


Exemple #2.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Sierra Forest Xeon, where the algorithm calculates the incorrect hint.

Here is CPUID leaf 5.

$ cpuid -1 -l 5
CPU:
   MONITOR/MWAIT (5):
      smallest monitor-line size (bytes)       =3D 0x40 (64)
      largest monitor-line size (bytes)        =3D 0x40 (64)
      enum of Monitor-MWAIT exts supported     =3D true
      supports intrs as break-event for MWAIT  =3D true
      number of C0 sub C-states using MWAIT    =3D 0x0 (0)
      number of C1 sub C-states using MWAIT    =3D 0x2 (2)
      number of C2 sub C-states using MWAIT    =3D 0x0 (0)
      number of C3 sub C-states using MWAIT    =3D 0x2 (2)
      number of C4 sub C-states using MWAIT    =3D 0x0 (0)
      number of C5 sub C-states using MWAIT    =3D 0x0 (0)
      number of C6 sub C-states using MWAIT    =3D 0x0 (0)
      number of C7 sub C-states using MWAIT    =3D 0x0 (0)

Notice that CPUID leaf 5 advertises two C3 sub-states, and with this input =
the
the algorithm ends up with mwait hint 0x21. This mwait hint is not document=
ed as
supported on Sierra Forest.

The supported Sierra Forest mwait hints are defined in 'intel_idle.c':
https://github.com/torvalds/linux/blob/2e1b3cc9d7f790145a80cb705b168f05dab6=
5df2/drivers/idle/intel_idle.c#L1345

They are 0x0, 0x01, 0x22, 0x23. And 0x23 is the deepest C-state (C6SP).

But offline code ends up issuing 0x21. The platform maps it to a "shallow
version" of core C6, which is not documented and is not supposed to be used=
.

At any rate, it ends up in a situation when offlining a single CPU will pre=
vent
the platform from ever reaching PC6 state. In PC6 - happens when all CPUs
requested C6SP - all cores are powered off and there are power savings in u=
ncore
(caches, interconnects, memory controller, etc).

Now, as I mentioned, in parallel I am working with Sierra Forest firmware t=
eam
to change platform behavior and map hint 0x21 to 0x23 in firmware. As a
workaround.

>=20
> > 5. What's the behavior when it is not set?
> >=20
> > The offline code will fall-back to the generic non-architectural algori=
thm,
> > which provides correct results for all server platforms I dealt with si=
nce
> > 2017.
> > It should provide the correct hint for most client platforms, as far as=
 I am
> > aware.
> >=20
> > Sierra Forest Xeon is the first platform where the generic algorithm
> > provides a
> > sub-optimal value 0x21. It is not fatal, just sub-optimal.
>=20
> What is the non-architectural algorithm?=C2=A0 Which Linux code are you
> referring to?

See above.

The non-architectural part of it is basically this.

The algorithm assumes that in the sub-state part of the mwait hint (4 least
significant bits) always starts with 0 and then next sub-state is always 1,=
 and
there are no gaps. This is not documented in Intel SDM. This happens to wor=
k on
majority of Intel platforms, but this is not architectural.

Thank you,

Artem.

