Return-Path: <linux-pm+bounces-27369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6948ABC55D
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 19:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE584A235A
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 17:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03181E9B23;
	Mon, 19 May 2025 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/Ch6l6l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F9288C07;
	Mon, 19 May 2025 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674975; cv=none; b=sE0zFEvROHdw4T2qLz6QhAXTTEmyp8+1RyLJFQjxNkNVynlZRWQxSjYzV+/i1NY5AGI9NyBGXNBfZGjkTt6Dbp+s1B5WzHG9NYCRzWcFVrjEwaIHyhweQrx1+eR/uLRzC0bhCBOcoGlB8zm7hCS02l6q/+51acvlKzkHbAgIVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674975; c=relaxed/simple;
	bh=pNrf+QD60zmkj70f3+YDaBoATl7U8V/+uFH0RTj/DT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A5sdHuYEwSAAeZP8YJXTKQ4nuG2BLa81DIww4/cHKu76mm6yfGKyxm84f6Qh8cNK2LN4XhOpujN+ZMWYo2K56Yqaduf1Zqp7y1kldA/pkkIYqDhey+vvhjM28EtfcYnN2A5u9pDAB8bXES0uQRVGbv23aAQeDkn6zr5+k/MJOik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/Ch6l6l; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-87c04aeef0fso409344241.1;
        Mon, 19 May 2025 10:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747674972; x=1748279772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h52ZvInZ2ZKG98XTL5i3CaIBIWLDrbmN3XBHdiyAOzs=;
        b=e/Ch6l6lbk/iqS2cyS1dTfVXPhtOwGsMxl9Tw07QAD+alVnQTANWqPX81Qwef9Otjm
         Dj4JlYNs75yANXvaYibfyGzRlXW7GNA7P0L9NbxMlNV9fDF+lyuR07RaXW65Q1WpzsQM
         ltpRce3X19bIq2Qi4qt+7jDR4tcp+nrtv+p6f3Wi1b/jIeoMFeWFB+hSIjQQnZUFrc/J
         zZ+XeMgE4FPoq5ElfKIXrlgqQ/q4IE8/T1IkEGVjo+If4XR2skq1lIBw6Dl+VkMf01Ms
         UaiKqVNfzO8Dxe4ildtA4/+Bj8FLJXPzTljRfO7TE5PKoFnWTnmwsu6RIuhf/3EJlMPN
         NIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747674972; x=1748279772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h52ZvInZ2ZKG98XTL5i3CaIBIWLDrbmN3XBHdiyAOzs=;
        b=sr8opVs5gF2cSRm0t6XinfEIQ/xbbLYueJsakAK/XM/Dc4IjcmB+Coq0rEd+NjUsfw
         0AXyK8AbGcKKKbBKP/v9benFY6kqgn86ZaLk8CiLS/9u0El210FNLVOycIfOOIJg9wrb
         QeFCXo/Wq2riryhtMhKsj+b+wxrksky+C4pMRS22HumZqVdC4nfOkyhFaynOBzNp/lWR
         qB/YDYvgSzGYwo7pg0EQnTrtbZvi6qlVOC+1gunBM/sPiyq5NCRWbkWD4SSoeD97Uav7
         XhTAGtlOkt0jxEeT0sQ3568UoI6A0fyzm+xPRtLLcdK3SMHJAyHJf3DiTFq5QXVJaaTj
         aftA==
X-Forwarded-Encrypted: i=1; AJvYcCWmpbSMgIzvGmUqQxyVgctKneG+PInQ9A3LEfu7I0cSvcaFYwNaxXFvfr1rpuwhX4e/AT11pKi1r67ZwHQ=@vger.kernel.org, AJvYcCXZLHyw98+Tb+2m8drnqBFY69A9kEt6HnWfIy4MOOBzUV21YxjdMWb6YkfFMisnGT7nIXHK+8u8z77FqXMH4D6ROg==@vger.kernel.org, AJvYcCXr1ZZvISxhwXsEM/OZ7T4V27XVReVFMFVu+Awf+S9u2h5dhvOV/MRdjYDR7Z3C0ku+HII2mTUELKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcwimhuWAwIuITDc9xF9T7dETUustn/hqYM5C9yAvWbHp9K622
	5ceMY4id/B8otQLvOawXYvyALjNhqIypWnzNgsxwUQmujp43D9H76eFq
