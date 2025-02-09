Return-Path: <linux-pm+bounces-21599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC811A2DBC5
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 10:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB7D1886C3A
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7A01494A9;
	Sun,  9 Feb 2025 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcSL6PqE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C23FD4;
	Sun,  9 Feb 2025 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739093089; cv=none; b=nP6bzw+Nip9yn+6OovIEEoMaFTXOnX8zTawvf3LXV+ZkakHJsMZZvgWShUIia/XQqSoFrwWaC5Id58ewIeor585HPSh4V/pdt+LX7xiBbPHVwx1XvbnRTSwicRlRBYSTlXmH4lsDREWi8cX9VO0THxMJ/OcAQ+WxZhiFXMfXD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739093089; c=relaxed/simple;
	bh=Su5g4iggh06hom7FhOwOe9xh5oBA+OUDx6rTWwhgShQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jTnma0VdiB9uI+dvjr9vtO4riHAQITonIgk4PZtk0tM3lILbRWCpRhNi3DNDvPTCrRBP5JNRUHpmPHzigUcfFWxypRqv8hVSwrv8GZsPArc5gLSGZDKraYeeoP6wuPnxLb1qH5jOIYJo+BDKCEr7Fhb1pd84QcEMn+2SvHO94IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcSL6PqE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739093087; x=1770629087;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Su5g4iggh06hom7FhOwOe9xh5oBA+OUDx6rTWwhgShQ=;
  b=EcSL6PqE/i2fvfFwvIS8eT5uIUbgEvJvaQEgCmJkKaoecj3kV+hv5fmS
   d1lzs5IAS+5KTy8F6dMzEoEQmCsev0iweTEvA7YIO4XS86BLriE3OBvjj
   6aZd0Gb8xXUqig8+YCriE9awB0uwokytMva6abmFbRPe148upFd5GDw6c
   KAl/DViK02Fr72uZ0LV3yZ+BIz+0wmpxJAwWBMzquJbLnL0vfFbao4ZXg
   5YOnhN86F6n52LnHe39r4HQW2AnB+YKfoAfJrudByEbLflEmBBFKYyiFK
   Z+dIFfOfEFN/Uq1MQD4VNce4vThy37ruza5GF0skAa+Zc3+mYDnk0yAto
   Q==;
X-CSE-ConnectionGUID: VuwIVpb1Rump5CPF/hL8Ow==
X-CSE-MsgGUID: C0XlsuL/Tqysdg7bQEhM3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="39839908"
X-IronPort-AV: E=Sophos;i="6.13,272,1732608000"; 
   d="scan'208";a="39839908"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 01:24:47 -0800
X-CSE-ConnectionGUID: v1+arjs7QNyYGc2aJDQIHw==
X-CSE-MsgGUID: VmvCN2/lQoCY4fifWftvKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,272,1732608000"; 
   d="scan'208";a="112144468"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 01:24:47 -0800
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
	by linux.intel.com (Postfix) with ESMTP id CE20220B5713;
	Sun,  9 Feb 2025 01:24:44 -0800 (PST)
Message-ID: <38fadf14318be8f3c622719cc526f7586657e0e2.camel@linux.intel.com>
Subject: Re: [RFT][PATCH v1] cpuidle: teo: Avoid selecting deepest idle
 state over-eagerly
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'"
	 <rjw@rjwysocki.net>
Cc: 'LKML' <linux-kernel@vger.kernel.org>, 'Daniel Lezcano'
 <daniel.lezcano@linaro.org>, 'Christian Loehle' <christian.loehle@arm.com>,
  'Aboorva Devarajan' <aboorvad@linux.ibm.com>, 'Linux PM'
 <linux-pm@vger.kernel.org>
Date: Sun, 09 Feb 2025 11:24:43 +0200
In-Reply-To: <009d01db79b9$aecd1c70$0c675550$@telus.net>
References: <12630185.O9o76ZdvQC@rjwysocki.net>
	 <009d01db79b9$aecd1c70$0c675550$@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-07 at 15:40 -0800, Doug Smythies wrote:
> I have only just started testing the recent idle governor changes,
> and have not gotten very far yet.

Hi Dough,

there is the menu governor patch too. While it helps the server, I did not =
test
it on a client system. May be you would to check it too? Subject is:

[RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful information when=
 processing recent idle intervals

Thanks!

