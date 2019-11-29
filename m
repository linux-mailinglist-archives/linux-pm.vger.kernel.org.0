Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD82A10DB6A
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 23:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfK2WCu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 17:02:50 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:32852 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfK2WCu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 17:02:50 -0500
Received: by mail-yb1-f196.google.com with SMTP id o63so3490978ybc.0
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2019 14:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBFfyve4zeh4DVhdr4q4ORn0Yl45pSjl2PrBaMrz/4E=;
        b=t7YKNY5WqMWU/jvRye+X2w55JXFkqSZaPNDtaeQ0Uc469ILUEST4j4sCN/RfDUVJRt
         WpHgyhgG/L6zG7v/G6NjTZ9+A5ME+lSZDvvJx/EWm0BiPFe5QbtohCKnSaQJJOXl8oRN
         WW1oSZC9jFwjD8CqbpWQoGsGJdvDfgkAKDJjWltMV5iNBkecIhw0JMBFfXA20A1TzHxW
         pbwS6XJtOcjbTrqjLjU7/on7XogtzX1Wb5yaUCml5v0+PvbByZsqDF/HFsevw8Qo7LCZ
         st79wvz+Mraflp10AvIyoI6pAjMKAHeFWzTfnCgivIPLoomMAwzdW6MswGGhH/AudVMj
         yM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBFfyve4zeh4DVhdr4q4ORn0Yl45pSjl2PrBaMrz/4E=;
        b=t/kxPxfNdNoF/Z+Oz5lwm6vDK6l4XBCQdQTOUtRjky//5nYpcQKYBd9hOo8Rjr3GK4
         IP1LTlFpfMHy7iWJ4d0iCW+UDrutZlg27nRwE7tMQv4/1aMpn65qDFRylmGBldLuCe16
         5GTXBO2lrGDkRaWB20GJRn1L0Y5pId4x1mzEqomn2MtNhc5Tmt4jdg0YtfPanzc+fHsK
         5CCriRoPlw6v4dFvwCby9UsgBousNNsnMKvrccpX3V/n28qBPJhaiyE+nK7pRu1KFnGS
         0zZ6d0lumsx3+3uynDD7P6ecDovVzcORlT/OYXRSBjZKgT5CB/wFaF1cmZWJv8/2Fidh
         XUeg==
X-Gm-Message-State: APjAAAW03kPSwcZ4ZezhtRGgkLH78y93J10VOrdU8lUQnuRv75zeZQ1p
        Im4pd0sPu6CCOSytu7h1GMNYnY8IwU3BMJwPxJ6pMg==
X-Google-Smtp-Source: APXvYqz2Ccri7VdLSl/UfTzXKgElMvDMOdBy89g3NxMW9dTyG3JrmQhReCS5tL2MvOv1tFmZmyUE7EFFLE1wpugCSwA=
X-Received: by 2002:a25:1909:: with SMTP id 9mr11484703ybz.61.1575064968117;
 Fri, 29 Nov 2019 14:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20191129215916.17105-1-enric.balletbo@collabora.com>
In-Reply-To: <20191129215916.17105-1-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 29 Nov 2019 14:02:37 -0800
Message-ID: <CABXOdTef5QAmZosDFF0Av8=9etj46O6aoxM3k9M9YBJmJynASA@mail.gmail.com>
Subject: Re: [PATCH] power: supply: cros_usbpd: Remove dev_err() getting the
 number of ports
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>, fparent@baylibre.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 29, 2019 at 1:59 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> When a device has no support to get the charger number of ports, it
> doesn't have to result in a dev_err(), print saying "Could not get
> charger port count" using a dev_info() would suffice. In such case,
> the dev_info() message is already printed but the dev_err() is annoying,
> specially, on those devices that doesn't support the command. So remove
> the dev_err().
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/power/supply/cros_usbpd-charger.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
> index 6cc7c3910e09..ffad9ee03a68 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -132,11 +132,8 @@ static int cros_usbpd_charger_get_num_ports(struct charger_data *charger)
>         ret = cros_usbpd_charger_ec_command(charger, 0,
>                                             EC_CMD_CHARGE_PORT_COUNT,
>                                             NULL, 0, &resp, sizeof(resp));
> -       if (ret < 0) {
> -               dev_err(charger->dev,
> -                       "Unable to get the number of ports (err:0x%x)\n", ret);
> +       if (ret < 0)
>                 return ret;
> -       }
>
>         return resp.port_count;
>  }
> @@ -148,11 +145,8 @@ static int cros_usbpd_charger_get_usbpd_num_ports(struct charger_data *charger)
>
>         ret = cros_usbpd_charger_ec_command(charger, 0, EC_CMD_USB_PD_PORTS,
>                                             NULL, 0, &resp, sizeof(resp));
> -       if (ret < 0) {
> -               dev_err(charger->dev,
> -                       "Unable to get the number or ports (err:0x%x)\n", ret);
> +       if (ret < 0)
>                 return ret;
> -       }
>
>         return resp.num_ports;
>  }
> --
> 2.20.1
>
