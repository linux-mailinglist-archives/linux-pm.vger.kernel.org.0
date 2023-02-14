Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351D6695892
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 06:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBNFfF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 00:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBNFfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 00:35:04 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C9411EBC
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 21:35:03 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v23so15944058plo.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 21:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzgz8P6j9U+VOO66+AqoHnkSi6hrIE7BI8XAzDYylN8=;
        b=TW9zITri0WH5Lr4ITTUeUIbYQBQxyXoamm9bZ+ZfzRt3OrmsN9n7HCl2OQbIvFr+G+
         c0Sb/2bJWbCeNRYaAb5DD5uDIwCR3ErwmL34bfkMR6A8/KqaWq5bl4B4NRzp+3xrzVL0
         jh6wA11gIvDBbVJr0TV1rGaBWjjYVtuy/GJRHZ7n4nkygsJTzTifp6KVzUuEakcSvsYU
         i/oyAy7ItfvkQuu/kM853LeBfL8hZiNiuDwOvluLsOu1EbN8YSCRlN10ne7PsC+pnv5A
         +Pu4idh2X7ZFjWvPP0oa+MXFp5DIzbToIV8TxiNtKzM/+vvoxipftzJPm1Jnws4q7Q6S
         lJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tzgz8P6j9U+VOO66+AqoHnkSi6hrIE7BI8XAzDYylN8=;
        b=uygk02JYJ5kQfOFQ6p/wAUbHxwUxqHfnxjLOmOKULgyWTzfMKsXHHkL2LuprmKAT6C
         OtF6Yk1aG6xWK5BySmxt2MMjBk33Slr7Yt+Lrwz/Sq8Hosga6PB5dvEiedbMBr4yFrGK
         t93J4oLls7c+w/UE5E2QEDqBrZRRzgFueq00udVh2Mmx9PqZWwC9YQfFyyXfWYeBJdUw
         7tbO/KeTHq7Vn///uiRMhS9GEVd2KuYg3oU7zuKSF5+6Nf8qg5Yet9a+OBTXOXjdfm3v
         wzDG5Ep17GxwB7ktehiGrTsQ1ZKHPgQIXzOLnMBaiBpr4liOfS4ALav0F0TDuag1igMZ
         klLQ==
X-Gm-Message-State: AO0yUKUrdA0JvCDAr8kTW+1qHWR9Lcm1fMDNS34/9L/8uDayqiNdC+m5
        4tD6J2S9TI0lpkOTnZBW9iEYTg==
X-Google-Smtp-Source: AK7set+AcFdM6d9le1CI3Dd6bsUdFfbhO/aFAJGFgQ75r9PTW7hxXG7rLrwlr2+KSZYpusvIq6G+ag==
X-Received: by 2002:a17:903:11cf:b0:198:b5e1:74fd with SMTP id q15-20020a17090311cf00b00198b5e174fdmr1441319plh.60.1676352902751;
        Mon, 13 Feb 2023 21:35:02 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id e20-20020a170902ed9400b0019a6e9ae01csm7486826plj.21.2023.02.13.21.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 21:35:02 -0800 (PST)
Date:   Tue, 14 Feb 2023 11:05:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.3
Message-ID: <20230214053500.ziqfmb3temvetssk@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit 51be2fffd65d9f9cb427030ab0ee85d791b4437d:

  cpufreq: qcom-hw: Fix cpufreq_driver->get() for non-LMH systems (2023-02-06 09:31:38 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.3

for you to fetch changes up to ba38f3cbe7db2cec802c6d60e2bef57a3ff095a4:

  dt-bindings: opp: opp-v2-kryo-cpu: enlarge opp-supported-hw maximum (2023-02-14 10:51:58 +0530)

----------------------------------------------------------------
Cpufreq arm updates for 6.3

- Enable thermal cooling for Tegra194 (Yi-Wei Wang).

- Register module device table and add missing compatibles for
  cpufreq-qcom-hw (Nícolas F. R. A. Prado, Abel Vesa and Luca Weiss).

- Various dt binding updates for qcom-cpufreq-nvmem and opp-v2-kryo-cpu
  (Christian Marangi).

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM8550 compatible

Christian Marangi (3):
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: specify supported opp tables
      dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr bindings optional
      dt-bindings: opp: opp-v2-kryo-cpu: enlarge opp-supported-hw maximum

Luca Weiss (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing compatibles

Nícolas F. R. A. Prado (1):
      cpufreq: mediatek-hw: Register to module device table

Yi-Wei Wang (1):
      cpufreq: tegra194: Enable CPUFREQ thermal cooling

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml    |  5 +++++
 Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------
 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml        | 16 +++++++++++++---
 drivers/cpufreq/mediatek-cpufreq-hw.c                             |  1 +
 drivers/cpufreq/tegra194-cpufreq.c                                |  3 ++-
 5 files changed, 77 insertions(+), 29 deletions(-)

-- 
viresh
