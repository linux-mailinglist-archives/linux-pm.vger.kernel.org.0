Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CEB48BBF9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jan 2022 01:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347359AbiALAmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jan 2022 19:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347316AbiALAmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jan 2022 19:42:18 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BBEC061748
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 16:42:18 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso758044otj.8
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 16:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuLiyWvOKCNFHRzc7SJEufnmfQWRRouNshUT1JlfJ7U=;
        b=XoTI7sR5YkrKP0/NNOqYf8pOBuqhdkwarPDPgSPCCAUHq6zUjJzc3DOJDzusa6QIzO
         yPZ9ZVmJFQFKetvwV7ZWkkbvYtRXfYX5nvoQZ9u4/3V+QGWiG40EiH1cICJmBJkyDPJX
         saAho07b48FH9U2ncbrnwX4dsvYetNonIxFTP5/VRLsYMjQ72Bzai6NdvsYE2kRbHXpq
         UITtpZC+VQcnSJbL8eH73ddx97cJ3GqSrxi9nWGSMyoBeMuqWdmap7+jZczNPr8Kfz57
         5FGAM3qSkNicdfrCJzdzX8Zz8Y7Wms7IfCqOMPqAM6v7OCEYk904DZp+A/OoxMhjTmJj
         rvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuLiyWvOKCNFHRzc7SJEufnmfQWRRouNshUT1JlfJ7U=;
        b=XRrONNSL8Nayn1ETOHeSB3A93E2keYnS/mXNWyg3Mu9G/8eL3rWh0EgqI351j/Dz0Z
         noh2OCeEX7XlmOaEIrKjP5/tzAZ4h9JCLovq7TceGP09KD9J5J6oJ5i+oxxK89tJkeSO
         lPsR+eNHzyQUM5qb3qrv/o/Nxn1XNS45cnn22olE9nKZ1P6FvICXyHInhVfpfGW9+7aK
         jycs8Q8vc8kwA+ySJQp/y+2nV1mZiSrkWHtzGPgJIFiT99pvGPcjuK1glDBkjdJ4cHCF
         dz0bAmjeI6VNd/I0u//Q0bMnvG7LsngAtNlWX7mEqhTWMgSTjd4Gg+4f4Os33i35yAqh
         Io4w==
X-Gm-Message-State: AOAM533LPTI1bIbA+xxuP2Byse0Q5I8xImUICul2S7pZWMojDJ1xLhos
        AoRc6ZC9dwoYoaNm+VLfChlVP0Mtnn/GkEq0Mzv6+w==
X-Google-Smtp-Source: ABdhPJyRua3x8hGIFEnkS6VGhkf9ddNtgUUB/HL1p9RdfA7g0IHb/yI28TavFsuaWNvTtxfLQbintksNl5BueuZsv5w=
X-Received: by 2002:a9d:465:: with SMTP id 92mr4915625otc.35.1641948137630;
 Tue, 11 Jan 2022 16:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20220105023700.10966-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220105023700.10966-1-yang.lee@linux.alibaba.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jan 2022 01:42:05 +0100
Message-ID: <CACRpkdYvdbR+2Ehwxm9z280gBSmztmjj_eN_zakEbRHEbw9pWg@mail.gmail.com>
Subject: Re: [PATCH -next] power: supply_core: fix application of sizeof to pointer
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     t.schramm@manjaro.org, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 5, 2022 at 3:37 AM Yang Li <yang.lee@linux.alibaba.com> wrote:

> The coccinelle check report:
> ./drivers/power/supply/cw2015_battery.c:692:12-18: ERROR: application of
> sizeof to pointer
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 25fd330370ac ("power: supply_core: Pass pointer to battery info")
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for finding this!

Yours,
Linus Walleij
