Return-Path: <linux-pm+bounces-24939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9003EA80DB1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 16:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2581F1B64741
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 14:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1CF1D8DF6;
	Tue,  8 Apr 2025 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFbuoZ7q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD891D7E50;
	Tue,  8 Apr 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121885; cv=none; b=juyG49oEA+QU5kEO4xvXy829I+hh8xBWN0G89jP13RtPxZj+Qr9BN3ewefSxN1Xhhsao8frpYofPCzMO+sJwdiguXIdtMbiBAEfO2xvP8wZK8zP8XY+0IqT82PHe0FXeRBJjMHZp0TkTSRjU6XF2smZHfMFrJma/6Zdq4ZLixoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121885; c=relaxed/simple;
	bh=d/p4Ngv0MWUpnK7qO2qh9ECXM3M0o3eoWfLf86Cub6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SKnQRxqb7YIk7EzqdM8upql7E0dKfD+QQDQA7iiYg7zCwrltWDcYKnjkglyQAznyUHSN5xscp6TYkS7keAJqWDzvHUVE4F2jaVjpcfx1uBnb0SF+4ZGaRYpJ64T1ul4U6CVOTa3JtKO+49qUSsovx9Uxwjg0zsh8ewzfNrhCDS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFbuoZ7q; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744121884; x=1775657884;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=d/p4Ngv0MWUpnK7qO2qh9ECXM3M0o3eoWfLf86Cub6Q=;
  b=mFbuoZ7qUqBtq7XjUMImU45syQFYfHuMNXmGB36cCtVGgPtn900yqc2E
   bEBvKBQOThWeqQD6NmgK7d3ckz0i1HNWPj8Rayw4EoB0E410bu9sTycgF
   Phctq/2yfkaP5klRTI99FM7CpX+TKW+U3eJ8M3t/Hb72yFw8Y1KM36VFA
   B6Y4qAJfqUac+Bxa4WZwi0Hed13oozxfT9VaIvQW2IxvLR86eMS31IKMA
   5SrdwTt1WllDkZbcD1tnpdlFNZaQFxiivL5Cpu1TrSfavCguG8gCZ+8he
   Azl1iz5ZEZIMTc+4asKPE+4eNKuNaZqoZsxuu8CsdRdsSG568eqtU88M/
   w==;
X-CSE-ConnectionGUID: cAtXG16iS3GR3+obVlQTLQ==
X-CSE-MsgGUID: 6wocN2DYTZyXVOJvQ3Qa8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="62958134"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="62958134"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 07:18:03 -0700
X-CSE-ConnectionGUID: CCh2+ogTQ7udkrIqpEzZ4A==
X-CSE-MsgGUID: GgvV+OIAS7e6a5Ev2ulMhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="129241077"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.111.121])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 07:18:03 -0700
Message-ID: <cb4f449d622f7577782fc56d2b961c3c059ffa10.camel@linux.intel.com>
Subject: Re: [PATCH v1 10/10] cpufreq: Pass policy pointer to
 ->update_limits()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Linux PM' <linux-pm@vger.kernel.org>, 'LKML'
 <linux-kernel@vger.kernel.org>,  'Viresh Kumar' <viresh.kumar@linaro.org>,
 'Mario Limonciello' <mario.limonciello@amd.com>, 'Sudeep Holla'
 <sudeep.holla@arm.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, "'Rafael
 J. Wysocki'" <rafael@kernel.org>
Date: Tue, 08 Apr 2025 07:18:02 -0700
In-Reply-To: <005501dba817$b710fe60$2532fb20$@telus.net>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
	 <8560367.NyiUUSuA9g@rjwysocki.net>
	 <CAJZ5v0iMYSTnX9mkZb8aEmtbKxWOgsshNJ_AqnB9Mn27y8jzeQ@mail.gmail.com>
	 <2362a42de1403e99a66551575efd910cc92980bc.camel@linux.intel.com>
	 <005501dba817$b710fe60$2532fb20$@telus.net>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-07 at 16:49 -0700, Doug Smythies wrote:
> On 2025.04.07 15:38 srinivas pandruvada wrote:
> > On Mon, 2025-04-07 at 20:48 +0200, Rafael J. Wysocki wrote:
> > > On Fri, Mar 28, 2025 at 9:49=E2=80=AFPM Rafael J. Wysocki
> > > <rjw@rjwysocki.net> wrote:
> > > >=20
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >=20
> > > > Since cpufreq_update_limits() obtains a cpufreq policy pointer
> > > > for
> > > > the
> > > > given CPU and reference counts the corresponding policy object,
> > > > it
> > > > may
> > > > as well pass the policy pointer to the cpufreq driver's -
> > > > > update_limits()
> > > > callback which allows that callback to avoid invoking
> > > > cpufreq_cpu_get()
> > > > for the same CPU.
> > > >=20
> > > > Accordingly, redefine ->update_limits() to take a policy
> > > > pointer
> > > > instead
> > > > of a CPU number and update both drivers implementing it,
> > > > intel_pstate
> > > > and amd-pstate, as needed.
> > > >=20
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >=20
> > Hi Rafael,
> >=20
> > > Hi Srinivas,
> > >=20
> > > If you have any concerns regarding this patch, please let me know
> > > (note that it is based on the [05/10]).
> > >=20
> > Changes looks fine, but wants to test out some update limits from
> > interrupt path.
> > Checked your branches at linux-pm, not able to locate in any branch
> > to
> > apply.
> > Please point me to a branch.
>=20
> Hi Srinivas,
>=20
> You can get the series from patchworks [1].
> Then just edit it, deleting patch 1 of 10, because that one was
> included in kernel 6.15-rc1
> The rest will apply cleanly to kernel 6.15-rc1.
>=20
Hi Doug,

You are correct. But I prefer a branch usually as there may be other
fixes so that I can verify once.

Thanks,
Srinivas

> I just did all this in the last hour, because I wanted to check if
> the patchset fixed a years old
> issue with HWP enabled, intel_cpufreq, schedutil, minimum frequency
> set above hardware
> minimum was properly reflected in scaling_cur_freq=C2=A0 when the
> frequency was stale. [2]
> The issue is not fixed.
>=20
> [1]
> https://patchwork.kernel.org/project/linux-pm/patch/2315023.iZASKD2KPV@rj=
wysocki.net/
> [2]
> https://lore.kernel.org/linux-pm/CAAYoRsU2=3DqOUhBKSRskcoRXSgBudWgDNVvKtJ=
A+c22cPa8EZ1Q@mail.gmail.com/
>=20
>=20
>=20


