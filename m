Return-Path: <linux-pm+bounces-18880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5319EA488
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 02:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA2C188897F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 01:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A369070839;
	Tue, 10 Dec 2024 01:54:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87961433CA;
	Tue, 10 Dec 2024 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733795697; cv=none; b=AaHleaIgnopeT7eKfQNT6OzKoEHNzn+iqYOUA86uJ8yg7OljHvUA4WQV0+arXpV6ZCTkNbBTrCwhaYove+l+2fkMujrTEnwuBPSwgyhF4CjGDgkNDCJ7QGvKrB/PFtlChNRvLB4oCSBT6H0oefjAH4M0RJqQbZfq9hYZ0Uyo7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733795697; c=relaxed/simple;
	bh=8wSfwTM0OctErNbGniPdRlboZDZBQb3lNYp3LmnDHNc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E+vKL5hJEnPvem0dFEdqCG8IaMsP0rE9tqtJir6i//t4gbWJOoRztvt+FDJOsHkACB1IXWHf/WJN50z7roYRQ8wlcyrxSeoBGN4o4/qyB5KTQLD24BSJ68osNljkcMLyNb2nYKaRhB62ZeXZoDAoxMlwUCq6vk5hFmJvXmwfBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B8EC4CED1;
	Tue, 10 Dec 2024 01:54:57 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 4673510604B1; Tue, 10 Dec 2024 02:54:54 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
In-Reply-To: <20241209-fix-charge-current-limit-v1-1-760d9b8f2af3@liebherr.com>
References: <20241209-fix-charge-current-limit-v1-1-760d9b8f2af3@liebherr.com>
Subject: Re: [PATCH] power: supply: gpio-charger: Fix set charge current
 limits
Message-Id: <173379569423.1843885.5224010394636642275.b4-ty@collabora.com>
Date: Tue, 10 Dec 2024 02:54:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 09 Dec 2024 11:46:15 +0100, Dimitri Fedrau wrote:
> Fix set charge current limits for devices which allow to set the lowest
> charge current limit to be greater zero. If requested charge current limit
> is below lowest limit, the index equals current_limit_map_size which leads
> to accessing memory beyond allocated memory.
> 
> 

Applied, thanks!

[1/1] power: supply: gpio-charger: Fix set charge current limits
      commit: afc6e39e824ad0e44b2af50a97885caec8d213d1

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


