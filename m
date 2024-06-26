Return-Path: <linux-pm+bounces-10050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150229181DD
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 15:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95C32857F6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0AA18A95E;
	Wed, 26 Jun 2024 13:06:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADD818A959;
	Wed, 26 Jun 2024 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407172; cv=none; b=A1f7luv7vXboXTGrbwyw8dFzAIpnPYm61AeR90h2yU+xQ1hvEBD3pJbPNo1b7FFpYD+k595yItvoe/iPSlyQ3/n2Fr61XL+tqinBNMbd8ndFOFkva9iz1Ko4lXPrGeTgAkCw8UOS/l6OkyYg284ObvJw52RRsrr4Mrhom50Nr/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407172; c=relaxed/simple;
	bh=GOp37wPmnAvgXsqMReUrdRIqdeUb22PiUxfzKAposJQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uofA4P43qJEWq37VAKGkGYhTVAKRAOZzJ73cyRNZr6zdvJKUVaPGAYvM3JwDRzMJY5HTshZG9p02nN9EFhVpedc0EW/BLfGSeeu+jTNen5xyqmaUE68Y9I73nGkZi+l1X5e+64TL7iW1Y6FlhR+DBeaTSvmSC+zekH6QlJYer1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21902C32789;
	Wed, 26 Jun 2024 13:06:12 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id A4A1E106093D; Wed, 26 Jun 2024 15:06:09 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linus.walleij@linaro.org, sre@kernel.org, jic23@kernel.org, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <cover.1719037737.git.christophe.jaillet@wanadoo.fr>
References: <cover.1719037737.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 0/3] power: supply: ab8500: Improve code related to
 iio_read_channel_processed() and fix a bug
Message-Id: <171940716965.127964.17060971210782573496.b4-ty@collabora.com>
Date: Wed, 26 Jun 2024 15:06:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 22 Jun 2024 09:04:23 +0200, Christophe JAILLET wrote:
> This series is inspired by a patch submitted at [1].
> 
> While looking if the same pattern was relevant elsewhere, I ended in
> ab8500_charger.c.
> 
> Patch 1 fixes what looks to me as a regression introduced by
> 97ab78bac5d0.
> 
> [...]

Applied, thanks!

[1/3] power: supply: ab8500: Fix error handling when calling iio_read_channel_processed()
      commit: 3288757087cbb93b91019ba6b7de53a1908c9d48
[2/3] power: supply: ab8500: Use iio_read_channel_processed_scale()
      commit: dc6ce568afd3452ac682261ea0db570d28f7d82d
[3/3] power: supply: ab8500: Clean some error messages
      commit: f62b267adcac33c64a26ec55973dad92bc8a8358

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


