Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CE0427AD3
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 16:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhJIObT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 10:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhJIObT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 10:31:19 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2EEC061570;
        Sat,  9 Oct 2021 07:29:22 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id x207so5441738vke.2;
        Sat, 09 Oct 2021 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sx2lHz5mXP4bcDT2BgwdB//veu66amkB+JijBT7hsOA=;
        b=B9JP9C3ga+6gzWGfzDBuGqyRy8gwfpFJpFcLzIQoDTL7vsiw4PSC9Ixja7tJkL3pzc
         Y6JPOkiaeZBzFgpvVa462FFSChn3/wy9AGVyIWqQ0lEKundCdnE+gvbgUfeSyJVMVAmE
         juV+XdbcqfMmrN1BiZ9qj174O9riVbWoatSlopjLzUBg9EJE9W457gQi6qh7QB27nyDX
         mXJ8iDZ/AkfIS+pu2Nza7A/SAHsPuDcBW6AIyrKLSvgmmgFPwDetAF01SBoymYTypg8l
         cd2XH8xqacrNkpI/O93BnmMFTbWXIuNOu9QnyJtoLb6iOvBRo3s69F7HbXG5ZYVJ/vCw
         Gp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sx2lHz5mXP4bcDT2BgwdB//veu66amkB+JijBT7hsOA=;
        b=B92XY9PqnWurs8cwBTcf2cfvhAjQomExNDC0UUYdWJCSUWLtyGM6XnFJDEybQ5HY6w
         T0cHWymv+MsRyj/Gd51lnAI6poE1rseBEC5hIAem3kISJPPBxzDqeiYqsXCMAf6H04v2
         ykEgjjCidCW/ZJBkXMXisXsarZhalzoBWF4iGKw3q+bGmkAupR9x/pbodbNQXJlz2iJk
         Z8Gnm5qfZFoas6TYO8OL/dC1meJLMzSd6qxnrzu4qrYEsj4WcsEEmvj+G0pe4fN6EVTr
         MI4Qj9Emvw4im9ReIWJGpgwAEFvzKWv2MDaqk9JhNP/sMO72c7u6ZH1gKqfRDEhfrZZq
         iuYQ==
X-Gm-Message-State: AOAM530F1lgbU5iUTWew3biUKWxtQV1M8uewFAYqcXMDw7uq69nvrPfY
        0ksqVL+NVrWhPJIaigEqaVCGYyGz4ccbBldK2eQ=
X-Google-Smtp-Source: ABdhPJxT3cIcGEL97+SdND5QDF9fYcKsFCcVZjI0cOaamtZL47rFrh7Xc5BOzF/5AR5KBTa3k7kvXb1ZAYSwp2sCfrY=
X-Received: by 2002:a1f:b417:: with SMTP id d23mr14139390vkf.8.1633789761095;
 Sat, 09 Oct 2021 07:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211009115031.18392-1-alistair@alistair23.me> <20211009115031.18392-13-alistair@alistair23.me>
In-Reply-To: <20211009115031.18392-13-alistair@alistair23.me>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 9 Oct 2021 11:29:10 -0300
Message-ID: <CAOMZO5DK+YSx6iQABFbgR=EKLutRc486GEUeH0o0fYRotmQmXg@mail.gmail.com>
Subject: Re: [PATCH v12 09/10] ARM: imx_v6_v7_defconfig: Enable backlight
 class devices
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, amitk@kernel.org,
        "rui.zhang" <rui.zhang@intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair23@gmail.com>,
        linux-hwmon@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Alistair,

On Sat, Oct 9, 2021 at 8:52 AM Alistair Francis <alistair@alistair23.me> wrote:
>
> The BACKLIGHT_CLASS_DEVICE config is required for the already enabled
> DRM_SIMPLE_PANEL to work so let's enable BACKLIGHT_CLASS_DEVICE.
>
> This allows the mxsfb probe to complete successfully on the reMarkable
> 2.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

With the commit below applied,  CONFIG_BACKLIGHT_CLASS_DEVICE is
automatically selected:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm/configs/imx_v6_v7_defconfig?h=next-20211008&id=c54467482ffd407a4404c990697f432bfcb6cdc4
