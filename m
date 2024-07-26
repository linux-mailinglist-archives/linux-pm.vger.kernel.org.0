Return-Path: <linux-pm+bounces-11465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 731C093DAB8
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 00:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2AA1C230FA
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 22:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD811527B1;
	Fri, 26 Jul 2024 22:39:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5004C15099D;
	Fri, 26 Jul 2024 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033557; cv=none; b=MYJPcbva8iM+UiVJ8Qwn9JFeRV5S6YdPNVHgHjLJIdY/QZLTK3YekBePgfsFM+8zs8i55NobwhTLkbBWHwwUHClBZ22wjfv9MQX/Ht8XiUUzbj1iFip+bc3JNgx8eNZrWXBQVzevL9jiW2VXO8WaA3EPt1ZhE21xNzOgmfH91UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033557; c=relaxed/simple;
	bh=Bu5UslRBZq44O0sqBkTIKfN+TgpcyydLs8owUsPUz8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M466wzzR+rlZh/3fyC+S1Q3r5y9AbOBEW/QzeLu4pUzOfJtmmwD4dSrKIRb4HQRZ2VcbfqYsNZZ6go0LCjNcVeZEKW6iK0VSWTNn8EmtpybDI3NAISuEYOczkN/B3mGdV38MLq1bUNOnVn2n2Mz44gch1h6nIzSdQfS4QxEAkzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7141C32782;
	Fri, 26 Jul 2024 22:39:16 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 6CB721060980; Sat, 27 Jul 2024 00:39:14 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20240715-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-16e842ccead7@linaro.org>
References: <20240715-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-16e842ccead7@linaro.org>
Subject: Re: [PATCH] power: supply: qcom_battmgr: return EAGAIN when
 firmware service is not up
Message-Id: <172203355443.246603.13662219731890792931.b4-ty@collabora.com>
Date: Sat, 27 Jul 2024 00:39:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 15 Jul 2024 14:57:06 +0200, Neil Armstrong wrote:
> The driver returns -ENODEV when the firmware battmrg service hasn't
> started yet, while per-se -ENODEV is fine, we usually use -EAGAIN to
> tell the user to retry again later. And the power supply core uses
> -EGAIN when the device isn't initialized, let's use the same return.
> 
> This notably causes an infinite spam of:
> thermal thermal_zoneXX: failed to read out thermal zone (-19)
> because the thermal core doesn't understand -ENODEV, but only
> considers -EAGAIN as a non-fatal error.
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_battmgr: return EAGAIN when firmware service is not up
      commit: bf9d5cb588755ee41ac12a8976dccf44ae18281b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


