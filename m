Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614BF4279D6
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244772AbhJIL6a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhJIL63 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:58:29 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4872C061570;
        Sat,  9 Oct 2021 04:56:32 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a8so469596ilj.10;
        Sat, 09 Oct 2021 04:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6PCq4Gkwis4c8eZUmnooNUV0Fha5o7at5yue5VuXyw=;
        b=QgdFWFo1g0PqlHU63O21/eE9FGdPfLdFEg29CNlBHA48d3imgR6Z3tqHE26IOqso+h
         Bol8ewmawHSuZjZ90m467THrsq9FuZLVTqwBUHzxzgwx4vmTjxd0Mv2lvNv/mHRo8R1O
         JS+/IHyWmFdQ+gV/shGqzlVG9jePsy1lYtGv4Saq8Z/IkcVPB4++RYxsSUTEMiWRAD8V
         iHRpyduEloukYiEU1jW75etRDn1IN7DFFabDCsXZwIEE3tyevIjO74NY+YZqf4p8tPdl
         FRXi5PLQ21EdLP2Um//n+BWLTL728rB7njeS5ncXd+5L4zOB2QOwRYMd0QTruRD/Khb7
         hz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6PCq4Gkwis4c8eZUmnooNUV0Fha5o7at5yue5VuXyw=;
        b=aI4dDig/oc9fxZjvSNYtaVngwqrrPd3TJmMjthwFtL/LiowX0nOjgTNXubuEQFFEwx
         Du/hHp3+xNhGZBr50Sm5jgW4sHyIhVwIS3tFn1y172IZXW8U/DT2xCsgbRf7P2Yz2ozC
         vP5etQLdB6cuau6aBJqxvVwmFCcwEhUBGR32NLAHxPK+KI0eSG7+iIAbni79XQNNJm3R
         aEhHj+B1Of+nNt3RKZHTNmeFicRcpYRO+LVy29ECtwlus1kAyYfInmXU7xGau3hwD/II
         DjdbNtV78DlGLTL/zcLbMbKw35rBk0q8JECDMCbGMYsmXg6ddL5zWMs+KCDG/EG66QbH
         qybg==
X-Gm-Message-State: AOAM531hINS7qudfzYUmz31UAZEXxzoF+2C7HZDxENFb6zLq7Dqq/pxU
        pRGvvvwGMH1o0LBo/35U2Y+aqCpClahIGkQDF9Y=
X-Google-Smtp-Source: ABdhPJw+WU+NHf/iZf8YrI5iEi5wtr8YQ3p2j5/7QrYzBGo0kuuhuIiAF0LRnqsLO530CKI2vwusyZr/U3HSx6nYrhk=
X-Received: by 2002:a05:6e02:1402:: with SMTP id n2mr11501309ilo.208.1633780592446;
 Sat, 09 Oct 2021 04:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211009115031.18392-1-alistair@alistair23.me> <20211009115031.18392-6-alistair@alistair23.me>
In-Reply-To: <20211009115031.18392-6-alistair@alistair23.me>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sat, 9 Oct 2021 21:56:06 +1000
Message-ID: <CAKmqyKO-6jByG0DL5g7A84aK8yCMygqmnehnG4_X-TicfgrLLw@mail.gmail.com>
Subject: Re: [PATCH 4/7] capsules: sha: Continue reducing code size
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, amitk@kernel.org,
        rui.zhang@intel.com, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pm@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 9, 2021 at 9:51 PM Alistair Francis <alistair@alistair23.me> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sorry, I wrongly copied this patch. Just ignore this patch

Alistair
