Return-Path: <linux-pm+bounces-28196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067A2AD0119
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 13:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F833AD661
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90602882A0;
	Fri,  6 Jun 2025 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GKuliRjh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39EA1F099A
	for <linux-pm@vger.kernel.org>; Fri,  6 Jun 2025 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749208680; cv=none; b=oRQ7h1YdInyOiBqJNUkkqjt9YiUe1Bl5ti93Q7Pnc1+Y/oGByZ82XuVpXFC+0Wvu4WoopeKttUjuwXkisqzcSMx/4HhVFPCuH04tWOW5gHQkzQ9r888yUancyWJB7TtEqe0H21tDHPX2J0z5qS6kXNFzaH21jxFX+PDmiFOy8IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749208680; c=relaxed/simple;
	bh=xqceFklevNKHrB4ZeBPwo3lRayjsO/IEtbJhI2UtAgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/1CUO/WxYDJqHd0856h3W0vfmbEmq+Lr6UsPuTPMHJmbRSLt98zCMnq+ZxGC3W11RX7q6RuTt6ZD6W4uPVHfiUTCqFs99EEhcp9DP6XAKg4dj/DAj6f0ufn52XBaSdR5Mttw3GkS7bBilTqn+QMlTc5HPeIx2IML9wbi9+bBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GKuliRjh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad574992fcaso325195566b.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Jun 2025 04:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749208677; x=1749813477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Do+QkiJD6NZpQLNVX8MWxR+5B4FmjG9ealql6MxkGsQ=;
        b=GKuliRjh/3XQYYGRR4O1FIoUa7x4jjtwAglDorwOy/82DyRUFU+vIAL+r/bcUtL7Fn
         o3xuR1836fE3oss3v/3J1qAJZon4UHZCazi0vfZtRo2C5iYX55uDuV0+2zOX8Y41rKlQ
         iU7C9VKz1HxQJo3Evfec/iRDbs7RUOkjBr5e9U4+dSgvL2awhD5MIFDcXwIByUshzBVb
         NrozqBNUi7igNkxzizL3+wOW+uQWlasOeDNG1O6LyaKUUXZoX2DK8+qCMn7CYPFYP6Jt
         +2U1rIW7Srsjd2HxJmLwzuy+Uzf3//hne1ChpqDtlgXfUryqDp+lFO8Vf756/eM3xKCE
         ffzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749208677; x=1749813477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Do+QkiJD6NZpQLNVX8MWxR+5B4FmjG9ealql6MxkGsQ=;
        b=t3WHSHLJqlhi5yhziU2ry3Hi6cI9k6oWu+/KHhmRzy6E9/s8BhFovM43ueK4GueQkj
         Ujnb0MDYhcIuhO/y9ZzPQtbSPuY+Q3oR9xcCYvaxsRCzu2UzRAOjKJ7uQDviSv3Z/UN+
         F0OTnp/07JZCM3L9/2iiKX7HylF1moMZxkhllc63gzINKExEa90MXS5K3IidMaKgXrse
         dMDrZHExdtmex3h7Fn4VnNqpopTHoMFcTxlWAqmwRSKVGXGBOT0quqH1S/ixsCelo6Di
         cw8oQ6aRczFn+rX8cA7uRBeeHvBpu5CT02cYHwuN/XhRXxamAi/2mrL2pFtTUcahA/9A
         Ny/g==
X-Forwarded-Encrypted: i=1; AJvYcCWOaymXKCyr9ZC+Xo5SY3kg1gNjmcPq943h1o7LTP9no8P04PjbDMLBjkwU/d+gJStp/bFQqlTcag==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnr0MuQ1GuSEU0N3RKFa2pF4kpwpJPWJ3HHlRB4W8K9yZR4tVc
	1XtokK6gGIi81EhQ0yOEWVJeYBPPg4tCLjMvJXAPekGk1/eiVK0DLv6WrOj4pBvACio=
X-Gm-Gg: ASbGncvXTGCWERCpJIlCZaqRveuyKzTgYyKym8XPx/zXiIPpNLUYMjH6unzOIktg1DK
	XpVRIo+P7xzysANQfYrxc0uVcE2PdvnZEG0DasNT/HR4EbBrcqyZTMgMHdB6zoKqPKaI7vo9Y0Z
	xcoDpIPhn/ofgd7cwm8SwA4HiZSNykCLS0IiRGFLq6HFd2DHcvvLOuxkwIHrAc7cD5wcrGH9epZ
	ODIIWTvroUDzz3ykIZDX41qjTzLt5FCM8TRo+vXb8BP+vHzvMnMi+K6mzNdeXGK9Ii4NusWvDG0
	ic32MoTfKe0Vjr/rlXDbu0zu9wc7eJwUGY284fqkcjcArITRloJb2ufywFJ7Ykni08+c6Maeixy
	1ThY+WtasQ7nmQqA3
X-Google-Smtp-Source: AGHT+IHWDvzZ+cK5XGmhp46aq4fLVkiHMu9QfV5rZevpbF7hqhSG/HrvSR909QCTjWOMJuFnjrtBHw==
X-Received: by 2002:a17:906:c14f:b0:ad5:55db:e40d with SMTP id a640c23a62f3a-ade1a978c16mr236485566b.34.1749208677061;
        Fri, 06 Jun 2025 04:17:57 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7b566sm98704566b.164.2025.06.06.04.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 04:17:56 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	ulf.hansson@linaro.org,
	jic23@kernel.org,
	daniel.lezcano@linaro.org,
	dmitry.torokhov@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	bhelgaas@google.com,
	geert@linux-m68k.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	fabrizio.castro.jz@renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 0/2] PM: domains: add devm_pm_domain_attach()
Date: Fri,  6 Jun 2025 14:17:47 +0300
Message-ID: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

As a result of discussion at [1], series adds the devm_pm_domain_attach()
and uses it in platform bus probe.

Please provide your feedback.

Thank you,
Claudiu

[1] https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com

Changes in v3:
- dropped the detach_power_off argument of devm_pm_domain_attach()
- use a single cleanup function
- fixed build warning

Changes in v2:
- add devm_pm_domain_attach()
- drop the devres grup open/close approach and use the newly added
  devm_pm_domain_attach()

Claudiu Beznea (2):
  PM: domains: Add devres variant for dev_pm_domain_attach()
  driver core: platform: Use devm_pm_domain_attach()

 drivers/base/platform.c     |  8 ++----
 drivers/base/power/common.c | 50 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  6 +++++
 3 files changed, 58 insertions(+), 6 deletions(-)

-- 
2.43.0


