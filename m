Return-Path: <linux-pm+bounces-20644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B5AA15917
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 22:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B381881709
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 21:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CF71AA792;
	Fri, 17 Jan 2025 21:35:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5233062;
	Fri, 17 Jan 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149757; cv=none; b=SfIBspheEweRbLtezrIy3xuqYZn5jOQG1rpeLC+PDDnrimpaEb6Q9nFA094hxckysO3NDLvPFwyATOIsYqGrA9oQVKihq8pnoylN9aZdnwpWefvvIr+CZHYaj4Mu4JmGycngJ1TBoRy1yld35tY3W8xgEvQ0eacXoyNNVcK0+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149757; c=relaxed/simple;
	bh=5fElWjWZ7auM89capPbOgVvKPOoNRprjv3AKsfzBjrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BLBtmd1jouRzYC8C3DFSw5cstueiW2Qks7FjsmHacIMoBg53UwTQj1Qr62rS+eqlbUxfBy1roLSltSPXGPT1zhdi7STdIOAJ7edHx/ttZBGVPdsFnJ0fdxI8z1YIXR0jXJsspo02Btyy2nMSH9Jl5jYdF3rE8NQwbKDXQlNF2U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3655AC4CEE2;
	Fri, 17 Jan 2025 21:35:57 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 8C07E1060351; Fri, 17 Jan 2025 22:35:54 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <20250116-max1720x-temperature-v2-1-9638969d091a@liebherr.com>
References: <20250116-max1720x-temperature-v2-1-9638969d091a@liebherr.com>
Subject: Re: [PATCH v2] power: supply: max1720x: add support for reading
 internal and thermistor temperatures
Message-Id: <173714975455.629224.11887621606904491190.b4-ty@collabora.com>
Date: Fri, 17 Jan 2025 22:35:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 16 Jan 2025 09:04:29 +0100, Dimitri Fedrau wrote:
> If enabled in the nPackCfg register, the Temp1, Temp2 and IntTemp registers
> contain the temperature readings from the AIN1 thermistor, AIN2 thermistor
> and internal die temperature respectively. Registers are shared between SBS
> and normal IC functions and are always readable regardless of IC settings.
> 
> 

Applied, thanks!

[1/1] power: supply: max1720x: add support for reading internal and thermistor temperatures
      commit: b4a95b8fd3e67c1222c76bdd1078d43c9a11d132

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


