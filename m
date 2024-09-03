Return-Path: <linux-pm+bounces-13473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9500596AAB4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 23:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F8C1C2174F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 21:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238D21D0DD3;
	Tue,  3 Sep 2024 21:58:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059BF1CDFA6;
	Tue,  3 Sep 2024 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400681; cv=none; b=PaSu4R41hM/EnImooaKH3p+u7Rzjttg0vfbGpAWPbz6VhgnXkoFxkzZQyn4Lc9yXzKaln9qcYjBQ29HEcgcKQpMWlyD0L2smmC8lWVnGLBVC6ZPs4cJGdB/Mj7dvOBOsjDBGwEj9QglDBCvKtgxh9b7dvHHHhcqvBHhFaaELVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400681; c=relaxed/simple;
	bh=OakaC+PH97oUs9+9AHdeNOYVuqIu4Hdcrt8QFiZ12Mo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tFkiHcN52EUcsc9/liMhM8yMuJfvXtRpHFt8aVY29gChdCcsqT1jj9lobLTPPTzyKy3jbUbtNly6Re2NokOkoFhuPANAmI8VLOPe7ooxQ5RugOSPee1YvQQmxRM3DlRVZxtMpStfkrmnceY+iAbjCnZnuHmmvCNEg/G/43BWFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0E5C4CEC8;
	Tue,  3 Sep 2024 21:58:00 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 308A0106044E; Tue, 03 Sep 2024 23:57:58 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240903063526.222890-1-dima.fedrau@gmail.com>
References: <20240903063526.222890-1-dima.fedrau@gmail.com>
Subject: Re: [PATCH v3] power: supply: max1720x: add read support for nvmem
Message-Id: <172540067814.972525.8957465635834036597.b4-ty@collabora.com>
Date: Tue, 03 Sep 2024 23:57:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Tue, 03 Sep 2024 08:35:26 +0200, Dimitri Fedrau wrote:
> ModelGauge m5 and device configuration values are stored in nonvolatile
> memory to prevent data loss if the IC loses power. Add read support for
> the nonvolatile memory on MAX1720X devices.
> 
> 

Applied, thanks!

[1/1] power: supply: max1720x: add read support for nvmem
      commit: 47271a9356192bf911a9f32de9236425063ed6d7

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


