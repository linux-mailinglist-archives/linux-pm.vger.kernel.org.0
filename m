Return-Path: <linux-pm+bounces-29457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA9EAE7587
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 05:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B231BC1B17
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 03:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E371BD9C9;
	Wed, 25 Jun 2025 03:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Vu66G7A1"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7271917F4;
	Wed, 25 Jun 2025 03:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750823296; cv=none; b=jlT4Ov/fcOv7fB2FnYUs6/2zFaOUurJN6Gpn/H606jYu7hd6lP2V6DMv9xDd138Hubc85YXtJoiJhn9R5Ib+w2xRPpOYsVN6MLL9Mhm751KURLOICYHprGC74z7unGr997A5CjGjEDbaXucRVFy0ZnPfkB3MSjcVZO947xkZeR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750823296; c=relaxed/simple;
	bh=Otk52K2UkGgNNbsfo3Tw+wT8D1C0VqHYBREnFKHZXdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2jjZQgQ9qV+Rgu75d38VUc6DHfy6ZyW3mxV988wxrGFeEGCRr8kfHtR+rnHZhQGvTs6wdpFQAqF384o3nrMle4vYGNnrkjQEL/o1SsjyNujExHxXTJtxMXW6Bd9fCq2WiPjqT78RSMLUHVyImCEl+oSrC4pUqrK1/gK9t9xWeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Vu66G7A1; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 48398206BD;
	Wed, 25 Jun 2025 05:48:05 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b7gxHv5344jB; Wed, 25 Jun 2025 05:48:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1750823283; bh=Otk52K2UkGgNNbsfo3Tw+wT8D1C0VqHYBREnFKHZXdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vu66G7A1MauCIThE3FLEUGylkmIO/BxPgVEv36LVLfofHUhmW7DKcv9OMGJvYf3kA
	 90phhj8O7Y/sMbINhNjl2LkRVK8EOmAgdoDzvh2OwuwVDwVqOe9LHnw4y25j4tJFX9
	 Se1YQiArrVaJBtqQbIz/9IWoLJ22ODbFvmqRlfCLv/lVee6g+1xHsnU3IfbHEYTGfo
	 iapSQyYzCAOamera+WXhhwZX2I16jUHMTA5hS/TJZWReOO5q1wLLJ5ErEbMr5xgsVs
	 HEG9BCoUPLqcQQNH9K8KuWtC3Fl1et/V3GMe1hsI9GHliYTJBVP8jLnzhBHN3k5yX7
	 uDrxzZp91z5xA==
Date: Wed, 25 Jun 2025 03:47:47 +0000
From: Yao Zi <ziyao@disroot.org>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: loongson3: Support older SMC firmware
Message-ID: <aFtxYwgZDbYy_EMb@pie>
References: <20250623123321.5622-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623123321.5622-1-ziyao@disroot.org>

On Mon, Jun 23, 2025 at 12:33:21PM +0000, Yao Zi wrote:
> SMC firmware found on many on-market LoongArch devices implement a
> different ABI than what has been implemented in the current upstream
> driver. They significantly differ in the following ways:
> 
> - CMD_GET_VERSION returns 0.
> - There is no known SMC call to obtain corresponding frequencies for
>   each frequency level. The frequency table must therefore be calculated
>   with CPU clock frequency from scratch.
> - There is no known SMC call to obtain the current frequency level.
> - The main processor must determine the set of cores able to run at
>   boost frequency and enable boosting manually.
> - SMC call response format may vary between commands.
> 
> This patch adds support for the SMC firmware found on these devices,
> which I denoted as "SMC-0" in the driver. Boost support is omitted,
> since determination of cores able to boost requires the driver to couple
> tightly with micro-architecture details.
> 
> For coexistence, I prefixed all SMC-call constants with their SMC
> versions, and introduced "SMC-0"-specific initialization and
> frequency-level-setup rountines.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>

While self-testing the patch on a 3A5000 workstation, I observed the
processor cannot run stably at the low frequency levels, it's required
to keep it above half of the maximum frequency for stability.

This type of instability seems to depend on the silicon or firmware
revision, my 3A5000 laptop, Tongfang L860-T2, could run stably at any
frequency level allowed by the SMC firmware. And with the driver it
gains extra 30 minutes of battery life when idle, which looks valuable
to me.

To avoid breaking existing users, I'll disable SMCv0 frequency scaling
by default and add a module parameter to enable it in v2.

Regards,
Yao Zi

