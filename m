Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F384290B3E
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 20:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391417AbgJPSXp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 14:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391390AbgJPSXp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 14:23:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5317C061755
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 11:23:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p15so3290064wmi.4
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMd/PE6SkMQGEjnH+y069gqvi/8V6l4jTsxAP4NdnU4=;
        b=najltAJwVmZII+1e30IFrzBErsEFDns68aGIAEAFuHIBfIiNVMWuswnl4H7BamM+UL
         iLk0aX9VfPU1IiZOy0vGaCAgS8P4f5mgPuREzuBk+lu9GNG5gD4hsoLDCFMsoSV8PXhu
         PtG3MvU4gunRyRsZ9IqQpKz71uxLBzQLf6fa6Aj3EAH9/bNcH8IuKgRjkjWdqF29cNyU
         2eYXQjTsvsHlVmpJMUa8LCQLhHxznKRL5MUjNzDRLdi62BSAg4JvYB4ZMiOvPbSzzGTk
         fO/GTwKFBKWiRe4Idh7+VOHSbZx4QASL56IQelaTja7j4/rQEO7va5KsXRxEaHPBre2W
         j3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMd/PE6SkMQGEjnH+y069gqvi/8V6l4jTsxAP4NdnU4=;
        b=UP18fmrFgRAywLB7MJQGDbEuzdZYPb+XQQ8xuu2TWKsj9wrgiHy4+vzvHlsNhkeVST
         WhNUqt4ACtexcnQhPGkzpPBGtrRN6ktdr1nx/E90dzTpv6HeVWXzvu9RQf0Si8gAKNsz
         L99yz2dx01nQ+wq6Grt3ddcqFuizNlksIg9iCm1KfgylZspuWrp6Q5Prx46e4HGf4FDu
         ywh5Ie96o2a+E8F/XSvTJrMpX0crYcde+fhn+b9G3UcLrE6aWXcnZDuVIjbwuehf0dLs
         2s7xsBtnocIIpY2iyP+d9mtPSpovGQqRD5yaG1MNrqhXMuizN0Rysu4f5SmCrlCFuZA6
         Inng==
X-Gm-Message-State: AOAM5302ofxoff8dVZh2ibswzAy7HJZsnncTfs9cRI7uFeEVAgaMp0jE
        f6Q4FGOxVDPBoLgg2CjuUyq4WUpirxs=
X-Google-Smtp-Source: ABdhPJx3E+fI3LvtQeu3Wr8spwrtP8mSBJ80aiVr8NhksghvBHGO4U5qk81Rvta003NaTaFmceY3tw==
X-Received: by 2002:a1c:7d48:: with SMTP id y69mr4982700wmc.82.1602872623090;
        Fri, 16 Oct 2020 11:23:43 -0700 (PDT)
Received: from tool.localnet ([213.177.192.103])
        by smtp.gmail.com with ESMTPSA id 4sm4463334wrp.58.2020.10.16.11.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:23:42 -0700 (PDT)
From:   Daniel =?ISO-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] power: reset: linkstation-poweroff: add missing put_device()
Date:   Fri, 16 Oct 2020 20:22:37 +0200
Message-ID: <21115613.dmes8fMApM@tool>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The of_mdio_find_bus() takes a reference to the underlying device
structure, we should release that reference using a put_device() call.

Signed-off-by: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
=2D--
 drivers/power/reset/linkstation-poweroff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/linkstation-poweroff.c b/drivers/power/res=
et/linkstation-poweroff.c
index 39e89baed..f1e843df0 100644
=2D-- a/drivers/power/reset/linkstation-poweroff.c
+++ b/drivers/power/reset/linkstation-poweroff.c
@@ -113,6 +113,7 @@ static int __init linkstation_poweroff_init(void)
 		return -EPROBE_DEFER;
=20
 	phydev =3D phy_find_first(bus);
+	put_device(&bus->dev);
 	if (!phydev)
 		return -EPROBE_DEFER;
=20
=2D-=20
2.28.0




