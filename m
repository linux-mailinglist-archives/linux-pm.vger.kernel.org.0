Return-Path: <linux-pm+bounces-542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DCF7FEDDB
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 12:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6340C1C20DC7
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 11:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD53F3A29C;
	Thu, 30 Nov 2023 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrqFx3vg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15AF1737
	for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 03:29:31 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9cb021d5bso6284471fa.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 03:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701343770; x=1701948570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7b0ctZB3CE38lmBqwtgKLVcx66/DGir1aEMPMaEabH0=;
        b=xrqFx3vg3Ibx4bpkv7/4/C1d1Dt0mS7SqaOnUHzLukJ2OzMaxnyARUQInMuncrHi0K
         bw/8tSG2M7dnbay1ZXEWWD9jrYFH07aFyMxb0iyai8XN8gHbkisDQm4CSaFMgA+NF/hp
         JG04UEpy92iabPWXEE29rGH0crCv2eZ4WeAhNVloEjAvVTMjv3+eh/s3wmInwlc1lmUq
         C8Q1rPsal2DemFMDE9R5J4tjnBLfntvML/nRfrFZPw7lV0W9ujyY/M3+5c+jQgjtPwS1
         REvrWSt7Aw/5q8Zdk5xQYHDV6QUMJxDYCPJuwpjRwtYlwzj15DgYq9Y3OLCQkHddTwRb
         XxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701343770; x=1701948570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7b0ctZB3CE38lmBqwtgKLVcx66/DGir1aEMPMaEabH0=;
        b=hQEf1MRTHkUBXP+/VcOQRN2AxssBqKzMNTwXV0y0XlFpFsdbHbmI2R5Gy6amWFlmDN
         txKGmp0qkzrVxoSn+Hm3aaS3l8EyjIN8TfqTKHmjgwbRf3idtodhkqiKJNf9qFe526oD
         /k7IEXrpTEiT5IAbf8mYOLq/yeCDRb/QOcFNZ1ORMc0cISw1hZpl3S99TG/UAJp634F2
         tXCNM4DjToJE8dq0j8oiItK7eDHFrZSVo6FG+Jcuvm5eC3NSqbxehritQ0udBvKb81+z
         GAcYwsRncYvD1fDrqRq0bXePiGfcDI+MUblomW6hdNKa+fgFvB0vAOkEwcQUcWNP6mVY
         /uQg==
X-Gm-Message-State: AOJu0Yxaf+xqcF7n7ZM8M93h7EzMCptySEl6emWiv52blZ1jurznFjUZ
	fnh1H42TdmBK7XD6+Mlnb0mMjw==
X-Google-Smtp-Source: AGHT+IH6IbA/kyxQtBUcbHuHxAbxWUMG9Zg32mPrWbotuU2rIkBPL9Lmpdf737cOWxT8yoLNLJ/fEA==
X-Received: by 2002:a2e:9e55:0:b0:2c9:cf5d:af56 with SMTP id g21-20020a2e9e55000000b002c9cf5daf56mr714828ljk.31.1701343769906;
        Thu, 30 Nov 2023 03:29:29 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id f15-20020a2e6a0f000000b002c871393f61sm118960ljc.72.2023.11.30.03.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 03:29:29 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.7-rc4
Date: Thu, 30 Nov 2023 12:29:28 +0100
Message-Id: <20231130112928.64992-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a pmdomain fix intended for v6.7-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.7-rc2

for you to fetch changes up to 0cb19e50a911aaadf49eed120392e429d6e1fa0c:

  pmdomain: arm: Avoid polling for scmi_perf_domain (2023-11-27 16:28:20 +0100)

----------------------------------------------------------------
 - arm: Avoid polling for the scmi_perf_domain

----------------------------------------------------------------
Ulf Hansson (1):
      pmdomain: arm: Avoid polling for scmi_perf_domain

 drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

