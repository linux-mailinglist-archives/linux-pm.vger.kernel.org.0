Return-Path: <linux-pm+bounces-34144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A53E4B4889E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 11:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6058A177F00
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCAE29ACD7;
	Mon,  8 Sep 2025 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwHlHsPH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6AA27F4F5;
	Mon,  8 Sep 2025 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324176; cv=none; b=TcX+SQCnHRsj5+RFKXBeEFGsOetvKYltfySFK9yfiel1peAKARk6G/S5yFYuNK9S7GZQwqKC89gOFVdDRlKsr6Am5Rc4VWUjcxYo31sQFfyfTMibN3ntFRj40nr5A1dgbRz67FumhtR8ICu5NfijlzrNcP0zaByR8+tMQMLH1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324176; c=relaxed/simple;
	bh=wTJIKbb7SQ1n1SinbgKp6nbexsmY5xc9jbdV11ciElk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NCoJcqV45+jtooV5iLQA87uPILC+q1YWScdUFDo0PXX4DGXWb81/XQOaMtJW+moiq9Loso/7+L/Gi3xgDFFGTByVXfOktwI2PBdrl0qjDm2IABlf5FcgB+e+ZeilVgrCk+4RAde6G6otCpLTsAE7sAZyy9d5TzMtnvhJU5GquC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwHlHsPH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757324175; x=1788860175;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=wTJIKbb7SQ1n1SinbgKp6nbexsmY5xc9jbdV11ciElk=;
  b=BwHlHsPHP3SzemgupF09ytMzZm0+k21xCwJ5JCVKswMbfjqNumOUxDzD
   GY7NQvXnnBfxCaUMY9VrcEFTDuEG2ZeZ0wNMBE82Umk00uXZO7OzZALW/
   RtSGA6rp28NasR4nO+oHO6/Sdnc0w1CS4FHZy7jFmkgnnGgTGKGZDwR1K
   4G02SO0HWahSxiE6o1wvsgBDXDT2tqZ1t0pd/IjUXMWx3oMLOx+43rNVg
   u09KwT/tQcZ9GkT7ok4YiKrKhyxLuQH1jH4X5vbDFxk4Cea0mml0PFIZ/
   knOjNJaJ5r68aktbFC4koXYS1NH/+bw0uupqly19q9i7hc3oKAhrkkP9V
   A==;
X-CSE-ConnectionGUID: kqDkZUqLQZKp+husSV6bng==
X-CSE-MsgGUID: bS6d8BP3SzCS0B/7Z3ZHMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="59273467"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="59273467"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 02:36:13 -0700
X-CSE-ConnectionGUID: 8rx//6F7QnmJSxVMkP7RhA==
X-CSE-MsgGUID: 8PNtX6E4QZuHCeH7CqapDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="172010227"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.204])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 02:36:08 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
In-Reply-To: <b47c91a4f4c337ec8e2fdb663e0a90fd62b5c3b6.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250904063631.2364995-1-rdunlap@infradead.org>
 <6089e22ddfdc135040cdeb69329d817846026728@intel.com>
 <20250905140104.42418fba@foz.lan>
 <34fb6a27a2c17c22c0ac93bebb0bbfd1a04d1833@intel.com>
 <b47c91a4f4c337ec8e2fdb663e0a90fd62b5c3b6.camel@HansenPartnership.com>
Date: Mon, 08 Sep 2025 12:36:04 +0300
Message-ID: <a016a06ceaa05b446d06d669cc8bac43a64c72c8@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 06 Sep 2025, James Bottomley <James.Bottomley@HansenPartnership.com=
> wrote:
> On Fri, 2025-09-05 at 16:06 +0300, Jani Nikula wrote:
>> On Fri, 05 Sep 2025, Mauro Carvalho Chehab
>> <mchehab+huawei@kernel.org> wrote:
>> > Em Fri, 05 Sep 2025 12:02:37 +0300
>> > Jani Nikula <jani.nikula@linux.intel.com> escreveu:
>> >=20
>> > > On Wed, 03 Sep 2025, Randy Dunlap <rdunlap@infradead.org> wrote:
> [...]
>> > > > +++ linux-next-20250819/Documentation/driver-api/pm/devices.rst
>> > > > @@ -241,6 +241,14 @@ before reactivating its class I/O queues
>> > > > =C2=A0More power-aware drivers might prepare the devices for
>> > > > triggering system wakeup
>> > > > =C2=A0events.
>> > > > =C2=A0
>> > > > +System states available for drivers
>> > > > +-----------------------------------
>> > > > +
>> > > > +These system states are available for drivers to help them
>> > > > determine how to
>> > > > +handle state transitions.
>> > > > +
>> > > > +.. kernel-doc:: include/linux/kernel.h
>> > > > +=C2=A0=C2=A0 :doc: General system_states available for drivers
>> > > > =C2=A0
>> > > > =C2=A0Call Sequence Guarantees
>> > > > =C2=A0------------------------
>> > > > =C2=A0
>> > >=20
>> >=20
>> > If the problem is with "extern" before enum, fixing kdoc be
>> > fairly trivial.
>>=20
>> The non-trivial part is deciding whether you're documenting the enum
>> type or the variable. Both are equally valid options.
>
> If you're building a system that's easy to maintain, it shouldn't be at
> all non trivial: you add the documentation where someone adding a new
> state would find it.  i.e. on the enum.  If you document the variable,
> no-one adding a new state would likely look at it.  I get that in this
> case they're one after the other, but think about the precedent for
> when they're not.

Ah, I meant deciding what the *tool* should do with the documentation
when the type and the variable are bundled together like here.

BR,
Jani.

--=20
Jani Nikula, Intel

