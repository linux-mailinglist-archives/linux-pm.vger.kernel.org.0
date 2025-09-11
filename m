Return-Path: <linux-pm+bounces-34452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AD5B52D9F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 11:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08B318963F8
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 09:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D94F2580E4;
	Thu, 11 Sep 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edh34KDK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776AF8F7D;
	Thu, 11 Sep 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584062; cv=none; b=iJUFbuWsMfzfb0kJNf0UIdK4FukZqZQKh/kei5Jo6FAT4kem3Xaw7jFixOJmutyxnAPeMB7jACVjZNV2XS1yoQEqyr9RPbZrvHmXukKjwKAci7BJJkVwiVc+vQ1n6K+jl7jC0b5qqxIpzpFIP8FYslJltqxehJU9tl/wWYAZgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584062; c=relaxed/simple;
	bh=PV0pGmndLpSpMkaThngiV8pYU2tYzIxpqXXWKj+lazI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SyOQUo4E/VcYPT6K5O6IpnRcqtKjFp0DA9CVEAiN51OEv3Pq2W/XS1Qw8w4nYlZZ0GE0mnpuoP/1aFhfns9H4uxXO7xY9sWF0GVpsZk6vHwjzi8qcPzIRxMYMrb4bHDp3I/khG/0mucbALE+qKTMaFeb8c7Wwib+oZMhhK/VJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edh34KDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07CDC4CEF0;
	Thu, 11 Sep 2025 09:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757584062;
	bh=PV0pGmndLpSpMkaThngiV8pYU2tYzIxpqXXWKj+lazI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=edh34KDK31MCTJ5THlkoV6GgcI5IAwoe0/NezH5H0KeC5LgoibMxtYjppMiIKO3lD
	 Khrm4DQ7Y1mZG0KvBEeenI9ZgMFz8bCVppWtf59IwfY1zS1VKKcGAe2M82Jcb9DFW9
	 KhLgPpdszAoC2A4qyM07SlGXTNqStFGc77U5Ab/5DZi+O3HI6yJDztpgVCyII4uFFk
	 jWRWx686a+g/RdgB52X5YkHROkLHHnN8npWrrk3oaYLXayuw+I8qTKQRrmmSWgPsVm
	 Rm7ZmHvQIYrkRtwM5Brujt1iN7Xjz/wQVXUh9NM+V2l1IeiOd5YXOH4IFT5EQVkfW2
	 BsP/SUMxRGCjg==
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Andreas Kemnade <andreas@kemnade.info>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250821-bd71828-charger-v3-1-cc74ac4e0fb9@kemnade.info>
References: <20250821-bd71828-charger-v3-1-cc74ac4e0fb9@kemnade.info>
Subject: Re: (subset) [PATCH v3 1/3] mfd: bd71828, bd71815 prepare for
 power-supply support
Message-Id: <175758406050.1323810.11657674052971911034.b4-ty@kernel.org>
Date: Thu, 11 Sep 2025 10:47:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Thu, 21 Aug 2025 20:23:34 +0200, Andreas Kemnade wrote:
> Add core support for ROHM BD718(15/28/78) PMIC's charger blocks.
> 
> 

Applied, thanks!

[1/3] mfd: bd71828, bd71815 prepare for power-supply support
      commit: 58cd9c86b24072f0a25b27d602fd36ec8c8222a7

--
Lee Jones [李琼斯]


