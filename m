Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0816C7F81
	for <lists+linux-pm@lfdr.de>; Fri, 24 Mar 2023 15:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjCXOHB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Mar 2023 10:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjCXOGi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2023 10:06:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94631B55D
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2023 07:06:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t10so8278568edd.12
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2023 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1679666793;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NSRH/whhkHasG61CV9A5MEslEc9VQHATlvFYwxjFGj8=;
        b=5mNGte52FnpY3FXONGnlJ78wo0d7WWnd3PiT/98GxWyuU6hahwLQOypkA1gcdxBvc1
         XVboBPlBnu1JdD/nMAw7FK6LsvhxhRrf3ZlRybwCLyBEVh+wwGQ6lna1yHdiVbJRikVk
         9GDqw0Cu2le/0yYwhIjYsIJ7dIrXXZyoVQotRhYamq9wFEPq2rXoYYD3T2IVUDb0IP6z
         1dVkmLlbRrZ4iCm4uyvIXTJtuli2Au3UrrXuU959V9+1wctRukkogPE38otZ0MINqNMQ
         xIhnDDm9A994HmlVasqfqRpp77HPs16+9xkz0FIqD1wwE8msZNN9xV/tBoaNWlY9Pize
         /bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679666793;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSRH/whhkHasG61CV9A5MEslEc9VQHATlvFYwxjFGj8=;
        b=jk92CPhOVAGcVvU8ilh8es3DrgA5Wbb+n8IdkltxSB98VSOD8EbI9RxPlzeMide3Cl
         2TNZ5p2JRNZ5SrhCYHXOIFK2zvp3bJCk4HH1/oTC2s7MrUrL/oadDw3UmwQTRhMfF+TL
         PREOi4VLhOrC0jzUtETIwx1QYOglnmWajBbsGJpySiznlIjbf3+7zcq9q1fmooXNjZVV
         MiZ7j5n1vP46z+M1KWGfrTmDgSwrtdurW4OJK66bQijZoJv/AMn5HNTf4p/936Q05E7x
         VsLh6ODoweJ3v7YfbKi5JImDCHLGCFx1jMldKqTRbxBotvjALiE2iCgp0S3MOOdMLxJl
         cA2w==
X-Gm-Message-State: AAQBX9crFdbRuVih2icV9cM+UZyLqPq5USngdLJK6HXZlm/C8hCP9x4T
        +r30fmlatqP6jmdHxP6kaIr2XA==
X-Google-Smtp-Source: AKy350aSSQNUKP8+F3tSCmiOeC2fY+aNnCrd8kWjimpqxpgdGJmkQx3EO2E13p/C7DmSUvT+MBojvg==
X-Received: by 2002:aa7:dd50:0:b0:4ac:bd84:43d9 with SMTP id o16-20020aa7dd50000000b004acbd8443d9mr2908854edw.2.1679666793317;
        Fri, 24 Mar 2023 07:06:33 -0700 (PDT)
Received: from [192.168.0.29] (84-115-214-73.cable.dynamic.surfer.at. [84.115.214.73])
        by smtp.gmail.com with ESMTPSA id ch19-20020a170906c2d300b00933d64cd447sm7645192ejb.121.2023.03.24.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 07:06:32 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 24 Mar 2023 15:06:24 +0100
Subject: [PATCH] cpufreq: Add SM7225 to cpufreq-dt-platdev blocklist
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230324-sm7225-cpufreq-v1-1-7c2e9a4ab7e3@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAF+uHWQC/x2Nyw6DIBAAf8XsuWtwQWv6K6YHoEvdg5RCnzH+e
 7HHSWYyKxTOwgVOzQqZX1LkFit0hwb8bOOVUS6VgRRppclgWY5EPfr0DJnvqMiNqqdh7IyGGjl
 bGF220c97FpLBoaX2i29J+PBpod1KmYN8/tvpvG0/xbJACIYAAAA=
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SM7225 platform uses the qcom-cpufreq-hw driver, so add
it to the cpufreq-dt-platdev driver's blocklist.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 5ac6b9e5270e..452181434735 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -152,6 +152,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sm6115", },
 	{ .compatible = "qcom,sm6350", },
 	{ .compatible = "qcom,sm6375", },
+	{ .compatible = "qcom,sm7225", },
 	{ .compatible = "qcom,sm8150", },
 	{ .compatible = "qcom,sm8250", },
 	{ .compatible = "qcom,sm8350", },

---
base-commit: e5dbf24e8b9e6aa0a185d86ce46a7a9c79ebb40f
change-id: 20230324-sm7225-cpufreq-02b805268143

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

