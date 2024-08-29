Return-Path: <linux-pm+bounces-13169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1872E96470F
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 15:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14321F22C0C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47CF18C923;
	Thu, 29 Aug 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2/IeRB1u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="juGiuoXI"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECA19408D;
	Thu, 29 Aug 2024 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938990; cv=none; b=j+8dmtZeIvkx4B0lZ1Kj0dDgk4rEUx6hOIcapSvuLuHKW+mlqk021sleZDYkce9MZx0w0GukOqa6TU7ffNQU9ZiFty5qMPDYOYBQqDI2oyXoxSR6oEFagJTLSiKHhYveT5KUWQ1p3S1LmUkjYde6dfPa+IbEs7buUQvI74sW4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938990; c=relaxed/simple;
	bh=nHf+xT92yT82mqfp+QipgHo+k+vk0BwwMwDlqkjAv3s=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h2W8zlGg2+SYenRq11zSkTl1Pydu6mMmpbpGHccC0fiTHcILWxRV0AUnCghMloxqRofx/r3T0dbiK5G4npQhioiix6uO8HgrF6KKVA3kRI1pIqP4FKCgytj6ExeKWvZizukUfL7hAxW3eunqV/UnFR+WFlxnPk4IsJYvoosi8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2/IeRB1u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=juGiuoXI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724938987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aggf7neS26jWKW+YIQkenH6/dZMQMCyhYknOlHKaKGE=;
	b=2/IeRB1udgz4p/pcCGc4UXSK9YP6TdSt3W2cdcUezsQDh+7EcnPjfzF/HyuFC0wa1MuHme
	pF4BZhAikgZHgi0clgSyrrZqEQu+Xa6sCwl8pEDhE7/iPCA+V1V2vJWi/6R15lBwbmCkru
	bci5WWK2Bd3hCii45vkheTFIxUgsg9NEoxiC+xaFbBD1QPPWOCtPYNA4B0dN7SCS0aAPXS
	SzPBQZDbbjcwSmZA8XaCc12t6gmA+/Guz3Qyk942yu1dXqgUsLd+WDcExOdAOem/kS40j/
	i6lX2n9LoJKzq24FJwBbl38f61+fTKaCIbWYuT5OaW0/HP+wzhgsBp1B/gZDlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724938987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aggf7neS26jWKW+YIQkenH6/dZMQMCyhYknOlHKaKGE=;
	b=juGiuoXIPzeyd6G33VQMgMjLiCRqDX7VGyrH4FIb3jszoPFwGaNtXSGD53P39IycO9hqRh
	2FCHfRTeae/j+hDQ==
To: Nick Hu <nick.hu@sifive.com>, greentime.hu@sifive.com,
 zong.li@sifive.com, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek
 <pavel@ucw.cz>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Andrew Jones <ajones@ventanamicro.com>, Conor
 Dooley <conor.dooley@microchip.com>, Samuel Holland
 <samuel.holland@sifive.com>, Nick Hu <nick.hu@sifive.com>, Sunil V L
 <sunilvl@ventanamicro.com>, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] time-riscv: Stop stimecmp when cpu hotplug
In-Reply-To: <20240829033904.477200-3-nick.hu@sifive.com>
References: <20240829033904.477200-1-nick.hu@sifive.com>
 <20240829033904.477200-3-nick.hu@sifive.com>
Date: Thu, 29 Aug 2024 15:43:06 +0200
Message-ID: <87o75ba1hx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 29 2024 at 11:39, Nick Hu wrote:

clocksource/drivers/timer-riscv: is the proper prefix

Thanks,

        tglx
        

