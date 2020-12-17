Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779072DD881
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 19:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgLQSit (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 13:38:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728183AbgLQSis (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2020 13:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608230242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2cRaPSl45XV/lY3xUeswvCV0fSKfL65bx+LKx2mNGi4=;
        b=IIWC94/zg2AtZab0cBDmcR71xCGi7nhqQV1olov7Eq+cXrPiXvifa+D0HKYyAQMxJQzTzS
        JrsTaz75tAsI+ol1tYc03Gx9jmqryFe43SVVUmgMAEqcRKjZHqLam5tr2ay3+p5Q05PYh1
        20chP6sERMmF/oRWJ58VzW29RF2+ZVg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-PaqYbdlbMCe_ZhCTwgvsjw-1; Thu, 17 Dec 2020 13:34:50 -0500
X-MC-Unique: PaqYbdlbMCe_ZhCTwgvsjw-1
Received: by mail-ed1-f69.google.com with SMTP id l33so13764321ede.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Dec 2020 10:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2cRaPSl45XV/lY3xUeswvCV0fSKfL65bx+LKx2mNGi4=;
        b=laH+r7h60/nA6dc8stagEsr/Qp5XUgGciAWBRKhA9aBrLmLYjxl3PXKWh4xBoX+9fz
         RMq2pw4n/U6/o6ygsoKSBVVLcoHrVetmlInw/z4lysDAdHUit8AILkjDb0qGn+hmeAf8
         U+BsphBNe1NxUCzuAWaBvVsK61arSh5wnK9nWGyn/oqjlgQrgrZ9pUHLKc3jzzZvZCNZ
         4yBF6n4ognO8Pcan7NV0UKkRE2l4hkLKG82m9XA2aEl34XcAYQLpq6ivdirebVx4SZqm
         LC5ueO1vbmXaThmRxyyrZz29ZNhdINmcIZauMj3GkP46JyIXvIiJN/9Uv87qbAjArOf1
         vq8w==
X-Gm-Message-State: AOAM531+Wox6sGGcMBtaj+8WqUYH40ju6ULx9R+B82Kotu7QSxwQxtgV
        hzHdAigRnU4zE5amkbi527dn6jqqfjTzLFnYboKIIb3SVHoLww+IRe7cExgJwmqSiO6TAYupCPr
        hKMr/4EDMzDmoABqnjXN8rg2hnyFKpfVXqwFNEeVWHN6IzllAUDVbMVlYNsyKgLGvYVqF15c=
X-Received: by 2002:a17:906:3ac2:: with SMTP id z2mr363111ejd.26.1608230088432;
        Thu, 17 Dec 2020 10:34:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPw0m+CbO7jpUUx/t0CkRFVX4TW6yj6UzBlQSFAwT9rNCufG+kQ2w+8TPDXI+r4YCNt7NGrw==
X-Received: by 2002:a17:906:3ac2:: with SMTP id z2mr363091ejd.26.1608230088182;
        Thu, 17 Dec 2020 10:34:48 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v2sm4323931ejq.109.2020.12.17.10.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 10:34:47 -0800 (PST)
Subject: Re: [PATCH] power: supply: axp288_charger: use
 devm_add_action_or_reset
To:     Tian Tao <tiantao6@hisilicon.com>, sre@kernel.org
Cc:     linux-pm@vger.kernel.org
References: <1608208594-29081-1-git-send-email-tiantao6@hisilicon.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c1bae8d3-3373-9a12-f487-7c1f69061516@redhat.com>
Date:   Thu, 17 Dec 2020 19:34:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1608208594-29081-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 12/17/20 1:36 PM, Tian Tao wrote:
> When devm_add_action returns non-zero, it will return directly and
> there is no place to call axp288_charger_cancel_work, while when
> devm_add_action_or_reset returns non-zero, the system will
> automatically call axp288_charger_cancel_work.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

As I explained in my reply to the previous version of this:

"As the comment 1 line above the devm_add_action states, the action gets
registered *before* the notifiers get registered, so before the work can
ever be triggered.

IOW there is no need for the reset here. It cannot hurt, but it is not
necessay, so NACK."

This patch is not necessary.


Still NACK, please stop sending this patch,

Regards,

Hans



> ---
>  drivers/power/supply/axp288_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index a4df1ea..6480c2e 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -855,7 +855,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Cancel our work on cleanup, register this before the notifiers */
> -	ret = devm_add_action(dev, axp288_charger_cancel_work, info);
> +	ret = devm_add_action_or_reset(dev, axp288_charger_cancel_work, info);
>  	if (ret)
>  		return ret;
>  
> 

