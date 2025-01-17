Return-Path: <linux-pm+bounces-20615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B226AA14EC4
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 12:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8B01888AE0
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3DF1FE44A;
	Fri, 17 Jan 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k7w0aeHE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892551FCCE1
	for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114626; cv=none; b=nmm2GMZ5+AOV31E3O1mSW9ZVzlgcu57E1ZhhqiWgT6zKcsTAKlURTMjA+iIzqhgc0rFXFBs84GYv+m5gg+7NTbYIE3jZtuhEdc85t8n9h55lQDG8MN0c0s7II4TlIpGzn1Ll7hkpQ1HpBP8flhCgMkAW+jNvLb1rLTD/pp7E/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114626; c=relaxed/simple;
	bh=j/WJTODvNgHQxWyvI8sJLV8uR4D0yon4WC67UNQEKk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ojYnQhBBA2kX+FV0Lwavg64zoOqtT/CJlFT93X2tFkhF0KDD8q2i9z3DedU3ArPLsgG2Ch7Y5zqiW4aOtSsvnqVp72MXH5Sh81Ctfuap51sS86VWssbYs/yaA6BwuZLx7IVncnEmxmnRIl2r8njJE0mJeZKL8QAkqClwz5QnDTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k7w0aeHE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5426fcb3c69so1578249e87.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 03:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737114623; x=1737719423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HF3HtUtfAu4n8L77UWwH/wgG3K4qS3wA+QVLh+7nSzM=;
        b=k7w0aeHEthJ9sf1sDYB2MAwRsrxwFRk+BU4/QUWEMS4JaIj4mp31epaSuAAkjJkbDP
         Hjhlg9Lst6T6GyRcRoV++94OXKHet3qf9+icG4Bv4OUxFPEoW9ZRNHe7fOvtUT3XA7bC
         VvJk1lAu9QpluHjN22Ir3K7+26bsHZAPwq/1n7Pq8b77Ps8RJEIr4EsDgBnpGmJejbgv
         rLTeFSK3jNEXxMV2wXdmQQPfMCSDwk/8plfIEox6RW1tpgU0UF1UdZfBPUSGnQVDK0Uy
         UXI5ggHbydIavjSRg4kDUEKEqcArVzApNBsHPr37DAF2JEa58OAD1HhZelkEyXevjSVl
         Ihxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737114623; x=1737719423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HF3HtUtfAu4n8L77UWwH/wgG3K4qS3wA+QVLh+7nSzM=;
        b=YL4RhDFvWAyg3SPrvp2NTc0SGEcFp4blO5Ta3YMYDDCipfFDMdv4r+xwayykJkDv/i
         FO2kc7sroxTu+G64HcOCHzMP4PdcR8BL4v2NYqkmSU6ypYzNliS35kDikFFTOwCMIZUM
         Fq4SohjfaP1nbpRek+KTC1aWdJKsZkNg2Nfo5cGy8vPpK0TbqhfqnYTfCqZx8DIWu/hg
         kVMywuHHaH/LRi7TLQodn+b6JIhn9jlA/X7q6Ouq6mPsVq+CL+kyRvX+JWsGLs2MWWUb
         2UAuIBoY2vR1Zm0czcqabdpTcjpcmetfIIQMn4qk2f2tMWKVPdiCgemmF66E4KqEoXej
         XcBA==
X-Forwarded-Encrypted: i=1; AJvYcCXgo04nmTeKBjDXe3XuyaUt8kUUNP0QHzEE4VrdVmNPqSnAieBjuoDEoiq7l9zx5pLRj5mubOP69Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZdRNMSYqZSr6xnAnDaHAsHQFq/4SaHwloq+8UM5Va9vaE8ER
	fT2xXqWwyO9ZVpIox7sKcdASWz7sfobbwEsg0y2Tu5h8MBeHQRS12xqKftjYLto=
X-Gm-Gg: ASbGncudbWJ+tPVoUEJ5EjasPUUqnjanFjTDMaXptL8tU530RAGrp9XxFuFFsrQ5XrS
	nmURmLxe8H0vaQ38m+i3C+E5wmhJKQh6/QHpH4XNje6H+QT6Qk3SRV8zYP6RrVMsCpDsnpH4u6G
	cxmvt7jjuIhTQfusmwcAzz6WD+By0ndsIMrjK/Vgn3RziVeorkvDGcjAaZu8X6YDqSlt0kOYWe0
	mcRZwU/pqL8I8v/gKzizffT63w4vkJ2yPbZ7ETdu/Cb0olqrSK1EDgJoBNt7pPmGPFvMQDHwHLH
	eN87Em7RZb94pZCK5KIg4XYxqtcZ8jg=
X-Google-Smtp-Source: AGHT+IH1wnzOw14sjbF7dAPjH6ln1IxkVsiYQfGjuneU9oc+H1R1X98toJc2Q+PdXTyuw6himuwmSA==
X-Received: by 2002:a19:c214:0:b0:542:91a5:1d5c with SMTP id 2adb3069b0e04-5439c22cb3amr538573e87.8.1737114622431;
        Fri, 17 Jan 2025 03:50:22 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af72b45sm329764e87.179.2025.01.17.03.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 03:50:21 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.13-rc8
Date: Fri, 17 Jan 2025 12:50:20 +0100
Message-ID: <20250117115020.131731-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with an pmdomain fix intended for v6.13-rc8. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f64f610ec6ab59dd0391b03842cea3a4cd8ee34f:

  pmdomain: core: add dummy release function to genpd device (2024-12-19 15:47:02 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.13-rc2-2

for you to fetch changes up to 726efa92e02b460811e8bc6990dd742f03b645ea:

  pmdomain: imx8mp-blk-ctrl: add missing loop break condition (2025-01-16 16:10:32 +0100)

----------------------------------------------------------------
pmdomain providers:
 - imx8mp-blk-ctrl: Add missing loop break condition

----------------------------------------------------------------
Xiaolei Wang (1):
      pmdomain: imx8mp-blk-ctrl: add missing loop break condition

 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

