Return-Path: <linux-pm+bounces-9692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED136910AB5
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 17:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974971F2156D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D861B1420;
	Thu, 20 Jun 2024 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ay2YRKaZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A381CAAD;
	Thu, 20 Jun 2024 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898703; cv=none; b=LiT/c+QMfqsBx+tjd0DGB/u27HnEQcWaJuBl08Fauxk4npHIno3siMu1gW5psvJqLg1g/yC5uJiiTOV97EuGYViJ4u0zkhjdT+SAbw5UyHK52f3YdnqQsbIqYwhS18sEBGcBTxRlfZ3tdZ6sXAvKhQSiD/YCeZ8QjlmNjk38iuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898703; c=relaxed/simple;
	bh=Fn2qvUWCwhh2z96NGCLJJJ9xkITNDvWOalFocQorZUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfhviZvwNYhq9Bju/hY8Xkw9obseeCgWJM4NJyj+GEk88GOISCQNZDvuqOT1rmOjiLtBTv7//SQKkNvGuy9iKD6I+AFXhIx+1M4O4nxmWtySvsR2+PAzzX6myYQVQ0r02O8btyLr+BLuC95Glg7x30+FsMLrVNBPGAFQv5nWGJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ay2YRKaZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 49A2940E021A;
	Thu, 20 Jun 2024 15:51:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iZOw6opdpaf2; Thu, 20 Jun 2024 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718898694; bh=sDw8qtd49A92yEpqRTXNQFspgSL2Qr1g4HIFxOxJypI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ay2YRKaZ9RvqbsCw8sqvf8PYz/btqS4m1DhDGQPjsGUoB9W3OooL6oHUMnxnpMKwX
	 sW//kpnxTG0D/3DJ2DHoijvxS7hGqhvQ3jtpuUP0Fnw7lK37xFAeqbfzds8mDq9Zih
	 8/x9i+BTS4jwv+NCOaZQ+X2SD/iZGgXi0VQDoxsOYkdwPsFGcc035OBhZEoj9SB8Yz
	 iqUquGcFS4C0U+asdlQVGVurIxGjXbrpDax7caEJWi92IscueCKIs7kBR6vLGhemo8
	 cGD/XdRFBcWVn/DGPDTCDfkLIO8HzugjvZl23fuGN6wnKVL9rJ3qRFPMRZn76vW+Jk
	 JYZVuiiK4Pd0Z/MPN1fFTPNeFjBhtNC42nausYw/TNkjoHOZbUFKd9GivPYlJJTkHz
	 KJygG97EgOU4BLuGQ9a6ouiE3qlIsVpgdz5cDK/rVWhlEu/Op5aCf4odmhoWxqSAxC
	 v1S5NJ+G9nznySa2Pm52B/v3pZUgnwnWzFuL1AAWdgv6G1H2Qc66Kw3FUyjRkSDuht
	 FsJH/YzAx/U5YjPsphY+WFvnkm9KjbKXkAHo8VlzCHKVTHDLb7uHAYIuTuk6UVsKpq
	 GzGq51zUhzhM2n4rXuPES5EzVQWhoSjvW2lWK8OnHZE5aiaV0j+6EvyAhlwXXyfC7w
	 MJMEE9+4JkQFq6VlqMsIPn0g=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0034A40E01D6;
	Thu, 20 Jun 2024 15:51:17 +0000 (UTC)
Date: Thu, 20 Jun 2024 17:51:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH PATCH 1/9] x86/cpu/topology: Add x86_cpu_type to struct
 cpuinfo_topology
Message-ID: <20240620155111.GIZnRP7-XYvJZPY0_6@fat_crate.local>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-1-b88998c01e76@linux.intel.com>
 <20240618212801.GJZnH74Q4yknT-4X12@fat_crate.local>
 <20240619033126.irudoer3pw4fb5be@desk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240619033126.irudoer3pw4fb5be@desk>

On Tue, Jun 18, 2024 at 08:31:26PM -0700, Pawan Gupta wrote:
> To accommodate for that we can name the vendor specific types in this
> series as vendor_cpu_type. And if we ever need to add generic types, we can
> call them cpu_type?

Yes, then that member you're adding should not just be called "cpu_type" but
either "vendor_cpu_type" or "hw_cpu_type" or whatnot and every vendor can then
put its own values there.

And for the future we could do functions which convert from a vendor CPU type
to a generic one. If we ever decide that we need the generic ones.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

