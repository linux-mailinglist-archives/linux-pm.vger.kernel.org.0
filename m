Return-Path: <linux-pm+bounces-25759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C89EFA949A0
	for <lists+linux-pm@lfdr.de>; Sun, 20 Apr 2025 22:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723F8189091B
	for <lists+linux-pm@lfdr.de>; Sun, 20 Apr 2025 20:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99C01D86F7;
	Sun, 20 Apr 2025 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIr56xHm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF41D79B8;
	Sun, 20 Apr 2025 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745181743; cv=none; b=QGk8SJPGNMBhGUnulKoYbznNPxo8k+Hs96eeA9JueTQ+LqIHzYEXHpwL1SS+cgvSGvOjSTPeqp8UDMnHYDwF/hevXFKArqXfqyVTJ2Hh6eCG9WnfpKzcAWp/gVicles8r/g6axpLczfPZw23dCoLVRiXFInecZ5Rq3V3Kxxe+E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745181743; c=relaxed/simple;
	bh=kKokJEjFYi8Ksm5QQ3qONIkFxJYvW00e94gaOUzw0KU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AUj2fvHyt63LnbBcNRdrlkA3nRwUoiC5lYFw5hohzJFznsmZouzHBjw28FvcUOwi2ae3beEiCXRaLwFsOCHcjdjsc59bMy/C5vJeVMgRgyalPnkPUxXASnok+/3k8oOYSrlEsWGhtrAwylvxtKx3gwqt+vih0SP+ThXPDp7IOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIr56xHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DF81C4CEE2;
	Sun, 20 Apr 2025 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745181743;
	bh=kKokJEjFYi8Ksm5QQ3qONIkFxJYvW00e94gaOUzw0KU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gIr56xHmNvirBjarLbxoiuBYCfXcCEe3k69o2L50dx+shTPQRPB0wECCJbPC739IE
	 eK61W4Me1DmEHksOJJ+HA13teXrwiFKBGjFlf4Y4fEJbj65om94W3Si9BbAhRWXHre
	 vZXhKQXMKncxHUZyKAm70aEMcUXsQ6IjHOxQrVr2qCLT8zbJwXhq/phuiK2scr71gV
	 fhx3EAdbiytsOfi5gaErJHUxyo443MwgoHUjS5MRbDmTQ68b7+3ngV78z8ukxov1li
	 gX/TjPoZSDwZ8TTB5kkHJQtRbowTpOftvxWrkz94KQwzzVw/APTVywH6hGGuag6Sai
	 PFjPDCi8MewSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A910C369C2;
	Sun, 20 Apr 2025 20:42:23 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH 0/2] Support building tegra124-cpufreq as a module
Date: Sun, 20 Apr 2025 15:41:59 -0500
Message-Id: <20250420-tegra124-cpufreq-v1-0-0a47fe126091@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABdcBWgC/x3MQQqAIBBA0avErBNULKirRIvQ0WZjNlYE4t2Tl
 m/xf4GMTJhh7gowPpTpiA2q78DuWwwoyDWDlnqQRipxYeBNaSNsuj3jKbybjPHO4qgttCwxenr
 /5bLW+gFDC4nxYgAAAA==
X-Change-ID: 20250401-tegra124-cpufreq-fd944fdce62c
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745181742; l=748;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=kKokJEjFYi8Ksm5QQ3qONIkFxJYvW00e94gaOUzw0KU=;
 b=26xLAOIifCd1GbPdD4cj7WbTjM8dDmrB5R6GMNa+xPo4UL312EK7dD7DYkaLNRXaYp97iv/MR
 pSFG6kKJE/+BCPHLlYpf/wD7I47/EmggR4tGnHKLzdWe5t1XmyL845j
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

This driver handles power management while offloading the primary
cpufreq operations to cpufreq-dt. It fully disables cpufreq during
resume if clocks fail, thus it needs access to a previously unexported
cpufreq symbol.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Aaron Kling (2):
      cpufreq: Export disable_cpufreq()
      cpufreq: tegra124: Allow building as a module

 drivers/cpufreq/Kconfig.arm        | 2 +-
 drivers/cpufreq/cpufreq.c          | 1 +
 drivers/cpufreq/tegra124-cpufreq.c | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)
---
base-commit: 91e5bfe317d8f8471fbaa3e70cf66cae1314a516
change-id: 20250401-tegra124-cpufreq-fd944fdce62c

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



