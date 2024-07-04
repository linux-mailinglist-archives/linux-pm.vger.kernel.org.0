Return-Path: <linux-pm+bounces-10598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29963927442
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 12:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEEA1C239D3
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 10:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E351A08C0;
	Thu,  4 Jul 2024 10:44:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B6A14B964;
	Thu,  4 Jul 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089850; cv=none; b=rbLxEghQWw9RvvnLMHKoMoOBbarAwBm2CCr5uVlHQTkWsNYXzgAwEoqIcwYMYqmFG/y4Ytm0Rf3x5Emj2ZF2gHeKBIANMAtGEhY3xucd7X+KIoBT0/BQE19ETZ5jCDDhT3CPhWHuyezD/Fm9HjsJ858naKY2pw+XiAQewRVsQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089850; c=relaxed/simple;
	bh=Eb390m/j8bz7Wm70Is4X8JRJP2NhHtMFSdGTGOCa5Yo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SVK8O4AiS6BowxZoS+UKwrVXnVjvTTET9XHeomktXhYJtn9JO3QMI7FoDpTa9NiZgbQYpO1+h/dku+b+BNFiedZ0m2qo3TsC0oQVo44u3/ANq62bh471mQaLsficvZUc7ZFzNGLO4do8Zi3bRaFQmNo7nHhIFUb3+Wxy3Qzf7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AB8C3277B;
	Thu,  4 Jul 2024 10:44:09 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 9C959106066C; Thu, 04 Jul 2024 12:44:06 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net>
References: <20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net>
Subject: Re: (subset) [PATCH RFC v2 0/5] power: supply: extension API
Message-Id: <172008984662.82956.11434564615076901549.b4-ty@collabora.com>
Date: Thu, 04 Jul 2024 12:44:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Sat, 08 Jun 2024 21:19:36 +0200, Thomas Weißschuh wrote:
> Introduce a mechanism for drivers to extend the properties implemented
> by a power supply.
> 
> Motivation
> ----------
> 
> Various drivers, mostly in platform/x86 extend the ACPI battery driver
> with additional sysfs attributes to implement more UAPIs than are
> exposed through ACPI by using various side-channels, like WMI,
> nonstandard ACPI or EC communication.
> 
> [...]

Applied, thanks!

[1/5] power: supply: sysfs: use power_supply_property_is_writeable()
      commit: be6299c6e55e971ffc060495708740a59aa0e45b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


