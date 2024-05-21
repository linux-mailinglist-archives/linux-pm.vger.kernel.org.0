Return-Path: <linux-pm+bounces-8017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A277F8CAAD4
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 11:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CA51F22912
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7467054BF6;
	Tue, 21 May 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaYLpm+n"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAF63B1A1;
	Tue, 21 May 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284036; cv=none; b=VSKlrluFk90AcBruIp0SP8UF43MKoHkCLZiRizIvkhVN7EwlNFh0Kjc05ZISvcb1Mm73AJCXQaQEFlJ7qGjOeIYAAe137TmHgUB9eBlr6C9YcJOi21csDvsybZEb3l+SQKO0eWnJi9YU46jfa5rIGgEfcKekinVxRf7PajFnyUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284036; c=relaxed/simple;
	bh=B1Gn79WQQ8yvHOCpRPqpniMSnY0uNccKCYimm+T2ocQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Jrsi+VD/chmdlpyNVrliUuvbCoGvv08iaj00jNLMILldP+MWVgqPMOBvUt0wc40KCBRmrHWG9Y34j9zlhe77KFYUODSBka0SIFCzL3z9IULTkUJ7GggZ2xlIfl3ES/7d4wDlnA7bzMmQJ1ub/L2vhN7fTvfDL4O8qSl4R37BZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaYLpm+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE81C2BD11;
	Tue, 21 May 2024 09:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716284036;
	bh=B1Gn79WQQ8yvHOCpRPqpniMSnY0uNccKCYimm+T2ocQ=;
	h=From:Date:Subject:To:Cc:From;
	b=SaYLpm+np8Eq2B3d/+pQETfG/1q3P1AwwEnZ25iIdqrosyjGHR8hrdBPWP/bhFEw8
	 4XOwzZpuDkQ97Gkblrkot8stwmLl2qwQBn0cTAi9aAtYk6yC4VxuYUJYxFl1mgT5qG
	 wD5p6B4afSZ+8tgaXzVfxkjX82VmhTiZAtY4dB0cEHNWppdrrOrgCA4cVokFACPgke
	 UkBWRFSV1WP2U8qFdYqkSfweaImc/vhnQTt8sMogc+LkN9xBOgbMLiKj8bQSHftYj6
	 mF/Bd6kIW2NdwDGuzr7cq1RForsvBEpyXwiBzRx1XE0DIilHBD/nfRJSDW8Hm5CoL/
	 fv7dlW2Vexavg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b2e8d73bfcso387369eaf.1;
        Tue, 21 May 2024 02:33:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiRzs5H/uCgaVovi4Tid2iXoF9GN031vQ6XKUbwsVMCwHEikdv2azjDOSBz9MEJ16KtZz1A3EGqwgUkJ87NMCNlz/3DK07lq3J8XN/
X-Gm-Message-State: AOJu0YzwWh9UuEamGuM4OGSqlkI8f7xfoQvtMUttvoTmNKD1jggaGzIU
	Pt5SOd+rtt3CijiAsaTkcFpf+U/oY3zaFBnyZa6OEhclCcSAPcvYc4ae6EW/g/Zj3Su5YwRCYRY
	oNgVRf3kcxHnCs6qEryjAlFp0In0=
X-Google-Smtp-Source: AGHT+IG4OwrS+P3sSWTGBSzzfhJsUCTDDM/T6YWrWMwghLMTMLUHVYqhMN/+p8ZmGGuZuHdik4hFhiTrmC+98hqG4kE=
X-Received: by 2002:a4a:d10e:0:b0:5b2:7e47:e914 with SMTP id
 006d021491bc7-5b2815e04cemr33416100eaf.0.1716284035446; Tue, 21 May 2024
 02:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 May 2024 11:33:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jui_HzdbhQ+F6_4aLAWb6LnhT9yEnBX82-LuZ40CcF0w@mail.gmail.com>
Message-ID: <CAJZ5v0jui_HzdbhQ+F6_4aLAWb6LnhT9yEnBX82-LuZ40CcF0w@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.10-rc1-2

with top-most commit 8c69a777e480174b1fdd75dab5ad584454dd6555

 thermal: core: Fix the handling of invalid trip points

on top of commit f952b6c863090464c148066df9f46cb3edd603da

 Merge tag 'thermal-6.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive thermal control fixes for 6.10-rc1.

These fix the MediaTek lvts_thermal driver and the handling of trip
points that start as invalid and are adjusted later by user space via
sysfs.

Specifics:

 - Fix and clean up the MediaTek lvts_thermal driver (Julien Panis).

 - Prevent invalid trip point handling from triggering spurious trip
   point crossing events and allow passive polling to stop when a
   passive trip point involved in it becomes invalid (Rafael Wysocki).

Thanks!


---------------

Julien Panis (3):
      thermal/drivers/mediatek/lvts_thermal: Check NULL ptr on lvts_data
      thermal/drivers/mediatek/lvts_thermal: Remove unused members
from struct lvts_ctrl_data
      thermal/drivers/mediatek/lvts_thermal: Fix wrong lvts_ctrl index

Rafael J. Wysocki (1):
      thermal: core: Fix the handling of invalid trip points

---------------

 drivers/thermal/mediatek/lvts_thermal.c | 15 +++++++++------
 drivers/thermal/thermal_core.c          |  9 ++++++++-
 drivers/thermal/thermal_trip.c          | 18 ++++++++++++++++++
 3 files changed, 35 insertions(+), 7 deletions(-)

