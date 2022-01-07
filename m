Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97861487149
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jan 2022 04:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344988AbiAGDhc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jan 2022 22:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiAGDhb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jan 2022 22:37:31 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD442C061245
        for <linux-pm@vger.kernel.org>; Thu,  6 Jan 2022 19:37:31 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id y130so13135339ybe.8
        for <linux-pm@vger.kernel.org>; Thu, 06 Jan 2022 19:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TJScsJgLlb+h2d3wmK3Z0ci2bKmxWyHWQlqMGS2kOY8=;
        b=Lp54CyALGhwftB2WmYBXkAYjLyvJpBfNEitKqrCQ8DY6XI0GRxd9gaZpXBQgmk3Dce
         jzyz2xz6yoVvRUHCv9FKIggv8ZZm0dKtDAKewH0aAs+GucOWNhkv7JWhBeRPSXaYsSNI
         l1r6bG3hzx7SnEwdOa3qKFpuFidzyPfSxT461R1mgd4LOxwayHa0jaC5CZ7kr/RtJnrc
         47JT5XWMmgcj5MF+J9N7Y4EwP3E07ouwN+9K1JaPYnKLmdXJp1JBl3hCXvDMt1Be2qBe
         bXRogRNmgsWd20Usk8HqaW0ugKd9KP8XL2susPekNFhcxwWHygbBZF/Sfn8mJFhr3aaF
         PgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TJScsJgLlb+h2d3wmK3Z0ci2bKmxWyHWQlqMGS2kOY8=;
        b=j/vbEQZpacUZedf+fwVNkNz1Jy6E7IivFmnM2TIPYx7PxUj1o5n1HXqpd9CZ7+mbb3
         bNPclEVxHuuAJO9opnlxvxd4TnvAjxerPXcjfXPhRWFs+K4r7LaciHRXa8pGo3800lp0
         6JtFcKU3I2mu4GiiAQtbVAISQDs5FRbeYjItuBnMEfBlNaV4CBA/9mgMgTjj/KL0WR8j
         QB0UgsejdtsNyXB4DXjXyYVhagdMEK9VhxFE69s29TLHEcWve1u+ToHNO1zMASJn+5DV
         gFoWWz+SH05KYwFDJsbIelUmwJVNjH3TDlqUG+ccXGBMlpVomL88H/RqB10oLSx26YEX
         TYHw==
X-Gm-Message-State: AOAM533J3ahdJAKIhEvwGYVtnqa5Az9V3mgS/8K5QpXxRlZxlLbyeVew
        PQsSMvEQgjyhS0oog5AYPE97QaRSIhB4QTuQ94BfgA==
X-Google-Smtp-Source: ABdhPJwroRpn2prKqVnayvhj5dqrHi0nukjrsG1C8Ff0xzUg2EBFaOj1O5AttXGVwRHC8xw20CVTgQ2/IY6p0hH/l04=
X-Received: by 2002:a25:f403:: with SMTP id q3mr80213005ybd.606.1641526650722;
 Thu, 06 Jan 2022 19:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20220104122500.338870-1-wjack@google.com>
In-Reply-To: <20220104122500.338870-1-wjack@google.com>
From:   Jack Wu <wjack@google.com>
Date:   Fri, 7 Jan 2022 11:37:19 +0800
Message-ID: <CAHnoD8CtN6QMUDnd+A+WqG__CL0njSqYvgCu0oKTiieQGaE88g@mail.gmail.com>
Subject: Re: [PATCH v1] power: supply: add dock type
To:     Sebastian Reichel <sre@kernel.org>
Cc:     kernel-team@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, AleX Pelosi <apelosi@google.com>,
        Vincent Wang <vincentwang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Alex and Vincent

Jack Wu <wjack@google.com> =E6=96=BC 2022=E5=B9=B41=E6=9C=884=E6=97=A5 =E9=
=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:25=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add dock power_supply_type for the drivers which supports dock can
> register a power supply class device with POWER_SUPPLY_TYPE_DOCK.
>
> Signed-off-by: Jack Wu <wjack@google.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 2 +-
>  drivers/power/supply/power_supply_sysfs.c   | 1 +
>  include/linux/power_supply.h                | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index f7904efc4cfa..854299a0d36f 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -34,7 +34,7 @@ Description:
>                 Describes the main type of the supply.
>
>                 Access: Read
> -               Valid values: "Battery", "UPS", "Mains", "USB", "Wireless=
"
> +               Valid values: "Battery", "UPS", "Mains", "USB", "Wireless=
", "Dock"
>
>  **Battery and USB properties**
>
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index c3d7cbcd4fad..53494b56bbb4 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -57,6 +57,7 @@ static const char * const POWER_SUPPLY_TYPE_TEXT[] =3D =
{
>         [POWER_SUPPLY_TYPE_USB_PD_DRP]          =3D "USB_PD_DRP",
>         [POWER_SUPPLY_TYPE_APPLE_BRICK_ID]      =3D "BrickID",
>         [POWER_SUPPLY_TYPE_WIRELESS]            =3D "Wireless",
> +       [POWER_SUPPLY_TYPE_DOCK]                =3D "Dock",
>  };
>
>  static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] =3D {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 9ca1f120a211..fa80eaa54242 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -187,6 +187,7 @@ enum power_supply_type {
>         POWER_SUPPLY_TYPE_USB_PD_DRP,           /* PD Dual Role Port */
>         POWER_SUPPLY_TYPE_APPLE_BRICK_ID,       /* Apple Charging Method =
*/
>         POWER_SUPPLY_TYPE_WIRELESS,             /* Wireless */
> +       POWER_SUPPLY_TYPE_DOCK,                 /* Dock Charging */
>  };
>
>  enum power_supply_usb_type {
> --
> 2.34.1.448.ga2b2bfdf31-goog
>
