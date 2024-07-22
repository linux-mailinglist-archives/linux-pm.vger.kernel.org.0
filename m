Return-Path: <linux-pm+bounces-11288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C56079389DB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 09:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7906D1F217CC
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA013208CA;
	Mon, 22 Jul 2024 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ny7J4Qsc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A26B18042;
	Mon, 22 Jul 2024 07:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632439; cv=none; b=epzTBd6+yJSCgB6zPLNyuurL+rtQ2ZGKdNbtskhK385JuY7c+Q5tRN+gCUv65YAMJDtDnuGqZzDhr7XSeV5EIsS9fJKDOTmdt76sUXXk2PbK+jcZf/aKbERjZsSJsD/ypuQWqlS2QVzMcedTTnUVHtFnU3CbjlmaLB6UoDlajgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632439; c=relaxed/simple;
	bh=iB1QOBqFVvlM/tdGuOs0pX0CIU12BzEFaEcvVN2YBOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JrRp3OdGvA/Pcb2KcAQyyUq8nftaUH2T+vL9nmPhz7gAxvZq+N9Tx4Kc+ur3I92aFzP6RTRHeNJUwNjQsmdZQ81ilRdgkhl2FsCYi7ERgl9Eus791Erwoj8k3z4o6YQFiJPMxUpA1FWX/FyzsB1qwM/Glhrvciz/M0GGEJ2rgDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ny7J4Qsc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721632434;
	bh=6l9oTJbEcWGJwSJxH1MEdCIBrY+RHN7wzT3mRVNamcw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ny7J4QscA7BWI6vcC412b5mW2ix1Qw4tkN2E38BJ+FhP4qi98iP3whWAw9ij4ef7w
	 k/HCMmakYVFo14Hr7bFOqI0hGaecjH/iInyXrTgrUqcg60CVvy5reHAeJHPrO6y8aZ
	 SCgmF8CCVTKQkIqnltNUcacpRqZsXbkXpm1tuGcC/8wADBekoihBEym035Mysdvexx
	 IVEBwrqucJup4aEHV56YodHDlRiNzzGEvV8ze4Ws9rdKa8bCKeIZQAdZqBONE7e6PB
	 XuDVU0bNcsOhSjI/j1dVhCJqci91ms8lG+uEY2Pw4Iu6sqQb0auP/MLSlSSsH9wQDc
	 /G5IuSysaiP5g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WSBN070S7z4wxk;
	Mon, 22 Jul 2024 17:13:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org, Jeff
 Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH] cpufreq: powerpc: add missing MODULE_DESCRIPTION() macros
In-Reply-To: <20240614-md-powerpc-drivers-cpufreq-v1-1-de4034d87fd2@quicinc.com>
References: <20240614-md-powerpc-drivers-cpufreq-v1-1-de4034d87fd2@quicinc.com>
Date: Mon, 22 Jul 2024 17:13:51 +1000
Message-ID: <87bk2px5jk.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/ppc-cbe-cpufreq.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/powernv-cpufreq.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
> files which have a MODULE_LICENSE().
>
> This includes three additional files which, although they did not
> produce a warning with the powerpc allmodconfig configuration, may
> cause this warning with specific options enabled in the kernel
> configuration.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Corrections to these descriptions are welcomed. I'm not an expert in
> this code so in most cases I've taken these descriptions directly from
> code comments, Kconfig descriptions, or git logs.  History has shown
> that in some cases these are originally wrong due to cut-n-paste
> errors, and in other cases the drivers have evolved such that the
> original information is no longer accurate.
> ---
>  drivers/cpufreq/maple-cpufreq.c   | 1 +
>  drivers/cpufreq/pasemi-cpufreq.c  | 1 +
>  drivers/cpufreq/pmac64-cpufreq.c  | 1 +
>  drivers/cpufreq/powernv-cpufreq.c | 1 +
>  drivers/cpufreq/ppc_cbe_cpufreq.c | 1 +
>  5 files changed, 5 insertions(+)
>
> diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
> index f9306410a07f..19ca7f874d28 100644
> --- a/drivers/cpufreq/maple-cpufreq.c
> +++ b/drivers/cpufreq/maple-cpufreq.c
> @@ -238,4 +238,5 @@ static int __init maple_cpufreq_init(void)
>  module_init(maple_cpufreq_init);
>  
>  
> +MODULE_DESCRIPTION("cpufreq driver for Maple 970FX Evaluation Board");
 
Can you change this one to:

"cpufreq driver for Maple 970FX/970MP boards");

It looks for both those CPUs in probe.

> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index fddbd1ea1635..e923f717e1d7 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -1162,5 +1162,6 @@ static void __exit powernv_cpufreq_exit(void)
>  }
>  module_exit(powernv_cpufreq_exit);
>  
> +MODULE_DESCRIPTION("cpufreq driver for the IBM POWER processors");

This one's tricky, because it probes based on the device tree, though it
is restricted to CONFIG_POWERNV. It also supports non-IBM CPUs in theory
at least. Maybe something like:

"cpufreq driver for IBM/OpenPOWER powernv systems");

cheers

