Return-Path: <linux-pm+bounces-627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD6980153C
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 22:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BA8B20E28
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 21:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93FE5914D;
	Fri,  1 Dec 2023 21:21:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4481E10D0;
	Fri,  1 Dec 2023 13:21:24 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1faf1ba2219so127537fac.0;
        Fri, 01 Dec 2023 13:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701465683; x=1702070483;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P006BstmV7W/R+YlcJRbFIYya/BbanV1UGsaFy8YvWQ=;
        b=TP+l4U+c2gE3rY4JrGuFI75TJEx7SMtigTHlcNWvDo7kQAjBBTUniRlStY2z1wy6UP
         FK+0dK83RaCNnniRWrFuwGqvRAcTkH1MWXbjd1zjVHA2+ZLqeBcsA75yBj8HO9wu8hAW
         TvVqbOzbQfVv0OQA1ct2E8X0sm3Z+cGim4MMyX7DWv5ODG4LtuYVNPuOxgX8ugBTfDSV
         RV7wpVUYAEGHDEL6b1XkStbYynVul5hT6x0lMsW3mbclUCwex/UWVt1FKK/jWFL3JuSq
         ytHoa3+Vn8r6Jq5UZMXDB70jc5gLp9tA2POtk3NzaKT33APbJJW98YyXkJUpOb6BboWm
         tuvw==
X-Gm-Message-State: AOJu0Yz/C96pHGswZdjwmCAIgY+IhlQ8LiYlHBqx4yIY1a9VI2aR1PNt
	eZa30VVprT963v6Jd3n3BGHpIvOq27Ib011qLto53Nmc6C0=
X-Google-Smtp-Source: AGHT+IFmQSHvTpybN3UOScBB7T43eZsK6+QIfRufv3Bmbewgran0EV+2WT7QeEhm0MGftcutKRE+etna3KUjqEKf3R0=
X-Received: by 2002:a05:6870:169b:b0:1fa:db26:78a6 with SMTP id
 j27-20020a056870169b00b001fadb2678a6mr5351843oae.1.1701465683453; Fri, 01 Dec
 2023 13:21:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 1 Dec 2023 22:21:12 +0100
Message-ID: <CAJZ5v0iHKMcpK+B9dzCbDJxqZK79PoGdbLUD5hRH6sueAMgKGw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.7-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

 Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.7-rc4

with top-most commit a6b31256928d78204f8f282220d3b0d64387f79d

 Merge branch 'powercap'

on top of commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab

 Linux 6.7-rc3

to receive power management fixes for 6.7-rc4.

These fix issues in two cpufreq drivers, in the AMD P-state driver and
in the power-capping DTPM framework.

Specifics:

 - Fix the AMD P-state driver's EPP sysfs interface in the cases when the
   performance governor is in use (Ayush Jain).

 - Make the ->fast_switch() callback in the AMD P-state driver return the
   target frequency as expected (Gautham R. Shenoy).

 - Allow user space to control the range of frequencies to use via
   scaling_min_freq and scaling_max_freq when AMD P-state driver is in
   use (Wyes Karny).

 - Prevent power domains needed for wakeup signaling from being turned
   off during system suspend on Qualcomm systems and prevent performance
   states votes from runtime-suspended devices from being lost across
   a system suspend-resume cycle in qcom-cpufreq-nvmem (Stephan Gerhold).

 - Fix disabling the 792 Mhz OPP in the imx6q cpufreq driver for the
   i.MX6ULL types that can run at that frequency (Christoph Niedermaier).

 - Eliminate unnecessary and harmful conversions to uW from the DTPM
   (dynamic thermal and power management) framework (Lukasz Luba).

Thanks!


---------------

Ayush Jain (1):
      cpufreq/amd-pstate: Only print supported EPP values for
performance governor

Christoph Niedermaier (1):
      cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Fix the return value of amd_pstate_fast_switch()

Lukasz Luba (1):
      powercap: DTPM: Fix unneeded conversions to micro-Watts

Stephan Gerhold (3):
      cpufreq: qcom-nvmem: Enable virtual power domain devices
      cpufreq: qcom-nvmem: Preserve PM domain votes in system suspend
      pmdomain: qcom: rpmpd: Set GENPD_FLAG_ACTIVE_WAKEUP

Wyes Karny (1):
      cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update

---------------

 drivers/cpufreq/amd-pstate.c         | 71 +++++++++++++++++++++++++++--------
 drivers/cpufreq/imx6q-cpufreq.c      |  2 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 73 ++++++++++++++++++++++++++++++++++--
 drivers/pmdomain/qcom/rpmpd.c        |  1 +
 drivers/powercap/dtpm_cpu.c          |  6 +--
 drivers/powercap/dtpm_devfreq.c      | 11 ++----
 include/linux/amd-pstate.h           |  4 ++
 7 files changed, 136 insertions(+), 32 deletions(-)

