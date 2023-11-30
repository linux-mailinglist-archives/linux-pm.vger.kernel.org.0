Return-Path: <linux-pm+bounces-536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588607FEA69
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 09:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2061C20BD3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 08:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867CC2208F;
	Thu, 30 Nov 2023 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dra6CPBS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3BA10FD;
	Thu, 30 Nov 2023 00:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701332664; x=1732868664;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YfW6il/Qm5tA+b+HtgoPr45j9dfu7F6OdxtpEIAdKRg=;
  b=Dra6CPBSvAlHivSeJSrt5POiac/YFPVFT6upY1j3+6D81X7CI1O+MybV
   yFdEAg/h6h9tBvEgLIbC8CnaO67q1QRaeyZDmaqPR6J/ITToHXc7K9nr6
   z/gsedbymgJL5/7L97yxsPsDVi+mzafw1xXWY/Dpf08CHuSqQUeJPxpzU
   L2et2N1xLtkOaIPdOswo0Fk79zYHF6awY6K8YpdwXHX1BOB+DhjLzmpMQ
   Fj6BIXGDDcwZWppf1n+5hIz0SR2xvufkc1Tl7SP8RP7txTSCStvdOq6LQ
   kYkC31Lm4nuezjAiERH8lPkOV4YFY0USGChY8j+JKsSzFZuTwRNBDoYrg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="6510140"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="6510140"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 00:24:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="798201928"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="798201928"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 00:24:23 -0800
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
	by linux.intel.com (Postfix) with ESMTP id AD3BA580109;
	Thu, 30 Nov 2023 00:24:20 -0800 (PST)
Message-ID: <a9db1de5ab4d2c8fc289654053615a53b9ffc20d.camel@linux.intel.com>
Subject: Re: [PATCH] intel_idle: add Cometlake support
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'"
	 <rafael@kernel.org>, 'Jiang Yihe' <jiangyihe042@gmail.com>
Cc: 'Jacob Pan' <jacob.jun.pan@linux.intel.com>, 'Len Brown'
 <lenb@kernel.org>,  linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 "'Zhang, Rui'" <rui.zhang@intel.com>
Date: Thu, 30 Nov 2023 10:24:19 +0200
In-Reply-To: <001701da22db$180872c0$48195840$@telus.net>
References: <20231129143132.32155-1-jiangyihe042@gmail.com>
	 <CAJZ5v0jfEsNVu=fg+Xa118F=hCGGB33U5SbiqWeCMaVMqNpUEA@mail.gmail.com>
	 <001701da22db$180872c0$48195840$@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-29 at 07:45 -0800, Doug Smythies wrote:
> Hi All,
>=20
> This proposed patch has been submitted at least once before.
> (I think more than once, but only found 1)
> Reference:
> https://lore.kernel.org/linux-pm/20200227013411.1.Ica3bb9fa898499d94e0b0a=
2bfa08ec46c89d84fa@changeid/
>=20
> I have a Cometlake processor and am not in favor of this patch.
> Reference at to why not:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D210741

CometLake is a platform from 2020, so I'd classified it as "legacy" and wou=
ld
not apply this patch without a plausible justification in form of measureme=
nt
data.

Comet lake has been used with ACPI C-states for quite a long time, and swit=
ching
it to intel_idle now may cause unwelcome changes in user workloads.

Artem.=20

