Return-Path: <linux-pm+bounces-12884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829AC95F4EC
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 17:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC53F1C21240
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974C0193079;
	Mon, 26 Aug 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YIk6fmpm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8696194083
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724685944; cv=none; b=YnZ9JAXQzumAPPz56yC86jPhcm24ObuN/M7MFRqrv5i0j5mHaCV2tnwxv7m5oQo5VK4TjT+jyqHEk4Nqz/hTnQVpXUpFO1BiRILJ5hCm/O+B8H/mdmYw0T5q2UT577F0scv6/psDWqVm8sHzwdBJx2UXxTHa8CuxgTmAcmC/bGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724685944; c=relaxed/simple;
	bh=/DMKkyAX33V/uuPtD4o6lStnmjdqMZbSaNtMNVCkcFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M09Z18CKGMIHuijcq3paEQbEEz+l0ZJhRX6la12h5WJjloQoCj/MWmTerhlPRLTJFHROXWKvXNdm545+zn2BZ2f/duS5N8qrP2X93vzlb8PnRUfwyEYz9qI6CXNPHezfRHk/tMTYtHkqRQ8M+DrK8AW9DXOOKtwPrszgmzkgpI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YIk6fmpm; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5343617fdddso6453631e87.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724685940; x=1725290740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVZxPwWU6fTdIbk77ZAZBmOWFDE8RmLRjC5RiWd9L5I=;
        b=YIk6fmpm/iQe/kDeAf+huYnLY8U7zrRTJX5PXKokopJUU3BJ5Ga/DYDx2pSOpVteKf
         0angm6/wfHQZilQ8pogOcKw/1Co/qT3TLT/RvNX4GVPd2pBCEb5c16FlqV7aw86G8rhG
         vs9Ep3wKjsyqVrD4/2wTH9GJ0FhxhGP5CLjdp2EZidykc5WFi2qsO2DI2PuJEDIEA0sV
         uvhmXTYcTRkgH55DgJQx3P7C+owpRC5qawP7zfabiVQEhFQB9GORu+WgvSHXd5xtH0Cd
         IKJsCwylTc8UMq0ReR3Dg17tNVAhWZvJvvhylgnsfUumNdELCvN1X3AZtMSwuuzeHuM1
         hLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724685940; x=1725290740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVZxPwWU6fTdIbk77ZAZBmOWFDE8RmLRjC5RiWd9L5I=;
        b=S0PVaePXrezvXIVhZ/Ge/LHfvx1Dt7bqovWpavjyA3ecyQkCdow7qQtmtzSVoBqdIH
         YTLtliPUAJHjPy/+XHBz2Qw9xM9dRKN8qCzgIVwpQL02Jad67gUPNHBUtua6KoideGoU
         zuzt9Q9Siy0LiSu1H9IiEarAtQ2v5F3x9b2RD7dRHZ8nVmTnAfSyTN4REKnyKHbumQPL
         BbKnLd0QmtWqqnM1ge2lRe7CLvYA2VM+eLQMDEzxVpwkURdUbOJQTyZNSD9a59pb2Z6j
         NrhM8BGFIQdoavQaW/aya0L2YahA8qULS2zd4QO1pUPBiLMQGwpS874fwLy7FGBLH/R5
         VSaA==
X-Forwarded-Encrypted: i=1; AJvYcCWcmDEtoNqAM+RewrUgVgz2VubYQvLYID4vyjZFghuEhsfNf+Am3+RKfkZPoaEu+QSTwXKiRaJc8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx53RpdPA9Qs9BUqC4nHBUPaRXVJFQYmOc+6MKKsu1Wf7eFU0Bj
	7mMrmSmrlMozDeAdKYB+7nT3eZfvZ/oUQqKbZhrroPNjgqaaHKVQMgmEmpSFAWk=
X-Google-Smtp-Source: AGHT+IGqJgMZFTxRO1awmSGF6GW+2CPuDRMo7JmoLYQGXIKpOJ+edUP1SwWEqW7Tv6u077l7Xl+BJg==
X-Received: by 2002:a05:6512:b22:b0:52c:ddef:4eb7 with SMTP id 2adb3069b0e04-53438846f4cmr8424456e87.20.1724685939527;
        Mon, 26 Aug 2024 08:25:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f437d5fsm683005866b.99.2024.08.26.08.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 08:25:39 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	ulf.hansson@linaro.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/3] watchdog: rzg2l_wdt: Enable properly the watchdog clocks and power domain
Date: Mon, 26 Aug 2024 18:25:26 +0300
Message-Id: <20240826152529.2080248-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Watchdog device available on RZ/G3S SoC is part of a software-controlled
power domain. The watchdog driver implements struct
watchdog_ops::restart() handler which is called in atomic context via
this call chain:

kernel_restart() ->
  machine_restart() ->
    do_kernel_restart() ->
      atomic_notifier_call_chain() ->
        watchdog_restart_notifier()
          rzg2l_wdt_restart()

When the rzg2l_wdt_restart() is called it may happen that the watchdog
clocks to be disabled and the associated power domain to be off.
Accessing watchdog registers in this state leads to aborts and system
blocks.

To solve this issue the watchdog power domain was marked as IRQ safe
as well as watchdog device (as proposed by Ulf Hansson). Along with
it the clk_prepare_enable() calls from the watchdog restart() handler
were removed and all is based now on pm_runtime_resume_and_get()
as explained in patch 03/03.

Series contains also power domain driver changes to be able to
register the watchdog PM domain as an IRQ safe one.

Initial RFC series for solving this issue was posted at [1].

It is safe to merge watchdog and PM domain driver changes though
different trees.

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/all/20240619120920.2703605-1-claudiu.beznea.uj@bp.renesas.com/

Changes since RFC:
- dropped patches 01/03, 02/03 from RFC
- adjusted power domain driver to be able to register the
  watchdog PM domain as an IRQ safe one
- drop clock prepare approach from watchdog driver presented in RFC
  and rely only on pm_runtime_resume_and_get()
- mark the watchdog device as IRQ safe

Claudiu Beznea (3):
  clk: renesas: rzg2l-cpg: Use GENPD_FLAG_* flags instead of local ones
  clk: renesas: rzg2l-cpg: Mark watchdog and always-on domains as IRQ
    safe
  watchdog: rzg2l_wdt: Power on the watchdog domain in the restart
    handler

 drivers/clk/renesas/r9a08g045-cpg.c | 43 ++++++++++++-----------------
 drivers/clk/renesas/rzg2l-cpg.c     | 13 +++++----
 drivers/clk/renesas/rzg2l-cpg.h     | 10 ++-----
 drivers/watchdog/rzg2l_wdt.c        | 21 ++++++++++++--
 4 files changed, 47 insertions(+), 40 deletions(-)

-- 
2.39.2


