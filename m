Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72DB618AED1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 09:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCSIy6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 04:54:58 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37533 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgCSIy6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 04:54:58 -0400
Received: by mail-vs1-f67.google.com with SMTP id o3so1073830vsd.4
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZy6E89ucoA1w97qJwvQQ5sgoUaCDGfmKMbJv5XOI10=;
        b=XK/XCnLJJNQVJAFR9LEOpSM1poFBblp65fCGQDIRaF29of9VD4V1LOFmYaU5OEB+jt
         w/+kared86CnwkNFscot3nEdyn0KBKBtEqJA07CHwRa/sLrSLIvW6oKScdiU2o/IUd7Y
         D5g59E+R26xAa2a3oeh0tKhlxgLpRTh/1Gyx/ldySrv8h1VZ4Vq2e94mz5Q3gbe0hwz1
         c/a1ZeuIPtygCbOC11Wu4hzhneZ47WX+/hU076c7+ax4UWRzlcVOaeDO3Yug1e35sOEg
         nD425AlVpFB9bTvkKy3TJ0vAYR0hkHr+psjykByec+XQVmlI+81xcwDMR5Qw/2LqVP+z
         sfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZy6E89ucoA1w97qJwvQQ5sgoUaCDGfmKMbJv5XOI10=;
        b=K2Qs6ae857E6flMGy70Iek1gco60w3Hc5N2Iti3uLxpceG76rL/F9Y7gtFTulgCNso
         V5CMzSha8uLAWqtaeoIipmZeevUsUQ2cJslj9fUrtTfhYf7uUnIR0KYlz0RdAHHQPLmR
         kueLTN/wVSDhfLScg63zFJ652Of3CSu2AOx18QHZjNcB9SfEVn+mYMr2b5//q4JllOfk
         wrFF9Lr53iQBZz7PKL4mUHzTBvcomtwlxH8RaTKvgjrJC2SNdr4gPnUyeRYQrFXbSvfw
         6Ot/1r353blClBDPi5XfiRWvF1f6CXGm8FlFSlB3o3MmYYgNVGRbsR7JjqlPnRixnGmz
         d/Zg==
X-Gm-Message-State: ANhLgQ0q/YOhcQiGqNjgrtBaU5fdxhf1Z+SOGNpTSZqinbsxpqt2Fc/h
        6pSIOixFf9SK/RrJxHD9jB8L+XDeQTkl/pYcnAQv8g==
X-Google-Smtp-Source: ADFU+vs2DevNYypMycdkzht98FKAILtKLTB3SxtpJh4gYUWybbe0zhjS9orQtRSVxxWOews2rcT+N7y1BY22d3zG1bU=
X-Received: by 2002:a67:69d5:: with SMTP id e204mr1084947vsc.159.1584608095560;
 Thu, 19 Mar 2020 01:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <1584606380-9972-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1584606380-9972-1-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 19 Mar 2020 14:24:44 +0530
Message-ID: <CAHLCerODxv9jAhDPLHSHRVvsmPtBvj2X-CzFcFo1Vc7EZF+9og@mail.gmail.com>
Subject: Re: [PATCH] thermal: imx_sc_thermal: Fix incorrect data type
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 19, 2020 at 2:03 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> The temperature value passed from SCU could be negative value,
> the data type should be signed instead of unsigned.
>
> Fixes: ed0843633fee ("thermal: imx_sc: add i.MX system controller thermal support")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/imx_sc_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> index dbb277a..a8723b1 100644
> --- a/drivers/thermal/imx_sc_thermal.c
> +++ b/drivers/thermal/imx_sc_thermal.c
> @@ -30,8 +30,8 @@ struct req_get_temp {
>  } __packed __aligned(4);
>
>  struct resp_get_temp {
> -       u16 celsius;
> -       u8 tenths;
> +       s16 celsius;
> +       s8 tenths;
>  } __packed __aligned(4);
>
>  struct imx_sc_msg_misc_get_temp {
> --
> 2.7.4
>
