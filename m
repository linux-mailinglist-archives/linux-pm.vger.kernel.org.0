Return-Path: <linux-pm+bounces-18592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B35A9E4BE4
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 02:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3FE188163C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 01:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D4D15B980;
	Thu,  5 Dec 2024 01:36:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01E912FB0A;
	Thu,  5 Dec 2024 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733362615; cv=none; b=ENi8LfY/Yn1Lbs1h4w9ADv0WHP78Eifmj3gvj7Uv/RNnj/tEZc08f4punFmEc3KRMQlwf5G/0yRP4CgXUpllGkCfPuZoxg/nFdmJkC+YFjwtdp36JyolX0Xw/EYZ5MzN5Akgs1OtkdNxh554pBYya7XssKqXOWoQ8i3vZVKZ4Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733362615; c=relaxed/simple;
	bh=uC333v///R86zgdnakjesizE+9f7QIveEIV6QL14mLY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BW8kJBFJ7/Ivo60I/oyYhlklHYOY07lkNG6pawqhfk5ewJGjtK6FoAuXIUppb+yGRt5p8LVcEKq/Ac7TFVigVMtAmWWRdShv/lDNAnaLpJzEMgIpWkGjualMR0BU/02p+3l9HGa7oILjk5lBZ1la8RT6RM8z/d1s3djtJGPgsaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF55C4CECD;
	Thu,  5 Dec 2024 01:36:55 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 8D45A1060502; Thu, 05 Dec 2024 02:36:52 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev
In-Reply-To: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
Subject: Re: (subset) [PATCH v4 0/9] power: supply: extension API
Message-Id: <173336261256.1429662.14253916757159348513.b4-ty@collabora.com>
Date: Thu, 05 Dec 2024 02:36:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Mon, 11 Nov 2024 22:40:02 +0100, Thomas Weißschuh wrote:
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

[1/9] power: supply: sysfs: print single value in uevent for POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
      commit: 31d8440e07704d53041936222728636421957660
[2/9] power: supply: core: rename psy_has_property() to psy_desc_has_property()
      commit: 172f2151c2b436746173d794887115e026961d82
[3/9] power: supply: core: introduce power_supply_has_property()
      commit: aa40f37d636570458e1be76f51564357347eb77c
[4/9] power: supply: hwmon: prepare for power supply extensions
      commit: 39bb32f06c1f7eb34b4a9838e878f3d741b7d50c
[5/9] power: supply: sysfs: prepare for power supply extensions
      commit: 5c2141f2c7c671e8696e2ee1c7b332c77266dd08
[6/9] power: supply: sysfs: rework uevent property loop
      commit: f29a749d01dc136ee6e08afafebbccc389ef5b05

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


