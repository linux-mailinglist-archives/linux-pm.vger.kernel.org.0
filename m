Return-Path: <linux-pm+bounces-27963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 578D0ACAECC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 15:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E601BA0CED
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 13:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7E8213E69;
	Mon,  2 Jun 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOQpJ1Vm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2E95227;
	Mon,  2 Jun 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870389; cv=none; b=jdbWbSvtmJioimYH6TxiHYVNPGCrlplbVqMzCIlBO+ve0LbM5lq61FAHfE+d4ndYoSQ7FAJ6rMGR35vZFrHhMqwX5b8zAOz165frgNqk5wlSab1BS9tR9poEYB1SV/wDTGdspYOrTfPyda17buOA8uAS68HtHrv90CF5cP+gjZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870389; c=relaxed/simple;
	bh=UxGEKXZqr/JaIi0rMXu3vg+WUXFZEFThlv9I/oaHoDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H4MHk6BkH044AauMoGcOXiFv1Z4/+7dy33Vjm5GtC21D29Zqyvjx/Idh0XOjuZJ6JAHn3p0hQwXvdhUGe0nlFn/Iz1Voviv5ojNZtkqXOO4HRhygRWFalxmWzErlV8fa3NeOh1Qr9n40NfIp9chgrinK6GvxM49cu4v6pTFYNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOQpJ1Vm; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso3015401a91.1;
        Mon, 02 Jun 2025 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748870387; x=1749475187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2pWQ8XYInPzY7yzvFzb84/7Ia0EnVFU8WNL68zGHlw=;
        b=EOQpJ1VmyTxByW69ygZWWDI0yb2LCZhzGZUNA6TNUkm2uPEZZUuz4UP5KHttBMVTP0
         9VOisYX1gvaq/r1/IYwrTI62s8VUT3EHca7Zz4jq54lmK3QC5qon7tlFx3HJR6o43uVN
         N/Z0HsEVpw1Elw0lqotVwc3o90E+f8H2SV1X5d+NISWOopXP5sSfIywT8LqcT1X/5aOP
         atlhKoiA+eU9LRhjB+cyGGQp3RHO6gTWd/7SCnu5yBQjFu/Ip5NjOa98BFrUM2FHsjQq
         Lee8bP814KC34HSv8Fs0qJHIZjRmGLzYYG5AIUfALc/KXeL0pmML4kk59HZr5rFSxxGO
         exOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748870387; x=1749475187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2pWQ8XYInPzY7yzvFzb84/7Ia0EnVFU8WNL68zGHlw=;
        b=eagfQT+tLsQbBPg2N3RmR+Yytx5CUwcIX/ofgZWUDUtargkH0pWNjCO6oPjY4r6V98
         GwJhLHw4/AJ0IsWaD6fuvQpgQ4HPYMjyQAUgPSQTGOzYM3Vbt2SXiN89XcsLWBc3yUT7
         gtVEnWs9Rs6K5YVj0wTvo5VG4UhIyE7uDONrG5sajZqBsTlt4MI3T/7TYOqfr2KQC6LD
         XqgSqKGD6yg1IR/2IEhAp83oZg624mP+1q8gKthUOt0g5z3QAZx4lsoa1rSaYO/amEyf
         khVO7seoDIXvYtsafBu3J8d2o/mkKY5/enf410YWdvnEQk87v5L4lgd23eOKfEUYznPo
         HLVA==
X-Forwarded-Encrypted: i=1; AJvYcCV5GY00X34pYdutgccNlz0q0AZKZpJ4gKoNAMcO7zRGfT2UtLdyK5hR4gb8p2tPXRG0BlIB97G1dxaruaIrtprfWQ==@vger.kernel.org, AJvYcCW7a+N4+ITdGpPCgT63s02QdLkLxzgrXogNMzTmvu+Tpak0VJsKPfV92vnIfKKKaly3gZSC5EYekBQ=@vger.kernel.org, AJvYcCXF6Pwn09h+oLDCEhidH8YetBuEawGCd3V9uYv7HSiqT2aM+c3q7DYJlTXKveY8C4E+9bgZ7115sdBPjtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEFrvZExDA7Qa6PG/r35JuVoHhpBXN7J2mMadylW3kv5dWuuC9
	cLk9Q2l+LpExzZaV13sVr9nkfIbc1BrmrqLLth6FIgPB+q4Wu+FKICLr57QTzbqL
