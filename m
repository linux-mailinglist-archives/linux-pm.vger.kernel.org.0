Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB0F8130CC2
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 05:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgAFE1P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 23:27:15 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40021 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbgAFE1O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 23:27:14 -0500
Received: by mail-ed1-f65.google.com with SMTP id b8so46413852edx.7;
        Sun, 05 Jan 2020 20:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwRP4ECi3xByfI1AHY6eFXxg+DNLJFdWayS/RcdVemU=;
        b=IEPvxW+5pliFKZOvQ54n+TkAbfNxusZQQJ1Xt6vtUxmjXk4jHO/lowrQS0zSlAr9U1
         99b0dWjgcS4Tq26U6+T0vYhMjAh9Tuf9eRXLk53qqNCJ5+3t+DN/433jJD3096G/2Rje
         xU3LL21KCK4YLGBSrpHoZnbtLRK4IM5IGR/j8zppc8dMEmoylw70hA4zoFXffRNtH9Wt
         DGfK3+v+NUAT2QKKF7VEVqW4RpaaK/M7qU85IQw/JJIUCbd5uCHyd6FrmRYHzRCbd6xi
         ckEz8xwX5rTi1ZeHKPUwUrKtXT+HK44+HsvhRKfkU/exbcdN0rpO0ZcA73hYYsI5q2v+
         qHLg==
X-Gm-Message-State: APjAAAV/mvWy7xXD6dGbk3tQsc6WK1Vx6jFZS+BsZUZMnV0Xc4z7kpnE
        kSANJn+wmPzZU3ofSfra6WkJ/MpMQiM=
X-Google-Smtp-Source: APXvYqxsuFjd6KIlUxup71uAFtWbBiXXOLCYfRpRiK/1LTv9g0h/ZYmV6qgV9USBX2seJ2aH7cCvLQ==
X-Received: by 2002:a17:906:b2d1:: with SMTP id cf17mr107937673ejb.192.1578284832637;
        Sun, 05 Jan 2020 20:27:12 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id y25sm8003412ejj.68.2020.01.05.20.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2020 20:27:12 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id y17so48268940wrh.5;
        Sun, 05 Jan 2020 20:27:12 -0800 (PST)
X-Received: by 2002:adf:ef4e:: with SMTP id c14mr102268897wrp.142.1578284831822;
 Sun, 05 Jan 2020 20:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20200105012416.23296-1-samuel@sholland.org> <20200105012416.23296-10-samuel@sholland.org>
In-Reply-To: <20200105012416.23296-10-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 6 Jan 2020 12:27:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v66jxw5acPXEQd0KwVbL96dOjeTj=8jZsC7DFiB_-=i0MA@mail.gmail.com>
Message-ID: <CAGb2v66jxw5acPXEQd0KwVbL96dOjeTj=8jZsC7DFiB_-=i0MA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 9/9] power: supply: axp20x_usb_power:
 Only poll while offline
To:     Samuel Holland <samuel@sholland.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jan 5, 2020 at 9:24 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Investigation on the AXP803 shows that VBUS_PLUGIN/VBUS_REMOVAL IRQs are
> triggered on the rising/falling edge of AXP20X_PWR_STATUS_VBUS_USED. The
> reason IRQs do not arrive while N_VBUSEN/DRIVEVBUS is high is because
> AXP20X_PWR_STATUS_VBUS_USED also never goes high.
>
> This also means that if VBUS is online, a VBUS_REMOVAL IRQ is received
> immediately on setting N_VBUSEN/DRIVEVBUS high (and VBUS_PLUGIN shortly
> after it is set back low). This was also verified to be the case when
> manually offlining VBUS through AXP20X_VBUS_PATH_SELECT.
>
> As long as VBUS is online, a present->absent transition necessarily
> implies an online->offline transition. Since will cause an IRQ, there is
> no need to poll while VBUS is online.
>
> To ensure the driver's view of VBUS online status remains accurate,
> unconditionally poll once when receiving an IRQ and when resuming. If
> VBUS is still online at that time, polling will cease until the next
> VBUS_REMOVAL IRQ.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
