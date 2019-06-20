Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B26604C5A8
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 05:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfFTDGX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 23:06:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46715 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFTDGV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 23:06:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so741463pls.13
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 20:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3k+ZqG6fxcx9wjJdYzN51AwwDrKWOBygZ2ckfqKNWZk=;
        b=HrJpaYTfh5iJbgSLgstdGwcJAa1gk2U+dDIGKCefttcxJR2S9+gmgMD9cBuHOZBrbn
         jQAwb4Wot4lmy9hxiJmrtHn1hThMmUIg3+CT9yKxqC55sISKDNdvoJpdH2Nk/+hjuei0
         mO3S8ukJFHAYeHrMHHfeaIe0X5o+j09Hl6Lwy7p4WoAVhMnBYQIEnGTJ/Q8Osw6QYOht
         w6wIaJ+Aj/UTaDVtoxQ1m4bSQzIoihV/m31J6jWfdIt/ht7l5HPbJQXbZoAP/O6R6U1y
         uJuNgGwKZ+VRFqdRy3RUra1ywpgiK96uKYtZJoVTdp0iGj2zmx02t7H+aUmLKymZ6VUt
         eVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3k+ZqG6fxcx9wjJdYzN51AwwDrKWOBygZ2ckfqKNWZk=;
        b=a7FgTNNmXopWXAtgbtNjxJpG1x6Twb0fcDnhYMs47UMMGqxuiJaP9taRpCIgkbhe52
         6FwmskIPQjL9XMvReE4aq9LEP9HLpTdo74gsckwoJz/QzrfEsuuH13tJAwEgCIC6/znI
         7nea2epJ9RZDbaAtC7NuBIm/JnacYyULXQ9YuWT7B6yOLPubITxLRMlg9DdoIIuf1xZi
         6d3FyG5chGDIAJ+LBMbybzTSxyAhxPCBkGl2mXyYA5eaOV0JnQDCq7ONCcooe2mAtXmY
         aNFWTJmuiJxBPOmk6T5r0vCZA+S9nF8/yC2jomsshwpuB/afUYEKSuzHjTiAUDONTOV2
         xiAA==
X-Gm-Message-State: APjAAAWnvDchTRBQ/a5zXnyH7OhZKME7T3PghKrhyIr+Rdn6awCOb5Sh
        XvnrLfGcDwauh5K7n1NK+Ygs+p43oGw=
X-Google-Smtp-Source: APXvYqxA1ihvMaKN2NzXGUveqK4utf/bDtTmrRm5hK+cBzH/KHvsbQsG//5VuL8TwVOv8uDmfmCP9A==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr124316996pla.172.1560999980612;
        Wed, 19 Jun 2019 20:06:20 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id e184sm25563402pfa.169.2019.06.19.20.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 20:06:18 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/5] cpufreq: cleanups
Date:   Thu, 20 Jun 2019 08:35:45 +0530
Message-Id: <cover.1560999838.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

I accumulated these while reworking the freq-constraint series and it
would be nice if these can get in before I send the next version of
freq-constraint stuff.

These are mostly cleanups and code consolidation for better management
of code. Compile and boot tested only.

Thanks.

V1->V2:
- Merged patch 2/6 and 3/6 (now called 2/5).
- Updated commit log of 3/5 as it wasn't clear enough earlier.

Viresh Kumar (5):
  cpufreq: Remove the redundant !setpolicy check
  cpufreq: Replace few CPUFREQ_CONST_LOOPS checks with has_target()
  cpufreq: Use has_target() instead of !setpolicy
  cpufreq: Reuse cpufreq_update_current_freq() in __cpufreq_get()
  cpufreq: Avoid calling cpufreq_verify_current_freq() from
    handle_update()

 drivers/cpufreq/cpufreq.c | 115 +++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 63 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b

