Return-Path: <linux-pm+bounces-18879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA57A9EA461
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 02:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7615281758
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 01:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06F3136326;
	Tue, 10 Dec 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqUncYvN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC340BE0;
	Tue, 10 Dec 2024 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794230; cv=none; b=HT/RphVBZv1yiuwdEzpqysbzjyhgRDt8PuLAoS1ePDBIddpdG6n3VgEOVCbaBVP3Sr0gMMlY/WRYS5hrhNsqifVQMAMe8f708WMWy1YEOkrKvWSc6Fm//9vDU6ZvJCzQRsrsIi6Etr5fhLKUxcvnY6X5g8YqeOTOVHXQqIZ8IUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794230; c=relaxed/simple;
	bh=/3/Fa996/wPp/z2tuRA7CnvQdgcWzerb8WWKan2wAvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n/swsfgFkm2JuzYYy/lTT0HGgejeMT/pNvZyx9rMxRpoyBs9hPIBnrXNszLyxhN1H/nsMj7KJjGWCZOPIZ8ctNAH4/8jx57ajeGzEjStmubyYtlwzsJKNw2cceB2cMg4oV8YhEUenxrVADfz1jQl46TMrPhCooZSwDmaqOODpMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqUncYvN; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d8f1505045so23813036d6.1;
        Mon, 09 Dec 2024 17:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733794225; x=1734399025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yLptFqAMCqePRuk20SWKFsGYRWkZDJ2kBARfQHLQM5A=;
        b=XqUncYvNXnbJ1GrK19YSiN/olUbVDddX3Txyhz5qhe5rngOSkRbwGoGNjB27U9F24G
         e/RGB7k8urp0JcO3OEZn8GgjN1pwwv3YNcs/KVVr2Mqe2ogbWH0sRF1TQS7PM0zPCwDD
         gLi8p8PhrT9z4WKo3HSC7NOyY2TIWbY16uC2QyLMLQOTHyhkHf91GKBJv4SlbHV/vH3E
         RFSDbvfg+L2jI5Ah0hEFLLLXD8ClBEjq0Z08r/mnw/fC6acnr7o72+uP+hZUHxwxprtk
         nUOZumug84AC7H2EQaRWTgoYXROeWfOIR2Ds4dd1uOpEi1Bd+yF6AkTQ3GaH4az5htEG
         c3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733794225; x=1734399025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLptFqAMCqePRuk20SWKFsGYRWkZDJ2kBARfQHLQM5A=;
        b=DWBkyY1uWwHE7UVOINgumdMMgct96RYA3I/5SjJEb390VEc5yKPYYvkL7LCCHm/vda
         ULTtr5wPOF2UNN7E/cnNdncpLlmfWjChvHB4dmdqnWGvmBnWB1L2f2f5pN3USCA07BuI
         MHuePemXUZqy9dHUVl83aCKpnqixZfI02+VVkV8h5plHQnRJV4qEetEycxu866iURXw1
         a6y0z/pTMOkwzseKJlYH5GZSIcoQ5qxzPtxFMgp9Yc+/NO6AUgZw0BdrHp1NA/2U3f5C
         E8z7g6PZb30AKHyX/Q5r5vZ7RuKNCNZGXDwT89PSxSGfmqSfRehigVZcvu8XBbsQEIhP
         UJYw==
X-Forwarded-Encrypted: i=1; AJvYcCU60+7dkq/Dz9qZC1Ra1I9U3AzFAurf5s3MtQLmztU1n9DK0N+9N+0xkMuxa1gyDocW5CnZglscLp9YvvD+@vger.kernel.org, AJvYcCUERru12nk433xTZtVJNYJ9epr6yU5ymVeNSkYVIfzXIABNUEadoFS058EzK9EzhwrrtLHZkbJ/M/Q=@vger.kernel.org, AJvYcCUxTGHYyAL0ngtUlGm1Dcrww7ZP/7oDfmJd1mHLhPovd11WbwbOzlogyE7n9MG2wcxxfv7sokiSrbT/@vger.kernel.org, AJvYcCWIbSgnLIit3lnwlwDetjxbvKoCdT8fYMepwdKkdgJEG4Tsu3knqEonjGJuUOFFFraOFqktcx0EB6L0@vger.kernel.org
X-Gm-Message-State: AOJu0YzITfK3oZGMmosYpY/6rHjWUY+47+KNFomrfRTwz4hlHaiP/cYz
	YOuHy1+NVRjDpWQe0I/rEKXFYl/DkTlVolaYSdSbvZDuwLKidPFeQRs8iqHE