X-Gm-Gg: ASbGncvBKyj4z2bwxfdMy+9A0snUVCVIY+MHV8VgWPIA6B+WVb5olMA4EiYbKpN7gpG
	34OM2EP3rzfvSbvS3u6p0rEXU0rANg8u4QiC1WVtL8vRbJvTRjZXnZN1G+1FpSogC0k8iYUl/9e
	+P4KenLuPvTk5ynJh/yWKFunR7lvofL/xBhgdLbhclzXqllzgH8CM/9j+HQe2LYge8CwAOxC+bY
	pzkcb2kIbQ3K14tTmym8DTCh4jB69n9Q9mny8iy5jZWEbXmBnjdb+AvlsnIeLrFIMr2Y74SzEYT
	6B2ZXLFZKofy5KVoILGynh15ccDbReh+PVR+fxYl8AvxP/95Vx9Tnig+LvNYUkkjJ8bB+3Yd2g=
	=
X-Google-Smtp-Source: AGHT+IHxO6Q7pyZ10Rjc58jJYNwEv+Q71o6gZRhjB80LZXE2hgkkj3DboWPcXP74AuftkJZQLczGHQ==
X-Received: by 2002:a05:6122:ec9:b0:52a:c0db:29e3 with SMTP id 71dfb90a1353d-52dbce1e5a3mr9485202e0c.10.1747674971615;
        Mon, 19 May 2025 10:16:11 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dbab4e983sm7003647e0c.31.2025.05.19.10.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:16:11 -0700 (PDT)
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
Subject: [PATCH v3 0/3] remoteproc: imx_rproc: allow attaching to running core kicked by the bootloader
Date: Mon, 19 May 2025 14:15:11 -0300
Message-Id: <20250519171514.61974-1-hiagofranco@gmail.com>
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
it is already powered on, the driver will attach to it. This SCU API is
being added to the new file drivers/firmware/imx/power.c, where all PM
related APIs should go.

Finally, the imx_rproc_clk_enable() function was also changed to make it
return before dev_clk_get() is called, as it currently generates an SCU
fault reset if the remote core is already running and the kernel tries
to enable the clock again. These changes are a follow up from a v1 sent
to imx_rproc [1] and from a reported regression [2].

[1] https://lore.kernel.org/lkml/20250423155131.101473-1-hiagofranco@gmail.com/
[2] https://lore.kernel.org/lkml/20250404141713.ac2ntcsjsf7epdfa@hiago-nb/

v3:
- New file introduced, drivers/firmware/imx/power.c, to handle the PM
  (Power Management) API functions, as suggested in v2.
- First patch, "firmware: imx: move get power mode function from
  scu-pd.c to misc.c" was dropped to make the reviewing process easier
  and in favor of firmware/imx/power.c file. Moving the power mode
  function from scu-pd.c as proposed will be sent later in a different
  future patch, as suggested.

v2:
- https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/

v1:
- https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/

Hiago De Franco (3):
  firmware: imx: introduce imx_sc_pm_get_resource_power_mode()
  remoteproc: imx_rproc: skip clock enable when M-core is managed by the
    SCU
  remoteproc: imx_rproc: add power mode check for remote core attachment

 drivers/firmware/imx/Makefile       |  2 +-
 drivers/firmware/imx/power.c        | 52 +++++++++++++++++++++++++++++
 drivers/remoteproc/imx_rproc.c      | 17 ++++++++--
 include/linux/firmware/imx/svc/pm.h |  9 +++++
 4 files changed, 77 insertions(+), 3 deletions(-)
 create mode 100644 drivers/firmware/imx/power.c

-- 
2.39.5


