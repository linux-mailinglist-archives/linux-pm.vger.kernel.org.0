Return-Path: <linux-pm+bounces-41004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B09BD31ADE
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D0C8301D1F2
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 13:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DC227B336;
	Fri, 16 Jan 2026 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="be3WEBYL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104E725BF13
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569454; cv=none; b=YuPnevGUMSpy9r04eHhmVHpV0beL0kudo0WXA88cl/O08HRUbHo2G/U0PbvnvoUj07FdX+lSo0vlu5NWzDNF+8iSgdcBcD468MpIm+MG4Z1VKhZuCkfUDQWA6rZw1sH2e0kHnRvs17Z3rsimn5AZiloQ75l/zVLZaZLqOXVeeh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569454; c=relaxed/simple;
	bh=v3yWlx3GbotL3G9AhcSN50C5SpvFDf2A//QxTjb64Xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fna8gZgRUrWimbu3P51cVRHyHJsgRmEuMRw904G2bW6seKm45E5MKdKvPwJmFcLZjIVprmNkV5ziNyXBgCcrFEd1GCD8wwbzsoQqyeila6rl5dKZ+hDVjYBqpAuK+rMCDK8YdLMzpPEY48VEtw9mDsTiJgvCmGiTjF9aPyTx7So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=be3WEBYL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b879d5c1526so117459166b.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 05:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1768569448; x=1769174248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJgg01NaZF2IVCPUnfeyk7TRyWFsft/f+OKB8cHgBK8=;
        b=be3WEBYLr9CQ8Uqbqh/EA5zPkEV/7hU5Jz3ypwBG0e9aSBTlqKJGbZ4u4eWPet+gdh
         shzQnn5Q5FFynUD5mizZ7QvHkgU5ruktjLctez4uCwUsh4lE5xMadbBfH348kl9chRI3
         kx6GZ7w9ubrHP+JQU7yTFZn6QZt3+7vYNiNzqyXt5op3rQ/mREwzSfZscPSCw7B916i/
         OljF6Tp8xDVIkbB3rWb6joPQ8Zv++tBZnhHVYc4xvzqCX5yO0fhZW0UYEVdu8YQyJg1z
         y8AzmtxG59iorijbkrEQYsppYqhv0InXGN8vJ1W4JJ+eIdcNCxULdk+LCSGs4KVugme/
         Pr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768569448; x=1769174248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gJgg01NaZF2IVCPUnfeyk7TRyWFsft/f+OKB8cHgBK8=;
        b=dkTv29zTyTN5F8RSo3hEuLsFjguSGQiYiROW9TPeXsgsIKGhVrHxPApobBlhqGgHuS
         FFKvR8V/9jRMkoG+MG36BuQ3naIELSzpVe+BPNP4b4+MvGpGK7+ur7GOMquA+2Qymy9d
         Yo6vjCmagmgcMNJfXQtjhO1y9ZrihyE1i+z5V6SLRXjmfNPo9FZkiQ8EwkSu2QIITxOs
         5CEh5qh1T0sfXMNz5cMDya9m3ZXRZ9O38fxMaGMJEdQdnFFVv24kvPa0Ij6qd03eAZXL
         ki/l0EWI+C6WnccNXsIP6wRzZ2pU17pN8IlFNT/W6ViJCbMknsMp1BHgQc7t9EdQ/1bA
         XXgg==
X-Forwarded-Encrypted: i=1; AJvYcCXPS76rqSCsd3BcxSFo4ONT47NO4jja1OKVqrZRXJUE2AGSRJyF3lvP1cPODJnJMDZBspfk42SbbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0y8oV9LPqVS2kzA7aZIXNh2685tmj6YWBV9+7kc412LkFpHP
	kqcZN4W+7kH28c6pNigiDDNr6aKOf/JbFqFqyHDKG+op2VmesEbk53bRM7BfEpbwwFA=
X-Gm-Gg: AY/fxX6ecKX/LQo7uJZhLQ3QUkXxetb5a0ubLkM5fGqmBCiD4DX2VR4bLSQyIUNikBx
	srM1yfLI8e+y/mFZKk+zUWrzkRAEDYn2Z3AM5FzD8ViPHep42xe/Xf+nlV+aATaefE8AhqzN1tZ
	rTkuleOOMe+wSa6dfI8k/XzlYSRGqhhBa4/U4huBeUYuxeESnnaG6WdrXEIrbulVuBryYbIhqpC
	brWHHWT3+eci7VpmmeN39x5N48AeisMADnPOSx1aUmrptLE3KFlfMsqIibDsfL/F3BMd2pL2xaq
	ouOQEEjO8dmAMre+g6teBf9330hpiL5N8XBUk2PnI3y36W88U78cEDgpbe0ho6PBUHFhtOcwAKA
	QKo+96KUSyq3U9jkR2WKd0CuQ7bP0VOz71/SgC8I2SBdQ1iZwWU61j+tt8cNv8/lJJdRSy+yyEK
	unccXejAeE00UuTvW72Cuq90Dqp897Mj80lUZwO8nOJx4S8R5+q5nwZ2987+Tk8mKL
X-Received: by 2002:a17:907:940d:b0:b87:2d0f:d42c with SMTP id a640c23a62f3a-b8796bf55e7mr207695866b.63.1768569448338;
        Fri, 16 Jan 2026 05:17:28 -0800 (PST)
Received: from [172.16.240.99] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a350dbsm235507366b.69.2026.01.16.05.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:17:27 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 16 Jan 2026 14:17:24 +0100
Subject: [PATCH 5/5] arm64: dts: qcom: milos: Add interconnects to camcc
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-milos-camcc-icc-v1-5-400b7fcd156a@fairphone.com>
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
In-Reply-To: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768569443; l=934;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=v3yWlx3GbotL3G9AhcSN50C5SpvFDf2A//QxTjb64Xs=;
 b=7wylF7yqR/1GoCG7yFRPMLqJokhikSOBv5u57rvVqHFkqjHgqmzQMvlpMhfx0Dl0hM+wLd8sL
 nNihUzL6AQiDwGvEwHERwtwD5doSABLP66k8esCiKpq1FwIUTJhh9H+
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

The CAMSS_TOP_GDSC inside camcc requires an interconnect path to be
enabled, otherwise the GDSC will be stuck on 'off' and can't be enabled.

Add the interconnect path so that this requirement can be satisfied by
the kernel.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom/milos.dtsi
index 0f69deabb60c..58b4c2966df1 100644
--- a/arch/arm64/boot/dts/qcom/milos.dtsi
+++ b/arch/arm64/boot/dts/qcom/milos.dtsi
@@ -1660,6 +1660,9 @@ camcc: clock-controller@adb0000 {
 				 <&sleep_clk>,
 				 <&gcc GCC_CAMERA_AHB_CLK>;
 
+			interconnects = <&mmss_noc MASTER_CAMNOC_HF QCOM_ICC_TAG_ALWAYS
+					 &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ALWAYS>;
+
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.52.0


