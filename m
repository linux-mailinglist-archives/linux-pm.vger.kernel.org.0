Return-Path: <linux-pm+bounces-26825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193E4AAE5DD
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 18:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706AD4C45A6
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6C928C006;
	Wed,  7 May 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez4UrsDX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE928BAA2;
	Wed,  7 May 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633711; cv=none; b=JygvX2iABYw6IOJFzDdnxA9JkKDhYPWzJcBqz/u4ExBPSMSaa4igG/im91Xtu6VaYyCcTZRd39z/s/XFgv0qVzWOIKG9njmo+UgeT/HutYHP+PJ5YHa9NpRS89UlE7nr1EL+bm+ycQt6LWXIYnHLBNDwlshs+03zTQbAkYYF7g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633711; c=relaxed/simple;
	bh=rrN21HlGP0Ki2awKpcTuqZWM5E98/Tgd/DrojYNhTmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FYvgmf9ynJbOLBEV2tzmcwE2M1etdDWaTUKBDzJ+lwzSaoY5XdFrUz4g1KUT3pdExyLrD0GBLH8QUAEPuJ53348dV6f1kp+WJtxhs9gUVy0l+VCXzxpk3sCJ6YSDxxODI5oGkfaTxIf3Pr7/f+yml1bnxHYNNXH5gqGbfzR2O2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez4UrsDX; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30a8cbddca4so81384a91.3;
        Wed, 07 May 2025 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746633709; x=1747238509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lcz+l8Co0SDC/cHtMO2vcFW8EyYc7hvrzUdAF6/dLuY=;
        b=ez4UrsDXaNU9OsEoHiU5p/TdAibM57Fni5kSWTS8LON8oeBBxgIV8mcnf0ZKMgLe3B
         DWg6JlQIyHqNLnCLLnGWXNelwNGVdpndAz0YieixuTQ1aSOPqCC7QEDOxTI4Y7rg84Jp
         HF20Omko0OnKu7adG27beJ7z389bx8Vjcocx9mlTNtUZ2kJhEpAFxjZVbVs7VK/d3RR2
         1uN1xuBOyOvUh5vXaVlp/sshc43AUBVMDMgxtKn2YtJJVaQZXtXg7SO0E6eih763bu93
         SDv7iWo4tdBQ+HKxhOzZtvHEeodm44QtoTHjG9DvjLMl8PyMmS2ciFwza6qt+A8s0Ryv
         iV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746633709; x=1747238509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lcz+l8Co0SDC/cHtMO2vcFW8EyYc7hvrzUdAF6/dLuY=;
        b=uPaCPkNgKArvkOjO+imKJWmzEFnKPG4mw3cmzrwRIiGKiRS/o1gS6Cg/pOheqUCBLo
         6vgh5VTWHKhjwzny1wbWraCGWLCLMwqnUAlGSs9UoA8ZbcFNrXrcOaSvOP0mNIXA10G6
         KI2eatooQFWu1/s1bu3NqOsPYngvNt4qA5pXmdEoE0sUlNItpE0zwEngjxn0CIfCKFra
         X8HK+3cSIk/E1ueIWzP4b/ZI/T58q4vox74PiqBhRP3LA0MtVMks/oVkoURj+GpuSeAo
         CvRufXsdmH4kD2Ke8x2husX4UdcviyB0ClPbnzpNNyGwjA5beMm/fkXRVUZBBLx8txCA
         3YPA==
X-Forwarded-Encrypted: i=1; AJvYcCUKLp9jc5wN2KysMcYizWaQMF9WiujrN6ENL+57wehHI+hqlkkbTiQynvt6hZ6A2vcNMTaxp7LDNuaM5nFQ4fgqyg==@vger.kernel.org, AJvYcCUdJycEZqfwYbmEzpL6zZCR91HR8cMv5JZKQG/+Zla6mJKrqMnR7KjgzjqxmoMZVQL8oujo9zgNWXY=@vger.kernel.org, AJvYcCWUiVJkiPvRXD9s9qZXJ5kcDjqrnPJL/LW7pAyiywdDFKtaMVYulEzuAb2BPfkdTcIk9rnsLbfXjMEQRxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4QCpHhMBXYBqsooTLJNYtebSHffEZVtPA9osGbMHMF5rKaMC
	XCcSgNryDki0aQkb0KLpNGG5dUKF9lgYivHF3HAV0Rhemr2SbBG7
