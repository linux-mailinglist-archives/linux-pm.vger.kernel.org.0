Return-Path: <linux-pm+bounces-15694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 902A499F879
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 23:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCF41F22B54
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 21:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8310B1FBF4D;
	Tue, 15 Oct 2024 21:01:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E991FAEF4;
	Tue, 15 Oct 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026086; cv=none; b=ktBbFPBNQjfqzfscJhScl0miyPkgc+iEeqlG0E+Eyuc7Vd+JNUgUTwEuMi9QR23ig1GsbbkzHLWWZhMVt7jZNqhzCoZh4zUHC7VJI5VlN6m4K+YjqZ2yZmuDD9/LrB1QihVoyQHG7nFlOk3TWT42a5XkZZkfKauZrM2959lhbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026086; c=relaxed/simple;
	bh=iyfIE3tV4Y9GLhFcTONAKLm8L1+8vXX8JY52fi0VVqI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eqvxaKh34hbGsB6yYBXrBf6bmp8/qQtj402pbgOEjIL8Yuv+7rjvEBY3Q0vOHXvXHOplHVZRICgXZOahfBjfhVBBLNqkDtF81GMU1ysQuYeUVomvv13YAByjv8XT/uhEbhiLM6KDq/orXV3zozyQl9LjpVqK0VeD9J2fq2+9Lto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E453AC4AF09;
	Tue, 15 Oct 2024 21:01:25 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 7405D1060445; Tue, 15 Oct 2024 23:01:23 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, linus.walleij@linaro.org, 
 Shen Lichuan <shenlichuan@vivo.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, opensource.kernel@vivo.com
In-Reply-To: <20240914085415.3886-1-shenlichuan@vivo.com>
References: <20240914085415.3886-1-shenlichuan@vivo.com>
Subject: Re: [PATCH v1] power: supply: Correct multiple typos in comments
Message-Id: <172902608346.467915.3387692460713675814.b4-ty@collabora.com>
Date: Tue, 15 Oct 2024 23:01:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 14 Sep 2024 16:54:15 +0800, Shen Lichuan wrote:
> Fixed some spelling errors, the details are as follows:
> 
> -in the code comments:
> 	dettached->detached
> 	meausered->measured
> 	meausurement->measurement
> 	sholuld->should
> 	Tempreture->Temperature
> 	measuremnts->measurements
> 	detecing->detecting
> 	persent->percent
> 	Parallell->Parallel
> 
> [...]

Applied, thanks!

[1/1] power: supply: Correct multiple typos in comments
      commit: 570c2234d5d62d52be7e8e35169b96d98378a7ce

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


