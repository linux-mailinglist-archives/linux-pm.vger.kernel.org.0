Return-Path: <linux-pm+bounces-3766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC88850C78
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 01:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AEA282944
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 00:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7437C;
	Mon, 12 Feb 2024 00:16:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20352257A;
	Mon, 12 Feb 2024 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707697012; cv=none; b=ETD0u7uA0pcqTJ9PIQttAYKv5vZKYzI69L1kd2cWMXxvdglAlj8nl9Z8dKWKD+C9qaLXU2dR2kNQGTjq2Zd8z90w3Bz6vTMVgPYVKqjyFoLwTH3rzGBQPn64kt+3q4X8hYhBxF/JnyUvpIflZgXL7Eenmle6eJimfg08SiB+N3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707697012; c=relaxed/simple;
	bh=DjiIHLakOCAPcImuZZ+ORwwQMzQ34JyKImZQLKgAtqQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BVvJj5idhT67XNYxw5El0e7bWCD7CSYN2vTeQrTM482YctI0VSg6KH+Lrr6HvIL6X5g0YN1Dw8nJqXj2ySiZC1XZqOtYpjKpi9UJm+5HOsxGh6toDFKHIVi/NhX6vKyAYx87OwCg64NOUlBGpp4JXqxQ+Y9ICM0pEaFiwNN5hXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586DFC433F1;
	Mon, 12 Feb 2024 00:16:51 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id BF7C3106043F; Mon, 12 Feb 2024 01:16:47 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20240204-mm8013-regmap-v1-1-7cc6b619b7d3@weissschuh.net>
References: <20240204-mm8013-regmap-v1-1-7cc6b619b7d3@weissschuh.net>
Subject: Re: [PATCH] power: supply: mm8013: select REGMAP_I2C
Message-Id: <170769700775.655612.5781363366886890444.b4-ty@collabora.com>
Date: Mon, 12 Feb 2024 01:16:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4


On Sun, 04 Feb 2024 18:30:43 +0100, Thomas Weißschuh wrote:
> The driver uses regmap APIs so it should make sure they are available.
> 
> 

Applied, thanks!

[1/1] power: supply: mm8013: select REGMAP_I2C
      commit: 30d5297862410418bb8f8b4c0a87fa55c3063dd7

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


