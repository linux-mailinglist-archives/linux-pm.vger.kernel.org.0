Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B055977C360
	for <lists+linux-pm@lfdr.de>; Tue, 15 Aug 2023 00:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjHNWV6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Aug 2023 18:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjHNWVy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Aug 2023 18:21:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B608E61
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2023 15:21:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589c2516024so47201967b3.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2023 15:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692051712; x=1692656512;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RTWgDCbnFUgO1HWtlSj6vfjNh6uEFztFcnKIx6cL6BQ=;
        b=aW5BiVb0BJerVlOUuQqirDiDzgsZOv/UGtud9s1nPzNjzQMSVCZIWC96olVT8c4dzb
         LkNm1Un2nV5Eah5qtCvSQVtmzHVOjS51wtSCIMrXGor5zQ1o9c/H3Ldi2GRceNBh1hik
         /pffbkFEpqrhPoGr/TaKHqfeMWiBn18IrUyykEXvELpcY68P3h6/xa89ub5eRoXX9TpA
         KRX1oqhdxs3AAMAlBDwuwJlLp6Dy0qQi9PU9YFwrhAtUypZpLSYkl+UrwbWV8tdxbK6E
         fY4aALzUB3BTpApo6XaeosKZjR8+dahf5ULD575DA7OnVPMJlf/WRyCYYENFCFrjNL1d
         2G9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692051712; x=1692656512;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTWgDCbnFUgO1HWtlSj6vfjNh6uEFztFcnKIx6cL6BQ=;
        b=JjQulEbeqNdI1dzTmqD6DcTJypratfPfPvFMQhRiKmkUDKLietbkKX08/6liZIX1rD
         nbFTSUMqpDUEbaN8MFPvsDlX1es1MUATw5X+zRbGjHA0DiDSObQ1/rSGstl6U8Vb/a+w
         bZ79F2CqGTNnwExjCrz9pGj70kWoqRre24VX2rnl9B0Oka/Q3eLsAQMvIOBp+Cqs2mEn
         jpM8xNnc8k83vaIU4HN1UrOUI+IOHaKcFdv3/uxgV4TbF7QVk1MW4zbSQc3iHlCWavQq
         CuUa4FTexc6p3wiqZaS8B30qMxOvzpkZUwlnR9+n/dJ0mFRTzC8AnGt24rLA/0xkY2uH
         Ao0A==
X-Gm-Message-State: AOJu0YxN3GzRQqKzMPs2mliGdqvrXt5CGWDS79U3tM/lqXfxkE436Hry
        h9Oh4+QGh2nFJ42eaJczS7ndKBf/Sc69vcDplA==
X-Google-Smtp-Source: AGHT+IGUgCbq7vkRnFlWVMmgA0rhj2KZXb4OGaK48ZEofd8nevbwEQv6l0sLR8RgIqA4jQWqYXPdgCPYAfJ7Gpvt3g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:ae65:0:b0:56f:f62b:7a11 with SMTP
 id g37-20020a81ae65000000b0056ff62b7a11mr149484ywk.8.1692051712685; Mon, 14
 Aug 2023 15:21:52 -0700 (PDT)
Date:   Mon, 14 Aug 2023 22:21:51 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAP6o2mQC/y2NwQqDQAxEf0VybsDdSl38ldKD7CY1F1cS2Qriv
 zeU3ubNg5kTjFTIYOpOUGpiUleHcOsgL/P6JpTiDLGP9z6FAVuVgkWlkRpu9UOKSkY7Njo2T/+ yMmOex0ccUsocGHzQNcvxO3u+rusLXOcftHwAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692051711; l=1670;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=mDCmp0Hqg8EtlQGDIRB0W9nWt/W1QOLsyus7HkWaU74=; b=tywnHn/ERnLM9VIFtrhcr3oDmTExX8AP4yrHSMg6fIibovmNBnUJxcxLIW2tk1NeK0mKTMw23
 5cQft0dFY2NCIrWine0ndcJlpEkG6vXZKKtD0o/ILix3ztfjyGjRaON
X-Mailer: b4 0.12.3
Message-ID: <20230814-void-drivers-power-reset-vexpress-poweroff-v1-1-c3d9b0107e5d@google.com>
Subject: [PATCH] power: vexpress: fix -Wvoid-pointer-to-enum-cast warning
From:   Justin Stitt <justinstitt@google.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When building with clang 18 I see the following warning:
|       drivers/power/reset/vexpress-poweroff.c:124:10: warning: cast to smaller integer type 'enum vexpress_reset_func' from 'const void *' [-Wvoid-pointer-to-enum-cast]
|         124 |         switch ((enum vexpress_reset_func)match->data) {

This is due to the fact that `match->data` is a void* while `enum vexpress_reset_func`
has the size of an int. This leads to truncation and possible data loss.

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: In this case, it seems unlikely that any data loss is occurring
since `enum vexpress_reset_func` only has a few fields enumerated from 0.
---
 drivers/power/reset/vexpress-poweroff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 447ffdacddf9..17064d7b19f6 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -121,7 +121,7 @@ static int vexpress_reset_probe(struct platform_device *pdev)
 		return PTR_ERR(regmap);
 	dev_set_drvdata(&pdev->dev, regmap);
 
-	switch ((enum vexpress_reset_func)match->data) {
+	switch ((uintptr_t)match->data) {
 	case FUNC_SHUTDOWN:
 		vexpress_power_off_device = &pdev->dev;
 		pm_power_off = vexpress_power_off;

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230814-void-drivers-power-reset-vexpress-poweroff-ca762488cf1f

Best regards,
--
Justin Stitt <justinstitt@google.com>

