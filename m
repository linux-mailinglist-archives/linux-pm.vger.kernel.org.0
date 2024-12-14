Return-Path: <linux-pm+bounces-19233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B097F9F1C63
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 04:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDCA17A0505
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2024 03:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EA22260C;
	Sat, 14 Dec 2024 03:26:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34829182BC;
	Sat, 14 Dec 2024 03:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734146788; cv=none; b=D0Rm6HObaNGme8bDdokz+Qo3quVz7qu+yLvbTOXSwRhUs4mp2wwFDr1f4BDYZ6ThIZItDBjsR7eU8LDuGOu1rdsOXeYMb3FKB0Qx3aVR7cyq4A3JEVY7c/jFJqcahF778H91M90oke/R+4lFlcQoTnGdRAZHvyqL6T0W2Jmbsn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734146788; c=relaxed/simple;
	bh=iYy3LHaNQhxImeigRAydO3iKMMESZ0sGsu7dVukzIfA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XL2A8fPVuTHu6YEZWor2heflB4krbXw0vs4IwGuy1qDfm5ZILUAQqXGE1vm4V34LxPOvmbqqNwxHIK193tjLRtnF5B0++NVhIoW7gPFiJMYnn4tyJs7hRVVoK/mnMBpYkCvPRppTIM+IvfcV89oB1jAN3YRT/cwZTC7NvARJiPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B95EC4CED0;
	Sat, 14 Dec 2024 03:26:26 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id BF5B210604D3; Sat, 14 Dec 2024 04:26:23 +0100 (CET)
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
Message-Id: <173414678372.2671764.3359449633655016330.b4-ty@collabora.com>
Date: Sat, 14 Dec 2024 04:26:23 +0100
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

[1/4] power: supply: core: implement extension API
      commit: 6037802bbae892f3ad0c7b4c4faee39b967e32b0
[2/4] power: supply: test-power: implement a power supply extension
      commit: 9d76d5de87bbf03c6e483565030b562dc42c7bff

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


