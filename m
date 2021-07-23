Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4428F3D4043
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jul 2021 20:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhGWRr6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jul 2021 13:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGWRr6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jul 2021 13:47:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA22C061575;
        Fri, 23 Jul 2021 11:28:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l4so3318958wrs.4;
        Fri, 23 Jul 2021 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KpyA1TnBrUntqw/SDmyoOo3Qud+7hXORa6MtI7AfCIk=;
        b=SuafVSjdnc5jaGZ9OJK0cNqyraTPQWIF0XL0PTwDt9aZaJjP7A26+UJN6vZc01j2pm
         O3rYneVlGs+8NvOec1LL+bpyixK2Lu2jI/0o6sAUJi1mGO5akdFstwsqo9FsyVO2sByI
         8kKOi3ZrLM4vlu7IAMv0EBPD+h6YHmz9IhtpFr6JqHRcoXjp6YsUdSJCO2H5wOr41PWk
         3zEs4Y95w/b4ggE7tj6PBJ/kfQfXyZsR1x7nJ5a66kaYFhpsMUpR9iCSWYrbJyjJg3E2
         qhsbhhi0CwrRPKiTG9OEdm9qOZQRJ6+xptHFVamdGH7nCjDmwB+O2/NJWbuKNFORxutr
         OHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KpyA1TnBrUntqw/SDmyoOo3Qud+7hXORa6MtI7AfCIk=;
        b=GHwGzMSOcfCJncK3aMa+3L7vcJwgu3rqmuftAJ/Pleu/LWja1+CAKbPaZsHmPqRqOp
         7iUAgI++6XsbHAtqxhj2L7Ey7dHgIWr1y/OOi6CMJcRPPgr6yM91cU1vGCRaZWfPzRHV
         mk69iKkxYKnPv2koEC+un8uhDkJU0F6Dk/7tbAvl/sIJgbhfx4Lb2/wokvNWifs34DJn
         5Lrpi52cjwA34hWn1LPIKr2qiO2oeLF8+/hiPgS+lHip6HiNOM6Qn2+3s/PcQ4weCKed
         iMySZDILDbdV8JDo5S0jlq7ap5EkckI8qeHSQanUQI0jy7saQmem5P7XjSk5nbxZtuaq
         pNWg==
X-Gm-Message-State: AOAM531E+qUGnTTJLw0inV29Qir2qlTKy1rXRjtiBIcrLAulGqWMdp/L
        4Tr48cKEBOe7FGggVbrFzXC0BBgfvmi+Rw==
X-Google-Smtp-Source: ABdhPJyC3RcdGX3UlpEucnTB1XO50iNyIcEdGGzqeoxJEIYNc83Z2ItHLBeTU7d3OLa9kSqYA0gP9Q==
X-Received: by 2002:a5d:4cce:: with SMTP id c14mr6669929wrt.258.1627064908905;
        Fri, 23 Jul 2021 11:28:28 -0700 (PDT)
Received: from lb01399.fkb.profitbricks.net (p200300ca572b5e05c4ffd69035d3b735.dip0.t-ipconnect.de. [2003:ca:572b:5e05:c4ff:d690:35d3:b735])
        by smtp.gmail.com with ESMTPSA id c2sm33626146wrn.28.2021.07.23.11.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 11:28:28 -0700 (PDT)
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        pankaj.gupta.linux@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pankaj Gupta <pankaj.gupta@ionos.com>
Subject: [PATCH] cpuidle: set poll_limit_ns out of if-else
Date:   Fri, 23 Jul 2021 20:27:59 +0200
Message-Id: <20210723182759.74491-1-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Pankaj Gupta <pankaj.gupta@ionos.com>

 Since poll_limit_ns is being set at the end of both if and else statement.
 Moving and setting it out at one place.

Signed-off-by: Pankaj Gupta <pankaj.gupta@ionos.com>
---
 drivers/cpuidle/governors/haltpoll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
index cb2a96eafc02..7d0e95bc94f3 100644
--- a/drivers/cpuidle/governors/haltpoll.c
+++ b/drivers/cpuidle/governors/haltpoll.c
@@ -90,7 +90,6 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
 		if (val > guest_halt_poll_ns)
 			val = guest_halt_poll_ns;
 
-		dev->poll_limit_ns = val;
 	} else if (block_ns > guest_halt_poll_ns &&
 		   guest_halt_poll_allow_shrink) {
 		unsigned int shrink = guest_halt_poll_shrink;
@@ -100,8 +99,9 @@ static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
 			val = 0;
 		else
 			val /= shrink;
-		dev->poll_limit_ns = val;
 	}
+
+	dev->poll_limit_ns = val;
 }
 
 /**
-- 
2.25.1

