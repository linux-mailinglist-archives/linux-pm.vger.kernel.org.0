Return-Path: <linux-pm+bounces-8666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536DC8FD930
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 23:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A82A1C2219F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 21:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1B21586D7;
	Wed,  5 Jun 2024 21:38:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514543C28;
	Wed,  5 Jun 2024 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623491; cv=none; b=GzI7yTOil9WrpZL/IHZsfJVBHUariP2WxRb33FzfJcFGrrPrao2H5KSpe5+avYsL6cJJCVK5Tqx00NSYCjOI591HjMVkvhvfs8uWGQwYq/A8dcnDQh3hp2bDduJLJ06Is/vmmO+WDLy74QqTXXIm24eyEP0uJojy3bOIhUQUkUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623491; c=relaxed/simple;
	bh=cQYm3Mw/R808OfJeIQymyD9G7C9X3TvWK6oej9UCD1g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EkJ1id0isVgXSbLxXa5HsKuDJRbYeasoFYP6TDTXflGKRznFafXfr8Xv+t3qHCbXzmmy68EbToeuvrpB0WO2UdDndvWP82/nni9WpSKGn0qedWEnFjzJKA3wTAl5YhMv+/WXTLe5EtbmWyymZEiN9xM9mbbox/KHeH7lKKeSrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB4DC32782;
	Wed,  5 Jun 2024 21:38:10 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 04CBB10606D1; Wed, 05 Jun 2024 23:38:08 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Armin Wolf <W_Armin@gmx.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240528222115.791511-1-W_Armin@gmx.de>
References: <20240528222115.791511-1-W_Armin@gmx.de>
Subject: Re: [PATCH] power: supply: hwmon: Add support for power sensors
Message-Id: <171762348800.363491.9701194923808314717.b4-ty@collabora.com>
Date: Wed, 05 Jun 2024 23:38:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 29 May 2024 00:21:15 +0200, Armin Wolf wrote:
> Currently, more than seven power supply drivers are supporting
> POWER_SUPPLY_PROP_POWER_NOW, but their power readings are not being
> reported through the hwmon subsystem.
> 
> Fix this by adding support for power sensors to the power supply
> hwmon integration.
> 
> [...]

Applied, thanks!

[1/1] power: supply: hwmon: Add support for power sensors
      commit: ad175de1f8da6043553dec4402fc1ff28494ac7b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


