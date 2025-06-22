Return-Path: <linux-pm+bounces-29233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A150AE31A7
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 21:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFB63AF176
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 19:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97A81FCF78;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97F71F9ED2;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750619599; cv=none; b=MbZGBq9pyvfdnaGUOuADkBr3vWCkarW2a2iQlQZjaWbUWmD0YXbGAP1XQGyKsyJMenyaei23uQFTjaV7gtNiv0o+RvCvBrcT3bZEAMEESreKh8/7VN/LEFn6a9dkrb6ro7Up1if8UiNcV+fD1zYiJygP/TYJdQ7p1mIKdXDEltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750619599; c=relaxed/simple;
	bh=BJ4KJ1VPwN2wcWmzFfKjKMPyZmpiic3rGbnsBJ16YaU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gS+nIvE0FzJTPNaKbjyUYwHPOIwr3oOR7gmIp/qOIGAT8IfJNyVtwQj+HUmxAdyobBa2jZwwEMinr06XlkmijXjDmOez/EWnDBJMcGooXpwX7jABeLINHeZoW3dZ55V19p5lK+lKy+BWhdrAclpmS6IyyfMYdLYGQqfGuln66vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C3FC4CEF0;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 5CF0418095C; Sun, 22 Jun 2025 21:13:17 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: krzk@kernel.org, sre@kernel.org, akpm@linux-foundation.org, 
 lee@kernel.org, Charles Han <hanchunchao@inspur.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250519061601.8755-1-hanchunchao@inspur.com>
References: <20250516095346.24169-1-hanchunchao@inspur.com>
 <20250519061601.8755-1-hanchunchao@inspur.com>
Subject: Re: [PATCH V3] charger: max14577: Handle NULL pdata when CONFIG_OF
 is not set
Message-Id: <175061959737.285737.2823091107062731598.b4-ty@collabora.com>
Date: Sun, 22 Jun 2025 21:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 19 May 2025 14:16:01 +0800, Charles Han wrote:
> When the kernel is not configured  CONFIG_OF, the max14577_charger_dt_init
> function returns NULL. Fix the max14577_charger_probe functionby returning
>  -ENODATA instead of potentially passing a NULL pointer to PTR_ERR.
> 
> Fix below smatch warning.
> smatch warnings:
> drivers/power/supply/max14577_charger.c:576 max14577_charger_probe() warn: passing zero to 'PTR_ERR'
> 
> [...]

Applied, thanks!

[1/1] charger: max14577: Handle NULL pdata when CONFIG_OF is not set
      commit: 2937f5d2e24eefef8cb126244caec7fe3307f724

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


