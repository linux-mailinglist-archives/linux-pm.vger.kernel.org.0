Return-Path: <linux-pm+bounces-39888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81265CDA270
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 18:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41A26303DD37
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A43347FD2;
	Tue, 23 Dec 2025 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp8Lc53E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACDB338927;
	Tue, 23 Dec 2025 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511870; cv=none; b=kne7hnH/oi7fD6caU9PuEcGID3SlFZR/eKJnKyl2yOuNjodo9wCJohHU6YeHpsr4Hn17WUsv0oph3Osm2rn8iJLjjYTC4gz7R0D9xbauh3f3vN5x1qH6rhXGV+sNIARDlKeGgScPVRrIe7nsjmf8fzzFVXdNbx2Z1Bu/EIly3fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511870; c=relaxed/simple;
	bh=QfnwP6g3xZyc9qS0ZVe4lcUJD+FmaQPSpWmATsSwLwg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UdGYUDueWYfiW5mpU9Vb3xrXoEUxYWn69QMNflhfFwPsrsK52dGktVPdBE/j0GJAHcXZFalpYnaqHy5UTvWEPS5LgeX5orGCdjgFDzlByBYeD2YI3emRMyFcz9L9J38hC0OKVss7svkAvcmBQv9x90ma09B/6z9CrKMIB7Q5xUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp8Lc53E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D944C113D0;
	Tue, 23 Dec 2025 17:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766511869;
	bh=QfnwP6g3xZyc9qS0ZVe4lcUJD+FmaQPSpWmATsSwLwg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hp8Lc53E+roULdJGi8nNVCdOFZOj4ej522R5s0vXLxIhbW3PkknOgMvnyu4Y1akKE
	 ROr8nmuY3C35WGHDYTvja18GMifaHlMl1N9reCfXDBmdY1gLYl+rZ/G91eOc3un3xM
	 2HuwekgGq20MVunBhsVIX/siQi5MK1Ty42v4ZsLc/iq5NZ1Li+pCwYWjyfOAGjHAnt
	 IBW3l2p9z04VqgMKlsuwGUhwU1IZBm060VDw6VhWYp5q9Rt2aK60k67LrgmKIUBRm9
	 t8YCosA6KTxPW/x569a7f+KVh0CRQTZ3FZ0uLHWmebvYBon8ZnjNlc1elx8SfItm8H
	 04RwnURXY4vpQ==
From: Vinod Koul <vkoul@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Brian Norris <briannorris@chromium.org>
In-Reply-To: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
Subject: Re: (subset) [PATCH v1 00/23] PM: runtime: Convert
 pm_runtime_put() to a void function
Message-Id: <176651186788.759340.13138612907596077683.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 23:14:27 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 22 Dec 2025 20:48:11 +0100, Rafael J. Wysocki wrote:
> This is something I have had on my todo list for some time, but it is
> kind of tricky because the return value of pm_runtime_put() is used in
> some places all over the tree.
> 
> Nevertheless, I think that it is worth doing because the majority of
> users of the pm_runtime_put() return value are at least somewhat
> questionable (in fact, IMV the only legitimate use of it is in the
> USB core where it is included in a debug message).
> 
> [...]

Applied, thanks!

[13/23] phy: freescale: Discard pm_runtime_put() return value
        commit: 8bb108e4f6747dcea590710c4b6f95eebf4a04d6
[14/23] phy: rockchip-samsung-dcphy: Discard pm_runtime_put() return value
        commit: 455bf7d9256495e09fd3fd4a4e8a41e727f1043b
[15/23] phy: core: Discard pm_runtime_put() return values
        commit: caad07ae07e3fb173e804abdd53fb96aa7186830

Best regards,
-- 
~Vinod



