Return-Path: <linux-pm+bounces-13906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5A097227F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 21:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7391F23C3B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 19:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92698189F45;
	Mon,  9 Sep 2024 19:23:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F10B17C7D5;
	Mon,  9 Sep 2024 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725909816; cv=none; b=k6j/yrpsWWugltkxg9rR1ZWosfR6Nqp3j8oZG4n0R0jdjh2xAdnnZQk4+4xxjId+Cz+2bDD3oaW9k/55S7PrWAlDCI6Yl1LUnfsAomlFnajJJieUeMuSHiOiAwANYzYMj0NcZcSvq83j+j656Oy4ZgsY2K4Q81x2Kxw71mE0PwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725909816; c=relaxed/simple;
	bh=u2RN3vQAYk/XvwmBVDV7ioRu8REE5BqsQ8i7L2NZpoo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tuQju5B761Vh1TUtqF9kxls5dq+gQ8Uyi8gnycKQ0gyWnAp+eNtN6ufJUkU+q83sJxKx4K5KpvnDY0ZNQB05gbIHuT7tuRJVA07+qajLgM2XVxQnY3Mwmh0wNkXJpLT2pJC+BHXhL7hVYNXWao0lakknO9Fcafl38hnwuYYwEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EDBF106F;
	Mon,  9 Sep 2024 12:24:02 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71BF83F73B;
	Mon,  9 Sep 2024 12:23:29 -0700 (PDT)
Date: Mon, 9 Sep 2024 20:23:26 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: bigunclemax@gmail.com, anarsoul@gmail.com, aou@eecs.berkeley.edu,
 conor+dt@kernel.org, contact@jookia.org, cristian.ciocaltea@collabora.com,
 daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
 jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, lukasz.luba@arm.com, mkl@pengutronix.de,
 palmer@dabbelt.com, paul.walmsley@sifive.com, rafael@kernel.org,
 robh+dt@kernel.org, rui.zhang@intel.com, samuel@sholland.org,
 tiny.windzz@gmail.com, wens@csie.org
Subject: Re: [PATCH v6 3/3] riscv: dts: allwinner: d1: Add thermal sensor
Message-ID: <20240909202326.59927766@minigeek.lan>
In-Reply-To: <08466bb0-4306-4941-97e1-e62ba07d8ea2@gmail.com>
References: <20231217210629.131486-4-bigunclemax@gmail.com>
	<08466bb0-4306-4941-97e1-e62ba07d8ea2@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Sep 2024 10:16:56 -0700
Sam Edwards <cfsworks@gmail.com> wrote:

Hi,

> Hi Maksim,
> 
> Apologies if I have failed to find a v7 of this patch in my searching, 
> but I'm seeing that patch #3 here was never applied, so Linux still does 
> not enable the thermal sensor in these chips. I just thought I'd give 
> you a heads-up in case you weren't aware. :)

There is an unaddressed comment on this patch: to remove the "disabled"
status line. Sam, feel free to fix this and send the patch again,
unless Maksim beats you to it.

Cheers,
Andre

> 
> Thanks for all your hard work,
> Sam
> 


