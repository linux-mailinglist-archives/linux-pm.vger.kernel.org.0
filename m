Return-Path: <linux-pm+bounces-35785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D73DBC1396
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 13:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BAF189602B
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 11:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEF52DAFD5;
	Tue,  7 Oct 2025 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMXfIbdu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E819E7F9
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836808; cv=none; b=kdwLCBzxuv3walV3rbJsFGB3kHL50mgOXN8D3IzjlZ8HH4VwIwIq45f45Gx1pLeTI+NoaDrSTFQZu65wKpOKZ+SrVUPmAP8mBe+2Te82hjDH6ydYyR5VcCLYkphLghk7WYP4f96YMuCsGsKg9Pz+Ns48100TyJgTGsiEHmhudMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836808; c=relaxed/simple;
	bh=RreNBgcHcd8C54RBRAXq1rSo4fvG1VkY8fYy6fi+J9k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=j+MH0P+2VF4FmDkZBzHupfCp2lHI0F8EYB163917Nvxud76StdK1CjjmkUKQcspqmQWrCIQmcRm1rUq9fd3qQIPXEpB3kA8fuCRh3m/dvd8Pli4S0WdK44ClJKoyUp5FLZfWWvn1pUva82kzrkh3DLxXX8yUttfQgxhqDpB/1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMXfIbdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0137AC4AF09
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759836808;
	bh=RreNBgcHcd8C54RBRAXq1rSo4fvG1VkY8fYy6fi+J9k=;
	h=From:Date:Subject:To:Cc:From;
	b=WMXfIbduFN67EseDySexGpel0o2teqE2slzjIc5trVFWdWQ7HWlAmphPa3LGP6irV
	 mr6ktrYgN5X2tX85mb0Jxp3xv/E/usacJ8Turo0d0r3vsoQGHRIR8NeCCz8veONRKm
	 OeEYS5Ijr+j2qA4eTE33VEux612O/r3xzf1twBwDc9oV2Ekc1SAfZyYycJV22tYFxK
	 TxNuR86e1/1uJMzWyO6EP2KzNNxl+YWfUivVnUyVOt2IEAmzOts7NZ7tDncrn+tnrn
	 O10oRoSH5qrwe66gRio/6N9YdFJLu5OxzWdX7CphiBdP9lnKXArP5UKSmoImLmLtr4
	 7QrMBIr7VBEKg==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7a7b084ef77so3510928a34.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2025 04:33:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YzIOKOthTvK/EMHd4ijnxkoqFaDSS0UJP5Jby459QmQ1ZrwoQtQ
	m6aIGPgs98+SfvCaYJrBcQFzez1XNkQ4OYyq3cjDbnxePoCFXIimuMDPadJmYqGnnY31/xOiOnp
	OfzB5ciwI8ygp4owb5aikH8rV4s8eGCc=
X-Google-Smtp-Source: AGHT+IGEK+FtvwNkqJhxOwWhJIYjn2fiu1tyne54MUIHP1qMNgp9WkOhRZm0r1jR/BASRLIQt8mD+Y6Yr1YWGHr+hnQ=
X-Received: by 2002:a05:6808:250f:b0:43b:7bbf:9a78 with SMTP id
 5614622812f47-43fc1888183mr7777788b6e.43.1759836807336; Tue, 07 Oct 2025
 04:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Oct 2025 13:33:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gbqcV1GzM6AKzt0kob8ZzuDYRRVyXCEMqD9kL_4ZPNOw@mail.gmail.com>
X-Gm-Features: AS18NWBIg9wjHUkiw2sshfqd7FF__eIjEnw3ac1KUN_IjwRdPT1ECzvaHFX19Lg
Message-ID: <CAJZ5v0gbqcV1GzM6AKzt0kob8ZzuDYRRVyXCEMqD9kL_4ZPNOw@mail.gmail.com>
Subject: [GIT PULL] More thermal control updates for v6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.18-rc1-2

with top-most commit dea00c204e7e99aca9a4cb8603174c4cd0051728

 tools: lib: thermal: expose thermal_exit symbols

on top of commit f13ee7cc2dca5ebbd7f01e14d6c8db1caabd863b

 Merge tag 'thermal-6.18-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more thermal control updates for 6.18-rc1.

These fix RZ/G3E driver introduction fall-out (Geert Uytterhoeven) and
improve the compilation and installation of the thermal library for user
space (Emil Dahl Juhl and Sascha Hauer).

Thanks!


---------------

Emil Dahl Juhl (2):
      tools: lib: thermal: don't preserve owner in install
      tools: lib: thermal: expose thermal_exit symbols

Geert Uytterhoeven (1):
      thermal: renesas: Fix RZ/G3E fall-out

Sascha Hauer (1):
      tools: lib: thermal: use pkg-config to locate libnl3

---------------

 MAINTAINERS                      | 14 +++++++-------
 drivers/thermal/renesas/Kconfig  | 14 +++++++-------
 drivers/thermal/renesas/Makefile |  1 -
 tools/lib/thermal/Makefile       |  9 +++++++--
 tools/lib/thermal/libthermal.map |  5 ++++-
 5 files changed, 25 insertions(+), 18 deletions(-)

