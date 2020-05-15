Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A721D4776
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 09:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgEOH5d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 03:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726671AbgEOH5b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 03:57:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABD1C061A0C
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 00:57:30 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q16so613139plr.2
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZyzW1H8AFFYElgNpg92Xk3JWxRZpBy2j9yutlr0YjsE=;
        b=HWM2/1Du2WgTucuJQpwh98ZrRlroWxqg15O5s2SpAAGHKSWILrVa0LrWXciiMeLDbm
         dHKCyvUnu7aEVyi+PSvgBB3lT1L6ms806WxRI7BvHHoUTTqEndaAEdj5b/pkalA1MJ0U
         66B/Po2dzZDRD7fRfnOF9jpHeXir0aWwiZovv6OWW+mJkIM6QZCNX+c1pMXkijbrPk7i
         H5CMH9GcPO60vokgnukC1QNN4vDyKQkijVYmiNpzz5njzwKIuYr+oJaislpmOdPVmCDO
         zQNyXOlV0jO5KigMzAtxOTk54UKJYTSGP9V8OIS6p6J3lhZRHOdCQ9xfvq76FHB7CKJj
         /geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZyzW1H8AFFYElgNpg92Xk3JWxRZpBy2j9yutlr0YjsE=;
        b=FPCfChlSLHxilFa6t4QDEwkw9Adendv3YUWC8zyIgVJgFShXUn3HqBw5R/z4s9vfpc
         uTeVZRfdh0tWtxDByY7kzTNyew4fliMEZUQH7MaExGm7oh480pYzOFXGNV1mjLsjBiTw
         ipaeD2NCBBYc2VZ4KM8eyQovEeHQZ4zPO6p+FBEQPK1kQHdGVt899AzHoaXXQlBfkrVm
         dV/Fv7U8EftR8CVTk2CSCW/zmZLLVR0jKhZc3W5BpLDKrdJqVGj1SgXqxoLa/bHshGXp
         8p1q8bj5PnfXG3IOUI1l5czyp4Sr9IG3tWkzah0AMJxravoyLXFCI3rxPwfqLs5HZgkv
         1dfg==
X-Gm-Message-State: AOAM532EvaoT8vi1diq2QSllWm14iG5x1JIzv6g2pGQvW9Tge8Sjyx/w
        PqvvAuDHl4VqCnZ3X0sKoJFCPw==
X-Google-Smtp-Source: ABdhPJyoEn77D99k5JFEmPox0/Sh0OVxYkzLK8U5vnIaAotAEhqOhnvr845CAGGuRKRTrA/vUU8D8A==
X-Received: by 2002:a17:90b:3790:: with SMTP id mz16mr2056475pjb.179.1589529449691;
        Fri, 15 May 2020 00:57:29 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id 140sm1218633pfw.96.2020.05.15.00.57.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 00:57:28 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     k.konieczny@samsung.com, peron.clem@gmail.com,
        m.szyprowski@samsung.com, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] opp: core: add regulators enable and disable
Date:   Fri, 15 May 2020 13:27:19 +0530
Message-Id: <cover.1589528491.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series reintroduces the usage of regulator_enable/disable() to the
OPP core after the previous attempt was reverted [1] shortly after getting
applied. This time the regulator is enabled only after it is configured
by the OPP core.

Marek, Kamil and Clément: Can you guys please test this out and report
if this doesn't work as expected ?

--
viresh

[1] https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsung.com/

Kamil Konieczny (1):
  opp: core: add regulators enable and disable

Viresh Kumar (1):
  opp: Reorder the code for !target_freq case

 drivers/opp/core.c | 39 ++++++++++++++++++++++++++++++++++-----
 drivers/opp/opp.h  |  2 ++
 2 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

