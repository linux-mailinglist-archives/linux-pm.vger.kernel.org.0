Return-Path: <linux-pm+bounces-22702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADB2A40301
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 23:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962E019C86F3
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 22:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1896B24CEC2;
	Fri, 21 Feb 2025 22:51:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AF21FE478;
	Fri, 21 Feb 2025 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740178299; cv=none; b=gcCBpQCncOey9hARSiFB2I51Z4bcY3gxSsUl9vDtB+N9xXG+fHL7uNgL/RMUxJWQWmn/v+iofIL1xtAij3Lw6Gy7qMa29NmABq+c5K8wZ/YKURiEgq8RBMtjgvlF1eM6FIQKMSC9caaza/4KzljZ/ew6a3vs6d5eLh4n9n5VyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740178299; c=relaxed/simple;
	bh=zcVkL0nxSTlmIWLn85VzcI7kovdWHOwM5mLusDodj8I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dflMx08PD7z4LVwUAIMoPR63g7luFILmpZVvFSUhcnS7k+bc83rOUDYhcJ/nVV0RPdJw/GvSY6ZqCAaydTt3EIyxzIATGQojkA6kpjtr4lHjmCObR6ni1jfTm1s5fq9mW7l3RaGsM3tD2g+zsF3/QgZqFTFj4P57zR0XTAI/WGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1993DC4CED6;
	Fri, 21 Feb 2025 22:51:38 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 0E5A8180937; Fri, 21 Feb 2025 23:51:36 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, lgirdwood@gmail.com, 
 deller@gmx.de, andriy.shevchenko@linux.intel.com, sre@kernel.org, 
 sakari.ailus@linux.intel.com, mchehab@kernel.org, jdmason@kudzu.us, 
 fancer.lancer@gmail.com, Hans Verkuil <hverkuil@xs4all.nl>, 
 Raag Jadav <raag.jadav@intel.com>
Cc: linux-sound@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, ntb@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250221165333.2780888-1-raag.jadav@intel.com>
References: <20250221165333.2780888-1-raag.jadav@intel.com>
Subject: Re: (subset) [PATCH v1 00/13] Convert to use devm_kmemdup_array()
Message-Id: <174017829603.128405.11979179155278619095.b4-ty@collabora.com>
Date: Fri, 21 Feb 2025 23:51:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 21 Feb 2025 22:23:20 +0530, Raag Jadav wrote:
> This series is the second wave of patches to add users of newly introduced
> devm_kmemdup_array() helper. Original series on [1].
> 
> This depends on changes available on immutable tag[2]. Feel free to pick
> your subsystem patches with it, or share your preferred way to route them.
> 
> [1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
> [2] https://lore.kernel.org/r/Z7cqCaME4LxTTBn6@black.fi.intel.com
> 
> [...]

Applied, thanks!

[08/13] power: supply: sc27xx: use devm_kmemdup_array()
        commit: 0c3cbeb89c49f47ce6cae9250c8ff6c8f3cdf232

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


