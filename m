Return-Path: <linux-pm+bounces-18230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088709DC240
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 11:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BA41646A6
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 10:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4094318D63E;
	Fri, 29 Nov 2024 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQid/2nQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A09155345;
	Fri, 29 Nov 2024 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876761; cv=none; b=t4gVUgqx2ujlE3IqTjORSYWADAuHCjXaQKmZ+767vxnthED3SQ4B5+Tv+EMMXvAkcXEdyvT+JFfhQ1zlGpy4z2ogls4xCuFeh/Oh78NoEeTg1fmP3ghNoUv7t/P2OpjCzTPHbxJXf9m/A9ooW8Ba76PEiBdSAERUCN+MxB8vUTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876761; c=relaxed/simple;
	bh=VWzpWcjZZkhqQUm6epZ26RyoE21pHq7obcPtshIpnaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IbGpj2DYrAR6lYhlZ/q8ZbFIIIvCm4tEG1wZh1HyicxH2TlKc1TMO7l88NJGXNxI3xWg/C5PouoCyM5Q+p50z5BpdEBu3yRGjtDM4ugn5qMgTd6xwtE7iQQ8AzDP4HyqpFH8+9+EyfnPngq938rMUQNS9/fRVRv32DHIVf8Xx7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQid/2nQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso1955079e87.1;
        Fri, 29 Nov 2024 02:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732876758; x=1733481558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Np3OdtT5Xyxq8H5dbfpzquej8ty+vnScwvmmHgohYbU=;
        b=fQid/2nQe8gNBAg8ACHCtr21KyvWTSOh9W7/LIn+R0g1dVAc4B+w7qbJFyWTgbkZi9
         MpVK+DG4//9bJQ3J223AxnO5Ld1KmMpxL3TF2MyfI2xU4IioR04ikkHj7AhchTTBaR4P
         4goSmPSadNFipZu2B0cCWjA4mZquDBfIrJ4+uOAAX4UIX+a79dZRJsYYki6gJKuQolzA
         E138q5OMtkeqOlkS4tTcmFemXtZe9ARBmHSTp+wdx3YRZtxnMFHKQmI92uJRt+za7GRP
         UQRvJYTzvuOErhCX/s9T8QU0r6dnQQrP6Ydx5FKj2iYP9CiILJl7fg4KujRUf26ig04s
         pCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732876758; x=1733481558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Np3OdtT5Xyxq8H5dbfpzquej8ty+vnScwvmmHgohYbU=;
        b=cVyojEigs5wukwnemWmY5EpVWlkOkeEOGy1jpqGG3ZvvE9nWTFQLo5YnfqSsidkNGz
         E0paJjPWgmRtzjEtjR7MpRD7ihcIkJa9smm+tJ7zFp/JuNgHrUbhLOJnnBVFqyFt1IeU
         F8dCS6u2PMKaQcw1FsVNBCXg6xUE+N4zGyOkcrKTXuC23eaXvCbeeZEZbFAm621awhaM
         5LY1qvULkiC2ML56qcmhu3BkYA3uCulbRCDAmJffSTSjJUwXDXmvmPBBrquOG5c9ch7X
         mMyeVyvAAF3M+rKRwX5geYLy5x5d/a1KW80X0yUldJAS1di0T7G4hN20awJFCGG4npWE
         xrFg==
X-Forwarded-Encrypted: i=1; AJvYcCWSTdK1qVziG6KnhkFQm6sKVxi8gE62m+T4v8P6qDDF9I1pUdjzPJaTEtl5NAmR2AHU50J5Rs9o6l0B@vger.kernel.org, AJvYcCX+0iCI+t2gEqA20TzPR9WK31A+/R1sFRSCK3cMPrHdFvuGebFWR1JmTteJ1MOevaZTt+sIdkeKi4sRqAHt@vger.kernel.org, AJvYcCXVVIvOwGC7kdGolIy34bU5Mx5TRHBIcXEroly8tuR8u9BB7Gai4oThmLbxofeoXkRmt+PosHHs45E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycrps0OkNyx0dP0Unq1t7Sof7/kUkWzvhi6wS6LOZzOajiy1IR
	dbJX/V9rd6v16cEWxc8sf3ZlaCLNd4U/EOv4SM3oWCdTuKcpwyH0
X-Gm-Gg: ASbGncvotSbYn8MGiutrSdXixhcqWuKRraR5drsEP7DLXcTZIH429hSPrb3rZ+nJ+HQ
	qXD3VbcNRanMvmO1T4JI9Wn/bxMNE6G5Stf8W/teajV0Y1FhOsIReoWyx5Rz2P48iVmGnPOxITN
	RMV/nct+trHXlW+ELmP9REqDmNlWmfO1LX848CKynlOOMe5GLyiYVCboKgcEuxhlu99vqZYwsUc
	if6yCQM+NF/zSjKxpxRLtWaIvSBUJ0WXluN6lH5Y8Ty/fmANpMC8gLnB4i+Ly3C7CtuxvgX4JaK
	1tphkCHGJdQejZ5AMu4s2vPm4MuIT7H9n085ZCISvkaqfpE=
X-Google-Smtp-Source: AGHT+IE/oKFmreY7ucRb1zrq0VUswViDReUpkyZkZZF1yBcfmuic2ZAXH6kI+ww6SPUHyIKijCy1eA==
X-Received: by 2002:a05:6512:3502:b0:53d:eef4:8acf with SMTP id 2adb3069b0e04-53df00ff76fmr5961107e87.45.1732876757463;
        Fri, 29 Nov 2024 02:39:17 -0800 (PST)
Received: from stefan.beckhoff.com (dyndsl-089-166-153-066.ewe-ip-backbone.de. [89.166.153.66])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434aa74f1e6sm81764585e9.9.2024.11.29.02.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 02:39:17 -0800 (PST)
From: Stefan Raufhake <raufhakestefan@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: s.raufhake@beckhoff.com,
	s.dirkwinkel@beckhoff.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 0/1] power: supply: gpio-charger: Support to disable charger
Date: Fri, 29 Nov 2024 10:38:46 +0000
Message-Id: <20241129103848.39963-1-raufhakestefan@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefan Raufhake <s.raufhake@beckhoff.com>

Hello,
We have a device with a simple built-in UPS, which
is controlled by GPIOs. For the control of the UPS,
we used the “gpio-charger” driver module from the
power-supply. For our usecase we want to support 
enabing and disabling the ups. When the UPS is 
disabled, the device turns off immediately if the
supply power is switched off. When the UPS is
enabled, the device has power as long as the UPS
has enough energy for the device. Now, we are
looking for the best way to implement this
function. This patch contains our first proposal.

Stefan Raufhake (1):
  power: supply: gpio-charger: Support to disable charger

 .../bindings/power/supply/gpio-charger.yaml   |  6 +++
 drivers/power/supply/gpio-charger.c           | 43 +++++++++++++++++++
 2 files changed, 49 insertions(+)

-- 
2.25.1


