Return-Path: <linux-pm+bounces-24931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E4FA7FA19
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 11:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017BE1894963
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 09:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04DE266B4A;
	Tue,  8 Apr 2025 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="kRPeka47"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81208266593;
	Tue,  8 Apr 2025 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104939; cv=none; b=XF447oFQ0f+UNPz8y2XzvaTMWruoAA/VEi2FOLuQR0tqbZOIfVNaKIsGpKLt4dEa0zC0k8zYB7C9IH0Kry/ffRPJDiWRit9aTZohkP0pc8zwVu7cPFqrDxy3VE0pgpfF5mOjdlnuTNJKBb6wywQyzw8kRk9Qrw0Tq9XZCGruuYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104939; c=relaxed/simple;
	bh=EJSHMKpGhViqTfouoTjG+vkCRWxUv1idSyLcCyeRa1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FowtkyRXLclY4D5BWZUHH8gEapeI9B+ojKAZz9fq83QD/WuJUmNNaKaNZO3LYPR6vAUVMPRYXC41xE3G40WrL2wfIGP9kQwYjfVsoSBFA5KfRFWIppJPKh2tz3tKmT2WdcsblUQrJWi9eGz8Zqk0GHOgXQl+ONAg6cnLD1nzADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=kRPeka47; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7B98F1F9BC;
	Tue,  8 Apr 2025 11:35:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744104935;
	bh=epFMM6E3b5n0AAjQqhCMwFutqLu+axl/bDlyBr62jpM=;
	h=Received:From:To:Subject;
	b=kRPeka47FL9mUb/LiDd/KpngGvLjxHugS25K7j24KcMayZUKVJPhJdJic4fXTaRVi
	 fPOKGwxQ9qqLyl/6RhA+Mkw+mSUUotd/VLHTPRETb8/UwuMohmuRXW2/8U1bs6f4VH
	 Oi86j2bfeCOn5i5AOeFvnjiAxLLKcY1NZFy8sbaYmOVOVxEuQogIE6orN3NX/x1J8h
	 YqBnKXKQ9DHpF+MV9LJeyRylGN9US8ePAGtJBC4+Ph1R1G+T1m6qPROnW/SZtOPqNl
	 HOkkaWNeoZ7K7vLm7xW/IvqQLofWQOA+ODX83FJvJAcIHsqOYm8yU5rO7K+M2NBmFz
	 tJS0d65nIZHLw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 328987F8D5; Tue,  8 Apr 2025 11:35:35 +0200 (CEST)
Date: Tue, 8 Apr 2025 11:35:35 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>, Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Kernel WARNING (RCU) with btnxpuart on TI AM62 platform
Message-ID: <Z_Tt58Ar9TAUy4gB@gaggiata.pivistrello.it>
References: <20250408083512.GA26035@francesco-nb>
 <a8e7171b-d859-4611-9681-e4c614f29d64@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8e7171b-d859-4611-9681-e4c614f29d64@molgen.mpg.de>

Hello,

On Tue, Apr 08, 2025 at 11:26:47AM +0200, Paul Menzel wrote:
> [Cc: +regressions@]
> 
> #regzbot introduced: v6.14..v6.15-rc1
> 
> 
> Thank you for your report.
> 
> Am 08.04.25 um 10:35 schrieb Francesco Dolcini:
> 
> > I do have the following kernel warning with 6.15-rc1, on a TI AM62
> > platform (arm64), single CPU core, using btnxpuart driver, any idea?
> > PREEMPT_RT is enabled, if it matters.
> > 
> > Either the issue is not systematic, or multi cores SoCs are not affected
> > (no error on the exact same image on a dual nor on quad core TI AM62).
> > 
> > 
> > [   23.139080] Voluntary context switch within RCU read-side critical section!
> > [   23.139119] WARNING: CPU: 0 PID: 61 at /kernel/rcu/tree_plugin.h:332 rcu_note_context_switch+0x3c4/0x430

...

> As I understood, that it’s a regression, and you can reproduce it, would it
> be possible, that you bisected the issue?

I am not sure if this is a regression. It's possible that the issue is not new,
and it is just non systematic. For sure it was reproduced by our CI on v6.15-rc1.

Francesco


