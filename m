Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3310F600BDD
	for <lists+linux-pm@lfdr.de>; Mon, 17 Oct 2022 12:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiJQKDM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Oct 2022 06:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiJQKDK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2022 06:03:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988965E65A
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2022 03:03:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so13792603pjs.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2022 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t6FpKHf/Wd0EiGD1gOCuFVMrfmWYNpZZOBzaEWmZchk=;
        b=gjuYvuVRHhM6dAnE3sI+rzyGXmHCOcFrTYxmShW7gKpVeiJkJL6Xejto2c+rTRZPqW
         /F9xrXNUQ8iCfeuDuMS9NbvoSAKTVj3UZ//wtHDb9xvKN7Usd0KvVI65Tan+a6kZ5sJO
         clOugk3AzHgWCOwYA5AOFqhuNX/S6+FLzclXB7U6FfTOyIODz10g0hVTd3ZwOgVxqqG9
         pC4At49gttg9NGNksRB6RwYnxRdkNflvQeqZZYTTWIvRPB5hYjNavYrshJy7VV9QtIic
         3veoDEFsSzYbOm/gs98tdUipdE4PCJ+UXHVv9pmcYRNhO2lYqUbhjfU1xmc9aZGzuwp0
         H1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6FpKHf/Wd0EiGD1gOCuFVMrfmWYNpZZOBzaEWmZchk=;
        b=KxAPwKhKKlZIvza8hAJr3NKdp46sGwAJguYvQxgAqYgwTEA8F8kZGwMQYL2QF1e9C6
         m2CVWYMhz7RYfTzAll6+N2KZtB85qI+oxvmMjpUHoLPPW8KLeKDhvcap8lR+1PxYhBPY
         A5Pq1SFHlTS/BAYPGrqyHbdsY3a/oicbHCnVjyELRNoWi1ozMVXmtlDYQO9F/4mklC75
         PqxhkfQMgAMvXgmLcT6x1xJJS3GEseTsAREVz1Cq5459pRDgpWbq+JAC0MykMynxGqq1
         RY0EmNc/UhbWVXHmo3dZcQmMmsSfLd4eUgPioRnOV+QBTQ/EkmVuNLiXZALJSBNrwtVB
         MX9g==
X-Gm-Message-State: ACrzQf1tuC0CJoWgG+jli7YUdbCtcNxqXqG+lL7bxgwcIKNDe97wIMIX
        7GIHDTFK+oLLeQzhdQKj1ClG0Q==
X-Google-Smtp-Source: AMsMyM5sk6prcx6Qs5VQWdAGPPNwi6GtlgbpQmmLALZUXDBKkZMeMi/HMHoTHyijNvltzL9fueeogA==
X-Received: by 2002:a17:90b:4fc3:b0:20c:dbba:e614 with SMTP id qa3-20020a17090b4fc300b0020cdbbae614mr32716405pjb.163.1666000988996;
        Mon, 17 Oct 2022 03:03:08 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709027b8300b0016c5306917fsm6241221pll.53.2022.10.17.03.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 03:03:08 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] thermal: Validate new state in cur_state_store()
Date:   Mon, 17 Oct 2022 15:33:00 +0530
Message-Id: <cover.1666000867.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In cur_state_store(), the new state of the cooling device is received
from user-space and is not validated by the thermal core but the same is
left for the individual drivers to take care of. Apart from duplicating
the code it leaves possibility for introducing bugs where a driver may
not do it right.

Lets make the thermal core check the new state itself and store the max
value in the cooling device structure.

Once this is merged, I will update the thermal drivers to stop checking
for the same.

Based of v6.1-rc1.

Viresh Kumar (2):
  thermal: Validate new state in cur_state_store()
  thermal: sysfs: Reuse cdev->max_state

 drivers/thermal/gov_fair_share.c |  6 +-----
 drivers/thermal/thermal_core.c   | 15 ++++++-------
 drivers/thermal/thermal_sysfs.c  | 37 +++++++++++++-------------------
 include/linux/thermal.h          |  1 +
 4 files changed, 24 insertions(+), 35 deletions(-)

-- 
2.31.1.272.g89b43f80a514

