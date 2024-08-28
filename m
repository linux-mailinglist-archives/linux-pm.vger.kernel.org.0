Return-Path: <linux-pm+bounces-13078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B59896347D
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 00:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE12A1C24072
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2099C1AB526;
	Wed, 28 Aug 2024 22:17:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FF31A76B9;
	Wed, 28 Aug 2024 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883463; cv=none; b=tu+U/k5DYYnZXLX86foMMMKLvW7+YlJj7y/N6MO3/TE2MyTYu22aHPyQ3cYnmQ/XrsOItmfHWXI5mEd7BrsoFhjb1+4doZd00prxVBhM3h2PYO6AjnSrVjakiX36cgW2p+Sj21MLSgy68+IFiXZDsUBGa+8RjzmJUSS2/Lbm8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883463; c=relaxed/simple;
	bh=EkEtp55oPiKBwq3dSyhIslmVS08+3zItAPPERYHr2Ro=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B3idYiSGaRoEHXySIfOPm2ame5yh9uhLcr0fdQj2KlItW52FPiC8/ofCkeTFWw5neJI580D4aZgWQt1Kdwtud9w92WHwoNtg6X3oQ745oInjI9uBvev26hWGVr5XK5IhxGF1x2IF7X7t7F3KvMgP/8HCIZSYT8c8aSwAl6kDPmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0209C4CECA;
	Wed, 28 Aug 2024 22:17:42 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 4ECF6106053B; Thu, 29 Aug 2024 00:17:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240828-power-supply-const-psy_tzd_ops-v1-1-dc27176fda5b@weissschuh.net>
References: <20240828-power-supply-const-psy_tzd_ops-v1-1-dc27176fda5b@weissschuh.net>
Subject: Re: [PATCH] power: supply: core: constify psy_tzd_ops
Message-Id: <172488346031.466860.6298644704120446291.b4-ty@collabora.com>
Date: Thu, 29 Aug 2024 00:17:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.1


On Wed, 28 Aug 2024 20:04:29 +0200, Thomas Weißschuh wrote:
> This struct is never modified, so mark it const.
> 
> 

Applied, thanks!

[1/1] power: supply: core: constify psy_tzd_ops
      commit: 9dad0127ad732f756d056ea152e0b084f321c765

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


