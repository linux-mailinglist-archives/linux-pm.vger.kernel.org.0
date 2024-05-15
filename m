Return-Path: <linux-pm+bounces-7864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3287C8C61F9
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 09:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F09F1C20EF3
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5789D4654B;
	Wed, 15 May 2024 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RHqAEhS4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FA4F88C;
	Wed, 15 May 2024 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759105; cv=none; b=YAHEsvpASG27XchLQe9o13T8zPl6DHfUuRoO1w/AvjfWeW6Rxz9ep8uyh+5l8Sv3DYLQ41Vy61Lw/xTanUpt0G5vmyevXmTeoKx+uDRH9fFlYGReWlO46W0ZqT80EAGdviiLSf8Mp2dKcLjRs6UHY5DTu+2YFkVlGxLlzfKN2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759105; c=relaxed/simple;
	bh=781is5sCzVEcf+PuXtwPR7ViQ/edRF2GcLrPcLEgq9w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=L3l3z+IESW2MBs2BenrMaz9RF1+qw7Xeo0wNEDulopiO5OnYZSA2c6monLUEilYeFKkSyBS3yjhHHPhr/x11l+lI3reSKO89Vmh1OC1iE0X6Kdw2ibXuTNd44qkVd6sfOpdqflEs/4/NhbeFAvkK7QsxVlpW8FkZas7bJ0aqOG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RHqAEhS4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 316E440E0244;
	Wed, 15 May 2024 07:45:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vHFZ3dmOPuUD; Wed, 15 May 2024 07:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715759096; bh=Q+7syvfoeI5ZTmMPwK0pFi6q5i6DepQzJ/1ixFIPyu8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=RHqAEhS49auvryHUQf1mmkXRharCjwDnALA1yj7CIXKW4W3haCDsVEMrelPVvtAR9
	 mBSr5/rTOR1a9uniDNzIPC6eyXdXmK9o3pMpuly3xvOkrrI+xcS5D5gH6kQuINgW3u
	 RZhYGu846QxAwZR1ghBOL+X+vPvZ7ohTdgMZ6uoBOiZtEyXwuv3VdAwT1RbF2lr4Wv
	 56fRrFi/wYWOafRc7bjBtYhuvqEo7Cw8VKpiJ09KWVX2BUSyl2QBHng8jhzZ2m1ORO
	 /pXXFGNqWNpyyPuOrO2+XRU+kD8MzTB6wo3o5q62hsxLT3baPJzLmA03PLJIckclEB
	 56T5SDoUCxIq7BICj3iLh2cuosb4SJzB3hNWW4yADKhVWKBWsPhzLvBsT8ZRt9i9kO
	 xwCDlsleT0X/CS87ixbBsgmaWdWUBynBOzTof9mtjsv4Q2wCu1rvzxEGz5MA431uQ1
	 aNXqxy1GxIuPXFOVhnL9OOb68b/azofcwze9w9ae8e++RW6mfmli8TiJPiNnpS2Hou
	 kQpyznUzIKNbmnKDDYNoOd+xN9ecPVc/rAxm5r8vBq72KoPisv4HYlDlO6Y74SjpKO
	 CC7qb3zKuX15AhKRi+jcuA5nhJcZKpn6D+WYaypcceXDkavOL4/yXAxuC8jV6qiEvH
	 9AZB5MnUtitGndAXSwI57zFI=
Received: from [IPv6:::1] (p200300Ea973A34f4499cB1fe0C65A759.dip0.t-ipconnect.de [IPv6:2003:ea:973a:34f4:499c:b1fe:c65:a759])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB2BC40E016A;
	Wed, 15 May 2024 07:44:42 +0000 (UTC)
Date: Wed, 15 May 2024 09:44:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@intel.com>
CC: Kalle Valo <kvalo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Jeff Johnson <quic_jjohnson@quicinc.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: Re: [regression] suspend stress test stalls within 30 minutes
User-Agent: K-9 Mail for Android
In-Reply-To: <20240515072231.z3wlyoblyc34ldmr@desk>
References: <87o79cjjik.fsf@kernel.org> <20240511184847.GCZj-9j2sh1Akpt9iS@fat_crate.local> <20240511184945.GDZj-9yaOEWqf1ng8u@fat_crate.local> <87h6f4jdrq.fsf@kernel.org> <878r0djxgc.fsf@kernel.org> <874jb0jzx5.fsf@kernel.org> <feaefaae-e25b-4a48-b6be-e20054f2c8df@intel.com> <20240515072231.z3wlyoblyc34ldmr@desk>
Message-ID: <529C9374-DA6F-49C8-9B32-91741800F8E4@alien8.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 15, 2024 9:22:31 AM GMT+02:00, Pawan Gupta <pawan=2Ekumar=2Egupta@li=
nux=2Eintel=2Ecom> wrote:
> Other interesting thing to try is cmdline
>"dis_ucode_ldr"=2E

Right, is his microcode revision 0xf4 the right one for that model?
--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

