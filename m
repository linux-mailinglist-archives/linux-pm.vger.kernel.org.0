Return-Path: <linux-pm+bounces-13474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECBC96AAB5
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 23:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80278B220BC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 21:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286811D2230;
	Tue,  3 Sep 2024 21:58:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059701CB52A;
	Tue,  3 Sep 2024 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400681; cv=none; b=crbR/TzPUT+IQPp/QKjzwTYon485jlIVPYL5PGKpT34GUfIiegLM3p4xg3GnasTpXoItBb75JqoVGHWnWmwgHe5CXxBvd1osiJcrvR9Kf82oBNnCoGO3uJm7cDR9f4IMdt0kXMUk/aKnDiLzku+PyN/pUIcS9goh82piBGsGrgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400681; c=relaxed/simple;
	bh=7ay6BnCa/B67NWwvPBMg48FH7M8hObG2QEGAY191p0M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gINBOjOHXDL2+gLTd2aL1D5/yuaUbsD8mGQ0tqHA5msacrFjlAdsYmpOZ5li7p5Mhx6kfpuepSpZLh26YwHLAgY8e3E4uAuMRFCAhJpfgQfbhmHptltauZ56BaTukEMXKq++ASJtxkjalHFa+oFgLz/jJXo6OIVE57taBaKgrQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF40C4CEC5;
	Tue,  3 Sep 2024 21:58:00 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 37B6B10604AA; Tue, 03 Sep 2024 23:57:58 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-phy@lists.infradead.org, 
 Enric Balletbo i Serra <eballetbo@kernel.org>
In-Reply-To: <20240831142039.28830-1-hdegoede@redhat.com>
References: <20240831142039.28830-1-hdegoede@redhat.com>
Subject: Re: [PATCH 0/6] power: supply: Change usb_types from an array into
 a bitmask
Message-Id: <172540067821.972525.3472424402904819549.b4-ty@collabora.com>
Date: Tue, 03 Sep 2024 23:57:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Sat, 31 Aug 2024 16:20:33 +0200, Hans de Goede wrote:
> When support for the "charge_behaviour" property was added the list of
> available values was made a bitmask in power_supply_desc.
> 
> "usb_types" is very similar in that:
> 1. It is an enum
> 2. The list of available values is stored in power_supply_desc
> 3. When shown it shows all available values, with the active one surrounded
>    by square brackets.
> 
> [...]

Applied, thanks!

[1/6] power: supply: "usb_type" property may be written to
      commit: 0d9af1e1c93b6a89f3fb6dcbafa5bc78892cb94f
[2/6] power: supply: ucs1002: Adjust ucs1002_set_usb_type() to accept string values
      commit: 83a4c42df75e8f6ff671fa9fbe7d4c79b98626de
[3/6] power: supply: rt9467-charger: Remove "usb_type" property write support
      commit: 03ec41c1670aedfbd126f541c4acbb8e69d4cd0c
[4/6] power: supply: sysfs: Add power_supply_show_enum_with_available() helper
      commit: a6456d43e9abebb5d7866e5edae3024188273306
[5/6] power: supply: sysfs: Move power_supply_show_enum_with_available() up
      commit: 322900ac7d82be0475466f81946b6484cd1936bd
[6/6] power: supply: Change usb_types from an array into a bitmask
      commit: 364ea7ccaef917a3068236a19a4b31a0623b561a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


