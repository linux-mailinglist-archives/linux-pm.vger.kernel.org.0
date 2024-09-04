Return-Path: <linux-pm+bounces-13594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991FA96C0A1
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 16:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA4DB2A506
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7B81DCB2A;
	Wed,  4 Sep 2024 14:31:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD31DCB38
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460270; cv=none; b=Ym55xM6dFczY+wJYpZUKVEqWt22mGxEI43VkHjjQaoVdLDxx0+u53jSXxyX5vtM9WgoN7O9l0aXe+NO5zcvozUhGdi6+ZZegcjemdUdYwHG79n1LD943vBW3BtuM/fmTnp7yj9c4KSUH/28+EZCoX0THwhDYb1u5xpqviHCwYi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460270; c=relaxed/simple;
	bh=P467mDUfuNo+4sLO1U0OGgnTSxfzQa2d9CPIR8FgBtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i8QWUWX3Ga0PJGQ8/8T5caQ57P7QBKO8RWnc4Z5dSSTGQvDiAb5puTtl8gX2ZFDP86hGi8kAUMEnma4zjvs4mx6eYoTL7CLKNpEYab4K/6OrWx5/gZ28ZPdk/jlvulhDBFI0ifbHq5XdNLNBCjxI+TTviMyzMibzNqaNrtqWIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:ef52:68c5:eac1:f6b5])
	by andre.telenet-ops.be with cmsmtp
	id 8EWv2D00J3m5in101EWvaT; Wed, 04 Sep 2024 16:30:59 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1slr24-0028JM-H1;
	Wed, 04 Sep 2024 16:30:55 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1slr27-004My7-6y;
	Wed, 04 Sep 2024 16:30:55 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/4] pmdomain: core: Debug summary improvements
Date: Wed,  4 Sep 2024 16:30:44 +0200
Message-Id: <cover.1725459707.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi Ulf,

This patch series improves the table formatting in the pm_genpd_summary
file in debugfs.

The first two patches are fixes and cleanups for commits in upstream.
On systems where performance_state is always zero, the first three
patches have no visible impact.

Thanks for your comments!

Geert Uytterhoeven (4):
  pmdomain: core: Harden inter-column space in debug summary
  pmdomain: core: Fix "managed by" alignment in debug summary
  pmdomain: core: Move mode_status_str()
  pmdomain: core: Reduce debug summary table width

 drivers/pmdomain/core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

