Return-Path: <linux-pm+bounces-37668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD4AC42E02
	for <lists+linux-pm@lfdr.de>; Sat, 08 Nov 2025 15:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD77F3A42B6
	for <lists+linux-pm@lfdr.de>; Sat,  8 Nov 2025 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125441DE4F1;
	Sat,  8 Nov 2025 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/tiy8Mb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E771C1F02;
	Sat,  8 Nov 2025 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610864; cv=none; b=im4y56EjrD9RpOMEDwDO2VwAQSPZ+Ktj2ha7ljuXYLhLe6XWFvBpzRcCWrvwhqdx35dLcfFNZUDD77RbfhR5Mw8v7fYqT/bng1tLT9OwP5RZMgz1ElGwU8aJ1fSBYHaQe2MqnXH4pTTskAV/GcdgGNlw4OmQgO08togQhI0oZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610864; c=relaxed/simple;
	bh=qSqPh2nCFyWRUgBYOcEIfKYmiFhvdyBi77+UEVA2+AI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YOGiQE5M3rGJ7vI6aOFI+R4jDNXADdzF/z/MmcxcknUHGj6rSz07LJho+QWabgB5vEEOa4KwQWbVwMrtH+FIYrt3qKVDLwmlfC/NiAKObVoZfZ3xyc9aMkOc+4Pa7XU4/kRl6R1PXhuLzII9kljOJxq1zoljWHmTXmspICjfAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/tiy8Mb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762610862; x=1794146862;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qSqPh2nCFyWRUgBYOcEIfKYmiFhvdyBi77+UEVA2+AI=;
  b=G/tiy8MbB29FnHbHLm8qBqjWREZcdua7HU2P8rptiSrobv3Mg+2t8hGZ
   RtSq8zTBdcOT5q30hkCTnQUBqRgiAcgSwoF+XTpT1ru/VebaBd//tHOqI
   tYOct+qYJHWm3waJgXSB0P61fp/oEJqjY5uKy+q0dvBzIkSEebjpOFr0C
   9OAtyytM8KJblEzNZz4YStohz/7ny7qpNpOBYeTolA7CqHYhacpzoo7lB
   vGKT6rBk34DXLCSlXgd32m9KP3Xxr50dXI+aJ0S4SGmjo7nsWWv/9N6Kj
   ewTJw5hNDjD0V1av5HdhxaLrWz5ittjvUeZeJ8Lp/WFF2IpO554bMgjLg
   w==;
X-CSE-ConnectionGUID: KEnnsa5pTaeVXrfoQNoN3w==
X-CSE-MsgGUID: 4mzDAyuiSS62AcBLCs7cSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="63944170"
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="63944170"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 06:07:41 -0800
X-CSE-ConnectionGUID: 7XY5IPluRUK7HBVvFFbtOw==
X-CSE-MsgGUID: mWXm4wTUSOmhDMr3Z0BYOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; 
   d="scan'208";a="218939566"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2025 06:07:41 -0800
Received: from [10.245.245.159] (unknown [10.245.245.159])
	by linux.intel.com (Postfix) with ESMTP id 8292620BA6F5;
	Sat,  8 Nov 2025 06:07:39 -0800 (PST)
Message-ID: <a4c894d1334e587e094b7039745c792108086199.camel@linux.intel.com>
Subject: Re: [PATCH v2] cpuidle: Add sanity check for exit latency and
 target residency
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,  Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Sat, 08 Nov 2025 16:07:37 +0200
In-Reply-To: <CAJZ5v0i9DkZR=ZnJ-+VDm-2wk-ab2X=RM69uiSTgwuhGnf8zVg@mail.gmail.com>
References: <12779486.O9o76ZdvQC@rafael.j.wysocki>
	 <f1194b6840459447f36e5d387320ef295aa8166d.camel@linux.intel.com>
	 <CAJZ5v0hgjZdRTbDnTz7frt5+Grrt0Dft_TJgW0-t92XupCbzXw@mail.gmail.com>
	 <CAJZ5v0i9DkZR=ZnJ-+VDm-2wk-ab2X=RM69uiSTgwuhGnf8zVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-08 at 12:48 +0100, Rafael J. Wysocki wrote:
> > > +static int validate_state(struct cpuidle_state *s, struct cpuidle_st=
ate *prev_s)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->exit_latency =3D=3D 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >=20
> > The change above will break the polling state AFAICS.

Thanks for feedback. Yes. I first implemented this in intel_idle.c,
where this made sense, but then moved to cpuidle.c and did not notice.

Thanks,
Artem.

