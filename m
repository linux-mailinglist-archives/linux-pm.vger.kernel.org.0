Return-Path: <linux-pm+bounces-18685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5F9E6925
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 09:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CB118838B7
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF611DACA8;
	Fri,  6 Dec 2024 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dk4BXXGh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF006FBF
	for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2024 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474439; cv=none; b=uhvXbk9oYubjSYTBOvS4H8Nb+NC/GjIdwFT9l71O3vItoAMHbtYaQdsBcXBORziaOMUAxmPP30Mxp6p+Dt1u3O1zdC6QxEkcrtx+YwesHnt1wJ45StZrp2JTta53Ew1T+nZ873kcYzyW2kq33J/Nf9t7dq+0LDCtMHp73MXEBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474439; c=relaxed/simple;
	bh=OkwL0QgGjHbpwOJvTu6jbAUyXPydHvv8mamPZjhsB+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVYwaPj/oNKp2R6LlpOLPBOHGcqC6g/ePwUrCWc5grI0w0L//UrI3ubn0SbeJiBZd06tM05wvXQ7PI6TYDwqRbj471kW3FH/6YND5VZd9s31K8rebkyUQKmUt0Xe5EULzRyLXcB2wcEK3CQFpKnL4/lm9n+h2E608yYMHrvlmjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dk4BXXGh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53dde5262fdso2320985e87.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2024 00:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733474435; x=1734079235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8VUSVD5d4Al31C/uHXsnAW+QuZilX6JYMkj8nRl9R0w=;
        b=Dk4BXXGhjEnRv8zY08ah9CM4X9IMuvJjLOxUqfN5SQ4Aj87qJSydByKyplGeB7xJAN
         0GGEbAqTSE0p3MHnEPWY997Td32DoMrOXtbKpB0cjRR0XgF7S+5qIXoCsTe+lt/jTCI0
         McCKtaiSwSN43uGfGkN5wj3V9qgoi/KjSHBLfRk8+sz875KGLdR1fS/lePeyMX6p9oV+
         cs0MxXSxerM2NGSljltkjbVhHFuicF/g5ZuBEbCVCOZdZduEcfz+ocKMSfSSNXBEYSq/
         bK1y2uKlDpCkByGFnVdEBkX3VFoYewM48Mw4oVqiDkDu6o3+wFMfJmWAHIOlVXbugL35
         jN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733474435; x=1734079235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VUSVD5d4Al31C/uHXsnAW+QuZilX6JYMkj8nRl9R0w=;
        b=oD5Kb2MhqSP64euu4tML/Q96/g0s04eePqrLojBio0vtmu/AvJtAaJuTq8s1l1/Dow
         3T8eEy6umLjzRgLObzpphTsFJountsvkj8GlNqYuDV3wZnlPj4pvyoVS9NwZBLjGthM4
         D5SQHBeaPX/usMhArK3NpmEIhYFFMHJrsJtm+UYuOg6IH81ZcMrkshEVR0e0d4mcnIDD
         eKPY5dEDebFSge8YCoetw9Cr9zy+4axg9mQvnfN4/1FgHzXQyZ8nR8bZVobtu2Rf/6JR
         482roTIpi+4A8r7t3wCv913fqKKUwzjroOV169kXRGi0FXQgjjRrXZE6maVNITIpQRzT
         5BMA==
X-Forwarded-Encrypted: i=1; AJvYcCWbacrI1qDMX0T4nFTb+NeKIJBGk34DYE31M1T8eRMYnOZZLMD5i17O4ivSJGtqjXHnZ/wQ+SM0Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPlhNkXPrw6xLV3kuRiP/MAcr2hV7tajzj3jOliccYmhkmFEg
	AfwQHPA9XLtzDSFQyEzRnO7NHvNFG4kqhFsIp97H2mWJfgEAcmqDb1kivK3LEAtY5CerNgGO6mP
	+
X-Gm-Gg: ASbGncsr0JEUIBhZ07ui8HctvzlmCHEJSmT6GtvFi9FZcWpgTMZYIfEeIG2V2ptj7Sv
	KDvUjnUgYW2m8wpIEpymjQLW8yz1DJypRjToiHP0ScvyQA1wkRUcKcuAu79NFsJ0P0XONN87k0s
	s4iUVmHXIaXS1PXAcrCo99G5RW4yKH4axMjDS4ILEAOvjmLSJ2faQrwqb7k+XMgWh1XXaI+dyaW
	GN2AtH1Wv5WBTS8cJgYNoMs0VMo0nNos/QnLnoveOlRm4o7glmuq9/LEQBosDS0Q+HNJLbeYFB7
	hr/SkfH+CiCwwg/mI7jDLzSw
X-Google-Smtp-Source: AGHT+IFpuj5t7B9JAnco0SLRdwKPzD3iDmQdoSabd9nUYzKXx43l+NudJrIm2FG0ufsZx+78hIKN8g==
X-Received: by 2002:a05:6512:e9c:b0:53e:1fb4:45cd with SMTP id 2adb3069b0e04-53e2c2eb652mr1210445e87.41.1733474435296;
        Fri, 06 Dec 2024 00:40:35 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229751c2sm440973e87.106.2024.12.06.00.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:40:33 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.13-rc2
Date: Fri,  6 Dec 2024 09:40:31 +0100
Message-ID: <20241206084031.119041-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of pmdomain fixes intended for v6.13-rc2. Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.13-rc1

for you to fetch changes up to 2379fb937de5333991c567eefd7d11b98977d059:

  pmdomain: imx: gpcv2: Adjust delay after power up handshake (2024-12-02 17:09:26 +0100)

----------------------------------------------------------------
pmdomain core:
 - Fix a couple of memory-leaks during genpd init/remove

pmdomain providers:
 - imx: Adjust delay for gpcv2 to fix power up handshake
 - mediatek: Fix DT bindings by adding another nested power-domain layer

----------------------------------------------------------------
Fei Shao (1):
      dt-bindings: power: mediatek: Add another nested power-domain layer

Shengjiu Wang (1):
      pmdomain: imx: gpcv2: Adjust delay after power up handshake

Ulf Hansson (2):
      pmdomain: core: Add missing put_device()
      pmdomain: core: Fix error path in pm_genpd_init() when ida alloc fails

 .../bindings/power/mediatek,power-controller.yaml  |  4 +++
 drivers/pmdomain/core.c                            | 37 ++++++++++++----------
 drivers/pmdomain/imx/gpcv2.c                       |  2 +-
 3 files changed, 25 insertions(+), 18 deletions(-)

