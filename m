Return-Path: <linux-pm+bounces-15844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820A9A1D91
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 10:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8770B23A19
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 08:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA5D1D5142;
	Thu, 17 Oct 2024 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUyIi/fD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC021D2F73;
	Thu, 17 Oct 2024 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155118; cv=none; b=i71Ewsu69sa3Ijlcj4f39CpyhfLxFh1XBaiz8716rIhktvi4vCDMs4C0wwhMkIAzkHNsdJtXJfzzmMOP13EpZw3JjnNJ8XhNigK/0ah3xoTVoFbVBMNBL5EEias0rzrMhy77eTQKoDEo5OVMmbiSDUrli3b1CkkH5viDj2DdR1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155118; c=relaxed/simple;
	bh=BhU4E9AJwscy0vU8NfowYqAoC9yMGqa3kfr7MgNXyLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZWL4/I82egg++7g9iUM8PYiEjshV/mYEGi+ZWF24O049xTGZzXZbnupACH+ziUyA4ETLffTb9oIzHRUf/Gtv4JdDqinymrgvAL374CF8pE1LQnSzf9ErUEqCKTPjFbyo7KVCpXrALPmspvS2W1+rG4Pkp3a+JiM8E2BcuTtvF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUyIi/fD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so78883266b.2;
        Thu, 17 Oct 2024 01:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729155114; x=1729759914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qmmjYCeB18CbyqQJcVn0ADXJ6qrNFmHuW7KL3HqRqgo=;
        b=NUyIi/fDj2XwX/euKGLt4C6Nh70T7D8XXuGsPts16QC0qsQcdYCB48PALoBFlnQ/1F
         w0vf4WDcyW6WCa95vIAddZkUB9XC6LNlkFJad0sTccpvljE433QsqLcttCti8vFRUNCt
         3Y9p0gZwGvxb9ng9IsYARPN8OBhe0kTnKhhr8NiunyQIAiw+qOJqk++2leLakZ0n4X5G
         HyyYolnhUW+vGTngQRXMM78mcfMbWMi4hW2HVvRzb4iBbqMIpDzP2qi/b4y+msW3pqEK
         NHfLdFSGxzd5TzAGnEhatVG8x0mMk9nyLYnV+kJTXi3d69pvs81OZ2WmcwpGsoHJncRr
         nicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155114; x=1729759914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmmjYCeB18CbyqQJcVn0ADXJ6qrNFmHuW7KL3HqRqgo=;
        b=NetlKeDS6dMoBYXGBoNXL59TcgwaJeE7kFiTPLpc9Ch0eWbpmXYrgg9nv6g4ebqLuf
         BqPWLzOvumOEHj9CWnp7siTBXkpTZ2Uefqvy2gWxNvX48qnWV8zPSD96jGX1wsgAPIBp
         y6v0W7I43l0GOjVtUcTCq/5+lyS+5dkuBRCLrTYk7952nMBg4b6mZs9Cc96/YwUFBzGX
         OPzfCLhF6woi55EVa9B4Uvj1McuFpPfhYa6IeiU/HWRrnz0893HSAVEHp+PBTn2VJIsN
         kMuhc58HyPu+Uk073cogNvMKG3P9Az6Rny0CNHQTYXHi+1jsvm/ocv3G5vvHcsOXH0P4
         hy7A==
X-Forwarded-Encrypted: i=1; AJvYcCV1K57u1ja3TXje6s+9lLZRfGeyfwCCjb0J0ibIacyK5W+EXtnSCdHj/SXJMvLAPcpwYsSAYuX1VIU=@vger.kernel.org, AJvYcCVY4Ens+nllhNLAZyRgcRROWv1m7gPo8se6txmu0wPaIoH6/zS0RpXHkGGd+12DDV9jw4VXed9dn9Yz@vger.kernel.org, AJvYcCXbgZ74qBnDdJQVDgCr2bnm6q14M46VRgD1jMjPDULFy4567SZbhXlyKTLnbPuerWgWhwPAUHPmW0htQ+lS@vger.kernel.org
X-Gm-Message-State: AOJu0YxMQ9L6oIjkYiCahACt951BqoM5T2wfBtv0dhqLeMeo7aJri0N3
	8MxMed/39sYGBTnl+548qHPXW03uZpHSeeCb3iTNp+gqbn+ATpS4
X-Google-Smtp-Source: AGHT+IHvrx94gDRBDzTK1SQ1fRhoIwm949VyNvL5+yIRliyURYMzRlOD6rRrQPmQzzu2BY5fCvgDow==
X-Received: by 2002:a17:907:86a3:b0:a9a:522a:ba70 with SMTP id a640c23a62f3a-a9a522ac213mr175985466b.32.1729155113699;
        Thu, 17 Oct 2024 01:51:53 -0700 (PDT)
Received: from zenbook.agu.edu.tr ([95.183.227.32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29816c24sm267045266b.110.2024.10.17.01.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:51:53 -0700 (PDT)
From: Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Fabien Parent <fparent@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Alexandre Bailon <abailon@baylibre.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	Yassine Oudjana <yassine.oudjana@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/2] MediaTek MT6735 SCPSYS support
Date: Thu, 17 Oct 2024 11:51:33 +0300
Message-ID: <20241017085136.68053-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yassine Oudjana <y.oudjana@protonmail.com>

These patches are part of a larger effort to support the MT6735 SoC family in
mainline Linux. More patches (unsent or sent and pending review or revision)
can be found here[1].

This series adds support for most SCPSYS power domains on MT6735. See patches
for details.

Changes since v2:
- Rename DT bindings header to mediatek,mt6735-power-controller.h
- Remove comment citing header from DT bindings
Changes since v1:
- Squash DT binding patches
- Dual-licence DT binding as GPL/BSD
- Switch to mtk-pm-domains driver
- Add MFG bus protection bit

[1] https://gitlab.com/mt6735-mainline/linux/-/commits/mt6735-staging

Yassine Oudjana (2):
  dt-bindings: power: Add binding for MediaTek MT6735 power controller
  soc: mediatek: pm-domains: Add support for MT6735

 .../power/mediatek,power-controller.yaml      |  1 +
 .../bindings/soc/mediatek/scpsys.txt          |  1 +
 drivers/pmdomain/mediatek/mt6735-pm-domains.h | 96 +++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c    |  5 +
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |  2 +
 .../power/mediatek,mt6735-power-controller.h  | 14 +++
 include/linux/soc/mediatek/infracfg.h         |  5 +
 7 files changed, 124 insertions(+)
 create mode 100644 drivers/pmdomain/mediatek/mt6735-pm-domains.h
 create mode 100644 include/dt-bindings/power/mediatek,mt6735-power-controller.h

-- 
2.47.0


