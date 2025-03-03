Return-Path: <linux-pm+bounces-23304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3C1A4C033
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 13:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6244917005A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F6C210182;
	Mon,  3 Mar 2025 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu07RUWZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ECA20F091;
	Mon,  3 Mar 2025 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004529; cv=none; b=R1utBVoEgd+oVV21icNrP6j8HhX1Hvi8rH6k2pG+rIrUe8tkTXgIz+W87ELfbNIZPHGceaOhZRuq1cNOLKYwyOYw8okoI0TyPvNb7GesC4nhQSVgFuFhN4LdjyQcMIDw9ved2ddJulvaIlIz5mFTK+Pyhv8LINttuRUvYFT6m+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004529; c=relaxed/simple;
	bh=5XGSBkroT3NyH15c6J98n/wt9cwzqENYoyXtkNF++dU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eeONe0NcGjeMb8208NLNidfYMxke8IreKMQnbVxl3MFmtP8shMeMeOg6mRmFZlKjvPy2BlrPdU6ZV7ahdbOgtNHQbbjNBIByT+fDIPxTA1mAcmFJZBIu76nfDmAjG4TRWbGjEj9HTAX840iLIXZXwkVQ/vftEKYlv1KZfF4TGzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu07RUWZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so5087178e87.2;
        Mon, 03 Mar 2025 04:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741004526; x=1741609326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZmg489r6L6pRhlkbZ4niT48F2MsWO7ApxopBhoezJw=;
        b=Hu07RUWZtAqkdAQSl4keRFYy0vjkj9XPifAsfXKIY/Kp5SdGXeS+uk7RldvKyOgJIf
         CpPg6xGCL2o5V2hJcjRDP93eyxmJ6LYMUkDXt25220Jip6rcjIWW/tRsMsP+RY2c0sop
         a8k0/AxgITPPKh8WODv0e4pB6L3ndCN3T3fTIps/G+oHLfqEzo588CA6dlJWoFZ/j9NU
         56MRXRlGjEtgEQFvJf3YlP3wd5vWS4FvosI7OZ3u/Gwh+emAlo3HIQyS2YVv9b5yFuUh
         Yj96iGFk24XJK7ymdLievxpZ7kazmJ3PPTWOlYvoJQc3VgFipKRv7C+zKvEwiPFoWjUo
         RFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741004526; x=1741609326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZmg489r6L6pRhlkbZ4niT48F2MsWO7ApxopBhoezJw=;
        b=L3SZWyBEoePzMRtbz+xV980HD2ortnO73DakmWrGxgs6One6zHm5+C4tDrt0pPVp41
         4U4MBN2Fd1JFJ8ZddnMjnJczLwWJbkrS4RmZL9FZM7C+ejpGMhM7whW5E8EXRjocZpx0
         PkhVRXaVoZRjHLgtRVjIwHHIZxxBhW8ZeK0D8EBbpfZaI4NlhARIocDzjYuPCY5vLWLf
         f0YslVPRxi1PKhABJZ2FNnMXeeW6NRkINBv8S6DUMutEV0Xb8KT9kfiFBrje1c0bVsBR
         9IGDUh4P5AcSJ1hfDQOCayguD8xvwCkQWTl7zTVItbnx6YzwcmGRau0PDMk8NixOT6F3
         xsgA==
X-Forwarded-Encrypted: i=1; AJvYcCU0S8LVAtVIL2mOeOEIRJjpVHG4YynR/rJly0/UOfEtAlE2ckttde5neEVbkCr3xdb2v9NAmCB0KLN5HSmB@vger.kernel.org, AJvYcCVvDlwr44JLJgiwRp9Lx0weIjOl5/dBG7nF3qpFog1RNjbd/XOSxQDbBQbHuX7JzxrX7VIQ6/f651T8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Abtysd/qgsBvp2JDOhRaO9oR0i3cijmK9LLGVx6oEcXgi+rK
	Lv0N2ZkGzh6daUlZebUROgD5Q7/lcwP2lkKzAs9Qgl5SWkW7ei9j
X-Gm-Gg: ASbGncsxo+030cKcDLKUTbNUsv6l4FgOfY0QYJ2ksmNhEoqaFTvsAtl4QJc/Z1a0rHj
	9HI3mbyK8Mz4XfLfHUfx1+TCA1qo1dK7zm8OjavFbXhBOm40byY9ks0dZEpFawWDMcINhQmS0UV
	TOg370L5eNEHLCFxk5g3JOit5CBEZlGC/0CrHUYQ4hJDyZRTlT0MJujMgCYgOs38U94j8XMvRo/
	T4mTYNT9mHHoRmGUe06WEGHOZozr1J3TYQXLGcXA/iIMpQad16YbZv3mZzxSswBSiiKHnI/G/iB
	MAzC5bssiAE6mbgyfQgKOikX6rSqCfTysVc=
X-Google-Smtp-Source: AGHT+IGTBGYosGRDbEuVZA2KP4Ij2fiTOu2dMftCCG5C+UQWTRH5Drf67iHW/KYjICrPNIIWKVuJhg==
X-Received: by 2002:a05:6512:398e:b0:545:d70:1d1c with SMTP id 2adb3069b0e04-5494c129ce8mr5205004e87.11.1741004525723;
        Mon, 03 Mar 2025 04:22:05 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b868766desm13486611fa.100.2025.03.03.04.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 04:22:05 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] thermal: thermal-generic-adc: add temp sensor function
Date: Mon,  3 Mar 2025 14:21:49 +0200
Message-ID: <20250303122151.91557-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add IIO sensor cell to thermal-generic-adc, which would benefit
devices that use adc sensors to detect temperature and need a
custom conversion table.

---
Changes on switching from v2 to v3:
- rephrased commit headers

Changes on switching from v1 to v2:
- documented #iio-channel-cells property
- switched to IIO_CHAN_INFO_PROCESSED
---

Svyatoslav Ryhel (2):
  dt-bindings: thermal: generic-adc: Add optional io-channel-cells
    property
  thermal: thermal-generic-adc: add temperature sensor channel

 .../bindings/thermal/generic-adc-thermal.yaml |  4 ++
 drivers/thermal/thermal-generic-adc.c         | 54 ++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

-- 
2.43.0


