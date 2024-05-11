Return-Path: <linux-pm+bounces-7741-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 982058C3340
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 20:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CF01C20C1E
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 18:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09491CA85;
	Sat, 11 May 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IOV+6qo+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73141BC3F;
	Sat, 11 May 2024 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715453353; cv=none; b=IGCwuC909DMAHTLELEozrf/nfktOytfgNuy6SR2GcLk0L5lXXWaXhnbZHOi7fJuxBGN8ZA2bRmvDp+rkQcVCTQyOiKg2vraYhrqOqDJaeG8weFMVx3KDRS/mmceDNZh54ZKgWbGTOkNWyA4Hif0r3YgFH7A1Pd9sW55H+MfL/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715453353; c=relaxed/simple;
	bh=/XbzvrAitbJty/7I8EAzYayswe+CoApMGuFwqAJZVuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkbdy99s7YTgdfYGhEKc2WNY51ejC98mBZtB1++FJmj8XAM0j87f8iVW5PN5zQaQqtmGkJLCdqRxiK0qya9pdOx+UCjU2LXkA8s/98kG+H2/HutXBP8Mw3dBb8nAzYbIBQqoRKit2VffOwYjTjJ4rHxiUxQyv0I4ksFRMvrwc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IOV+6qo+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9DD6840E022F;
	Sat, 11 May 2024 18:49:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PnX4ziIooVsj; Sat, 11 May 2024 18:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715453344; bh=76jizOL7yKwxmpY8JJfciMhUUS0r6779or0+hE35XA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOV+6qo+PbCzxm0WTNYJ3xdPs6y2IRrboOirH7XWbELoRUdU6x/G782hvPk8SgvXF
	 gsLQjC3hOz5Uqd/unoYSALvUqDn1hPzm1NKqZXSfpj4ZT446RgeQGQdrh8QwyKS6jV
	 Qg1w6SMxLMuzfj2HwNyGxsr9HMl/woi1wRhG1FicMJPsMF3+BRqC9M5l2t/Xt9UGup
	 t6MEy/yhD5GRD2VdJu6aH4vwXkcVLjyTzV5x3zDDeM7uH8QU55s5aGJAaLOi7fxPnH
	 mgtApW92UR06oKI4mzH7Yy93QZtlkTQj2r2Lg2YqMjUBAF0gbnI/tHe8kTubWRPPzk
	 hc3aTI1eXRMGRc3eEKov3MCAVFKkW36xYCqaQE5rHLrgJnCLgLGMDot3KvrGUGs84g
	 FvcKOATkdZFdg7xlzYLKVD2HXTRb5bhtuMI1FKjYVJw5x1pUdg7ln0G3u7dH05lnE3
	 RNbCBtz/gwAdrr1Gte59n6FG8iVY+3XA3K/wDcFiLLqhFFdLAPZc9jcqg/clFpvOVj
	 NtQLxai80sAcEb9BebAjkz5y+N+mcO+NRNPnLiYgWOaC+99ff+S2y6XRrzr9OJQtKd
	 ANUEa8TSdaKEUMKLSvSkodJl2/kLQH7i0IJf1+5mM5oUh7cEbPrrhFsItGNK7mV/GZ
	 8UNaJRZOQDG1ImQtX3HX9Uac=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1692A40E016A;
	Sat, 11 May 2024 18:48:54 +0000 (UTC)
Date: Sat, 11 May 2024 20:48:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
Message-ID: <20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
References: <87o79cjjik.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o79cjjik.fsf@kernel.org>

On Sat, May 11, 2024 at 09:22:43PM +0300, Kalle Valo wrote:
> Here's the diff between broken and working .config:
> 
> $ diffconfig broken.config works.config 
> -CALL_PADDING y
> -CALL_THUNKS y
> -CALL_THUNKS_DEBUG n
> -HAVE_CALL_THUNKS y
> -MITIGATION_CALL_DEPTH_TRACKING y
> -MITIGATION_GDS_FORCE y
> -MITIGATION_IBPB_ENTRY y
> -MITIGATION_IBRS_ENTRY y
> -MITIGATION_PAGE_TABLE_ISOLATION y
> -MITIGATION_RETHUNK y
> -MITIGATION_RETPOLINE y
> -MITIGATION_RFDS y
> -MITIGATION_SLS y
> -MITIGATION_SPECTRE_BHI y
> -MITIGATION_SRSO y
> -MITIGATION_UNRET_ENTRY y
> -PREFIX_SYMBOLS y
>  CPU_MITIGATIONS y -> n

You could start turning them off one-by-one, and each time run the
reproducer and see where there's a difference.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

