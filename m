Return-Path: <linux-pm+bounces-7944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95868C8AF4
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 19:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64889281AC5
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CB913E028;
	Fri, 17 May 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DI2/sOIS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BF313DB9B;
	Fri, 17 May 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966788; cv=none; b=QCDVWAOGYOrGcl+SZ6nb9DO61bVI0fpD9M5PjN0FZzyq4ut5G7qZ5u7SKPE4udVjCqV+h0gDO202fggt2vJulQGanR6DjEvpKocGixZxyJYxiba78RUe6R3v9f0ilkRDzPFePwADRZImiwikgE2b8ctK8llVYH7zEVAiEi8yjYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966788; c=relaxed/simple;
	bh=L01yknndEnuYphVPNzv32AM8AKWTkpUwEh/WTz0L6Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQjAbkGL4PnCf155+PjvlAAembYClG9TDgR3AIWEFANr1iUJK/ixAAAsZGL6+5MEGGZoNpz6TB9lIOZ0CX3UQ/FbCJnxPYr1sVR7IC0vGWSv8NYFZzN3RrMg84adwFNKB/Osv5sH1UmfStTmaBq6MhRvaBLQBJuthHKSkRDRkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DI2/sOIS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6FF8840E01E8;
	Fri, 17 May 2024 17:26:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QUTAxFpwmxTl; Fri, 17 May 2024 17:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715966780; bh=JxAsV7mx2TJYX+9cLdcRXg8LbfpFXpxmKwDrIX6yx2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DI2/sOISPGLdODF0BiGocWEe/0U2MNVG8oNI+5pw4AX0o3DocNcEi2jD28MsRvtly
	 LLfpEjN2T0Eh6AZE5KUZfA5/t0wiQ/p0pJXeXz5jCCiJOrwMiqrVpFmDpaFBkPfu8n
	 zNKfbCYRm3x1HiNnw7Vx0kgVZgqiVLEaY2pipCEj+Dj0th9shVMPJhIFcHEHfDXPEK
	 WdnGLssQYNWw4prkWdEgsVXM407HYRxxxdQv6oJhFl88uqyfsoPsI6my01zVwmFVGK
	 i4Vvt2Kje2+NfihI7muhCq3ukKA+l+/JQ2RUU9Db/cH1pXBmcs5H+oltqJn+sEwKMs
	 Tq4raj3xeDDQ9GGwisXKDd0XLB5yhUa30bxtEqJQYZrw1gylg2T7yziWnfnq/FpSYT
	 y6DjTjIx//ixAdBFj+JYXBEQe/roXr7LToeSf3DXSZRGtlENmqLFTUfJwP2GobgZDV
	 MXdaW/MZ5i35OCiKryPq6MvUKyaHeIAlO0wDuRA+bI60UsGRA0gaDmOBT1SJY1kO9T
	 qoIOmIQnRDPs8BURUKBrkkMFhHVHfnP1eeXiPcyggk00pq42mr31bwex7k9hQa8/a+
	 ijjVw3w6MRUmSqEiEJosV+NfW1CNX1+SSjm6HK7nEklPBRWX6n+jzYw1hf2aUyGIOt
	 ggrnG3vW0HjE0rbC/dR/iImg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DEB4440E0244;
	Fri, 17 May 2024 17:26:08 +0000 (UTC)
Date: Fri, 17 May 2024 19:26:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
Message-ID: <20240517172603.GEZkeTK246tBvGEtgF@fat_crate.local>
References: <87o79cjjik.fsf@kernel.org>
 <20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local>
 <20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local>
 <87h6f4jdrq.fsf@kernel.org>
 <878r0djxgc.fsf@kernel.org>
 <874jb0jzx5.fsf@kernel.org>
 <20240514160555.GCZkOL41oB3hBt45eO@fat_crate.local>
 <87msoofjg1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msoofjg1.fsf@kernel.org>

On Fri, May 17, 2024 at 08:15:58PM +0300, Kalle Valo wrote:
> So the weird part is that when the bug happens (ie. suspend stalls) I
> can access the box normally using ssh and I don't see anything special
> in dmesg. Below is a full copy of dmesg output after the suspend
> stalled. Do note that I copied this dmesg before I updated microcode so
> it will still show the old microcode version.

Does that mean that you'd still see the stall even with the latest
microcode revision 0xf8?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

