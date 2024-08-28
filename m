Return-Path: <linux-pm+bounces-13080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FAE963480
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 00:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4363285565
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E461AD40E;
	Wed, 28 Aug 2024 22:17:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FBE1AC8A9;
	Wed, 28 Aug 2024 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883463; cv=none; b=D1aZTKgyZ5xUKd5/E8jDHC/GKAZeLGHu32bV9NBfhxml+HrWGQFUyavyWuarknLCW0ANLh2j357l+OyxS1jxZIog/fCD/+/UQW+foTc2YVbaB8HJTCZQGb+CZOQecqhT4PFDHTr9fp1BkWgQPJC9+O885pMPR31BtgFDNkbrTzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883463; c=relaxed/simple;
	bh=lpJbHZspsQiMJ6ieepbT9T5dQRIu+DZnhhP+O9BlYsg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qp1ASjSovSd4DxN72G5HkrfP7SULNZzg1YM4jrEFU5AuR+Sm6Lt/NeSt+lScT/aGOJ8p5mKxPewAorQzGe89mim1miUD/OPKYWwVP45C7F4VnpIsrlDNveVPxTdsQXiBsmvGX4gsG55vS+FkebNG3KdHj93IkrMjyzEfrnkaQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71F0C4CEC0;
	Wed, 28 Aug 2024 22:17:42 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 4C1CA1060535; Thu, 29 Aug 2024 00:17:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, Andrew Davis <afd@ti.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240610142836.168603-1-afd@ti.com>
References: <20240610142836.168603-1-afd@ti.com>
Subject: Re: [PATCH 1/5] power: reset: brcmstb: Use normal driver register
 function
Message-Id: <172488346030.466860.4956050651307556387.b4-ty@collabora.com>
Date: Thu, 29 Aug 2024 00:17:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 10 Jun 2024 09:28:32 -0500, Andrew Davis wrote:
> The platform_driver_probe() helper is useful when the probe function
> is in the _init section, that is not the case here. Use the normal
> platform_driver_register() function.
> 
> 

Applied, thanks!

[1/5] power: reset: brcmstb: Use normal driver register function
      commit: 0174d12f9b7ebc83f1f2b6c25f05304104de5a91
[2/5] power: reset: brcmstb: Use device_get_match_data() for matching
      commit: cf37f16a60f332fad21fe0a45893ac4c6a825d9d
[3/5] power: reset: brcmstb: Use syscon_regmap_lookup_by_phandle_args() helper
      commit: a4ceaab660cabdc9ac2d2514a809174443209b3b
[4/5] power: reset: brcmstb: Use devm_register_sys_off_handler()
      commit: ad87aee5cba821066be99c76efd818368ff5bb4a
[5/5] power: reset: brcmstb: Do not go into infinite loop if reset fails
      commit: cf8c39b00e982fa506b16f9d76657838c09150cb

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


