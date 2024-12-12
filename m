Return-Path: <linux-pm+bounces-19083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AD29EDD8D
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 03:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD76428312D
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 02:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC35E13B5A0;
	Thu, 12 Dec 2024 02:22:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976CA225A8;
	Thu, 12 Dec 2024 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970178; cv=none; b=tkYKYwm6hqdo/QQgzwKd+yv1QmI6fuertQRW//ldJtbIALKvP2tsQO11WiEVX0AgwzQPUfXEkLdqYbYIHEup5JKCmXH5CU0Hez+Blqjw6jkNzupEPhDpFmNFyJL0DQmYlLl1v9JYL1Y6Sc2w3mhdhDnYXTXCsVQaEoqtD4eWu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970178; c=relaxed/simple;
	bh=brrlmb4mzTALAgJnsIs6TWQ3skrl13B42um6N5djRec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K8dOugt20xz6QUpUzeLY7TngXLxIxuRK4Wemq1QewcRTVFql3Sd80/NgKof6FL50kgsNOnyHi4t3feHYR1E4s8CWLa2A2E7V5+ZUZftN2L/CuyOTwuy0gQkMVnXzQzsDkuU7aRxgZvGEFE8TTmZCd0lMxbmZz7xqu+sFdLfY8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE09C4CED2;
	Thu, 12 Dec 2024 02:22:58 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 55F9510604B1; Thu, 12 Dec 2024 03:22:55 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org
In-Reply-To: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
References: <20241210-power-supply-dev_to_psy-v2-0-9d8c9d24cfe4@weissschuh.net>
Subject: Re: [PATCH v2 00/14] power: supply: introduce and use
 power_supply_for_each_psy() and dev_to_psy()
Message-Id: <173397017529.2463564.581435065921684491.b4-ty@collabora.com>
Date: Thu, 12 Dec 2024 03:22:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Tue, 10 Dec 2024 22:55:47 +0100, Thomas Weißschuh wrote:
> Add two new functions with easier to use and safer APIs.
> Switch over a bunch of in-tree users.
> 
> The first commit is not directly related but fits the general theme of
> the series.
> 
> 
> [...]

Applied, thanks!

[01/14] power: supply: mm8013: use accessor for driver data
        commit: e959fdb1cd4dccd37225cac654901a862c52e0c5
[02/14] power: supply: core: introduce power_supply_for_each_psy()
        commit: 9029409d1a250da19f1086ab1113752411c5163d
[03/14] power: supply: core: use power_supply_for_each_psy()
        commit: 68abaf7323ae857db7ec56a174b7bbf5fc687d47
[04/14] power: supply: ab8500: use power_supply_for_each_psy()
        commit: 87f57faa20ee2cc274400801fb197a27535ff6b5
[05/14] power: supply: apm_power: use power_supply_for_each_psy()
        commit: 230fb418b47733d887dc8ca1a653b21f41f77399
[06/14] power: supply: core: remove power_supply_for_each_device()
        commit: bfc330323cf3ea6d5c9985179384c0b56f2d5372
[07/14] power: supply: core: introduce dev_to_psy()
        commit: f52204036326bd9c07db08bab6607f423c801716
[08/14] power: supply: core: use dev_to_psy()
        commit: ead11ae3c0d9805012fb7bd3169f7771844410cc
[09/14] power: supply: sysfs: use dev_to_psy()
        commit: 4543b0c3534c65d676a837640d1ed1611e5e3038
[10/14] power: supply: ab8500: use dev_to_psy()
        commit: 1f4971fd33b1c79f1a265ce878c29241d4100a69
[11/14] power: supply: surface_battery: use dev_to_psy()
        commit: 6d99e50663f61db460a2b09ad1feef069b013182
[12/14] power: supply: bq2415x_charger: use dev_to_psy()
        commit: 30c9849c4867197d7e23f8108b93f5d196d6953f
[13/14] power: supply: bq24190_charger: use dev_to_psy()
        commit: f11ebcdeb9208e07140c7db9a849df111fbbe9d7
[14/14] power: supply: bq24257_charger: use dev_to_psy()
        commit: 72ad51a62389dc99fbe5337ad1821399b23bd78f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