X-Gm-Gg: ASbGncs+wTAMKO4TYDqMh3RcTkRTqPQEpzkHSGyrFLXAbJDBWXKDtborub0SViWdD4G
	FmCzObHXSurvVouVIZe1eIwugDXO9bcTKRsNLHJcODxb9FF8vGrNuKaJEaPgXP8BsmhC1h01+Gf
	KorG4hwVw8smTkST8PbMQ/TBhDQeP+mqMVgE/erjqTZeQXkAEf6Z4o7U4Uu1tL8FLOBYTl8badI
	yx8nBdnJ88s77kdWcpjK1f/lHcVVtdxMgozqeMmTpv8nsUY5QQLIsYySXkeeVKS0WCfV4+H+gKv
	tfeR+gS7Sx/AMcWKR6s4Q6txf1GeaOm/T1CShe9WlTiHW4wcA0S8PPZgm5T3QdE=
X-Google-Smtp-Source: AGHT+IHtf5ETBNi0g7KPKcGrpppl4GxmbE0GaRV9AigEcRMrHyTDtjao1tx6BacGw5smVf9EeZkAGg==
X-Received: by 2002:a17:90b:278e:b0:309:fd87:820e with SMTP id 98e67ed59e1d1-30aac1f04edmr5636711a91.26.1746633708633;
        Wed, 07 May 2025 09:01:48 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4f82b86sm327242a91.44.2025.05.07.09.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 09:01:47 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>,
	daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 0/3] remoteproc: imx_rproc: allow attaching to running core kicked by the bootloader
Date: Wed,  7 May 2025 13:00:53 -0300
Message-Id: <20250507160056.11876-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

For the i.MX8X and i.MX8 family SoCs, currently when the remotecore is
started by the bootloader and the M core and A core are in the same
partition, the driver is not capable to detect the remote core and
report the correct state of it.

This series of patches implement an API call to the SCU which will
return the power mode of a given resource (M core in this case) and if
it is already powered on, the driver will attach to it. This SCU API was
already being used inside pmdomain/imx/scu-pd.c driver, therefore it has
been moved to firmware/imx/misc.c so it can be accessed by imx_rproc
driver.

Finally, the imx_rproc_clk_enable() function was also changed to make it
return before dev_clk_get() is called, as it currently generates an SCU
fault reset if the remote core is already running and the kernel tries
to enable the clock again. These changes are a follow up from a v1 sent
to imx_rproc [1] and from a reported regression [2].

[1] https://lore.kernel.org/lkml/20250423155131.101473-1-hiagofranco@gmail.com/
[2] https://lore.kernel.org/lkml/20250404141713.ac2ntcsjsf7epdfa@hiago-nb/

v2:
- Order of commits changed, now "firmware: imx: move get power mode
  function from scu-pd.c to misc.c" comes at first.
- Updated commit description of "remoteproc: imx_rproc: skip clock
  enable when M-core is managed by the SCU" as suggested by Peng.
- Removed "imx_rproc_is_on" function and dropped unnecessary include as
  suggested by Peng.
- Email corrected: peng.fan@oss.nxp.com -> peng.fan@nxp.com

v1:
- https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/

Hiago De Franco (3):
  firmware: imx: move get power mode function from scu-pd.c to misc.c
  remoteproc: imx_rproc: skip clock enable when M-core is managed by the
    SCU
  remoteproc: imx_rproc: add power mode check for remote core attachment

 drivers/firmware/imx/misc.c           | 47 +++++++++++++++++++++++++++
 drivers/pmdomain/imx/scu-pd.c         | 29 ++++-------------
 drivers/remoteproc/imx_rproc.c        | 17 ++++++++--
 include/linux/firmware/imx/svc/misc.h |  8 +++++
 4 files changed, 77 insertions(+), 24 deletions(-)

-- 
2.39.5


