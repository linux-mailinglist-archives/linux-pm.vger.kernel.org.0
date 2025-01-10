Return-Path: <linux-pm+bounces-20256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B2A097DA
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 17:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FEC16B0C3
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56462213242;
	Fri, 10 Jan 2025 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsndesIj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76238212FA9;
	Fri, 10 Jan 2025 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527848; cv=none; b=CgbybJpBlZaoLbg1SAztD/PpIl7/XarvxcZh/s4TNS8lKYgUIskPucYaCHUtg0TcjUs3eRl3pAcDt7pQtMyr6vTUX4fIWZEXEhjlOeczDPSm4okdN91QL3oUQ4Bv4hOtcNTxpfoCtkIq0DRKbJfefQNLu9WOipTOVQfRz+3NBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527848; c=relaxed/simple;
	bh=gw6Z9lH9aernM8LU6pNRvgAJ2sVCNEEpy6MR1ezVMCs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GSTZe7y26xJWzh5N/xFhJQIciBAnKXdgrZeEqKqCW/ETN1cRLC1B/bndSECwmEvq6vKv3UH4/tEASrPwalQaLj0PcK7cjdrk119azonC5vP5w4g4p6cJmdJPB3Ms2nWq9Od30mqE7qWn9yE/D4J2jyaL4Bis1Ysbd9daQITGpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsndesIj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736527847; x=1768063847;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gw6Z9lH9aernM8LU6pNRvgAJ2sVCNEEpy6MR1ezVMCs=;
  b=HsndesIj2W/xyt7Zy2tUJb+Dt6c1D2fKgy3sgN+yijgegBOBn6lKA7hs
   zq32N79PpO4bSEL3XTo7etDxpzACV6kZowatWqG6IxDZii3jcXmQUweFr
   0cyKT/j0+rL/4c1KwvlPALggvUNRwC/Tl8er+ILCsVJB/wzxc3A88QcwH
   KKDTXaQtskSA42xsqFVeGoVtBAsvvewLw3VXqsj2uZwfZVUqCwEOqXqBK
   sb2jxN4gXbAwux3YZ/NfLSfNA3YMkeSsNJ03GmwuJ+Fy3tb6Tgfmdb61E
   XS40AD2rAm/1W3yd35p3xs+PeKNwdKwQh9sBhntmTEP9CZbIuY9THk7uM
   Q==;
X-CSE-ConnectionGUID: htzqZo8kSaiWAmsLyz0Fvw==
X-CSE-MsgGUID: /Mq7CCduTYK0ff/w2PGQyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="47400771"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="47400771"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 08:50:45 -0800
X-CSE-ConnectionGUID: oFysmHd5Shmt4gcWVRP5oQ==
X-CSE-MsgGUID: V8RINJnjRKq0elTkMeUQKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141079684"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 08:50:45 -0800
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
	by linux.intel.com (Postfix) with ESMTP id 92C2420B5713;
	Fri, 10 Jan 2025 08:50:42 -0800 (PST)
Message-ID: <fbdaf69ec121836db4d4611842bd0c1b93224bf6.camel@linux.intel.com>
Subject: Re: [PATCH v9 0/4] SRF: Fix offline CPU preventing pc6 entry
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>, Patryk Wlazlyn
	 <patryk.wlazlyn@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 rafael.j.wysocki@intel.com, len.brown@intel.com, dave.hansen@linux.intel.com
Date: Fri, 10 Jan 2025 18:50:41 +0200
In-Reply-To: <860da841-fa82-4984-9e34-fba02e7aa556@intel.com>
References: <20250110115953.6058-1-patryk.wlazlyn@linux.intel.com>
	 <e6c49f30-b32a-4ad0-98e2-634113011f90@intel.com>
	 <5f24fe01b6dd0ae0e6d91209e143f2faff6ae017.camel@linux.intel.com>
	 <860da841-fa82-4984-9e34-fba02e7aa556@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-10 at 08:07 -0800, Dave Hansen wrote:
> On 1/10/25 07:26, Artem Bityutskiy wrote:
> > > I noticed there are no Fixes: or Cc:stable@ tags on this. Should we b=
e
> > > treating this like a new feature or a bug fix?
> > It would be very helpful to have this in v6.12, because it is LTS. So I
> > would
> > suggest
> >=20
> > Cc: stable@vger.kernel.org=C2=A0# v6.12
>=20
> I was _kinda_ hoping to hear how this affects users.
>=20
> Is this a big deal for real users out in the field today?

Not a big deal. Most SRF users should have a BIOS with the workaround by no=
w.

>  Or is this for
> some theoretical savings of 0.2% of battery life for a platform that's
> coming out in 2029?

If I interpret this question as "what is your motivation precisely", I woul=
d
answer this way:

* Because version 6.12 is LTS, there is a good chance that users of near-fu=
ture
new platforms will run 6.12 on them.
* If a near-future platform happens to miss the firmware workaround for thi=
s
issue, having these patches in 6.12 will likely mean that most users are OK=
.

No other motivation.

Overall, I would categorize back-porting this patch-set to 6.12 as "nice to
have".

Thank you!

