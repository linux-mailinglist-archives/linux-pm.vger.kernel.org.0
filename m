Return-Path: <linux-pm+bounces-35009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5275AB874C5
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 00:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB061C2849A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 22:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2552D2FFF98;
	Thu, 18 Sep 2025 22:59:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C042FB625;
	Thu, 18 Sep 2025 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236349; cv=none; b=KOylEXvuNsI8uKps61ckHxvIOe0gIND3B5PPLpKV6NJ2U28ktmLhHEHvKUP8a/KR+8PyFySDcJXJEye0lNWjdWhITl5xjmUCodV7qtmMyLv0WNjYlUMXHuiKYfbYZbRrDdtoB7s27n+2Fd+e5Bwy2Tsy4Yg60j0oOmF9CzE6EJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236349; c=relaxed/simple;
	bh=TGZzHEBYHoKrNBn5m+9BHTZWquR2CTlAeKhr1gzv0Qg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PEeqpDTawEyt6ZRRQL+SQSgWDGbU59+fQFMTX4TUOt7btTDPVUHzVKBy8k7ORIjqu3IxcDwfqlfFvWZ2z8wtM9U80nsAQxD4qPy7vwNnu74T0PTtoDI5BCDSa1I9CoIgoGEDeYZ2ScfEbD89JcPSHgFsJ73JI5Y1LamO2WcxFqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33461C4CEE7;
	Thu, 18 Sep 2025 22:59:08 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 7F000180F75; Fri, 19 Sep 2025 00:59:03 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
References: <20250918-max77705_77976_charger_improvement-v4-0-11ec9188f489@gmail.com>
Subject: Re: (subset) [PATCH v4 0/9] power: supply: fixes and improvements
 for max77(705,976) chargers
Message-Id: <175823634349.118465.5407942243669595492.b4-ty@collabora.com>
Date: Fri, 19 Sep 2025 00:59:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 18 Sep 2025 20:06:44 +0300, Dzmitry Sankouski wrote:
> This series consists of:
> - max77705: interrupt handling fix
> - max77705: make input current limit and charge current limit properties
>   writable
> - max77705: add adaptive input current limit feature
> - max77705: switch to regfields
> - max77705: refactoring
> - max77976: change property for current charge limit value
> 
> [...]

Applied, thanks!

[1/9] power: supply: max77976_charger: fix constant current reporting
      commit: ee6cd8f3e28ee5a929c3b67c01a350f550f9b73a
[2/9] mfd: max77705: max77705_charger: move active discharge setting to mfd parent
      commit: c24928ac69be2390cdf456d126b464af079c57ef
[3/9] power: supply: max77705_charger: refactoring: rename charger to chg
      commit: d84510db8c1414b67167cdc452103c1f429588cc
[4/9] power: supply: max77705_charger: use regfields for config registers
      commit: ef1e734dbe257ce8bc42383b9977b5558f061288
[5/9] power: supply: max77705_charger: return error when config fails
      commit: 55af7b9bb66c1cf796142f75a76914e2c3df5d06
[6/9] power: supply: max77705_charger: add writable properties
      commit: baedd8be7036233025527a78f209e34d03057872
[7/9] power: supply: max77705_charger: rework interrupts
      commit: 12a1185a06e3377af777e792ba7436862f8e528a
[8/9] power: supply: max77705_charger: use REGMAP_IRQ_REG_LINE macro
      commit: bc7d3a0f92dad811110f5602f58fe756cefce2b8

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


