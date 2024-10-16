Return-Path: <linux-pm+bounces-15807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B25339A1510
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 23:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D8A1C22BC1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 21:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AF91D2B2F;
	Wed, 16 Oct 2024 21:42:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72031D517F;
	Wed, 16 Oct 2024 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114921; cv=none; b=lv5WpuHF7BTKO2gP3qOPexnSw5/YIv9dFo8zdlyVz2wfxj5Dv+j6Mvi0QV2oMLlZcI+twBi2h2l2llPV1DmnU8grgW4cQHkT2cS0+q1rIflJlfesoxCGzGAQlObdBuUyXK/Gb6FSinwXDAwNeyoc5LVBBitNMAhfpkA2ZTjj2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114921; c=relaxed/simple;
	bh=UatnwLdLYEqwbn7VVH986cj25w1ARhMFB6bRK9YGE7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ch5pT3d/7r1/Oi2k+6y/NhJxwnAGLVm/Han8+vJ36JebL+bWpBQedOuWQps/piVary8aQpwIP/y6KZsnkShB9p/ROZhfaVwpwgqt9m+U4T2dABtrrOI7DxDdYbh/ui+8cJc4TObW9cwOS5QGrM4dzoLjeydKo1iWX6Y80fGQu/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630B5C4CED3;
	Wed, 16 Oct 2024 21:42:01 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 54C5B1060460; Wed, 16 Oct 2024 23:41:56 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: 'Lucas Tsai ' <lucas_tsai@richtek.com>, 
 Sebastian Reichel <sre@kernel.org>, cy_huang@richtek.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1727252762.git.cy_huang@richtek.com>
References: <cover.1727252762.git.cy_huang@richtek.com>
Subject: Re: [PATCH 0/2] power: supply: rt9471: Fix WDT bitfield and
 charger status
Message-Id: <172911491633.630785.17931516784281011855.b4-ty@collabora.com>
Date: Wed, 16 Oct 2024 23:41:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 25 Sep 2024 16:32:57 +0800, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This patch series add the following fixes that reported from the end
> market included WDT bitfield and the real charger status.
> 
> ChiYuan Huang (2):
>   power: supply: rt9471: Fix wrong WDT function regfield declaration
>   power: supply: rt9471: Use IC status regfield to report real charger
>     status
> 
> [...]

Applied, thanks!

[1/2] power: supply: rt9471: Fix wrong WDT function regfield declaration
      commit: d10ff07dd2b933e3864c592ca932996b07bbf22a
[2/2] power: supply: rt9471: Use IC status regfield to report real charger status
      commit: c46a9ee5c6210682611d3d4276436c23a95e1996

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


