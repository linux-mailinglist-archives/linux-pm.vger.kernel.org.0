Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157E83ACC68
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 15:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhFRNic (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 09:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234079AbhFRNiV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 09:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624023371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dwAv77AeNlMLDZyLBksUycGFC3fX4Q/aI+Elu1Kw5xU=;
        b=OEX/ddlkvtRb1UP6hGDbozHev4F6Ngg/v7TbTCbnhKf9Wh2nAvgWOOjydkOuHRlew4DaQB
        b3jm3c2OwykwbheZKg/kQT+/orv3SG7RcH1gweA7klYb0PVGS1IgHFI3DezC4nz17mhPC+
        IPdY0svIJpo72sHaqOTc/qwezhX8tHI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-ja0bfDJXNtCNnrbbT59Pdg-1; Fri, 18 Jun 2021 09:36:10 -0400
X-MC-Unique: ja0bfDJXNtCNnrbbT59Pdg-1
Received: by mail-ej1-f70.google.com with SMTP id de48-20020a1709069bf0b029048ae3ebecabso395908ejc.16
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 06:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dwAv77AeNlMLDZyLBksUycGFC3fX4Q/aI+Elu1Kw5xU=;
        b=Ax4yXu82JmY90S6bMj9P+9j7/dQZ4dwyvXZa92bGCKGilnsZv2NRt1NGO0JO+HN2eX
         Fb9imEvB8WetPvorNFY8CuG07cuMUrmzhJuG/RrwX2LTQiaP8siGvudMNCpvPso1UVij
         NhUsY/lAbrjH8FJHxCOnaNJSk0gC0Y8JVsfQ2ElyYN9lDkKfDy3swGS0co0hTpeOsaQw
         EMfj9+HIxtXxiWch+0uWvxqjlS3ccOaZcoQu18tKz0Y/4V8OtkBIwuDOiLpGF6pcoG/l
         qUBe/ode3+sqRitpQI/hU3UMEZ/hIEpx9j5RyuFaxSb6zpqInDH+rsh2V3UC5dumhmnS
         Mv7w==
X-Gm-Message-State: AOAM530GBA/iCmzUCgDeH5g/xNu84gu8IV6r4HwmnrJuyHrT401GoJ68
        my5LQE09TpJz5aWH+YYD7o+CiApKmN0ssvEggghAJAgTNbpAslXeU/H1zKOlG/FCXOAMgl/5sGp
        FJjnunQ/1R3gAwi9ssTo=
X-Received: by 2002:a17:906:1704:: with SMTP id c4mr11309286eje.182.1624023369338;
        Fri, 18 Jun 2021 06:36:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR91c6OPYoDNV+ixeXoAS0a4lEBGMZghoM8VLy/9noopvEnzhrLCC5z06NQNHkpEdJHuzVDQ==
X-Received: by 2002:a17:906:1704:: with SMTP id c4mr11309273eje.182.1624023369190;
        Fri, 18 Jun 2021 06:36:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id e12sm1047791ejk.99.2021.06.18.06.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 06:36:08 -0700 (PDT)
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: remove redundant
 continue statement
To:     Colin King <colin.king@canonical.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210618092924.99722-1-colin.king@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9d482c54-f578-5afb-9661-dbb658471b5d@redhat.com>
Date:   Fri, 18 Jun 2021 15:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210618092924.99722-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 6/18/21 11:29 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The continue statement at the end of a for-loop has no effect,
> invert the if expression and remove the continue.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/power/supply/axp288_fuel_gauge.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
> index 39e16ecb7638..20e63609ab47 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -142,9 +142,7 @@ static int fuel_gauge_reg_readb(struct axp288_fg_info *info, int reg)
>  
>  	for (i = 0; i < NR_RETRY_CNT; i++) {
>  		ret = regmap_read(info->regmap, reg, &val);
> -		if (ret == -EBUSY)
> -			continue;
> -		else
> +		if (ret != -EBUSY)
>  			break;
>  	}

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

