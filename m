Return-Path: <linux-pm+bounces-5733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B92E892DF8
	for <lists+linux-pm@lfdr.de>; Sun, 31 Mar 2024 00:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937251F21A81
	for <lists+linux-pm@lfdr.de>; Sat, 30 Mar 2024 23:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278BF446AE;
	Sat, 30 Mar 2024 23:01:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABC742AA0;
	Sat, 30 Mar 2024 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711839703; cv=none; b=mNZeKHIJISYF0qfhDypFumDWJ4iiACaPMl+3H7nzNTE/JeJ54Z5jBjRdzjcCWap4dpt1cEI1WQQ16H3fZbI2I88Sz/ZC30NuRZooGODn31G3048hYchvp3IP+fsBvICg61nnO5N/acUnR0SumInw7nqWdylBXFYjLiWRxZC+UVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711839703; c=relaxed/simple;
	bh=s2fZIERPWen68T7ai0Hbcm9HxnhK2N1NdJbuq3jQgm0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a7M5UJgkz9CGZA/Vr2hDTdu6L/VIyzs7xqMWxGy+1/OYz3qH3JP7iRcsz31bw1P3GsP0NhkWd8YPRfD4b/fLoXudEEF32XBqom59lnNLxNpsJ9L1FxkT0I7LkEM2g3ne/go9OnpOANJkPq4rnmJZWeSzZ6JpENdOd/BHwJo+A/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2C3C433C7;
	Sat, 30 Mar 2024 23:01:42 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id B7FE310608D9; Sun, 31 Mar 2024 00:01:39 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240329-power-supply-simplify-v1-1-416f1002739f@weissschuh.net>
References: <20240329-power-supply-simplify-v1-1-416f1002739f@weissschuh.net>
Subject: Re: [PATCH] power: supply: core: simplify charge_behaviour
 formatting
Message-Id: <171183969971.480547.16599196216072730255.b4-ty@collabora.com>
Date: Sun, 31 Mar 2024 00:01:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Fri, 29 Mar 2024 09:18:29 +0100, Thomas Weißschuh wrote:
> The function power_supply_show_charge_behaviour() is not needed and can
> be removed completely.
> Removing the function also saves a spurious read of the property from
> the driver on each call.
> 
> The convulted logic was a leftover from an earlier patch revision.
> Some restructuring made this cleanup possible.
> 
> [...]

Applied, thanks!

[1/1] power: supply: core: simplify charge_behaviour formatting
      commit: 91b623cda43e449a49177ba99b6723f551a4bfbe

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


