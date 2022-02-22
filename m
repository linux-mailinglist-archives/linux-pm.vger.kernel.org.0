Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FE74C0401
	for <lists+linux-pm@lfdr.de>; Tue, 22 Feb 2022 22:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiBVVoJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Feb 2022 16:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiBVVoI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Feb 2022 16:44:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5ED3C3C21
        for <linux-pm@vger.kernel.org>; Tue, 22 Feb 2022 13:43:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54EA5B81BE1
        for <linux-pm@vger.kernel.org>; Tue, 22 Feb 2022 21:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BACC340E8;
        Tue, 22 Feb 2022 21:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645566220;
        bh=jKZy5vYwk+iO8mfl3Hvdcb8DqQthbOoCnB7fcGM07VE=;
        h=From:To:Cc:Subject:Date:From;
        b=sDtwyhuh5sOVvC0GSs5mZ48rwbuMt3fJkKvQILBCJNDsW/+z3E2Tu2t5athcR9hFo
         +pn3m84M015GRWHMSEu5qzYe+yK5NZISV/AxTLBJ4GwjmEhBxpqlhIseHu699hAZhz
         48FJ/3qeQPjRhBvisq9C2iGb23z1maQhMawA/pwCs+9PKA8JUzVuFqEgFa598LtNW5
         S1h9UlJCA01Gy5PGRCsgD9BKHo7Z7S63IlGAgFmOtj7pmju9XLM2z1x3RH+jc4en7r
         qwb13yXBvO7LdBBAOoz9YIBRNpV/PEATZdR/qIVPmT+fw11EnQxKE/6L0T8GE6bgOh
         Q8hzTNlnTDIQA==
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] power: supply: Use an rbtree rather than flat register cache
Date:   Tue, 22 Feb 2022 21:43:31 +0000
Message-Id: <20220222214331.1557723-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398; h=from:subject; bh=jKZy5vYwk+iO8mfl3Hvdcb8DqQthbOoCnB7fcGM07VE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiFViSm5nekEWHqYihZgPllTpwT1vx0nqamKxCjCY1 G5BLv0eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhVYkgAKCRAk1otyXVSH0LWLB/ 4gT34GGXSQFfpRY9XmnpLA7b9H0ymPLJMue/FUe3OeLZSsAh7kjtytcw5aAN8Scx5oNJOwNyaRmXsY E6h4bk/wIvtoJ5dlOUJEX8T4mJcKp7JRAHZcZFxg12lY0aurT+vco29Mheh8iiwjQtpXqIkfbFSuQB ljrF/eYJN7hW2aHD1XrG7wgqER6RhkdfqEpfXDVlWyTm4rmW1LHl1V0R3siiuiuI9+MXNlXlD8STzx dvWp6DqIOl/adHajsk56WHwv5ZkZcz53w8ZXEdYUtZkScNeJJLdFzNzAQKNK8776zKTqvljribdyhv Sz0Gcsf49OT5PCgR/BSS234Ahj5MKL
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The smb347 has a very sparse register map (the maximum register is 0x3f but
less than 10% of the possible registers appear to be defined) and doesn't
have any hardware defaults specified so the sparser data structure of an
rbtree is a better fit for it's needs than a flat cache. Since it uses I2C
for the control interface there is no performance concern with the slightly
more involved code so let's convert it.

This will mean we avoid any issues created by assuming that any previously
unaccessed registers hold a value that doesn't match what's in the hardware
(eg, an _update_bits() suppressing a write).

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/power/supply/smb347-charger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index d56e469043bb..1511f71f937c 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -1488,8 +1488,7 @@ static const struct regmap_config smb347_regmap = {
 	.max_register	= SMB347_MAX_REGISTER,
 	.volatile_reg	= smb347_volatile_reg,
 	.readable_reg	= smb347_readable_reg,
-	.cache_type	= REGCACHE_FLAT,
-	.num_reg_defaults_raw = SMB347_MAX_REGISTER,
+	.cache_type	= REGCACHE_RBTREE,
 };
 
 static const struct regulator_ops smb347_usb_vbus_regulator_ops = {
-- 
2.30.2

