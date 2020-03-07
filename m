Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81BE17CAF3
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2020 03:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCGCbL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 21:31:11 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40911 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCGCbK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 21:31:10 -0500
Received: by mail-ua1-f65.google.com with SMTP id t20so1438423uao.7
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2020 18:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9Ya/C98kfpRZg4gkqMvlKooVGFLI5x92xi8P3qorPM=;
        b=ifuIIkzS+6sRYeh9R+L3aZMWngxePK4Ae1v8J8XTPBIzJ4o6wTgmY1C3gLSOmf6N8C
         MIi0O1CXFXA3kIriIUYp8S6VhAaJMTdjcvoSbHxYxZpfUaDpbYgYl0hrthO7jCa++Nnk
         akDN6T8Del1H9aV78YCbmUigBlh5Cmp48bjIK/8KoV6EM3gOkrIEZMzy+MR33nUvPrMe
         rSOqUg7PlD2aY+v5wVmOHrgDnORH6DM8/UiIKctJji/LOPfvXjqgrkkB+oFMNyrAZwjP
         vhaXmDCDC0BULFNNfA6YyFzsAla65DUnN49ac8TCdFWVqMdzelgncvDX/Xb8npJqwYVz
         Ei/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9Ya/C98kfpRZg4gkqMvlKooVGFLI5x92xi8P3qorPM=;
        b=MSw6ApfcVaVdw88GJ+iVZTPLef3P7tIZ+ymvu2XfqLffntN3S74+8iwF8UjQec6A8N
         GfuevLmYwsH4cX5b1V88n1c24STwj4+/DbFsocWkVZTsxPdvKApNCSqGmclPr7MZubSO
         cueg2UTXmQAchwNWpr9kKoAme4/fEI/1aCWzN8imF9NjmqFq4xwIXiy5eWw1vguCEX1k
         lR9uAMlLwpQxDhY98WsdZnOgB7wdmqkgjP+5X3tfUgcZRqB0DoZbsgTiXc86sFkHxkip
         KprsH1f4SGE3JqZWIQTXQE9yb6nR6BYOrNBqASoAahdmMu7cMlRxe6s2oXdwnAA0KI9d
         xd2A==
X-Gm-Message-State: ANhLgQ2MlSe8sn0lcVpl9MXuUW4Z+ZPt3HDe5eOPNfnc6OJ3C29oSUWK
        EIyA+emZwRirMU3NjZUigLim+0+CzQwh8uItAWo5Hg==
X-Google-Smtp-Source: ADFU+vsGYeX8deeFTiQUXBM84EbN9XuUAeO3QMuQlbxbcRkUEgsMc+zWB+stKd0Nn+CFFbGOxaT4ggue64YY108z+Iw=
X-Received: by 2002:ab0:1849:: with SMTP id j9mr3482116uag.77.1583548269719;
 Fri, 06 Mar 2020 18:31:09 -0800 (PST)
MIME-Version: 1.0
References: <1583509057-8197-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1583509057-8197-1-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sat, 7 Mar 2020 08:00:00 +0530
Message-ID: <CAHLCerMYdFVbA+Fqw92uAVjjKWaMGS0Fq6Vrmy8AxDcnTX4L-w@mail.gmail.com>
Subject: Re: [PATCH] thermal: add COMPILE_TEST support for i.MX8MM
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

On Fri, Mar 6, 2020 at 9:13 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Add COMPILE_TEST support to i.MX8MM thermal driver for better compile
> testing coverage.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 4d6753f..91af271 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -265,7 +265,7 @@ config IMX_SC_THERMAL
>
>  config IMX8MM_THERMAL
>         tristate "Temperature sensor driver for Freescale i.MX8MM SoC"
> -       depends on ARCH_MXC
> +       depends on ARCH_MXC || COMPILE_TEST
>         depends on OF
>         help
>           Support for Thermal Monitoring Unit (TMU) found on Freescale i.MX8MM SoC.
> --
> 2.7.4
>
