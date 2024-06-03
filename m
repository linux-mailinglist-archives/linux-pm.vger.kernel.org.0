Return-Path: <linux-pm+bounces-8531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF80A8D87B0
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 19:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF33E1C21F70
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E961369B4;
	Mon,  3 Jun 2024 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOk2zbJY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3017E12EBCA;
	Mon,  3 Jun 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434678; cv=none; b=epLSe1HCoCppaF/im8DZSkgLn3zSwuaJgviQPEzCEmX/E6ejS1SEhkw18SDNidyAQyao8bu5ztfwmSDwc7u7d84Dg+09BVueBYjWJ8igXKFrPao21wZ8RXgOJtpFOW4WV0kD+h6yjbvgXyWmFAsfkdYc6N4/iwyVML+Rm8TMSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434678; c=relaxed/simple;
	bh=NjLDT7cs+dCU+pDcUFffYxuBdRTC85LI9u06hQm0TKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KU23ABoJGxYZ8Cd8NYcKOYQ2KvvG+tkBTTYrRjBTlWx9DXhFtBCkKWPxTFhdG0V4R3Dgzf4cQUxjH1XzmPmSj2Mw2vYlWqBNTBkh4nhc68gTStKcXnaV/FgR40QZJtH982/8qQMaKQ/qUJe4Qll7u1xOHOF3LxK25x+9PLj6r/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOk2zbJY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717434676; x=1748970676;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NjLDT7cs+dCU+pDcUFffYxuBdRTC85LI9u06hQm0TKk=;
  b=fOk2zbJYRxDEBSs+xHr4aavFJ0Ipd2GUXsCNxApaHu/hDVjeqxt8ldfS
   jVOISHlT6JzHks6B9MOayCtrPmFimrLegSnRcZYpHL0QBPjKKmE2o95KQ
   +Li66xC7oBXqT8jd/ekd34xcDgvfy7kUtOTCVCyjxrYlD1EJcybgzNJ2B
   8w/qStwh9uDaT5gD6XUc80W36Pvxje3/Bwu3vHOX2QDPdaK19cPrvU3Cd
   KffnMeKjVNyAvidzEPOoWWw9LNqBMTf5eTrnv0+zv8hazhl4oRsku5n+A
   qKzeup7gYO4qVAZs90NMfeilC6iNCJm4GITr4bQczmNLGy+kwJIzplhIK
   g==;
X-CSE-ConnectionGUID: icVCUYzTRQ69QXxGG0F9eA==
X-CSE-MsgGUID: TG/8zJD5SOO/ODdTbk6iHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="31470633"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="31470633"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 10:11:06 -0700
X-CSE-ConnectionGUID: EnnN1zeSQouECDC9nrVcig==
X-CSE-MsgGUID: MDItepmySAyA8KC7ZsTgsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="41881074"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 10:11:02 -0700
Message-ID: <c3526e7a0e80ec1a3a011259c38ab4b772040ea4.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/6] cpufreq: intel_pstate: Do not update
 global.turbo_disabled after initialization
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Xi Ruoyao <xry111@xry111.site>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
  Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Mon, 03 Jun 2024 10:11:02 -0700
In-Reply-To: <0324bc3a88654855719cd48a5ed69a34eea31037.camel@xry111.site>
References: <13494237.uLZWGnKmhe@kreacher> <8366982.T7Z3S40VBb@kreacher>
	 <bf3ebf1571a4788e97daf861eb493c12d42639a3.camel@xry111.site>
	 <6d5ee74605bd9574baa5ed111cb54e959414437a.camel@linux.intel.com>
	 <6ebadacd8aaa307a5766cdb1b4d4a5c69acd87ac.camel@xry111.site>
	 <30a30c5107a47a2cc3fd39306728f70dd649d7fe.camel@linux.intel.com>
	 <f382e06635b3b52841d1e0c11dcf639d225edae0.camel@xry111.site>
	 <29d69252dcdc398f147c9139a8666d09e7bd831d.camel@linux.intel.com>
	 <0324bc3a88654855719cd48a5ed69a34eea31037.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-03 at 21:12 +0800, Xi Ruoyao wrote:
> On Sun, 2024-06-02 at 16:11 -0700, srinivas pandruvada wrote:
>=20
> /* snip */
>=20
> > What is the output of:
> > grep . /sys/devices/system/cpu/intel_pstate/*
> >=20
> > Also=C2=A0
> > rdmsr 0x771
> > rdmsr 0x774
> >=20
> >=20
> > Try these three patches. Don't worry about the commit description
> > for
> > this issue.
>=20
> Unfortunately they still do not fix the issue for me.
>=20
> The outputs of grep and rdmsr commands are initially:
>=20
> /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost:0
> /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> /sys/devices/system/cpu/intel_pstate/min_perf_pct:9
> /sys/devices/system/cpu/intel_pstate/no_turbo:1
> /sys/devices/system/cpu/intel_pstate/num_pstates:41
> /sys/devices/system/cpu/intel_pstate/status:active
> /sys/devices/system/cpu/intel_pstate/turbo_pct:33
> rdmsr 0x771: 10d1f2c
> rdmsr 0x774: 1f04
>=20
> But it then changes to:
>=20
> /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost:0
> /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
> /sys/devices/system/cpu/intel_pstate/min_perf_pct:9
> /sys/devices/system/cpu/intel_pstate/no_turbo:1
> /sys/devices/system/cpu/intel_pstate/num_pstates:41
> /sys/devices/system/cpu/intel_pstate/status:active
> /sys/devices/system/cpu/intel_pstate/turbo_pct:33
> rdmsr 0x771: 10c1f2c
> rdmsr 0x774: 1f04
>=20
> It seems only the output of rdmsr 0x771 has changed.=C2=A0 And if I read
> the
> SDM correctly it's a "Most_Efficient_Performance" change.
That is fine.

We don't have any notifications either via ACPI or via HWP interrupt.
I think it was working by chance before this change as by the cpufreq
core is trying to set policy, the turbo is enabled by the firmware.

What is this laptop make and model?

Thanks,
Srinivas

>=20
> > Please send me full dmesg after you see the issue.
>=20
> Attached.=C2=A0=20
>=20


