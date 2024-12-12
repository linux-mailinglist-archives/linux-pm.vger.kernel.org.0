Return-Path: <linux-pm+bounces-19082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 406749EDD8A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 03:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61575167ABB
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 02:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5835139D1B;
	Thu, 12 Dec 2024 02:22:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977082A1CA;
	Thu, 12 Dec 2024 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970178; cv=none; b=AspF2fW8ndNDdwCnU9HlXQGmfOstdwCUtrZ9qZoXn1s9ULV0gGrfj6XHIVSJrGVOEW78q98AfUX2ng1a5iuraMZvxz61ylWnL2sMDRTOrey3DZ3Y368j7m/+BzxnyX/lnYOrOTI0RE7YUvb6Mdo1ruPvRWbgqmOPm0n2EmUWW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970178; c=relaxed/simple;
	bh=SU/plzE6Atz9+STwldqjyTGEzMW6oxK3s0wQut82/Ao=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HH7T8ZnJXOFVMlF4bJNCAN7/Gc8GLyJzLAU3yCErUCS5ZQ6asO99awQA21/sZU8izjma8HVjUhniiY4ZtrB2mdK4d+2w0VSPVexPeQTcMItBIXE6I3HQpUjjNxGFfcBYCVuxCKXMWrc958FC5a++ktlUZm9Wayip/mVzwGo0Q74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169ADC4CED7;
	Thu, 12 Dec 2024 02:22:58 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 5DFA710604D3; Thu, 12 Dec 2024 03:22:55 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: platform-driver-x86@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Jelle van der Waa <jelle@vdwaa.nl>, linux-pm@vger.kernel.org
In-Reply-To: <20241209204051.8786-1-hdegoede@redhat.com>
References: <20241209204051.8786-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH v3 0/4] power: supply: Add new "charge_types"
 property
Message-Id: <173397017536.2463564.3345585197096702799.b4-ty@collabora.com>
Date: Thu, 12 Dec 2024 03:22:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 09 Dec 2024 21:40:47 +0100, Hans de Goede wrote:
> As first discussed here:
> https://lore.kernel.org/linux-pm/49993a42-aa91-46bf-acef-4a089db4c2db@redhat.com/
> 
> Some power_supply devices have a writable charge_type property, but
> userspace cannot know which charge_type values are valid to write.
> 
> This series adds a new "charge_types" property, which is identical to
> "charge_type" but reading returns a list of supported charge-types with
> the currently active type surrounded by square brackets, e.g.:
> 
> [...]

Applied, thanks!

[1/4] power: supply: power_supply_show_enum_with_available(): Replace spaces with '_'
      commit: cc4c34577dbc17729b7e3f1266cf12d043e8c170

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


