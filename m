Return-Path: <linux-pm+bounces-10052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96176918367
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 15:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F773B21FBB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698591836FB;
	Wed, 26 Jun 2024 13:54:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529518AF4;
	Wed, 26 Jun 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410097; cv=none; b=CR+98o4PzJqp4oYnI04IRQCGeNFanGxXWVpqof6GFSqCGt5ANt0CAkk10lQufGkUTNvHpmV4SqX4qYvll7W+Hr3ZqVpNdgzToVWM0sFR8y9R0L21xp7xYa0KHRD4wdOvZI2+OtybUqHeGkFlYYo2+qWKIsK+V2AvVr95bQX3MkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410097; c=relaxed/simple;
	bh=FxtDe9nSy9I9WH66jJV3VBzgSphNCZ9umbNyeu3Umc4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CW6nFnvqgi1y/zcsc8EpRAfLIO48iH4H2OHh5aqdAfoUP0UUtrb3N5g5lur2EHdtVwWbwT5JAoHrUOaRhqUMUUKlnw1WSD/W7Jsx1fJX8EPefLtWdkM8ozcbwCtB+WG+aMFL2pwRW6LxtcHEF0ENXqVUkz8TVxSDvtxaGkIQtVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5432C116B1;
	Wed, 26 Jun 2024 13:54:56 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id A97F2106093D; Wed, 26 Jun 2024 15:54:54 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Paul Cercueil <paul@crapouillou.net>, 
 Sebastian Reichel <sre@kernel.org>, Artur Rojek <contact@artur-rojek.eu>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <51e49c18574003db1e20c9299061a5ecd1661a3c.1719121781.git.christophe.jaillet@wanadoo.fr>
References: <51e49c18574003db1e20c9299061a5ecd1661a3c.1719121781.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] power: supply: ingenic: Fix some error handling paths
 in ingenic_battery_get_property()
Message-Id: <171941009467.143534.7882184622422258601.b4-ty@collabora.com>
Date: Wed, 26 Jun 2024 15:54:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 23 Jun 2024 07:50:32 +0200, Christophe JAILLET wrote:
> If iio_read_channel_processed() fails, 'val->intval' is not updated, but it
> is still *1000 just after. So, in case of error, the *1000 accumulate and
> 'val->intval' becomes erroneous.
> 
> So instead of rescaling the value after the fact, use the dedicated scaling
> API. This way the result is updated only when needed. In case of error, the
> previous value is kept, unmodified.
> 
> [...]

Applied, thanks!

[1/1] power: supply: ingenic: Fix some error handling paths in ingenic_battery_get_property()
      commit: f8b6c1eb76f73ed721facd58d0cfb08513aad34c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


