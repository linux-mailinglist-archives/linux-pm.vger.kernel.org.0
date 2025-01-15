Return-Path: <linux-pm+bounces-20508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F57A12D61
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 22:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D05E3A36AC
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 21:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A371DBB19;
	Wed, 15 Jan 2025 21:08:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA01D88D7;
	Wed, 15 Jan 2025 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736975335; cv=none; b=EemdOkpiGI6kRKGF6zJGkyrgJEmC1pvBGmrP0F3afRTv4O8gBo97/OY5asUnGnRn5Tc1XB+3pfIogdjHIZWBFmte17EofB6knA2OlKt5pkvFngJuwTBza1Z7ej97BjSKTIQtyi2sOwKolrmVYNDsvl/znPxQCgL5FfloEYEQefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736975335; c=relaxed/simple;
	bh=HxbcTdV2Z9d97O7P8qHhG6OSGVOp4E/EsY5kQGYtr7M=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SVG2OiRmFBEulr5EUuaFUFora/cCJ2O10UJtKefABBjkOFgEqMggHGDw0hzf+iYyCsGDjwg8YrcCXlATMSnRqTgdYp0FgfdpvKzzp0pIQfVeiI9clnn/XmDS0AxJuJM2JeYoVE64Iapdj1XLLFg7JZfnbRjLFkKnUB48UDMhmoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C9DC4CEE1;
	Wed, 15 Jan 2025 21:08:55 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 13FC61060346; Wed, 15 Jan 2025 22:08:53 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250114203611.1013324-1-krzysztof.kozlowski@linaro.org>
References: <20250114203611.1013324-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] power: supply: Use str_enable_disable-like helpers
Message-Id: <173697533305.451358.3313821474382610123.b4-ty@collabora.com>
Date: Wed, 15 Jan 2025 22:08:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 14 Jan 2025 21:36:11 +0100, Krzysztof Kozlowski wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> [...]

Applied, thanks!

[1/1] power: supply: Use str_enable_disable-like helpers
      commit: 2d678e3e1e1564780562614ebb099a1e8cbd025f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


