Return-Path: <linux-pm+bounces-26625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9094AA81C9
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 19:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A071A189E7EE
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC3427A471;
	Sat,  3 May 2025 17:18:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C51A9B29;
	Sat,  3 May 2025 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746292684; cv=none; b=SQIT9s9x3fWMqHpN9eEobi31+IiCBZm2W+7NnSw4e7i2FSGD6qwP1KqAO7yGN6v4omRX3Qb/iOzKCPxD0L5bHrG8lwF/nhydIvIXKf3Xgx40dVGJAzYFnH626HrffEt0z8JbwyR8gC+gp9n8OJdWUCvkhCNLa/i3GWbdod/Uk+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746292684; c=relaxed/simple;
	bh=yikhi6fHK9c0p85i0U+FHely5llLDofnzNBwE6ROQMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lo6by70eQNbdMvP7vyAUOuALAUaS782MvfJe7eQBX1mTNL7ztC1H5OSXVsqL54ja/yVuUSUX2Fza0g6Jzt1DzhrJQMa+P0yAPXUN2a8/LPSKilc+iFI+lXhQi2QhT5pG1YwbPozA+OwunsGQJHswI5wRGIlC2d3p0QT3PUhwtYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453CCC4CEE9;
	Sat,  3 May 2025 17:18:03 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 303091805AE; Sat, 03 May 2025 19:18:01 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-pm@vger.kernel.org
In-Reply-To: <0da94193c5f8b35fa98f25a852d74b841670bd6e.1746197233.git.christophe.jaillet@wanadoo.fr>
References: <0da94193c5f8b35fa98f25a852d74b841670bd6e.1746197233.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] power: supply: rt9471: Simplify definition of some
 struct linear_range
Message-Id: <174629268118.176094.11846954270575706555.b4-ty@collabora.com>
Date: Sat, 03 May 2025 19:18:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 02 May 2025 16:48:09 +0200, Christophe JAILLET wrote:
> Use LINEAR_RANGE() instead of hand-writing it. It is less verbose.
> 
> 

Applied, thanks!

[1/1] power: supply: rt9471: Simplify definition of some struct linear_range
      commit: b1d8766052eb0534b27edda8af1865d53621bd6a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


