Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC9B47DF7E
	for <lists+linux-pm@lfdr.de>; Thu, 23 Dec 2021 08:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346812AbhLWHVx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Dec 2021 02:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbhLWHVw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Dec 2021 02:21:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64481C061401
        for <linux-pm@vger.kernel.org>; Wed, 22 Dec 2021 23:21:52 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so9624684wrw.10
        for <linux-pm@vger.kernel.org>; Wed, 22 Dec 2021 23:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=A3zAhH27VO+OQB/EdZYfdgoVLy6tWAmVfgubJ70foN0=;
        b=coaZvTOfNs9Q+7TM+z4pPBB3i6Gfx0FSsid5ELXz65MvAuyi92ZQvF6kir52chfv/Y
         ytSyHo1QrbPLCuTaejMjaAPNis4F8uZRuR1iN+zjX97EHACrQKphe6lxLPoshj1+taiX
         yPjJ0aKsXjn1xnguRKIzh8XyD08H8c/PomacP0wOub+OI+6vSLazy4y5uYWlWffE0A0R
         IEdbaB6Gf5txsq1bfUUMgj4vciXl/UdxwOfNrjAyiHc+OaLveccIntaYnNM7OVEdtAjs
         f3HWMWtzqQQTEUK1K2cPuUu+krqQmPZsFjMEfvZfAhCO1YwxulPA6JRPXyJNb15xFtQF
         pWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=A3zAhH27VO+OQB/EdZYfdgoVLy6tWAmVfgubJ70foN0=;
        b=M8ADEcegF9Rt2BAn2hvHk3d5moQuXMXvJCSzUVKTSDe6YlUEgTxIsn+yvxUfg1g/z4
         1SQ1aUF1ouX3Wz/RhEb9/Iv0PFuwkWRDw5vLxiDC9wiV86jf3mHStpRkHSuZN9wjHNDL
         ou7x1pQ1oeBHjyoGNYRcyqaM3wqpXL/SINaXp/ic0/RwGJM2Sk+tKZcNOdrPsqa8TUwd
         O8dyPzxU/LpXJTGA49zHKmVVLNfmcq7C+zdQkTv4DJz4+KEOqc7bMLa6vpV0N2m2i1Il
         UL3g00E02ndUkt9RCwmAf3oBF0Wmc9fxm2rVfxsXOd0KM732MJixySZOd2YgVO7taYNt
         E8PQ==
X-Gm-Message-State: AOAM532uYQKsuaLT5HopgLSwe9e0r43fv6B22cWHNGFSrugksJWIuVo4
        LAI9h6dMYCg1jpxxbp8TOW6ptfUJo/8=
X-Google-Smtp-Source: ABdhPJyFp4Bs/nKu6O7k6Ebi15JkhsmJLHDzdIW0tug3ceJM8GTpIV7ldPUucqsBcvNzzozfdgLvgQ==
X-Received: by 2002:adf:da51:: with SMTP id r17mr819397wrl.389.1640244111039;
        Wed, 22 Dec 2021 23:21:51 -0800 (PST)
Received: from ?IPV6:2003:ea:8f24:fd00:91a0:6ae6:f368:5418? (p200300ea8f24fd0091a06ae6f3685418.dip0.t-ipconnect.de. [2003:ea:8f24:fd00:91a0:6ae6:f368:5418])
        by smtp.googlemail.com with ESMTPSA id b132sm3744178wmd.38.2021.12.22.23.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 23:21:50 -0800 (PST)
Message-ID: <174f49e0-628d-f5e4-2f99-874524fb9f5e@gmail.com>
Date:   Thu, 23 Dec 2021 08:21:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PM: runtime: Annotate pm_runtime_resume_and_get() as
 __must_check
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the error case this function returns w/o the usage counter being
incremented. Not checking the return code will likely result in a
usage counter imbalance in the error case therefore.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/pm_runtime.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index eddd66d42..aa106f5fb 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -384,9 +384,8 @@ static inline int pm_runtime_get(struct device *dev)
  * The possible return values of this function are the same as for
  * pm_runtime_resume() and the runtime PM usage counter of @dev remains
  * incremented in all cases, even if it returns an error code.
- * Consider using pm_runtime_resume_and_get() instead of it, especially
- * if its return value is checked by the caller, as this is likely to result
- * in cleaner code.
+ * Consider using pm_runtime_resume_and_get() instead of it if its return
+ * value is checked by the caller, as this is likely to result in cleaner code.
  */
 static inline int pm_runtime_get_sync(struct device *dev)
 {
@@ -401,7 +400,7 @@ static inline int pm_runtime_get_sync(struct device *dev)
  * PM usage counter. Return 0 if the runtime PM usage counter of @dev has been
  * incremented or a negative error code otherwise.
  */
-static inline int pm_runtime_resume_and_get(struct device *dev)
+static inline __must_check int pm_runtime_resume_and_get(struct device *dev)
 {
 	int ret;
 
-- 
2.34.1

