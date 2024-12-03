Return-Path: <linux-pm+bounces-18403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71A69E138C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 07:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9978D16129D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 06:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F99514F104;
	Tue,  3 Dec 2024 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YgTqxsxv"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275F1865EA
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733208664; cv=none; b=tQOJMisDfS9tR32EnzmzW3PeemmfVuFXPl6nhAadzfRaf74TWfftdRYPH9WDAnI3gF9oI8GwfA0vtmMDtNPz+gp8iFgGgjZ70Nkyc3YmpKMrUAEbSXRU5YEmjaqlZ55xXebhvmbDyzejP1D4HmdOySN51aUCm8dKUvdQOdw4TFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733208664; c=relaxed/simple;
	bh=6/hy5WoqGn8qJtQlfBenG3SJbexf/MpVLxIfNfIo004=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF7MEC3BXyvV1hoefSZs3tjjkTuN2VbtI5Dn+soF3aW9kGbEY5Hse78REpbndVokNBq1tmy7CcXsgDxzAYLf/KBGlQbDSNbodNpRNXo1MNyw2HVW43hrpbrZMTuUfhKnbDuhzKD8kDFQm9UGSlIyTlhwfLbM8JyDdr02/45Ri3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=YgTqxsxv; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733208656;
	bh=6/hy5WoqGn8qJtQlfBenG3SJbexf/MpVLxIfNfIo004=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgTqxsxv6DmKMeEdGEeqJcI/KkxSMmTikgxQ0pwBRE7jIm2Civk3AVnYUdBrmyk6T
	 mtKpDnn74U6WZVODnRGp0ngDct9NvwxGSF3PeYnCn2uaiiNAj9Sgv1Ga9DNB3hKg+n
	 yhWjnzIZ00IfKLDvlqcSIw5jpgx8b30UwpNzwTPU=
Date: Tue, 3 Dec 2024 07:50:55 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, 
	"Coelho, Luciano" <luciano.coelho@intel.com>, "Saarinen, Jani" <jani.saarinen@intel.com>, 
	"Nikula, Jani" <jani.nikula@intel.com>, "De Marchi, Lucas" <lucas.demarchi@intel.com>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: Regression on linux-next (next-20241120) and drm-tip
Message-ID: <5e405ad4-34d6-4507-978f-3d81d4af2455@t-8ch.de>
References: <SJ1PR11MB6129CCD82CD78D8EE6E27EF4B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612965ACA3E84745346F0400B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB612965ACA3E84745346F0400B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>

(+Cc Sebastian)

Hi Chaitanya,

On 2024-12-03 05:07:47+0000, Borah, Chaitanya Kumar wrote:
> Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
> 
> This mail is regarding a regression we are seeing in our CI runs[1] on linux-next repository.

Thanks for the report.

> Since the version next-20241120 [2], we are seeing the following regression
> 
> `````````````````````````````````````````````````````````````````````````````````
> <4>[   19.990743] Oops: general protection fault, probably for non-canonical address 0xb11675ef8d1ccbce: 0000 [#1] PREEMPT SMP NOPTI
> <4>[   19.990760] CPU: 21 UID: 110 PID: 867 Comm: prometheus-node Not tainted 6.12.0-next-20241120-next-20241120-gac24e26aa08f+ #1
> <4>[   19.990771] Hardware name: Intel Corporation Arrow Lake Client Platform/MTL-S UDIMM 2DPC EVCRB, BIOS MTLSFWI1.R00.4400.D85.2410100007 10/10/2024
> <4>[   19.990782] RIP: 0010:power_supply_get_property+0x3e/0xe0
> `````````````````````````````````````````````````````````````````````````````````
> Details log can be found in [3]. 
> 
> After bisecting the tree, the following patch [4] seems to be the first "bad"
> commit
> 
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> Commit 49000fee9e639f62ba1f965ed2ae4c5ad18d19e2
> Author:     Thomas Weißschuh <mailto:linux@weissschuh.net>
> AuthorDate: Sat Oct 5 12:05:03 2024 +0200
> Commit:     Sebastian Reichel <mailto:sebastian.reichel@collabora.com>
> CommitDate: Tue Oct 15 22:22:20 2024 +0200
>     power: supply: core: add wakeup source inhibit by power_supply_config    
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> 
> This is now seen in our drm-tip runs as well. [5]
> 
> Could you please check why the patch causes this regression and provide a fix if necessary?

I don't see how this patch can lead to this error.
Could you doublecheck the bisect?

Note: Having line numbers in the trace would be very useful.

> Thank you.
> 
> Regards
> 
> Chaitanya

Thanks,
Thomas


> 
> P.S. We could not revert the patch cleanly and therefore we are yet to verify the bisect but we are currently working on it.
> 
> 
> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20241120
> [3] https://intel-gfx-ci.01.org/tree/linux-next/next-20241120/bat-arls-6/boot0.txt                                                                                                                                        
> [4] https://cgit.freedesktop.org/drm-tip/commit/?id=49000fee9e639f62ba1f965ed2ae4c5ad18d19e2
> [5] https://intel-gfx-ci.01.org/tree/drm-tip/index.html?

