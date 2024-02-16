Return-Path: <linux-pm+bounces-4017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E13588589C4
	for <lists+linux-pm@lfdr.de>; Sat, 17 Feb 2024 00:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968DB1F25B6D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Feb 2024 23:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541B14831A;
	Fri, 16 Feb 2024 23:08:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2BE133423
	for <linux-pm@vger.kernel.org>; Fri, 16 Feb 2024 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124914; cv=none; b=EjRWzPnk3k0vsiu4KhrLqZbNHNQa24TwDz1HUCUUyKYfD56OkUxf5iityJcgAz08R65MBp3NVMnfa8f5wfecQ5PVi/I2ccQ8whSZOl987rx87ol0Py8ObCxfjESR7sLjGKePVl4lpX9/I8BCbVMcV4q4nADQ2DY9nJb57qH4Rt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124914; c=relaxed/simple;
	bh=Dh7y+97V7NZ9dE1V513f00SwbU7qqRMJs8HYnO2Odqs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fvkIBdRaWMS1S6AH6OH6FGXr0FOjES+DIpzGXRjFPfLXD5DoCWI8aHVDaoEh8UzRluTuQ/apuN5Uo+oPkNJ+9/zTqwT0SDaL8zKbJzctiYVEihIVoqy/YnQWXmVu+j7uWZgAnUvAzSbKbNzigSUdDpqUZq8wEupb4mdrY/oXY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15730C433F1;
	Fri, 16 Feb 2024 23:08:34 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id A29871061C38; Sat, 17 Feb 2024 00:08:31 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
In-Reply-To: <20240215155133.70537-1-hdegoede@redhat.com>
References: <20240215155133.70537-1-hdegoede@redhat.com>
Subject: Re: [PATCH] power: supply: bq27xxx-i2c: Do not free non existing
 IRQ
Message-Id: <170812491162.1326093.13864794994127552945.b4-ty@collabora.com>
Date: Sat, 17 Feb 2024 00:08:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Thu, 15 Feb 2024 16:51:33 +0100, Hans de Goede wrote:
> The bq27xxx i2c-client may not have an IRQ, in which case
> client->irq will be 0. bq27xxx_battery_i2c_probe() already has
> an if (client->irq) check wrapping the request_threaded_irq().
> 
> But bq27xxx_battery_i2c_remove() unconditionally calls
> free_irq(client->irq) leading to:
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq27xxx-i2c: Do not free non existing IRQ
      commit: 2df70149e73e79783bcbc7db4fa51ecef0e2022c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


