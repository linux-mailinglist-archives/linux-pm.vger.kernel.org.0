Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CC975C330
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jul 2023 11:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGUJlN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jul 2023 05:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGUJlL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2023 05:41:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4562D46
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 02:41:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8ad356fe4so11666905ad.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689932470; x=1690537270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfVjb+XTXQMZBJMVJn4MrXS6wRwbcO0K1EZZjr+U+hw=;
        b=Yl2LgVrUYyludPDYyQwOZ8HvgZpfli3mRz9cabR+eZEGSXEP9ppuStt5XbHMbXa1Cw
         n01cO9TxURDYRcRRoxHId+EhzEckok9HaHl0/AfSlG5opj+hCiQ6VeUibAw2rJMXd+gD
         aKBFR8hxXqjB/vAY5KcH4IK89XrEJcxyTojPC2cERxuXDP96tKFsmHjd9i+HslJrVvQM
         Au/Ot68Qw+1m3vSGJdczQUrC2vwCbKYeXXT6s3pwh4oOPxbCGLK6qdY5NJ6HH8tLHkhj
         zZ2ZraEIig7jP/8ypK+wsBCLQYyhktJw4v00kOXx4eN3tAeUF1iyuevds1x3QYIUbcdt
         95iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689932470; x=1690537270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfVjb+XTXQMZBJMVJn4MrXS6wRwbcO0K1EZZjr+U+hw=;
        b=GjNIHq3pfNlAe/dtzVIAkM4v1lQs0ZBNAn06Xbi9t3WTOjVM5EjUGwszhUrtDtNtpp
         LFNhiogG0bbPDNFell0nTiJznRj7fXhOpwBCNe1pL+vv0iFg1CWGvz1KOMffiAOsygYw
         zkkifW9reZViv5Prdzh7e1Aq4fPzkIaMJ86cHdVyERSlKrsRQCIfPdYj6POGa/Y87XtN
         d441O4+CvdM/Z4/UCXsnphlWWoRYTP7HXuIIy+REhsfff8U5HOG8gPULaQEqJ/lmbYQX
         3nVoSFirQRSjiEb5c7yJfvkSSYbJLYdqX54qTq/GPX4KOfRc7ONoMq3uFgMAoBWstoN7
         aqvA==
X-Gm-Message-State: ABy/qLY/aaEUDLzq3C9d2n9eFmyulULTpy3B/oHhyIw/7maOJc/+9Sgq
        ZFhhqBF6wC5H8gkuHhut/tLS/Q==
X-Google-Smtp-Source: APBJJlEVcLQFoRpP2ZdOULBfard9br9JYX0AOcHyewsuorbPDYMKqlgGhJOqVozxBZZ5zkEZf50cFQ==
X-Received: by 2002:a17:902:9f88:b0:1b9:e1d6:7c30 with SMTP id g8-20020a1709029f8800b001b9e1d67c30mr1030899plq.39.1689932469892;
        Fri, 21 Jul 2023 02:41:09 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id jg5-20020a17090326c500b001b9fdeead86sm2988654plb.68.2023.07.21.02.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:41:09 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] OPP: Indexed searching based on frequency
Date:   Fri, 21 Jul 2023 15:10:53 +0530
Message-Id: <cover.1689932341.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series adds support for indexed versions OPP finding helpers.
Some of these are picked from the series posted by Manivannan.

--
Viresh

Manivannan Sadhasivam (2):
  OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
  OPP: Introduce dev_pm_opp_get_freq_indexed() API

Viresh Kumar (4):
  OPP: Rearrange entries in pm_opp.h
  OPP: Add dev_pm_opp_find_freq_exact_indexed()
  OPP: Update _read_freq() to return the correct frequency
  OPP: Reuse dev_pm_opp_get_freq_indexed()

 drivers/opp/core.c     | 109 ++++++++++++++++++++++++++++++++++++-----
 include/linux/pm_opp.h |  62 ++++++++++++++++++-----
 2 files changed, 146 insertions(+), 25 deletions(-)

-- 
2.31.1.272.g89b43f80a514

