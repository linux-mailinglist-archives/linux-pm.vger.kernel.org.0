Return-Path: <linux-pm+bounces-8499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407CF8D73AD
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 06:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE44281824
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 04:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5601E749C;
	Sun,  2 Jun 2024 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0ODv2c8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0316FCC;
	Sun,  2 Jun 2024 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717301009; cv=none; b=Hd+GqYaM+5VoJpZ86IVAb1A1DPKwrrKoV1t9XdAwypQb+cyOIdJgbTByt49HC/4RBZtOSO9BH0qKZN7l/pH9CpsIoGfyMotl5ZWrogJ12a6ieYeo0F8eBIeB06b4LlmoaNatn4D0x1HIoV7joU2CHOI3QWATEsY9dZ1CL5g3DC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717301009; c=relaxed/simple;
	bh=5kCl8uorB1nKwMgl3Tyy4pULV+LlG5gIqTfnpnUbIEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eo1wtr4EvugtX8tzCPqb/W4SFhW+xhUduotFbaSFY2YE8i89qX3fkgWmKf7xDutYdQ45hrs26+o7O0Vldzwxkj3YVKLXpZv8238i0Yj1x56oeb29cECwAel5g+Wl9oDp65GRx+mcm02ZWJMogdyC9JkV6NJVS1wOQOniFcCoM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0ODv2c8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717301008; x=1748837008;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=5kCl8uorB1nKwMgl3Tyy4pULV+LlG5gIqTfnpnUbIEI=;
  b=c0ODv2c8BcIXzdNDYjV20XGBbQbo9Rg5dIhRwIUNxv45KZraCLsFPm3I
   okB9B8IX8+4bcAE1oNM93VYmkGYNn3YFh4kQq9UWGzyl3RqY5aFKYeuO3
   Cag1tv2QyBwTyKg+MWFt+oymf5c2I91JjqGVUVqfTvqKZ4mEA2n1I4b1X
   ps5dN3zc7wR3bV4uDbueXNf3L1L6nhVziFSxQhHP4GrOkKVWcbfEdwk9W
   IfV74dq7CetT6S4JBoSP5jfpcAAC4qrVGSDeQDqE+4a7MmuSRfS4VxOMj
   G1j8caQqDkHvdgaR7gMFtJz8Mok3Oot63thHsqPQUHNW3DV3kS7iPCtDU
   A==;
X-CSE-ConnectionGUID: W7sgabexR9yQSsyIF7hWCA==
X-CSE-MsgGUID: TQOUou/bQlqRHZkyZ89L5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="25219015"
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; 
   d="diff'?scan'208";a="25219015"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2024 21:03:27 -0700
X-CSE-ConnectionGUID: R6L1sIQuSiCS4gM1rT3wUQ==
X-CSE-MsgGUID: ye4e3pN9QW6ORCXpHg/Hgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; 
   d="diff'?scan'208";a="41627519"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2024 21:03:27 -0700
Message-ID: <6d5ee74605bd9574baa5ed111cb54e959414437a.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Xi Ruoyao <xry111@xry111.site>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
  Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Sat, 01 Jun 2024 21:03:18 -0700
In-Reply-To: <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
References: <13494237.uLZWGnKmhe@kreacher> <8366982.T7Z3S40VBb@kreacher>
	 <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
Content-Type: multipart/mixed; boundary="=-3gzlBN4siQgWAYD7n7Rk"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-3gzlBN4siQgWAYD7n7Rk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xi,

On Sun, 2024-06-02 at 11:21 +0800, Xi Ruoyao wrote:
> On Mon, 2024-03-25 at 18:02 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >=20
> > The global.turbo_disabled is updated quite often, especially in the
> > passive mode in which case it is updated every time the scheduler
> > calls
> > into the driver.=C2=A0 However, this is generally not necessary and it
> > adds
> > MSR read overhead to scheduler code paths (and that particular MSR
> > is
> > slow to read).
> >=20
> > For this reason, make the driver read
> > MSR_IA32_MISC_ENABLE_TURBO_DISABLE
> > just once at the cpufreq driver registration time and remove all of
> > the
> > in-flight updates of global.turbo_disabled.
>=20
> Hi Rafael and Srinivas,
>=20
> Thanks for the clean up, but unfortunately on one of my laptops
> (based
> on i5-11300H) MSR_IA32_MISC_ENABLE_TURBO_DISABLE is mysteriously
> changing from 1 to 0 in about one minute after system boot.=C2=A0 I've no
> idea why this is happening (firmware is doing some stupid thing?)
>=20
> I've noticed the issue before and "hacked it around"
> (https://bugzilla.kernel.org/show_bug.cgi?id=3D218702). But after this
> change I can no longer hack it around and the system is much slower.
>=20
> Is it possible to hack it around again?
>=20
Please try the attached diff and build kernel and try.

git apply update_max_freq.diff

Then build kernel and install.

Thanks,
Srinivas

--=-3gzlBN4siQgWAYD7n7Rk
Content-Disposition: attachment; filename="update_max_freq.diff"
Content-Type: text/x-patch; name="update_max_freq.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYyBiL2RyaXZlcnMvY3B1
ZnJlcS9pbnRlbF9wc3RhdGUuYwppbmRleCA0Yjk4NmMwNDQ3NDEuLmRlYWI5NmQ4ZDRiZiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCisrKyBiL2RyaXZlcnMvY3B1
ZnJlcS9pbnRlbF9wc3RhdGUuYwpAQCAtMTE2OCw2ICsxMTY4LDEyIEBAIHN0YXRpYyB2b2lkIGlu
dGVsX3BzdGF0ZV91cGRhdGVfbGltaXRzKHVuc2lnbmVkIGludCBjcHUpCiAJaWYgKCFwb2xpY3kp
CiAJCXJldHVybjsKIAorCXByX2luZm8oIiVzIGNwdTolZFxuIiwgX19mdW5jX18sIGNwdSk7CisK
KwlnbG9iYWwudHVyYm9fZGlzYWJsZWQgPSB0dXJib19pc19kaXNhYmxlZCgpOworCWdsb2JhbC5u
b190dXJibyA9IGdsb2JhbC50dXJib19kaXNhYmxlZDsKKwlhcmNoX3NldF9tYXhfZnJlcV9yYXRp
byhnbG9iYWwudHVyYm9fZGlzYWJsZWQpOworCiAJX19pbnRlbF9wc3RhdGVfdXBkYXRlX21heF9m
cmVxKGFsbF9jcHVfZGF0YVtjcHVdLCBwb2xpY3kpOwogCiAJY3B1ZnJlcV9jcHVfcmVsZWFzZShw
b2xpY3kpOwo=


--=-3gzlBN4siQgWAYD7n7Rk--

