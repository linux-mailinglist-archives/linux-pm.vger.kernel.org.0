Return-Path: <linux-pm+bounces-23662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6072A576A5
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 01:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC0A3AB3A9
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 00:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B28A48;
	Sat,  8 Mar 2025 00:14:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE02137E;
	Sat,  8 Mar 2025 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392868; cv=none; b=JD2HewDlNfJXb+v9Urnn7PnN9tIyrl9J9mHHKqGHVspb+COW8AjvqC2Tjp0uKiCSYNyZtrrjlelY+KnL8p0f7+gkFF8pvQqMG5lHiYDdC3SlL9gm8RB+QNf6aCv312T9FdUM7J9SuFrPBpZpcNssd/FTUN8GsO1G9ECR1iI7VvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392868; c=relaxed/simple;
	bh=sm5ofhfEty+HmDK+BoW6bGYRecz6LOsMatb5Jz93hpc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K4qMerTSQg35vZ5xODKmlYUcQXlxoEiPekFBHI9keMB1wJYIHmMKT/RKFfwHE0clesxTqAhesOtxFf8D5tmJKb/JwaKcGKEOL4e1r6tgLQ0YHKccc6kl64So+LsY1cXXu49dK/bxEApHfD9p7wUAqrMdL//oayeXXobbFFmDa70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3D7C4CED1;
	Sat,  8 Mar 2025 00:14:26 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 0A4AB180B9A; Sat, 08 Mar 2025 01:14:25 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, linux-pm@vger.kernel.org, linux@treblig.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250307230225.128775-1-linux@treblig.org>
References: <20250307230225.128775-1-linux@treblig.org>
Subject: Re: [PATCH 0/3] power: supply: set_charged deadcode
Message-Id: <174139286501.163707.913541186456388522.b4-ty@collabora.com>
Date: Sat, 08 Mar 2025 01:14:25 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 07 Mar 2025 23:02:22 +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   This series removes power_supply_set_battery_charged()
> which hasn't been called for a while, and then goes to clean up
> the set_charged() method which it was the only caller of.
>   The only setter of it was the ds2760, which I'm not too sure
> is used any more, but I've left the device in.
> 
> [...]

Applied, thanks!

[1/3] power: supply: core: Remove unused power_supply_set_battery_charged
      commit: 46723e2839a543859a754b0e6b6f88fa71038b09
[2/3] power: supply: ds2760: Remove unused ds2760_battery_set_charged
      commit: 172b7d79f79629300e7a6d16bc7e743b11e5ff2c
[3/3] power: supply: Remove unused set_charged method
      commit: 68b6cf4020726a8be4fa4462e12b16c7fcf8487d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


