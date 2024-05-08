Return-Path: <linux-pm+bounces-7636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5948BF855
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 10:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF9A1C21412
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 08:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC7E2C68F;
	Wed,  8 May 2024 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ass3Ngfb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DF11DA53;
	Wed,  8 May 2024 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156350; cv=none; b=Kc+v2QuxFKXTNIUKA8v4aw+K943kjbvj6QRRUabSpLtFzuCKIbcB9MlOkH2T35VHCETxSOfraKY2lo6rMdSmfu+duUakSbeyvImw8NNECyAdIuMtsdyggU9i5MT7BES9oqAm2Zr55Ny9dLhshRjMwHpgL6EZqgFMagNmfIHlOWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156350; c=relaxed/simple;
	bh=7EdiqmWW5EIGiv89Zc4uXj762VPjnhbjsW52TZwT6GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7QJtlxa65TwDU1gxTa4Kwa99BXXLGBhvOM1sprWVbZgWkdAB9lV3rlDVFp7KEtjlqvM2rNlFTQlKhktpIu/d+ESbRCP+Jx0Kgz/uATLet3v8cffogAD/lyo9kfOuwMuoN5Z/OPxDFriyBMZNtM6T8q1NVgHoQpfsGfx0gHdvdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ass3Ngfb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D72F240E01A3;
	Wed,  8 May 2024 08:19:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4_--T3KUNXPX; Wed,  8 May 2024 08:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715156343; bh=uH6oKAFJRkptxNNJooUkGi/SrcgHZr/bYVl1yfK+V0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ass3Ngfb4hVLQiZjmQ6zLIwpwaUoGkKZCP1UBaiRXbXduveybWRNe08vaLbc0RWnc
	 oNY9dh/xDLkt33cMCtGBo5r8eKQ9JyXGGTtYiYdElFIt1Be6ONZul9YCg9UhT2BUBG
	 PdMx/jdB1qHXiDbUDeuKHaR+VLyEDxpi0ObPw3G1U+4Bu6u5rbyplqcnNunDWQF4xK
	 clhJ87KK2QDeqVkm/F1JMHE2Wahi8F+RshHL+LOIzzAu+KYE1o47zMUOGVCNNV4bo8
	 ADK2cdvj5uO1aKxhDQF3PnBgto1KoSlpMpSqOPZSuY24XMkS3wvYz0a3AluKDz6+Xn
	 Hkmz/SoPXbts1wBzjuRp424bSDui5m3f6ethcbNOAHcg4H3iaPA6b9I25evgQ5TDfs
	 fF65PGZTj7rb/raxil6nDRhVtfKmZo8QLGHHgAOL6WR4eHhwHd88BMYSFaB49zn3pM
	 NfGZ/aA3uru6o7fjdVS4z07hfNvYJitZAyfrjoZBBtQ4lxODFG53abSugrfa+k2zSi
	 Hs0+Sd+zW8EhYdb5wE4uUD/mgiMLVJ+7Ix5SaKktbSnICVtUvpfgfWKq579fIA9fTJ
	 sLkABwrmfHkV0lBt46BIDe5mfdHWCoV+xXBAkKcYykV8+IfZFmojZf6F4s9IAL95/j
	 gjPHXNOyCmM9IEd1nZgIlOWQ=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8785840E0249;
	Wed,  8 May 2024 08:18:51 +0000 (UTC)
Date: Wed, 8 May 2024 10:18:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/7] AMD Pstate Driver Core Performance Boost
Message-ID: <20240508081845.GAZjs1ZS7atvvdsOOd@fat_crate.local>
References: <cover.1715152592.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1715152592.git.perry.yuan@amd.com>

On Wed, May 08, 2024 at 03:21:05PM +0800, Perry Yuan wrote:
> The patchset series add core performance boost feature for AMD pstate
> driver including passisve ,guide and active mode support.

Can you please slow down, wait to collect as much feedback as possible
and only *then* spam again with your patchset?

https://kernel.org/doc/html/latest/process/submitting-patches.html#don-t-get-discouraged-or-impatient

"You should receive comments within a few weeks (typically 2-3); if that
does not happen, make sure that you have sent your patches to the right
place. Wait for a minimum of one week before resubmitting or pinging
reviewers - possibly longer during busy times like merge windows."

Maintainers are not a shooting gallery.

While waiting, you can read this:

https://kernel.org/doc/html/latest/process/development-process.html

Thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

