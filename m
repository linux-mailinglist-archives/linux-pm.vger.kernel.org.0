Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA2E1A95C8
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 10:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635571AbgDOIHg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 04:07:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46291 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635562AbgDOIHM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 04:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586938029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDdYfSg43KpYWuuPakF4B4tcdGZPYljqQUL9gLxwyrs=;
        b=PLXnQNEZLa2JiW120SGZiBpAxqPMn4ygJHwgOaaTjVK12xOtQQiUAFXflInFwygANgP6wS
        G+ZiJmbZ1sbjI1JCIywBH8KMtqs4se2XOXif1xnB9vrgF2OhEyBjHw8glGRQYSICkj1ibn
        7MWXKIWqkKZH3A+2w1ckFMvM4fjxBG8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-E4tDS97iOMGQnGdlahOquQ-1; Wed, 15 Apr 2020 04:07:06 -0400
X-MC-Unique: E4tDS97iOMGQnGdlahOquQ-1
Received: by mail-wm1-f72.google.com with SMTP id h6so4943432wmi.7
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2020 01:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDdYfSg43KpYWuuPakF4B4tcdGZPYljqQUL9gLxwyrs=;
        b=ILEOTLN6ZoWPbEgOeSfgIujasTAEz+eEPBxKUSMfNlBdCD/3c3DoCbCozZ6RZ2tq5E
         JtShK1Gs6EA718bMJXL0FNonrTh7wtWzifWUmpy3AvOl99c2stjplJstGWjuNw2rNnml
         KU1XcufJYE94UVH1TpZCTVqFDHhvVWiDm32W/F0lCYM1KYQkjVaE5vwVDWFxoigkXgrk
         1qumQpVS7IMHyEVNbPmNnHSyi77AfdjcWdLqdVGBA2GMkN8qbG1v2DsE3KswMUYXocEs
         A9R4vI369PxAqXa/UedrI6Cg6Le3XgBXapdo7Q8q3hVtQ8GVAuXpXpnRHfB0g6zElBHr
         w87Q==
X-Gm-Message-State: AGi0Pua1642gPKsEAS1yJOAEvhZuJiKUgFxhoBbXc3rnxMngiZD2hjUK
        sNGLmZWYBegOpPIu7ut+waKiNXEUzB53D8cU7NPkY/le38uIZSZeGklusxPdcb5Hja0YloBYr3h
        s7WqOdS47UPIFBFMvpRg=
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr4163567wmr.25.1586938025051;
        Wed, 15 Apr 2020 01:07:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypLM8/guNljwdxt33+rGLqxJ5oJ/t0p2TiWjT5KUdTEEF6BNudkLy+55c9aOC9WA4m3vasp/fw==
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr4163541wmr.25.1586938024762;
        Wed, 15 Apr 2020 01:07:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id m14sm20326145wrs.76.2020.04.15.01.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 01:07:04 -0700 (PDT)
Subject: Re: [PATCH] power: supply: axp288_charger: Omit superfluous error
 message
To:     Tang Bin <tangbin@cmss.chinamobile.com>, sre@kernel.org,
        wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
References: <20200415042727.13496-1-tangbin@cmss.chinamobile.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8f9ae92b-9aab-34a2-dc15-a9c3514c7ca8@redhat.com>
Date:   Wed, 15 Apr 2020 10:07:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415042727.13496-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 4/15/20 6:27 AM, Tang Bin wrote:
> In the axp288_charger_probe(), when get irq failed, the function
> platform_get_irq() logs an error message, so remove redundant
> message here.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>

Thank you for this nice cleanup patch:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/power/supply/axp288_charger.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index 1bbba6bba..16fb4ae1c 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -825,10 +825,9 @@ static int axp288_charger_probe(struct platform_device *pdev)
>   	/* Register charger interrupts */
>   	for (i = 0; i < CHRG_INTR_END; i++) {
>   		pirq = platform_get_irq(info->pdev, i);
> -		if (pirq < 0) {
> -			dev_err(&pdev->dev, "Failed to get IRQ: %d\n", pirq);
> +		if (pirq < 0)
>   			return pirq;
> -		}
> +
>   		info->irq[i] = regmap_irq_get_virq(info->regmap_irqc, pirq);
>   		if (info->irq[i] < 0) {
>   			dev_warn(&info->pdev->dev,
> 

