Return-Path: <linux-pm+bounces-17353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737A29C48E1
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 23:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391F12842FF
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ABD1C1735;
	Mon, 11 Nov 2024 22:13:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B801BD000
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363216; cv=none; b=PITDuXZUisxdh0WHgYNeR8f4gaO1VTKoV4V924tj/7fLXrVCRoOZ/ri83IIXnBNx0vUbfFP9iNRMAgNV09GiaHbW5jQIRS5N+UYxMBNnJZ2y1ganM4DmuLFxupfBLN4tBU6XevXUVhjZfqW85AZD2TN5y1GecPub9vmYI3NikuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363216; c=relaxed/simple;
	bh=/5E3wiiXJBFA3HgqczhgvYKdTO35oKbo1smmmqcnU0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mat1G8hjKoPe+8GGF4ec8oz3mbQYMGv1l+vqGj/mpc/dYMrjYXadDy4xUsTGoXtKTf4BbMzuVIT2O3WnqAqOSfHvDg8TvqaAayNUmSoJHhuViMm9EZ5/Gmyz5ZVNVcIEDRspaCAii/yNfp0pLZWegyP8lUreBQTJcQkaCUsqjw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5F8C4CED7;
	Mon, 11 Nov 2024 22:13:36 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 488C910604BA; Mon, 11 Nov 2024 23:13:34 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>
Cc: wens@csie.org, sre@kernel.org, Chris Morgan <macromorgan@hotmail.com>
In-Reply-To: <20241023184800.109376-1-macroalpha82@gmail.com>
References: <20241023184800.109376-1-macroalpha82@gmail.com>
Subject: Re: [PATCH 0/2] Change axp20x power drivers to use iio scaled
Message-Id: <173136321428.772650.11707529206182542140.b4-ty@collabora.com>
Date: Mon, 11 Nov 2024 23:13:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 23 Oct 2024 13:47:58 -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Simplify the axp20x_battery and axp20x_usb_power to use
> iio_read_channel_processed_scale() instead of reading the channel and
> then applying the scaling factor in an additional step.
> 
> Chris Morgan (2):
>   power: supply: axp20x_usb_power: Use scaled iio_read_channel
>   power: supply: axp20x_battery: Use scaled iio_read_channel
> 
> [...]

Applied, thanks!

[1/2] power: supply: axp20x_usb_power: Use scaled iio_read_channel
      commit: 9fdd97d63fe2be2ab890240cce0a5790e0ef9877
[2/2] power: supply: axp20x_battery: Use scaled iio_read_channel
      commit: 1d3db2d99fbaa5020543bd1dc4f365faeffae4ed

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