X-Gm-Gg: ASbGnct7WtkoFjJUbDw+ImTPuknAd/rEnjQxDa31Yh5S4rPMFuVovzV4YSedAFEnocS
	J8LdzbVx+NYSbBNoIGCQ2qs+og3PPdxYqKoK7ApG8+mMk52ExCUvy52O+0+DWlhkQ8eSkuGTqpl
	KkCby2MFrZ3yKvKVeuEksBE/oFdFHfRHYnocr/yqJ3xycGmONg8KGQgG0AJ5l0hOrXVmmvRBiss
	auyJ++euEZrd+VrASwggwx2GiTYifgtbNxgklMUjWjovNyYds5XGLORSvjriQO3oNaluuOEf1Nk
	DxeskcC921h8gju51xgjAnTSisRQtuvz6PkLmY5FJ+70T7Xw8g1j2vGpdgTOIbGHSHcR05rVyQ=
	=
X-Google-Smtp-Source: AGHT+IFDyEzGFaym1wpwRqsblj24xGVKJRt91HFE7nLSINnTFLOY+Zcd+cdYuE1FMCys07O3cnvoUw==
X-Received: by 2002:a17:90b:4a0d:b0:312:1d2d:18d9 with SMTP id 98e67ed59e1d1-3127c6a9969mr11777603a91.5.1748870386764;
        Mon, 02 Jun 2025 06:19:46 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2b67bcsm6130983a91.8.2025.06.02.06.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 06:19:45 -0700 (PDT)
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
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 0/3] remoteproc: imx_rproc: allow attaching to running core kicked by the bootloader
Date: Mon,  2 Jun 2025 10:19:02 -0300
Message-Id: <20250602131906.25751-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

This patch series depends on Ulf's patches that are currently under review,
"pmdomain: Add generic ->sync_state() support to genpd" [1]. Without them,
this series is not going to work.

For the i.MX8X and i.MX8 family SoCs, currently when the remotecore is
started by the bootloader and the M core and A core are in the same
partition, the driver is not capable to detect the remote core and
report the correct state of it.

This patch series implement a new function, dev_pm_genpd_is_on(), which
returns the power status of a given power domain (M core power domains
IMX_SC_R_M4_0_PID0 and IMX_SC_R_M4_0_MU_1A in this case). If it is already
powered on, the driver will attach to it.

Finally, the imx_rproc_clk_enable() function was also changed to make it
return before dev_clk_get() is called, as it currently generates an SCU
fault reset if the remote core is already running and the kernel tries
to enable the clock again. These changes are a follow up from a v1 sent
to imx_rproc [2] and from a reported regression [3].

[1] https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/
[2] https://lore.kernel.org/lkml/20250423155131.101473-1-hiagofranco@gmail.com/
[3] https://lore.kernel.org/lkml/20250404141713.ac2ntcsjsf7epdfa@hiago-nb/

v4:
- dev_pm_genpd_is_on() introduced to drivers/pmdomain/core.c
- imx_rproc.c updated to use the generic power domains instead of the
  SCU API call, which depends on Ulf's patch series.

v3:
- https://lore.kernel.org/all/20250519171514.61974-1-hiagofranco@gmail.com/

v2:
- https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/

v1:
- https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/

Hiago De Franco (3):
  pmdomain: core: introduce dev_pm_genpd_is_on
  remoteproc: imx_rproc: skip clock enable when M-core is managed by the
    SCU
  remoteproc: imx_rproc: detect and attach to pre-booted remote cores

 drivers/pmdomain/core.c        | 27 +++++++++++++++++++++++++++
 drivers/remoteproc/imx_rproc.c | 33 ++++++++++++++++++++++++++-------
 include/linux/pm_domain.h      |  6 ++++++
 3 files changed, 59 insertions(+), 7 deletions(-)

-- 
2.39.5


