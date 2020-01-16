Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E84A113DC0C
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 14:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgAPNdb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 08:33:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53364 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgAPNda (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 08:33:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so3779827wmc.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 05:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TN1C0BU2PTBLJmNFZg5mU4BeRHix0wJ3ht/gwzdD5u8=;
        b=oxrQ87UT83nfd3P9kxfj9QfY2myJr7M1giXv9Qf0hHpui2mW5VzAw88L57J9lZ0v20
         yZ+egCtL37C0m0oHxc6vGdiGf0NrwrzU+S497dJwHjoCOoLHaNi7VkAyG+SCEZ7+xEsv
         zVMs2IDbd5PYFwbk4010xsqgj8a397CUGFGDHsE+oW9MAwLixnZMnv6kmm7203G3k1yt
         KVyUpLjVqNiMYXxZUGvFBZqHYhDW5JglvXnBjAe2wa1fn/U/FE1mzvHN8PlDzLDz16b+
         smVa8kRwRouG/4OKwXooONg2EXcG2cV+0gtFbASy2oAFJZjhWCk5B5xfEq24x5BCHDZ0
         xwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TN1C0BU2PTBLJmNFZg5mU4BeRHix0wJ3ht/gwzdD5u8=;
        b=QUOhMUK6Vl2khNN8PQ/AfJASlIeOyS96fPw0Ct9vzHEXbBVLjteyrKE2fiOEw6FHBF
         ry3J0DhUw6qslo2oaKtRrZwacR9zwh/de0ASqor3bbomUR8pZZb7F7ALtKSwtSuaFCGv
         ZVYuF24+CUXnajvIOByU45YuaO28+G7uvIioRKuikBwN10qf6kxRyP4wBepI6yUeyHIe
         8+xz7+UEdlV2ABzS4xyZrZb8E0aQ/2qvCkL9jq7EA67+EDjaCX03PSl5dKDu5qZlzAfq
         F+sMtKWjdYAy17Vm5oTX86N9cX4Z9ha9LOoxggsVdXjF2+wUrvs/KMXNgfiYikm8vfrG
         cCcw==
X-Gm-Message-State: APjAAAVYZ8DczaV9QxYcxiggoI0MCzwT1k5+qzchHhZDlrL7k6kLJsH1
        ldMXeMfkCxprPGF1RvPaLIyi6w==
X-Google-Smtp-Source: APXvYqzuVoN3eK9HhpiyuxjekGNFfr9lmPcxs3tdIbJpSi/brNhpgYHOUCmx8UocH1nw01xH5b8omw==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr6313015wma.5.1579181608706;
        Thu, 16 Jan 2020 05:33:28 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id t131sm5053730wmb.13.2020.01.16.05.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:33:28 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:33:47 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 2/3] mfd: cros_ec: Add cros-usbpd-notify subdevice
Message-ID: <20200116133347.GQ325@dell>
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

Just replied to v5:

Looks good to me.  Could we have some Chromium reviews please?

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

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
