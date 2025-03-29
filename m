Return-Path: <linux-pm+bounces-24607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60228A757D8
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 21:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18BF16721A
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 20:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90FC1A9B34;
	Sat, 29 Mar 2025 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="jPM8odLE"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ABB1DF73C
	for <linux-pm@vger.kernel.org>; Sat, 29 Mar 2025 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743280443; cv=none; b=UZGiHbU+cLMxyMdsmt0bC39sUlbj+/i65z/pQEgUGv8sUtpshA2p9ksZJsBtT9OSPL2yUM/oBNyFbc78ZbK4x/lO3duxuVioXABjyobrxnvT54vm25ZDe5q4ZarxdKGBkzP1+i8Xp3SapSriWORFqGc3F4Fj3JAMMcNYLKnCEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743280443; c=relaxed/simple;
	bh=dw23VKl6KA6wjms9Dgn41Joz33bEr1iBNkuwfirG12w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVKTbt71gQjP7+Ll3w/8rCS2pnFrJD6xsh2Db5L1tWneMoqewo+bwqn8teNzQD2dIdyUojGJryY87+TLP6dnyn74Xkoy+b8eZ0YtWLlS4uzsdP7kfn/CNFUEMne83mqs0UD9sTJOvCeRnUcwitWbEoeaozyAvnsggt1ZY+ZmV/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=jPM8odLE; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Sat, 29 Mar 2025 21:33:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1743280439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=waBDOum2KFYHQU4HEAqFQURKA6hlBTFPqh8uVcV7csc=;
	b=jPM8odLElJ1MnfPr9cFkWVAx0FEgTCgSyrAvn3Ufb9O+14uUsLjJwveePDyJbOBQ0fnsZs
	DhDhP3+8bwCbHBMrsQ/aa84yAuXEX3mpfiYs52pDZvC+cl7U4r5ADpSNOqKiDnEgssbvHD
	cBmeXGBKrHM1wQJKMciiVIhD/7J8LfVq6opMoig5cRBFYHfuCvO20YxkiM4M3AokHezRAc
	swI6fDuIDJacNwimx9+4+fZo1OUtIIrOcbN3tPm9lIUZD30DAhnK/+p34LR3Wr/qqpmsVB
	L2xJBgFJapyE4PQsyVF4Fiv5Ha/D4LnY1ZlkYq9AF34vMqR4HVBfNsPFirbJLg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, ebiederm@xmission.com,
	rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	akpm@linux-foundation.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z-hZNKszFmFJc0A5@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z5bx7ZHNcyc5fM_L@darkstar.users.ipa.redhat.com>
 <CALu+AoSSKh=5ELgQyzDrGEDm5fm2XKteH1ZC70mm89pNSSPMHw@mail.gmail.com>
 <Z-c7V2hptt9U9UCl@desktop0a>
 <Z+dQZozsbdls6yqJ@MiWiFi-R3L-srv>
 <Z-hYWc9LtBU1Yhtg@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-hYWc9LtBU1Yhtg@desktop0a>
X-Migadu-Flow: FLOW_OUT

