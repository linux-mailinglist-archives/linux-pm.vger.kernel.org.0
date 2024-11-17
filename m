Return-Path: <linux-pm+bounces-17680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D639D03C3
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2024 13:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EF2B266F9
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2024 12:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7072A1A9B44;
	Sun, 17 Nov 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="DHjTIw83"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4D71A00FE;
	Sun, 17 Nov 2024 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846334; cv=none; b=hAQGcrLr2b8Kmcsu9ufM/EhhatEgMDMSr2boxk2Xr9q3EC5arZBV49AtPTLx1BSMC+MoukscMru4upjhCaDU//NIQfqLGaQpoRokTQo7jGmPL15LNIN+tMl4Kahc1JaQV4HiueEmxNGoVBpNkIo/BcX6+wOPNGTlaB9DJ1lLjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846334; c=relaxed/simple;
	bh=Fq865M/WrUHRUH+5J7pUXroBZwRrXAGq8n5OxIsSYF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KHnV4Phywc59FjcrafPIZUBM6EZP8o6vGqOncRpaoE464PXkW+wyfoSkMfu4aqCdkvL8U0CtI817XDmH4Pgx7aLR1BmeVzFNw7SfKqQXpi+v7OMmWb+8EQRwv464xS+gsR16WLvAGDdRsVmxb2mzl+2JUHp9+HqhAgkgvxUanxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=DHjTIw83; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846328;
	bh=tIh/QNV7meNa8ZIOXp4JCVdE5EyBroYXF+febM+ZTBY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DHjTIw83VFAysYWEw7AgoPAe6hOt4XDQZOG2X63mE2qeumMvRDF2mUpHXtJUcRE8N
	 R+ghXJqqRr6WH2hHJkynC/ievdh9h5KBPxgZC19TtzcVP4ksJiM5tQHlt8BRXAfIkA
	 /WU2tEuRmzubxUWOWbdOH42Jfkvujqw4miYp8BSAWIPpqh1oQtGuoZkzc1f3cEZg5+
	 F4EFQkUyasEXcfRfJrkMuLh1apvdcSWYtWLFfbT6VPis5dXaMih0CAUjOrOy43bu7l
	 TrYPr8MkDEpwxy7zG6tZhKpgerwkVYXriBVTLniJ9jW9+RQAI3e9j7hbqRGvpoAKGI
	 AQCjUIgARCGVA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqj4380Zz4xfJ;
	Sun, 17 Nov 2024 23:25:28 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-pm@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rafael@kernel.org, viresh.kumar@linaro.org
In-Reply-To: <20241112085148.415574-1-mpe@ellerman.id.au>
References: <20241112085148.415574-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] cpufreq: maple: Remove maple driver
Message-Id: <173184539748.890800.8372516431978764964.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 19:51:48 +1100, Michael Ellerman wrote:
> This driver is no longer buildable since the PPC_MAPLE platform was
> removed, see commit 62f8f307c80e ("powerpc/64: Remove maple platform").
> 
> Remove the driver.
> 
> Note that the comment in the driver says it supports "SMU & 970FX
> based G5 Macs", but that's not true, that comment was copied from
> pmac64-cpufreq.c, which still exists and continues to support those
> machines.
> 
> [...]

Applied to powerpc/next.

[1/1] cpufreq: maple: Remove maple driver
      https://git.kernel.org/powerpc/c/fae2987e67786a6358c0ef47189b12ff19e9543a

cheers

