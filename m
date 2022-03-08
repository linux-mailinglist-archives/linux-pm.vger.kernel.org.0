Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719DB4D211B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 20:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349938AbiCHTLP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 14:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350022AbiCHTLC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 14:11:02 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F874554B5
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 11:09:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k5-20020a17090a3cc500b001befa0d3102so2405449pjd.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Mar 2022 11:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IizyyKLt67Z0rg/Dl48rRHBPPMkh6LQBUEtOh7L4+qk=;
        b=Bvfe9G/MEM66BYRH60KYgdCaJh8AKOGbjxX5+ZCBHFRCY02DcOTijHLwWDlLz9nFmg
         V3PqU98KeKYRX34QTCbWnr1XJ0sMW/rOeT5GMi0izY6xvBsIPbq32RiLBMYqCOm9fUJn
         QJnq/Qrlh5G66FkEuGcFblcQlUXp0y2ZnWIJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IizyyKLt67Z0rg/Dl48rRHBPPMkh6LQBUEtOh7L4+qk=;
        b=3XnyOZoLXbFRKDkkp8FqcG8FSRPCbIcs9QYacNus5J3SFxR3EFcStTwbzpq6yyJUos
         w5eJ/1weFjTxnYbjW3rd4TACDAhZD6cZ4DMkPMFl9zh7ThKvJoMbwopCziJsY9eCfe4C
         581OsqRJMj30nOKsh351jwZ/HUmUPxq5NkIq3qQRpKEOf1N8pj7LEDI6RGaU7/MTBt4L
         Y3/BdQYq3a5niGGha8GRsdKNMYtHlx9LuASnJeQKsRrWutsiGgB3DZG9OOXQ/RCcwpqj
         u2C2SJaSAV/62I5nd9yDFsr400azNXDZ5hG8qqzO2Lk7BlO6zLue3DJEpOfPrYCtY9Dz
         7k6Q==
X-Gm-Message-State: AOAM530LNeFyuXxGySscxf0K7uugGbUWy8FDm3vePv1AoRFQdYSTITBG
        o81iM+sD6ck62e4I8KwlwF8Qyw==
X-Google-Smtp-Source: ABdhPJyqj7YklmvfKU/LYYyISAhNTAhR5T/zle5js+D93QhjzLdkS7Znp9ivicweO2UwT/n6KE8wCA==
X-Received: by 2002:a17:902:e944:b0:14e:dc4f:f099 with SMTP id b4-20020a170902e94400b0014edc4ff099mr19029261pll.161.1646766585879;
        Tue, 08 Mar 2022 11:09:45 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b3e3:a188:cbfc:3a0e])
        by smtp.gmail.com with UTF8SMTPSA id x14-20020a17090ab00e00b001bf2d30ee9dsm3639224pjq.3.2022.03.08.11.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:09:45 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4 13/15] PM / devfreq: rk3399_dmc: Disable edev on remove()
Date:   Tue,  8 Mar 2022 11:08:59 -0800
Message-Id: <20220308110825.v4.13.I1476960b2586441beaef21dca4feb3ecc067f768@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308190901.3144566-1-briannorris@chromium.org>
References: <20220308190901.3144566-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Otherwise we hit an unablanced enable-count when unbinding the DFI
device:

[ 1279.659119] ------------[ cut here ]------------
[ 1279.659179] WARNING: CPU: 2 PID: 5638 at drivers/devfreq/devfreq-event.c:360 devfreq_event_remove_edev+0x84/0x8c
...
[ 1279.659352] Hardware name: Google Kevin (DT)
[ 1279.659363] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
[ 1279.659371] pc : devfreq_event_remove_edev+0x84/0x8c
[ 1279.659380] lr : devm_devfreq_event_release+0x1c/0x28
...
[ 1279.659571] Call trace:
[ 1279.659582]  devfreq_event_remove_edev+0x84/0x8c
[ 1279.659590]  devm_devfreq_event_release+0x1c/0x28
[ 1279.659602]  release_nodes+0x1cc/0x244
[ 1279.659611]  devres_release_all+0x44/0x60
[ 1279.659621]  device_release_driver_internal+0x11c/0x1ac
[ 1279.659629]  device_driver_detach+0x20/0x2c
[ 1279.659641]  unbind_store+0x7c/0xb0
[ 1279.659650]  drv_attr_store+0x2c/0x40
[ 1279.659663]  sysfs_kf_write+0x44/0x58
[ 1279.659672]  kernfs_fop_write_iter+0xf4/0x190
[ 1279.659684]  vfs_write+0x2b0/0x2e4
[ 1279.659693]  ksys_write+0x80/0xec
[ 1279.659701]  __arm64_sys_write+0x24/0x30
[ 1279.659714]  el0_svc_common+0xf0/0x1d8
[ 1279.659724]  do_el0_svc_compat+0x28/0x3c
[ 1279.659738]  el0_svc_compat+0x10/0x1c
[ 1279.659746]  el0_sync_compat_handler+0xa8/0xcc
[ 1279.659758]  el0_sync_compat+0x188/0x1c0
[ 1279.659768] ---[ end trace cec200e5094155b4 ]---

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v2)

Changes in v2:
 - New patch

 drivers/devfreq/rk3399_dmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index f778564cab49..fca9fcbd4249 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -452,6 +452,8 @@ static int rk3399_dmcfreq_remove(struct platform_device *pdev)
 {
 	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(&pdev->dev);
 
+	devfreq_event_disable_edev(dmcfreq->edev);
+
 	/*
 	 * Before remove the opp table we need to unregister the opp notifier.
 	 */
-- 
2.35.1.616.g0bdcbb4464-goog

