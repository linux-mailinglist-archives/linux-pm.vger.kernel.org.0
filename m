Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1AA11F36A
	for <lists+linux-pm@lfdr.de>; Sat, 14 Dec 2019 19:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfLNSLe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Dec 2019 13:11:34 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37223 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfLNSLe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Dec 2019 13:11:34 -0500
Received: by mail-pj1-f67.google.com with SMTP id ep17so1139818pjb.4;
        Sat, 14 Dec 2019 10:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v1jzw3cTgARl5UtByan28qHh9GkTIdbeMdcGnEnNuqQ=;
        b=nJtCJighcBW7qQ0mUEAJ+mt8TIpyIXMY4sumdT4LQ3mKPCkagjoGjn2/CdUIK4ZVI5
         VIx1bvfJi1AA6AFFxhP1zt43mog6ji/gwenI530G5DagqKmcWQBd7GCKxbuZJxbzRPxQ
         BcPgsvhKQlRubwxNqhuN3/hSMl5kYOng9thJetOaergkSAyaofdC0jRZPQNfKZes/7XT
         oQKYpwlPN+wPBYkwtoUyTvRGvwQZglorntRKlPsm/TY6eJ7isjWA74TFxG5Nx590LCdS
         I1/lSTh8C6nkBBKa3UJ2gZZgiLf7I4NVAyudgR5hWzVrx+aaEhYt6J4HcMChKWYbdmn4
         E3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v1jzw3cTgARl5UtByan28qHh9GkTIdbeMdcGnEnNuqQ=;
        b=qFkf1bKZSjtHaKT9ay1kQL9L2RjCNH6t33J2yGi1dcMrMyp6XI0SUj4jn05uQ1G161
         WsUJVz9nHnnE9OfeUNzZGutgM+kez/yGqlTxvVJjgvSe9Q8OP74JCy74/q0WGqBp3HEK
         eoTYls4LPSo7Pcs73/RAsHDNWG00mNIcNkM4gZusjbz6QiLH9AoNjqPs1ETjy7XJrb6i
         NuD8OSZv1tMSSzg2gpoz7PFSmASszVqs8GCXcpu8vh1BARP+6QQqmh+Q0UUF8he47zvB
         QXQVBzE7D5TiW2f1+4kXM69MAesUG0InAyHfbEPEorDWyISUwHSJMRaOHQUIRip9d8ln
         5CyA==
X-Gm-Message-State: APjAAAXGCfiwaEyrvo7+tHkHTvXl9mK1WV19Hbrn4D8U/NvxOzOE3fPO
        Kdm6x5vnEsndVN+1XcPgUfI=
X-Google-Smtp-Source: APXvYqzws7Irzz8SVSeA5eeveXWvkJ2t4wz1lTz0HCd8Gn3Nu+eQpYu7QiRwV5E7bR75avFW+NGUeQ==
X-Received: by 2002:a17:902:8693:: with SMTP id g19mr6130524plo.116.1576347094175;
        Sat, 14 Dec 2019 10:11:34 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id b73sm16427814pfb.72.2019.12.14.10.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Dec 2019 10:11:33 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, heiko@sntech.de
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/2] PM / devfreq: rockchip-dfi: add missing of_node_put()
Date:   Sat, 14 Dec 2019 18:11:29 +0000
Message-Id: <20191214181130.25808-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 5d1042188727..45b190e443d8 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -200,6 +200,7 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
 	if (node) {
 		data->regmap_pmu = syscon_node_to_regmap(node);
+		of_node_put(node);
 		if (IS_ERR(data->regmap_pmu))
 			return PTR_ERR(data->regmap_pmu);
 	}
-- 
2.17.1

