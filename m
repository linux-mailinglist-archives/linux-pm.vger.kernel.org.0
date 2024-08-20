Return-Path: <linux-pm+bounces-12582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEBE958DE7
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 20:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E071C21A7D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F8B1C0DFE;
	Tue, 20 Aug 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="m8P35aCu"
X-Original-To: linux-pm@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBEB1990B5;
	Tue, 20 Aug 2024 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178033; cv=none; b=PkJe3YbcYYm4tsfKnCzQB6tu+yU+6JcaejygR879aPJIldUg2Hs1Uw391CtN9zbyVAgpp1OTBp6lBn226hakEtCdXVv99YKdsEBNApXoaXDLg++kAw4mO6yTXUWbQyiahlLlUQiwqxpPDaMXVOMhiDtsvmAF+ceY+pUFNVEcFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178033; c=relaxed/simple;
	bh=RvWHMA+QlIXIfQFzXjSOSYW566+oe9HIOkqioJSiN4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=npApHffgYvUNketYIkKbP3dqbsXlr0Svk6sZQ9/VUe/5Hf3xDIyoico7+cx6g6l/3iTHzdiuSSRUb/0Fm+/HKL6IB5u9VBfiYZr05DzwwqhDc6pux0xl1Wvl6pJloANp9qmjBYHo8B9/kqhRqs7szywcG2oaGuu+HzGuZYhtIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=m8P35aCu; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 54AAB41A31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1724178025; bh=nFaHd32s5trVTpDKXwsREEAD4awvMeRK4pcOGg/kmmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=m8P35aCu3JXfXC0Mp+qdF8wo9rWEouGDC2rCpysBSPaaiJ3Xvx0xJNDzt0nVKU+2u
	 LmQzKfuu25g1a6d5JcYu1KnGJ//1kA3jSmV9qXESi/55ZptPNxideBikVlD0zvxqP+
	 dzc8GcdZ72jlJM+q0sydDNhvDuEgfUmKYZj/MkEMyWc/QhXvnc67HtHx9qsa+AXL2U
	 UgfbNXO9EK1aABCs2JcwkQs7tliKLldBBVKeCfvuh1eW1RLY6P4sDJ0aIoQOIpALOY
	 sczj3d79VXIRSrIsi6qmW8PtXA2jRzYfSGY4HI4bj79ZMvPhQSA0FQ7ELDKF5BgNpy
	 GLZp8bS6s0ZoQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 54AAB41A31;
	Tue, 20 Aug 2024 18:20:25 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] Documentation: add a driver API doc for the power
 sequencing subsystem
In-Reply-To: <20240820153855.75412-1-brgl@bgdev.pl>
References: <20240820153855.75412-1-brgl@bgdev.pl>
Date: Tue, 20 Aug 2024 12:20:24 -0600
Message-ID: <87cym3f447.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Describe what the subsystem does, how the consumers and providers work
> and add API reference generated from kerneldocs.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  Documentation/driver-api/index.rst  |  1 +
>  Documentation/driver-api/pwrseq.rst | 98 +++++++++++++++++++++++++++++
>  MAINTAINERS                         |  1 +
>  3 files changed, 100 insertions(+)
>  create mode 100644 Documentation/driver-api/pwrseq.rst

Thanks for this ... just one quick nit...

> +The consumer API is aimed to be as simple as possible. The driver interested in
> +getting a descriptor from the power sequencer should call :c:func:`pwrseq_get()`
> +and specify the name of the target it wants to reach in the sequence after
> +calling :c:func:`pwrseq_power_up()`. The descriptor can be released by calling
> +:c:func:`pwrseq_put()` and the consumer can request the powering down of its
> +target with :c:func:`pwrseq_power_off()`. Note that there is no guarantee that
> +:c:func:`pwrseq_power_off()` will have any effect as there may be multiple users
> +of the underlying resources who may keep them active.

There is no need to use :c:func: here; just say function() and the Right
Things will just magically happen.

Thanks,

jon

