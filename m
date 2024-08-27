Return-Path: <linux-pm+bounces-12980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5717D9613ED
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB65B1F245CF
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBED41CBE8F;
	Tue, 27 Aug 2024 16:25:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F6481CD;
	Tue, 27 Aug 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775933; cv=none; b=MbwCk/4eT9jpuE7sc4tX8DZ7M8x3iW3Ak+Eo+xWrM75wPXz6J8ZTtbOsnxDrfEEo8Bbw+hVLE/urjlCjGTGXedrTtmPsLExhT6QAvPKtoxeWAoork0ZzutOc5JqUAz3/tXNCNx/oHna5cRlnNuYmQXai5dHMUH9aGDZt0bkTzxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775933; c=relaxed/simple;
	bh=4F2tol9y9eYw43ntC//87m+C1GKsivtXS88fE4HJ/cY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tVqOIUm616GQors59tsJ2b3/kHKUz6jyRTNmBTdsZn7vZr3uu0E0Gk8O2zi1bHQs7/wPc0OhwemdbUkLOzZ8KHOPBCEYNimaysW9foWZPL0bubpgGtAFiry0COcdyy6FyebGN60e2aH81+uWDPgm01ikA27MsxSD4bGOIwGZ03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A744C8B7C2;
	Tue, 27 Aug 2024 16:25:33 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 357391060501; Tue, 27 Aug 2024 18:25:31 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240819040831.2801543-1-ruanjinjie@huawei.com>
References: <20240819040831.2801543-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] power: supply: max8998_charger: Fix module
 autoloading
Message-Id: <172477593120.353499.1390821900975624059.b4-ty@collabora.com>
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


On Mon, 19 Aug 2024 12:08:31 +0800, Jinjie Ruan wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> 

Applied, thanks!

[1/1] power: supply: max8998_charger: Fix module autoloading
      commit: 7b2e5b9f1d5ea84802ae5ff531ae1739acd97c54

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


