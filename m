Return-Path: <linux-pm+bounces-4530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF16786BA8F
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 23:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F60DB22823
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 22:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D3B1361B7;
	Wed, 28 Feb 2024 22:08:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3A1361B5;
	Wed, 28 Feb 2024 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158136; cv=none; b=SjoeDubgVM2WJxwlTVCZFWjtEZK2XnFX4SR4xTuBcPegwcc9oVcdbvMwB/U0Ai5rj3rTq8V889NRxlwBIuhDVxwoE5+/cMCONR0CjZvOqUEI0huHwxyQ6I5+RWZxKLr+7hkQykVX/qKELyelrzKQ1nlcQXOw2YH6KkUxs5kess4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158136; c=relaxed/simple;
	bh=PfymlF7wlCOlT9tf+m4N9IdC5oUXuI/3KCzManRYmOA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KWqXdtJMTfg3ICiBoSDR8QGG0fFi3OcRD0uKzKw3fjcuNTwdNxqhORsEnfS0YYS/xduDLbH+uwJIHXRBH4MMmxhB4lE9gVPlSZ9gF2IvLLJx2FhAuQ11noXaaSnmsExBVIrwwdiqg0KdVLHVrC+rE3H1xZSJsVf2mgKicnhhY3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B09DC433F1;
	Wed, 28 Feb 2024 22:08:56 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 5C2DC1067A0C; Wed, 28 Feb 2024 23:08:53 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, ricardo@marliere.net, linux-pm@vger.kernel.org, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
In-Reply-To: <20240227-fix-power_supply_init_attrs-stub-v1-1-43365e68d4b3@kernel.org>
References: <20240227-fix-power_supply_init_attrs-stub-v1-1-43365e68d4b3@kernel.org>
Subject: Re: [PATCH] power: supply: core: Fix power_supply_init_attrs()
 stub
Message-Id: <170915813332.50142.14586523550606175263.b4-ty@collabora.com>
Date: Wed, 28 Feb 2024 23:08:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 27 Feb 2024 13:34:42 -0700, Nathan Chancellor wrote:
> When building without CONFIG_SYSFS, there is an error because of a
> recent refactoring that failed to update the stub of
> power_supply_init_attrs():
> 
>   drivers/power/supply/power_supply_core.c: In function 'power_supply_class_init':
>   drivers/power/supply/power_supply_core.c:1630:9: error: too few arguments to function 'power_supply_init_attrs'
>    1630 |         power_supply_init_attrs();
>         |         ^~~~~~~~~~~~~~~~~~~~~~~
>   In file included from drivers/power/supply/power_supply_core.c:25:
>   drivers/power/supply/power_supply.h:25:20: note: declared here
>      25 | static inline void power_supply_init_attrs(struct device_type *dev_type) {}
>         |                    ^~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] power: supply: core: Fix power_supply_init_attrs() stub
      commit: b683d738c0a1c4c8fcf83fdf5eb4c6ce3d5130c6

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


