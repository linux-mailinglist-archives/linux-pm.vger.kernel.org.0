Return-Path: <linux-pm+bounces-17356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEB89C48E7
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 23:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93EC284ADC
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 22:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DA91C242C;
	Mon, 11 Nov 2024 22:13:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817D19CCF9;
	Mon, 11 Nov 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363218; cv=none; b=Ub8qbb0AzIGIES43O2SXY1XY2Nex6nuAueutK0CQlCKHh6nDgk0lqlSIfAubIlbv7n2bvD/UaKDCnU9agVHm23JBduDmXtPF0OdlcpokaNEJ3DDKiJtPY2SALSDcjOiESAEstDieomSZPCUhb2R2Dp5ivRiKpL0tCydYI6/TMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363218; c=relaxed/simple;
	bh=0pzkDcZa27th5r1mT3IOcbNpaPIMmYssDvg03QLQrgk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mmH4mf/33owHvHxGmoGt5Jl8yjmyAoaCS6F3R7yAydbqEm9gWR0lur2N8sQHPnrF6HJFAsvMFm6GvPPxDU8aJ3M7dm9N2XzS7CjOGcyiWw7/ueLampxvw75HvvH9M0RTzpMP8TiJIXiKc2lFteWZuPKwb5GbICXm7DQOTW4UIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689BBC4AF09;
	Mon, 11 Nov 2024 22:13:36 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 5230310604CE; Mon, 11 Nov 2024 23:13:34 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <cover.1730720720.git.stano.jakubek@gmail.com>
References: <cover.1730720720.git.stano.jakubek@gmail.com>
Subject: Re: (subset) [PATCH v2 0/3] sc27xx-fuel-gauge: fix battery detect
Message-Id: <173136321432.772650.14902922989173539092.b4-ty@collabora.com>
Date: Mon, 11 Nov 2024 23:13:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 04 Nov 2024 14:03:27 +0100, Stanislav Jakubek wrote:
> Marked this as V2, since the DTS (last) patch is a continuation of
> the 2nd patch from [1].
> 
> [1] https://lore.kernel.org/lkml/cover.1723716331.git.stano.jakubek@gmail.com/
> 
> Stanislav Jakubek (3):
>   dt-bindings: power: supply: sc27xx-fg: document deprecated
>     bat-detect-gpio
>   power: supply: sc27xx: Fix battery detect GPIO probe
>   arm64: dts: sprd: Fix battery-detect-gpios property
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: power: supply: sc27xx-fg: document deprecated bat-detect-gpio
      commit: 2da0cb9f03bd9b726fa1b4accb210ef2ab439925
[2/3] power: supply: sc27xx: Fix battery detect GPIO probe
      commit: f29cc6d9a3917f98f1fb109f0c8841dd095f3fb0

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


