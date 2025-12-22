Return-Path: <linux-pm+bounces-39801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2D9CD71E9
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 496453036438
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFF533F386;
	Mon, 22 Dec 2025 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7SNYkaB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25EB30C343;
	Mon, 22 Dec 2025 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435864; cv=none; b=fuRBeML+mcX86vzVFHQedxFtt7WzdN3Zpw9r3cyEyj6OGtyo8dcg8FPW5s6/VQmf2/wqhpNZ5p8w9qbD/9dYYUSctB3ioKxf+n7QsiOcfyElUSl2cWMniqEOllrooyBAjCRu5YGLOyk7NvF9wxurY8GAfS4EbQFDTiEC7F9Ncxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435864; c=relaxed/simple;
	bh=TXg9OKqRxBIynxOeV3NzELfXqjhzvGTH/rxAsBktO8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHzgyZMr5MwN3SqgrlHm/5V9wrarUWYAnWXuyCmSNwEHQ9qCXbCAaq+pO69K0lzFsLvApoyJIFS43toNH8GBc6p8bXLuDI3BmfG6fWSRNdKA6O/J2eU41SR/wMZ+G8VlwKm00qMP78+1TCRhhym1Mvw2FOKrLF2RZlj2Eww0hKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7SNYkaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93D7C16AAE;
	Mon, 22 Dec 2025 20:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435863;
	bh=TXg9OKqRxBIynxOeV3NzELfXqjhzvGTH/rxAsBktO8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7SNYkaBzblJSqtoVY+fJyNuvL/S0klpXVejkk6+7qvCu0X4bjG0JH6J9DKpHsFcz
	 om5jq81R08tOdJJQcYCzgJcCizroNXP1nG7qrwsTqNB5p7w+LKyQrFjQDwV1fLyneY
	 iC/wKK6eVIwYbdVBFgpLQzHP5oE6fTMDLZE3ATmIbez1kKFLXbzomMyHAYlDNew6W4
	 9eRE0uAB/L+PmtV0JcIv327+sN34r7QDJUrkyvzFRVIIWmoLZhPm/hCCd+5vKFU0eM
	 IRNygbnrK2EEFpooaqa8+bR3xpJjLEH8FiQLWTSLEQg8JzQZe2zwBp/hz3BxP+ADq1
	 eX19DZuuAJPCQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject:
 [PATCH v1 11/23] net: cadence: macb: Discard pm_runtime_put() return value
Date: Mon, 22 Dec 2025 21:14:34 +0100
Message-ID: <2706413.Lt9SDvczpP@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Passing pm_runtime_put() return value to the callers is not particularly
useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.  It also happens when the kernel is
configured with CONFIG_PM unset.

Accordingly, update at91ether_close() to simply discard the return
value of pm_runtime_put() and always return success to the caller.

This will facilitate a planned change of the pm_runtime_put() return
type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is part of a series, but it doesn't depend on anything else
in that series.  The last patch in the series depends on it.

It can be applied by itself and if you decide to do so, please let me
know.

Otherwise, an ACK or equivalent will be appreciated, but also the lack
of specific criticism will be eventually regarded as consent.

---
 drivers/net/ethernet/cadence/macb_main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4837,7 +4837,9 @@ static int at91ether_close(struct net_de
 
 	at91ether_stop(lp);
 
-	return pm_runtime_put(&lp->pdev->dev);
+	pm_runtime_put(&lp->pdev->dev);
+
+	return 0;
 }
 
 /* Transmit packet */




