Return-Path: <linux-pm+bounces-22721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A276FA408A7
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 14:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF69819C07F5
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 13:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B24B20AF89;
	Sat, 22 Feb 2025 13:25:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7901B207A0E;
	Sat, 22 Feb 2025 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740230742; cv=none; b=ioCRuct9rvvkA48tkFoLcz8kGZJUxqxCyGqgwRlpeim8VXZtO7bYahSwl7aXFn29KGaAL5M2or+E5BHwelo7TddHg/8MJoI6GEO5k3y8wjapT9/jAOC+KtAil0kPIN+cz6+eu2XZSa+mSBd6JXByKuBtIHJggn0z936MFGLtVV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740230742; c=relaxed/simple;
	bh=BJ0o5CoL7JzS5CVcEkg5VlfLD/GqRHmfGMCYNaiDfuA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a0SVH9+uQgtE3vuBMqbZtjC6PncCEeitqBWowdu0XgTq4PvHNhAYBU+239tML4VJy/aGMvDTmxEMYe/1n78vIfK83Ubb9xRfglXw0cf28S1gXluA96jd8mJULSCV+S9RmpmFfz4kl9z5hYeQ2ZXYXb1i1rQsCE8lGDejUMKj47E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69A3C4CEE2;
	Sat, 22 Feb 2025 13:25:41 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 0C42F5F7C0;
	Sat, 22 Feb 2025 21:25:39 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, lee@kernel.org, 
 samuel@sholland.org, jernej.skrabec@gmail.com, conor+dt@kernel.org, 
 krzk+dt@kernel.org, robh@kernel.org, sre@kernel.org, 
 Chris Morgan <macromorgan@hotmail.com>
In-Reply-To: <20250204155835.161973-1-macroalpha82@gmail.com>
References: <20250204155835.161973-1-macroalpha82@gmail.com>
Subject: Re: (subset) [PATCH V2 0/4] Fix RG35XX Battery Charging Issues
Message-Id: <174023073898.2739576.4232537101952700431.b4-ty@csie.org>
Date: Sat, 22 Feb 2025 21:25:38 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 04 Feb 2025 09:58:30 -0600, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> The Anbernic RG35XX devices sometimes fail to charge when the register
> for the battery temperature sensor is set to the incorrect value either
> by user error or an incorrectly programmed efuse. Allow users to
> hard-code if a temperature sensor is not present (which is the case for
> all Anbernic RGxx series devices) to prevent this issue from causing
> problems. Additionally, a bug was identified with the handling of PMU
> faults while this fix was being tested.
> 
> [...]

Applied to dt-for-6.15 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[4/4] arm64: dts: allwinner: rg35xx: Add no-thermistor property for battery
      commit: c2eedcafb0e2613d44f57d7a8b416d752d76a15f

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


