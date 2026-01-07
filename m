Return-Path: <linux-pm+bounces-40343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A476CFB77C
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 01:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B95883002166
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 00:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640691B87C9;
	Wed,  7 Jan 2026 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhaGmbvL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2E26290;
	Wed,  7 Jan 2026 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767745749; cv=none; b=Bb5IQ/49pCvgTglzWFApYqI2S1IIz/PP7N0Wo2LPmUA9ugGrdOim+9PXauxgZ/bw2I7tECvxGFgGlcvox1g/sekB7TN0EbWibjcweFVAawfGphZ6iiSqZmi4nF1KTTx6yWXeG70k8KVJ5QlQnnigV2kC8rmg3NwE7w2Vc/379Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767745749; c=relaxed/simple;
	bh=xu5pY2s3WmH9BCuxfgMF/DiaeHV7iFxlKsfhL2aEVFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANy2srbWvabPGs1OyH71JpJkbnKThyL/SOqZSfGzyUeV5lC8MbwuzQd+CwJ+vul7tdDAWfOX4BscAAw4G00dUWGON0a19iOG4YTsGUZh/XNZYDq+hnMz7MqTzEZQoJ78CC0sCGB//+ibbqf4Z4j9sXfW4N8v6HUbg6f5AYCLb8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhaGmbvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A28C116C6;
	Wed,  7 Jan 2026 00:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767745746;
	bh=xu5pY2s3WmH9BCuxfgMF/DiaeHV7iFxlKsfhL2aEVFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZhaGmbvLohfIYuLTvi0eCsSDfLWT9FCi2A8VWQMboecCe4WtCXaMXp8JUD8eeGvmn
	 m59UlIrKMUbEmUb6Q+oFwlKH/WxUQ5wjsshHuAYt7++Y5A+HC1xszg7Ei4/igM/Cqx
	 rvPlLB0n4J9e3Ue+cEHkxB/O0gvvkPlzgdHZiAMSmwQxJQ/p2OYYs66j+V9zZOM+II
	 B1XPD5FsjP6rdCGyU1HNyo0FiYpxok2/uhlKSjCENZLOzy7uCo6eMTQLD/bcGLZE4L
	 fSQrMK9cyHYOLekXb7elsiSyFrV2kekjoXT8/R6biXuUZuG53NEKAg0E3JfJCDlVZm
	 ctCWtSresYshQ==
Date: Tue, 6 Jan 2026 16:29:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Brian
 Norris <briannorris@chromium.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2 1/3] net: Discard pm_runtime_put() return value
Message-ID: <20260106162905.14df3458@kernel.org>
In-Reply-To: <5973090.DvuYhMxLoT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
	<5973090.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 03 Jan 2026 22:23:52 +0100 Rafael J. Wysocki wrote:
> Subject: [PATCH v2 1/3] net: Discard pm_runtime_put() return value

Sorry for noticing late -- looks like the subject prefix being 1/3
instead of 0/3 is throwing patchwork off. Patchwork seems to have
mis-guessed that these are the first 3 patches of the missing ones
in your full 23 patch series, instead of treating this as a fresh
posting:

https://patchwork.kernel.org/project/netdevbpf/list/?series=1035812&state=*

Could you resend one more time with the cover letter subject corrected?

