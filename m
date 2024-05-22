Return-Path: <linux-pm+bounces-8061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F558CC951
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 01:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32CAEB21051
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 23:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBFC149C58;
	Wed, 22 May 2024 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6hBxvy5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3256D1E4AF;
	Wed, 22 May 2024 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418901; cv=none; b=dUkd7sXOxv6ZOAMXxG2AEa3KKcE383VoDR6rwxJfk7g7MGHdYeNzhbc7Qy0QYN39I35ml2qnfjQ+LuX0r2Ko4tEiKxjxys8UChCxpA8x5JlvfbEye+0unYKNbw4iAqmrpLW0aeF8U1N48Mlwf2Zz7kqugW7Sc4iwEmrLMbijADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418901; c=relaxed/simple;
	bh=ZI8SE+5RcL5NzI8JtaeoVv2eUoKGGwt83fNG7B44Wns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oqW/CsqmHo3qjdDZeyc/F/funK9sZD7LdrNdePrwU1FUrwXkZh7+sxZhXzNnlIVvRujxeBNpyaSvaqkRzc864dqfEDQqSnROSeq/Dklr8vzXY6Vjy8oubFz8EgGEyINjhR/twsAFWwQajwy+xC83llIAKLbBM+nxSD38lW6yFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6hBxvy5; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f12ed79fdfso2679810a34.0;
        Wed, 22 May 2024 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716418898; x=1717023698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0DCCVIVKZCZnK5pAwPpme5XVnB4z9KDueXfUHNAsHuI=;
        b=U6hBxvy5lxcCYJun+PC62MmWdjcH1YzUDCNXhzdf2o/PJxCtoJJQWQab8PbQbTv9PZ
         iPZ2w71vdWnnSZzSI7BqwnmWoyH284rsDoR8hik2CgZ2rmHyKiZMR9F97Sm6fT1hya5J
         eiEIvrXm/vD02CuwORzD8K9ALoHFbLxuFdHxxkDrLGrAGMNl9GqSIf0ToTXYHyLgSHjN
         RJVw9qtGJATP9+Wy3xYPGxVlvSwGAAb9ELYkV+bSp6a/AKtmt/4hOCGzufQ2v0Sm5vk5
         5WMfNrWelJR2HrfNgI+a30Mke8nS2j489P4sGmqcg/QdWGAseyfvp6KYiqGbvkpeZTKx
         tuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716418898; x=1717023698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DCCVIVKZCZnK5pAwPpme5XVnB4z9KDueXfUHNAsHuI=;
        b=Pbc/hPaPz40kkHX+0uweGvtWNF2v9D1TkrloRbdhTvqQRsbiXELwMWtl5v6aDkli/N
         idQY3sP3nL7V+B195A/waOZKQcY85p+wyXjZ7KteWjDSlF4GWHNnkSitDSCECiUNbVO7
         KKHaC6I18L7p49JvtIyiiHEv+DybfS99MScXVswYpQOR6BzSRa8dLfnfJ4GoYTmrMNab
         /MUMDWDgvnzgLicsdwQwN/XATPRcLGW5bPcROvEsxCshulv5fSKl6nQnPvqMmncnZ8r6
         4yt9eIbl20QDd5n29aYepcH/XYhaVWgBs9osWGFzpUQxbxyIDw2hZU8MqPCJG8U8eOEo
         HObw==
X-Forwarded-Encrypted: i=1; AJvYcCXX0mDsgjolqN9zVLHPXhdNxBHvmJgVZI8expGLuPfABZpcWvWC7SUN/qVWppuw5hbJ7iNS64lJaYUGLMHjQ0M3rQfHz8Sp0Qw=
X-Gm-Message-State: AOJu0YzUJ0a7GlP2RVyLV24YO3yRZm7zKAKLrVA9oRMo+TvQP/7fdDxa
	sbIcJHEI3pRjSJnjzTlBp7TkTn7zKBFAC7a01yBZNDykQ/xdNdLG
X-Google-Smtp-Source: AGHT+IHE8GNAndI69E9kReGSefDiGX4ZLLqWsmj4GbxgZPksd1egdS0/t9n5NmQ12/Prm5QDgXbBaA==
X-Received: by 2002:a9d:6a48:0:b0:6f1:2341:348b with SMTP id 46e09a7af769-6f665c26a0fmr3996465a34.3.1716418897805;
        Wed, 22 May 2024 16:01:37 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0ff995ccdsm4155936a34.34.2024.05.22.16.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:01:37 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/4] AXP717: Add USB Power Supply
Date: Wed, 22 May 2024 18:01:28 -0500
Message-Id: <20240522230132.364915-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

This series adds support for the AXP717 USB power supply. I will be
adding support for the battery in a future patch series.

Note this series depends on the "regulator: Fix AXP717 PMIC support"
series which is still pending [1].

[1] https://lore.kernel.org/linux-sunxi/20240418000736.24338-1-andre.przywara@arm.com/

Chris Morgan (4):
  mfd: axp20x: AXP717: Correct MODULE_ENABLE_CONTROL register name
  dt-bindings: mfd: x-powers,axp20x-usb-power-supply: add AXP717
  power: supply: axp20x_usb_power: Add support for AXP717
  arm64: dts: allwinner: Anbernic RG35XX: add AXP717 USB power

 .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
 .../sun50i-h700-anbernic-rg35xx-2024.dts      |   5 +
 drivers/mfd/axp20x.c                          |  19 +-
 drivers/power/supply/axp20x_usb_power.c       | 216 +++++++++++++++++-
 drivers/regulator/axp20x-regulator.c          |   2 +-
 include/linux/mfd/axp20x.h                    |  20 +-
 6 files changed, 256 insertions(+), 7 deletions(-)

-- 
2.34.1


