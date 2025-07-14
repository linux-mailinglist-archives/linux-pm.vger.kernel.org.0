Return-Path: <linux-pm+bounces-30765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B5FB0390E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 10:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B7C16FF2E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 08:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FF623C8CD;
	Mon, 14 Jul 2025 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foxivKZb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDE523C501;
	Mon, 14 Jul 2025 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481067; cv=none; b=sbcC5n5eIg8RkPLKjsKnYfDHLhhDnqcUHebusrJiuDtZUOUKJvBTYjxTv8rroVCqXr/d/OhWneGsk5E0nzS/wSwv4S/BBqKlX7hjOUEcNalGie6ff0iMRbBFAmGa6amuET/WQ0Poph2BaCXfYdC5SboxPa53Y6pdOukTWhD9MrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481067; c=relaxed/simple;
	bh=6BGIugkkbcoSqRT+1jq3o00bmKPpR5fV/Min4zX37C4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9YDhzC8+Ed0JbohnyOOwygQhl7jF80HbUuOoJy+i9sHsenM9DTPexJfz7NZn+mM0poDSY/qvtwSDrTr5+pnjYDw1Eli8no3rK1avslYnT2O/laqW2YZHU4IDursZtuGG0jvsWgNEPPylpmCNbgLGwbVijyk/swvBWImllNRnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foxivKZb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-adfb562266cso700285566b.0;
        Mon, 14 Jul 2025 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752481064; x=1753085864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nqz052lU9KaJtA3dS+oXDH6wWfVFipHzZ21v4iNIwVQ=;
        b=foxivKZbonq3HCkr8yjh4ewbkCeoEuuYwgf8ubP0skL8OPqn3iABpGAxAKwTdugPt8
         BZMSohp5RnVT0mJvCilQCofK4qi69JIpCn6afQEYsAZZKeB2bU0AkTsPlBtuZ6+eTYRx
         vkYLICjQJQ2+g999xyNHd34DjL2dPp+KKjWTactg36t4c5UHO2ICQGm3bWDaJFrMPVrl
         W3H9dJ2c6nIBioBL3pM6bwk72gOPlhzLqqiw5HptI8ePu3oNH8/7SvUkSP29Oc5/s126
         wMGOcemo/JnJkghW1oMTi4A7TEL8CgHuBkvi/jTgHFgqxAEvosag5ajVqo/JLdkLkDry
         DD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752481064; x=1753085864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nqz052lU9KaJtA3dS+oXDH6wWfVFipHzZ21v4iNIwVQ=;
        b=kVcbjZNRQaL4toscbn++tj0us4zz7b6Z9bOpMIS4NQJnjuN3Vik5hb1ggLckDTkmk0
         8VJJz/eedufahWmyukFt4GbWzqfIBaoHWQcaGwjZtzxG1m6CAxNyAVU6ZMmMLKgz6NBq
         vLghTVOeDujxCqepakNYhzSc8mWo5s8JjlcMHpKWrOJH8oPVDnz9Cz5dmw57fQTDQkfO
         sEG0dq/s8BqCsXXiiditBB+45Pi/PW2ojYukQrrM8tuCr6D3/8ejtQKQcCmDC0PSqInx
         hMSYkPMEHc69PDmNZ5gCIxr8rzuUVF+eaJ00iqbdH2kELFM3OKavOencmW1yyNEhPSj0
         S6ww==
X-Forwarded-Encrypted: i=1; AJvYcCW4Y6yBzg4It/LaJyuIQ5w6nW8OflY9EWOpyXLX357jtcaNl86lg4UY8yRLNF7226fRfpfMEOVtRcM=@vger.kernel.org, AJvYcCX+8OfO0cV9MMsKob9clfUt6UGufxCEc1BG5yJSw5fHuvbFgw8B5b7zoZadoJzlJeqENoPP1D/B6pQ=@vger.kernel.org, AJvYcCXOEamG/pfyBqQKV4X9pMMQRUqhj7iKqUST+HzxVdeFWd+KVHlru0PolmXVNl2tDTyQPQpGvMJZfiS0ueRE@vger.kernel.org
X-Gm-Message-State: AOJu0YybNO3NmXzKW/PQczLm5ICJfDEjEAO3ydxm4U2TSG9z731LBCwr
	tnH8CBIHrT+dyxFBhKGV50Meq5oX4ZFumNEQ4e/oTntiM2CPKhxtyUal
X-Gm-Gg: ASbGncvJ3C5ipAXUxl9WUS2E9EtZ3jiAGFJudRRdNfL1Ep6Wx+tWwIiBtitV/Kn6EAN
	8x7lVcX314rA44gOpYOCx49ImT+GPz2gMF8QxuNK3GWyVkTTgxXfqG2Gel/81wjy6qqYxoUgC5n
	U7jQzEak3Ri9JDyMVRVOH5mnrCvJC35K9S23t4mrGR/MqYdFdBUDVBxoBlbcdKWU+sjiHSrVtjb
	0S/cXzsgLkvDiKM7GFCOomnPZBdWilc9PPT69mHcQMkWsWfMF61Afi7AwA99FHz7PAZZUbL4uih
	pwdG3f5W5oBQ6Sq5oESHeO9RvpSiQ5T4RgURDb6sD5w+zc6hB0ucXt5l+jxehLkdeStIko16/Q7
	TBU2yj3jQTiFSKQ==
X-Google-Smtp-Source: AGHT+IHYeLMFss87Q7syjTCE1OdreLxl5WSTtTqYMsq+pAqlXYuaooJtRcwKYwjOxgyDJrPJIDg1mg==
X-Received: by 2002:a17:907:3c84:b0:ae3:f174:4484 with SMTP id a640c23a62f3a-ae6fc0c914emr1339692766b.46.1752481063915;
        Mon, 14 Jul 2025 01:17:43 -0700 (PDT)
Received: from xeon.. ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e949f2sm787867166b.34.2025.07.14.01.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:17:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/3] clk: tegra: add DFLL support for Tegra 4
Date: Mon, 14 Jul 2025 11:17:10 +0300
Message-ID: <20250714081713.8409-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DFLL is a dedicated clock source for the Fast CPU. The DFLL is based on
a ring oscillator and translates voltage changes into frequency
compensation changes needed to prevent the CPU from failing and is
essential for correct CPU frequency scaling.

---
Changes in v2:
- dropped 'drivers:' from commit title
- aligned naming to Tegra114
---

Svyatoslav Ryhel (3):
  drivers: cpufreq: add Tegra114 support
  clk: tegra: add DFLL support for Tegra114
  ARM: tegra: Add DFLL clock support on Tegra114

 arch/arm/boot/dts/nvidia/tegra114.dtsi     |  34 +++++++
 drivers/clk/tegra/Kconfig                  |   2 +-
 drivers/clk/tegra/clk-tegra114.c           |  30 +++++-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 104 +++++++++++++++++++++
 drivers/clk/tegra/clk.h                    |   2 -
 drivers/cpufreq/cpufreq-dt-platdev.c       |   1 +
 drivers/cpufreq/tegra124-cpufreq.c         |   5 +-
 include/dt-bindings/reset/tegra114-car.h   |  13 +++
 8 files changed, 182 insertions(+), 9 deletions(-)
 create mode 100644 include/dt-bindings/reset/tegra114-car.h

-- 
2.48.1


