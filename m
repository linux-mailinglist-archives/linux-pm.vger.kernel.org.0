Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 737BC177222
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 10:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgCCJOv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 04:14:51 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39970 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgCCJOv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 04:14:51 -0500
Received: by mail-vk1-f194.google.com with SMTP id c129so667178vkh.7
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 01:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82sNWGjFmkVLBw+FxrgCKF+vSCptDwYcsAW/FKpfGeQ=;
        b=jia5Icuk9eDsQK/O3bwyskMqnRE3YCqTgyeT5XMkVrG1a25bC9c7C8VvHR22iePtAx
         j10IwItrOGzWdVSN0DSbc3I1+IBdzVU60++A3ycgxyfIRyEyxS+XK9uuRJASMOm9eN1O
         XoFjYL+S2T6BhwactfaUfYl3oUkHe/byjavsEWBySp/nf6yKB5JFLIH9DXvyzvO46Z2u
         /wgbLcBQxZRQ+NEXftCiugNjGGaCBmsDL4qRfiixZ1Q1W3VMP7/dcDJgUJDoMF/nvwRv
         jB9xXMaTj4FooiW193xrCbIFDSOmt44NXW/aiWDpX1g9Y63AcqWvxftXtA18GGTfIbAa
         NbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82sNWGjFmkVLBw+FxrgCKF+vSCptDwYcsAW/FKpfGeQ=;
        b=c4vnKN7PCcgRy5WzGqBZ8VRPcUSU1JY/0U82gn3YCV6Ouu9d5Ikfhf1o2MY/Q1rsDZ
         yQTo/SXjpXswM4pp2sAIgct207OHkCbGZsQ8UC3iP6/piv5Lo+UecikPOd1OSGMogr/F
         AkCtaB05ieX1eS2ecSq/opRG/Sul63OiBVTzkOzDUzPvsSILz56odLB02vD7R3S5QFzc
         EznjMO9u1zEMqvT8t9pRTcVE9lr73K9YSdVqSbGInsrO11VG13naT60fSvW53mCPONEr
         /8gIAdbGKYGIWx4MwrrGISCshEerxpp0y9jauLs0XmGZxfy+onLHwwmLGDkSPTil/RCT
         J2CA==
X-Gm-Message-State: ANhLgQ2s2g/zuCPERaQS0mZjeiyzq9XdQfgAgvGqIIlDx4cnWluqi7eG
        5yIoc/O3pR/oeAp7E5qb9ClWShwaFhk0+YrGRsrU+Q==
X-Google-Smtp-Source: ADFU+vuzgnySETrv7JCPPbmi1t5WTcKrvGy3yJyLc0ysG69xum0gJOPpsbo1HvAzy8C6M8p0dZ+ff1IsbctcsiCKomM=
X-Received: by 2002:ac5:c7a9:: with SMTP id d9mr2310909vkn.79.1583226888730;
 Tue, 03 Mar 2020 01:14:48 -0800 (PST)
MIME-Version: 1.0
References: <1583222684-10229-1-git-send-email-Anson.Huang@nxp.com> <1583222684-10229-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1583222684-10229-2-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 3 Mar 2020 14:44:38 +0530
Message-ID: <CAHLCerNLQ11UR8AW2DcKC+9rh39KPWJG2uRiWGuwbFbyqPH72Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: Remove COMPILE_TEST for IMX_SC_THERMAL
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

On Tue, Mar 3, 2020 at 1:40 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> i.MX SCU thermal driver depends on IMX_SCU which does NOT have
> COMPILE_TEST enabled, so need to remove COMPILE_TEST for i.MX
> SCU thermal as well.

Wouldn't a better solution be to add COMPILE_TEST to IMX_SCU to
improve compile coverage?

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 165b7d6..4fb87df 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -253,7 +253,7 @@ config IMX_THERMAL
>
>  config IMX_SC_THERMAL
>         tristate "Temperature sensor driver for NXP i.MX SoCs with System Controller"
> -       depends on IMX_SCU || COMPILE_TEST
> +       depends on IMX_SCU
>         depends on OF
>         help
>           Support for Temperature Monitor (TEMPMON) found on NXP i.MX SoCs with
> --
> 2.7.4
>
