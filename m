Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B07E304842
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 20:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbhAZFqx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 00:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbhAYJPX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 04:15:23 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB27C06121C
        for <linux-pm@vger.kernel.org>; Mon, 25 Jan 2021 00:44:54 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i9so3439791wmq.1
        for <linux-pm@vger.kernel.org>; Mon, 25 Jan 2021 00:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IFHl3bl4OZPJd0JoqwGAwIlNY7YxXKKQkfzZqr2Pg80=;
        b=Ri1hXGuDzteU5OZGSXFpK4YybGw/wAHghQohkPBQQzxC8vg7LHhN0VPfV3WU5H8zD4
         5VdkSpc/1R9/2yfniMDa550PfTZMRY47g6s8luxhlsgfce/1VVaJyLJpeO+LOL97nJHj
         qitCcNSk2Jxr1z6mwFRMO/clgXYiRaiAFhyOl53yutU+4bsIF+WJIwR+qHJh156wr0GA
         iayr0RBAEY04LpcdG1Jw7pj66lWVe0RwFKdd+euM3WYsKj12WG8f+LGD8EsibHzomv4O
         T2t07mBMKAmxOZuLD8QdAj0/B3vEqr+K/Ip93TmBoD5exDE/T1+itiqGZAwXSiFQLcyE
         iZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IFHl3bl4OZPJd0JoqwGAwIlNY7YxXKKQkfzZqr2Pg80=;
        b=VTZrVCvwsrnZVDU0QFMiDvWFYJrS5G6yEGFiFTOCeJ8FWgla3Y6s/nkNm0zpO/wxlg
         oQaF9NciFLukwHEaoGTv3JTL9GMbgmthphHnL0zZ1V6/PXI4D3OaApxI4lnwFmWTrc1Y
         0q9ypK/0K0wJBKXKVs38UpzW3DTQJ86mjUMv6cznDhWjWhddyU4Y5yR3zrVrcBOr7a2A
         kajInorUtQrwYsB3Pc/hEWtDM4XF5QSgGWbcnur08vsOzCmr9wZo+t22c1GDgzP91bYs
         l7scXJ0KrHZgUNrOwTUq/Urn8VA2rWhKEKAe7S6MKwuxauosSWfFHyODxGEc2ywj1jUs
         lliA==
X-Gm-Message-State: AOAM5339JaEa3PDzFEDuwVlZwvyqnib/NSLbtgK0lfEahBzf6dDqlETv
        IimODiiz7Gv+yLbZB7gU+t+zsg==
X-Google-Smtp-Source: ABdhPJyFN5c/c6on04JHgiLXHPb9pHibi+YHGz3T4vhcHbVRUzR7zzOs94GoI04aeloeiIXl4eyiIw==
X-Received: by 2002:a1c:e1d4:: with SMTP id y203mr1205877wmg.50.1611564293197;
        Mon, 25 Jan 2021 00:44:53 -0800 (PST)
Received: from dell ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id z4sm966388wrw.38.2021.01.25.00.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 00:44:52 -0800 (PST)
Date:   Mon, 25 Jan 2021 08:44:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 04/10] power: supply: ab8500: Push data to power supply
 code
Message-ID: <20210125084451.GV4903@dell>
References: <20210123221908.2993388-1-linus.walleij@linaro.org>
 <20210123221908.2993388-5-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210123221908.2993388-5-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 23 Jan 2021, Linus Walleij wrote:

> There is a slew of defines, structs and enums and even a
> function call only relevant for the charging code that
> still lives in <linux/mfd/abx500.h>. Push it down to the
> "ab8500-bm.h" header in the power supply subsystem where
> it is actually used.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/power/supply/ab8500-bm.h | 278 ++++++++++++++++++++++++++++++-
>  include/linux/mfd/abx500.h       | 276 ------------------------------
>  2 files changed, 274 insertions(+), 280 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
