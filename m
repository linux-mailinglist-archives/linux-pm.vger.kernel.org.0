Return-Path: <linux-pm+bounces-38050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C73C5E8C0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C2F73A4EBD
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4957F330303;
	Fri, 14 Nov 2025 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8RynZl5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41B32D432
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136718; cv=none; b=gPwh6gqcidSYfCphdQllqDxs817JhmkGm2A5cwqaZtm7dyKNNi6v6krYJxt11kGJnSRucwgl5XshCPPuRGh1QFiOYxyNsEjqpGQxx84cNU7avV7QTr12rsniIsdUXNPWuc7op2DN9iMK8sOdPU+tOrL7EUIuCk3zHc3FiU+bAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136718; c=relaxed/simple;
	bh=ND1G3qoy+JHM8+IvcJxTR6Dp/QmSGS9bB8N2BVeV0Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MJbaczr/DDL4oQmLONfE2NQp4jM7Z1P6fIqul0LNQd6m//M0M8y7yo6CihIZeHjrr0xL9i+jvfMYlSFUQpFP3wDIEkQd/kKZaQLHA2GUQB+pZBKraj6pEICXgW1YmO7dviyZjSUxsjWak5GyG1CgPoCwsvSS1vQ7GN/76OTayb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j8RynZl5; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37a2dced861so29930861fa.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 08:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763136715; x=1763741515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSNhX2pkt7zcNqtt73B/SxXjHG2Uh9RLAgF3dQ2MWK8=;
        b=j8RynZl5nIuyofMPcnIg0JFRypTXS93o5SL98jy0nwLF4U3x49KruI2ILeiUPflvRp
         pJOigSp+RQmoByvivc6OwJ3cLOFOqFn+El6q8J1ZAJR4jmxmlhcWcXNv7js03ehO12Lc
         neFu5198q+80L6elkILRNBLJtECmdfR8txSbvE3kZxho59AE1q10n3J/QE29XhsbIlts
         adO032fjNtJJsHV1ssbRCEEojp2W/dZk0oWwEN4rkoJ6zU9zJpFzSw18ufq1RcMHcN6i
         2gtdwThYqP93sleY9Ld4gEpptHhufUU7lHqpD9Hd7u6BPxvW410d5zSqihkIAGhQOp85
         oC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763136715; x=1763741515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSNhX2pkt7zcNqtt73B/SxXjHG2Uh9RLAgF3dQ2MWK8=;
        b=Yy1qEr9VbYDhuQFGaLfY8NUdjii9sJ2JdZ0shwst8Li6xRcZJbQ7rIEUOZR/TxhLNY
         9tyVXjP0DZkKhduqMLeN0ZFSjHcfbsYZQw9qx1mUdIvCQbNbmHsNeEs6avf/vTUHr/Od
         Nz5u0OXsoK840nK+IiHJi1FGi0T/C/DOP8MNTK9562xLEzNpP3tlq/18MOTsvmeJ9hio
         ZX+BSWeluycikSWZ7elavBVgNW1KbHuf/EzVCnUQdlCePUMRNfMXumqFdpZ19T2m2qMk
         3Ekz9SbtABJIiH6qDxy9Porc9MVCZa5DT36yRLDcsl8Ce7+RQwEWeZwN5CkMQWv1DuGW
         O1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZT6Jl4bTiJqpoWCDGLwTdXA6j7lWS0ru+eVLp0ZQ5w5r1d8Rz+rJHpePTIs8t+iFyXAse4L6qdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHb8vUFTg/Cx2Z/KcrT4Ksg261mC2R8upJRCV6og+/02i2RemB
	YP60CrFkrHhz7M1Jir3bi8d1k9MYYC69qR1WCNYjDL8qVxLwT2WrCftGJinwBkmUBi8=
X-Gm-Gg: ASbGncvj/rYrAvdie6Py0KvE9eTUU0sy2tfaJ9Gf+7/Hi5IcQG5RKVj/aMQ0wl7H7FN
	JaJfdCxqwHTkdjSTQuEhqQYaj+M/IjlwIfbU/Budg7mBlOu6Zuj5DI80MCrJtfeCA0OndTjAHV3
	jAOTt9pefMJfP0Y4jOQMAzvn3csMaH9ERXrBxlc3bAefTnGZyi7FlXV3KkczYz0rAI+/NnvIpvQ
	f5O2cf2vEGRxMFB6Q3zfEyZsazdoGGsz+/ZOGH2o/thnvJJPGWr+Jiu0aMljVS4oOG6xcK5oRQd
	bMiBmL8t5XNhNcMi4r1LTpX1BN02X1Gj4nWd167/UEQ4aF31N36cF/yE+/GQd0h1Rma0n0sTBcn
	DbbsN8nveWdeMNJGGtoME3DsLb4jSAIGvktc2nxsRlD+20huk7++1/n+D9aIuRixIXBweYksaRv
	NsMJ6aVGwwCdxpxrVJtAvDWrlanckEVE3ehDEF3gKSUaeRIW+aGrkBN2xNmUl4
X-Google-Smtp-Source: AGHT+IE/hPBAWD9qBVjQMVIn4EUSgwCIcA9zVNyR1z50W4cCJMeA0fLeL7x9Slc5b9xh7VmbI0rqbA==
X-Received: by 2002:a05:651c:3041:b0:372:221a:b124 with SMTP id 38308e7fff4ca-37baacd9bbamr8456321fa.0.1763136714550;
        Fri, 14 Nov 2025 08:11:54 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37b9ce080casm11520281fa.5.2025.11.14.08.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 08:11:53 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.18-rc6
Date: Fri, 14 Nov 2025 17:11:46 +0100
Message-ID: <20251114161152.92955-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of pmdomain fixes intended for v6.18-rc6.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.18-rc2

for you to fetch changes up to bbde14682eba21d86f5f3d6fe2d371b1f97f1e61:

  pmdomain: imx: Fix reference count leak in imx_gpc_remove (2025-11-04 17:29:00 +0100)

----------------------------------------------------------------
pmdomain providers:
 - imx: Fix reference count leak in ->remove()
 - samsung: Rework legacy splash-screen handover workaround
 - samsung: Fix potential memleak during ->probe()
 - arm: Fix genpd leak on provider registration failure for scmi

----------------------------------------------------------------
André Draszik (1):
      pmdomain: samsung: plug potential memleak during probe

Marek Szyprowski (1):
      pmdomain: samsung: Rework legacy splash-screen handover workaround

Miaoqian Lin (1):
      pmdomain: imx: Fix reference count leak in imx_gpc_remove

Sudeep Holla (1):
      pmdomain: arm: scmi: Fix genpd leak on provider registration failure

 drivers/pmdomain/arm/scmi_pm_domain.c        | 13 +++++++++++--
 drivers/pmdomain/imx/gpc.c                   |  2 ++
 drivers/pmdomain/samsung/exynos-pm-domains.c | 29 ++++++++++++++--------------
 3 files changed, 27 insertions(+), 17 deletions(-)

