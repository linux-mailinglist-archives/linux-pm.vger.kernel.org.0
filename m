Return-Path: <linux-pm+bounces-29210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2991AE2D8B
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 02:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAB81716F3
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 00:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E50139D;
	Sun, 22 Jun 2025 00:10:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9210E9
	for <linux-pm@vger.kernel.org>; Sun, 22 Jun 2025 00:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750551051; cv=none; b=PUqKxAhJYZslegXQaWa5AY02Ezf1K68+oNdw+XPS1MeLelRC2ISk75v+xya2Hin4y2HL3FH876AU9FsQz/rKX2EJwWqcIw2aiAugzxNVo2yX2XFsz4k1PEQOciurIHNfBUmmyuI4JV37eaivHgS5PC+f2xQQOAa3RdJHpjktVNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750551051; c=relaxed/simple;
	bh=qC4UilLZrGkX5GUY1WiyV8YeS9dRPLkvG8EjNg1o0LU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HhM7+WmSLOCElpM6pxR3A9SUE36wjf9x72djxHUp8Ysue9M5HiZbunZky32KSqUjHzeTX5VakUzG8FBUL6ij20zldvIMrW7RRZe+cSx8U1qAXNg8lP3jOYe913+JPVhB9PlQ78PYxcMZrM5HxdrrVXePZ/5v++MbYusWzHAPtG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28443C4CEF1;
	Sun, 22 Jun 2025 00:10:51 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id E3A4A180F96; Sun, 22 Jun 2025 02:10:48 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org
In-Reply-To: <20250608204010.37482-1-hansg@kernel.org>
References: <20250608204010.37482-1-hansg@kernel.org>
Subject: Re: (subset) [PATCH 00/10] power: supply: ug3105_battery: Switch
 to power_supply_batinfo_ocv2cap()
Message-Id: <175055104892.226297.388983002573981633.b4-ty@collabora.com>
Date: Sun, 22 Jun 2025 02:10:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 08 Jun 2025 22:40:00 +0200, Hans de Goede wrote:
> This series converts the ug3105_battery driver from using
> a static ovc - capcity mapping table + its own DIY code to using
> the ovc-capacity-table(s) from the battery fwnode and using the
> power_supply_batinfo_ocv2cap() helper.
> 
> Since the ug3105_battery driver is used on ACPI platforms this relies
> on sre's "[PATCH v2 0/5] power: supply: core: convert to fwnode" series
> for completenes sake I've added a copy of that series + 2 fixup patches to
> "[PATCH v2 3/5] power: supply: core: battery-info: fully switch to fwnode",
> the original patches are unmodified.
> 
> [...]

Applied, thanks!

[08/10] power: supply: ug3105_battery: Use psy->battery_info
        commit: 8842bd00a74bf758fb1abf572ec1c7d70c09dedb
[09/10] power: supply: ug3105_battery: Switch to power_supply_batinfo_ocv2cap()
        commit: 2986e5b213cd84ac290ae68e73b7629ec8f184a6
[10/10] power: supply: bq24190: Free battery_info
        commit: 6aa1c3a72b99abeb7ddc649047073d701ede2c91

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


