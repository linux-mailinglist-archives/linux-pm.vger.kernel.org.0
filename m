Return-Path: <linux-pm+bounces-26338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E31A9FDC4
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 01:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0EC0465D54
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 23:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB6211491;
	Mon, 28 Apr 2025 23:31:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C701552FA;
	Mon, 28 Apr 2025 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745883116; cv=none; b=Vi7sAk3YBnBa1fNN2CwLRp/QivjIuT384kCphmiog4UXWUt8Yl0fVzRRa52ZtqBDnGhzkPn0+hBUs/9WQf7HOA3QQyQvHZumscOwVWDyNFtipxBNRT9rDOvPm2Y5beqEWtSg0Sym6InnI3DoPQgpCxrgPcI9P9zQrm78XzSicAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745883116; c=relaxed/simple;
	bh=N1rK+REertKpW0cfJZD/OEc7WPkAyiF4fadTwEuNAmg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hkYxk7K8hO61oiYRmYqPAOabBbANaci08Fogf/TxYV2dISVxU961cO+Px4Fm56sZqGaP7sIVgqF0uT6rTGID0US9s+HQw5FQ0zNpCbarceIyX+JZOxM36HE/vvMh7ZGcaQ7qMRlkIN94JZ2XfiEfvua/KLGgW4lgCt2xPh8NVtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C198C4CEE4;
	Mon, 28 Apr 2025 23:31:56 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 77210180822; Tue, 29 Apr 2025 01:31:54 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250414171455.155155-1-francesco@dolcini.it>
References: <20250414171455.155155-1-francesco@dolcini.it>
Subject: Re: [PATCH v2 0/2] power: reset: Add Toradex Embedded Controller
Message-Id: <174588311447.37089.5244289696406269020.b4-ty@collabora.com>
Date: Tue, 29 Apr 2025 01:31:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 14 Apr 2025 19:14:53 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This series adds support for the Toradex Embedded Controller, currently used on
> Toradex SMARC iMX95 and iMX8MP boards.
> 
> The EC provides board power-off, reset and GPIO expander functionalities.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: reset: add toradex,smarc-ec
      commit: 1cf87b00a74d3ee3006d825855e0075ddd2eab2f
[2/2] power: reset: add Toradex Embedded Controller
      commit: 18672fe12367ed44df24ff38aa6ac350fac479f7

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


