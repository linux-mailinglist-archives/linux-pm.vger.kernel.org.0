Return-Path: <linux-pm+bounces-28919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807FBADDC73
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 21:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADB04A12B4
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 19:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3FD274FC8;
	Tue, 17 Jun 2025 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng0kFYrl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7823B61C;
	Tue, 17 Jun 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188962; cv=none; b=gklraFLDp8RgTxfj48TN1lAzmi0h5aLcBSHka8qPQ5E/RwLA3bkWM80m4tFmtlk4aVFItnwPsLMMvWfbmztad+VwTRxJScJjSE6gFaSAGQZbBOPVW+gYoQD/0ccUw3qQB0VIYNBM1/a6evPzOPkSnDHdQ99CID9F6UlWRNoSqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188962; c=relaxed/simple;
	bh=1uEeGF9p7kz9UCL3FmlVdwCP0lAngpPAygjFaSOXfyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BQqO+JJ2z7nJq1YR2XkJLlC1FA0Y8NAg3ntaWJnTBzHuYmXKIb796XmxRbRtXuPto/Gub+yIUwqdwjXKVeMW6jeXpAYcT6R82ZmCT6ZrRiocLuGqo+zMIY6nPkI1Rgbqd4ulO+btxDoBF+4tcJslGYsTMerAigEndzuhdj3rxRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng0kFYrl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso6566568b3a.2;
        Tue, 17 Jun 2025 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750188960; x=1750793760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ticf1f4PmQmZwFcANzazYxHsrbux47xCzbGTbFHeNUw=;
        b=ng0kFYrlmN6D5tQn55FtzTIqC7Dp0+q68c16oN3DJTYfsspEJaEl82aF9kY6oGBnkN
         gCikSVXbXtFTHPQhGXmVWAyEWWDcBn3IAC0wHc00AwfHoW0lzCQvjqZlCGkf39/8gIwU
         yvrVyYvgQI8hzyY1w7S5v9VZXxAdKFxQTxjKUnoaAR5pL3pBnknjZ8YaEPUJ2hC52r8h
         PXJIJMQkBzIJWM+fOERhi2/Akuk6PykuGakhW2hP8GbhbK2Q7A2QZY1C4+C3sHBR3O5J
         E2ElfUHKrPJQsb8XRze548CKoCFd+UQViZsh5Ayqs+T2IY6LLOlDP1iKhw+FQVo7zKXp
         shZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188960; x=1750793760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ticf1f4PmQmZwFcANzazYxHsrbux47xCzbGTbFHeNUw=;
        b=Qj2miSYTYpxzrat7Iyq+Ek8ZNMJp2EaTC7b747QYyi/FGE5a5u5leO03tI5OxhjoKE
         XLB6oJ9EONAKhfS51dwVcWLYMR3nybqR6DRwE2HrZXDVFnoXnnmwWwnBx/b//YdlWyPn
         5il9rSGk/ECl60whOmQpcdWNGPHZQooezWD80nD1ZW677ezrd6pHZ6smrrc0TqiIdv6F
         CjmVXehrI5WkJJlou27w9uZ1CkXXd6EaueWVGiU1oOrYKOb8BG9FWGEJzsO7c4sTyEoA
         SnpEtL/i2Iw9/LKfx4VqUtwXyX2co9T23K5PEwY5wK8MZQS2pXEOwIkMMH0mXe5BbrT+
         aPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTb66yU8QLMSTbiY+39c89WnX7Jm5PFDyFWdeQlB3tEmgwQ3QEmB2LAVS7GI2RAOpf0m2EcgjNNf0=@vger.kernel.org, AJvYcCVucujthUnmsvCL39DhsNB+cjdche4FlNwgK5XhhbnBCj78lAE+VGvhT7GrtxzXdEDXDhtmiWAUJSkScC3j2g8MZw==@vger.kernel.org, AJvYcCWtLdbgKohE/iCUHqI4z1ZUtHRTk+l3TiBG2a60X0O8Bkt/gz0e85zaqpvWXQ1YDFrHMiZnKZ4wUvUUl8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDPcHmumA1URpFNGNStP7h6wY8Dtn6aom9Kq4XJfsZ+HzRgRem
	cdBmJ0mketrL+zP//8vI+7zoQFuBMvhBjP+Dgc2Qxj7ta29uSJExw3WS
