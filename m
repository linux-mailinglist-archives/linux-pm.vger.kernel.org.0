Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295BC2A4929
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 16:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgKCPNw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 10:13:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgKCPMC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 10:12:02 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27EB8206DB;
        Tue,  3 Nov 2020 15:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604416322;
        bh=As5BcWw5h10I2lEv/HK9gzXmhyPt7zitVkuTgyN9i1k=;
        h=From:To:Cc:Subject:Date:From;
        b=NHTUy2F5RmIFRJAPsLrgNeoRooPAVmOmiKsjSXBINRfh1wK46g/77GYxQtL8yypC6
         cmnqtvakV4FhbDhxds2Kpbkwi0uVOJ1CRNmAVeMhsxHqaGtaePLdffgeeeOdElCZy8
         TfDYDVK8RgZS1O116qZsdjc7mZoUletk2wvbgaro=
Received: by pali.im (Postfix)
        id B37FA7E5; Tue,  3 Nov 2020 16:11:59 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] cpufreq: Add missing modalias for tristate drivers
Date:   Tue,  3 Nov 2020 16:11:30 +0100
Message-Id: <20201103151139.29690-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some of cpufreq drivers are tristate, can be compiled as modules, but do
not have defined modalias for automatic loading. This patch series add
for all those cpufreq drivers missing MODULE_DEVICE_TABLE macro, based
on OF definitions, or MODULE_ALIAS for platform drivers.

MODULE_DEVICE_TABLE is not explictily added only for speedstep-centrino,
speedstep-ich and speedstep-smi drivers as it was removed in commit
b11d77fa300d9 ("cpufreq: Convert to new X86 CPU match macros").

Pali Rohár (9):
  cpufreq: ap806: Add missing MODULE_DEVICE_TABLE
  cpufreq: highbank: Add missing MODULE_DEVICE_TABLE
  cpufreq: mediatek: Add missing MODULE_DEVICE_TABLE
  cpufreq: qcom: Add missing MODULE_DEVICE_TABLE
  cpufreq: st: Add missing MODULE_DEVICE_TABLE
  cpufreq: sun50i: Add missing MODULE_DEVICE_TABLE
  cpufreq: loongson1: Add missing MODULE_ALIAS
  cpufreq: scpi: Add missing MODULE_ALIAS
  cpufreq: vexpress-spc: Add missing MODULE_ALIAS

 drivers/cpufreq/armada-8k-cpufreq.c    | 6 ++++++
 drivers/cpufreq/highbank-cpufreq.c     | 7 +++++++
 drivers/cpufreq/loongson1-cpufreq.c    | 1 +
 drivers/cpufreq/mediatek-cpufreq.c     | 1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c   | 1 +
 drivers/cpufreq/scpi-cpufreq.c         | 1 +
 drivers/cpufreq/sti-cpufreq.c          | 7 +++++++
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
 drivers/cpufreq/vexpress-spc-cpufreq.c | 1 +
 9 files changed, 26 insertions(+)

-- 
2.20.1

