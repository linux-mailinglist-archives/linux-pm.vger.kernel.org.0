Return-Path: <linux-pm+bounces-9073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DA89068FA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 11:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D381F26AA3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC0113E8BF;
	Thu, 13 Jun 2024 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fRYHIdOf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF513E05B;
	Thu, 13 Jun 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271352; cv=none; b=ggPHMbruSyL5FoFCYlh32YWRRkyDPAkb9YIhKuWaP+WWBl/zxnRY2rlm53rUldNSXpc81LWLzuQB6bZq43pU4t2b0uY96Pc/88P62zyyBZGu5hYqwDR/BgaKBcuHXE51kRu0lYYozNipJJ+8x6ls7QSH05JEZuYCp+SvpE9bnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271352; c=relaxed/simple;
	bh=SAFsliebWAF2Ca6m66wUlX4Al1PjQVBMB3uMrdEyohc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ9xqp4rs6MDan23FJ3/BDjkCjxxWaRshDHPCg9LoV/A/AEfs4GY+fvSxCaMlzXzjM3vf7nWYqHQE9nrsq1m4tFmQDqT4cv7jqsqgJbddkrBxu1IoYES+TcnDX2ZjBqRmvp995Xri7SimXPBUD86f40w48F8JDG9nLH0p/6WgT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fRYHIdOf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7BECA40E0031;
	Thu, 13 Jun 2024 09:35:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id e42eXaHicUkL; Thu, 13 Jun 2024 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718271344; bh=oIPn1GDwjrm+RtDrjM+WuOgJ3cnBpyNsf+6S28z4qk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRYHIdOfioJp7KPlNZlHHGe/7jFtdF6KDu/rwn3ErjPLTdCOpah1EwM8vW6H9ZZvp
	 uvR+Gz/JYijrVgdAKpqVcbhintzVrnVPgnEMRAoPy9HddvdjFhWKLr0GNnTGQow0WJ
	 ZHCXs+nCx6yo9EPME98oINvksnjlqmdRy9Ui2I1Vl6tFmfsTEe0dwT+67THEHAB1FP
	 MF8SvG7n4ruIjUpPKkEP5QmlevrstciNtn4wUpPtSyI24iEI6U8gbfZj5i4g5ebuLE
	 5N6eNArOz61yw4WajoCEqpBUA72XXRGdahbeYuxePb92tDYK4gV13K2LGNJIJgb2lF
	 2nvT5jWneVUxTN9Zc+Oyznll7T5dHbPnDaOCBC9ZNtOOkGHYdKLQQc0OUO5ARrZqiV
	 ubDjoswhW/6/7PZoJZBjMnPn4hd5yzxlgrt3v2FUEH/dEGCVOsjdLXUMZ8CrsUXwnU
	 7S1T+HuGviMQ+1bQFVhTYwks+vhjaRcnVCFacrGkHGS9LdgRIdzJX2VSnZYsb1AMLb
	 FDHFhUAHzhYAKcZuud2vvd8uwb5F8zUQs29joL86+KOIjcV0pL4FHhEqh/K/D1kMWe
	 dtboXmQ/BdoJuL1SBMHcHMTLTTvX+wecOfWcyoD2q7xz/nrQ8gJ6fayFmC6giMGpQa
	 FXBlfYHNZoYj4ySigoulzMkw=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9CB5E40E016C;
	Thu, 13 Jun 2024 09:35:32 +0000 (UTC)
Date: Thu, 13 Jun 2024 11:35:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Yuan, Perry" <Perry.Yuan@amd.com>
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Huang, Ray" <Ray.Huang@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/10] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
Message-ID: <20240613093527.GEZmq9X5SRq6qwQ_O6@fat_crate.local>
References: <cover.1718095377.git.perry.yuan@amd.com>
 <7a2817ce6e8e6a2787bed8285dba8d81423d8414.1718095377.git.perry.yuan@amd.com>
 <20240611105216.GAZmgsYC-J_yLfdupF@fat_crate.local>
 <e41fd460-6b50-4792-9328-3eda370672e4@amd.com>
 <20240611143929.GEZmhhoW1qCvIWS0SK@fat_crate.local>
 <CYYPR12MB8655D1333B53BB6DC83E45649CC12@CYYPR12MB8655.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CYYPR12MB8655D1333B53BB6DC83E45649CC12@CYYPR12MB8655.namprd12.prod.outlook.com>

On Thu, Jun 13, 2024 at 08:59:11AM +0000, Yuan, Perry wrote:
>     Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/56713-B1_3_05.zip

What about "This link will become obsolete" don't you understand?

Do you need me to explain it in greater detail?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

