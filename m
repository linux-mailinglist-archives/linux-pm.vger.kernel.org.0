Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D39241683
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 08:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgHKGxO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 02:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgHKGxN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 02:53:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3345AC06174A
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 23:53:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o1so6364563plk.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2020 23:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kVyLaU4+BT0CbBg8wXnS9t25mJ9x+rEfYROdR9As1Es=;
        b=l/MvN3zSLaDAVf/ZEMGuKIVX2W6b0GobJ7BNF386lIwvlgxAF2o6tm6X8QapJ3+Zqg
         W5gN23ay6ZI+/HTNvAhPozVVbnnJh9jMX2kab611Gb9N1Il70xK7NIXLVo2a2wv/yB3v
         YP7Cb/9cGoQsX6+3CiLXlfmITwhmg2TeDX9hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kVyLaU4+BT0CbBg8wXnS9t25mJ9x+rEfYROdR9As1Es=;
        b=kMgwfG2r9gdeBSll9VGWL+Kx3eY8/uuRriV+0/u74BRTICK5UFbKzWf6JVulC7QMhq
         Bz0D1ZhE3lMGn19zNMEVrCIiRZIX18yMCc9978SA+8Y3TEwtI8RremgEN9jHq7iNaEgS
         Qp3mrC/wdRgNVEuQUcsDIUswzVyWX3Q439enrOnQ+SVFHdhf/Zm+KQpAaP9X+/rICIzX
         8V8bn3z5EknebzPGWUN9MPssrh7PzEd7IW5x+1Udh7tJhg/+2XleDon0hRDeWgjcrBjE
         sHwvLWjjyh6EVg6LrMzMga566Ngs0q4kYY2MJnZJrpLERAgI8MH0vW4JP1r2ZPAgkB7L
         3Icw==
X-Gm-Message-State: AOAM530BsGZhC2yIRr3RavhaTjscsykMwRAqEAsa/c13Y9t63t0R4jPS
        t0MUdV9pZm0jWyI7dfyPVDNZ1g==
X-Google-Smtp-Source: ABdhPJwQHLudf/hU6n2fobVQ1fVT/hk2E3bs045RNnDZoeghFT3resIKbQ30X2QKWnezkqlPSna/vg==
X-Received: by 2002:a17:90b:384b:: with SMTP id nl11mr3214695pjb.91.1597128792275;
        Mon, 10 Aug 2020 23:53:12 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id q13sm1667351pjj.36.2020.08.10.23.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 23:53:11 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v2 0/2] power: supply: sbs-battery: fix presence check
Date:   Tue, 11 Aug 2020 14:53:07 +0800
Message-Id: <20200811065307.2094930-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When gpio detection is not supplied, presence state transitions depend
on every smbus transfer result from get_property(). This patch tries to
check battery presence again with well supported command before
state transition.

Changes:
v2: combine get_presence_and_health functions to reuse

Ikjoon Jang (2):
  power: supply: sbs-battery: combine get_presence_and_health
  power: supply: sbs-battery: don't assume i2c errors as battery
    disconnect

 drivers/power/supply/sbs-battery.c | 99 ++++++++++++++++--------------
 1 file changed, 53 insertions(+), 46 deletions(-)

-- 
2.28.0.236.gb10cc79966-goog

