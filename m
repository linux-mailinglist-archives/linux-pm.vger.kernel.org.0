Return-Path: <linux-pm+bounces-16493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 895039B1682
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA0F1F20FD5
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8AD1CC14B;
	Sat, 26 Oct 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IYmreAr7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665E029D05
	for <linux-pm@vger.kernel.org>; Sat, 26 Oct 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729934713; cv=none; b=eGYhupdfapfx+wl8gcukQrnZTgP76MwJZAP1W1o0M3NFtvenLvVlNZFrKk+Ch5l5rt4WTHrC9ugqm3ZzknZKRcsAv2/tqbjCaV6mGLURedrdX6CixPwA1BjMnM18xwvD4t6+Ckgu5FpTxGI4Vzi+d85jVpz0hgyBaFL07CvmQ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729934713; c=relaxed/simple;
	bh=LYQSUS8mhGNDvEawXGrFJWhJIqL8Iyw21eTV3HEBIYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKtgv6nYU5/XoGXLTr/jgmiirAfq0TYDkEI0W40unH5pGSVuLCoVaG4B3B2U1t53jTCO8BuOacnvF3FxPuHuCLv2snEg0a6tq5z6ijtuo7T3EM3qRPhCZ7ZAraVuOVve9gcO+1EdXZ3x6b+YyWvDKGd8AvDmDHdQPP8pvOQ/l5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IYmreAr7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A6CF240E0194;
	Sat, 26 Oct 2024 09:25:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gTSppulLJDOK; Sat, 26 Oct 2024 09:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729934702; bh=uoMjj/Wb/u5//jgBoXUxZqfKCWH3VJGy3yLHWXY6a8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYmreAr7/MUV6hxkUeNXhnG4kqEdI+1mwdCekXcEYq/gCalNj5ehw0aC7xEjmH5Dh
	 S2UvyMph476tn9F9yYnqbkIIvxvGulpVi55zrTV4dE2HRZD08eutj8IxpUhH9UwT8A
	 CC9k9zAKxJXXZgPZsoGnYWa3Mnon4va2ALthzPE1qZeW9t/127PPx/9OtJnaRspRYR
	 T2IlnO7P+XQeeRIhaQd5dHClbNR01LRj0FPajLaMB1QLvthRNlWfxdLocoM27Q5BpG
	 pe6EgdRLZcBbm/02C/q6zIpKPFYJkRAc9OCM77mp1jExSx+3sd+gO1gG8J/rDLxV6L
	 ZAC5j08bXXrUNQbWo01KZvIhypfH1Fe+6KBxwAjnxoAtleIBFUPIkG4e1ZIvkUBcqx
	 PqSAn5rkQy8f05t8cwMre4nBFCb/zJejTew9CCcldO+LJSYyX9cekZBddP4lW5Jy20
	 TOzsPXXZP6XMD54ecjrRRG8z7le14PxP+/oYmTgA9PtYL/JBimSVl3WDDkQHTJ4HsU
	 6e+s9W3+1iuQK/ppvaiIGu2ufXpp7qbVJTOGTcEFFD5zUKFSMIpAqI8KI6jRpDNJVF
	 1OKgGIzIZj2JQVT0TlC2QBZPzF1xFX0KZa8HvZLrwmz8sVmMEXxcgrlodkvG4PrJ0P
	 d/LOWSzrsEyGh5m1v5DEg05E=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 50E6840E0169;
	Sat, 26 Oct 2024 09:24:59 +0000 (UTC)
Date: Sat, 26 Oct 2024 11:24:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Preparing next amd-pstate PR
Message-ID: <20241026092451.GAZxy1YyuewwlQLem7@fat_crate.local>
References: <bfd6e381-b3e1-457e-b992-d6d9be5e446d@amd.com>
 <CAJZ5v0gwO6hLGu1iNu+GKz6_LAMaZdY_8htDhVoFVixUhSO1zg@mail.gmail.com>
 <CAJZ5v0j7HpUN-heihZL3HZDMLV0y7XCw2nvkHgFCGZPhhFroAQ@mail.gmail.com>
 <a2e7c093-66e2-4efb-928b-86fd55c21f65@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2e7c093-66e2-4efb-928b-86fd55c21f65@amd.com>

Ok Rafael,

tip branch is here:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/cpu

You can merge it and base the rest of the stuff ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

