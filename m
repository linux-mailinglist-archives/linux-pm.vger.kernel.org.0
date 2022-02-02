Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9674A70FC
	for <lists+linux-pm@lfdr.de>; Wed,  2 Feb 2022 13:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbiBBMqA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Feb 2022 07:46:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237261AbiBBMp7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Feb 2022 07:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643805959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2MgpqkUcQy8xm2YEczHn5aMWVUVny42CQPa38ApqUo=;
        b=VBp3nBumZQG3y5BnoX/TJeVgV7ojZEiJgWPQPteEpPQVGeGJpsTEWoFLOEYg+/YRSJb25B
        uT4fp4fwhpqVFKc0VJ6jH2Vdn9buQqmTfO8q73JFUutQNEKZakt5g1suy51cpc6k/2k/Ey
        VBfXchn/8ijykm0+MXT5760YX9VhlEE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-9dVwC3qEN4SLLaxhboyIDQ-1; Wed, 02 Feb 2022 07:45:58 -0500
X-MC-Unique: 9dVwC3qEN4SLLaxhboyIDQ-1
Received: by mail-ed1-f72.google.com with SMTP id w3-20020a50c443000000b0040696821132so10315993edf.22
        for <linux-pm@vger.kernel.org>; Wed, 02 Feb 2022 04:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L2MgpqkUcQy8xm2YEczHn5aMWVUVny42CQPa38ApqUo=;
        b=0SJaO4u6gznTTmzzAXE1RYMqcuWxc9klCzOTTmlKDpdRiljmAS6xVxgFROojZWXoTs
         9ibhz/QY0QbiUrZUqk8FJdZ6r3pY114SMki4UKuKMlf3IMFjuSjGSCaBY7xi8wGK1O/b
         Ul1qdtqDmAvEZzUEIVjRXoeWsJKZjJCzy6J6pDVdnNzHC2pJmKdtj2x8TCzNwvbV+RUP
         yDBXc2a1pRJTp43Q7ZmuBfez8YUZDPKGIUY8Rb+OKHBDFL0yU6P0DzgJcWv3WxrLz/gt
         09WuDRW2z7Q0XmhP9s8x/bIPVKCockE3DlxNAstv64rXFYVawGiTrYhivyiNrffd2dUG
         6sRA==
X-Gm-Message-State: AOAM532HF4tUOvbzoQ5PnDwe5VZaUzVM+pISfb1twqx5wftU3d2k/Bwk
        4RK88chPkHhKRrx7qeuCFgL8VgTbNOJP/cCtCMzDIteGkNirip3aU2/ptK/qD3A1B+pEl4RV5FN
        X2nfAyukzWXzwVNeezTE=
X-Received: by 2002:a05:6402:698:: with SMTP id f24mr30447151edy.159.1643805957168;
        Wed, 02 Feb 2022 04:45:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0BOt5vFNLNoU+2m3VvI1dwFENKVK9kPv+3YXwZ4YNAFwj6bqDiewZqYzq9PKmLgXw0q43hA==
X-Received: by 2002:a05:6402:698:: with SMTP id f24mr30447139edy.159.1643805957039;
        Wed, 02 Feb 2022 04:45:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id q6sm15775628ejx.113.2022.02.02.04.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 04:45:56 -0800 (PST)
Message-ID: <8386b5bf-46bd-5927-9119-cdf77e1df082@redhat.com>
Date:   Wed, 2 Feb 2022 13:45:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH][next] power: supply: axp288_fuel_gauge: Fix spelling
 mistake "resisitor" -> "resistor"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220202091246.580091-1-colin.i.king@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220202091246.580091-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2/2/22 10:12, Colin Ian King wrote:
> There is a spelling mistake in a MODULE_PARM_DESC description. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Oops my bad, patch looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/power/supply/axp288_fuel_gauge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
> index dcedbc59732d..13be2c1d6528 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -91,7 +91,7 @@
>  
>  static bool no_current_sense_res;
>  module_param(no_current_sense_res, bool, 0444);
> -MODULE_PARM_DESC(no_current_sense_res, "No (or broken) current sense resisitor");
> +MODULE_PARM_DESC(no_current_sense_res, "No (or broken) current sense resistor");
>  
>  enum {
>  	QWBTU_IRQ = 0,
> 

