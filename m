Return-Path: <linux-pm+bounces-8534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F10A8D8828
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 19:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86401F21C0C
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 17:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD9313791A;
	Mon,  3 Jun 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="T6t9OcPu"
X-Original-To: linux-pm@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8DB137902;
	Mon,  3 Jun 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717436657; cv=none; b=qDiUAMfoBdaS9JwMlCbxjxB5QbesdmS9h21R14dmotMw1kZ+JLbzoFbH3m4VTyYaYoPIMhJXQ1D0CWh4bG3SO9gyQ3ramivcSD0g4AeYTjPQ0VHKGfXafWF0M2u1uSHOOC4k6I4Iv17tHjteELL+c0vUhEbxu0/m3XxmgJ0x1Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717436657; c=relaxed/simple;
	bh=tmo0LZxMdzvSoYgPSGhR2ipRgjphQMohkpxHGkKaTFU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pOeONbOkdIeITjrFl27thMZZTeaabhFZC3bhsYrc2RXDrgHCuc9Brd7lXVm85BtTuRLd9SlKdlctqdyDRECYv35HbYLdwIBkMtqxCoIlnNmBmlJ99R1dwyBiICeZMoWawQ3CsTlnXezu/Q4oWbKdc8pcDd5wmiaa+/AU2qRLmUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=T6t9OcPu; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1717436654;
	bh=tmo0LZxMdzvSoYgPSGhR2ipRgjphQMohkpxHGkKaTFU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=T6t9OcPue/Gq30YaSX3aQDQfihwjieNxwm9BETQhPd6cp27uZzkYR6KpHHXtbgxlk
	 ezvofmMb0AxhkLkXaR+Atu74hu8NHWywohAoSI0Hx5FxeDdAdNuTOgY7yW91FxHN63
	 oMeETO6JsnHpVo9tzQudIXoLnsGM/9Ap9Wak20J4=
Received: from [IPv6:240e:358:117b:e900:dc73:854d:832e:4] (unknown [IPv6:240e:358:117b:e900:dc73:854d:832e:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 0FD8A66E7C;
	Mon,  3 Jun 2024 13:44:12 -0400 (EDT)
Message-ID: <48eba83030e155f703b4248e9c1ae65aa44b1a83.camel@xry111.site>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: Xi Ruoyao <xry111@xry111.site>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Tue, 04 Jun 2024 01:44:08 +0800
In-Reply-To: <c3526e7a0e80ec1a3a011259c38ab4b772040ea4.camel@linux.intel.com>
References: <13494237.uLZWGnKmhe@kreacher> <8366982.T7Z3S40VBb@kreacher>
	 <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
	 <6d5ee74605bd9574baa5ed111cb54e959414437a.camel@linux.intel.com>
	 <6ebadacd8aaa307a5766cdb1b4d4a5c69acd87ac.camel@xry111.site>
	 <30a30c5107a47a2cc3fd39306728f70dd649d7fe.camel@linux.intel.com>
	 <f382e06635b3b52841d1e0c11dcf639d225edae0.camel@xry111.site>
	 <29d69252dcdc398f147c9139a8666d09e7bd831d.camel@linux.intel.com>
	 <0324bc3a88654855719cd48a5ed69a34eea31037.camel@xry111.site>
	 <c3526e7a0e80ec1a3a011259c38ab4b772040ea4.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-03 at 10:11 -0700, srinivas pandruvada wrote:
> On Mon, 2024-06-03 at 21:12 +0800, Xi Ruoyao wrote:
> > On Sun, 2024-06-02 at 16:11 -0700, srinivas pandruvada wrote:
> >=20
> > /* snip */
> >=20
> > > What is the output of:
> > > grep . /sys/devices/system/cpu/intel_pstate/*
> > >=20
> > > Also=C2=A0
> > > rdmsr 0x771
> > > rdmsr 0x774
> > >=20
> > >=20
> > > Try these three patches. Don't worry about the commit description
> > > for
> > > this issue.
> >=20
> > Unfortunately they still do not fix the issue for me.
> >=20
> > The outputs of grep and rdmsr commands are initially:
> >=20
> > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost:0
> > /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> > /sys/devices/system/cpu/intel_pstate/min_perf_pct:9
> > /sys/devices/system/cpu/intel_pstate/no_turbo:1
> > /sys/devices/system/cpu/intel_pstate/num_pstates:41
> > /sys/devices/system/cpu/intel_pstate/status:active
> > /sys/devices/system/cpu/intel_pstate/turbo_pct:33
> > rdmsr 0x771: 10d1f2c
> > rdmsr 0x774: 1f04
> >=20
> > But it then changes to:
> >=20
> > /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost:0
> > /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> > /sys/devices/system/cpu/intel_pstate/min_perf_pct:9
> > /sys/devices/system/cpu/intel_pstate/no_turbo:1
> > /sys/devices/system/cpu/intel_pstate/num_pstates:41
> > /sys/devices/system/cpu/intel_pstate/status:active
> > /sys/devices/system/cpu/intel_pstate/turbo_pct:33
> > rdmsr 0x771: 10c1f2c
> > rdmsr 0x774: 1f04
> >=20
> > It seems only the output of rdmsr 0x771 has changed.=C2=A0 And if I rea=
d
> > the
> > SDM correctly it's a "Most_Efficient_Performance" change.
> That is fine.
>=20
> We don't have any notifications either via ACPI or via HWP interrupt.
> I think it was working by chance before this change as by the cpufreq
> core is trying to set policy, the turbo is enabled by the firmware.
>=20
> What is this laptop make and model?

It's a Hasee X5-2021S5H.

Hasee is known for producing some laptops very cheap but often having
"minor" issues.  So I guess the firmware is doing some stupid thing.

But turbo works just fine on Windows 11 so it'd be better if we could
make it work for Linux too.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

