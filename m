Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D54E3B9886
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 00:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbhGAWRX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 18:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbhGAWRX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 18:17:23 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC06C061762
        for <linux-pm@vger.kernel.org>; Thu,  1 Jul 2021 15:14:52 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id g3so7484571iok.12
        for <linux-pm@vger.kernel.org>; Thu, 01 Jul 2021 15:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AayNT7A4/UnyEHfo4sSIDGrVOluBbwc8WD1fZL87evI=;
        b=PrJubOsb46hL0tcVQQIqZh00dYjP1FfLOARJ52Ri9A5NMUpdzJ4DBhrHoTLJfIq3gD
         rPcGwOFXU/N6xiWbfKBC5Yzo5FqearbiZAqxzaRkxkpmi5r022ecpXpy+zYrCD1z/sJ7
         ImRaJ1nW3zl7Zn/ZjKHsdrs2Zihpxl/MD1kmN3Jjc2Jr+OM8UYooi3rVpG6xecH2WYWA
         UOkii/Be5U39vUwVlOvF8oPXRusbO/r21Cv8eoaL/43u9RAHIWKvZGvl/XsWnTsBosU3
         jh7/F62tD3+xL4QQEccnEys1huICQb+cRpPIPOC7LZ102CTK3t7/QYHbC2pzI3+x89vi
         1YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AayNT7A4/UnyEHfo4sSIDGrVOluBbwc8WD1fZL87evI=;
        b=SbSs8XQZP/TbrcytW5j3HMKCcjCffrCN/L3+UyntPTQecUWFxtlzBQn5owp2ATMJ7K
         2Y0kqAEwv/+5C0jgGtYxpW1zMVg4a3Di+tZ9YbXsmfVu7ktn2GrMubGRLo2nlTEljGIS
         9+aVrcvwEJqCBIQDHoJCeT2B5ihJmgd/PZXOQGf8I9iy5lTxzjAYiK9edOhM1yr6xynS
         2b7qfBQT9igJzImOr9qI4DtRExpvcjT5ubFR82Vuu8jaasj/ATdzmS+3xWlZERtPdCIH
         PelQeYWT6Vbx/ymQ9n7szummk78OrO17ltVxsVBCy7j8iD726b2FH1Jap4dGrXx1D9DC
         BqYw==
X-Gm-Message-State: AOAM53368gcn248UlWreFPidWOetjONxCgz034L8HQiEgTcBKlqgUJpU
        sXGJQ64REoKxjOhpOi0jhUeGjBF9L91XF3uCbN6u2PnMrEs=
X-Google-Smtp-Source: ABdhPJxsm/fY9mV5MSiu/22x8aKZ0CzNINfrlZzyy+7xtp+/GhNcw4mmaVwsuTQy5MmE5eC+KxudVsJXmXdhTQWCqio=
X-Received: by 2002:a02:a114:: with SMTP id f20mr1710653jag.60.1625177691648;
 Thu, 01 Jul 2021 15:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210701220516.2738398-1-pbrobinson@gmail.com>
In-Reply-To: <20210701220516.2738398-1-pbrobinson@gmail.com>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Fri, 2 Jul 2021 00:14:40 +0200
Message-ID: <CABxcv=mHGeSHNo=eeA0cBpL+3s2Kx2nUrrJ+-xOqBx=ORza0yg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: cw2015: use dev_err_probe to allow
 deferred probe
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     Tobias Schrammm <t.schramm@manjaro.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 2, 2021 at 12:07 AM Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Deal with deferred probe using dev_err_probe so the error is handled
> and avoid logging lots probe defer information like the following:
>
> [    9.125121] cw2015 4-0062: Failed to register power supply
> [    9.211131] cw2015 4-0062: Failed to register power supply
>
> Fixes: b4c7715c10c1 ("power: supply: add CellWise cw2015 fuel gauge driver")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---

Right, I also found this error message annoying and agree that's too noisy.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
