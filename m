Return-Path: <linux-pm+bounces-8670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 388EE8FD9C8
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 00:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6EDDB23778
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 22:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B8815EFD9;
	Wed,  5 Jun 2024 22:18:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C01912E63;
	Wed,  5 Jun 2024 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717625880; cv=none; b=T/8lM6/d1WNlV1Yvp2XipjkYEydJ8XrgjB4pZgZRILqBMopIWQPD9K8mZy2U4YDE25neWWq899rBxenD+6zTRpHlhwY3IkBMw5EHdMhDXYXIFfe14PY09NvSZQpuh1WNHDwWUjSK7Z9FbXUKF0VJMjtnEa5remWlF6W6atyZml4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717625880; c=relaxed/simple;
	bh=hLzgsMa1dzEX9W6V/wQtMP8WSGz5GDExHJphUh4myh8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NWZRhiQJzl5wXcdICzQHTFxsKcEYRUM90HqmH6A4TEgOPucqzecK8QkYnQIMLluweRECM/F1nk01aMu3KsfH5mainp4kh5MybgYt7KuuWf4JaEJMSplRU+n4ixvuLaNWDJCn0o1ZVJ+8hKdX1RTdUaMax1BYDSs+YpCudT4bsa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846EBC2BD11;
	Wed,  5 Jun 2024 22:17:59 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id F2AEE1060501; Thu, 06 Jun 2024 00:17:56 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Andrew Davis <afd@ti.com>, 
 Nikita Travkin <nikita@trvn.ru>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Raymond Hackley <raymondhackley@protonmail.com>
In-Reply-To: <20240605-rt5033-null-clientdata-v1-1-558d710eeb4d@trvn.ru>
References: <20240605-rt5033-null-clientdata-v1-1-558d710eeb4d@trvn.ru>
Subject: Re: [PATCH] power: supply: rt5033: Bring back i2c_set_clientdata
Message-Id: <171762587697.423727.14923925734341018284.b4-ty@collabora.com>
Date: Thu, 06 Jun 2024 00:17:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 05 Jun 2024 18:53:27 +0500, Nikita Travkin wrote:
> Commit 3a93da231c12 ("power: supply: rt5033: Use devm_power_supply_register() helper")
> reworked the driver to use devm. While at it, the i2c_set_clientdata
> was dropped along with the remove callback. Unfortunately other parts
> of the driver also rely on i2c clientdata so this causes kernel oops.
> 
> Bring the call back to fix the driver.
> 
> [...]

Applied, thanks!

[1/1] power: supply: rt5033: Bring back i2c_set_clientdata
      commit: d3911f1639e67fc7b12aae0efa5a540976d7443b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


