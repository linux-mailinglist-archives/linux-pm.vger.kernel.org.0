Return-Path: <linux-pm+bounces-17611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEF09CDCCD
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 11:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655901F23029
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FD519CD08;
	Fri, 15 Nov 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGQzV+hM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6DF38DD8
	for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667240; cv=none; b=EEPRFfzHK/6CjjXIwoOxuo4tkAJZtYSgmrl9DvJoGkme/B2AWyUE9kLxO4psJ59h2JrFBsCUrf9s64UR8aa0hwMlgQ7K8Dr8PHDIQYi1vLI6RwVbMlpvMbDJEWaCasCGu5w46otBtimd3bP4ezMoCCBAzl3z6xg9w1ThKepYXKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667240; c=relaxed/simple;
	bh=ilGIpaaX54RTYzqtFywkuJv9jhWNTIMieNFKaKBDOHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DgmF4ZPsTmGtTENw5TYVQvAta2Q0sjy3hi/nvr/trcdFSV3Rgx+9I8dvRH3WVEbHBqvQQSWvdWB8RLBq0MC0Upgx9OlWZxRthu7/2yWcP/kzSQPuNlIAfX3Qum3B1zCdcq+6kCT2W9PIV8t2DsmuBfGVrQgm6xrR5N+3u4hZdtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kGQzV+hM; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5111747cso5508481fa.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 02:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731667237; x=1732272037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Z6LvJ/sPB+Dl1kFLmZv/mrYyYjioWG5VXi0FQmBtqQ=;
        b=kGQzV+hM7h+DcWptLj5py2CSLh2d4JokTi2eou7qvm+pq5A5tJbBzKzJzGgFeaeMmi
         bbhH2cUTCS/yqArL+Kkurrrw+ddcawsufneyJjoSIJvYJPgtAxwjeXUmBYi+Bem3b93L
         B1i6ltMpMjTdeFcmpLa+bFLmVoCJpbCGi2XUbeV3taWYDE1SKsLTpJALjm0jHFgsQv5t
         FH/KRRR/LfRfgJEld1p99b9ASmceO+FsKov8wRdqQkHBZcklMD3RRm7/fgycicovrQSu
         RdVhCVzcZQyp0jrFziUDaqV5lyD1CRMiyCr+m4UqsXf3QLqnvA6y4NTOgQVYdNhwNAgF
         iTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731667237; x=1732272037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Z6LvJ/sPB+Dl1kFLmZv/mrYyYjioWG5VXi0FQmBtqQ=;
        b=Stj4sSQj5GAJNWzMZpc+KoyxznDzx+/bYOfj7JWAUvPoTYhZ9e6Niz3w7QX61oAbsS
         azKzjLRS2Ukg2T1/ZG6BPNTcoV0OIuJvHkEJiEV3eqaUzEQsU4IvvsRplTHH66Jgi6v0
         l0BEcSiPOrUzLhxrJyzg5B/AbXJaLQsWmzOWByPk2BuZFB5yLY3NUDhGLRQb9QYv4Dps
         5EC6swvqrweebsA9e3Aa0EVr32KqdslP5TnIa0GlgSihgRy3zH9BrpdL/NKlr8TNYTgc
         sRmsXh1MsBnNRDypojDs73HhOKHCvq//Drn9KgOmceHyKylZn2z2jPt9/8S2x5DOkxap
         prYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSfEFRJysRGLsE/KDTPfI8Uk6mMPbzWd4FdpNqxxFg2shTLDNJf90hFnaMS75bZkR4buQtfJ5LPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRuq/ZKmIokXFwunEpnJJW2FPHGDAYFgzp9mfsC0AVb7YgEb49
	R8J7iBGFu9vx5gQwowYecsORRtNCd6pC5qk6mC6Tf3hrjaATuTobZNiiXFSTL7I=
X-Google-Smtp-Source: AGHT+IHochvip3ndT36pY7JzUJ9o2k/DM6zBRNTgAKVEogfP3W6wLBEgo4qo8JTEtM7I1Em76KrM6g==
X-Received: by 2002:a2e:a99c:0:b0:2fc:97a8:48f9 with SMTP id 38308e7fff4ca-2ff606900f0mr14332601fa.19.1731667236678;
        Fri, 15 Nov 2024 02:40:36 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff597a067dsm5179361fa.65.2024.11.15.02.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 02:40:35 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain/arm_scmi fixes for v6.12-rc8
Date: Fri, 15 Nov 2024 11:40:29 +0100
Message-ID: <20241115104029.119226-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of pmdomain and arm_scmi fixes intended for v6.12-rc8.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7738568885f2eaecfc10a3f530a2693e5f0ae3d0:

  PM: domains: Fix alloc/free in dev_pm_domain_attach|detach_list() (2024-10-10 13:55:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.12-rc1-2

for you to fetch changes up to d2fab3fc27cbca7ba65c539a2c5fc7f941231983:

  mailbox: qcom-cpucp: Mark the irq with IRQF_NO_SUSPEND flag (2024-11-12 19:45:25 +0100)

----------------------------------------------------------------
pmdomain core:
 - Add GENPD_FLAG_DEV_NAME_FW flag to generate unique names

pmdomain providers:
 - arm: Use FLAG_DEV_NAME_FW to ensure unique names
 - imx93-blk-ctrl: Fix the remove path

arm_scmi/qcom-cpucp:
 - Report duplicate OPPs as firmware bugs for arm_scmi
 - Skip OPP duplicates for arm_scmi
 - Mark the qcom-cpucp mailbox irq with IRQF_NO_SUSPEND flag

----------------------------------------------------------------
Cristian Marussi (1):
      firmware: arm_scmi: Skip opp duplicates

Peng Fan (1):
      pmdomain: imx93-blk-ctrl: correct remove path

Sibi Sankar (4):
      pmdomain: core: Add GENPD_FLAG_DEV_NAME_FW flag
      pmdomain: arm: Use FLAG_DEV_NAME_FW to ensure unique names
      firmware: arm_scmi: Report duplicate opps as firmware bugs
      mailbox: qcom-cpucp: Mark the irq with IRQF_NO_SUSPEND flag

 drivers/firmware/arm_scmi/perf.c        | 44 +++++++++++++++++++++--------
 drivers/mailbox/qcom-cpucp-mbox.c       |  2 +-
 drivers/pmdomain/arm/scmi_perf_domain.c |  3 +-
 drivers/pmdomain/core.c                 | 49 +++++++++++++++++++++++----------
 drivers/pmdomain/imx/imx93-blk-ctrl.c   |  4 ++-
 include/linux/pm_domain.h               |  6 ++++
 6 files changed, 78 insertions(+), 30 deletions(-)

