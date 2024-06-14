Return-Path: <linux-pm+bounces-9147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E36A09086F6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 11:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6665DB246EE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 09:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E77191497;
	Fri, 14 Jun 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwYMP21H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5724618C32B;
	Fri, 14 Jun 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355815; cv=none; b=igp5E/6ndiU1rLjplTibsx2wZG9QKoRlqGDMSsjmqjFV8f5KXtSYwRJ/cWUH/p09e18mxfT297lqsNqRZl/X/94MpEmGBDa/8DfOyOvbgaIyMSZWh8NgLkg6bFp1oPETEg1HOZcrFKAQ7oLkEE2OAJgV15A2xis+8WpbT3ZX9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355815; c=relaxed/simple;
	bh=IXf7OaCEeko5i37eEx/0V2OWZm0hqdsVhR6bCTAEggg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J5h3ULZiF/36wwLP07Kun96L9S3g4mz3HFsbyzs6U4svcxiP/4Zl8pJoach1bjr+yLYNybdJ/Hz5wRO2wdzTyv9H/e98MX23aQelhpJ79AECsgzc5Mkfyo4tL/BtKEC6stxMsxj1ggPkTGYusg9kKVt5NxsIUuSMO+1HZb7LjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwYMP21H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D33C2BD10;
	Fri, 14 Jun 2024 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718355814;
	bh=IXf7OaCEeko5i37eEx/0V2OWZm0hqdsVhR6bCTAEggg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RwYMP21HQqQyNsVooWvWJpGf4JNRJhGUkLayh+5ASpySgNQ1Jbi23usndLS4swIVl
	 uXq5elkO/YlfRQSbHiZD41uUD6U774XVNUUBhipQI4AmAGfsqZlBqG/dU4d4EZQUWg
	 EsXI0xCDvZpPedP3ufm6bVOwqw7aklqSwQs7XQgbU5xp+Fhbj1TNJZA/K5r27tLksU
	 rs7dsTmMfeGNZhFp74+RDS++hetdU4FH5lXwoLrGjefK1W4Zach+I+hrHUhGAbdfd9
	 zyOc7xDwfh/yZisIx+qPJTavPNyT53ew/jUQBRxAz7VWYj74qC1WcYib+Uw2ZDeTT6
	 3Z6AKOPWtnRXg==
From: Lee Jones <lee@kernel.org>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
 Dustin Howett <dustin@howett.net>, 
 Stephen Horvath <s.horvath@outlook.com.au>, 
 Rajas Paranjpe <paranjperajas@gmail.com>
In-Reply-To: <20240528-cros_ec-charge-control-v2-3-81fb27e1cff4@weissschuh.net>
References: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
 <20240528-cros_ec-charge-control-v2-3-81fb27e1cff4@weissschuh.net>
Subject: Re: (subset) [PATCH v2 3/3] mfd: cros_ec: Register charge control
 subdevice
Message-Id: <171835581255.3023088.4972914168728771366.b4-ty@kernel.org>
Date: Fri, 14 Jun 2024 10:03:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 28 May 2024 22:04:12 +0200, Thomas Weißschuh wrote:
> Add ChromeOS EC-based charge control as EC subdevice.
> 
> 

Applied, thanks!

[3/3] mfd: cros_ec: Register charge control subdevice
      commit: c353be492fbfe7d1c77af6e18891183141c36f98

--
Lee Jones [李琼斯]


