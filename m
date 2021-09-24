Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352474174B8
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 15:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343927AbhIXNKA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 09:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346752AbhIXNIC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Sep 2021 09:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632488788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzNoSJfz8UWlBA9GOEva3/uiwEVLsfbaUygslX1PjHk=;
        b=VsGtynVolvQhBfPN7y65ARzdzkZeNPLt/e53XRqJAwiaT9Evr/LBSFDXNx8eUHbD51rhFj
        KUelCxuISexYQAxoRpsxeruamNNmPbBxP0DA954jsNjTHKykES22k5qmHjVa5XzP77ZHbw
        YVsOUxiARC0agxI3uSwf4OaVh4+QscE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-10bhD7JOO1Cwj9-J-Tg9wg-1; Fri, 24 Sep 2021 09:06:26 -0400
X-MC-Unique: 10bhD7JOO1Cwj9-J-Tg9wg-1
Received: by mail-ed1-f70.google.com with SMTP id n5-20020a05640206c500b003cf53f7cef2so10162625edy.12
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 06:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DzNoSJfz8UWlBA9GOEva3/uiwEVLsfbaUygslX1PjHk=;
        b=0J7b6nAKji8TsrY2v+qsnp5SDQbOKIlck6IKGp1GIVmxCnxlOPbiCLQGJ9JDtRBj5M
         ZSxxYSV+YEBc18Tn69wSt2R/tN52QVh8mMEoM63nAS6wXB+31QpS64y0s45Np/NmOyVn
         coUIN7t+CDq+x8T8q9AAFadqvLXfxFad3rBK5ep0r3nxtEKMKfOLh+XtiJS7vtS0GzuB
         Rk/+JPJBfJ7uHxUa1jfelh29cWkN2XBG8JW5rZOY/h+K1feQRUp9+X98hEeHUdDG2jyp
         NqX8fjaYUXTvdx2lQosMObPc7uojKKeRFBG2wBdGim0gdZqXDpQv3/VPNGk1aytjH4fg
         SL7w==
X-Gm-Message-State: AOAM532ekKCkzbig2AdKhyhjZX8guUR66PMHJGkwyKBLDF8Znk3ZLPM5
        uou2lhsgRJITArJlHuewHmIDe+Rf1iHDe2QV2Y8TQUoKw9B7jW1ydsqGBzitqnGz7Eahhg/n4TR
        dnsqUNj3k43+kuKYJWeY=
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr10652094ejc.188.1632488785548;
        Fri, 24 Sep 2021 06:06:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNhVr57TKy2OLV2CObu4gkIwPOKhycrD5Ho86NxP8/1LlBpelW1ktxDmu0qDZjF+7D4sIDTw==
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr10652077ejc.188.1632488785367;
        Fri, 24 Sep 2021 06:06:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s4sm5064713eja.23.2021.09.24.06.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 06:06:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] MAINTAINERS: power: supply: max17042: add entry with
 reviewers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210924115619.52927-1-krzysztof.kozlowski@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e7983d04-5651-7962-36e0-758d547be761@redhat.com>
Date:   Fri, 24 Sep 2021 15:06:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210924115619.52927-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 9/24/21 1:56 PM, Krzysztof Kozlowski wrote:
> The Maxim max17042 fuel gauge driver supports several devices used on
> multiple different boards - both devicetree and ACPI based.  The driver
> is incomplete and has few known issues.  Fixing these might break other
> platforms so mention recent contributors who can provide feedback.  This
> way most of interested parties might help reviewing the patches.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 329d3a0a9fdb..da9d5383af04 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11429,6 +11429,16 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
>  F:	drivers/iio/proximity/mb1232.c
>  
> +MAXIM MAX17042 FAMILY FUEL GAUGE DRIVERS
> +R:	Hans de Goede <hdegoede@redhat.com>
> +R:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +R:	Marek Szyprowski <m.szyprowski@samsung.com>
> +R:	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
> +F:	drivers/power/supply/max17042_battery.c
> +
>  MAXIM MAX77650 PMIC MFD DRIVER
>  M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
>  L:	linux-kernel@vger.kernel.org
> 

