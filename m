Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1ED7DEC74
	for <lists+linux-pm@lfdr.de>; Thu,  2 Nov 2023 06:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjKBFrw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Nov 2023 01:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346332AbjKBFp7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Nov 2023 01:45:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DF5116
        for <linux-pm@vger.kernel.org>; Wed,  1 Nov 2023 22:45:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-280260db156so579825a91.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Nov 2023 22:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698903953; x=1699508753; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzrhZXo+dGDa3AqsNy7Vgj6MpkiaO6zQpmKf2ZstGE8=;
        b=i3sYaFjVPw6nxGK9AjgMg84FPLo/1W/BnhDpSq/j8wj9DX2owAo+n33nJO8gMrT1fT
         RcmOhZe4ab04wzeB8NJZ7ngL0TS1xdWFFnyM8iUvOdY9XMe9f5H9Z0K5Gg4Mqp/4xcsw
         NWloP0yPpQSAncTLjT86JnIo0k7QomDpPy3TKIC/nIuvm4mELvv1eDv8dxxH4v3WEhak
         pw8WXPPpPPTMkgdg/ubR4Y/8W9ENab+/8Acu6PdH0ZDXwwi5LKNPNlnQQYTnrE5Csy2l
         sZQ+xOWYOTT3WdCiTGSTtsytPv87RdlYMXR8A650VfhKokN0SR/2ks/IkGFW8Wl3aXUt
         sLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698903953; x=1699508753;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzrhZXo+dGDa3AqsNy7Vgj6MpkiaO6zQpmKf2ZstGE8=;
        b=SLNBmzVXNd06SATrAjISnOfHMXjXPrTW9YBdamWnr38rZNiOFIExzO91UUkwBYwgK1
         M2Lk007BYwQjCTnKjuUUTJeZG6l6My2u6/5EgzQvCZUlc39MbaF0Qd9TzKOcWhYsebyd
         bqau7kM1U0QNYX15lraBbg1pppCFeYqeur1kDcozhbC7b853Rq1smxi+StBSSPYTpDl6
         b8mYfxiQFhaCbrYf8Elpf8CeEfzdUk6vR1SvigkyAaE3K3Jh2B/Te43J6vdqHXIqPjDn
         0TYk+894Nk5FI8PYYXUylXIwENcU4yt+q7s0d8j6RApM2rBQBGLbpF7wD+9EtCVubv3Z
         /Eug==
X-Gm-Message-State: AOJu0YwPtDTZHO6uBHNWdeKZ08H1DiW6oo5P14/87KfY4fZxpgfjhVr/
        W/cte3okDnIg9CbKE4mxM+x5vA==
X-Google-Smtp-Source: AGHT+IEPgw24FpLWuRgkEYbzkkE3f3S+pHxPyeik0vL+BYe7aur6FmN4y2lRlfWUQuB5rJ4Kp1fOnA==
X-Received: by 2002:a17:90b:3449:b0:27d:6404:bffc with SMTP id lj9-20020a17090b344900b0027d6404bffcmr17526493pjb.1.1698903953531;
        Wed, 01 Nov 2023 22:45:53 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id gm19-20020a17090b101300b00280070a2613sm1658809pjb.51.2023.11.01.22.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 22:45:53 -0700 (PDT)
Date:   Thu, 2 Nov 2023 11:15:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.7-part2
Message-ID: <20231102054551.rah3brlwv7457kzl@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

I was waiting for some dependency patches from ARM SoC to land in for this.

The following changes since commit 038ef0d990a0a5fbc2024084f51e8af7d9bc95a2:

  dt-bindings: cpufreq: qcom-hw: document SM8650 CPUFREQ Hardware (2023-10-25 15:51:22 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.7-part2

for you to fetch changes up to 5b5b5806f22390808b8e8fa180fe35b003a4a74d:

  cpufreq: qcom-nvmem: Introduce cpufreq for ipq95xx (2023-11-02 11:04:53 +0530)

----------------------------------------------------------------
ARM cpufreq updates for 6.7

- Add support for several Qualcomm SoC versions (Robert Marko and
  Varadarajan Narayanan).

----------------------------------------------------------------
Robert Marko (1):
      cpufreq: qcom-nvmem: add support for IPQ8074

Varadarajan Narayanan (2):
      cpufreq: qcom-nvmem: Enable cpufreq for ipq53xx
      cpufreq: qcom-nvmem: Introduce cpufreq for ipq95xx

Viresh Kumar (1):
      Merge branch 'cpufreq/arm/qcom-nvmem' into HEAD

 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml |   2 +
 MAINTAINERS                                                  |  12 ++
 drivers/cpufreq/cpufreq-dt-platdev.c                         |   3 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c                         |  60 ++++++++++
 drivers/firmware/Kconfig                                     |  32 ++++++
 drivers/firmware/Makefile                                    |   2 +
 drivers/firmware/qcom_qseecom.c                              | 120 ++++++++++++++++++++
 drivers/firmware/qcom_qseecom_uefisecapp.c                   | 871 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/qcom_scm.c                                  | 394 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/socinfo.c                                   |  11 ++
 drivers/soc/qcom/wcnss_ctrl.c                                |   1 -
 include/dt-bindings/arm/qcom,ids.h                           |   5 +
 include/linux/firmware/qcom/qcom_qseecom.h                   |  46 ++++++++
 include/linux/firmware/qcom/qcom_scm.h                       |  22 ++++
 include/linux/ucs2_string.h                                  |   1 +
 lib/ucs2_string.c                                            |  52 +++++++++
 16 files changed, 1633 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/qcom_qseecom.c
 create mode 100644 drivers/firmware/qcom_qseecom_uefisecapp.c
 create mode 100644 include/linux/firmware/qcom/qcom_qseecom.h

-- 
viresh
