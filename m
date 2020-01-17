Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35FCC1408F9
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 12:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgAQLdw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 06:33:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35767 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgAQLdw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 06:33:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so22341522wro.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 03:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HlGSqRPWCcpTVOvm2y/4qtBvBsg/45YDsT7XOrDxWQM=;
        b=wa4/IqEfc6rA+A/P5fHdkezc4l0JT2FKB0L8O2eIS8GE75THnOPZY1efa7QMDwReoT
         vQTSUimHGiira0WvCAsM9xAFumAjav8oSbE6ynre1ZUIhbMYZPjAKN73HxW9/V7ujGxj
         p09HveO7MV5D2braT3bzrQkaDFCxkYT9oHVm933uCoSdV3ogA9miGjx+geK/7hsroHUy
         ilTkQs1o36Mxs6PgZVX1sL0c6mQY8xf+kLlR3+kiomjPAFrl6eZ1GGl15YIXvkjLk2ck
         z2RRWzaFarWf6iWxahIrJ9ABra2dOuzC0cSG+y7BBpy4MjHw0ENqLaHTuBNWG4FVHUS8
         3Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HlGSqRPWCcpTVOvm2y/4qtBvBsg/45YDsT7XOrDxWQM=;
        b=HnLfiSceeUglOPdjeQY49i8ssVm5QZ8jHgGfED0DdRFpn9DYhYHB1fhwElunwD10lA
         eSOUNJ5naaLsxgocEmWD1VPw6OYDYj9x7FX7QPZNlw5di7jd5ps+Lpct4p115t0G3MYy
         lS0ysTgvi790tYJidvo96QBKBpGZ+iGajDOWR94cQsQKIaw1RtMXeHjwfQ8BQ0Mfh8T4
         lxDdc530G0myUNdII/2XjhBBel9j5WJ6y8aQws6KBVpfo9lihCQlZ8xj1TOpGDjFa79v
         bRVOK2E2rhGhJMN5GTsrZXSTVbKilHnQACfzOo10gCyUmXo+NF1Q0MtTFZQYcTMJqeXK
         aAEw==
X-Gm-Message-State: APjAAAVctt36tYjBm29UM7aO1pynFVrEzmMfT3NNEufhMhnj/j1e2csn
        AQBC5d+k03iNQY2wJGFiZOjy2w==
X-Google-Smtp-Source: APXvYqxWFzmFtAaZqwXcheoxbrUKo9fL18irV27YAg6aTrSXgtUWJp16xEvIUZeWzLPnBLgypfOWqQ==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr2544858wro.216.1579260830707;
        Fri, 17 Jan 2020 03:33:50 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id u14sm33018273wrm.51.2020.01.17.03.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:33:50 -0800 (PST)
Date:   Fri, 17 Jan 2020 11:34:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 2/3] mfd: cros_ec: Add cros-usbpd-notify subdevice
Message-ID: <20200117113404.GI15507@dell>
References: <20200114232219.93171-1-pmalani@chromium.org>
 <20200114232219.93171-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200114232219.93171-2-pmalani@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 14 Jan 2020, Prashant Malani wrote:

> Add the cros-usbpd-notify driver as a subdevice on platforms that
> support the EC_FEATURE_USB_PD EC feature flag and don't have the
> ACPI PD notification device defined.
> 
> This driver allows other cros-ec devices to receive PD event
> notifications from the Chrome OS Embedded Controller (EC) via a
> notification chain.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes in v6:
> - No changes.
> 
> Changes in v5:
> - Updated the IS_ENABLED() check to check for CONFIG_OF instead of
>   !CONFIG_ACPI according to upstream comments.
> 
> Changes in v4:
> - Removed #ifndef usage; instead, moved cros-usbpd-notify to a separate
>   mfd_cell and used an IS_ENABLED() check.
> - Changed commit title and description slightly to reflect change in
>   code.
>  drivers/mfd/cros_ec_dev.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
