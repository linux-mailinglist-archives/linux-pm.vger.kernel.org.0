Return-Path: <linux-pm+bounces-29232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95CEAE31AB
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 21:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C59E188FA0A
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 19:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A3F1FC7F1;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E51F9413;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750619599; cv=none; b=CRmwYCifvVehkX3DLddmDe0zZQPgUQClMfOALDaY39yq2/n4W+i56WyS51GvAkG11+wiAkdfavb5mDf8GhlsMtwgXONpk3jul0GILpeKyQ598+/SaQkbm3Wza3bOoL1LO4FDEIlfY/TR0K8Gh/25fB+cwRM3bTlIKu5wsblDlAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750619599; c=relaxed/simple;
	bh=LHkuIhQy7WiEv0lTFs4O3owr1wCMsYLQH2TituR6eMg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q98P9FFnQwBbGxpdA1gUujd5BeKLO/aAn3QX7bN4AqDQ80BhjudoYeECoWWAXmxNLRNjEjNOOVZen0IOfmVdoCbt1Tc4DFz0LEhM+tsfdj2o8wuM8GMcwvLqXOIyd/NWAFN1UH6LlEdz9lBVPHq2vM/0XiLmY0+U5Ii+3fewhnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE1BC4AF0C;
	Sun, 22 Jun 2025 19:13:19 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 4D3E3180958; Sun, 22 Jun 2025 21:13:17 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250528194439.567263-3-krzysztof.kozlowski@linaro.org>
References: <20250528194439.567263-3-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] power: supply: bq256xx_charger: Constify
 reg_default array
Message-Id: <175061959729.285737.6498182263279126885.b4-ty@collabora.com>
Date: Sun, 22 Jun 2025 21:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 28 May 2025 21:44:40 +0200, Krzysztof Kozlowski wrote:
> Static 'struct reg_default' array is not modified so can be changed to
> const for more safety.
> 
> 

Applied, thanks!

[1/2] power: supply: bq256xx_charger: Constify reg_default array
      commit: 188014b4256fd7b625c79a45d61209da5ca4c92c
[2/2] power: supply: bq25980_charger: Constify reg_default array
      commit: 7cf88213b95e9491572c4af39c7ba2829f9b2637

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


