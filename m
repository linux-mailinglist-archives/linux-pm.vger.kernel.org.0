Return-Path: <linux-pm+bounces-40628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 011ACD104E8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 02:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE74930B8FD4
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 01:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2917923E350;
	Mon, 12 Jan 2026 01:56:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D31A724C;
	Mon, 12 Jan 2026 01:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182977; cv=none; b=DjrdplQ2WyDMsv8HlK2Tll8XqOXJ/ztjgt4oJTqqHWfH/jWzLYXntYH82ryBk0cMr5cJlhEQ+uA0icmPDnaucsMIuwffVCK6D++pkZwl74l6t4o00LFtciAL3bDG4TMVUMN+eIbhDuUAk81iJEmUGc7a4z5ScZ5DSuc44vOGefE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182977; c=relaxed/simple;
	bh=9clN++4Z4iquPbDAcNzpXt4fUsMtmuB7a52J4o4Rzic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GRF9TdNJAe07ZJj7tt226CJM0KDYzr1wD64uWeaEDdLFvjyRl0TtOV0S1sbVE0tCQ+8Kd2nPJQ+j1GBTDERt0jhKMAiYxwXHNTI/ZQX8fitfzyGZHuJiWAF9/9q7fd0f5wxiPRrhOJL4aeUFmiiKrkzjG4hyMdjvtJ75YUcmMlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E4BC2BCB2;
	Mon, 12 Jan 2026 01:56:08 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 2C11B180749; Mon, 12 Jan 2026 02:56:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Anton Vorontsov <avorontsov@ru.mvista.com>, 
 Marek Vasut <marek.vasut@gmail.com>, Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1766270196.git.waqar.hameed@axis.com>
References: <cover.1766270196.git.waqar.hameed@axis.com>
Subject: Re: (subset) [PATCH 0/3] power: supply: wm97xx: Fix NULL pointer
 dereference in power_supply_changed()
Message-Id: <176818296417.643060.10579242574378526613.b4-ty@collabora.com>
Date: Mon, 12 Jan 2026 02:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 20 Dec 2025 23:46:24 +0100, Waqar Hameed wrote:
> The majority of the drivers in `drivers/power/supply/` do the right
> thing when registering an interrupt handler and the `power_supply`
> handle; namely making sure that the interrupt handler only runs while
> the `power_supply` handle is valid. This driver requests the IRQ a
> little too soon, and this can lead to a nasty NULL pointer dereference
> as thoroughly explained in the commit message. This patch series also
> contains some other related clean-ups that makes life a little easier.
> 
> [...]

Applied, thanks!

[1/3] power: supply: wm97xx: Fix NULL pointer dereference in power_supply_changed()
      commit: 39fe0eac6d755ef215026518985fcf8de9360e9e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


