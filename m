Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5984B8DDD
	for <lists+linux-pm@lfdr.de>; Wed, 16 Feb 2022 17:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiBPQXx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Feb 2022 11:23:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiBPQXu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Feb 2022 11:23:50 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C830522218B
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 08:23:37 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f37so4788947lfv.8
        for <linux-pm@vger.kernel.org>; Wed, 16 Feb 2022 08:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzBX1lIAVYZwdECaRMhi8WBrfRP47BlcmzYMUdivK5U=;
        b=keZIpHeTvTHtXJK9/pje+DNhUxw0b6g+PN/54W4qKYTwwl6ZJRBqCLk+Ha4D0P3YDk
         keJ+8z+bB0sqMQSQ+0zNF7slV8OZcHf4s6wxH6qzHd5ASQOvrX3XUVvMB5dMNUJyXziA
         8/qqX1s8UTd9azWkIx/zpio+3RTiTuBAiMGwosSvP/wcs5847OmkKHy14EwFN48ryB4E
         64rDmMsiuaio/5wVmJJO7FDtXkrk0wMmgMQLSMJE6V5mTwghA43jQn2/N9MJmmr83Owl
         k1WO7Sozach4DT+6Rqd7bja50HPUyDDTciIU1+cfATD2c66XAcqk/wl4ZwMA8SPq27OV
         hQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzBX1lIAVYZwdECaRMhi8WBrfRP47BlcmzYMUdivK5U=;
        b=4cn8IbkAQ7EZcFSi4q3QmgL6JpnZxZIEf32TXsWhnWp7EKI2zktprSbLXMTgXPbfa4
         RAQdNxktbekqrNQaR6N3uyrgQ84jtGtwAoYzak387Z3k+GMjQgbHUM3Tmmjw5FzrhWVL
         +mgjpgWhQrUwzYG4sWj1pbVWxaO4jW2pdXEDUO0IfbQt+D5m/k/c8UcUP0+O3fn1P6ky
         S8nrM2x8BldBaf5NZb8EYQjI8fXz25T/ey/yTOEiCiOevZDztuAT/tS3xZgvFjKwgPSe
         AXFfQRJCkQYcrFSHnMYaKRV4NpydXPFW2Pwh2rmNaNYRkz0/Psbrs30WF9qyp9gnUNrv
         2Ujw==
X-Gm-Message-State: AOAM531XWxP27yADDta9DXuNxiRLhoLBhGvTFmwlhoKoqerGaex1ijAi
        gfVtEJuFUcCd8tXVud8ZuaPH+iS+gQ5qOehhNbiOrQ==
X-Google-Smtp-Source: ABdhPJyUuQz4Diml1VJhvSdyugYzUWtSBf05c5HD9+nNLuAQ4WtatF+oZKRsz3jYwQcAMJd0SuaAXICsTz85sxLyZxc=
X-Received: by 2002:a19:9144:0:b0:43b:86a4:1497 with SMTP id
 y4-20020a199144000000b0043b86a41497mr2576104lfj.254.1645028615997; Wed, 16
 Feb 2022 08:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20220130210210.549877-1-daniel.lezcano@linaro.org> <20220130210210.549877-3-daniel.lezcano@linaro.org>
In-Reply-To: <20220130210210.549877-3-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Feb 2022 17:22:59 +0100
Message-ID: <CAPDyKFqV++g63Asax8TNSEgujxJ=uM9XG2_Advu34JidYBCGtg@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] powercap/dtpm: Fixup kfree for virtual node
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> When the node is virtual there is no release function associated which
> can free the memory.
>
> Free the memory when no 'ops' exists.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/dtpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index 0b0121c37a1b..7bddd25a6767 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -181,12 +181,12 @@ int dtpm_release_zone(struct powercap_zone *pcz)
>
>         if (dtpm->ops)
>                 dtpm->ops->release(dtpm);
> +       else
> +               kfree(dtpm);
>

This doesn't look correct. Below you check dtpm against "root", which
may be after its memory has been freed.

If the ->release() function should be responsible for freeing the
dtpm, it needs to be called after the check below.

>         if (root == dtpm)
>                 root = NULL;
>
> -       kfree(dtpm);
> -
>         return 0;
>  }
>

Kind regards
Uffe
