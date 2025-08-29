Return-Path: <linux-pm+bounces-33408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A70B3B9CE
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 13:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17F21C850C1
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 11:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434E6270EBC;
	Fri, 29 Aug 2025 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="mWB/aYC6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5B30CDB2;
	Fri, 29 Aug 2025 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466152; cv=none; b=FZ+M42Zc6KCAnoUnIIuwG+g9nfAUcqkg7mjMf91XmopXu+mmjm5oOdJfdI3mLcpGRbr/QqJch1pX9Dn00d/jaCGSjdcS8XgRvsB31Q+ruGmH5pTXMG0Ie4ywcJXVhjzr96egvMTMc5JgHBDMqJSyHFUcd+7AuKYR13QZ297NeZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466152; c=relaxed/simple;
	bh=1cvY5Es+Qsi1sNtchfYDxHniBIpi6YEMiH0Tn6mLyik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxK5WEDRa/EMD0Z0BkDyHTDcwN9tFaTYnPZO+mhXWzg5HG/exStj7FF5aAXV20QDbk19EC/39YY2HwEUPOpfh+MqlGxagcxgIx5egNNa9JnZ8/y/IXQN9vAae2TQ4IK7PVSr2sDm6qt/NFeOXKd00yhvGzP0ZPIJGMR1msU8bAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=mWB/aYC6; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PAt0B5y7TqRJZjJ2YTKx99ZLf+zVMXDPISiWwNJeNt4=; b=mWB/aYC6EY13I72doqzZQeJ/TP
	zLZRgVuSi1HzQjjz12EfRII+ZTpO1hCrw5NxtTnE/aJnaVi3orQX70uHiAUm0KoTn1UHYC6E6eVrf
	z4wovF3aOWjfdFYiPDyFHr0EUbgdkWC/HsqmnLm2RuqrbzfwEYnSOzBmrLNHBDoP6klvfcx+Df1wE
	qTyiLt7uoAg9B7S74IZNjb80U+JlKtUTYNDdV255z+iQnGJ5C1A2dXeixrpc5xoPiAjat8YZ1BSkm
	C2609VX6jEiBDMI/tdWm3qOpTWd2RKxl9kqpuu08xE1aE3O1/+o0g6ygMYGxNzVEBo86Gc0WG8mC0
	y5ARXX3w==;
Date: Fri, 29 Aug 2025 13:15:42 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/3] power: supply: Add bd718(15/28/78) charger
 driver
Message-ID: <20250829131542.4f46ebf4@akair>
In-Reply-To: <6341e004-880c-4a81-811d-a8b367aab39d@gmail.com>
References: <20250821-bd71828-charger-v3-0-cc74ac4e0fb9@kemnade.info>
	<20250821-bd71828-charger-v3-2-cc74ac4e0fb9@kemnade.info>
	<CACRpkdbZN3LB=iVwL0YLEoUOiPMSePdOF_NEGWuCncDAjWY4XA@mail.gmail.com>
	<6341e004-880c-4a81-811d-a8b367aab39d@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Fri, 29 Aug 2025 09:35:00 +0300
schrieb Matti Vaittinen <mazziesaccount@gmail.com>:

> > to indicate that a measurement of the open circuit voltage
> > is available in some register, which enables you do do more
> > precise capacity estimation, right?  
> 
> AFAIR, the ROHM fuel-gauge algorithm used OCV tables when battery was 
> not really open, but 'relaxed', to adjust the coulomb counter based on 
> the SOC estimated from the OCV. The 'relaxed' condition was met when the 
> current consumption had been 'small', and battery had not been charged 
> 'recently'. I have a vague memory the BD71828 had some hardware support 
> for knowing battery was 'relaxed', the BD71815 and BD71827 might have 
> used coulomb counter 'history' for this. I can try to remember all this 
> a bit better if Andreas continues to upstream also the fuel-gauging 
> logic from the original RFC. But yeah, these interrupts were for over 
> current.

78 at least has. But then the question is how often the relaxed state
really is reached. Current limit is around 3mA per default
(REX_CURCD_TH). So if your
power management is suboptimal, you will not reach that state on
discharing. So, regarding charging, at least when I am on vacation,
the limit on available energy is also my protection against spending
too much time with my electronics (esp. on the smartphone). But that
also means that I will not always charge the device fully. Lowering
current may also mis-indicated that the battery is full.
So the scene is set for any mess with fuel gauges, not limited to the
BD71878.

Regards,
Andreas

