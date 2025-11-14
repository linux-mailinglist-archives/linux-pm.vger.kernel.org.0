Return-Path: <linux-pm+bounces-38022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A344C5C544
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 10:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D457E351D2E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 09:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499923081A7;
	Fri, 14 Nov 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Gt5z0wfC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0C5303A03
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112677; cv=none; b=KFditESofhkLCKerR4WAD+P5LH2YbhHTNpxhZeNRc+duepB7V1cJM6gVZsJbGtkVWbIyEAMoHlUVIMus7YhtS1k+KF3SWmfEisS2d1taZ1i0cQN5GHan31D+XGnAkwx3dfOHP7JotrggAsz8fPlkxICVVUkR9IIGw6PYZSzU7yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112677; c=relaxed/simple;
	bh=ACQpx7cjZHPONgx9RRCg5HRaeFcKLESZFAJFQv7L0K4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LcJNhDRRUfNy0ISmLH1SNhjfGfCToHgWeOuBmmlDQHnJlCxeGX/QHMnj7Eq+Os/XfXuKP84uNYzAAqnTcNGx7rDLGpVq4DG9njTfSTYZ4exk8ePBYZPikfBjloUtCgQfGFHAHqIGcYuJkdtl696hDvfOBSwS6KloI+kndgEehN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Gt5z0wfC; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b735b89501fso147538166b.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 01:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1763112673; x=1763717473; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfvYbwMR85cXvJiXqvlh8kV+lNS72Io0vdeb3FdrUK8=;
        b=Gt5z0wfCaiI1ftWmU5iVKgPjYaQKzQthmqbpbaNK1L0EDU9djSiQ/veSCISJzelRrX
         U0cpdp40ZjTZvynmBdobuQaxBKwwdDYthYCywihYkHWl0s0yaOP3OwKbuSHKEPMh52Aq
         wI6sym00wQLQ1Yl2LDuiK+TUG/UF6P0ev6QIHh7qLfqjNGoMCqvzQHChKs2gC7xmrWvz
         iNtc16cBSMz13cfEn6svqKceNtti2HVodV4UpuasHxhpGjw47Q4h9xXTHXxQKtgQhVM5
         MsxyklUiFOaOP5YuHMQ8sQXMjlgCUYnWM4V3lWXO5OegOrLCTRF3ZVuPRfEDWmS48aF1
         e6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112673; x=1763717473;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfvYbwMR85cXvJiXqvlh8kV+lNS72Io0vdeb3FdrUK8=;
        b=K1Khf4JQWtVVEoPM8Z8/EbRITdmfgcKFNp7sryRZbxaWduEmWlySKfyUin6yjfNWxa
         G7MaY0Qw9p8TzQKE4FaiiKC+WoPgSdn1HiscoG8Rxq9RMtSlkNCcNXpnJabcxR7RYCCT
         QyP8qpYqYGbzta4zgh8bRmIEQwCDpoyBTjyOLMXQqmXovaqKScxNaVU8ykiYnfLvMXwP
         Vvo342rjRibW5/flXEkFF8JKBAp9SMZXopJlOeUMGl/7jCzQkqNcn/0R4s6fQ5iJjH/E
         l/8LqiTG/VYko1qv4Dr1ZDZbB1b3G+x8pwItb+1yDnt1CDoxjUVsjjjuYLYI9RtUHL6f
         sI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkT43YQbQJEeTmGl41VodxqcyiJjBBT5zWo4cKfEg0qWyrryZgYyBsh0LUJgJnMKq1bJj2L+g18w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHi3sQW5Skqn5Zqf9mL6tIqXGyQ9KDlmX5EaFtkyCTBOVO1NgW
	KHtlWeru4U4Z6h6SaU/9O+bBbId3CdwXU1YpEfCSQ4AcGkxCoPrLCaiRIa+qZcbuubg=
X-Gm-Gg: ASbGncv+1g0z7/R4DcvW/lZwodHRQAoRF/O2LnNPVK4FHnui7F309cbqqXsmTib8sP4
	LVV0pMyTRlFbSrev7J3dqgzgeNxvWwsqXSAzQmZIRqXiqss8cDBZhP5j69AdJ3suM4UDybl+g8G
	teCutpSpscbWdcBz4CtgvnoEC4QRieBvY9GHASCxY6LhcYu6K0BMAFQuu6XQWPvMRpA9z3mf6yc
	nkawbumI8cqXXxv2xgOml27HIgi2/GbqeVMmkQqK0TS7uafHPWzMUMwI5dfTfzWb/TUx1yaKAfd
	9HYoJQJEZqChkji6EUZAFzwhIq7Rjja2SuVaP5JBJHiZibi7zbNVVpHEQOBqfnVz7qdA//S8W6O
	EmzAq0qlXUeGr1QZ57t83ttPoft5rxex4TUgbmHoKslKHK8Hz85DPj1+Zkjtu1n9D1AtGbMxU4R
	W6hSUZLvvjIePZGKn1kxfFybz3V+Zkt1rJCZfuYZvf6VJDDs8YMhlNzRr1LaPEgpf9L2H2nYOo7
	vRLfywETvBkEc5CQCTQEXE=
X-Google-Smtp-Source: AGHT+IEHPT99abpf0KPMgu3Y6RnZucQGw5ejkSL87Rxnqo9xEnFi6rEdVtOT7jKib0z0sW0Ef35W4g==
X-Received: by 2002:a17:907:3e03:b0:b73:59b0:34d6 with SMTP id a640c23a62f3a-b73678ecc12mr273490766b.33.1763112673413;
        Fri, 14 Nov 2025 01:31:13 -0800 (PST)
