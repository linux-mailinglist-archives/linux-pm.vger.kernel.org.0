Return-Path: <linux-pm+bounces-24983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE5AA81D7C
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 08:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF2819E7D97
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 06:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A471E9906;
	Wed,  9 Apr 2025 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yc+e34az"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC603D81;
	Wed,  9 Apr 2025 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181538; cv=none; b=sPIOBrCLIQ/tnoKVjveZNwR8Dq9nTz3yoE535NYDw3OY0vtoK8x9Eo+2m5vratLp64oS44sbWkFYsN3zche74TWNyd20VXcL24M73llv6+NvbPGjBp5wQ9yERdR6MN5D385W84TzMux3mLe9A+6lze+YQXAKAb8seuBAxMZdxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181538; c=relaxed/simple;
	bh=kWYezyYs1zuswcTDPHq/cb/rTH297BcrKTnJpgUhmcw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j4xM8k7spHQdRC5O1ygino9FmBqQs7QQm/yO2o7xllQFDGjssMk22emL6d5aKnW5n33iBbmt52kDlMmoBobXsId6zDCm9uCQwL5Q3lMiG+soM1gOOxHf9SiKVJZNeoEBg3cLkouqSdvS/5ipAjnPtiDtmvXpalxsnCkbvYAW+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yc+e34az; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744181537; x=1775717537;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kWYezyYs1zuswcTDPHq/cb/rTH297BcrKTnJpgUhmcw=;
  b=Yc+e34azWhCtGe9WxdfeXDAzL4W90UWwKIR+ekwPUGN1yf9yWSMhoEtV
   mWWWiqj0gMcK2IqVjNJZzJhT18HtdJekZznl2h5kuYUOREbPv3Dwqj9rY
   WYtQ/tq549pJbRFtyV/vei8FmEaVwzO1W8ygc1uKX1oezjCZiFvqpkgiG
   w3dJeOhkAdXX9yCGvyyI8Tb6+Cf1lXcR8u2YPNC00slQ+/ZF3sRb9y1i/
   mF2xd40FljQ3sCNOSOAAjyYiPjPthhh1VUcYXTqdrOU7ZNmWoR8elUUps
   W4AxtwQQ5JY1024oaVROHXQTpg2iABcUTYVmGkoXo+8amRtTZ8D2gk09W
   A==;
X-CSE-ConnectionGUID: 9Bx0AWApQXOt4jVovhWQMQ==
X-CSE-MsgGUID: LLTem6PjTUKISLDp2SX/Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45771591"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="45771591"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 23:52:16 -0700
X-CSE-ConnectionGUID: 7pIIqn+7T9m/+NxggTxebg==
X-CSE-MsgGUID: sjRp9DNDS5qFuztZ37c6lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="129005862"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 23:52:16 -0700
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
	by linux.intel.com (Postfix) with ESMTP id 090EE20B5736;
	Tue,  8 Apr 2025 23:52:13 -0700 (PDT)
Message-ID: <3892c0eb983900c184c6d06ffe8364e2da23ae2a.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/2] cpuidle: teo: Refine handling of short idle
 intervals
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Christian Loehle <christian.loehle@arm.com>, 
 Doug Smythies <dsmythies@telus.net>, Aboorva Devarajan
 <aboorvad@linux.ibm.com>
Date: Wed, 09 Apr 2025 09:52:12 +0300
In-Reply-To: <4661520.LvFx2qVVIh@rjwysocki.net>
References: <4661520.LvFx2qVVIh@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-03 at 21:16 +0200, Rafael J. Wysocki wrote:
> Hi Everyone,
>=20
> This series is intended to address an issue with overly aggressive select=
ion
> of idle state 0 (the polling state) in teo on x86 in some cases when time=
r
> wakeups dominate the CPU wakeup pattern.

Hi Rafael, I ran SPECjbb2015 with and without these 2 patches on Granite Ra=
pids
Xeon (GNR).

Expectation: no measurable difference, because there is almost no POLL in c=
ase
of SPECjbb2015 on GNR.

Result: no measurable difference.

Conclusion: these 2 patches do not introduce a regression as measured by
SPECjbb2015 on GNR.

"No regression" is also a useful piece of information, so reporting.

Thanks, Artem.