X-Gm-Gg: ASbGnct7KsWWX4Q7qBORoRhQAZ4sKbP8dlAhlGZkZeqokLeZVuu+BE/C6UPaN/Shl8J
	JQ0gqERlBi1NYvhjGZ1HglfC2ohh6FYKPPjy3TAWboUN/jiCOve1+s7T3fXb5EjOakbsly1Zf2v
	kLAHeyWzQzhdn/omSvGEnSH/Eq/IzB8hOwKRIzFxWbQSmr528bjJC/h5rzHp0W40FC0KxAI6Gwd
	ATx3U5/LlRKE+veoUakEdWVwGDnfj0XAtvHGy+bzmYNQISmhtlKlmI5BjvoJ/j3iA==
X-Google-Smtp-Source: AGHT+IGl94+bcjaYHpUAJtAtPKM7ozTtuuRWPzM7fSjzKBKRwV5Bk+GTu1vmg7p1bUUPpYPUkPwp+Q==
X-Received: by 2002:a05:6214:e6b:b0:6d4:1dc0:2620 with SMTP id 6a1803df08f44-6d91e4465a0mr47573006d6.40.1733794224737;
        Mon, 09 Dec 2024 17:30:24 -0800 (PST)
Received: from master-x64.sparksnet ([204.111.53.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8f429a79csm36834346d6.72.2024.12.09.17.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:30:23 -0800 (PST)
From: Peter Geis <pgwipeout@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Peter Geis <pgwipeout@gmail.com>,
	Alex Bee <knaerzche@gmail.com>,
	Caesar Wang <wxt@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Johan Jonker <jbx6244@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kevin Hilman <khilman@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Levin Du <djw@t-chip.com.cn>,
	Liang Chen <cl@rock-chips.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	shironeko <shironeko@tesaguri.club>
Subject: [PATCH 0/6] rockchip: rk3328 fixes in preparation for usb3-phy
Date: Tue, 10 Dec 2024 01:30:04 +0000
Message-Id: <20241210013010.81257-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This is a series of fixes I uncovered during my work on the next
generation rk3328 usb3 phy driver.

The first patch fixes the error handling of the pm-domain driver. I
don't expect this to break anything, but it is entirely possible some
driver code makes some bad assumptions on the fact that this has been
broken from the very beginning.

The second patch fixes the ref_usb3otg clock parent. This was preventing
correct reclocking of the usb3 phy.

The third patch fixes the ethernet alias that was accidentlly readded
during the rk3328-roc dtsi conversion.

The fourth patch fixes a race condition between power domains and clocks
being shut off during boot, which would cause an ugly splat on rk3328
during boot on recent kernels.

The fifth patch corrects the rk3328-roc fixed regulators and power input
map. It also cleans up the fixed regulator flags to be consistent.

The sixth patch removes address aligned beats and the redundant rxpbl
and txpbl flags from the rk3328-roc, which are unnecessary now.

Please examine and test these as necessary, especially the pm-domain fix
patch.

Very Respectfully,
Peter Geis


Peter Geis (6):
  pmdomain: rockchip: fix rockchip_pd_power error handling
  clk: rockchip: fix wrong clk_ref_usb3otg parent for rk3328
  arm64: dts: rockchip: remove ethernet alias from rk3328-roc
  arm64: dts: rockchip: add hevc power domain clock to rk3328
  arm64: dts: rockchip: correct rk3328-roc regulator map
  arm64: dts: rockchip: Remove address aligned beats from rk3328-roc

 arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 27 +++++++++++---------
 arch/arm64/boot/dts/rockchip/rk3328.dtsi     |  1 +
 drivers/clk/rockchip/clk-rk3328.c            |  2 +-
 drivers/pmdomain/rockchip/pm-domains.c       |  8 ++++--
 4 files changed, 23 insertions(+), 15 deletions(-)

-- 
2.39.5


