Return-Path: <linux-pm+bounces-40626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7356CD104E2
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 02:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4367A30A3F05
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 01:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04945237163;
	Mon, 12 Jan 2026 01:56:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0023ABA9;
	Mon, 12 Jan 2026 01:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182968; cv=none; b=aHBYFhAgKCwJo9RzBvDQKsZm1XfZesz2qvSJZ+e3/QJBVhaWD5YrcjZPwUkm4qwt8mg8mVwITlxULPA2w/OiOibohk/SmwoYVzNs4GRCm+obvFJBSwaRO7LVGUJj8OxPrEJZNsYUYKm1Cdj7XJSbd547JS7mPSBNv627H69Tb2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182968; c=relaxed/simple;
	bh=iqa27vuCrzqttH9JOB13T3XEoujmfsmUNotCTyzLph8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=quqZevqJykC6/0zzPo/JAd2lapqbhdjRJw+rWN9yFFJXlif30PdIlHeQWXdxH4pQv3399lXP1HZQRLw+FfElZPUdAYdOkVxOP+Z1NaWQ54GxD8XSp/XmODVxKx8jqQzEm4+o7k5Le6OLPsh9DwmywCaN68CXVv50VYUl+HU5KMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBFAC19423;
	Mon, 12 Jan 2026 01:56:08 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 21B6818068E; Mon, 12 Jan 2026 02:56:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
In-Reply-To: <20251111060009.1959425-1-rdunlap@infradead.org>
References: <20251111060009.1959425-1-rdunlap@infradead.org>
Subject: Re: [PATCH] power: supply: ab8500_chargalg: improve kernel-doc
Message-Id: <176818296412.643060.12298903088499964424.b4-ty@collabora.com>
Date: Mon, 12 Jan 2026 02:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 10 Nov 2025 22:00:09 -0800, Randy Dunlap wrote:
> Correct "bad line" warnings and add descriptions for missing entries
> to avoid these warnings:
> 
> ab8500_chargalg.c:173: warning: bad line:  is set
> ab8500_chargalg.c:179: warning: bad line:  increased
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  't_hyst_norm' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  't_hyst_lowhigh' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  'ccm' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  'ac_chg' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:247: warning: Function parameter or struct member
>  'usb_chg' not described in 'ab8500_chargalg'
> ab8500_chargalg.c:308: warning: Function parameter or struct member
>  'state' not described in 'ab8500_chargalg_state_to'
> ab8500_chargalg.c:773: warning: Function parameter or struct member
>  'di' not described in 'ab8500_chargalg_chg_curr_maxim'
> 
> [...]

Applied, thanks!

[1/1] power: supply: ab8500_chargalg: improve kernel-doc
      commit: 81963d1c5689168731dca0652093c73b90bed1d3

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


