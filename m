Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6754D1CECD6
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 08:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgELGIS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 02:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgELGIS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 02:08:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08F0C061A0C
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 23:08:17 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fu13so8870140pjb.5
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 23:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=p7XtvaoFiJVt/R5d+IqguDUpdNaL8OhKuIuM6QPe/Sc=;
        b=Gl/d2K3mdoX0zxHBjQmgbOREPPP8AFmxUux68m3duqpO4fR7hXnhTTRiRB20IFTqkm
         8sqemSp45CG8qiMrXefcnyaYVGnlfLbzm5n+0dFXAjpwblCnrrEsVAucL1mtBIT8+JCO
         RW+Hl1DeFOnJnJCuDhEGEwaZHxVTM0irab1LQD+9cy+9Ec2nfsPiAWkzMyJ9CSptrtHt
         jj6dlZeomfWVaBI0+EObo50IYj7kDV01h0SaeUvmWaIl3SN+PvrNylVji4xh5zeFsjaM
         L1LRndMCYWwRNXduwxgRYI8QnNegf/rsCuBWRCMpZmsTxuHApfiITHJ6xHLPBAlprF0p
         Zq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=p7XtvaoFiJVt/R5d+IqguDUpdNaL8OhKuIuM6QPe/Sc=;
        b=UR4Cozx8yT9TL6lkxHYgmK5W5XfXVuQu/kW3B78de224DH4MGjCgLEVimVV6xPhIAt
         x+dlTfgL+Z9WMCCm6+UI9vii4of5j7LtRAjGi3h7pcG6RBFnbQn6V3IzPYiDXbtNsnGf
         eMPH7OtyfssaCtmZd8n0ZRWxRsDMc4QGTQbNNwM7F/VIjKdATtq26PJJw9k6D6FEOrQy
         IKlpmdxte/0g9OdDbR4jI3t3yLnk+Phc8vlxBdk5rmf5pOFvsp5MgjZQpONMELzNE3B0
         yB7qtAMt7IcZPy450bEoTDUyl6ckKeiYcbLBCQB1r3JTwKy6bby6QNY+I/Zms7t7Lu3X
         T9qQ==
X-Gm-Message-State: AGi0PuZdLWkzzppidxPimq+7mp/46oElBKHEQ/xkssTKGbngy/5axZQA
        IgB2eGs2WWsdeGzUvNNBs3unuRgtep0=
X-Google-Smtp-Source: APiQypL+GM05DpAFMphC7ctyKtGREso8XDuJOAvy5+n7yMuaofbfw8pSQpH/TvUmvzmJ3Zi9/fbQ3Q==
X-Received: by 2002:a17:902:7:: with SMTP id 7mr18904368pla.157.1589263697218;
        Mon, 11 May 2020 23:08:17 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id v1sm7283882pgl.11.2020.05.11.23.08.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 23:08:16 -0700 (PDT)
Date:   Tue, 12 May 2020 11:38:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm changes for 5.8
Message-ID: <20200512060814.jkbbxxsxw45mcmg7@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains:

- Build OMAP cpufreq driver by default for ARCH_OMAP2PLUS platform
  (Anders Roxell).

- Fix compatible bindings for qcom cpufreq driver (Ansuel Smith).

- Update qoriq cpufreq driver to automatically loaded when built as
  module and related changes (Mian Yousaf Kaukab and Geert
  Uytterhoeven).

- Add support for r8a7742 to cpufreq-dt platform driver (Lad
  Prabhakar).

- Add support for i.MX7ULP to imx cpufreq driver (Peng Fan).

--
viresh

-------------------------8<-------------------------

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to 1f1755af4f062cb1cbd55ca4a250fe272b82fe2f:

  cpufreq: qoriq: Add platform dependencies (2020-05-08 10:53:10 +0530)

----------------------------------------------------------------
Anders Roxell (1):
      cpufreq: omap: Build driver by default for ARCH_OMAP2PLUS

Ansuel Smith (1):
      cpufreq: qcom: fix wrong compatible binding

Geert Uytterhoeven (1):
      cpufreq: qoriq: Add platform dependencies

Lad Prabhakar (1):
      cpufreq: dt: Add support for r8a7742

Mian Yousaf Kaukab (2):
      cpufreq: qoriq: convert to a platform driver
      clk: qoriq: add cpufreq platform device

Peng Fan (2):
      cpufreq: Add i.MX7ULP to cpufreq-dt-platdev blacklist
      cpufreq: imx-cpufreq-dt: support i.MX7ULP

 drivers/clk/clk-qoriq.c              | 30 +++++++++++--
 drivers/cpufreq/Kconfig              |  3 +-
 drivers/cpufreq/Kconfig.arm          |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c |  2 +
 drivers/cpufreq/imx-cpufreq-dt.c     | 84 +++++++++++++++++++++++++++++++++++-
 drivers/cpufreq/qcom-cpufreq-nvmem.c |  2 +-
 drivers/cpufreq/qoriq-cpufreq.c      | 76 +++++++++++++-------------------
 7 files changed, 144 insertions(+), 54 deletions(-)