X-Gm-Gg: ASbGnctUOoKHFDgxMYV9c/UC94FkF8HnNv7ZC7S4NtcT+Nj8bndnLu72utQWMQuvONq
	8H9ne8v2HSoAnA/FeNx1v9hp5iky418tQuuiGVNialZqeedrLxN0FjFoXcnX/FLTqkC4Hp8Dhc5
	7uPW9YYF9k5hp4zI4AEdc0v/hfrkqBN09fj7dbtvraaZhzVWX/3rVbs7LorvQ8JniwZ7BfsKsiM
	dOJxOo3oDKJEMQK1LF/OFdyrJgBS6HXevSn7TLwm7IHlrOKMvmYgzFvlqeoG1ZLxeIfjA8EzRgL
	CSMAPDtzup/Mj8ehsbU7a1yYGxSVrE1+x9Pz+qtmfNkbUcmB/hCYAbxfzjV8Q8IRY+g+jBNYXy+
	UnKDGIJrQ
X-Google-Smtp-Source: AGHT+IFusaGvuCb7ZR1Ws5Y5oPYYDpHSdWxbRb5ZmiLNV78bJUEaevAuOwvHQpQaXM6A0+dTKeJfPQ==
X-Received: by 2002:a05:6a00:23ce:b0:748:de24:1ade with SMTP id d2e1a72fcca58-748de241b57mr2814970b3a.7.1750188959655;
        Tue, 17 Jun 2025 12:35:59 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d7340sm9648582b3a.179.2025.06.17.12.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:35:59 -0700 (PDT)
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
Subject: [PATCH v5 0/3] remoteproc: imx_rproc: allow attaching to running core kicked by the bootloader
Date: Tue, 17 Jun 2025 16:34:47 -0300
Message-Id: <20250617193450.183889-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

This patch series depends on Ulf's patches that are currently under
review, "pmdomain: Add generic ->sync_state() support to genpd" [1].
Without them, this series is not going to work.

For the i.MX8X and i.MX8 family SoCs, currently when the remotecore is
started by the bootloader and the M core and A core are in the same
partition, the driver is not capable to detect the remote core and
report the correct state of it.

This patch series implement a new function, dev_pm_genpd_is_on(), which
returns the power status of a given power domain (M core power domains
IMX_SC_R_M4_0_PID0 and IMX_SC_R_M4_0_MU_1A in this case). If it is
already powered on, the driver will attach to it.

Finally, the imx_rproc_clk_enable() function was also changed to make it
return before dev_clk_get() is called, as it currently generates an SCU
fault reset if the remote core is already running and the kernel tries
to enable the clock again. These changes are a follow up from a v1 sent
to imx_rproc [2] and from a reported regression [3].

[1] https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/
[2] https://lore.kernel.org/lkml/20250423155131.101473-1-hiagofranco@gmail.com/
[3] https://lore.kernel.org/lkml/20250404141713.ac2ntcsjsf7epdfa@hiago-nb/

v5:
- pm_runtime_get_sync() removed in favor of pm_runtime_resume_and_get(),
  checking the return value of it.
- Added pm_runtime_disable() and pm_runtime_put() to imx_rproc_remove().
- Fixed missing "()" in dev_pm_genpd_is_on description.
- Updated dev_pm_genpd_is_on() function description to be explicit the
  function reflects the current power status of the device and that this
  might change after the function returns, especially if the genpd is
  shared.

v4:
- https://lore.kernel.org/lkml/20250602131906.25751-1-hiagofranco@gmail.com/

v3:
- https://lore.kernel.org/all/20250519171514.61974-1-hiagofranco@gmail.com/

v2:
- https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/

v1:
- https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/

Hiago De Franco (3):
  pmdomain: core: introduce dev_pm_genpd_is_on()
  remoteproc: imx_rproc: skip clock enable when M-core is managed by the
    SCU
  remoteproc: imx_rproc: detect and attach to pre-booted remote cores

 drivers/pmdomain/core.c        | 33 +++++++++++++++++++++++++++
 drivers/remoteproc/imx_rproc.c | 41 ++++++++++++++++++++++++++++------
 include/linux/pm_domain.h      |  6 +++++
 3 files changed, 73 insertions(+), 7 deletions(-)

-- 
2.39.5


