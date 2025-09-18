Return-Path: <linux-pm+bounces-34989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9DCB86394
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 19:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B561CC3956
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A52C316181;
	Thu, 18 Sep 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="NpoRcLF0"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F1C26A088;
	Thu, 18 Sep 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216837; cv=pass; b=QbHBmLXcBSvlncmaRoPjTznfcuunHnwrSCx+jA+K+sazBSfCQuLpuIL14uKlaq8ftVWPGNWbmJvnkaPbfpyXms5byhPedHcUT4iVeWW2m+c9ctezpRMV1SxZ6NQXvNqXOhjkME1SZsvVPOWedvRiJYcOKdnDI/3dvMNfnxOzbXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216837; c=relaxed/simple;
	bh=JHvmGX12m1wQzYIPj83q/PsLtKN9HV+s4oY0ejVQxI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aL+1NQkLmszYgbbMJFks6Z7yEm7+ooZIpF4t3cPCEVCqTJrg0azc4DBEtYF+ZnN1/jaEX6vFF6S/Ay8AYb1j0nWWE/QanpXMNuPGuKsNWjyQLj4liuQ5cF6K+owlDpHo2aQuNhT0gJrI/UtamIer9g52KKR3/H+UO3n8facFVCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=NpoRcLF0; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1758216818; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IoqDInUzbSjfXo4SKiiwDqhYG7FfiqcuR8Cghf+1+RHm4YntQqEXI3e6pAxiWeU+7B8XRyEyevx7/5YzjLTSHfF6Zkd6BnwAQuUc9+A1pmwf9d5RJPBqOUxoLZ9HCCGelP51cbC3kZltifJCCTLJwaaa8HnQhNooCsL7GebxaOY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758216818; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yUthklRovuuMcuH7eOn/Jmb2HQ/kbKqWsy+DVuHow6M=; 
	b=nr0LYtbLXgpCsN3r28VZRLHxrbg1cSV7FhoBamc/Xlmc8DF/RrRjJDhnuSogdArbuEJOqRltadXX1gjcxM7IFZ/ZYywGVPWvkgjfsqXYNXplJdv+7vKQPp6TqmiHUcJuGhJFr96s7hs6t03Yf3RUgqOl9OzU1VdtbD473IKGKAw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758216818;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yUthklRovuuMcuH7eOn/Jmb2HQ/kbKqWsy+DVuHow6M=;
	b=NpoRcLF0/Bz5x9s/3XaPoQS0wCr177wsdE6bNvS5v438GjmlZ6aul7KruSXXp0yq
	+FeBL32EnQV9GacpgIVv36LTQM6k3EFZnbfZft1QFQ4oV9Npa8OGi9HLxSMsEnikWUh
	prbzCf79pWV5JtBcOTc1laZeB3dwRSRPeY76Qp0K8cNwBPJkjsPB2on27mez5G0tKO6
	yQ4i3Cl3v7QrrZX0vlQpafiAmd2lX7kwSmjBvOkOkw3d6vGojXCP59Gr0GiGq9oyqFh
	8x7GFV4OYBrUoeKIE1jhXCtDVf1PoKS1nFg/JrnE+cqXftsl/SeHZucaEknz8bM7n0Y
	OS7RqOLIQA==
Received: by mx.zohomail.com with SMTPS id 1758216817402958.4122287213521;
	Thu, 18 Sep 2025 10:33:37 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 0/2] Poweroff/reboot support for TH1520 via AON
Date: Fri, 19 Sep 2025 01:33:21 +0800
Message-ID: <20250918173323.340738-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patchset tries to add support for poweroff/reboot on T-Head TH1520
SoC by calling the AON firmware.

The first patch creates an auxiliary driver for this, and the second
patch makes the driver currently matching thead,th1520-aon create an
auxiliary device.

Icenowy Zheng (2):
  driver: reset: th1520-aon: add driver for poweroff/reboot via AON FW
  pmdomain: thead: create auxiliary device for rebooting

 MAINTAINERS                                |  1 +
 drivers/pmdomain/thead/th1520-pm-domains.c | 14 ++++
 drivers/power/reset/Kconfig                |  7 ++
 drivers/power/reset/Makefile               |  1 +
 drivers/power/reset/th1520-aon-reboot.c    | 98 ++++++++++++++++++++++
 5 files changed, 121 insertions(+)
 create mode 100644 drivers/power/reset/th1520-aon-reboot.c

-- 
2.51.0


