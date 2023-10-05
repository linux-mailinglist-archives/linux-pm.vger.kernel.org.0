Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BF47BA801
	for <lists+linux-pm@lfdr.de>; Thu,  5 Oct 2023 19:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjJER3A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Oct 2023 13:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjJER2b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Oct 2023 13:28:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D0B449A
        for <linux-pm@vger.kernel.org>; Thu,  5 Oct 2023 10:25:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81773C433CA;
        Thu,  5 Oct 2023 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696526748;
        bh=DYgenNLerdu9RAwVeCgwZpULc3B6FOwx/xoe/GURY58=;
        h=From:Date:Subject:To:Cc:From;
        b=XGevS/E1j4f1SvwKHaPpQT3mNwMP3DoLYIqt0uSEhDp490aY/oa2DggwWIiYXil+O
         W604m8bTIc3VhAmd8zbU/zTbq2UJKNbIVHC+rVMUIr2NUn0lWK4tpA9ZjSFx7OjeJu
         jGmUqRrmD8MA6F4OpcEFqsz+3Cx8p3IAHipsM9f9ll1wlqUv0LeWv+10kblOqKmQIg
         kbJTymxtuoXKyagBLjgUutcajutG3NYUX8Z0JogEyZtA3w6P71iRPQSSzy/vg8ff0j
         +Dqzb+x08y4a38qnumDC0wGv6N4Sx/J8hJds1kVzC0j13TMQXCM/l8B5Zx7s3Mv6ge
         N+35S9yGQxtdg==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Thu, 05 Oct 2023 10:25:27 -0700
Subject: [PATCH] OPP: Fix -Wunsequenced in _of_add_opp_table_v1()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-opp-of-wunsequenced-v1-1-778815980a8d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIbxHmUC/x3MOw6AIBBF0a2YqZ0EPxS6FWNB4KnTAEL8JMa9S
 yxPce9DGUmQaaweSjglS/AFTV2R3YxfweKKqVVt1yilOcTIYeHr8Bn7AW/h2Oihh+mt0p2jUsa
 ERe7/Os3v+wH+JxPgZQAAAA==
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        ulf.hansson@linaro.org
Cc:     ndesaulniers@google.com, trix@redhat.com, linux-pm@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=nathan@kernel.org;
 h=from:subject:message-id; bh=DYgenNLerdu9RAwVeCgwZpULc3B6FOwx/xoe/GURY58=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKlyH2fn1TWnuh2xf6D8Wkc6aX9nz525ukYbuxdN22qxo
 jBjm+3jjlIWBjEOBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRRX6MDHd5c8snrbobtC8w
 WKrr1YopCnwWhiJvj1mLRW8/6r1hrzwjQ3ek1kSDB/886zo/Pp+wgPurfUvmxLwQ8zVpz3ZL307
 ayAMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Clang warns (or errors with CONFIG_WERROR=y):

  drivers/opp/of.c:1081:28: error: multiple unsequenced modifications to 'val' [-Werror,-Wunsequenced]
   1081 |                         .freq = be32_to_cpup(val++) * 1000,
        |                                                 ^
   1082 |                         .u_volt = be32_to_cpup(val++),
        |                                                   ~~
  1 error generated.

There is no sequence point in a designated initializer. Move back to
separate variables for the creation of the values, so that there are
sequence points between each evaluation and increment of val.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1940
Fixes: 75bbc92c09d8 ("OPP: Add dev_pm_opp_add_dynamic() to allow more flexibility")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/opp/of.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index ade6d42cae46..ae5c405bbf9a 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1077,9 +1077,11 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 
 	val = prop->value;
 	while (nr) {
+		unsigned long freq = be32_to_cpup(val++) * 1000;
+		unsigned long volt = be32_to_cpup(val++);
 		struct dev_pm_opp_data data = {
-			.freq = be32_to_cpup(val++) * 1000,
-			.u_volt = be32_to_cpup(val++),
+			.freq = freq,
+			.u_volt = volt,
 		};
 
 		ret = _opp_add_v1(opp_table, dev, &data, false);

---
base-commit: 3c4746e28af13fdd134d3c4312169fda0a8abef0
change-id: 20231005-opp-of-wunsequenced-a594ea4c053d

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

