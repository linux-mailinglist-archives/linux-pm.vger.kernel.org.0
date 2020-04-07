Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF5C31A0ACC
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 12:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgDGKId (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 06:08:33 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42277 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGKId (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 06:08:33 -0400
Received: by mail-ua1-f65.google.com with SMTP id m18so1058147uap.9
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2020 03:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F2A6bF5pOwQfH6U6RsbdhYdssLM5VS1H0bjWBJEI5rs=;
        b=1uUD9C0jDUR1wh+FuDGcgIb3d6PIHB2NtGjyM6PYw6RBGSJyDc69ShTjTNZlBa2Urq
         xp78/tif7EIZ626u5vHVQo2YiKDWWnBWDRpKO9NH4sj0P0fzMTZsWK9bOAIHNfxkrN7g
         nTSUg77TDDjoWmpSKgZqOFCOfDr/DgIIT5XrSXRU2waJKwvLU+UH6BNouuGY1SmDQ+bR
         UpXx0mBA6ILboHMR3pRyBbG8KNpJ4/LjhJp2xzcRGw2H//b1gST6JvRvwYmYzKhcFyEy
         L/LF1/EETZqeKBGRjPTEGUQYZCxGvfhA2Bpmaug65oES0DbtpG1tXSO61SDTZedqkbcz
         SP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F2A6bF5pOwQfH6U6RsbdhYdssLM5VS1H0bjWBJEI5rs=;
        b=OuKPBzZTMGcCrlYXg+SoO4GKaYOtaRbd5SSaMYzbW9q9hK4D3Uu/akkxo0LqyzmnLB
         +6eZxMWx8Wxxe7bwA5ABxPpuaKcikaAmQmlvZ0leOwnEyZnHpYlPUhAVAXNq0C1y4qIT
         3BjbjL9a61XNri5zVWzGzIyOr4G8DyAelXNkzyJn0a/OnPrKFlUkj8r/St52bl1Sr5rf
         u8sXEYhHuJBNyiQODT1pyOZDUe95P0ArMhCqmdmP45IJIWTVNRs7qnnSGgnDyYbIsgDA
         oT4WK+d7pFvugSXxLu/Nq34IaH6BpI5AoGKOm3UmQqYj9KqyKPKKzuyeSrSoa1D/kMXt
         HZRQ==
X-Gm-Message-State: AGi0Pua4FJqCxEGIuOdDzzgvcfD4FvgglpQnk5VLsFoYgW5SJC6Xb3Xx
        h+O8JHLwc8Wj0OIc0UNYp7znXHyMx/XwhY0IcP3ckg==
X-Google-Smtp-Source: APiQypLaGVsH6TbjG7WCt6G2mEAMejyONGl+O/A8Q1teowUXy6zgVgOiYzr90B/ArRCQp4PvnoEK0zPMmj9CyxjM+Rs=
X-Received: by 2002:ab0:4e96:: with SMTP id l22mr1138595uah.67.1586254110747;
 Tue, 07 Apr 2020 03:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <1584363301-15858-1-git-send-email-shenyang39@huawei.com> <1584363301-15858-3-git-send-email-shenyang39@huawei.com>
In-Reply-To: <1584363301-15858-3-git-send-email-shenyang39@huawei.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 7 Apr 2020 15:38:19 +0530
Message-ID: <CAHLCerPJGdb8dx_8UMAricfL6LwEW4zYJdg-R11V=ggvZo10vw@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] MAINTAINERS: Add maintainers for kunpeng thermal
To:     Yang Shen <shenyang39@huawei.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 16, 2020 at 6:25 PM Yang Shen <shenyang39@huawei.com> wrote:
>
> Add Yang Shen and Zhou Wang as maintainers for kunpeng thermal
>
> Signed-off-by: Yang Shen <shenyang39@huawei.com>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc1d18c..b7d4af4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7602,6 +7602,13 @@ F:       drivers/crypto/hisilicon/sgl.c
>  F:     drivers/crypto/hisilicon/zip/
>  F:     Documentation/ABI/testing/debugfs-hisi-zip
>
> +HISILICON KUNPENG TSENSOR DRIVER
> +M:     Yang Shen <shenyang39@huawei.com>
> +M:     Zhou Wang <wangzhou1@hisilicon.com>
> +L:     linux-pm@vger.kernel.org
> +S:     Maintained
> +F:     drivers/thermal/kunpeng_thermal.c
> +
>  HMM - Heterogeneous Memory Management
>  M:     J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>  L:     linux-mm@kvack.org
> --
> 2.7.4
>
