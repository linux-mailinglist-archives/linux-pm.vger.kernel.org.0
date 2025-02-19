Return-Path: <linux-pm+bounces-22395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC601A3B3B7
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 09:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEB73A8C75
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 08:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D6A1CAA95;
	Wed, 19 Feb 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHrLUXpL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9471C5F01;
	Wed, 19 Feb 2025 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953726; cv=none; b=j5NKKpEbKt1yYJQyaOBoRwzIaYOqlfuItlgLM14LYxBL2gzbzg6IrChlo9HvQTbwnproYsAddA4QzfhMDaTS7JddtTMjz5eq4OTcCv7Er86hNdT+C1DGHMWPC6ZmbiMHv4/aSQN9M9RweU2gjYCXFDAYjFwwPQ/Vvj02a+Mk2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953726; c=relaxed/simple;
	bh=xMa5dhWIwvX/FI0ly9X9PbJJjGiw4OH8z/bKgRy6zEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nch3i7yIyiSp3pydGbBTUhN6BUtGVyX0GYo0l78IL0dLKdnavzhNiYghsjlLHq4l+HsHCT+kCLI66eFjaMlGmofb/UBeUtc3+w5kA/pAPeCDOTKmktnp/HZEQVeHizZqwsTZ2fQDWn4Cb2Ca3t2JUpjxBsEEwfz0MMaoGGofOhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHrLUXpL; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54622940ef7so3109060e87.3;
        Wed, 19 Feb 2025 00:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739953719; x=1740558519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mb1tzQ3pAYfxP0ynUpJfaLnvBHvFdLIdM0D9Vvl71Wo=;
        b=KHrLUXpLssnAxx+T0tO0sg70AOXy87L/qIKkyUGV/JxQDptCiXLdn7w36ewMzhPZF0
         t6mFJjVzawf282XPhG/jNAkurImDPo0Q6gIZkrdtNdo1RxsYxPsU1eFf5gOou2Tu9QKD
         C8OM3beQjCvN72BCimjmanSPVo3VA0JjEK9B1eUkLLz+o3skA8KXeyufsp8CmxN5Umbs
         TqcFuJZyxXaLDLeVCOGGVrmbJk/kUNOOsbJRtDl54Nn4wf3bqw1TeupGcO2tKK/qFYOu
         TtDGcoYlA0mt4zrgG3jTlgGFyl/Qu1mFl+bU8XouEYYCjDADKe8cXuRvL8arOzExYZB2
         ZGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739953719; x=1740558519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mb1tzQ3pAYfxP0ynUpJfaLnvBHvFdLIdM0D9Vvl71Wo=;
        b=UhCjHIVlEQ5zJfYiDeDTI4smJ9ccutWWL5AKxxg338DXW6BM1layuAuWczFOr4zxNX
         h1MXP9ISFVal1kr1KsxQdyFKizCv5UO7ZVUHdg+xLZC6248DKnm//8yypPM/DyosMPoh
         t7p57ysB+G34Kswdvj0a0AAtvFbTHQKKcyfkKqj5dSMUj/w0G9evJw9h8np1f781tGb8
         faU1IC8gH6hs+nE2MzoGTt4/RvgMvHriAVZtkPfTWlGKqyq0S4vnrKCDveDg/TNstZWr
         PZ9XwmULYOP2FzbLsqr9qxuwuC+VT2H1pB3s8sLW/NWRrjuFkqXrWgPX4B/GsvMqeQB2
         l9Rw==
X-Forwarded-Encrypted: i=1; AJvYcCU1tdzd+u+4KQIxdyJ2tlAljypp3RoOyR6ua6KFj0EQFVYdWsJBaa9zT8jD+r5vXtzH5QNjfjA+xQiMB6ip@vger.kernel.org, AJvYcCUHHhL2KOlKA/aFo2sDhfWr01q5cOGFhJS1hJW4fHYLoSLERe1um9oWjuWOfJNaCdeND8w0DvPykPzk@vger.kernel.org
X-Gm-Message-State: AOJu0YxIAYWZMFS8mh0N14WzgsddY8t6hwPcj4ZxSYudC4kB0siasz/t
	O/zJIwM6soZbUX0ALZPcqP8/wfRA3DTu91SFgEvpDGlzc8bJmDzB
X-Gm-Gg: ASbGncu75TIX7nR+bk1aqwGT5cQwy1EGrJofncfdhmU89fFdw7um4St6fY8VdNYLQKg
	Lupa3CjLqnCtcv639SriPzIpmKPob3M4yJOCPcETRJD36WaKYBsyxtifbQZ1u5SKrPgAsiFSVSe
	Fw2+HcJZLGCfC9f3LXoj7pxsaiytHk6xlEs22ul15zCG1LHF1E7hZIRLk9myoW73Z0PInywcrwr
	geQc/bv/pN6J89fBPJtjz1p+eaMuI6wUoYMFEMrX2E+85phWRfzVn5aFjbmu/6wprYol8sYhKjw
	J1OiVw==
X-Google-Smtp-Source: AGHT+IHYa54eu2Zvq5c+1QI8//C89stYENtxQOthf3tKrjT2ePHvxkgrhNgcOgvKfLBYiIPBJ6F+vQ==
X-Received: by 2002:ac2:4c48:0:b0:545:1233:d4f9 with SMTP id 2adb3069b0e04-5462eef2cc5mr1105081e87.30.1739953718631;
        Wed, 19 Feb 2025 00:28:38 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2699d0f5sm12645911fa.78.2025.02.19.00.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:28:38 -0800 (PST)
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
Subject: [PATCH v2 0/2] thermal: thermal-generic-adc: add temp sensor function
Date: Wed, 19 Feb 2025 10:28:15 +0200
Message-ID: <20250219082817.56339-1-clamor95@gmail.com>
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


