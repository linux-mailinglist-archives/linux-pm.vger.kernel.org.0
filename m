Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9646A8417
	for <lists+linux-pm@lfdr.de>; Thu,  2 Mar 2023 15:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCBOYQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Mar 2023 09:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCBOYQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Mar 2023 09:24:16 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38E0193FE
        for <linux-pm@vger.kernel.org>; Thu,  2 Mar 2023 06:24:14 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s26so68114073edw.11
        for <linux-pm@vger.kernel.org>; Thu, 02 Mar 2023 06:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1677767053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+FX2bRnFYB4pwUNOT+bxicT/CBSQOm6gc2j2xz3BnQ=;
        b=mySt6yKzU0MPpjsIOQSpdfsaJYaU4vwgigGhMgO0Rlq0/92t/YM9DmRkeNxagirRcp
         iT+nNZ2RewxnwPpll7uIfD6P5B1zOssp9LmcMs4g9hesKKVuvRlvIXxvp7mPeyrBHkh2
         zMiAh6N95NMozIK5wOmbbL6jJ6ZP5vpWM46hfoUzm/BUsikUpF+CZD4wz6UQXNcj/M4b
         rRziW8AWrS7yO3/jNVSbn8uP9Un/sqQO4L1Sq0Vjux/C9Jtpq5Y+4Vr3eBPd7xtNCuV8
         b7+WCuW2Qk9anZswOk/fSpxBWrSEvuHPbBPBpieju5ccRVDFbxx71gdn32t3t8s2LSjR
         knZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677767053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+FX2bRnFYB4pwUNOT+bxicT/CBSQOm6gc2j2xz3BnQ=;
        b=WHC0i/mIFkbaf9ZisPxtDUnVKFq/EzLMIZwYDiMVRGtpaqjtHfNW+I2MCVkx4CGe4c
         3FD06Y+MXw/sorO2qBcd6tevnKrLipmT8RhH99ukkVLqSdn55UsjakensbTA1Hs3vAzC
         3SMhcGZ2Z3NNusfbIBmAGuyFtqU53stnuwNxVzmBgOC3Ja0DbA/vbENRn06Lm5CTMXFP
         yaWy+EK1qtlZQLAU2ucfEV6QcG5w9/D5zOFZV4Y3EreANP1zoLpf3p9KOgXYCeLVRxau
         w6aceXoe7RhJ4qFSjmRKRxA7+N5D83phLWmQ2GaUtv6I52dldnx4VZxnetaFQgOETgoY
         gL7w==
X-Gm-Message-State: AO0yUKXlLKj35Ov2Ey8FFIH1srLUYTt2rQdE1QtVbHYzU+qW0VMAg4R5
        u/+yZmSkhOY4cb0uKBllB2LLDiv5dZAUevliSSpm3A==
X-Google-Smtp-Source: AK7set8r4j0tq4rowbbxxo8fIvmc+CPTtwUYa80qViAhpkPD9kvq8gLfk9uOHpWXWuK70y+1jlhXp7wFwtrfjeU2zns=
X-Received: by 2002:a17:906:6d55:b0:8f3:9ee9:f1e2 with SMTP id
 a21-20020a1709066d5500b008f39ee9f1e2mr1255982ejt.5.1677767053169; Thu, 02 Mar
 2023 06:24:13 -0800 (PST)
MIME-Version: 1.0
References: <Y/yTacHF8TvAkxdj@kili>
In-Reply-To: <Y/yTacHF8TvAkxdj@kili>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Thu, 2 Mar 2023 15:23:37 +0100
Message-ID: <CAGuA+ooJXL9f5P8ToCyOwYoYA2TG7H4x_H5FMDhAOwqf51FfQg@mail.gmail.com>
Subject: Re: [bug report] thermal/drivers/mediatek: Add the Low Voltage
 Thermal Sensor driver
To:     Dan Carpenter <error27@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 27, 2023 at 12:26=E2=80=AFPM Dan Carpenter <error27@gmail.com> =
wrote:
>
> Hello Balsam CHIHI,
>
> The patch f5f633b18234: "thermal/drivers/mediatek: Add the Low
> Voltage Thermal Sensor driver" from Feb 9, 2023, leads to the
> following Smatch static checker warning:
>
>         drivers/thermal/mediatek/lvts_thermal.c:562 lvts_calibration_init=
()
>         warn: not copying enough bytes for '&lvts_ctrl->calibration[i]' (=
4 vs 2 bytes)
>
> drivers/thermal/mediatek/lvts_thermal.c
>     555 static int lvts_calibration_init(struct device *dev, struct lvts_=
ctrl *lvts_ctrl,
>     556                                         const struct lvts_ctrl_da=
ta *lvts_ctrl_data,
>     557                                         u8 *efuse_calibration)
>     558 {
>     559         int i;
>     560
>     561         for (i =3D 0; i < lvts_ctrl_data->num_lvts_sensor; i++)
> --> 562                 memcpy(&lvts_ctrl->calibration[i],
>     563                        efuse_calibration + lvts_ctrl_data->cal_of=
fset[i], 2);
>                                                                          =
         ^
> This is copying an array of known ints to a u32 array.  It should copy
> sizeof(int) instead of 2.  It only works because the data you're on
> little endian and the data is small.
>
>     564
>     565         return 0;
>     566 }
>
> regards,
> dan carpenter

Hello Dan Carpenter,

Thank you for reporting this bug.
I will create a patch to fix it ASAP.

Best regards,
Balsam
