Return-Path: <linux-pm+bounces-38879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D890C92130
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 14:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA87334F48D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 13:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B504328B5C;
	Fri, 28 Nov 2025 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7SJ91sV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88405309EF2
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764335456; cv=none; b=Zhw71NKxfinh9cjpxrJEA9FsVOp+1+aElIRE5LIJQ5yPP+OYAfK56KT8ofrGwN1Ljs2vYAq4epYGyiKZT9YwmzrglspRGlTwJqomtZgxBvyBd3dkJEAaNzRw6Eux2o+S6MmgslWuMWMUKtIWGwCgfpoIJ6ut5J93tL/zWIGjFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764335456; c=relaxed/simple;
	bh=dvLiXeGbMyL6LjS4KZj+XBz2Xm2VvTPyKLMdIxMSwcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EeFhR5y4tCuxg/VHFyN+Kfzp+wqRp6o+46pguA8w5009FJivBUvBlOGWkUgfiYb+t8kJyhBpJcipVUB9gyRbFk7smk0JgdhfYe4nzOM+XAVq8OJZjl6smaiFU2kOeDFavtWseNc3NnVmfaUoo0t6y0cEkSeqW3Z8va1tB+8b848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o7SJ91sV; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5957c929a5eso2840250e87.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 05:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764335453; x=1764940253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UzjFUATixGEhENXHEUG95u0sMOrZqZmW0LecHI/bMco=;
        b=o7SJ91sVMcu6FkSgDO0lLgMtiwg/WSJfrOrnINll1gkt25CZS5wr6NYDOXqi6XaNT5
         R/DYm7bU1wEqfbFEBJ0n874YEb8od/3ObW09K2IAWXIx5vuDrNbU6tsv+oUjUSBNv+w0
         mOJfMOAHmcdkYsKzxceBQScvyM6D9p/xetWUDg0l+vV4u48KdvL2+tbn3ozpySP2mApn
         m2n1lxOXzIdacs38jlPfqhyh3V2R7sSMi1NNVqZUMsBZvNLGZpSzogFOYzieu/14ZP4I
         FVHI2NCePtjDrprbDfB36YaVxsBOLfYc5te3VRlMbOo+VlOpd4K8cxcAqudCh3zr5yDQ
         w3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764335453; x=1764940253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzjFUATixGEhENXHEUG95u0sMOrZqZmW0LecHI/bMco=;
        b=k1zOZVDRIzQBgdN4RI7J6m0iHYg7EWwZLykd9pJ9peZaxk9ogp0xNqWpLTaEfJyLiX
         8pjSsWso4t93m/MMnsRkLZdYwS52zPQlcwmWUBqQJbIqBtB+wLf+3EEbIoJ2BqHf6aLE
         lsv2DkrgJL6+gEytKcV/E3oPJyEV+fFfIjyft8Gu9UUiqslUVHAFoI0WiwhuRiOlBxUF
         MDskeCE5vm7W+YcdbJ0dzdwc1i6/ILImOkAWMzHfCgT/hpYkNbzSSdQBrTv4dbBedkE1
         ikQ57uM25U6OzaLqVsmujeAABs2awM7j4RxoYMXnw0m0GP1jGNPaZ5qDkyOofbzYbD0D
         Mv3A==
X-Forwarded-Encrypted: i=1; AJvYcCU7QWfoEYh6PhFPBmjV179QIcfILMU3OLp3dUiXCVKrazYhtizlCMv6fXJiuAmHHln6B4wXKbsi4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR9EU0d2c8Ley0peIrSDHSide3knc1mDpTahFwkVPMXsGP51SE
	JPHri4prnicIT7TdRt3yiTaG1jR9WNx9ptp+yUhIgnPy7kquds3o37q/9Ocoq2xi0WEZKe6jXl+
	qBFIl
X-Gm-Gg: ASbGncupgf/MOHh+53mKYqyXSnGhCHxG/EIZ6Rm2B3RZv0by1Ie8bzWE9K9FdkiL0Wi
	mMX+9PWsHWiwf+NqjvodTcS4XxQZiNVUnbmoNZ5GIq/4wl1nZZwepzIpzEX8OhXTrgrCWaxRL24
	UwyVaVrH3TrI+ypyyyMrZewe5hPyEzgh+/EwLu0pAaSuf53FYfWzvOxVeHCUPYUGLIm/VAe/l3C
	MDlArKyvnjVFWl9i69lLUsR+Wmo21QyAml2xnkKKkMitZVBUZ/rZzTjPC2DoNUu7rYrbCMjOvWF
	J52PLVDVhakwNCyyHoWWZ4iq3MnD9tKymznP7fTZEaGhe+rBAxK6AYbMcqR4gu+sUDQMdJ15irq
	Fvdoj9A80q1LPaAWQ8kTDXhLzZMX+1K/R8wLjy4UJV5hgnyRYWQEMSWC7akWzArUCJ3mZjvg1p5
	dk6vpkX4piXHtBDKzqBUo=
X-Google-Smtp-Source: AGHT+IEQsRJAXuvpMC9nA3qXOjzTHFWk0uaOKBkHUrEcO1F3nDkA6mgaLwYnxUkSq0kYQOipq5jdRQ==
X-Received: by 2002:a05:6512:a85:b0:594:2f72:2f7f with SMTP id 2adb3069b0e04-596b505992dmr5760486e87.6.1764335452545;
        Fri, 28 Nov 2025 05:10:52 -0800 (PST)
Received: from uffe-tuxpro14.. ([2a02:1406:25e:19ec:960:b9ff:34c:57a6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bfa43f12sm1209002e87.53.2025.11.28.05.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:10:51 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.18-rc8
Date: Fri, 28 Nov 2025 14:10:49 +0100
Message-ID: <20251128131049.7584-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of pmdomain fixes intended for v6.18-rc8.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 6a23ae0a96a600d1d12557add110e0bb6e32730c:

  Linux 6.18-rc6 (2025-11-16 14:25:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.18-rc6

for you to fetch changes up to c98c99d5dbdf9fb0063650594edfd7d49b5f4e29:

  pmdomain: tegra: Add GENPD_FLAG_NO_STAY_ON flag (2025-11-24 11:14:01 +0100)

----------------------------------------------------------------
pmdomain providers:
 - mediatek: Fix spinlock recursion in probe
 - tegra: Use GENPD_FLAG_NO_STAY_ON to restore old behaviour

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      pmdomains: mtk-pm-domains: Fix spinlock recursion in probe

Jon Hunter (1):
      pmdomain: tegra: Add GENPD_FLAG_NO_STAY_ON flag

 drivers/pmdomain/mediatek/mtk-pm-domains.c | 18 +++++++++++++++---
 drivers/pmdomain/tegra/powergate-bpmp.c    |  1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

