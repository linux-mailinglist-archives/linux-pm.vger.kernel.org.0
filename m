Return-Path: <linux-pm+bounces-19239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE379F2113
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 23:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267AA166ABD
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 22:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597AD1B0F20;
	Sat, 14 Dec 2024 22:04:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31688101DE;
	Sat, 14 Dec 2024 22:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734213849; cv=none; b=H5+mbq89lMQ13AadPT5CAEXtwHrS0YhKPY/Um16xsb8zdf8WKtaPsz3lFsIDvtMJpZyRAMUQzPFQgk+6Cl0PbI+1U7t605IBMPtn1RYek4+wBZcWSpLAElOoZAszn+9hUuOqPSjxB3NCOQPq2vRPajeQ5aYem5Gk6+16Osuev58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734213849; c=relaxed/simple;
	bh=eM600mWZ4a7iJiNFgjD5YBQLfn+RzL8RVxRXZxMdK/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QE5deIyPApoyJgzJ/rtytlXrYy7JvT7r0LZG5ez0KEoVww5bOcywudZebT2+OSleL+YHWZ9XpX0eB12TR23F4UoM/FWCXwXtIqP4p81ToiNg+YBt1j6vX6uEeSUjtseTr65kYzj0rry10T2pbTR3j1HiyUH2n4r7kv6qAC9RiLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973DEC4CED1;
	Sat, 14 Dec 2024 22:04:08 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id EA5A710604B1; Sat, 14 Dec 2024 23:04:05 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-pm@vger.kernel.org
In-Reply-To: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
References: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
Subject: Re: (subset) [PATCH v6 0/4] power: supply: extension API
Message-Id: <173421384589.2755040.15453506845982357839.b4-ty@collabora.com>
Date: Sat, 14 Dec 2024 23:04:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Wed, 11 Dec 2024 20:57:54 +0100, Thomas Weißschuh wrote:
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

[4/4] power: supply: core: add UAPI to discover currently used extensions
      commit: 288a2cabcf6bb35532e8b2708829bdc2b85bc690

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


