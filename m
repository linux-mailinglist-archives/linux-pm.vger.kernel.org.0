Return-Path: <linux-pm+bounces-19162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FDA9F0083
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 00:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3749188A7DC
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 23:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C18F1DE8A8;
	Thu, 12 Dec 2024 23:51:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5C1547F5;
	Thu, 12 Dec 2024 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734047492; cv=none; b=BLfqNkMiNln0o81eoGgJmKupXcGx7bCX/tVovqfY/dgjy2Mi5Lg4VlBoS/eHfHPD47oeBf4kKNjwK0W90TATuKRs8XtXcsJDkma1CYRWaush0RorhahJa29fDMp+zCwTDUf2/Eh2vIcoxSnsnqEMcd6gkSI/qhy0VLWBm48sjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734047492; c=relaxed/simple;
	bh=1ybgSGhWucWWIY2ZKySK0QljEB2jdFjrquEr5QUgDCU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MiFgot5kcUxb+4NdAUwaF+yDfXqMGEivQDZ6lb8xb+rb7af5dYq0j1fR59pB3c03J49P9X1O8ay66EN0uJJlFXMaEVStBeDTo4qPIheMUzh5ge2GlAZAplVIG+24vGwMAnuL2Q2a2F5o6VIlpnkPzTuRBCdP6A6gsyoEY6lT36w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988C8C4CED0;
	Thu, 12 Dec 2024 23:51:31 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 2FDD210604D3; Fri, 13 Dec 2024 00:51:29 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>, platform-driver-x86@vger.kernel.org, 
 linux-pm@vger.kernel.org
In-Reply-To: <20241211174451.355421-1-hdegoede@redhat.com>
References: <20241211174451.355421-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH v4 0/4] power: supply: Add new "charge_types"
 property
Message-Id: <173404748914.2578176.13866203134576019112.b4-ty@collabora.com>
Date: Fri, 13 Dec 2024 00:51:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 11 Dec 2024 18:44:47 +0100, Hans de Goede wrote:
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

[2/4] power: supply: core: Add new "charge_types" property
      commit: d24bf99214b199c25f9c2cb04b3a4993d1c7ab60
[3/4] power: supply: bq24190_charger: Add support for "charge_types" property
      commit: 5d417a5e7ade02a7b75cd886d8afe3e9025e7e25

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


