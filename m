Return-Path: <linux-pm+bounces-7742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552408C3345
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 20:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107E92816EC
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 18:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7181C6A0;
	Sat, 11 May 2024 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EB7y1MY1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B01CA85;
	Sat, 11 May 2024 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715453404; cv=none; b=X8LUCMFBZuUy6rpBO+WHRDUniKDe/etD6vc+OK07n8I/ErStjcf3W1mKa172Yrz9iM18eEZB5awryrI+rldXXSZOX7yhA///cyDvLbCd1uwQ8hvyaZXrw0mRJyonnUxHROU/OCWV+K56bo7oJDH7J03OPHYD+c9T/nI54kjqVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715453404; c=relaxed/simple;
	bh=XQlJ52Gjcwh0/eoXO2kRS0oPJSJxuVoBs9NjXyQ9Q3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWmCiKnB2WIIV6EpJcMnzXnj3z44uoM9NWhT+6CrTWJo3ErLpBOkcxK9av0QDXCZ8/UGfAnRt6p5Po/tRdIhTgFhbmz6zjK3pjbRCiaI8aVtDU/ZUor299Ue+iirR2BaIulKCN/MPwQ7mpG+iIkiprtCO+jfAZgonbw0I1Qfs3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EB7y1MY1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7DA0540E022F;
	Sat, 11 May 2024 18:50:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qw6eaHcV0NBl; Sat, 11 May 2024 18:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715453396; bh=S/8c399LYuUKjA05XuJD8JszHUQnKzGlwFbNREX7vvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EB7y1MY1FRIovRwF3y9CS33rMNBhBH9oEUuKYGrH2/k8U4EgmbiRFWWMyoN78jia4
	 5xR2nI3wA/ubstiw45s5VbdtGmsKw3Nd8sf5COvj0C0poixjoEHFeBS07CN6yNJ9ku
	 2wZdD9BkJzTR8dIyzG0UN6GvWdurozETXlVr+rbDcC0Lx6htOVajUOPa4oO/L7Mj9C
	 mJNvj+1fyH4vllUY4dEjv7P8OJqEOpA3l7iG+yt5g4hYLahQZM+Q8HOGAO2dV+VLHb
	 mdXhqQVtEbiiI/tvJKQWSpHDw91bQd4Ax6xqcyLT8tI5fEzG4AAgms5IY5OlJ2tVyH
	 acqfjve3FRWX26Q1bJNh7Sjp8OaStNUwGHyBkLWUXH+DVsg0y/rl6+8sNxfsG+LqcN
	 u44LOtdyoOS6yNBxj31jc8w3r7SDyD/O1adtJDsOq3EWRy1KOYEHq2cfEI1eBgyl0/
	 FLr8EPLwq07crfTqWYz9kyMtEXvXiik1P6rEOpDorX2CmUn1SFHZ+Ts4EApSFa/JUz
	 +08W4vXVgI1haJ9JE8sKy4zOv48GWoet1aYIvCwyyjKI4W4kPDeLqwTHAcCyrqXMPL
	 YvCD8EXcHfhkAhitZFxvUmgi7NiQ1DF8fbGfWokdzdvKfTVVCM+iTeUJ+szEv3nfF0
	 ez43qIHn8R60KR1UOZqBa4nk=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 659FB40E01A1;
	Sat, 11 May 2024 18:49:46 +0000 (UTC)
Date: Sat, 11 May 2024 20:49:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
Message-ID: <20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
References: <87o79cjjik.fsf@kernel.org>
 <20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>

On Sat, May 11, 2024 at 08:48:47PM +0200, Borislav Petkov wrote:
> On Sat, May 11, 2024 at 09:22:43PM +0300, Kalle Valo wrote:
> > Here's the diff between broken and working .config:
> > 
> > $ diffconfig broken.config works.config 
> > -CALL_PADDING y
> > -CALL_THUNKS y
> > -CALL_THUNKS_DEBUG n
> > -HAVE_CALL_THUNKS y
> > -MITIGATION_CALL_DEPTH_TRACKING y
> > -MITIGATION_GDS_FORCE y
> > -MITIGATION_IBPB_ENTRY y
> > -MITIGATION_IBRS_ENTRY y
> > -MITIGATION_PAGE_TABLE_ISOLATION y
> > -MITIGATION_RETHUNK y
> > -MITIGATION_RETPOLINE y
> > -MITIGATION_RFDS y
> > -MITIGATION_SLS y
> > -MITIGATION_SPECTRE_BHI y

... and if it started with -rc4, I'd try this one first.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

