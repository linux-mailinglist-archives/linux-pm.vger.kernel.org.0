Return-Path: <linux-pm+bounces-12989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CA89614CC
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 18:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25B6282BEC
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF821D1735;
	Tue, 27 Aug 2024 16:58:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED00B1C8FD3;
	Tue, 27 Aug 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777922; cv=none; b=j6XOxx8W5obaYu0u/CTDsE4CEwUesAYw+f5Bdpfg4Nut/rj+01cf1pG0Ldm+W/rqza0NsG2o7qC4glYxy5HYL6AxpToH0V+QXq1sz806OwKubPcKbra6ueeUfOM1IxGIO3t6p1rCl37Qz/G8Op1My1OrwFZ+zHJoa82RBn1ZTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777922; c=relaxed/simple;
	bh=ncLX3v97aEsUdyRx7bib1sU6wV4hUJEdPLTSjruYgjM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D80RIQMUr4flSC96Sowpjuic0qtPR+NhILk/Uoi6K8Eoy0exOaVSMn5K5XTiriad7s4tcg9QJJvBRRSIoxSalxxmSqAlOZkrY/xmYJimlr/vFfnmCVeFILLT7BWgF9l9mdt79Bu8jWsUAES5+4OGd8IIecTwnPE10631MjruWys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BB0C4FE0F;
	Tue, 27 Aug 2024 16:58:41 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 977451060501; Tue, 27 Aug 2024 18:58:39 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Artur Weber <aweber.kernel@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
References: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
Subject: Re: (subset) [PATCH v4 00/10] power: supply: max77693: Toggle
 charging/OTG based on extcon status
Message-Id: <172477791961.367469.6956429142424733838.b4-ty@collabora.com>
Date: Tue, 27 Aug 2024 18:58:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 16 Aug 2024 10:19:06 +0200, Artur Weber wrote:
> This patchset does the following:
> 
> - Add CURRENT_MAX and INPUT_CURRENT_MAX power supply properties to
>   expose the "fast charge current" (maximum current from charger to
>   battery) and "CHGIN input current limit" (maximum current from
>   external supply to charger).
> 
> [...]

Applied, thanks!

[03/10] power: supply: max77693: Expose input current limit and CC current properties
        commit: ba7e053ec89f61be9d27bfb244de52849b5138aa

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


