Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6712F7AB8A9
	for <lists+linux-pm@lfdr.de>; Fri, 22 Sep 2023 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjIVR4E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Sep 2023 13:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjIVRzs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Sep 2023 13:55:48 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE202E5E
        for <linux-pm@vger.kernel.org>; Fri, 22 Sep 2023 10:54:01 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1778792a12.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Sep 2023 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405241; x=1696010041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=blbaNQfE8VF8IyCe56PdApvTuknWltr7FlvuMXZ9aXQ=;
        b=WAgkpwpbAEya87UlUu+Tt/mG4f/VbdOdzsamvOTyzStKkQ9+NgNGL5DOeHYBiCu5Fo
         c0m/RuQJwpqRF/gAY6pYgS9PiUtMd64YbmsHFyGSvkgGUVL7NpTDyfMvycXPYmLZ0jH4
         L/awb1+Bz9x3qW4/el29/xLVEQen/La21lsEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405241; x=1696010041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blbaNQfE8VF8IyCe56PdApvTuknWltr7FlvuMXZ9aXQ=;
        b=JhmD12mJi8cvX055F/XVqENHqeJZzL+sSpP2H4YXWucKeuvnrqQHgHKE2gXHCU6H6i
         wvx8JbqQNtHngGCF1nCaaIHudff3Hxa0I5ZUXP9GXhMpe8/DDzPff6vuAw8Xuca1RjJQ
         NKnssiHYSFyuqIsezmJngfK06nd05qeuoodbCu/WTqylFN3qGcKc98+BSW+Mt/LjajEK
         3+DAX6GPz+wmh41QmGMt43h4LNcLkh3nTn+2eRYrCE87itSuEVABuHBe5395VnRZPNib
         O7dCquELhD0hdWJraX6YrC6NX4ViVphE6JXbP0hOVKJAXCegsW7kGdVlYo4WPExpZhf8
         mPvw==
X-Gm-Message-State: AOJu0YyiU8s/MMsyjjH9zMa5SlWzpsa9FLK6FXnwNUUlIfBPDbxmK3lj
        yPz5vIo3Qc/bWKMEUE2a1WgyaQ==
X-Google-Smtp-Source: AGHT+IFaO9KtLZCcUOV7EhIX5OjLxGdOM0WYzA+wc3k3wsNUoy0acGXxR7rJOrzS65Y/KaC9Mc1qiA==
X-Received: by 2002:a17:90b:3ec5:b0:268:3d4:24bb with SMTP id rm5-20020a17090b3ec500b0026803d424bbmr416808pjb.1.1695405240748;
        Fri, 22 Sep 2023 10:54:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a818300b00267ae12b80bsm5156478pjn.34.2023.09.22.10.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:54:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] power: supply: axp20x_usb_power: Annotate struct axp20x_usb_power with __counted_by
Date:   Fri, 22 Sep 2023 10:53:58 -0700
Message-Id: <20230922175358.work.774-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=keescook@chromium.org;
 h=from:subject:message-id; bh=hUdVdLxiWpJoNa3S8zTxaKIJTMK1jo8G/vYOGoC9vzo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdS2EABKtMu8RCKmdL8MpgPHDFTGxabuzsdMq
 njl6//sbfeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UtgAKCRCJcvTf3G3A
 JuDTD/4rO45l/UjCZvd4HNI2vUdfkJfoazSV8gz7Hvu9weac7Gr1IAEVf5JUdAVmNBR/y+2nf5r
 DQxckTpjO+exDErFnK5YMPRQawm9wSNemZz1mf16g34Ri/WjJgE5vBbaIzHBauH7wii9TSPuJWd
 9mYKwClTjH7RDKgtSSfuXGG3PwBzL1T9lu1Raw1Pj722MlBK+Bn8cOJ5CjJcfOvpXe6hHCBV8xj
 vb/IOw2R2vD2YQfeW/eYfYdhk3bddOMr5qKDk/+O4I8MybaWKRVyfeZk/xwPqH5rRe4hIzU0+uq
 fjo/G69vAk2nlGFJTUBUDjO62+YwN6L2OZwkAvdmhjH8BM2++UU0z627piI+msOiaUUrNVfT3/W
 c6Q4a/Wn0u0CC/M0j/gL0ZGrgr1jHtOKA+0Q67bOq3BeXKyQE6NgvdAA/vX4YCskkj/iRTLgZW5
 Mr/yTJ5ts2lYw9XS9mzf4mjlvAIEmYTVwiYfHHSxi/sy+OF3G39hrfEMwSQIPJseKFEhWR3V0+y
 yb4B1LpNYBzr4LFk5oD63XOTo8CmK+bM7zpspN+Zd3QOB5Zt3adIr6ZaHVcIqqlZA6ZlxevxglE
 8/KqnJI/NicJkcQxzCtvyFvN/cWyzhYND0DnlSgT2c/GsQ4+UJSVM8F8nNFVvxR57tIejz5fxrJ
 wYT6csd pqwThkzQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct axp20x_usb_power.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/power/supply/axp20x_usb_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index bde17406c130..e23308ad4cc7 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -73,7 +73,7 @@ struct axp20x_usb_power {
 	unsigned int old_status;
 	unsigned int online;
 	unsigned int num_irqs;
-	unsigned int irqs[];
+	unsigned int irqs[] __counted_by(num_irqs);
 };
 
 static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
-- 
2.34.1

