Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AE668685E
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 15:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjBAOgh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 09:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjBAOge (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 09:36:34 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B33747087
        for <linux-pm@vger.kernel.org>; Wed,  1 Feb 2023 06:36:33 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso2653091wmb.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 06:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2rSmBPzQrDoBjd8Nbsk6laUgitreMtiRkhjm5eNehvE=;
        b=DnCHxdGpawCKZ3jBLuNxGM3UAXoWfJbI+kW7byixEKjpGbg8/FfcaZWGkUwB1YvyJw
         julqkx9kH43DsFAFNiCK1F/S6+IeiOp2NSA1hX79vK+tjAcii5Iivo4oPLYmCleOqIO6
         +8h7vKURPut4PM1H9/k4M9yIq21aiDkshi6jPBdb74XjKLIL6iw9Mc+SoR7b+rBrcHv7
         rjDsvPoHge7hA2RNbYOQq/n31DylXao3NpXrAmcmlm6YpVizybDeYIbj2pC4KSG/VZfx
         PLlH20nVun/DgjhRyWE1cLhrGJBrm5VInwvpEjHo8RgLg85p4Zc4QvlqAeZX6RDz7yyA
         HWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rSmBPzQrDoBjd8Nbsk6laUgitreMtiRkhjm5eNehvE=;
        b=Duj0SkCzB3dpPIh4pj3S9qN7fqceTF5XxxyhheGMI9mE0H6M0925MY1dVhGLLCG3BJ
         19bXS1DAzUt7gut1Bm1X3ESM99RSLofWK+/RlCtP4reFYXsqdeKNt0SV4MsrLFj0fkjI
         WQ9gQuR7XGxG0UNWuk5Ue5GoXu4ByGkqoe+CMNA+i2jH5vfnN/QCPJFZ/a+s+AOVaGXO
         SWj6ZAki2hjJ/vcaOBD5Qa1P6noGuLgrt5pj2l7CLO7dTOTJ3EzE0PbeSKM34qSMj/7w
         IPvOy39eDdeppzGBH1tiBrC1Ei3P863WTAbf6HG5ke40DT8FiUdErSRHvem8/RURvwv+
         TuvA==
X-Gm-Message-State: AO0yUKXd+RBEI86+Jy845TtBfCEoqHuLfQO7E0c8C4x6OC+0rveX+XNV
        c6poQ54yg089b03wwL1MNU2mlw==
X-Google-Smtp-Source: AK7set+4m+JTYZPO8dwzkbFOUxFXvOjmnO+/3Nyc4A6jC3lM0JB91hISYgLN6y9YC9/1qqeU24eEvg==
X-Received: by 2002:a05:600c:2207:b0:3dd:638d:bc31 with SMTP id z7-20020a05600c220700b003dd638dbc31mr2519067wml.26.1675262192152;
        Wed, 01 Feb 2023 06:36:32 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:3db4:bf23:5fd8:a5])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003cf71b1f66csm1846756wmc.0.2023.02.01.06.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:36:31 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kajetan.puchalski@arm.com
Cc:     lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/2 v5] unlink misfit task from cpu overutilized 
Date:   Wed,  1 Feb 2023 15:36:26 +0100
Message-Id: <20230201143628.270912-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

unlink misfit task detection from cpu overutilized and use the new -1 value
returned by util_fits_cpu() to extend the search for the best CPU.
Remove capacity inversion detection that is covered by these changes.

Changes since v4:
- Added patch 2 to remove capacity inversion detection

Vincent Guittot (2):
  sched/fair: unlink misfit task from cpu overutilized
  sched/fair: Remove capacity inversion detection

 kernel/sched/fair.c  | 189 ++++++++++++++++++++-----------------------
 kernel/sched/sched.h |  19 -----
 2 files changed, 87 insertions(+), 121 deletions(-)

-- 
2.34.1

