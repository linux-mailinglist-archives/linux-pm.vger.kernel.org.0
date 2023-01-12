Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9304B667229
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jan 2023 13:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjALM1b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Jan 2023 07:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjALM13 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2023 07:27:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983F0BF78
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2023 04:27:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id az7so17921040wrb.5
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2023 04:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4xQw8oRzEZf6j1JjjiSzT91wT9Ia+zmbBNMEAe4Rho=;
        b=Y8QkTUOrsDhczrnsucN0ok8RvJU3RKsxPN3Scx93YpjzCZFGuFhR3HVYZXDCTICozq
         Il/uHl3DSp/1sZV5n3lstFc2DzrvuW4mEMiKk+uTKYvv0qGLn+vJ0LS/zgbe2AGW8o5M
         GK7ewtehINNfFhwDmlIbpB3m80TpQuCmz2JWjV0EoBE0XR26cq1bkFUr1wmkmTi1DMJ+
         xdzr5uQ3sFDzy1EivMdC7kGlAlPwQ5aTZc2k1rp0VKPdCc9q5tzTofBklJKgQ1C/AgfV
         n2+yoYBvKfGcPPNpur32VBAjdr0yqoP9WoNYdv+076bZ0L5BIcgrljFi4BxeBUynKGYZ
         HTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4xQw8oRzEZf6j1JjjiSzT91wT9Ia+zmbBNMEAe4Rho=;
        b=gpDHiCJVf8jWfmHSuU4tsHl3rrCrXzziVWLpnZVUWmGK5E6pnKm4/F1UFn/BwvXUmF
         dro/FWicAZVuFyUmLgKbjmGZgz/RKbSfcDptN4A247503jvnRqO3K4Q6ob2OMh6YcN4x
         /vWVRIAWwQhz77NyghnWXZhN35jMz4o3jyL+yTIj2tH3iWxh5+4qK0bvxRhZfBWU2JzX
         1aNkL/YGtNrYOyrye4fWUJotbYaKPnkePxtlxmPqkjIEMm8QUgXa5De4WSd//b2J2+ez
         dfIoQnSd0w3/1fz1OsK7wIAGgB6HAK41IcevmkPuj0aeqtKk/6wWvaev7Oc5Th+edeq+
         o/XQ==
X-Gm-Message-State: AFqh2kqdOdZSW9Rg7uWUmZi9Yb7kukZwMisYmVMG106hToOOgUYrN3Eb
        fyH3cYZZrtWUWeUyLaB993SEwQ==
X-Google-Smtp-Source: AMrXdXs+bSeX89Po94TSwdL81EnOCsC12PGKuloj4OtbBiXcUmLflMf/yuoxXlvGLDh55lylJ0HGfw==
X-Received: by 2002:a05:6000:1a41:b0:24b:b74d:8012 with SMTP id t1-20020a0560001a4100b0024bb74d8012mr45902907wry.18.1673526446099;
        Thu, 12 Jan 2023 04:27:26 -0800 (PST)
Received: from airbuntu.lon.corp.google.com ([104.132.45.104])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b003d04e4ed873sm30132354wmq.22.2023.01.12.04.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:27:25 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v3 0/2] Fixes for uclamp and capacity inversion detection
Date:   Thu, 12 Jan 2023 12:27:06 +0000
Message-Id: <20230112122708.330667-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Patch 1 addresses a smatch warning reported by Dan Carpenter.

Patch 2 fixes a couple of issues reported by Dietmar in capacity inversion
logic.

Patch 3 which was an RFC patch was dropped. The discussion has settled into
this patch which is now treated separately from this series

	https://lore.kernel.org/lkml/20221228165415.3436-1-vincent.guittot@linaro.org/


Changes in v3:

	* Fix commit message in patch 2.
	* Drop Patch 3

Changes in v2:

	* Patch1: Improve indentation as suggested by Dietmar
	* Patch2: Make sure to hold rcu_read_lock() as we need it's not
	  held in all paths.


LINK v1:
	* https://lore.kernel.org/lkml/20221127141742.1644023-1-qyousef@layalina.io/

LINK v2:
	Sent in-reply-to v1

	* https://lore.kernel.org/lkml/20221208145108.452032-1-qyousef@layalina.io/
	* https://lore.kernel.org/lkml/20221208145409.453308-1-qyousef@layalina.io/

Qais Yousef (2):
  sched/uclamp: Fix a uninitialized variable warnings
  sched/fair: Fixes for capacity inversion detection

 kernel/sched/fair.c | 48 +++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

-- 
2.25.1

