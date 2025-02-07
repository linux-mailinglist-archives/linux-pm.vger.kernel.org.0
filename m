Return-Path: <linux-pm+bounces-21542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52407A2C632
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 15:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A21377A49CC
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A223F277;
	Fri,  7 Feb 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UaI62Dec"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D02238D56;
	Fri,  7 Feb 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939723; cv=none; b=ttp7uhJoGH+shfo3HxXqddmU9rGpcZtvHfz5mA1Y/Wzq1UbSGhm1nzPIesiAKf7319kPX/iy5V0CKZRIN44CmKQ8t92dPoZ2GkJBo6jbQ51omv3WL5k6VZckJ8+Cqg/fpOzB0uTbknBgDnbut1s8pHBad2GeVx2hhZLINWhfDxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939723; c=relaxed/simple;
	bh=5XIlGZsiLQw2hQ6a1oSKBh7M9NzM4ngrTEXTXgaUFr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mINKGWPh/VZPcg6QE0qHBdn/WagQNh3u5hH3O2qbCQsI8TJcwXMbwI/z6SpTvIxDbpQNm/RSuILYOKDRLvJY6TmqwrCWkHzPkYX8nNTY14k2Egdiuh97Tx2FOUzHYwKyeYzpR8lo6z8PEeE9EdW3EewXHOhSNpEKE4IQTh+pu8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UaI62Dec; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738939722; x=1770475722;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5XIlGZsiLQw2hQ6a1oSKBh7M9NzM4ngrTEXTXgaUFr0=;
  b=UaI62DecYncQ9pUWSqS9fWd9WXQjMj4yax8lx1MBOzLkp8RMG7MKOt5O
   2pQG2HQX0UAus4xBpzX3/Mb4B+HKYx2VcPiA3GcubXQVHHfTglrpQmZnx
   zWQfRzPaekFRSfN595rb9P+un5vlm/1bxy5b6MEcryiZ/o/vhkyL0no3n
   guffdbB8E7r9x8Qawvu2mfB0ojKMrK4lj8YcF+HCSfrFTP/W3M9aOSjow
   DArOSjFBvoqp9OcyhT4odd6iFXsruncMMklkpV1UPq//NBflV56rCXYSJ
   ENMvz+si3OwPGj2J7UrKDoB8anD0zFEhlFvJXQK0M3f4HCAY6MJUsUNkl
   Q==;
X-CSE-ConnectionGUID: WgKSAi6CRwW5Cn822uCI4w==
X-CSE-MsgGUID: CtYN7sAPQmyfHitXNazW7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39274297"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39274297"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 06:48:41 -0800
X-CSE-ConnectionGUID: 7Z+7UNi+QQe9rL9NzE4/cg==
X-CSE-MsgGUID: DflmxkABT/WG7ezG8AN8Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142415230"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 06:48:41 -0800
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
	by linux.intel.com (Postfix) with ESMTP id BB49D20B5713;
	Fri,  7 Feb 2025 06:48:38 -0800 (PST)
Message-ID: <4917ca35e5e0c7035f09c02d5080a69ed3e88c44.camel@linux.intel.com>
Subject: Re: [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful
 information when processing recent idle intervals
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano
	 <daniel.lezcano@linaro.org>, Christian Loehle <christian.loehle@arm.com>, 
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Date: Fri, 07 Feb 2025 16:48:37 +0200
In-Reply-To: <1916668.tdWV9SEqCh@rjwysocki.net>
References: <1916668.tdWV9SEqCh@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

thanks for the patches!

On Thu, 2025-02-06 at 15:21 +0100, Rafael J. Wysocki wrote:
> Hi Everyone,
>=20
> This work had been triggered by a report that commit 0611a640e60a ("event=
poll:
> prefer kfree_rcu() in __ep_remove()") had caused the critical-jOPS metric=
 of
> the SPECjbb 2015 benchmark [1] to drop by around 50% even though it gener=
ally
> reduced kernel overhead.=C2=A0 Indeed, it was found during further invest=
igation
> that the total interrupt rate while running the SPECjbb workload had fall=
en as
> a result of that commit by 55% and the local timer interrupt rate had fal=
len
> by
> almost 80%.

I ran SPECjbb2015 with and it doubles critical-jOPS and basically makes it
"normal" again. Thanks!

Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>


