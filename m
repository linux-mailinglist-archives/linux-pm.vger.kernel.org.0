Return-Path: <linux-pm+bounces-15804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E09D99A1506
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 23:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA6A0B246E6
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 21:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E381D318F;
	Wed, 16 Oct 2024 21:41:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532841D2B39;
	Wed, 16 Oct 2024 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114919; cv=none; b=X/uDvy8a6sAh9dcAhtGhGGW68fmKnY3XFSIKcdT9FDnTe+mAAn0bPqibi3ENevQnHBcKtptzQPx8l61iaYSn5aotiM4OheoIinsLYPX4d/01xdXzfPukCHDG99x7B3gNZE9GnlcU6gNLFq6fap9d3Fn586J9zQTIfqwW0pWFbEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114919; c=relaxed/simple;
	bh=wIyJk825vxE1cB6sJzT4gQT3wkEZCWbDwEm4otlzDjs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TaN3pD+2vNGJBu3TYfWCQuIzV1U3HV3WTaSBIaL9yWec7Q4NEzOOFJCcMF+9zYPP1rd/dXE/zLdghoO6Mp9yhaXl0MiIe6fxmXnBEU7aQnJSm/hc+sYe7BMsqvbM4yAavpHz5XsaAzpHPYJO7OmRbeK6ObBP5pyYMHRum+yuFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2643C4AF09;
	Wed, 16 Oct 2024 21:41:58 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 4DDDE106045D; Wed, 16 Oct 2024 23:41:56 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241005-power-supply-cleanups-v1-0-45303b2d0a4d@weissschuh.net>
References: <20241005-power-supply-cleanups-v1-0-45303b2d0a4d@weissschuh.net>
Subject: Re: (subset) [PATCH 0/4] power: supply: core: random cleanups and
 optimizations
Message-Id: <172911491630.630785.7870261570020412690.b4-ty@collabora.com>
Date: Wed, 16 Oct 2024 23:41:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Sat, 05 Oct 2024 12:06:14 +0200, Thomas Weißschuh wrote:
> Some independent cleanups and optimizations.
> 
> 

Applied, thanks!

[1/4] power: supply: core: use device mutex wrappers
      commit: bd3ee57b9d4c58edbf6f7bba071f6e508c7ff1c6
[2/4] power: supply: core: unexport power_supply_property_is_writeable()
      commit: cf70da29c4993bf23df68b67a82dfa3da8234e75
[3/4] power: supply: core: mark attribute arrays as ro_after_init
      commit: 3120b5f218ca8e2b375d496e2ff3f4f861fbc013

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


