Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E364D0C99
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 01:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344117AbiCHALk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 19:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344096AbiCHALh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 19:11:37 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1E2377C6
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 16:10:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so674057pjb.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 16:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IizyyKLt67Z0rg/Dl48rRHBPPMkh6LQBUEtOh7L4+qk=;
        b=nmr1p7Zpi21Vo5nTGQ+W42hBgVJ+wceTgYMvIvBNHV386aRnfyDx2oDXThvctKBNiO
         T+ds6ZOdwo39kocWApZebgjftNY0qoz+m3RDRYadSuLI5UyDMPTNYd/7L1TqLH5XnUrc
         khMiRUj24hUdQ0Tu2ts8+KNaNSnmUm4eFMIF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IizyyKLt67Z0rg/Dl48rRHBPPMkh6LQBUEtOh7L4+qk=;
        b=kH+dabtKRKlMTXTvcfTa+/M7F3GFRp9LvJtsWIlJ60wX48nYnyRQTS2B4DZqiyI2LK
         HEAqEkBpXjdNWw9N7TtqawzCwh/jjH13iWKCspY6SNT3BHZgjXJ5/S/Aj4kUeQBX65HI
         ynuyy7Y0jcqEUSBCZCr6zAM3pSkpZbeKYAcBt/DDt3R7E2CzBLaaFUc3wbI4XRVYrrUb
         F2PlGor4/0OAR2GmSMvY14KZstzVfakAVm6WWaCXjZ6wPsceVXwrNn7NjAqIBrmSMTf5
         jq3C4IdDo2xuJSoPkPwtyDvBqFmGHJ+1ePMXgrtM0okpW9BvnzZW6TPHIlnVFit27Ajs
         GNKA==
X-Gm-Message-State: AOAM531Wt5VfviJzgzy0WhiiiMwtOGhk1MmFZIU9RjBcp6PPoZeUYzje
        sp6IzEAH2VH2r3o5BdjVY8HDtA==
X-Google-Smtp-Source: ABdhPJysG+im7jQcn3JoysEPs+yE0jkGta4yg1/JABKGPaFJwDQomfn0JrClYlwNdAQ8BMAxlnuKOg==
X-Received: by 2002:a17:90a:138d:b0:1bf:7b06:ad6b with SMTP id i13-20020a17090a138d00b001bf7b06ad6bmr1672053pja.180.1646698234653;
        Mon, 07 Mar 2022 16:10:34 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e551:44dc:2842:57f1])
        by smtp.gmail.com with UTF8SMTPSA id g5-20020a056a001a0500b004def10341e5sm17375356pfv.22.2022.03.07.16.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 16:10:33 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lin Huang <hl@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 13/15] PM / devfreq: rk3399_dmc: Disable edev on remove()
Date:   Mon,  7 Mar 2022 16:09:43 -0800
Message-Id: <20220307160918.v3.13.I1476960b2586441beaef21dca4feb3ecc067f768@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308000945.706701-1-briannorris@chromium.org>
References: <20220308000945.706701-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

