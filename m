Return-Path: <linux-pm+bounces-37275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CFDC29B87
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 01:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 323C94E7542
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 00:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE3C2264CB;
	Mon,  3 Nov 2025 00:48:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9413221DB4;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130920; cv=none; b=YNA7lUj47Oj5kSnwvQpdHFb5bpsXK5fKVq8U30HYrotUcMukdZTH38o7FGUinIv4mSnENwvgfMyY3Ybmr2AKPcUQbuusqxIoI+kfisdkSqgj96j0nXXmUUYvFK3N5expesJW7IwuLvyaCkmglppSkIuAsIayFEP5zSWYQFtk550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130920; c=relaxed/simple;
	bh=nOFN6vfcMqilST2zNVsxQcVLExMZvz9mpz5z12p8XFE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ftWl5X6UtfmLYxBqfamArcgGifK3hR/iGGG60anm7dTJ0eNzQxShNrqKOcs0tXu/bkaQtVYTsZToE1AtaEgzl4L/jYnmr2S+N1M4DzOZzCzKqgPLVxiS8zZFmx5y8MEOkYFIelmKNIDmV4RpVB05Zn40uZwy0amFtlM5J4RwswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EE3C19421;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 4E67318157B; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Murad Masimov <m.masimov@mt-integration.ru>
Cc: ChiYuan Huang <cy_huang@richtek.com>, ChiaEn Wu <chiaen_wu@richtek.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <20251009145308.1830893-1-m.masimov@mt-integration.ru>
References: <20251009145308.1830893-1-m.masimov@mt-integration.ru>
Subject: Re: [PATCH] power: supply: rt9467: Prevent using uninitialized
 local variable in rt9467_set_value_from_ranges()
Message-Id: <176213091331.301408.12846671531653101740.b4-ty@collabora.com>
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


On Thu, 09 Oct 2025 17:53:08 +0300, Murad Masimov wrote:
> There is a typo in rt9467_set_value_from_ranges() that can cause leaving local
> variable sel with an undefined value which is then used in regmap_field_write().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 

Applied, thanks!

[1/1] power: supply: rt9467: Prevent using uninitialized local variable in rt9467_set_value_from_ranges()
      commit: 15aca30cc6c69806054b896a2ccf7577239cb878

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


