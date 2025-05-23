Return-Path: <linux-pm+bounces-27604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A14AAC29BB
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 20:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31FE1BA66DD
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E471929AB01;
	Fri, 23 May 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGsnTLfF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276A1295DB9;
	Fri, 23 May 2025 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748025013; cv=none; b=QtEo6qsryng3yqpCitQS1XO6DYMlzQ1ZsJlhqAzFSGFePzSZgBvTe6/fwAF1jz1EYCaY+umB6rbzGFzfk6sISwjNyTtwHZidfL9gfDJx2VcbLS/GlvK1ZoUcGsgfmAZYsJt8iyE4RfRsfCZDpXpWGRYt1Q+UEKJPE9ch0FeTBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748025013; c=relaxed/simple;
	bh=Ip/sAIrdqgqJsPUhpaAfOjeh0Yrq0iu8QQliqOwX+Lw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qSHDOA6YVCVGzROymEcySiNcI+WuIe8LNdMWhERinh8Bbv/qWGZfcVIZzV6F9vQ9Uwes0C2Q2H1sNddb8Um/u08a7yCV+rk0ykKlf6abPphajT8BlGlQG+wPJ4trjDR76bax4LkPSapsPA8+h133DT71qIJXIhHkcZj9AzvmkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGsnTLfF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a35c894313so155662f8f.2;
        Fri, 23 May 2025 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748025010; x=1748629810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kJJZnjBr9mgGxKDZ0uGLaI6NNFD33mLm/rGvUEEtWAs=;
        b=VGsnTLfFcrlgwhzUSm6ZobVi7XxmzTDM8L/N0FSGsjPsSn3OFVTANI1I2agi91QGSY
         nDtaq53wDesN2t++wadJ60vG3xmdN/Uh0Te9wj9nph6hO3wSet5H+0c3+Y0DpmGarbDY
         R2sdDYDZpv9U2HIWuLnr3R86WJZgiB4+LQmLf7Kzf3nf3D2mNYUaac/hSrlImhg6NvM1
         y28z+keRQ2h9VsrFlXRDGe7rCn00grvkgPcgrbQ1qUGpYRwXnqR0vquNPO4T4S9Xrowj
         NwwC8p//0DBa0PZ5Xbma1D3ew/XjZRaSLy0Wp9NgQSjU7urDipZkRuspZRn9izhohDhP
         +xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748025010; x=1748629810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJJZnjBr9mgGxKDZ0uGLaI6NNFD33mLm/rGvUEEtWAs=;
        b=to+hKbbCzOs2RQgVZQaGZuM5w09y6Hg/1bSTa3QZDZZNKd64awK1EQfIeJ2KqBdqh9
         BTChxMLc9yZCMrAeqlj5NfIZPiwadAkpEZ9VbNTRTYCl8zgufeLTbX7ELm+TDF90NT2B
         4aT3bEXnqeQWwml6o4716cJNkUdVtda/bN77rwd/0lswtKR3sKKvtrPs9aB0MNuJphYg
         1QboE9ww2qW7y6JDOJk06HJ8Flp17AvzKcZKXvKGW5pIDJ/UG0zzaGuE6k6JDe9bgS2j
         VVoh3QjLOoXO6F27dabESPZcN+G1xR28YWOLXzPd7cyUb6FExiFS7lL+XnznHe+kMkBi
         UI1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+0Z1HrAAfJp6VpQHtTJgMofqilUA5rY+ATAjnI8qOWXzeV+5oPpNNgPzz7qlDSBZOVJe6frdatcM=@vger.kernel.org, AJvYcCVtXppYBiPbNl2wOFTpuyz8nAVW1Jdy0lfs1Nh5JFLhZFTUwKgyKF3d6z2aw02k2SNR76sy8nS/DrUz@vger.kernel.org, AJvYcCX7F9E+e0NnrpChoKJbTw6wBCPRtqOEx77WHZMESUBgBGal8DRSdfqH3VQv08EPcR20X5mjBUTlv96yaSS3@vger.kernel.org
X-Gm-Message-State: AOJu0YxkWgg1Yxpyu9o004P+gm6F+uMtpFPicDTzkUyLrZUHJYDdxhFg
	+flWwGwT6bewXMirznwxDM3/rg0p23B82ZY14R2sldTlPGkQ8p4ZSwVp
X-Gm-Gg: ASbGncv9Kt8YcyacVdV8rGGqvqjZ6x4isrMV9Su6/5a2tgL2EBd70Sj7+iSXD2omcng
	6wfRj4Eafbsewd9jmLegpjmEwXLDx8wANiSdeaZK4+LSdMevTLcYymTHt3zaLol6OCYYkYAtet0
	+N+6aUI+fgQfiNUjCWYtG42e1X/ZC2raIFyBir6nVZl5YSN1v3JDdQbT0iH1rtHbVeNfZbVcFRA
	RNRUbswTDOx24lG/FZ+NISdmZYUxnYUSi6E2OCUoshj6oCvnnW8lgCGgFXiO011VyNUJJs467G6
	RkgjyX5RiKD8417PY4WnJJWjpl/TtoNRLtnlrDdIi37wq+aNkv+DyYgwOcfxzSFMRKaCEPgvzfv
	O7Gc2LQsGH4ADIEbVodY6
X-Google-Smtp-Source: AGHT+IGNbH1h1qBwaDv2QKFh/mf4u41UxuZxHeOUd1nlXnf6xn5djYi5t3a3634TiCa4M09uyA6rVA==
X-Received: by 2002:a05:6000:178d:b0:3a3:727d:10e8 with SMTP id ffacd0b85a97d-3a4cb4c5530mr275388f8f.50.1748025010098;
        Fri, 23 May 2025 11:30:10 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d2d1sm28180695f8f.19.2025.05.23.11.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:30:09 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] thermal/drivers: airoha: Add support for AN7583
Date: Fri, 23 May 2025 20:29:28 +0200
Message-ID: <20250523182939.30489-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series implement all the required changes to
support Airoha AN7583 Thermal Sensor.

The SoC dropped the Monitor subsystem and only provide
temperature reading. Some generalization was required
to at least save the common code with also the help of
reg field API.

Also this driver will live under the Chip SCU regmap
entirely under a syscon hence the yaml schema
change to reject reg properties.

Christian Marangi (5):
  thermal: airoha: Convert to regmap API
  thermal/drivers: airoha: Generalize probe function
  thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux
    function
  dt-bindings: thermal: airoha: Rename and Document AN7583 support
  thermal/drivers: airoha: Add support for AN7583 Thermal Sensor

 ...n7581-thermal.yaml => airoha-thermal.yaml} |  42 +-
 drivers/thermal/airoha_thermal.c              | 368 +++++++++++++++---
 2 files changed, 340 insertions(+), 70 deletions(-)
 rename Documentation/devicetree/bindings/thermal/{airoha,en7581-thermal.yaml => airoha-thermal.yaml} (52%)

-- 
2.48.1


