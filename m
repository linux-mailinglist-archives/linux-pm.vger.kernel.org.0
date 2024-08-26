Return-Path: <linux-pm+bounces-12908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4948C95FAF1
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 22:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004201F241C3
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 20:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262ED19B3CB;
	Mon, 26 Aug 2024 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WwpyI4Rd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D279EAC7;
	Mon, 26 Aug 2024 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705391; cv=none; b=BqjC7SfwYkiFLvEYsajDKe9n4Odm2WOorasV5wOXdW2d1gtFFEfVlqHmD4M/MI2Czhe9UT6xeGHYZAJjZH/SaIq8W4b+Fq3fDoPCPDWMElKM0+SkRgJPSRGkvjkOGhIeAELt/LjNR1CEAbBuoEpaYqTsYiZdlfvc0NvMKq0EzR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705391; c=relaxed/simple;
	bh=3McNi8RQsTankaDswnfRhRdsB4CjvWxQfgNMRyZMaus=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RiOA9rNlhpwZmJLdnPF3DBztRip55RqjVnL6A6raZvUjSS6xd3Xj9tKIZwdZ8B3+/chZZE1CHoDMC3qfKJb1Ouh8MqSRqgbVL+l4m+6LRrYpk9k80h/ynBc+bTj/y06K8z8SCEhp50X8gTuStRQv3ee9fwnF+Mh0Tq91OtSXi+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WwpyI4Rd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724705389; x=1756241389;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=3McNi8RQsTankaDswnfRhRdsB4CjvWxQfgNMRyZMaus=;
  b=WwpyI4Rd3XAHugTEqW7ihlpgWMsJ1xxkDnKTLuHTjvLGcy8JZPUwk2sA
   ZPhQp1JSc+7xFff38bsIQVzkOiPsZxlwOUm4aqKTJAmHL84qm2QiYv1L+
   3SnKMWjc2WqBtVt++eBD1pJjKw1DHbHGoeolXAt46+FqXQhCYxqRwcWRl
   2njMfrFZXRkBrJwYyNVMIOvaQ6z1HAdFbJ+7/P73p87TNJLQmlqJubR1Y
   ydkfhpSpJ8JdvDijbeKr7IMtL5R5f0xai1T61PjhHP1t3gG4w0lhJB3zq
   nSRsr2Wzzh+/44X3RngS40SGhcN3f1lfkb/cQaKFdnPVNeOAj3jKYqVf9
   Q==;
X-CSE-ConnectionGUID: emyPQhFISdOwawEhtpiWDQ==
X-CSE-MsgGUID: PoPX2fS2Q3ymawiRx6UYVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23020521"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23020521"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 13:49:49 -0700
X-CSE-ConnectionGUID: 7pm1e44OQhCKRtsNU+DeTw==
X-CSE-MsgGUID: sI4AbRW+QvOdsOZoeOXjMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62681629"
Received: from dgramcko-desk.amr.corp.intel.com ([10.124.223.43])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 13:49:49 -0700
Message-ID: <7ea23975329e4a22fd235cc28d365296fec47739.camel@linux.intel.com>
Subject: Re: [PATCH] pm-graph: ignore sleepgraph.py artifacts
From: Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, ricardo@marliere.net, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Date: Mon, 26 Aug 2024 13:49:48 -0700
In-Reply-To: <20240825095353.7578-1-0xff07@gmail.com>
References: <20240825095353.7578-1-0xff07@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-08-25 at 17:53 +0800, Yo-Jung (Leo) Lin wrote:
> By default, sleepgraph.py creates suspend-{date}-{time} directories
> to store artifacts, or suspend-{date}-{time}-xN if the --multi option
> is used. Ignore those directories by adding a .gitignore file.
>=20
> Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
> ---
> =C2=A0tools/power/pm-graph/.gitignore | 3 +++
> =C2=A01 file changed, 3 insertions(+)
> =C2=A0create mode 100644 tools/power/pm-graph/.gitignore
>=20
> diff --git a/tools/power/pm-graph/.gitignore b/tools/power/pm-
> graph/.gitignore
> new file mode 100644
> index 000000000000..37762a8a06d6
> --- /dev/null
> +++ b/tools/power/pm-graph/.gitignore
> @@ -0,0 +1,3 @@
> +# sleepgraph.py artifacts
> +suspend-[0-9]*-[0-9]*
> +suspend-[0-9]*-[0-9]*-x[0-9]*
This seems fine. If you run the tool inside the tools/power/pm-graph
folder I can see how it would be annoying to have all those output
directories show up in git status. (re-send with Acked-by)

Acked-by: Todd Brandt <todd.e.brandt@linux.intel.com>


