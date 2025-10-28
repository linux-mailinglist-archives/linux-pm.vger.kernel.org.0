Return-Path: <linux-pm+bounces-36955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C46C13191
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 07:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324B4584D60
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 06:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B8B29E110;
	Tue, 28 Oct 2025 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYCz8aU2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2814729C328;
	Tue, 28 Oct 2025 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632206; cv=none; b=NCbf9HUGnUdRy9v08KhUqz+rVSj7UY5hxsM8M0RqZJhCoFAihfPMIB4D6XWLVpk72SWaymbC1qdaUoaBh41ij1nwlZNlZ8PHo/qTKfve4ULsL2tZmH1J2nRtEystBKirgPsrlT00VMwBXw/jykzROPgUm0vMLYvod1Ju6dx/k/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632206; c=relaxed/simple;
	bh=JMt0g+3elYjxcxaxmCLJQE7WMr+hUSi/SmXMrtaOYZg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NAqqX1s4bewr5t9CZ14n1iLhp0JQoVm7O4SgB/rzzGMOAiQXkRi9yFu+BxhjNyeBRI5oexu7fgtoLQtS4NEQa72G94T5KYGCcuDJ1AF8/pG8mGJ5UZuW0D+2etvSNEO7jyzDED8amgZoaFMuAP0fStJNkw65nl0WuC65qfqCve0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYCz8aU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281F5C16AAE;
	Tue, 28 Oct 2025 06:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761632205;
	bh=JMt0g+3elYjxcxaxmCLJQE7WMr+hUSi/SmXMrtaOYZg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=eYCz8aU2Nf0loa5H4K1+9cuAcCCfgs8XCvRzD7Mp3pJLBHa/y+BP2DANMctu5sHIF
	 1mnpK3uIE98D8X8j3F6mgNBgcw+j00EL0cK4dNdZodPMgoxBDsTrgy4Gclzf2ETasI
	 D8y78vdSd79i94ZJtbBY9mBac1XHLEdRTBOyxfOLPT9Co/Iwt6On/1TkrEI+HLVU7S
	 /bZHLKWeSPmJwvfL78TaIitOuaFv1znoBgASA4SA80yWMI4vFPnQHc9HDzXTYqPmbk
	 lq1dLoRDbrrsIhR4G5xOLjEEK9HMV+LPP5zjQrW1XXwsQRBegKUNBfLugJO0dGwpgg
	 KPNU07tEbwITQ==
Date: Tue, 28 Oct 2025 00:16:38 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
cc: Anup Patel <anup@brainfault.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, linux-pm@vger.kernel.org, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpuidle: riscv-sbi: Replace deprecated strcpy in
 sbi_cpuidle_init_cpu
In-Reply-To: <20251021135155.1409-2-thorsten.blum@linux.dev>
Message-ID: <c0619d96-9880-8289-6544-97b0d9c3e663@kernel.org>
References: <20251021135155.1409-1-thorsten.blum@linux.dev> <20251021135155.1409-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Oct 2025, Thorsten Blum wrote:

> strcpy() is deprecated; use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks, I'll plan to queue this one through arch/riscv fixes - unless 
you'd prefer to take it, Daniel?


- Paul

