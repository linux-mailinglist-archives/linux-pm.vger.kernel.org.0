Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB5C1194AD2
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 22:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgCZVoV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 17:44:21 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:35344 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZVoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 17:44:20 -0400
Received: by mail-pl1-f173.google.com with SMTP id g6so2674581plt.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 14:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WX50ftumOvzTXhIUeaIT/DsPGZdRZpJXfelwUzbVQLg=;
        b=nxGN1bW2SWOfBmr9aVFs9Yxj+cvj5P6pxIF9PnseGzPG8pIsAuQ6Y4X2SE2dJ4J2n0
         rbSZnMAy2rLxvR/b29spPUmJvH1fDT2ZCQlhyLhTWFFFxLwJKANQkIY83YjAIIVG1tkb
         Lj6lRCSMZkAElOkFIApznp6H4Prddvid0pUeTXHazGGA95HCCOjKic93qvwnzBkIC6+l
         V67gIKtvQk8A1yzl4MSL7OFUcoLAjruiOiD0vQ/ynwCdVlhxGVQTF/5Q+gn9uF3Uk23k
         OE4GOBhgFUF/PXULtj4DdyldpMd5ray4lMpOI4oph/6AH026TFclVNuLmBpmgm8k/S5S
         D3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WX50ftumOvzTXhIUeaIT/DsPGZdRZpJXfelwUzbVQLg=;
        b=C3cFkHVPIzh1HUJ2fwm+PMLL9/fQbmNbG3VTTzJ5Czk6rl34Tljopjm3Z5KXo9zTc9
         svWlXjNW9VfWxuRNEERUkILCCl+Y20bgTz/dyupULcbvdVRHVJJxJy48Q1jTFvxx2T+3
         YjWQ0TpROVzAf/aKjCdelcezhTWAfppLGrXxGGb7lrOzkHA+cp4tteC/Xyz7Navt0gIB
         xh1SX49QO5Fbh6gRDSu/9roHq1JJluY3rFqKYiMuj8sXVhxUWgbBT4SIApT7Wu84gH89
         Bq9Swj65fGxO6oxe6VaEC6sXp23n+8lVkHOdlEnqde7c8j7PcNPBOzN3LU90Tz0G+FfS
         1o4Q==
X-Gm-Message-State: ANhLgQ2DJXtSJ2be0jZU5nCipyhYGXZ/m7lqxjUHQ9T6cRkSssiOf3gs
        9F5Z2AiLZbu4RvR+n1kGpkqf5xr9Sg0=
X-Google-Smtp-Source: ADFU+vuPua3e3os/K0kEVpZai3VwlFbsqWKRiNkXLHpaCAxJRbb887vc739E8nNhdDlVK5P/rhbcGQ==
X-Received: by 2002:a17:90b:3849:: with SMTP id nl9mr2213522pjb.86.1585259059417;
        Thu, 26 Mar 2020 14:44:19 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w205sm2459173pfc.75.2020.03.26.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 14:44:18 -0700 (PDT)
Message-ID: <5e7d2232.1c69fb81.d10e.95b4@mx.google.com>
Date:   Thu, 26 Mar 2020 14:44:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-rc7-129-g8b4ddf47b7b4
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-rc7-129-g8b4ddf47b7b4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-rc7-129-g8b4ddf47b7b4)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-rc7-129-g8b4ddf47b7b4/

Tree: pm
Branch: testing
Git Describe: v5.6-rc7-129-g8b4ddf47b7b4
Git Commit: 8b4ddf47b7b4dd54539f1821c95a8dee3295fb0b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

---
For more info write to <info@kernelci.org>
