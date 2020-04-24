Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51531B7CE5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 19:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgDXRfo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 13:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726813AbgDXRfo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 13:35:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64DEC09B047
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 10:35:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a7so4148288pju.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxWRIcftw699pfoYLFOd9KQSRKTjcr0K+Vl6dnQqheo=;
        b=JY2iMqtpGMtjtgZykQEtdEAOcMGg1lCyq4jnUDE4mD9vNJA1Y2JpzEYFyfcSUVEsG5
         ijnl/A8LkEPgt9cfJLgpo3icFeI5iiGHYymirf7Is8Yyqd87gliA/qIZd4paqhlRRvmR
         j0WeReztxucTmwFGAPfpPhLrBW2Fm9oGlsrDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxWRIcftw699pfoYLFOd9KQSRKTjcr0K+Vl6dnQqheo=;
        b=jI+1X4yOQ0qK0/lejKvExsN/eMqYTcvGJuOpEbdOOibiuNGLrf+oPKY4uyLprY9M/g
         qm6LMmY+Y6WzXL9QpGyT7a+uAgQr2I5XxBGH+iVoYHcyGzeCjMq9867YCbm1snZZBjBm
         VW/WV/b3q9J3pbl+ITHL2wJT2NnqSMHR8sk4TWnEeHV2r6we8+nZS3NBH8hivrpzPp2e
         3YWWSJ/JPxXCzw4SLPuqfiYq6ij+kFlhj0OieV0PIf0Wrti9ajvOGYYM8efVj8RxAA4I
         Z3BddOlvhDgmnG2ElrX2e++SqiD7h4UHOK2pRiceP+Kyd1UHiPZh63kSWrL45DITpqgh
         RJ/g==
X-Gm-Message-State: AGi0PubJAJAusVV6NrUoTv27STw5sp6IgjL+msv2HopEajvjKw1psZi9
        iFPg4UfIuz6TI805W9bDwqF2gA==
X-Google-Smtp-Source: APiQypJMZOjRtHulZ8Xf5jyjfh/qnsTS0b0q2JkqxsbT03TOoqfMbNtlgM4QwLwPe+adi1iZlf7u3A==
X-Received: by 2002:a17:90a:9b82:: with SMTP id g2mr7560800pjp.72.1587749743448;
        Fri, 24 Apr 2020 10:35:43 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id t188sm5360641pgc.3.2020.04.24.10.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:35:42 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 0/4] Cleanup power_supply_sysfs.c
Date:   Fri, 24 Apr 2020 11:35:29 -0600
Message-Id: <20200424173533.48572-1-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A few various patches to cleanup the power_supply sysfs implementation.

Mathew King (4):
  power_supply: Cleanup power supply sysfs attribute list
  power_supply: Use designated initializer for property text arrays
  power_supply: Add a macro that maps enum properties to text values
  power_supply: Add power supply type property to uevent env

 drivers/power/supply/power_supply.h       |   7 +-
 drivers/power/supply/power_supply_core.c  |   9 +-
 drivers/power/supply/power_supply_sysfs.c | 507 +++++++++++++---------
 3 files changed, 305 insertions(+), 218 deletions(-)

-- 
2.26.2.303.gf8c07b1a785-goog