Received: from [192.168.101.179] (2001-1c04-0509-ec01-156d-fa6e-7f19-0b67.cable.dynamic.v6.ziggo.nl. [2001:1c04:509:ec01:156d:fa6e:7f19:b67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd80841sm352104366b.41.2025.11.14.01.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:31:12 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/5] Enable QoS configuration for SM6350
Date: Fri, 14 Nov 2025 10:31:08 +0100
Message-Id: <20251114-sm6350-icc-qos-v2-0-6af348cb9c69@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN32FmkC/3WPy26DMBBFfwXNulP5IWzCKv9RZQFmXEYVOLEpS
 YT49zhm002X90pzzp0NEkWmBG21QaSVE4c5B/VRgRu7+ZuQh5xBCVVLKSymyehaIDuHt5Bw0PL
 kfa/J9B7y0TWS50cBfl2OHOn2m7nLUULfJUIXpomXtprpsWBhC9XAX2nekGthpMZI9xB/ilIMu
 rfKms6emnbV8FaMnJYQn+WFVRbHf2tXiQIbZWuqvdPeyLPvOF7HMNNnngSXfd9fDEAUPRMBAAA
 =
X-Change-ID: 20251107-sm6350-icc-qos-d319ffb3e6bf
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763112672; l=2923;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ACQpx7cjZHPONgx9RRCg5HRaeFcKLESZFAJFQv7L0K4=;
 b=KA0AoWxizz0/gD8OfkMA4rS2gAqVLcb1/7U5wBumPN8iT6dhshUZrXarIVRz1s4lnnGAnOGWR
 valGwg+JpYfAuecKkuVTx4irGlqABIo9n/bNeNk+0OpIdZdFn6jC2hi
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Update dt-bindings, driver and dts in order to configure the QoS
registers for the various SM6350 interconnects.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Refactor icc-rpmh.c change to be "less spaghetti" :) use less goto
  (Dmitry)
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20251107-sm6350-icc-qos-v1-0-8275e5fc3f61@fairphone.com

---
Luca Weiss (5):
      dt-bindings: interconnect: qcom,sm6350-rpmh: Add clocks for QoS
      interconnect: qcom: icc-rpmh: Get parent's regmap for nested NoCs
      interconnect: qcom: sm6350: Remove empty BCM arrays
      interconnect: qcom: sm6350: enable QoS configuration
      arm64: dts: qcom: sm6350: Add clocks for aggre1 & aggre2 NoC

 .../bindings/interconnect/qcom,sm6350-rpmh.yaml    |  65 ++++-
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |   3 +
 drivers/interconnect/qcom/icc-rpmh.c               |  19 +-
 drivers/interconnect/qcom/sm6350.c                 | 298 ++++++++++++++++++++-
 4 files changed, 357 insertions(+), 28 deletions(-)
---
base-commit: 33b5a67d76ce575ea38bc3de55719a6cdf42287d
change-id: 20251107-sm6350-icc-qos-d319ffb3e6bf
prerequisite-change-id: 20250613-rework-icc-0d3b7276a798:v3
prerequisite-patch-id: dc49cf2810a33db590997c9e9969f09fcbba207e
prerequisite-patch-id: bd229a10bfd7485726f341f1bbc179fa032e4beb
prerequisite-patch-id: ea3e9a509dc2d590f647560df3fa773165d5df48
prerequisite-patch-id: 95b82df224ac0515c56d41cad8547099248697c1
prerequisite-patch-id: c793efccb33da5b78d634fc0f7259c01854c7da2
prerequisite-patch-id: b25a3cc84427ed3d321575d32dee239aa6dcfa65
prerequisite-patch-id: 8262f845f906a575f9ee06c002d8626c7b25a87e
prerequisite-patch-id: f3b9493e64d90665d7093c7f7af335452010cf13
prerequisite-patch-id: 4e05eb6178064d4b4541fccbff31e18d4e5ae258
prerequisite-patch-id: 4c169d0f54fb39999cf62eaba98208fd94e0d250
prerequisite-patch-id: 91f18aff5b2cc765964c8991647dd53e75e97648
prerequisite-patch-id: 7749a4cc2e2e8e2ac191844f8c42f338d0a80392
prerequisite-patch-id: 75a9009c7cdbeb94b2c7528f6ecc54d7a4b7a6be
prerequisite-patch-id: 9566648a76666548a85084664ba6fd4a240fe602
prerequisite-patch-id: c2ba63308bedf78640d64d9662ebfe2ceb7e6d26
prerequisite-patch-id: a08ad34a60042b2693b91f24712ccc10e0d5666b
prerequisite-patch-id: 8227a4926c64a28215b6c03d43df5518d72094e8
prerequisite-patch-id: 15ece9c03dbae75dbfb1b16a2e2c1d2ed1766c82
prerequisite-patch-id: e69ae611580f951450269b4a7df8789f6b2e2c89
prerequisite-patch-id: 5e54f850197bc33dc581ff8907fcad1dccef20a8
prerequisite-patch-id: 73caecb9e342117c2a83832f0d2346119466a899
prerequisite-patch-id: 79abd6d335f0bdd8725c27797d4fbc7ffc017007
prerequisite-patch-id: faa043f224857fad9bd8368d83d5154e3f7013c1
prerequisite-patch-id: 5d7fdb3ea01a6066079dd89a4e494165b75159db
prerequisite-patch-id: 0234857c8f0119652dcf3fd6e7e1fe051f40a6ea

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


