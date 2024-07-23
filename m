Return-Path: <linux-pm+bounces-11315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4D093973F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 02:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C051C21918
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 00:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB403367;
	Tue, 23 Jul 2024 00:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="lvyK8ljQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B27F;
	Tue, 23 Jul 2024 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721692887; cv=none; b=Fd5JedxMNVEgrtNKHSa8vnmhtX0HQHF02/RCkJh5ygAwRZhs2gQxGW949Kk1tf442b/ckZVNE84eS4nv+pSIoDsFYq2kfMj+aBa0gljLcEYs6s21Npw+n1PvdyJkSGH9Ss/8M4Uu+Tn4mTBfGiUJGleUZcoEsheuvc1CZal6Q54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721692887; c=relaxed/simple;
	bh=2N5hAJNc/wHGl0+Wu9SA5P6Gr5W2YtDnH5+knDo4Ff4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B5iqJCmixegu5w+QK9p0DRiDhNqFBUEc/n/qSbaEnbdtFPehspmovNDxA6OozPPpSX1t46+/Wl94ICKCurto0/dB3Y38jV+U0CLGmRFlCQGhp5bV9HnXz8Cc6iyF6VDjXG/r6/XZ5VKsZIi3TOhvm4ppG9cwmoeMpzgQqzh7BE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=lvyK8ljQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721692876;
	bh=1ee9dpsEkMVtwnazsE5jJi3meNyVdkAB7jjS0GvSPX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lvyK8ljQXrJ70+MKwGlDyyNdspRGaVFS8sTJqSGUEFVJFCJk6ofjy9aiockxrI8GL
	 VZlkQ5kA8ALnfJfPn+cTpikrO7xPMAAOQjqRIAOyl4sQpMahgTFtsjrfn21aaH0Uwe
	 CwBicMo9gCli+tVNjbgIF/unZGFWs1ntjB0DZCpKNajBMwCJdIxT+YkQqX6qy21gQB
	 WaZhYMEKjZi9UIHV9kAcn2vyPbSxGvCn+JMwFyTN94MiBkXQWjkt1RPAQ4nXiJlNwK
	 o1chsP9+/HDPycBcKeqAVXWSFlkgB4UsjbeU9bpQz9IXzUrVM5wdASAQBWyQbVdjhw
	 Uqhg6kHYSkoPA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WSckM1pQBz4wcR;
	Tue, 23 Jul 2024 10:01:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org, Jeff
 Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v2] cpufreq: powerpc: add missing MODULE_DESCRIPTION()
 macros
In-Reply-To: <20240722-md-powerpc-drivers-cpufreq-v2-1-bb84d715eb3d@quicinc.com>
References: <20240722-md-powerpc-drivers-cpufreq-v2-1-bb84d715eb3d@quicinc.com>
Date: Tue, 23 Jul 2024 10:01:13 +1000
Message-ID: <875xsxvuwm.fsf@mail.lhotse>
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
> Changes in v2:
> - Per Michael Ellerman updated maple-cpufreq.c and powernv-cpufreq.c
>   descriptions
> - Did not carry forward Viresh Kumar's Acked-by due to this change
> - Link to v1: https://lore.kernel.org/r/20240614-md-powerpc-drivers-cpufreq-v1-1-de4034d87fd2@quicinc.com
> ---
>  drivers/cpufreq/maple-cpufreq.c   | 1 +
>  drivers/cpufreq/pasemi-cpufreq.c  | 1 +
>  drivers/cpufreq/pmac64-cpufreq.c  | 1 +
>  drivers/cpufreq/powernv-cpufreq.c | 1 +
>  drivers/cpufreq/ppc_cbe_cpufreq.c | 1 +
>  5 files changed, 5 insertions(+)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

