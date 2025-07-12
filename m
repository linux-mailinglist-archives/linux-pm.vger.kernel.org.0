Return-Path: <linux-pm+bounces-30727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8102FB02C79
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 20:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6693E7AF307
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA9F288C15;
	Sat, 12 Jul 2025 18:47:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA212192EF;
	Sat, 12 Jul 2025 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752346046; cv=none; b=LYn4lyV2o7mLPN9WQ5pa3I+VPIx3SCOEMhG9KX+eFZ989iBv+6ITIDFhP27rVdpA8xT5GidgedtUPJjlQGtwlC1qGObwb1o5rqNSkuptojMzWfAi3Apr3T06DPkzCunB/Iax7doHzmUoCz9Sjto9HskkxwMJBSSuOCCORNjne5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752346046; c=relaxed/simple;
	bh=zYuW7D4e67xKTdzr1vAEXh5gNK6yBoZSLxozbBytjjk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nEtdfg8lhPBO2BTk7PoU3sysb6DwfVbWpQQ8/84u9aCYfldiSHgkYcH6o7CA3EhD4aCeucBounc7S79YShp5tK0p2wRW4d9SfO2YrAJEWnVJ2MEkssPT/Ghzm/zjf1gm4RSXaLeqX0JJ33xY3km12rgz9opnlgx8MJTWyu6QOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFC4C4CEEF;
	Sat, 12 Jul 2025 18:47:26 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id E3777180F11; Sat, 12 Jul 2025 20:47:22 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hans de Goede <hansg@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com
In-Reply-To: <20250707-fix-psy-static-checker-warning-v1-1-42d555c2b68a@collabora.com>
References: <20250707-fix-psy-static-checker-warning-v1-1-42d555c2b68a@collabora.com>
Subject: Re: [PATCH] power: supply: core: fix static checker warning
Message-Id: <175234604290.745954.15228307419539590803.b4-ty@collabora.com>
Date: Sat, 12 Jul 2025 20:47:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 07 Jul 2025 01:26:58 +0200, Sebastian Reichel wrote:
> static checker complains, that the block already breaks if IS_ERR(np)
> and thus the extra !IS_ERR(np) check in the while condition is
> superfluous. Avoid the extra check by using while(true) instead. This
> should not change the runtime behavior at all and I expect the binary
> to be more or less the same for an optimizing compiler.
> 
> 
> [...]

Applied, thanks!

[1/1] power: supply: core: fix static checker warning
      commit: 7b41a2341fa62babda5d5c7a32c632e9eba2ee11

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


