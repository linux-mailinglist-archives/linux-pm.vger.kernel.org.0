Return-Path: <linux-pm+bounces-12983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AAF9613F6
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 18:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2E61F246D9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CE51CE703;
	Tue, 27 Aug 2024 16:25:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F5B1CDA37;
	Tue, 27 Aug 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775934; cv=none; b=OZC53FohbNBMEUwRJRbmJVWt6tD0si6TgjFCuNCtxajqcs/5ZMZiA0mMuseMLwSJ3g/mpQYnycqlYuhIh0BPPeyHEcjaFeqEgIz5uvJSBz+W2RQjBds20AfBmL2/+gMpkaYtVAum2jJCUE16mcih4oy4DNzbaaePD1pRjf4fgAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775934; c=relaxed/simple;
	bh=pp5seK9cFETth4Q3mhHoLrCJJb991K9mLFMTyHePyZ8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B2uHzqHiaHIFKyAQnm5d+5cEbYoIGOcETT8oVoL+aB2APy4UMhCuUPRjSZbjrWSunfDWMJlUhCkeg8eycc19qHlwSy13UQqqIpg2atSv9KGcLSeQhAzhGMREvAvfKWoi/G5k0YtjYrq8d3nny3i/08ZNTsPP9hxEhkV3t2aihaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89726C8B7C5;
	Tue, 27 Aug 2024 16:25:33 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 418F61060535; Tue, 27 Aug 2024 18:25:31 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240705113113.42851-1-krzysztof.kozlowski@linaro.org>
References: <20240705113113.42851-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] power: supply: core: simplify with cleanup.h
Message-Id: <172477593125.353499.16835192129915410138.b4-ty@collabora.com>
Date: Tue, 27 Aug 2024 18:25:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 05 Jul 2024 13:31:12 +0200, Krzysztof Kozlowski wrote:
> Allocate the memory with scoped/cleanup.h to reduce error handling and
> make the code a bit simpler.
> 
> 

Applied, thanks!

[1/2] power: supply: core: simplify with cleanup.h
      commit: a9125e868f7ad80d527cf5c69e20fa0ada96bff9
[2/2] power: supply: twl4030_charger: correct comparision with old current
      commit: e764374f4b57a0e0c0221bc0188034ae9996808e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


