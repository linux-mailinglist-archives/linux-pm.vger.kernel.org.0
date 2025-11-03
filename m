Return-Path: <linux-pm+bounces-37277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB69C29B96
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 01:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 990694E32E7
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 00:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2DB23183F;
	Mon,  3 Nov 2025 00:48:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F0221FCC;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130921; cv=none; b=enmqFFdymTC8MVlmZ0UrhN41pz09e2QHfLdfdG6leSjR0C2wDWiZdOIIhb8fnolhJl8bHitWZhxIm5fZGh9Q/mRpvPtbTeGp4dpvcbq4wal/kr0z9eCbbmPTAYLbJEsw2vhMtoF+9BghCawqF7wGnFaPA826AeEDfoHBSBnIlhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130921; c=relaxed/simple;
	bh=T5SKyj/KBZJLYia9w+Z+IRgphx8Opd9vj4VsWxl2ZKk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RkNplQFXEAIpTOmTL4BklreK3hBG+bs1q+ZJncTyGGI/uPGnR4ARaGhk0BdrT5LtNdEy0p6HWE2itIqIv8kfdjC2jOT9Tdv28bgYOL0Vla3l3gTN4XgCb+cHzcLjej/N3VTFLzNtuREZhrFYErcimkUsIKG3lfYxepmUIm+iKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7EBC19422;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 66C111822D8; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 Michal Kubecek <mkubecek@suse.cz>
Cc: Hans de Goede <hansg@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20251015075957.8F40620057@lion.mk-sys.cz>
References: <20251015075957.8F40620057@lion.mk-sys.cz>
Subject: Re: [PATCH] power: supply: use ktime_divns() to avoid 64-bit
 division
Message-Id: <176213091341.301408.15461245832294334915.b4-ty@collabora.com>
Date: Mon, 03 Nov 2025 01:48:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 15 Oct 2025 09:56:31 +0200, Michal Kubecek wrote:
> The build of intel_dc_ti_battery module on i386 (32-bit) fails with
> 
> ERROR: modpost: "__udivdi3" [drivers/power/supply/intel_dc_ti_battery.ko]
> 
> This is caused by 64-bit division of ktime values by NSEC_PER_USEC. Use
> ktime_divns() helper which handles the division correctly on 32-bit
> architectures.
> 
> [...]

Applied, thanks!

[1/1] power: supply: use ktime_divns() to avoid 64-bit division
      commit: 3fd1695f5da0538ef72e1268baa00528b589347a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


