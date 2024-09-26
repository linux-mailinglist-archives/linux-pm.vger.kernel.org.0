Return-Path: <linux-pm+bounces-14828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C9E9875E4
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 16:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF371F27990
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A34640C15;
	Thu, 26 Sep 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvw23nvo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B4C2A8C1
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361979; cv=none; b=WhgD/L7LwQvPlttCTDQypOARNG7rTXsQ1jE4FSYiXs0B2QG2i+oO1KnXFmJ9npuNRRDRLozzJkluaNg9X+CnFpD8X1rUBTt20WSVV6oVluBonSzcOoOe8XWxA+KaSpgzw6uLk3zZRue1DPK5GitQ+Kp6juGohAr6tBwh7Lnxjf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361979; c=relaxed/simple;
	bh=BYtR4OxJFCn6M3zTc3OKmhD9cnSm2YgHNzO+dz0uZ50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z8rtlGIZ0w8ULikkzJ365/kprLT2Gfh2jDs0lOvLacjjPp6kW+mASuJogdTkTrgP/5jAItvxLw7hNaXRdAgXYXYBObWf52duXKu9euGFmL9WcvtNvbPbsevWExrRtS5vV2hTyudRauKY1aT3cjQWwANk3+FVJ65BAO+PMAVTkGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vvw23nvo; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e0719668e8so512395b6e.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727361977; x=1727966777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lwr827ER7/MK7+gZOLmMtEaMpGANHyPzdExsv2SssgQ=;
        b=Vvw23nvowmDw/8uVxVwaiH3Cv8ldAH4gmj58AtA9lWNf//4QKoGmGtRJ6iSYBCiARn
         n7tW1aFY9VMy8mhwu7SjcJIN/EEGt9Y+cj+S1U/3qAo6UBhmY5swRyMRKg/EUQ2BwwRz
         JO4LzPrw5uwDevMxEkgQ9ogs62IRPXXK5HsJ1zg9ecInz2SQpTHNMd9l6ZhGkIZoqzVk
         hRo2rSlTjlDDGvFpRHpsWVovfK32QHxwEN5Qprl1xaMHXf1MzCZ8YWa2jziXbcN5CNek
         F63B2hbvbo+6KXUrGSvkHzwaeD0GxlvhTJhk1UPN4dGiZpBdkUvlnnSIJWNl1G0Iwbl5
         qEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727361977; x=1727966777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lwr827ER7/MK7+gZOLmMtEaMpGANHyPzdExsv2SssgQ=;
        b=ry7gJEuSQ+D+N5XWz22ak6RFojyxwHTHgLhLOWGk8Xu9lxRHv7dWL54B+Pn3vWMK+Q
         fw4pNAcbflQw4DehzyPt/fotDiX/3C18i6ExzQN7HckxiouQYGQ9BdEBeIrxRuL2YfRI
         B1rsQUbrI2RwnKo5Csn/uIAvaMTN3gi4A/RO9BVL9fkPIn7isnhdfASX9Z/h+YlUoM99
         gBfXF/kM7oyERivK6ko9BGm93o3XCXo1WzEJCbakU4pWX3AaR387Goe5MMPWfXTLXRfG
         gMqwb3sC3vkMXapgqi8mvmnho20rtPgFzsPbk8HVaelUX3kpFXm1E+COJzViJCo8CUqU
         oZYA==
X-Gm-Message-State: AOJu0Yz+SK3oVRq2Zm1LHZRRp/h67aQcSbS5MIQ7QdCUsTdNqtaE/McL
	eYQOYEqIz9aCtzWeCHPhLGdy1sFOWz/qZt43e1ZpImb8QevjMfzh+8gEmHpm
X-Google-Smtp-Source: AGHT+IGl4Dg99OQm6XYe+ukDAMoVgDVIM26FXdjFrIki9r2ntLdkf59s7Zj+ecJxXPQNlzAOzy7ZzQ==
X-Received: by 2002:a05:6808:2013:b0:3e0:5c45:454c with SMTP id 5614622812f47-3e29b7d3cccmr5352313b6e.29.1727361976806;
        Thu, 26 Sep 2024 07:46:16 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e39358753esm5268b6e.24.2024.09.26.07.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:46:16 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/2] rk817_charger full charge capacity fixes
Date: Thu, 26 Sep 2024 09:43:44 -0500
Message-Id: <20240926144346.94630-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

The code for fully charged capacity is still causing problems when
invalid values are reported by the charger (usually after resume from
suspend). Stop attempting to auto calibrate this and instead allow the
value to be writeable from userspace.

Chris Morgan (2):
  power: supply: rk817: stop updating info in suspend
  power: supply: rk817: Update battery capacity calibration

 drivers/power/supply/rk817_charger.c | 112 ++++++++++++++++-----------
 1 file changed, 65 insertions(+), 47 deletions(-)

-- 
2.34.1


