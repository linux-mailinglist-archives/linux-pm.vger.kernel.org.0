Return-Path: <linux-pm+bounces-32424-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE00EB27A90
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 10:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8DEAE15CD
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 08:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0145C21FF3B;
	Fri, 15 Aug 2025 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stJr1OdS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382CE22ACF3
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245302; cv=none; b=N4vl/Ec3cJxVF0WEayNGgaFHkpj5CXGWdaw8wSTdd3KBPfomZ7VlaFDQ06XY1mZpXiY74jLk1yGqyDMer+NyEQXFRBbleraCMxo/jzl0UELotC2bMdB2XbYI9G212ERUrCG6DOCqGOK2sk0GagfNrjeHggmmfIOPmJUrTErOlKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245302; c=relaxed/simple;
	bh=8A4TDN9tyEYv2858Q76tEWkh03e0+gd/EEe9+NAgsL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GqrR8MdGwj86v+nAwkP7aUs30Nf1TXNpwn2eUltgMfL7JJS9smSCDDNW0XGuzo4PauTdTKIVFHMCWc/UTqdZdtZy/hwxgmpGkO26gBdUEPsLmle/440umciweKIjYt6mYto+a85tqGYDG1BGXL/5oY0dr3FH7pHcLFgHr/LsiDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=stJr1OdS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55ce522d6deso1505830e87.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 01:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755245299; x=1755850099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BoUNg0NWnSD1ZMcCTQtaEQNN7qPQ5dP9cFU4cMtk98A=;
        b=stJr1OdSTTnVsuFpenyV9XRJPijuKibc5XwKBy6Ok/QPgPKoVtP3PHgTId9p8/JWiF
         EWjSeR6p6ALkHfeab17HtmJ8ZdvDn1tc8Q71vvNR6kBLLTsD8n5j57CXVn6ktGYrX2iv
         Ku0Tpsv8BiGzlCI0dmSggIKUWgSGhYiHtxC8getawUbAgTrozfam3q4FlQBA8E3CV5rK
         wFb6aq7ayF8I/5+a0UPIYqHyd7fAgh7rY0AwrOgjJW6LiVa8Nu8EXxnLT2lCLX09PEcZ
         zILgdIcBu7AUa48J6jZRv+ne9R9wneumyUS76qRkmHG3mNoCX1P6phMly3jr5jDSKjSE
         t2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755245299; x=1755850099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoUNg0NWnSD1ZMcCTQtaEQNN7qPQ5dP9cFU4cMtk98A=;
        b=ceV7++PB7Ica1qfvTOo+qpcWqai2omoWTssluYhHDXmgWY4WeI3bGXGxSFQLYxxUq0
         98j19WwjbZohB1Z6RHVtggsvjsRTetuiFTqI9BkMtGsocf/b/MpfCw/FjdDkrGKV4tin
         9MSHEvXCoBFQYQkm2lQxatggwx5tBXeP4QkwqAh2WL9s1jObBkka0jczF2mfnkRWZC/z
         wjCbwh5pDCSt0jd1uaLwnv1FZGnbxyqkMn4e/fHG8VeGkGypVBD/iupXYXToSGOMqVZL
         hwXpewOvCqke2pYVOKri7fVpO2mnON+osxf+Du6IJO5+Xxh08JHuhYLcLr6ComCKcFcA
         8jLA==
X-Forwarded-Encrypted: i=1; AJvYcCXEVLtoB9VrKM5EjQaqNBNMTmUuZw+beiswCbyhFG0pv0pJxVC/5KFcCML8t8v3t312RQIdOgJxEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZhyFg4mQvI+THVLPu09oHmEOK6IcCGhZEVPO1DgbP2/8pUHa
	Aj+oSkwa8iq6I0zXg/KZd/T118jBIhJMO4XZKtBdPqZALowDLwOsNoJ2ShRQH8w97QGZY2dzl5f
	ISiQR
X-Gm-Gg: ASbGnctsiG6idwU62YBoYCin80XLarzTPq5CCSXYwpygTcvsEnyLfU/ZO7FDuq8qdGl
	JdGfYzTCUwaK15VuaW93nTZtMihIrdANrjd/GuRp9giIBBugSsxRWTUoFBwlFYD+Dr62A6G6xcY
	C8MCUx4cxBFYKo/vz3sfZJkCg467EIqKDDQ0DGPHZdDslGvybCF1MztiRWpaLhVoB0/l7iIr8P6
	Zuq80tAjRHhFwbRevnM8wFlmj5ZSHphh9umgSrsrxoTVHIS5bpHb3ElsRdRzdVkF7F6VTJoMnSs
	4lJDrYBCXS1SssMFgHiihCzlKxdvY/sc3NIa8i39LNNo8kLjnLIYWDw5/xzD+ARSPnGkR3jPwFP
	AT+Y6oJKAdyGA6DczD85TxJ3nSkEXeTe/zCtYg4kItUYVp6E9AfxH37UzX2bVFRlbpE3OMSpl
X-Google-Smtp-Source: AGHT+IFt90Urrmo5HV1l7Yk3jJuUZrJK1egAUyTZX0v29li6VQluDLCOt3n47gyYnDJrd4tjNDr5Kw==
X-Received: by 2002:ac2:4bc5:0:b0:55c:af6c:db58 with SMTP id 2adb3069b0e04-55ceea048f6mr305717e87.8.1755245299163;
        Fri, 15 Aug 2025 01:08:19 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a645d21sm1925151fa.70.2025.08.15.01.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 01:08:18 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.17-rc2
Date: Fri, 15 Aug 2025 10:08:16 +0200
Message-ID: <20250815080816.282648-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a pmdomain fix intended for v6.17-rc2. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17-rc1

for you to fetch changes up to b6bcbce3359619d05bf387d4f5cc3af63668dbaa:

  soc/tegra: pmc: Ensure power-domains are in a known state (2025-08-11 12:24:43 +0200)

----------------------------------------------------------------
pmdomain providers:
 - tegra: Ensure pmc power-domains are in a known state

----------------------------------------------------------------
Jon Hunter (1):
      soc/tegra: pmc: Ensure power-domains are in a known state

 drivers/soc/tegra/pmc.c | 51 ++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

