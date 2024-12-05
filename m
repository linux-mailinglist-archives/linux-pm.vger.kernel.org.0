Return-Path: <linux-pm+bounces-18594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C339E4BE3
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 02:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3626284DD0
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 01:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21803156F5D;
	Thu,  5 Dec 2024 01:36:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F8E1422AB;
	Thu,  5 Dec 2024 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733362615; cv=none; b=OknzCGzBrYI9fpBMM+/BdcKgZ+JE7W5ou4Df1eBKV91rHF82QQLqnqyIC0mLxmYCYT4/PrY1HBYWR1NiIXPV87YGAU9Pse6CWPxAdlQrIvJiJsr5iWnsyj/hFhSQA5YNmyMq9H+KrSdvo7Tgx566HBWZgr35JlivCDe+CJNLfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733362615; c=relaxed/simple;
	bh=1Mjv9d0/DHrepgcPmPzR0ts/ogXRlZNwutiizS2SQ8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JR+FYdoUPRV9VgXC8ehZPgJjGW8FjHIYpN/q13pxK84jKJel0PIDuuCjxhJh6bRf6PrlX9hTsm6PyKnCYDzQhfpFcjShWJ2pqsMMUb3sSbfVZ/K19BinFLMszROpiCO+DbaZfFaHVJRyi1JGHObwyW4zBbadTM0lmuYgX4wJPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDBDC4CEE0;
	Thu,  5 Dec 2024 01:36:55 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 94C2D1060503; Thu, 05 Dec 2024 02:36:52 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cs=C3=B3k=C3=A1s=2C_Bence?= <csokas.bence@prolan.hu>
Cc: Samuel Holland <samuel@sholland.org>, 
 Sebastian Reichel <sre@kernel.org>
In-Reply-To: <20241119180741.2237692-1-csokas.bence@prolan.hu>
References: <20241119180741.2237692-1-csokas.bence@prolan.hu>
Subject: Re: (subset) [PATCH v5 1/8] power: ip5xxx_power: Use regmap_field
 API
Message-Id: <173336261259.1429662.11543418848764178684.b4-ty@collabora.com>
Date: Thu, 05 Dec 2024 02:36:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Tue, 19 Nov 2024 19:07:33 +0100, Csókás, Bence wrote:
> The IP53xx series [1] has a much different register
> layout than the 51xx/52xx [2] currently supported
> by this driver. To accommodate supporting the former,
> refactor the code to use the flexible regmap_field API.
> 
> [1] https://sharvielectronics.com/wp-content/uploads/2021/07/IP5306-I2C-registers.pdf
> [2] https://www.windworkshop.cn/wp-content/uploads/2022/04/IP5209-IP5109-IP5207-IP5108-I2C-registers.pdf
> 
> [...]

Applied, thanks!

[8/8] power: ip5xxx_power: Add support for IP5306
      commit: 39f3bd9c9a27d526858da153090376decdf7bfea

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


