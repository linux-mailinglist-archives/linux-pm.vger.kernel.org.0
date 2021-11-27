Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F85745FEDE
	for <lists+linux-pm@lfdr.de>; Sat, 27 Nov 2021 14:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351128AbhK0NpQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Nov 2021 08:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhK0NnQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Nov 2021 08:43:16 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3F2C061574
        for <linux-pm@vger.kernel.org>; Sat, 27 Nov 2021 05:40:01 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i12so10388016wmq.4
        for <linux-pm@vger.kernel.org>; Sat, 27 Nov 2021 05:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=2QZn4hTb2ishs/SY0rPb36iwH7LWCOG9bd8lEjPKULc=;
        b=ooeCEuZlyXC2iVvayAQ474nBvF/GoVfzcSibGVcgCNk9kl+9eV45FtWM5YN0Bw6Tj3
         osYGV4smhgtuQ0aExter8rWxInkYQSyBfveK/v55qm8Gz4jFN9iwdYRsmNH0TvYnJe6V
         x0PINnKpa+RxMMnzyTIIRu88Y5wX0z0jDxAkb3Y+mcjjKONYMAYHcjVDZUpwozCkFQ86
         E9CgywqfJfvK/ZE83y8GAEmf/CkGDwv5B1ki+MjGUxCGE/jSEHybI45MnNkZ1JPFjhhl
         EnojfaQAJK3lD8V2SpsQ1e2fXIUioLO6uCy4CbWvCHUmLk5FyCeKvcYQBzxneT9zMl1E
         IXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=2QZn4hTb2ishs/SY0rPb36iwH7LWCOG9bd8lEjPKULc=;
        b=kle2fRKI71+Lo5zJ1Va4eKih1DTcNqh7qqgfyy7SSkwDY+WSY7FwfOhkbEPSGFz+5D
         lju3VDfR/x+5Pkyexl05WaXi6dfil6Y/HI9Hw9W6tw9ouK4Pck+yVBHvCxtRtb7mfuWK
         fAvpL+W3Hy0L4lQerRdZ74ZApWUK0aWyUnD5UB1c5aztyBcNQNQ6qcZOHuNbpn/L0axL
         8PujKVCfmeY+pdEjkEFzhZvuZKEFGX/iKaSi7FU8H/2Q7XvO++ShAKPd7UIwgyyoh6/6
         +yfIsA5yjQG7sE5hf0/m3LG/CB6iNY0FRyvXXEA1lkn+tdewxnwaSSCc2jvCRTj2zD9O
         90Wg==
X-Gm-Message-State: AOAM532aWQ6sadYzju2HoU+ChZfXZF9M2AY0eSGroQnTzuSDEhqE8KMG
        WZTmt18z1XJa8fcaF95+MtivIUfN0wc=
X-Google-Smtp-Source: ABdhPJz8050dfUBTy5yNjoTA6gyKh3arFVOUld8Qe1TH1wOxSIs9ZLWYDrAyJuGGBhEqI/xuSh0umQ==
X-Received: by 2002:a05:600c:104b:: with SMTP id 11mr23382026wmx.54.1638020399751;
        Sat, 27 Nov 2021 05:39:59 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:7df6:9d34:4832:e4f1? (p200300ea8f1a0f007df69d344832e4f1.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:7df6:9d34:4832:e4f1])
        by smtp.googlemail.com with ESMTPSA id g4sm8310188wro.12.2021.11.27.05.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 05:39:59 -0800 (PST)
Message-ID: <4239b61f-f8c5-462f-2951-fbba2dec8b1d@gmail.com>
Date:   Sat, 27 Nov 2021 14:39:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Shixin Liu <liushixin2@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: crypto: stm32: Broken RPM changes should be reverted
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When discussing whether pm_runtime_resume_and_get() should be annotated as
__must_check, I became aware of RPM usage in crypto/stm32.

Following two patches replace usage of pm_runtime_get_sync() with
pm_runtime_resume_and_get() w/o checking the return code.

747bf30fd944 ("crypto: stm32/cryp - Fix PM reference leak on stm32-cryp.c")
1cb3ad701970 ("crypto: stm32/hash - Fix PM reference leak on stm32-hash.c")

This results in RPM usage like the following in stm32_hash_export():

pm_runtime_resume_and_get(hdev->dev);
...
pm_runtime_mark_last_busy(hdev->dev);
pm_runtime_put_autosuspend(hdev->dev);

This is broken. After pm_runtime_resume_and_get() the usage count may be
incremented or not. If not, then the call to pm_runtime_put_autosuspend()
results in exactly the imbalance that the patch claims to fix.

Therefore I think both patches should be reverted, or the return code
of pm_runtime_resume_and_get() has to be checked and properly handled
in the driver logic.
