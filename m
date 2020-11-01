Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A08F2A1E7B
	for <lists+linux-pm@lfdr.de>; Sun,  1 Nov 2020 15:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgKAOLl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 09:11:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbgKAOLk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 09:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604239899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=sIyk7Z/4NPATT4L/LX2Y5gpqyse3pPUcPApM/XM/zvo=;
        b=hG5eNLKiF7V2F1ZH/6RjVflPRANoLk9pC3gF7+rVZvzyWuYCv5C+ENPpCBCo7yy9Q6ygfB
        nW2kWhrXxC3iWDYNhVwJwlfm8VOfbhOuAuoh0O9BLRb3V/UH4dHPJlng+OktWkEYS733eB
        6gdoCWYP+TSqiHNtuDoscGR38BHwJH4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-6cW7f7_xNyGw8QNC8EvWNQ-1; Sun, 01 Nov 2020 09:11:35 -0500
X-MC-Unique: 6cW7f7_xNyGw8QNC8EvWNQ-1
Received: by mail-oo1-f69.google.com with SMTP id t9so4522422oon.9
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2020 06:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sIyk7Z/4NPATT4L/LX2Y5gpqyse3pPUcPApM/XM/zvo=;
        b=aMx+nrruwc7kg7OBfUhRPKiBQMZ7KTQYL5IFKXgTXqNizxqS0P+6UWBQzQVXvyLD7u
         S98ipvcTn4/46rLfEmgAvXQgU396PmBcwfI/MYyaSfFYB99CqeLbehG+IKjTz3f1FrBY
         kK2q70GGJOeyNJRytOIsZXog7Pe6Ek2KFtY6LPXlJoSguTIyPXvdK8iH1JlxGSUL+5Ti
         UZeeJri071Lg6KG+mp1xjyGzNNkoNqQByXH+/WcwY73j7Fdqfs6SmllsSMkU6051V1Uo
         TI9D5OCK1GEkp85sHaOxRwH8LnWSVVS4w+vRrdlGpMw6BaneXsrblvJmrvbH5SwaTajp
         DfQw==
X-Gm-Message-State: AOAM532MYqxw2XraHKHOzW5dATVSdy6UlQ9CAVySe2GYZdCSPPjUtFYd
        IJLnygbZwnjL8WlUFuZj/aDkrY8buuyYyRQe2K26Go/QKPtYKdiIp6sFzd5ScLVwybxicRQhjye
        n4mFLBkr1CXR11N1rV3c=
X-Received: by 2002:a9d:7505:: with SMTP id r5mr2592994otk.64.1604239894540;
        Sun, 01 Nov 2020 06:11:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUSjuZ0Qnvh2QaYVQYJ/+PNtONAzdv5wxwEbdXjZqg59Rvus/EwGHHO9o2uBHFGMtvGnwmEw==
X-Received: by 2002:a9d:7505:: with SMTP id r5mr2592986otk.64.1604239894382;
        Sun, 01 Nov 2020 06:11:34 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s20sm2844146oof.39.2020.11.01.06.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 06:11:33 -0800 (PST)
From:   trix@redhat.com
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] powercap/intel_rapl: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 06:11:29 -0800
Message-Id: <20201101141129.2280794-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/powercap/intel_rapl_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 983d75bd5bd1..020373d6d3f1 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -613,7 +613,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 	case ARBITRARY_UNIT:
 	default:
 		return value;
-	};
+	}
 
 	if (to_raw)
 		return div64_u64(value, units) * scale;
-- 
2.18.1

