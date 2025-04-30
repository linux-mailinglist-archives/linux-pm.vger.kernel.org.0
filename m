Return-Path: <linux-pm+bounces-26499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51B2AA5826
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 00:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FFB3A76B8
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 22:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D90226CE1;
	Wed, 30 Apr 2025 22:51:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBECA22618F;
	Wed, 30 Apr 2025 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053479; cv=none; b=d0rX+J+O32SwvFtkWvucUKK11TF+S1j0YJNCIuJe5h12Ni902UfDiTIJrEXm1ghzFot8HumJVhtzPhhqeFQ01Ih04/V34g4QJ06ABir8dPuI28O8kp+WGdpCpAf92Y26Vqv8F/t3vW8RyIuLzAlt4wQSUnAT6FqEE4T8tfppNHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053479; c=relaxed/simple;
	bh=thEMyLxkDrsA/ttO6n0gVhoW+WkyAbujhwvcR0ZVnis=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LQgTstjKWL5ID3GpPZPWgpP3PihhwHQXaGToz+bGLkS6eNSmqu3Vc/bL1NJxk1LwW9xqT3tSL+JEpU/Xv188U6XdevBh987P8w9maB4gz2PgT+0UhHFgPmMH7455Rw2SCpggJhU/xQuZ42VBuBzPGT+g9rXbyLNd8Ky9kn7RsZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BBCC4CEE7;
	Wed, 30 Apr 2025 22:51:18 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 32E52180F68; Thu, 01 May 2025 00:51:16 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Iskren Chernev <me@iskren.info>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Matheus Castello <matheus@castello.eng.br>, 
 Sebastian Reichel <sre@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250430060239.12085-1-clamor95@gmail.com>
References: <20250430060239.12085-1-clamor95@gmail.com>
Subject: Re: [PATCH v1 0/1] power: supply: max17040: adjust thermal channel
 scaling
Message-Id: <174605347618.113765.5784117458590490717.b4-ty@collabora.com>
Date: Thu, 01 May 2025 00:51:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 30 Apr 2025 09:02:38 +0300, Svyatoslav Ryhel wrote:
> IIO thermal channel is in millidegree while power supply framework expects
> decidegree values. Adjust scaling to get correct readings.
> 
> Svyatoslav Ryhel (1):
>   power: supply: max17040: adjust thermal channel scaling
> 
> drivers/power/supply/max17040_battery.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> [...]

Applied, thanks!

[1/1] power: supply: max17040: adjust thermal channel scaling
      commit: d055f51731744243b244aafb1720f793a5b61f7b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


