Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1CE45627F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 19:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhKRSkZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 13:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbhKRSkZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 13:40:25 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92B1C06173E
        for <linux-pm@vger.kernel.org>; Thu, 18 Nov 2021 10:37:24 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i12so6903955pfd.6
        for <linux-pm@vger.kernel.org>; Thu, 18 Nov 2021 10:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=clRlkcTWzJOWdb6SjT1HZu+AyElzVwLtoYPXziOiXRE=;
        b=oY7fVIiTAYnTqInaucomXlnqySq5BwBRW6KXZQ3tAe5Nt/jzBPxEe7HGtHgSYSpsMx
         JL6AqOkxn9t+v9dhiUB01lWZYqrcjU9G3FBe9rg0WC4TfNPviTGHoq/+6qp1W6aFlTOF
         dvujVBx27nX0gWVuYqTfJfZTge+VWgImT1aqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=clRlkcTWzJOWdb6SjT1HZu+AyElzVwLtoYPXziOiXRE=;
        b=wUFOqbirfjn9Vm1aT2+kPDOA/PnG9c3fUwIJrxunqj+q2+7hn7DTZZNIdZ91OItX5O
         HgT0P9/NxEqZevkd0nJusj1FQf5/UJ8zCFfMc/PHSOraJ/PSpvFMynZyLdVi9Wsb7lGI
         pve3eFiZdGxSISr6/Dnor50Q+VFS+/WnlUFPGvDMc/oy4Ece/k5uXvfC2WDlVt3/xaxy
         Pk6O9SQ4BtaYlQQh73jePvJqpoGGPgvPQxWQLTDJUmiQYQ8CbnRBoOYw7hMWl9rHvBWE
         qOe9RcaXbn/brpjBcCuxIPMOYGqZ11FaOoGw9URsSF6La1UpNHFp3qGXeJF4Tj7WXB8x
         NbJA==
X-Gm-Message-State: AOAM533b46HCB6LvImaN5c4EhdRiHmZP1LgEvHd/5QXRKd7PKHrgFE6m
        D/WSBL8bT3EW2T8qnW2qHG5OwVYgWYSKSQ==
X-Google-Smtp-Source: ABdhPJzvGy5Q9eb8Ms7CI5ZHNFdwzG8O5AFw8vmp2OUM5bltybpyQ2T/sTVs4ZaHR76fdd6ospb1zg==
X-Received: by 2002:a05:6a00:26e3:b0:49f:c0ca:850e with SMTP id p35-20020a056a0026e300b0049fc0ca850emr57893944pfw.4.1637260643129;
        Thu, 18 Nov 2021 10:37:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b9sm324100pfm.127.2021.11.18.10.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:37:22 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] thermal: intel: int340x_thermal: Use struct_group() for memcpy() region
Date:   Thu, 18 Nov 2021 10:37:20 -0800
Message-Id: <20211118183720.1282540-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3277; h=from:subject; bh=FXb9nQQ+9raXNRheCnPL/rsMtfpVZSmOVeEiPUzBx+k=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhlp1g97boEQtghYWjunVAHXryqRBeKslQ/U0/9Z2K SuHsN8WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZadYAAKCRCJcvTf3G3AJq6KEA Cq20Gf/+Ej92Sxr7ZbNW+QKWeFJDk56z7sNHE0roxks3ZGfeYa/gixYUjrdl6IAQKl553wzRaKoYwY tx7WMeOtV/opd/xq6vYTaMM/zBgEJuNdR/fF9bNGgaiswLzZWisgIBchzD+XwIuhtiewP1m5dE/8bq bsA97zyTEtdrsX8gqAhTzXY3Dm6A1rgfQWe1rlfd5RAgnz0WEmV7nnDl2sCA9M7fumTk6svQw5RWpC ae806DJbuzjNrJmp2d9XaEapK3XNMHKY5lpV6puNAVEubCdhkz9SC8Jd6vd7r6TWPNkj5ntZikzbd5 QU1Ut8w+ttz7GXA0mjxkVkhyQ+AMgfU9vFjx0Xmjdqv5pvuNXmBrs9CH2pVxMJHZLV3g79ksaJdYAG dnJn5FSQ5ICsVGR9rdhqvpJDJCCkBJnNbNpSA9jbnMT5jAofGeRCj/pIfr6s6l+pz838LVgXiFQGii DDXsL3pc1zeu7bi9xkTNAMA0f5PjTGmxntTPps2kKqrzgluV3j+/+YbxE0Iy4Lo60VZxlHjeVf6HFY DzYj2vOCiCqNRBFNxGSnv6g6tifRyiLCF3ruA8UUOWNgT+5EBJvL3uhIZnImNYu2sHIabEsiQtwK5I BvbJzO+4AIU6UPwZzzNcZL2MHlcVwNY27JEk00SqHgwvKHPKkGWXcAbSo5AA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), avoid intentionally writing across
neighboring fields.

