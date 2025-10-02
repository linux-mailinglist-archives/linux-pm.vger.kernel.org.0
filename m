Return-Path: <linux-pm+bounces-35682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654B0BB40F2
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 15:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144B942294C
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A92313548;
	Thu,  2 Oct 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="UckBt4DN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3031354E;
	Thu,  2 Oct 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411945; cv=none; b=U+a6xz7FmQuyW1Oc+vBLiTgGbR0X04jfF7rRUuPjJHCho5V51Il/YZQxdtW/jXKl+JmZhmKMkI+gS6vYI+HYhoT7Q1BaYqvCvL4K+cayRd3SkVv9zVdDgdaPduGEaBKoDdKli2bKXr/AEVozEWzUvsll78/MO4lHbeClkC9mUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411945; c=relaxed/simple;
	bh=fLvK+gR231rwxLjn83oakAMnbSxSqHnABsPzdTdYSP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cl1Q2RIcSzuG5mtnWglN/sQ7AfJQVqIdFjv0gmGMtVkokp9bDjVgU1VT/uAtSehiK33j6YIMHCCezNm5OaXEULGcrBoHGzKCgM8Js3vY9OcEI6bdcxgpRIs4dopUTHTcYk64w0g0nUkWy8upmqjd5Y9fOzJ6wm2ol55vCle0qiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=UckBt4DN; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=JT0Wgd6gBRo4kRQgUxc7iJvWH4BOaF4WzmrNeCf/WNI=; b=UckBt4DNydk83TxpIsFZQo7BHS
	4Bio1l1grmf1Ju2AQH5rwT5+r7nyw/L58jGkzdJT9cch5jy9R2m92xOoSWk9/oalu4Hoe3eN15ktH
	lNqmPrdyb5PbDvHIN2oMF6GuejBVXex04DPBEPOhMVq+DnK7XIQrY86/suih/N0ZtKra6Stt1QQZx
	kMXVJfP9+NQ9Ds27DUWwc2Lb80GQMm8KwbLadZt7Sul5O9aOD6p/3f4gbJA8qcxfhyIgGuwtUXgse
	xEnl9Gda/uvsnjZ5Rit4Jl+pHTjKk3SgY9N+v1rutcU2W5rKfnLx0eqlqhaWXs6Rm14Vfj7Bl/1RN
	bCoflzSg==;
Date: Thu, 2 Oct 2025 14:51:00 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Krzysztof
 Kozlowski <krzk@kernel.org>, Sebastian Reichel
 <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v5 2/3] power: supply: Add bd718(15/28/78) charger
 driver
Message-ID: <20251002145100.2741f5dd@kemnade.info>
In-Reply-To: <20250918-bd71828-charger-v5-2-851164839c28@kemnade.info>
References: <20250918-bd71828-charger-v5-0-851164839c28@kemnade.info>
	<20250918-bd71828-charger-v5-2-851164839c28@kemnade.info>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 09:45:10 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> Add charger driver for ROHM BD718(15/28/78) PMIC charger block.
> It is a stripped down version of the driver here:
> https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.1637061794.git.matti.vaittinen@fi.rohmeurope.com/
> 
> For the ease of review and to do a step-by-step approach remove all the
> coloumb counter related stuff and do not sneak in BD71827 support. That
> also avoids non-trivial rebasing of the above series.
> 
> Changes besides that:
> Replace the custom property by a standard one and do not use megaohms
> for the current sense resistor.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
to not add more confusion: Sebastian: I think you take this for 6.19 into
your branch. The mfd part needed is on the way into 6.18-rc1.

Regards,
Andreas

