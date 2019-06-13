Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA94448D2
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 19:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfFMRL1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 13:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbfFMRLY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Jun 2019 13:11:24 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C3C217D9;
        Thu, 13 Jun 2019 17:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560445883;
        bh=zXxn0DZZzDqw7OoZuqRBZa3+NRFbt9j4/8PtEklx0ks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z6QX77MEL+lVTwICJFn4lx/RYfLqUuktVzenVzi/xypIH3UcvaG4r71l7+wQ0UtEQ
         77w8cr+DCRXNO+kGefwibUjePyZcggjFxjb/OyjvBNs0qX/ZCCaagbGAGepZh82Fb8
         78Fi+KGZAlC2CadDDN6Mv/Pcqz8geGb2RALiMIUU=
Received: by mail-qt1-f169.google.com with SMTP id 33so15260222qtr.8;
        Thu, 13 Jun 2019 10:11:23 -0700 (PDT)
X-Gm-Message-State: APjAAAUea2kZ2y2Pe/A/Yq8z9AOb7fC+1WMXG/ZEO/VDzH0I8ocpYILl
        xoJTY2WsKz+H+srGn/wBhHZNmdWE/pr7QTwUPA==
X-Google-Smtp-Source: APXvYqxPx+RzHImrfYff7rhrQ4nBX3av55NJRHWJ45TzZYNcBbf30JPqZBJ3v2N/ISXb3erZEUw1S75dSeXuFTMiFz8=
X-Received: by 2002:aed:3b33:: with SMTP id p48mr69738055qte.143.1560445882940;
 Thu, 13 Jun 2019 10:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190613170011.9647-1-thierry.reding@gmail.com>
In-Reply-To: <20190613170011.9647-1-thierry.reding@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 13 Jun 2019 11:11:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKiFzED-YaBFQ-PBnBBbDaC5yeri+pLG-PX=-wpaFfb=A@mail.gmail.com>
Message-ID: <CAL_JsqKiFzED-YaBFQ-PBnBBbDaC5yeri+pLG-PX=-wpaFfb=A@mail.gmail.com>
Subject: Re: [PATCH v2] driver: core: Allow subsystems to continue deferring probe
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 13, 2019 at 11:00 AM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Some subsystems, such as pinctrl, allow continuing to defer probe
> indefinitely. This is useful for devices that depend on resources
> provided by devices that are only probed after the init stage.
>
> One example of this can be seen on Tegra, where the DPAUX hardware
> contains pinmuxing controls for pins that it shares with an I2C
> controller. The I2C controller is typically used for communication
> with a monitor over HDMI (DDC). However, other instances of the I2C
> controller are used to access system critical components, such as a
> PMIC. The I2C controller driver will therefore usually be a builtin
> driver, whereas the DPAUX driver is part of the display driver that
> is loaded from a module to avoid bloating the kernel image with all
> of the DRM/KMS subsystem.
>
> In this particular case the pins used by this I2C/DDC controller
> become accessible very late in the boot process. However, since the
> controller is only used in conjunction with display, that's not an
> issue.
>
> Unfortunately the driver core currently outputs a warning message
> when a device fails to get the pinctrl before the end of the init
> stage. That can be confusing for the user because it may sound like
> an unwanted error occurred, whereas it's really an expected and
> harmless situation.
>
> In order to eliminate this warning, this patch allows callers of the
> driver_deferred_probe_check_state() helper to specify that they want
> to continue deferring probe, regardless of whether we're past the
> init stage or not. All of the callers of that function are updated
> for the new signature, but only the pinctrl subsystem passes a true
> value in the new persist parameter if appropriate.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - pass persist flag via flags parameter to make the function call easier
>   to understand
>
>  drivers/base/dd.c            | 19 ++++++++++++++-----
>  drivers/base/power/domain.c  |  2 +-
>  drivers/iommu/of_iommu.c     |  2 +-
>  drivers/pinctrl/devicetree.c |  9 +++++----
>  include/linux/device.h       | 18 +++++++++++++++++-
>  5 files changed, 38 insertions(+), 12 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