Use struct_group() in struct art around members weight, and ac[0-9]_max,
so they can be referenced together. This will allow memcpy() and sizeof()
to more easily reason about sizes, improve readability, and avoid future
warnings about writing beyond the end of weight.

"pahole" shows no size nor member offset changes to struct art.
"objdump -d" shows no meaningful object code changes (i.e. only source
line number induced differences).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../intel/int340x_thermal/acpi_thermal_rel.c  |  5 +-
 .../intel/int340x_thermal/acpi_thermal_rel.h  | 48 ++++++++++---------
 2 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
index a478cff8162a..e90690a234c4 100644
--- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
@@ -250,8 +250,9 @@ static int fill_art(char __user *ubuf)
 		get_single_name(arts[i].source, art_user[i].source_device);
 		get_single_name(arts[i].target, art_user[i].target_device);
 		/* copy the rest int data in addition to source and target */
-		memcpy(&art_user[i].weight, &arts[i].weight,
-			sizeof(u64) * (ACPI_NR_ART_ELEMENTS - 2));
+		BUILD_BUG_ON(sizeof(art_user[i].data) !=
+			     sizeof(u64) * (ACPI_NR_ART_ELEMENTS - 2));
+		memcpy(&art_user[i].data, &arts[i].data, sizeof(art_user[i].data));
 	}
 
 	if (copy_to_user(ubuf, art_user, art_len))
diff --git a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.h b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.h
index 58822575fd54..78d942477035 100644
--- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.h
+++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.h
@@ -17,17 +17,19 @@
 struct art {
 	acpi_handle source;
 	acpi_handle target;
-	u64 weight;
-	u64 ac0_max;
-	u64 ac1_max;
-	u64 ac2_max;
-	u64 ac3_max;
-	u64 ac4_max;
-	u64 ac5_max;
-	u64 ac6_max;
-	u64 ac7_max;
-	u64 ac8_max;
-	u64 ac9_max;
+	struct_group(data,
+		u64 weight;
+		u64 ac0_max;
+		u64 ac1_max;
+		u64 ac2_max;
+		u64 ac3_max;
+		u64 ac4_max;
+		u64 ac5_max;
+		u64 ac6_max;
+		u64 ac7_max;
+		u64 ac8_max;
+		u64 ac9_max;
+	);
 } __packed;
 
 struct trt {
@@ -47,17 +49,19 @@ union art_object {
 	struct {
 		char source_device[8]; /* ACPI single name */
 		char target_device[8]; /* ACPI single name */
-		u64 weight;
-		u64 ac0_max_level;
-		u64 ac1_max_level;
-		u64 ac2_max_level;
-		u64 ac3_max_level;
-		u64 ac4_max_level;
-		u64 ac5_max_level;
-		u64 ac6_max_level;
-		u64 ac7_max_level;
-		u64 ac8_max_level;
-		u64 ac9_max_level;
+		struct_group(data,
+			u64 weight;
+			u64 ac0_max_level;
+			u64 ac1_max_level;
+			u64 ac2_max_level;
+			u64 ac3_max_level;
+			u64 ac4_max_level;
+			u64 ac5_max_level;
+			u64 ac6_max_level;
+			u64 ac7_max_level;
+			u64 ac8_max_level;
+			u64 ac9_max_level;
+		);
 	};
 	u64 __data[ACPI_NR_ART_ELEMENTS];
 };
-- 
2.30.2

