Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC75115FF7
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 10:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfEGI7I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 04:59:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34786 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfEGI7H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 04:59:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id n68so5752491qka.1
        for <linux-pm@vger.kernel.org>; Tue, 07 May 2019 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3aU3KdevIyzgXbG781UoZs1Bb4vUUWKNcMK076foDGU=;
        b=ON+p2hg7Pm2pamPArQ09UUBPZnXq1MgAYa2Q6ziX4dSU3Ex/qwkdxRfrmyQQKq4fo0
         CzdRAKKzu2/TUUbDJOleTBxNvkUtNAbVv6BJ5B8EVOF6ygVEtUfE2cih/mGrjoausodv
         pBx/sT84pXaXCG5QgM+6SgdQFHkYaLjmPAq9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aU3KdevIyzgXbG781UoZs1Bb4vUUWKNcMK076foDGU=;
        b=Y84p75hJCBT8s9NEQ9OXpfRQtVXRqGQyGDhfjMEGr8se/gdSo9eNcsp9EIJ7cWVUma
         8LyBI3ZSEiGU5HLNHkdtPXZ0lY6valwBmRg9gORDtQ9aZ35gqUvGQjEcvRI8Bd3McdFR
         P47vECvivRlelXWu+g2Naaqvi8XK9OPCa+AFCt0pnsgiHtXagkUAFcC6gAWYgNoVcQkf
         EJp7XdAfr4Tmgk09houWJJWwX4qrm2t/l53C8DVR9m5iCJB4IVsAXInZwGN7TqeCZCMS
         Oi8+k8ravci+ZwzBHoyPJlAq9UyyRazPvvDLEwInyPlCaXOUdyoyWyf/S1A6BoZKudfj
         nybg==
X-Gm-Message-State: APjAAAV1XCKHOmj25+xEGMTh7mb9V1Px7E+brqHK+kyAdASZ4LWSMgJs
        YgLNtlpVMMQWjNSm4iNThJNgs9jO8+pREHsW5dlykw==
X-Google-Smtp-Source: APXvYqwPpaxX5r4wI/jXxlXZQ/vWJkvg48WefXd+ah/jnuQKCFF2bVOLDxZdtW5Aili31vG0ozFXkzpJEG1lt+lr1Mk=
X-Received: by 2002:a05:620a:1641:: with SMTP id c1mr236605qko.103.1557219546010;
 Tue, 07 May 2019 01:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com> <1556793795-25204-7-git-send-email-michael.kao@mediatek.com>
In-Reply-To: <1556793795-25204-7-git-send-email-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 7 May 2019 16:58:40 +0800
Message-ID: <CAJMQK-i6oZ1dTbTXV2_nX+mGfZ7JcafRMKbb81YgPk67Gdbjbg@mail.gmail.com>
Subject: Re: [PATCH 6/8] thermal: mediatek: mt8183: fix bank number settings
To:     "michael.kao" <michael.kao@mediatek.com>
Cc:     fan.chen@mediatek.com, jamesjj.liao@mediatek.com,
        dawei.chien@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 2, 2019 at 10:43 AM michael.kao <michael.kao@mediatek.com> wrote:
>
> From: Michael Kao <michael.kao@mediatek.com>
>
> MT8183_NUM_ZONES should be set to 1
> because MT8183 doesn't have multiple banks.
>
> Fixes: a4ffe6b52d27 ("thermal: mediatek: add support for MT8183")
> Signed-off-by: Michael Kao <Michael.Kao@mediatek.com>
> ---
>  drivers/thermal/mtk_thermal.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 5c07a61..cb41e46 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -216,6 +216,9 @@ enum {
>  /* The total number of temperature sensors in the MT8183 */
>  #define MT8183_NUM_SENSORS     6
>
> +/* The number of banks in the MT8183 */
> +#define MT8183_NUM_ZONES               1
> +
>  /* The number of sensing points per bank */
>  #define MT8183_NUM_SENSORS_PER_ZONE     6
>
> @@ -503,7 +506,7 @@ struct mtk_thermal {
>
>  static const struct mtk_thermal_data mt8183_thermal_data = {
>         .auxadc_channel = MT8183_TEMP_AUXADC_CHANNEL,
> -       .num_banks = MT8183_NUM_SENSORS_PER_ZONE,
> +       .num_banks = MT8183_NUM_ZONES,
>         .num_sensors = MT8183_NUM_SENSORS,
>         .vts_index = mt8183_vts_index,
>         .cali_val = MT8183_CALIBRATION,

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
