Return-Path: <linux-pm+bounces-37462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 930FDC35C1B
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 14:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 346A734E886
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 13:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B838F24BD03;
	Wed,  5 Nov 2025 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRdsV/X8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181A18A921
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348004; cv=none; b=gwMZFKisFFcUYsBU4WAyNuZgH7gdc4LwuqAKr2qama/HRSTkhDAg8VCFBDAhAoB/Us8AfpwuZ19rHthK+y02USp9f+Kg2WpiuSIapOWBKDlgi3JLTdmk5KQXAwCF7iaXIiyQAs3OrNMs/bnJx/DYQIxk19uCul+LpXZYMjxRiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348004; c=relaxed/simple;
	bh=DOkJBUEu5TzkJyD93qprP1XdnA8atq2GejItsPvSc6A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZmII6DPTN7ed2SaFa4NBTur18FhYMhPqbkUvlUZUpkd5gz+sDgoZNBtEXps7cn15KPqu0ubGPaLkTSNHnsSsmgESecwBdHcLm17a9vZ8FJZMtxjemNrUx8hrC2WyQcbPT+WdLzhbbLwHuyHf57RnpV6dsFhPz7bkYR4lXBoYc0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRdsV/X8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762348003; x=1793884003;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=DOkJBUEu5TzkJyD93qprP1XdnA8atq2GejItsPvSc6A=;
  b=WRdsV/X8I7tFv7Feqv6XTuzQ0bRyVZmH3G+yyiu+nEJhEoOP7ees9YSG
   y+qxIiSwcjORQX/wCHP1+5AF0St2mxIWUlg9/tWGS8Yl6VNaOL3mCif1x
   eH+VfeFHh/GmeYwTSpGHGyJV+Vvl6h4JJTtzAkfLVANeI/jUKwHIirXmH
   ohN4QmWk2I0R7Y0QzCHPbh8gMW0aIQkPpTMaXW55QoDqrz391CV5wiXKU
   2yZfk/PkzqkFKd6i9cFgvcYnXznXebu7gp6XbyqmdN5vvtcLLOxYSqM/r
   rQE3oKSKmJn97mSrS5Ty5GdAN4eW4Bnz3dlvWzKdZ3/RIBIFrZq+z42ls
   Q==;
X-CSE-ConnectionGUID: 3Z5TDyLXQA6x0NquR4RqRA==
X-CSE-MsgGUID: C7LUiv7QTEOKW8nvGVBBCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64156121"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="64156121"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 05:06:42 -0800
X-CSE-ConnectionGUID: Ubom39YdSSKpzF0wzkTKJQ==
X-CSE-MsgGUID: DP9cK8z6SCuU6Fzg5Yf0jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="186701264"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 05:06:42 -0800
Message-ID: <356b1c77ef385158d062ad2ecebfa275dc663017.camel@linux.intel.com>
Subject: Re: Disabling  Intel turbo on non IDA featured processor generally
 correct?
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pm@vger.kernel.org
Date: Wed, 05 Nov 2025 05:06:42 -0800
In-Reply-To: <2764104.vuYhMxLoTh@localhost.localdomain>
References: <2764104.vuYhMxLoTh@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Thomas,

The BIOS shipped with system disabled turbo on boot and user had to
manually force via the sysfs. With the new change that is not an
option.

We are trying to contact the manufacturer, but no solution yet.


Thanks,
Srinivas




On Tue, 2025-10-28 at 13:47 +0100, Thomas Renninger wrote:
> Hello Srinivas,
>=20
> Since patch:
> ac4e04d9e378f5aa826c2406ad7871ae1b6a6fb9
>=20
> there is a user reporting turbo not working, while it worked before
> and
> he claims it works on Windows 11 as well.
> No related BIOS option avail.
>=20
> The patch mentions Skylake-X systems, while the user seem to have
> another CPU:
> https://bugzilla.opensuse.org/show_bug.cgi?id=3D1252385
>=20
> Can someone from Intel please double check.
>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thomas


