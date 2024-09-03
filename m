Return-Path: <linux-pm+bounces-13472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8084696AAB3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 23:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E864282597
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 21:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0E21C9DC4;
	Tue,  3 Sep 2024 21:58:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB7126BF5;
	Tue,  3 Sep 2024 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400680; cv=none; b=KSlmbk7O22g+UQ1zjG9Dil4ZujbTczz7FNkNCF3eBRTb1euK2UWWcoLs/lnAPJAhY0+CkfKqxBPrIgUEEAQHMSJANxQnynfcq0soBxZS00Id4bYOwmDWbkexQ4lyXr+zXQ9vTF/k7Lsde7pasR+UHfmP5tNsRIqOc8l3VY5F7mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400680; c=relaxed/simple;
	bh=Q86S46dRZelh06st+psy3jtzAJ3A1R462K9GLQJ2uUA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nGxfh5j+DDryHrYM65NM63XxhR2YKpulbdcBiOaAAStebPRZ6J3FMKsyesghNb3QXfUQsIizCASifszGhwlN29vBKFKjkuxal51IR8JQU1BzmWxsEC/wuNXx/HBvUYfo5VHCaRSzhvBQQTCiD//9H1QUeclApqPDuS4u68W0hoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D69C4CEC4;
	Tue,  3 Sep 2024 21:58:00 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 3BDBF10604AF; Tue, 03 Sep 2024 23:57:58 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 linux-pm@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240828093447.271503-1-colin.i.king@gmail.com>
References: <20240828093447.271503-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] power: supply: axp20x_usb_power: Fix spelling
 mistake "reqested" -> "requested"
Message-Id: <172540067823.972525.7995943081797942437.b4-ty@collabora.com>
Date: Tue, 03 Sep 2024 23:57:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 28 Aug 2024 10:34:47 +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_warn message. Fix it.
> 
> 

Applied, thanks!

[1/1] power: supply: axp20x_usb_power: Fix spelling mistake "reqested" -> "requested"
      commit: 57dfd4455bd270d1efebf950c2f722977b09c57a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


