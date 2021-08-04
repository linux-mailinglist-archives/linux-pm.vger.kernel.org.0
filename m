Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051583DFDC8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 11:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbhHDJSy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 05:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbhHDJSx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 05:18:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E410C0613D5
        for <linux-pm@vger.kernel.org>; Wed,  4 Aug 2021 02:18:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c16so1400047wrp.13
        for <linux-pm@vger.kernel.org>; Wed, 04 Aug 2021 02:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FU2QLdy7Hwt/eMlAilF6HLFsusjSV59ISM65hLzqQ0Y=;
        b=xbL+yZkgwgR0S//ZciTQ8AwerQ6Z5Ws27xc1cqmvwpraTNa3ARSpWWU+7+X0AjZF6q
         VMOfVksrEDGCqfmxwwVCgLgT1/XdxrO0S2Buj/TH3uLXCzBGuap7xiaofcGBUUwyAP3e
         +pvH18R+rTXpEanzqndozn6Fkh8wtYdvVxxXpZe4Q2eDbPdwu3JWF3ZBWgCSiku2yL6D
         8wgn0Wm+59i0QD3Bdigtao3x1ZpepKOypZM3oAKEeuxrDRddU+1SxNjAOa0Y4hFnsOKK
         Rhusn6aZFxLtCOsWk8KUDlIN/5hUlzIC7Fk416QdVjcQnJ30GW175G047Va9mUS/M8G5
         aYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FU2QLdy7Hwt/eMlAilF6HLFsusjSV59ISM65hLzqQ0Y=;
        b=OWn/dqMx/5LyZ7EiqSdihVrEy2g4TtBrIprj1ONhpt8IoxXZzyNPLy57CU7QQ+zsTN
         4jx7/kXpGxApAD+LcuDU8MYduJ61fUxDBKpCrcHHBpUH067kJu9QuqybCvsm2NxQgocu
         +cM56STiPTQ2mutjMJGm7lQBJtOeqt7cAaHFG6ya2uDtsXcEfKgOcEDe2c2sX9XW8FQq
         laNS66vADH1y8aPN0OimqKRSWQV2rE0nua4SrU2uWjF17zzrVpfrQoR+ECloLabncmgJ
         vn8U0qzoi1KaLhZAFkgLWaONW56ayhRZjsv/tYE38uk/gGp7XUqSGOThu3SDCRP/nCge
         P/eQ==
X-Gm-Message-State: AOAM530abBG84G7UAWf45Uqp4GQHk44TcuwSzhSaDUkFr9c34OePcg1t
        ekFgAfL9GMMXWtXAsYCE3UZ3LwwhPK1gjw==
X-Google-Smtp-Source: ABdhPJwH6I9kobrJ9XlxF0zx91RgSpqdio53O0KlhveySWeUOqvr+B2mkWj1MA7E6gsUdwfvEa4Qgg==
X-Received: by 2002:adf:ea41:: with SMTP id j1mr27803361wrn.147.1628068717861;
        Wed, 04 Aug 2021 02:18:37 -0700 (PDT)
Received: from bismarck.berto.se (p4fca2222.dip0.t-ipconnect.de. [79.202.34.34])
        by smtp.googlemail.com with ESMTPSA id f74sm1653172wmf.16.2021.08.04.02.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 02:18:37 -0700 (PDT)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 0/2] thermal: rcar_gen3_thermal: Add support for trip points
Date:   Wed,  4 Aug 2021 11:18:16 +0200
Message-Id: <20210804091818.2196806-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

This small series adds support for the .set_trips() to the
rcar_gen3_thermal driver on the platforms that supports it.

Patch 1/2 adds the actual trip point support while patch 2/2 is a drive-by fix of a
datatype found while working on this feature.

The work is based on-top of v5.14-rc1 and tested on M3-N and V3U
without any regressions or other issues.

Niklas Söderlund (2):
  thermal: rcar_gen3_thermal: Add support for hardware trip points
  thermal: rcar_gen3_thermal: Store TSC id as unsigned int

 drivers/thermal/rcar_gen3_thermal.c | 110 ++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 7 deletions(-)

-- 
2.32.0