Try gzip decompression.
Try LZMA decompression.
kernel: 0x7f5df32b5010 kernel_size: 0x8a9540
MEMORY RANGES
0000000000000400-000000000009fbff (0)
000000000009fc00-000000000009ffff (1)
00000000000f0000-00000000000fffff (1)
0000000000100000-00000000bffdffff (0)
00000000bffe0000-00000000bfffffff (1)
00000000feffc000-00000000feffffff (1)
00000000fffc0000-00000000ffffffff (1)
0000000100000000-000000013fffffff (0)
sym: sha256_starts info: 12 other: 00 shndx: 2 value: 1110 size: 48
sym: sha256_starts value: 13fff8140 addr: 13fff7032
R_X86_64_64
sym: sha256_update info: 12 other: 00 shndx: 2 value: 3c70 size: 19
sym: sha256_update value: 13fffaca0 addr: 13fff7043
R_X86_64_64
sym: sha256_regions info: 11 other: 00 shndx: 9 value: 40 size: 100
sym: sha256_regions value: 13fffc040 addr: 13fff704e
R_X86_64_64
sym: sha256_regions info: 11 other: 00 shndx: 9 value: 40 size: 100
sym: sha256_regions value: 13fffc140 addr: 13fff7078
R_X86_64_64
sym: sha256_digest info: 11 other: 00 shndx: 9 value: 20 size: 20
sym: sha256_digest value: 13fffc020 addr: 13fff7087
R_X86_64_64
sym: sha256_finish info: 12 other: 00 shndx: 2 value: 3c90 size: 15c
sym: sha256_finish value: 13fffacc0 addr: 13fff7099
R_X86_64_64
sym:     memcmp info: 12 other: 00 shndx: 2 value: 596 size: 21
sym: memcmp value: 13fff75c6 addr: 13fff70b0
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: 13fffaf30 addr: 13fff70c4
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 2 value: 4b7 size: a0
sym: printf value: 13fff74e7 addr: 13fff70d2
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: 13fffaf60 addr: 13fff70dc
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: 13fffaf50 addr: 13fff70ea
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: 13fffaf66 addr: 13fff710a
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: 13fffaf68 addr: 13fff711f
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: 13fffaf78 addr: 13fff715c
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 2 value: 4b7 size: a0
sym: printf value: 13fff74e7 addr: 13fff7168
R_X86_64_64
sym: setup_arch info: 12 other: 00 shndx: 2 value: 762 size: 56
sym: setup_arch value: 13fff7792 addr: 13fff7175
R_X86_64_64
sym: skip_checks info: 11 other: 00 shndx: 9 value: 0 size: 4
sym: skip_checks value: 13fffc000 addr: 13fff7181
R_X86_64_64
sym: verify_sha256_digest info: 12 other: 00 shndx: 2 value: 0 size: 12a
sym: verify_sha256_digest value: 13fff7030 addr: 13fff7190
R_X86_64_64
sym: post_verification_setup_arch info: 12 other: 00 shndx: 2 value: 7f0 size: 58
sym: post_verification_setup_arch value: 13fff7820 addr: 13fff71a2
R_X86_64_64
sym:    putchar info: 12 other: 00 shndx: 2 value: d8e size: 119
sym: putchar value: 13fff7dbe addr: 13fff71b5
R_X86_64_64
sym:    putchar info: 12 other: 00 shndx: 2 value: d8e size: 119
sym: putchar value: 13fff7dbe addr: 13fff71f5
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: 13fffaf8a addr: 13fff7300
R_X86_64_64
sym:   vsprintf info: 12 other: 00 shndx: 2 value: 17d size: 2a4
sym: vsprintf value: 13fff71ad addr: 13fff74cd
R_X86_64_64
sym:   vsprintf info: 12 other: 00 shndx: 2 value: 17d size: 2a4
sym: vsprintf value: 13fff71ad addr: 13fff756d
R_X86_64_64
sym:    entry32 info: 10 other: 00 shndx: 2 value: 5c0 size: 0
sym: entry32 value: 13fff75ec addr: 13fff75fd
R_X86_64_PC32
sym:    entry32 info: 10 other: 00 shndx: 2 value: 5c0 size: 0
sym: entry32 value: 13fff75ec addr: 13fff7612
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffc15c addr: 13fff762d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffc13c addr: 13fff7634
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffae44 addr: 13fff763a
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffc1ac addr: 13fff7640
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffae1c addr: 13fff7646
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaeb1 addr: 13fff7679
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaec0 addr: 13fff7680
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaecb addr: 13fff7687
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaed6 addr: 13fff768e
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaee1 addr: 13fff7695
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaeec addr: 13fff769c
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaef7 addr: 13fff76a3
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaee6 addr: 13fff76aa
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffc271 addr: 13fff76b1
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaedc addr: 13fff76c3
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaf0c addr: 13fff76d9
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffae4c addr: 13fff76ec
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffae54 addr: 13fff76f3
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffae5c addr: 13fff76fa
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffae64 addr: 13fff7701
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffae6c addr: 13fff7708
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffae74 addr: 13fff770f
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffae7c addr: 13fff7716
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffae84 addr: 13fff771d
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffae8c addr: 13fff7724
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffae94 addr: 13fff772b
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffae9c addr: 13fff7732
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaea4 addr: 13fff7739
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaeac addr: 13fff7740
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaeb4 addr: 13fff7747
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaebc addr: 13fff774e
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaec4 addr: 13fff7755
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaecc addr: 13fff775b
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaf0c addr: 13fff7763
R_X86_64_PC32
sym: jump_back_entry info: 11 other: 00 shndx: 9 value: 2008 size: 8
sym: jump_back_entry value: 13fffe004 addr: 13fff777d
R_X86_64_PC32
sym:       .bss info: 03 other: 00 shndx: b value: 0 size: 0
sym: .bss value: 13ffffffc addr: 13fff7784
R_X86_64_PC32
sym:  purgatory info: 12 other: 00 shndx: 2 value: 12a size: 53
sym: purgatory value: 13fff7156 addr: 13fff7789
R_X86_64_PLT32
sym:    entry64 info: 10 other: 00 shndx: 2 value: 690 size: 0
sym: entry64 value: 13fff76bc addr: 13fff778e
R_X86_64_PLT32
sym:  reset_vga info: 11 other: 00 shndx: 9 value: 2012 size: 1
sym: reset_vga value: 13fffe012 addr: 13fff7794
R_X86_64_64
sym: x86_reset_vga info: 12 other: 00 shndx: 2 value: ea7 size: 232
sym: x86_reset_vga value: 13fff7ed7 addr: 13fff77a3
R_X86_64_64
sym: legacy_pic info: 11 other: 00 shndx: 9 value: 2011 size: 1
sym: legacy_pic value: 13fffe011 addr: 13fff77b0
R_X86_64_64
sym: x86_setup_legacy_pic info: 12 other: 00 shndx: 2 value: 10d9 size: 35
sym: x86_setup_legacy_pic value: 13fff8109 addr: 13fff77bf
R_X86_64_64
sym: legacy_pic info: 11 other: 00 shndx: 9 value: 2011 size: 1
sym: legacy_pic value: 13fffe011 addr: 13fff77ce
R_X86_64_64
sym: x86_setup_legacy_pic info: 12 other: 00 shndx: 2 value: 10d9 size: 35
sym: x86_setup_legacy_pic value: 13fff8109 addr: 13fff77dd
R_X86_64_64
sym: cmdline_end info: 11 other: 00 shndx: 9 value: 2000 size: 8
sym: cmdline_end value: 13fffe000 addr: 13fff77ea
R_X86_64_64
sym: jump_back_entry info: 11 other: 00 shndx: 9 value: 2008 size: 8
sym: jump_back_entry value: 13fffe008 addr: 13fff77fc
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 6 value: 0 size: 0
sym: .rodata.str1.1 value: 13fffaf9b addr: 13fff780b
R_X86_64_64
sym:    sprintf info: 12 other: 00 shndx: 2 value: 421 size: 96
sym: sprintf value: 13fff7451 addr: 13fff7815
R_X86_64_64
sym: panic_kernel info: 11 other: 00 shndx: 9 value: 2010 size: 1
sym: panic_kernel value: 13fffe010 addr: 13fff7822
R_X86_64_64
sym: crashdump_backup_memory info: 12 other: 00 shndx: 2 value: cb3 size: 3e
sym: crashdump_backup_memory value: 13fff7ce3 addr: 13fff7831
R_X86_64_64
sym: jump_back_entry info: 11 other: 00 shndx: 9 value: 2008 size: 8
sym: jump_back_entry value: 13fffe008 addr: 13fff783e
R_X86_64_64
sym: x86_setup_jump_back_entry info: 12 other: 00 shndx: 2 value: 7b8 size: 38
sym: x86_setup_jump_back_entry value: 13fff77e8 addr: 13fff784e
R_X86_64_64
sym: jump_back_entry info: 11 other: 00 shndx: 9 value: 2008 size: 8
sym: jump_back_entry value: 13fffe008 addr: 13fff785d
R_X86_64_64
sym: x86_setup_jump_back_entry info: 12 other: 00 shndx: 2 value: 7b8 size: 38
sym: x86_setup_jump_back_entry value: 13fff77e8 addr: 13fff786d
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe047 addr: 13fff7897
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe04f addr: 13fff789d
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe075 addr: 13fff78bd
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe07f addr: 13fff78c3
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe089 addr: 13fff78c9
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe093 addr: 13fff78cf
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe076 addr: 13fff78d6
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe08d addr: 13fff78dd
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe06d addr: 13fff79a7
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe075 addr: 13fff79ad
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe09b addr: 13fff79cd
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe0a5 addr: 13fff79d3
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe0af addr: 13fff79d9
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe0b9 addr: 13fff79df
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe0e2 addr: 13fff7a22
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe12b addr: 13fff7a65
R_X86_64_PC32
sym: backup_src_size info: 11 other: 00 shndx: 9 value: 2070 size: 8
sym: backup_src_size value: 13fffe070 addr: 13fff7ce5
R_X86_64_64
sym: backup_start info: 11 other: 00 shndx: 9 value: 2080 size: 8
sym: backup_start value: 13fffe080 addr: 13fff7cf7
R_X86_64_64
sym: backup_src_start info: 11 other: 00 shndx: 9 value: 2078 size: 8
sym: backup_src_start value: 13fffe078 addr: 13fff7d09
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 2 value: 57e size: 18
sym: memcpy value: 13fff75ae addr: 13fff7d16
R_X86_64_64
sym: serial_base info: 11 other: 00 shndx: 9 value: 2090 size: 2
sym: serial_base value: 13fffe090 addr: 13fff7d23
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe088 addr: 13fff7d33
R_X86_64_64
sym: serial_baud info: 11 other: 00 shndx: 9 value: 208c size: 4
sym: serial_baud value: 13fffe08c addr: 13fff7d6a
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe088 addr: 13fff7d98
R_X86_64_64
sym: console_vga info: 11 other: 00 shndx: 9 value: 2093 size: 1
sym: console_vga value: 13fffe093 addr: 13fff7dc0
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe098 addr: 13fff7dd6
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe098 addr: 13fff7e38
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe094 addr: 13fff7e4e
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe094 addr: 13fff7e66
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe094 addr: 13fff7e96
R_X86_64_64
sym: console_serial info: 11 other: 00 shndx: 9 value: 2092 size: 1
sym: console_serial value: 13fffe092 addr: 13fff7ea8
R_X86_64_64
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff7d21 addr: 13fff7ebc
R_X86_64_64
sym: sha256_process info: 12 other: 00 shndx: 2 value: 1160 size: 29f2
sym: sha256_process value: 13fff8190 addr: 13fffabe1
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 2 value: 57e size: 18
sym: memcpy value: 13fff75ae addr: 13fffac4c
R_X86_64_64
sym: sha256_process info: 12 other: 00 shndx: 2 value: 1160 size: 29f2
sym: sha256_process value: 13fff8190 addr: 13fffac5e
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 2 value: 57e size: 18
sym: memcpy value: 13fff75ae addr: 13fffac8c
R_X86_64_64
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fffab90 addr: 13fffaca7
R_X86_64_64
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fffab90 addr: 13fffad08
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffe0a0 addr: 13fffad17
R_X86_64_64
sym:    entry16 info: 10 other: 00 shndx: 2 value: 850 size: 0
sym: entry16 value: 13fff7880 addr: 13fffae48
R_X86_64_64
sym:    entry32 info: 10 other: 00 shndx: 2 value: 5c0 size: 0
sym: entry32 value: 13fff75f0 addr: 13fffaed0
R_X86_64_64
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaee0 addr: 13fffaee2
R_X86_64_64
sym:    .rodata info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .rodata value: 13fffaf10 addr: 13fffaf12
R_X86_64_64
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff7030 addr: 13fffafd8
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff715a addr: 13fffb01c
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff71ad addr: 13fffb050
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff7451 addr: 13fffb09c
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff74e7 addr: 13fffb0b8
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff7587 addr: 13fffb0f0
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff759a addr: 13fffb104
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff75ae addr: 13fffb118
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff75c6 addr: 13fffb12c
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff7792 addr: 13fffb158
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff77e8 addr: 13fffb178
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff7820 addr: 13fffb18c
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff7ce3 addr: 13fffb1c8
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff7d21 addr: 13fffb1f8
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff7dbe addr: 13fffb20c
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff7ed7 addr: 13fffb240
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff8109 addr: 13fffb270
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff8140 addr: 13fffb2a0
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fff8190 addr: 13fffb2b4
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fffab90 addr: 13fffb2f8
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fffaca0 addr: 13fffb35c
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 2 value: 0 size: 0
sym: .text value: 13fffacc0 addr: 13fffb370
R_X86_64_PC32
sym:      .data info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .data value: 13fffc140 addr: 13fffc142
R_X86_64_64
Loaded purgatory at addr 0x13fff7000
Loaded real_mode_data and command line at 0x13fff2000
kernel init_size 0x1feb000
Loaded 64bit kernel at 0x13e000000
Loaded initrd at 0x13d855000 size 0x7aae28
E820 memmap:
0000000000000400-000000000009fbff (1)
000000000009fc00-000000000009ffff (2)
00000000000f0000-00000000000fffff (2)
0000000000100000-00000000bffdffff (1)
00000000bffe0000-00000000bfffffff (2)
00000000feffc000-00000000feffffff (2)
00000000fffc0000-00000000ffffffff (2)
0000000100000000-000000013fffffff (1)
/sys/firmware/edd does not exist.
kexec_load: entry = 0x13fff7760 flags = 0x3e0000
nr_segments = 5
segment[0].buf   = 0x5610eaa51ab0
segment[0].bufsz = 0x30
segment[0].mem   = 0x100000
segment[0].memsz = 0x1000
segment[1].buf   = 0x7f5df2b0a010
segment[1].bufsz = 0x7aae28
segment[1].mem   = 0x13d855000
segment[1].memsz = 0x7ab000
segment[2].buf   = 0x7f5df32b9210
segment[2].bufsz = 0x8a5340
segment[2].mem   = 0x13e000000
segment[2].memsz = 0x1feb000
segment[3].buf   = 0x5610eaa4c730
segment[3].bufsz = 0x4291
segment[3].mem   = 0x13fff2000
segment[3].memsz = 0x5000
segment[4].buf   = 0x5610eaa45640
segment[4].bufsz = 0x70e0
segment[4].mem   = 0x13fff7000
segment[4].memsz = 0x9000

