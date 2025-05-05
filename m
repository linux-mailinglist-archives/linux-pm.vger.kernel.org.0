Return-Path: <linux-pm+bounces-26652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BCEAA97DE
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 17:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BBA1179608
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6633125F795;
	Mon,  5 May 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBx9G3Ez"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF125E464;
	Mon,  5 May 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460191; cv=none; b=qaquadKgHSNy+q+tHdJxt7L9OySmWNN/VDuknx2OWSxFUSMCgsbyU63vbimsF9nV/BuyftrVHL93gtKsUvpsUi1OhOcu3+oxNCDGQyELrZVyNc4aRJdEeuLwVQTSzkttJBIVj4sGrjN0EFFYFau1VS/NXs1yoULexPF2/30Ja7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460191; c=relaxed/simple;
	bh=hXB5HIS3f+ZCRt/681Lhw22MgJ3Qq9wuAw99RftnTZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PNugqv82YcSJWve43RAwI8GXJJwwuaZjvHiKnsa3oMcpZsPPK5FEcLYkUDxEOG5kflKdI5/UEgpoz/RWhugljaok54aOk5zvFfCiWq7DEPeevaHoRqfoOeYH9gtIW03qjRB8CI8BjCy0UaQs3+ykizSdhfzRa8XWX/2dU7pd4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBx9G3Ez; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-604f0d27c24so1976745eaf.2;
        Mon, 05 May 2025 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746460189; x=1747064989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TfSasfyNn2QOSv32qDVaYS8lEHvMrqjWB4CpFRqIp8o=;
        b=ZBx9G3Ez52HAXm6xtsSA66KRYGrPgwQTXrkA0Iq+3QBhEig8xiy/6paG46whKX7laf
         nmnCRV6M7b5B7bQ/7jeQ4+JSGUndDAdYvh4sun499DgiWuA3qNU5yrbk5NQ+pWbt0XMT
         80A2UcOUhD8+0a6XEkQraGAKNIHeh/J2NAuEPajRaVeV17z8j3i39yi5a/7sdI4kG6KF
         vMnQC5Wxp+NiuCl9DSqruACi7UijIHjdLgvFjEBbia509yylA4aO76WFbT3+z6QXWJdn
         dUbQM0pTMpKxBxYDSAWlkGG481ZCbfFICleJPRAWSQANfjVaczIspyukk5kYmqK1nXeE
         foKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746460189; x=1747064989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfSasfyNn2QOSv32qDVaYS8lEHvMrqjWB4CpFRqIp8o=;
        b=Wyk6fUeBoVcRDyoZISkfBryoCXxfAtucfTycNN7jBLMXPyXB7W4z9BX0wHrWksTAqO
         2oWYtTx1tGk/4Tcre2ZgF66/OSeXA3R760UvXYfUCzdydBOZmjRQ+90Pd7IQ2F35I2cw
         uYvLzBVD5xBeAkhhXldiyP/I6Amfyk15LkCipkd0zuH4u4DBz1cZO6cE0w2yO3xreIoM
         /jimmGYR68yretkTBicZv2EyNMP5aptpIL4/5OKMA6s2NcQ+W8yfMZtSs5XfKLkU8w95
         PxyR5zb/6H5ZJ4epooEn9LqBhRbOrqYrgi+oiwkCYFrim2c2h/WiQ5N5wMBSjwZZFm/p
         GRgg==
X-Forwarded-Encrypted: i=1; AJvYcCU43l7lDM2ysFqZgjJzLjcTEfpMd87cpuJE0HgHJELLPfY42pnRuxSZpP0ZwdA0fu0KrFG2M4p0MLR6kBk=@vger.kernel.org, AJvYcCUoHOlfC1wmzKRg57YeRKWr2umHmTeW31BksQY1qw729HxMxvv86HwbwYxl+DRag+hz3i0wh5AlZFI=@vger.kernel.org, AJvYcCXoXfIDzw71wut8I/U+fYVw7AZOdezMPabnzBHSrchFkyiOYeOOoNmMuAsqLG/dtCPDdDVJULEKJkFa8G7i4JLucg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7ZnnqYk7XEJmkBusWESaZCZA6Ly73IfOUo3y5VSw3NZvdABg
	xVFN2Mq9A85qPjQir45bTLWpBkxfr5E45F73cNmNRWHX6Jg5UJdM
X-Gm-Gg: ASbGncsObCFDfy27cYMzhkcMrenlTKApfkNDem8eiku+D88TArBo4v9eY0/1HkiZF9D
	GIusHC8wLMWG1qgCQ4ZCjMdB66vzdUTjLjtn8f2WhF9zqpU8unEU3cCPzJMV8v16QDqdrX7THDJ
	cW/18hwDxVSc7Ji7mVp4BkEUOQziGQPAb/CWbtixrDcci9RSzc+KOyiTHf3IS/Uc3thzR22BAKU
	4UXrfzOMzLxvW5laRob94WZ4dJLFFGWNTO+7Yeya4BDxR0ZbG5WR06fIy0MdCz61xsxyQTzYOCq
	K+AdximZc9yg7H/eI8lSUGCiHBKnxruHQfWwRcuYSjFyBZiNUbBMtuKZpyGPFPNGaKrqM4oRyA=
	=
X-Google-Smtp-Source: AGHT+IFxZaRAPndA18lDE7ChWtiEoMGY9mLpWkb2iP4H0PkM0TVxr3eZLsRh+qcaLAy4IFe3PQLjgA==
X-Received: by 2002:a05:6820:c81:b0:606:8bce:32a0 with SMTP id 006d021491bc7-608002f986dmr5907169eaf.7.1746460188788;
        Mon, 05 May 2025 08:49:48 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-607e7fe84a8sm1606217eaf.36.2025.05.05.08.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:49:48 -0700 (PDT)
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
Subject: [PATCH 0/3] remoteproc: imx_rproc: allow attaching to running core kicked by the bootloader
Date: Mon,  5 May 2025 12:48:46 -0300
Message-Id: <20250505154849.64889-1-hiagofranco@gmail.com>
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

Hiago De Franco (3):
  remoteproc: imx_rproc: skip clock enable when M-core is managed by the
    SCU
  firmware: imx: move get power mode function from scu-pd.c to misc.c
  remoteproc: imx_rproc: add power mode check for remote core attachment

 drivers/firmware/imx/misc.c           | 47 +++++++++++++++++++++++++++
 drivers/pmdomain/imx/scu-pd.c         | 29 ++++-------------
 drivers/remoteproc/imx_rproc.c        | 27 +++++++++++++--
 include/linux/firmware/imx/svc/misc.h |  8 +++++
 4 files changed, 87 insertions(+), 24 deletions(-)

-- 
2.39.5


