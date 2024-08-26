Return-Path: <linux-pm+bounces-12906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999E895FAAC
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 22:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9C51F21AED
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 20:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8BB4D8BB;
	Mon, 26 Aug 2024 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5o2DrIk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CC629408;
	Mon, 26 Aug 2024 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704262; cv=none; b=n+RjQkS8pS7C3DF+xh882rJM1TfHkxebnaSzwKISL4RaCbQJKd8UxZVE91BkCiqfJtzYTnbheuYfXs4XUr3Yk3XjDCrPWgAZX6B3x/KbCJx11PuyHx80/07kvnuyMh/g/jae2RAl1EcbqgqTMs3HK6gLMV/1gBUuS3GJW27WhsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704262; c=relaxed/simple;
	bh=gtpUXosV9nTewaoVXIBB26T8v/macdxzA2gCDaiEvlM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qexYjEy3QH9Sj04F06equyRiwVeK55DeqNlu0zLXox5PZ1sJOy3Gk6O5jrBKgrVV6sHc4SlzXQsciB9q5oINmkCdkMsEUluVvPlLHmUNRT4vBfQTQxbzjkbpSET5GoQcZo7mzpsBwaednQ9+tDT6LYfpXAB48POstSCa4LeFftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5o2DrIk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724704261; x=1756240261;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gtpUXosV9nTewaoVXIBB26T8v/macdxzA2gCDaiEvlM=;
  b=d5o2DrIkdzixJONc6dJ9bSC8ofWnSbE0rzxu2QHX08wJJI3kk4kJDWXe
   jkF9tzJLSKHh0B7ul425V5l9Q9mAN2YRCGJRz+0+boWyvdGQwaPDCMMyL
   Q5npC530r2Z+3FKR7H+NPjOTjlDE35wu5z7Dc6IzkoSrkzPh60tkT89Nu
   LSlMiuGoVEfzdtBP1LkC/2WiM520Z4DfFpVKgzknCb/+nFPkHUbooqLLK
   OPJ67EQgYt0RYeCLoapDm7pP5q8AbIsAET9kpE6OoKa9UGpkofXmVO/JE
   kCXeARXntpsiv/wAjBOJsc3HXp67OcTlTsmhuJr9ZIT98caJWBtUW2jZh
   g==;
X-CSE-ConnectionGUID: NcdW6nl4QOux29UzlSCH3w==
X-CSE-MsgGUID: e4UkSTRMR1aKLcC9Unoczg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33718255"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="33718255"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 13:31:00 -0700
X-CSE-ConnectionGUID: dWFGDeYxRDWN4Oa61Cd7vQ==
X-CSE-MsgGUID: Y46xu62dRjiebJe/ze2JPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66780154"
Received: from dgramcko-desk.amr.corp.intel.com ([10.124.223.43])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 13:30:58 -0700
Message-ID: <36376e1cb02b3ef44b849fc28e6b3f38e18a50ef.camel@linux.intel.com>
Subject: Re: [PATCH] pm-graph: ignore sleepgraph.py artifacts
From: Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, ricardo@marliere.net, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Date: Mon, 26 Aug 2024 13:30:42 -0700
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
directories show up in git status.

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>



