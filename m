Return-Path: <linux-pm+bounces-30265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2247AFB0F8
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37F13AC673
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B683293C52;
	Mon,  7 Jul 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="xifFmMFY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8828A1CD
	for <linux-pm@vger.kernel.org>; Mon,  7 Jul 2025 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883503; cv=none; b=IJidAb8RqQsODlB1jIDCS7UFb6cyJmir3ejgRL+fqgxlIpAuI1vabiPM8WXnBffoLfZly+l258iScGoVrEUA11s9IOtuvSnUthmyoeTX8LMTdeJybAfUSuUSsnEDVg+F2Onmq5T8nwukq0My0fHcTsgSJwUVdx88mQCXObks2H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883503; c=relaxed/simple;
	bh=WJvLISuNX9SrkFFHrb70kxmDTwn1pDB/xgPN8Mqr0+w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u4oZcRleCFe/OME7TVD1jZ/nmqUx1qfTp6Z6XAaIU3NjQodWcBZxkxX+22MhZw5/nrqdCxtB+HONiidCdmhVvgtjZUDlqnHeLFuqbtFjztJgDsEtQC2Jzb/G9VK6h+K2NxL3/dg2NCFhZgcPkW7cJquuQcPAuhfmFdo/b6JJIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=xifFmMFY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so4596181a12.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1751883501; x=1752488301; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+bGVqtQ2koVGagAhcdjPHNXO3hocrQjyTn8SnwAtxlo=;
        b=xifFmMFY8FbsteONnjM7YqaTU5HZsz7PgfdkxiYrV7+UExgN/mkTs0M5apKcA8r0Mr
         yobkib3krqyHtaB8VKIFblg2ewwWtjlHAYUXqr83xEkq+iKlcsEtl1vngJ4S1DNpN0q9
         9T0jQYklXms+nlM1PKqYFHrFCtALIC3bn0SHAiuAIMD3Hd7rjOepowur7qUt1c1Jl57p
         alxPLC7bNyar66pfC4dmdhomLp2JCuG2VBKdlik02s4gySe9Edv0XmXk9vwSM3dmnnh9
         qFZM5UBkOdgKpKkliBIR1xSdECEPohE5jlPVoIFDyr/26nWUzu93ApMb7GbyHkJGPvPu
         DX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751883501; x=1752488301;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bGVqtQ2koVGagAhcdjPHNXO3hocrQjyTn8SnwAtxlo=;
        b=Y1tbHwr0DKHBkeDczmu+0qqeCj4ZSBGJ9zAMO+dm/iwEnnVPm74Rh9LNdS/WivQI1m
         uLB88dJS2yquMUsVxZUhFw0VPqzcFstiF8bKVh4dUzpfA9liwhyrcpjRA7nyvdMcKIni
         TLuglOAscWRut7Vy68wi7r/dup1XCTPSVzdq9nkM89S25opb8LqgMgjFJ9742xcHGKtf
         ogHgxpFgYHhW1huPJI+xFG5FolDyNdngGUAyIldLII5VE7rSuuMfWkZFjHjVL2272Qxd
         Fi4rv+L4oxLEvavF573+cCvvMOaiz5SrRFRQcfMM4ve07tJV3zpPiEej5ICAgP7OACmK
         t8YA==
X-Forwarded-Encrypted: i=1; AJvYcCUb1+WCrIOM1WadWgvWMT6NB+P4J5agYkodg7kmgvq2TfY6mL8sKgbtwf8d1Lc1mlKCJ55zBaYNWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCoWAzxf2vs7M0BvPdYH4VmNr0+LqrZTuRrOxtaX2TvEBLb6r5
	ur/qxNToliVzNCzUlsGY06/btcVhP7LJ5cx246jddM70Ig8yE9fLGGBaNOZyQ1v6j/c=
X-Gm-Gg: ASbGncux9ak5X95w+kjKhl9T2TnWCApYg7IhvHkUydQkg3gUkODrYuGIg0MajckexQK
	wsJafnaNhfOWwy09Dpb0MDqsdjv2HOe2HlcIgha6YM/pBY6WWoZBkX+MlA02Kr+6p+8bXR/xaVm
	bkXYaezwTUUoegz4Wa6Li9bJrrr0m94HUy1N/XavAYof0XIRCSuKO3BZwTEOK3d6SkeM2JvIkV6
	d4x8Sqik0DLkhx+51IYlyJd4ngoyGVygg3gRn4mZ3YiIo7vztRhnIPYxqe+16mI6xPUy5iOc4qT
	0mfLkbhxMEz5ccjzROQoWHw8/EW1oAKoFROBNL1T/3eb/ILpXxqixw/pLTfs1ib9jodWydrZsgN
	y9MvRbbPbmXa5SEg8HzQiTO7lIVzl5ugi
X-Google-Smtp-Source: AGHT+IGmi2+AGzMy4YVxywbj63AxXZsKBp/UdN0n3w3kbYRL52C/ABqpGjaRqzOavMUNcyAAWeilCQ==
X-Received: by 2002:a17:907:86a0:b0:ae0:6a5a:4cd4 with SMTP id a640c23a62f3a-ae3fe457953mr1136586666b.12.1751883500499;
        Mon, 07 Jul 2025 03:18:20 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6bb1edfsm671711766b.180.2025.07.07.03.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 03:18:20 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/2] Add Milos RPMHPD power domains
Date: Mon, 07 Jul 2025 12:18:09 +0200
Message-Id: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOGea2gC/13MQQrCMBCF4auUWRtJJyRFV95DumgzUzOLNiGRo
 pTe3Vhw4/J/8L4NCmfhAtdmg8yrFIlLDTw14MOwPFgJ1QbUaLVDrcrcOWNVTnNIpMiPlrx2zjN
 C/aTMk7wO797XDlKeMb8Pfm2/60+yf9LaKq0uSMaPBok6vk2D5BTiwmcfZ+j3ff8AkSx5Uq4AA
 AA=
X-Change-ID: 20250620-sm7635-rpmhpd-dcb5dc066ce2
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751883500; l=865;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=WJvLISuNX9SrkFFHrb70kxmDTwn1pDB/xgPN8Mqr0+w=;
 b=6QRyDuZmo/9ShGExVuji4u5RHu2Uq7ibmNyAVct7bykLWvF01kuh3Ce1RW4zAduFIhck7eXoR
 /c6I7AqtoR+ArQyhwHNnhhLq2cTT++xy/oxYe+Hb/Dse4syVlNgzEcG
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add support for the rpmhpd power domains in the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Rebrand SM7635 to Milos as requested: https://lore.kernel.org/linux-arm-msm/aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com/
- Link to v1: https://lore.kernel.org/r/20250625-sm7635-rpmhpd-v1-0-92d3cb32dd7e@fairphone.com

---
Luca Weiss (2):
      dt-bindings: power: qcom,rpmpd: document the Milos RPMh Power Domains
      pmdomain: qcom: rpmhpd: Add Milos power domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml         |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                        | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250620-sm7635-rpmhpd-dcb5dc066ce2

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


