Return-Path: <linux-pm+bounces-26305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C996EA9E520
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 01:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4377AAEDA
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 23:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3494B20B808;
	Sun, 27 Apr 2025 23:27:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464CB663;
	Sun, 27 Apr 2025 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745796448; cv=none; b=ocT2wLFKDlmR/Bgn9q1NKGAMft9J2dSsol5HaLZgE7VRGEQBzlox7I3wysiIue0kZPEauDYBo0T+QxE47/mxYhPHmbIgs3dfrW9YGWkYJUX8zGqWSpPmBa8X84AtOkFqdN51cz7rF4THFVWxEaDorRlRGJ9toIy/UABLY6mGpFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745796448; c=relaxed/simple;
	bh=9SKc+mYiQDS0sF/SZPXMjoefdv+Wv38cj1C/b7g9aFE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pMmeVdJf3N+sJYT0J+fuzXs32W6avEoj21vUBNCbAXhCysbQ/6hWWFqo+FOABhuH6xXVmkCKmcYd1dOgWTkvzoqgAu0Iu+VVX7hiaZKSEg5HXWkis8Y21KTTIyVgyusQkUMUvldAaWhz6WE255QTZRP57FqFw1QkscT20gpDAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F06C4CEEE;
	Sun, 27 Apr 2025 23:27:27 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 85286180F9A; Mon, 28 Apr 2025 01:27:25 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Kees Cook <kees@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20250416222740.work.569-kees@kernel.org>
References: <20250416222740.work.569-kees@kernel.org>
Subject: Re: [PATCH] power: supply: sysfs: Remove duplicate NUL termination
Message-Id: <174579644553.306236.1161318959919770313.b4-ty@collabora.com>
Date: Mon, 28 Apr 2025 01:27:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 16 Apr 2025 15:27:41 -0700, Kees Cook wrote:
> GCC 15's new -Wunterminated-string-initialization notices that one of
> the sysfs attr strings would lack the implicit trailing NUL byte during
> initialization:
> 
> drivers/power/supply/power_supply_sysfs.c:183:57: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (32 chars into 31 available) [-Wunterminated-string-initialization]
>   183 |         POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
>       |                                                         ^
> drivers/power/supply/power_supply_sysfs.c:36:23: note: in definition of macro '_POWER_SUPPLY_ATTR'
>    36 |         .attr_name = #_name "\0",               \
>       |                       ^~~~~
> drivers/power/supply/power_supply_sysfs.c:183:9: note: in expansion of macro 'POWER_SUPPLY_ATTR'
>   183 |         POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
>       |         ^~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] power: supply: sysfs: Remove duplicate NUL termination
      commit: 77f5bb150132bbbcd6bc37ffdc80c9e140e373a4

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


