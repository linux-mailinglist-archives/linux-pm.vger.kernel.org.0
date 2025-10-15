Return-Path: <linux-pm+bounces-36208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC79BE0988
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 22:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDD818870FD
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 20:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F0D2DF144;
	Wed, 15 Oct 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="l1ick60i";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AR3ISOHe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A32305044;
	Wed, 15 Oct 2025 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559184; cv=none; b=TQPZZQThYYLKSKjeOOInjAAu9KmtxcA1Trzua3TdJyN2IIDlhEObQHIbTfQ4d3hvtAFTPg+k0UcXal0+913q2ZjVmumvYoJ9Nfa/fYJHlt8/IuF04XA3sHe9tMicRulM//jvrcpZaxqUCGbBggbolju7MxUelcxNLtChWwPM/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559184; c=relaxed/simple;
	bh=ndUKEECHP9OIyg4TBo/6xyVRd/iQJqTrfyef31H8T1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPVtwhp9sQwSM/Cj2T6USDLBce4/gNSz0kxwiIBcQgtgwcyYRLPBGEQng2RvFjl7KeeRy4H989vTn/fooKY0Z4d3z8d8Wpgbq36UhPPU9AusEZnGnQMFXIH09QQstDRE60fLigabEKNWbbTMN1XpF9W2ms9S6f7cXUpe5tfNrC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=l1ick60i; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AR3ISOHe; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cn2MJ5KbSz9tJv;
	Wed, 15 Oct 2025 22:13:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760559180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VM3KS+BgPucv/Zu8xC/KhkrUo3YmWBVtWcMKAdVFPjQ=;
	b=l1ick60iEwpbiwqqdnczgu1+9ZvA9BQF+EzuJnCB8cHonkGWdCnGWI0YqAHV+s/WoBpQwX
	5oFO6kISiyJhpKgHWQcGtwjTMkvw6TCgWBj56dXZaQbjL0LP436NEI7DUNeyHyCQXOhcpR
	Fklfi/0eHHOM1O+73xCaj2G8WIkAi5BQG0y1Gojb2uNo5XjUBGHHMl3nGto+SD2bnvT1k2
	6fNrF1p3u8rZYPoaXKRQWM6LXk6l61s2W/CxBZbzrmbz6giz2168pzA4/plYS6cuwldInI
	KPdrTerE1j4faojWBu0+KXTZAhc81/owT27EflmmWYLBwzz5o7RCDLHSVxyJ9g==
Message-ID: <48f394d9-69d4-449b-8478-f2f24b230e94@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1760559178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VM3KS+BgPucv/Zu8xC/KhkrUo3YmWBVtWcMKAdVFPjQ=;
	b=AR3ISOHe8TzmUi1oxWJzTQanUTqDs95RrzR3bLAf0FOPVmKKoRCl/KkmV6PS9P0rlnXAqB
	Npqag318FqEsQga/k+iImqpfMCYP4wJEQN+CT63d+l7uvImGZR/OsvkK1QsANBVFe31rld
	MKHbXnSCl/mTFZ3wHFdxjVAubfAjYRk7P9AlW0BFH1ELyrzE3msd5TPbmgCu3lbntCltH8
	8LF3q/vpoL015fjSZcQ8QjmpvsvOk49v7aq6a3yrj68xze02LekDcHKSTGN2ULNNXm83E4
	TZ6Q4/FOMOA3hVMHKP47aSD1ZAGjJjTPqjDF9HBlfC5wqRXa8TgToswvJIBnRQ==
Date: Wed, 15 Oct 2025 20:11:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] thermal/drivers/rcar_gen3: Document R-Car Gen4 and
 RZ/G2 support in driver comment
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
References: <20251015155905.186612-1-marek.vasut+renesas@mailbox.org>
 <20251015173303.GA607688@ragnatech.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251015173303.GA607688@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 76cofgb4q3ceweoxh566euj1boijjri3
X-MBO-RS-ID: e7187d32b6712431e8c

On 10/15/25 7:33 PM, Niklas Söderlund wrote:

Hello Niklas,

>> - *  R-Car Gen3 THS thermal sensor driver
>> + *  R-Car Gen3/Gen4 and RZ/G2 THS thermal sensor driver
> 
> Super nit: I would write "Gen3, Gen4 and RZ/...". Compared to v1 you
> updated the commit message not the comment here. Not a big deal all the
> information is there.

Like this, right ? I will include that in V3, thanks:

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c 
b/drivers/thermal/renesas/rcar_gen3_thermal.c
index a143b087a8ea7..1f4f02e939ef8 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -1,6 +1,6 @@
  // SPDX-License-Identifier: GPL-2.0
  /*
- *  R-Car Gen3/Gen4 and RZ/G2 THS thermal sensor driver
+ *  R-Car Gen3, Gen4 and RZ/G2 THS thermal sensor driver
   *  Based on rcar_thermal.c and work from Hien Dang and Khiem Nguyen.
   *
   * Copyright (C) 2016 Renesas Electronics Corporation.



