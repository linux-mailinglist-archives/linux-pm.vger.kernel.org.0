Return-Path: <linux-pm+bounces-24964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2D7A814F0
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 20:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D014171415
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 18:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBC722D4C0;
	Tue,  8 Apr 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2Ofc4BP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A125322687C;
	Tue,  8 Apr 2025 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138126; cv=none; b=Q65TgjcUtt2Md0PslXAHSGRhK8nKAYsm3zvLEhvMoF6JllTmnFhjPmx8CssFY+U1S0RVZNOsBrvYYAQPYIasN6Ixp8zI6Q+Ng3BmWyF+Mz2OrRv3jR/k8ISEKF6wyhSiTRH+QF7P0LeiZo3jQDGiWNl6dMx5HVWlGr/cTAgy4GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138126; c=relaxed/simple;
	bh=k04i0235xFtKwaaHHQJebbu6djvaXTSPypCZb71l5x8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BwsJDR0RsrORYAxs3P5rSHP9Z8FhVZnaAofA7MOcHMBkjKhu8l6U7IGpiHzOOF82t3SUb+5zAHAQKUp0uFpeSs0pz+JwVDX3xCM7gre9wVebfupd/1OSjM6fwyRvq/4+g68cf5vWAD6CanTZabokFAO/ixdNtaCPPjrUtLMODHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2Ofc4BP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744138125; x=1775674125;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=k04i0235xFtKwaaHHQJebbu6djvaXTSPypCZb71l5x8=;
  b=Q2Ofc4BPs/qz3xnaTgYXGvVlwpPmOmz1ZBX/pvPhfy842RqwkeZUp+TX
   jEh4/nph+L5nuMLdWWO5vKM7obBV2CEN4/MfflG+Z4uEEkbvppMBFo4/f
   StauulUDyjOlG0dXLuPIRlsfAKZ4y76rzhres6H9IGhxaTiNTeFihw6IK
   xclAe7utMIe/uE/tn0sjKUaMeM8dkvd3uKIuYDDW5yljanO468cjePAOd
   Iu3mT5js/k8VK2xkNOgS+TPBxfedBtDOQ4hR9xxfda6bbxwk2BNaov0HK
   cPfuZ9erCoPOkpEniA7MPkIMz2ZMxrf/x+6Cq9LlE41Klzle3zZFYByj4
   g==;
X-CSE-ConnectionGUID: aMMGfBdwQACDKLz2Pnwy9g==
X-CSE-MsgGUID: VHSNVHnkSRqQunmthohAzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="63132863"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="63132863"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 11:48:44 -0700
X-CSE-ConnectionGUID: YqpeydxSQT6mImyx/BOJqQ==
X-CSE-MsgGUID: g8wCnN6yQn2KAtecQU7URQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="159350389"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.111.171])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 11:48:44 -0700
Message-ID: <e10c4f6cfff8cd55cfe53de5bd1965e26d3ae8e6.camel@linux.intel.com>
Subject: Re: [PATCH v1 10/10] cpufreq: Pass policy pointer to
 ->update_limits()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Mario Limonciello
 <mario.limonciello@amd.com>, Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 08 Apr 2025 11:48:43 -0700
In-Reply-To: <CAJZ5v0htfoQzL48=-JcocfiV7hN5N5Bjn36vZ+zLCQ=Lathcfg@mail.gmail.com>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
	 <8560367.NyiUUSuA9g@rjwysocki.net>
	 <CAJZ5v0iMYSTnX9mkZb8aEmtbKxWOgsshNJ_AqnB9Mn27y8jzeQ@mail.gmail.com>
	 <2362a42de1403e99a66551575efd910cc92980bc.camel@linux.intel.com>
	 <CAJZ5v0i7uUFDcTYuam4Hz2fYxpnT6QQQzULk8CNHvkOUfg=bfQ@mail.gmail.com>
	 <CAJZ5v0hJCtqbkyMaOSMNoiD5DSz+H6PK_FyUdoVTZTVWEFJQyQ@mail.gmail.com>
	 <6346af9942a0e6730fd6b26f2586b82e6fc04d4c.camel@linux.intel.com>
	 <CAJZ5v0htfoQzL48=-JcocfiV7hN5N5Bjn36vZ+zLCQ=Lathcfg@mail.gmail.com>
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

On Tue, 2025-04-08 at 20:34 +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 8, 2025 at 7:47=E2=80=AFPM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > On Tue, 2025-04-08 at 15:37 +0200, Rafael J. Wysocki wrote:
> > > On Tue, Apr 8, 2025 at 1:41=E2=80=AFPM Rafael J. Wysocki
> > > <rafael@kernel.org>
> > > wrote:
> > > >=20
> > > > On Tue, Apr 8, 2025 at 12:28=E2=80=AFAM srinivas pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > >=20
> > > > > On Mon, 2025-04-07 at 20:48 +0200, Rafael J. Wysocki wrote:
> > > > > > On Fri, Mar 28, 2025 at 9:49=E2=80=AFPM Rafael J. Wysocki
> > > > > > <rjw@rjwysocki.net>
> > > > > > wrote:
> > > > > > >=20
> > > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > >=20
> > > > > > > Since cpufreq_update_limits() obtains a cpufreq policy
> > > > > > > pointer for
> > > > > > > the
> > > > > > > given CPU and reference counts the corresponding policy
> > > > > > > object, it
> > > > > > > may
> > > > > > > as well pass the policy pointer to the cpufreq driver's -
> > > > > > > > update_limits()
> > > > > > > callback which allows that callback to avoid invoking
> > > > > > > cpufreq_cpu_get()
> > > > > > > for the same CPU.
> > > > > > >=20
> > > > > > > Accordingly, redefine ->update_limits() to take a policy
> > > > > > > pointer
> > > > > > > instead
> > > > > > > of a CPU number and update both drivers implementing it,
> > > > > > > intel_pstate
> > > > > > > and amd-pstate, as needed.
> > > > > > >=20
> > > > > > > Signed-off-by: Rafael J. Wysocki
> > > > > > > <rafael.j.wysocki@intel.com>
> > > > > >=20
> > > > > Hi Rafael,
> > > > >=20
> > > > > > Hi Srinivas,
> > > > > >=20
> > > > > > If you have any concerns regarding this patch, please let
> > > > > > me
> > > > > > know
> > > > > > (note that it is based on the [05/10]).
> > > > > >=20
> > > > > Changes looks fine, but wants to test out some update limits
> > > > > from
> > > > > interrupt path.
> > > > > Checked your branches at linux-pm, not able to locate in any
> > > > > branch to
> > > > > apply.
> > > > > Please point me to a branch.
> > > >=20
> > > > I'll put it in 'testing' later today.
> > >=20
> > > Now available from
> > >=20
> > > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> > > testing
> > >=20
> > Looks good.
> >=20
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>=20
> Thanks!
>=20
> IIUC this applies to both [5/10] and [10/10], or please let me know
> if
> that's not the case.

This is for both. I tested the whole "testing" branch.

Thanks,
Srinivas


