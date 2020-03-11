Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 568391813D3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 09:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgCKI7p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 04:59:45 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37530 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgCKI7p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 04:59:45 -0400
Received: by mail-ua1-f67.google.com with SMTP id h32so438058uah.4
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2020 01:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+zVi+hAGykkkswrTz5Xe5bLUAkAvEDlo5d1jlqeg9c=;
        b=m2BRj4/txpDGqaCLUmLGEPNi9gS2KHP1x6CM1J5hj1cuQjpCip+JzZvcgyDGMmVpW9
         Zt+mGMMdL/OoureU/WAMi36vaoP4kMHmSX2k1YKKvMlxnMCoyUrag6Wh3neZg9zFI6e3
         1oEJlUQW+TdZ+snNkRLo3uh5i6IjJKph2+ILmxnq07E3q3RLeseohWFo4z9a6FNgiCRZ
         WEMA/xyfjjZJcZexIfANydAAa8f9q49nHTblW/CUcgQp+IM0ocOrcvb42zfwS60W+Asi
         nICga+QT5D5H3EHWwbdMdwAioY7G211/dg6Xv9Thr8DXsxATaskhRtJdsSm/qUd5KaKY
         fm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+zVi+hAGykkkswrTz5Xe5bLUAkAvEDlo5d1jlqeg9c=;
        b=Qjg0huU0SJ7y7Z1g59clPNYE7o8K0Wc3uNbw1dBQ1QY6awrrXFRkm60ESrWkr1w7We
         bjfBefjLLgwmTDZ3E/woLZmknj4afNeRI6+KWlru291uZnbtgOWpa0JoytOXYZ46G85A
         +d3NWaT+t5IEx5QvLh3nhSo2ikTEuW8gRMddE3DHcLQtR0mItlFMtVVw/yecF6XxCByH
         87+lkW9k2SCWAeKbQJwO1d2W0k4B9cSDUVLP+4J4grrx+5igTUgizkIzbWfXP6WgbztO
         sb5pF9+wxUkYrcOpjRf+D/NrOkp61zoV0Vt+XhE7oiGY/7nQ9HnzvPX/LSEd3F2bdxZ5
         b8Lw==
X-Gm-Message-State: ANhLgQ3lmS94Q5/1rHEhFY1WBQekROfRnaU2CcT0IBZ0QwRQQ9CSpIjT
        YY25da4ew3gm569ekrPgn9E7MVS/tMIFsks27IVQlQ==
X-Google-Smtp-Source: ADFU+vtvvedKlu0toUhUkrGSFTRN8Mq11WHrNu2FyqKg7H0jG7F1Sfs4pw5wcYf+d+IIrZAT5cIZ5p8de2pmfQPMytg=
X-Received: by 2002:ab0:1849:: with SMTP id j9mr928295uag.77.1583917183825;
 Wed, 11 Mar 2020 01:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 11 Mar 2020 14:29:32 +0530
Message-ID: <CAHLCerNQSrNdmPbgLLiTN9_kE-x4xTnBWVnC0-ewQfferG+6Bg@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: qoriq: Use devm_add_action_or_reset() to
 handle all cleanups
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 11, 2020 at 10:44 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Use devm_add_action_or_reset() to handle all cleanups of failure in
> .probe and .remove, then .remove callback can be dropped.


Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/qoriq_thermal.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 874bc46..67a8d84 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -228,6 +228,14 @@ static const struct regmap_access_table qoriq_rd_table = {
>         .n_yes_ranges   = ARRAY_SIZE(qoriq_yes_ranges),
>  };
>
> +static void qoriq_tmu_action(void *p)
> +{
> +       struct qoriq_tmu_data *data = p;
> +
> +       regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
> +       clk_disable_unprepare(data->clk);
> +}
> +
>  static int qoriq_tmu_probe(struct platform_device *pdev)
>  {
>         int ret;
> @@ -278,6 +286,10 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       ret = devm_add_action_or_reset(dev, qoriq_tmu_action, data);
> +       if (ret)
> +               return ret;
> +
>         /* version register offset at: 0xbf8 on both v1 and v2 */
>         ret = regmap_read(data->regmap, REGS_IPBRR(0), &ver);
>         if (ret) {
> @@ -290,35 +302,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>
>         ret = qoriq_tmu_calibration(dev, data); /* TMU calibration */
>         if (ret < 0)
> -               goto err;
> +               return ret;
>
>         ret = qoriq_tmu_register_tmu_zone(dev, data);
>         if (ret < 0) {
>                 dev_err(dev, "Failed to register sensors\n");
> -               ret = -ENODEV;
> -               goto err;
> +               return ret;
>         }
>
>         platform_set_drvdata(pdev, data);
>
>         return 0;
> -
> -err:
> -       clk_disable_unprepare(data->clk);
> -
> -       return ret;
> -}
> -
> -static int qoriq_tmu_remove(struct platform_device *pdev)
> -{
> -       struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
> -
> -       /* Disable monitoring */
> -       regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
> -
> -       clk_disable_unprepare(data->clk);
> -
> -       return 0;
>  }
>
>  static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
> @@ -365,7 +359,6 @@ static struct platform_driver qoriq_tmu = {
>                 .of_match_table = qoriq_tmu_match,
>         },
>         .probe  = qoriq_tmu_probe,
> -       .remove = qoriq_tmu_remove,
>  };
>  module_platform_driver(qoriq_tmu);
>
> --
> 2.7.4
>
