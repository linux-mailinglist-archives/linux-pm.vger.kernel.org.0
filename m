Return-Path: <linux-pm+bounces-4019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AD3858A03
	for <lists+linux-pm@lfdr.de>; Sat, 17 Feb 2024 00:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3791C2095B
	for <lists+linux-pm@lfdr.de>; Fri, 16 Feb 2024 23:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7631509A1;
	Fri, 16 Feb 2024 23:11:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB615099E
	for <linux-pm@vger.kernel.org>; Fri, 16 Feb 2024 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125072; cv=none; b=u2w2G8pK9T2Jf6tArwrg7W6DrvVKYQA+LJ5nQxtkmPCmAYq6dHFgEycx6JIt/JjCreR0JvjD2wQeIagjNDErGAyfSxZiaSZRcAPSw4rQsCo50oJdWHBFtjS6qE/LNc4V9xSszByXfPcCSjvvKDZaXQo5Yrikgvh6kf9THmwhQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125072; c=relaxed/simple;
	bh=V76zupFGt5UdG0fEowFGUUcMvUJSt8oRqR/8ilMUu54=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T+Ry07yBBl0uKpKuSotu0BeIquExt2VPpIgKykPIMJSrvg6m6yACGMuulKts8jCzOnI9tJmkjtz1kAToLThZVbMiCDMAijjESMD6ang4x8vkOWTDenaFzC6OrexXNaf6ryRItkPDXqS5h+A8EMtc/+9VsofIaAlEv/fkuFMQ7EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4A1C433C7;
	Fri, 16 Feb 2024 23:11:12 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 399D31061C38; Sat, 17 Feb 2024 00:11:10 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-pm@vger.kernel.org
In-Reply-To: <20240212090014.13719-1-hdegoede@redhat.com>
References: <20240212090014.13719-1-hdegoede@redhat.com>
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Add STCK1A* Intel
 Compute Sticks to the deny-list
Message-Id: <170812507021.1339522.2001217348386765909.b4-ty@collabora.com>
Date: Sat, 17 Feb 2024 00:11:10 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Mon, 12 Feb 2024 10:00:14 +0100, Hans de Goede wrote:
> Besides the existing STK1A* Cherry Trail based Intel Compute Sticks
> already on the deny-list, Intel also made Bay Trail based Compute Sticks
> which have a product name of STCK1A* and wich also report a non
> existing battery with a random battery charge.
> 
> Instead of adding 3 new deny-list entries for the 3 variants of the STCK1A*
> sticks consolidate the 2 Cherry Trail STK1AW32SC and STK1A32SC variants
> into a single entry with a partial match for STK1A* and add a single new
> STCK1A* match for the Bay Trail variants.
> 
> [...]

Applied, thanks!

[1/1] power: supply: axp288_fuel_gauge: Add STCK1A* Intel Compute Sticks to the deny-list
      commit: a9b254892ce1a447b06c5019cbf0e9caeb48c138

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


