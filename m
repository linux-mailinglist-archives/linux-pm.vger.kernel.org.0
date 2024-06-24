Return-Path: <linux-pm+bounces-9907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC83915499
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 18:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87BFDB261F4
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C8A19E80C;
	Mon, 24 Jun 2024 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPoQ5zju"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C8019E7F1;
	Mon, 24 Jun 2024 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247477; cv=none; b=hgt5ZlthrQyIRme5NNPOunNMbdqCAEdlBvLDbJNkDp8SHLdDfLYrMA7d7Nz7BRh0QIF8aCYf+dmRElOnvNBrCDZGj02j8bC8LX22V531U+gHLbeU0PpwemA00EZfqDaWa3keTL+whlhxCJOki0znxufPIm+JnPabAJm2nyUGUeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247477; c=relaxed/simple;
	bh=rqFwVvO7kc9furriT+NUoRa0+2A0hpN6NQP3M97zoLI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OdqGy1y8fELiCxlScKwmOtNBLMaimgsXFxR6C0MMud4+UwxbGiXHmycaLGhtxoBLKe3P3RnUvLtEfK2ZVqgLlAFPJjyusXm98RhRBRn6bqkJsYMoqEFvZzOgFDoztqp3MI5aVvhylW98uaUW4kjqjlZLNq9RvredFjI+hK7/cqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPoQ5zju; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719247476; x=1750783476;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=rqFwVvO7kc9furriT+NUoRa0+2A0hpN6NQP3M97zoLI=;
  b=RPoQ5zjuB7QRUglcWnRtO7QLOTgcn+fPMlvHAfS7wy6qRzZflENd7M+L
   JmLLUAckpzoG4s6AHVa7DgmXmjA+AprJ2g3EnQEp/NqdQcWghRWDKnOI4
   enrD71mX51aDtCkDDHu2vGUC1I6bkI2Li1gvKZ8abjY9Oy2Xf4UeoVV6e
   RL3yrR86xDpaiH9SV6st+8QVjeayh6LWkkvz+xH/VrWbIAcYL65C+2B+8
   Z7SIENOOMh27YHuz4bwblXEi4fypIh0tTdmHOyEg8B1+kuiuUcaIEh46S
   +4DBdbQA8cTek78zq/hzrvBgPodNWnuR9bXlyGjbO8/PRyq1OB53Uiwrv
   Q==;
X-CSE-ConnectionGUID: YjlFGaxkSUCYQTy2F3w8nQ==
X-CSE-MsgGUID: nIssueWOQ1Cw7uLCgIHyVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16054535"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16054535"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 09:44:35 -0700
X-CSE-ConnectionGUID: Viurw4iDREuNu7E0+Riarw==
X-CSE-MsgGUID: stii1T48R1uXiBgx2xfTYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43234237"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.61])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 09:44:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Jun 2024 19:44:26 +0300 (EEST)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
    Sebastian Reichel <sre@kernel.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>, 
    Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL RESEND] Immutable branch between pdx86 lenovo c630
 branch, power/supply and USB
In-Reply-To: <2024062440-guide-knoll-94d0@gregkh>
Message-ID: <948b6f71-7a72-d03d-c36f-ff4f08987f0d@linux.intel.com>
References: <e42fb2e9-81d4-4e40-ff3a-f9d6a46d03f9@linux.intel.com> <2024062440-guide-knoll-94d0@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-236211645-1719247216=:1031"
Content-ID: <a331f82f-a069-a912-3ae6-d6a9e525b17e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-236211645-1719247216=:1031
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <a4bfb34c-7c70-2d12-377b-ceb5cfaa1972@linux.intel.com>

On Mon, 24 Jun 2024, Greg Kroah-Hartman wrote:

> On Mon, Jun 24, 2024 at 07:24:55PM +0300, Ilpo J=E4rvinen wrote:
> > Hi,
> >=20
> > This is v2 of the lenovo c630 IB branch with the build fix for non-ARM6=
4=20
> > platforms (built on top of the commits in the previous IB PR). Resent w=
ith=20
> > full Subject line.
> >=20
> > The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacf=
abd0:
> >=20
> >   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
> >=20
> > are available in the Git repository at:
> >=20
> >   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-driver=
s-x86.git tags/platform-drivers-x86-ib-lenovo-c630-v6.11-2
> >=20
> > for you to fetch changes up to 13bbe1c83bc401c2538c758228d27b4042b08341=
:
> >=20
> >   platform/arm64: build drivers even on non-ARM64 platforms (2024-06-24=
 18:22:15 +0300)
>
> So was the first one rewritten?  Or is this just the second patch on
> top of the previous one?

Nothing was rewritten, just one patch added on top of the previous PR. The=
=20
previous PR had only 2 of these 3 commits:

> > Bjorn Andersson (1):
> >      dt-bindings: platform: Add Lenovo Yoga C630 EC
> >
> > Dmitry Baryshkov (2):
> >      platform: arm64: add Lenovo Yoga C630 WOS EC driver
> >      platform/arm64: build drivers even on non-ARM64 platforms

--=20
 i.
--8323328-236211645-1719247216=:1031--

