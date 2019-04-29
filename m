Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1A2DFFC
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 12:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfD2KBQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 06:01:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40149 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfD2KBQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 06:01:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so4909899pgl.7
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 03:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pKwVI940bZLusF6NLVE9cd0LjfTsiopNb61qEXhVwZI=;
        b=pHl8veCju6Jc0fMtfwa/zG4F7ILH0RYWXZEFGyjj0IOQspxtVVUegXl9maCJefrWnl
         OTCaLwNob7N1E8wKonHwFDl6EI61LcwvGXQOSE8uDHdCZ0xd5+QEIfolpXpFZ5DdfEye
         mdluTGDGC7Ivetf8MX/BUs3obUmLdAKjF/DOBPkAmbC7KIp5qh6tM3jzr5ok9V2Qxo89
         d40uLpGraDzxr/QZ3rpmzSsghwi8yFovJUGMtuDKk9GSgn6ZbDbgf79z379ASguvF1ak
         E5wOzrJNmqzPvtOCtzNDIwXRGo32mkbO1COpIfpOGfBQRH/RbYMgrf6pX/vYxb1G9aFP
         hLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pKwVI940bZLusF6NLVE9cd0LjfTsiopNb61qEXhVwZI=;
        b=g8+meyVCtNv9kVA2Zq/a8elRLrr5GH2dB7NYZFdx6wee4gKXTDtZdulx7Na6PdTwGM
         N1ZPVCh7nw7x2nXnkcHfTiPHrKKvMU83FC/XDrldZOG+mFCpZu/+CjKztlSe+V1iK2qF
         0CK4M3E/xDddpLYdcsRSaC0iwLERsG1egktSSyfagQCTNCbxd+Fs6tcKlV7K+/sRwPkF
         JUVsywUFEj43pvzekwuEmUyKYDra7Wu+dyCOQ4wDK7UmLgjC4ZbCaZJHtLmbQ/sjLRPO
         AHOZaFcGWz1z4Dp9MIBtd0Wap8HB4FWfXxq0yeWneRvHsoVDNfWDCNj5un/Ze5hF/XJD
         FnqA==
X-Gm-Message-State: APjAAAVWyis2cMpNIz29Ld445yAyPdpqYvtVpj1GRcTQOyfBYBX+BG1Q
        Ih4gm1CS7tOBe1y2EVVo3KZu8n+r7Ok=
X-Google-Smtp-Source: APXvYqxLzurVPJLO9x9JJHkJ9/Lh4++vWjlP58O/BBtgfhGf/YeZzQOwy0/v8p0uUBRjnU/MovsFfw==
X-Received: by 2002:a63:1055:: with SMTP id 21mr38851990pgq.200.1556532075576;
        Mon, 29 Apr 2019 03:01:15 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id p128sm59196124pfp.30.2019.04.29.03.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 03:01:14 -0700 (PDT)
Date:   Mon, 29 Apr 2019 15:31:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP changes for 5.2
Message-ID: <20190429100113.s5pwr6q6rsiebwie@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains:

- New helper in OPP core to find best matching frequency for a voltage
  value.

--
viresh

-------------------------8<-------------------------


The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 2f36bde0fc8f1ab79d54bd2caa7c1cf874fd2206:

  OPP: Introduce dev_pm_opp_find_freq_ceil_by_volt() (2019-04-10 12:13:31 +0530)

----------------------------------------------------------------
Andrew-sh.Cheng (1):
      OPP: Introduce dev_pm_opp_find_freq_ceil_by_volt()

 drivers/opp/core.c     | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  8 ++++++++
 2 files changed, 62 insertions(+)
