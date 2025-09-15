Return-Path: <linux-pm+bounces-34640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B134B572F6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1895018992C1
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A902EC087;
	Mon, 15 Sep 2025 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEURqaG7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1162D46BD
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925216; cv=none; b=mDh7fbz4cMZcSwd1sgYlwUbowpTJEjHZSBTnx6/ugg+tnbwNQNCLoSSHjblEpn1T8LPjUhqYlrIypait+v+F74dEfuKtckbpD0W11323K1jkYV2HQzbTKI2eCKwL4q9OCjQ6xlJy8Sb4L334yN1sj5NLwNGTEROumRpaejgQe+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925216; c=relaxed/simple;
	bh=qgHExHKX0GUPykcINnOhpIWsYtDUUek2qoRVQ2W22yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=quraxi1/shmcGbBX5YvMGnzWbnyzOPZrYJh9ZgwSTogq2AXsrmtCnDIVzeew/b3sZmzofokTKh3PWeyAUbh5G55F/7sSXLbTeriyeRdnrT0m8kulN7bG1XBa/omP0aZO6JxeupHj8RaWWRHIMc/OUe5ytJUzdSXitBH9EpQSBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VEURqaG7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso4477902e87.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757925213; x=1758530013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/EihPg0rDDUsO2zpTiZR4g9YFvnwO8fGm9cXNKFjmmM=;
        b=VEURqaG7fwCnnAy8nXUfmDd/YFkXcSbKQuKC1SS45fz7n1jUtzoSliGXXgjAibWode
         KBrK21App5AFoFGgoWBWLLsSkPPxWWaC41jLHUfGeMw9K3sRKvh5c22beEt1c2n+uu1z
         9q20us91iJWPer1aNSEgtA5a3LPFftBT02DBj5qNYyYTD43y0FdSoVAVPe6tLvmYBxY0
         FReBddjbdkHJODgNbzS1F13q5ZXjucTp6d0uh117uO73fXeTYVQmL5H6A/CJM0aWElwd
         8NtOL+/IbvUovX1/saj+SKEXs5MLZfGA+ObACR0n14Ciyg7zUGXz5KKjj4XoAvv99FKo
         P/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925213; x=1758530013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EihPg0rDDUsO2zpTiZR4g9YFvnwO8fGm9cXNKFjmmM=;
        b=QtGYcm6lcpcfX07rJLHecelIsRtkGskVk9tHwKh1lpQmzQymVSFdQwn+oyYjDDxs0I
         y8mUXbFoPPqxJvsosCFAIKbvnV7qp3i45QzZbEEQpdvTG6ZxxNNcw0Fq3JPZGfsE68ed
         rIXWU8EZvwqxKXzLec1oVPjHo8Y45P/Nedx15wRMpB0E/xpbEeuZ6NRpqbiQ1hADxLSr
         LLK6k23oIB4I2HWdCzuPsRo/McmF3ogMRT/8X4W+CykJ6RIoLCVUSom+hXYn42D+G7AD
         BA4HYzw8z86X5IgzP0/ii5WxPE5vyaBP5q6lTapjJ5HP00ReNXuhgyeIZke2P2XpeoQZ
         iGyw==
X-Gm-Message-State: AOJu0Yxtrg8tpJm2UqqXGALSYOUAJr168kr5WB3JqXdl48cpg99G9KwF
	00W7qm/bogHEF5CHgMw1RPPosMgZtiN1g8MoewlA5NtdQ+1bQAW0OnpuKMgpXFuEWE87x5w5hpT
	bLtZPsZY=
X-Gm-Gg: ASbGncujDpv8i795K2AIz5ASHGA1XEx9l/2Fb9WJuJ70GUT10OFyGwIfncDbgI9t6PP
	h61xkmRzQy6G+TSnN6NbK2ERVMm3/cvrH4mhaQGZ6YpSAtZc5QCb28ES+q1I3CHXOzmX4BqmCoC
	P6Ng+m0WvxUCRnraxODRuo8mkKgiibuFLTVkGo7EyfBHdY08YoYz4+JkfD1Y1lxnN6HaGYxXV5E
	cb9gsXkIlHOEzNen3ffrT0BBDKvmZ7LVEV5/YZ2Mk20CrkZotNCgtskhP1X+/xp2aVu4A97mvle
	3Y0AleaRZ2XA2VsJinbkL3UH10mTNCAgrHddpv25AgmfjEqnrNLAImC6X2mVE2nQN2IzIvQR1qh
	A8oVyrBij3v+GuZyZDaisjALg767RoeMc24qaHi5ikhNOCX5HXNA0Sn5dRdxWrf7m8BR692L5AY
	mi
X-Google-Smtp-Source: AGHT+IGOXTY6MavVKngLCpLB1G9dg0jsTMPCjkwVytxoyznWD2WrW7pxjPzUDjOIZ3mMkSDu12yFmA==
X-Received: by 2002:a05:6512:2585:b0:55f:43ba:9410 with SMTP id 2adb3069b0e04-5704b52f23emr3366686e87.15.1757925212793;
        Mon, 15 Sep 2025 01:33:32 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6a33ba8sm2335142e87.46.2025.09.15.01.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:33:32 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH v4 0/4] enable ROCKCHIP_PM_DOMAINS
Date: Mon, 15 Sep 2025 11:33:13 +0300
Message-ID: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

MMC_DW_ROCKCHIP needs ROCKCHIP_PM_DOMAINS before MMC is detected
on Rockchip rk3399 rockpi4b and similar devices. Make this dependency
more visible, or the default with ARCH_ROCKCHIP if possible.

v4: fixed Kconfig whitespace, added select REGMAP_MMIO to MMC_LOONGSON2
    instead of disabling COMPILE_TEST

v3: use "default ARCH_ROCKCHIP" in ROCKCHIP_PM_DOMAINS as suggested
    by Arnd Bergmann <arnd@arndb.de>, enable more MMC drivers for
    COMPILE_TEST and remove MMC_LOONGSON2 which doesn't link,
    remove PM dependency as suggested by
    Geert Uytterhoeven <geert@linux-m68k.org>
    https://lore.kernel.org/linux-mmc/aMQv1V49xa_MThGq@nuoska/T/#md2b3252f9dce14f3f79a493c426f2761cba1dc25

v2: changed from "depend on" in MMC driver to "select" as default
    on ARCH_ROCKCHIP as suggested by Ulf and Heiko
    https://marc.info/?i=20250912084112.2795848-1-mikko.rapeli%20()%20linaro%20!%20org

v1: https://lore.kernel.org/linux-mmc/20250911144313.2774171-1-mikko.rapeli@linaro.org/

Mikko Rapeli (4):
  pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
  mmc: add COMPILE_TEST to multiple drivers
  mmc: select REGMAP_MMIO with MMC_LOONGSON2
  ARM: rockchip: remove REGULATOR conditional to PM

 arch/arm/mach-rockchip/Kconfig    |  2 +-
 drivers/mmc/host/Kconfig          | 10 ++++++----
 drivers/pmdomain/rockchip/Kconfig |  1 +
 3 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.34.1


