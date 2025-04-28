Return-Path: <linux-pm+bounces-26333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7804FA9FCF5
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 00:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7142C3A4741
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 22:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941BE20E6EC;
	Mon, 28 Apr 2025 22:18:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876315ECD7;
	Mon, 28 Apr 2025 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745878726; cv=none; b=g9Ic/yEi01/CkaLqrsp80jlLmh/BvFQS0ukM8s6elUAhGsO+P2bFLHjzNR0Pvb+hJeATqxpaIWkgXUat4g99B7B3Vx/aQ3iXrU64YMaG96gPzHZ8ly7+8Y+MFDV9qppGptk9em+4hgStPynbwfrkWZidOVDAuoJ+0FZwKczUcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745878726; c=relaxed/simple;
	bh=uJptWOK031G4mdYZDB4GR6SIFI1DUxb5pMAYZJ/GKz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZCF20ax3ojVDmOWnEA+05mRbgVs2/6/qUvNIKUTnuwWjDlkzk3Z8/l26yaE41WIemSHRSlBKhJI5X6cQp3tKC2k28lmyIMfOQ+Yw+IphHGrgQaq3ExkgEtOQ7k/SWc9hbdXIF7byvBdQixsIVyPxzxeDnlx9e6tfSOlDRNIEt2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7DBC4CEE4;
	Mon, 28 Apr 2025 22:18:44 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 41ECF180757; Tue, 29 Apr 2025 00:18:43 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
In-Reply-To: <94f55158-1776-4f2f-9296-e307e83d569a@stanley.mountain>
References: <94f55158-1776-4f2f-9296-e307e83d569a@stanley.mountain>
Subject: Re: (subset) [PATCH 0/2] power: supply: max77705: Fix two static
 checker issues
Message-Id: <174587872324.18440.10820410998197235199.b4-ty@collabora.com>
Date: Tue, 29 Apr 2025 00:18:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 21 Mar 2025 17:34:00 +0300, Dan Carpenter wrote:
> Fix some error handling and an error code bug.
> 
> Dan Carpenter (2):
>   power: supply: max77705: Fix workqueue error handling in probe
>   power: supply: max77705: Fix error code in max77705_get_health()
> 
> drivers/power/supply/max77705_charger.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] power: supply: max77705: Fix workqueue error handling in probe
      commit: 11741b8e382d34b13277497ab91123d8b0b5c2db

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


