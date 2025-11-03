Return-Path: <linux-pm+bounces-37269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78351C29B5A
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 01:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 714A54E3134
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 00:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A882618DB2A;
	Mon,  3 Nov 2025 00:48:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D02A1465B4;
	Mon,  3 Nov 2025 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130918; cv=none; b=cCH0gr3z5QH0tCu7dv2C5SAxywpcdH5fhlEZaks8DiuotHQJ8b5F/8U5+NvLmBdMXGkmSAOe/cBSxORxvrpGpdQnn8UdubCIEs6PocFIxLe+5f31JQF+eHZjjaL3If4eH/ijjzQ52G6KlJxbf8kG7xdbhKupzPnKM4kL357ozsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130918; c=relaxed/simple;
	bh=2RPmo9wPrQ44L75Ktc/u/44O4tw1ecrQD5bk3TeacgA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tpz+zdFl2LVwqQKe9tcWZQRgCzA4Jp4yuaIvby+3ikzvIiCpLtkLkNpgerZcHMpU6WTt/pJ9rn/GGxkTnws4GTFdGCCqwOBHRH6LKALErJKtuNLt7sfPMn+kFREl2iuLc08hJvQa07TOOupCU1M0FUCmCaFeBhBNXztkxsAFxew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D217FC4CEFB;
	Mon,  3 Nov 2025 00:48:37 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 35FB6180CB6; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Andreas Kemnade <andreas@kemnade.info>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250918-bd71828-charger-v5-0-851164839c28@kemnade.info>
References: <20250918-bd71828-charger-v5-0-851164839c28@kemnade.info>
Subject: Re: (subset) [PATCH v5 0/3] power: supply: add charger for BD71828
Message-Id: <176213091320.301408.17517885463599490632.b4-ty@collabora.com>
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


On Thu, 18 Sep 2025 09:45:08 +0200, Andreas Kemnade wrote:
> Add basic charger which does just read out simple registers without
> doing any sophisticated things.
> 
> This is a stripped down version of
> https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.1637061794.git.matti.vaittinen@fi.rohmeurope.com/
> 
> That version includes all the bells-and-whistles you might imagine
> around coloumb counter handling and capacity measurement which includes
> changes no the power supply core.
> Rather do a step by step approach to keep that reviewable.
> 
> [...]

Applied, thanks!

[2/3] power: supply: Add bd718(15/28/78) charger driver
      commit: 5bff79dad20a51fed3ff6d78f6b60321cd145a99
[3/3] MAINTAINERS: Add entry for BD71828 charger
      commit: b838cecc229122559b3e2e381a9275f714bd4146

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


