Return-Path: <linux-pm+bounces-23735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9727A58D5C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 08:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DB116AC48
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 07:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8FC22256D;
	Mon, 10 Mar 2025 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVseLK35"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C165E2222BC;
	Mon, 10 Mar 2025 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593437; cv=none; b=qhP/5s9mUoefpY6eGZcIJqy4mjx4kEwEzbPKiXrEqSRLyxvzHmsJkYpjerc/j2NYqX0RcDg6AfdPiUFhMtbB3Zc1xdKb511m/OnNhO5PJUGFwZQFIXpXngIUn5W+P8U6iLSy9vgSOea6CrsmuDR3sNz+NfL34DfUgU7AK824ovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593437; c=relaxed/simple;
	bh=s6ct/4jBLB3PTMdJAeBIpC2PsFG7V/ZbecHXPZSaCCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ejPrC2pfJk1OLIdWlBllpNHc9biydqCNR86UrFLCcxCLVKUA44wpo2Fk7Rk0LyPvYN5MTn7ASYYJY1CNoeEzo+aoaH/kcR61cVWx4KAdHq/pBGyE7zVtGJJVDQvaJtu7FbYwmCvDfYWyCPyuTHDUnStXzB0FW2DimQTMDy4ESQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVseLK35; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso4849992a12.0;
        Mon, 10 Mar 2025 00:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741593433; x=1742198233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U15UAvQANOQFKH4VGvkHqQq/+vDSNjUxIybBwkpUdsQ=;
        b=UVseLK35bIq3ikyiVtZrC1J8J3Ur/LZQ2ur8SSSS/ncgl9pM5nI/iogkMgKcGOvs54
         3HMc5LFxf5kLj+L03Qnoxu+1bjkGv6RMADDXPoMATjiueb9DMTdcf7+IsKo75oW3uWQt
         ticOjiSa5SQcdkguf7M1uhe7VRwQouKHXi6jIaxrCmpihGvUdh2nooYI+8tQU33rfNBT
         Ri9ULwpsPCt7Q1H9B5T3XaTBPiivZ0jyUHAPSkRc8V6MhyyvPNw7V81oq46yS3Aac4on
         ZGW2fA6q/6D+VoU8Jl44IrWS9tfs1zJent6W667RAamv2HzHCDQ+Dc8GaC+GxQ8RPRAA
         wRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741593433; x=1742198233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U15UAvQANOQFKH4VGvkHqQq/+vDSNjUxIybBwkpUdsQ=;
        b=BeDsGuKDGjF0BwkXbTF5EOvkiF2twY0G+uKmI32kAT9tKVF/BI0YLU8JQQgV4yiXVr
         2NfageXvBdBpsj4OtqSutUInJTVmhA+IRWGEh6J7+YtL0GkXk0jA6Z1giGSlwv+yx6M+
         eq5Z+JfjBCzpPDyz/hU7Rmpm6nPRuERUQKZi/8awwjOygFfNJvVb1wsBlQoQy29tNBpV
         fPCwEQ4qp9W/enyRuxVBm7FsMY40VJdH0E38X+CEWLUVPT5mbw4fngipj7vtoxGSDIsS
         VNQ8YpZaEx4LCT66mYruUBuEZIsy7WeFObBRn0K2dEIV0wGZXCRy0nVUvQi2OpPSjLrh
         k2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUufRZiFDBjN5v19FHFT/c3eu31erHgmf0tjArNAntcdLdyYkJhVeQrBG8qCsuRF/hJFE9Zy912LkLL@vger.kernel.org, AJvYcCXt7N+kQIYuikw23jYG2BbkSDJYKafmyqmz2r+TDWuqST7xVvxvIZPaZz3c8/PIC/m0LzsHhImKF0eSsady@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ji4EPNl/19lq6DESvGTrYXge41GNMyIPeSjgr4sx9JU7+eAg
	sDSYfY89h+8es0yqx2E2WFG6BPhAvEm6m45pdbWA7jqmmH7dTdV0
X-Gm-Gg: ASbGncvkwnVmjRrDYNgMSd6tjmYhy2fFlTq1YP+eNf2M5oyZYkjMrS6ahSU22vCPPqs
	RLl1L8squdY5zZYIKyvhZ/+HIRHggWmt1bGRHo8d7gB+YFhQyrzK/SbSihGfluoGN0XgzsuQ+YN
	Ka8ITSkemHdShKmOIakfVLbUwagcdQO6xAeha2/rRI9HB7eFuzSb1tOIr6n+wevkRI2aNh/znWK
	dgM/KOip3Dg96eJ8w02p6U2OJS8OY7mWhS2kH1Grl2LqMvBLQn/cJiZayeAYNeHC8uAYvwAftVQ
	6m5sO9hopuc7Z33UhtNVikLOItr3O8TJfc7U
X-Google-Smtp-Source: AGHT+IG9r7MLHawaP0l5S1yYlDQvdCNBoi4U43j8q/dsWKaBv1/GPbKQ4WdcbpJuzt8L4QJ85H7hWA==
X-Received: by 2002:a17:907:1c1f:b0:abf:457e:cef1 with SMTP id a640c23a62f3a-ac252fa0a9fmr1508456966b.40.1741593432685;
        Mon, 10 Mar 2025 00:57:12 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2895e7e6asm274697566b.54.2025.03.10.00.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:57:12 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] thermal: thermal-generic-adc: add temp sensor function
Date: Mon, 10 Mar 2025 09:56:36 +0200
Message-ID: <20250310075638.6979-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid duplicating sensor functionality and conversion tables, this
design allows converting an ADC IIO channel's output directly into a
temperature IIO channel. This is particularly useful for devices where
hwmon isn't suitable or where temperature data must be accessible through
IIO.

One such device is, for example, the MAX17040 fuel gauge.

The temperature data, while technically a product of conversion and thus
categorized as IIO_CHAN_INFO_PROCESSED, maintains its unscaled state
(milli-degree). To account for this, IIO_CHAN_INFO_RAW is used along with
IIO_CHAN_INFO_SCALE to provide different degrees of accuracy.

---
Changes on switching from v3 to v4:
- switch to use of RAW and SCALED channels to provide more accurate data

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
 drivers/thermal/thermal-generic-adc.c         | 62 ++++++++++++++++++-
 2 files changed, 65 insertions(+), 1 deletion(-)

-- 
2.43.0


