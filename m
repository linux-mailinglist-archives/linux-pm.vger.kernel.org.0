Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D012408BD4
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 15:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbhIMNGS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 09:06:18 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56870
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238759AbhIMNDy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 09:03:54 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E95894019A
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 13:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631538156;
        bh=iu9zMq7VH8HxvbrRseM1CzfWgZBkbaUNi4Cw0YJuwM0=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=ZZ96PHBT7+p7K/JIE+0jsK4hEjFGrETGJRCloLsZ6gGw86rIzioQHwHldVOpGGj6x
         pbkPEa2rmuDq8HjVd/bjyqs4rRPOQ8juddPUsTj1iWheAYMkg8CJLDHIhjTPrdQV9m
         t3w7yIr5AIlNwZzW+/QXEbiy2sUpKKkoxw9gJZP2XGOeudXn8+BRwC3F8UV6mJhK9x
         ej2SiySEQUQjFIWMZjnpvK3oT55FZiGfndHoMcFy9890sCkfGdpkNbI1L1X6Wm7xEi
         KhwrsgF6i2D9NGXz5pZWkZ7WspOUwcaRphc8NKKtGhiHJP7x9v+6MZ7oD3IvAuAyPG
         5QDD0kRQ3Jivg==
Received: by mail-wm1-f72.google.com with SMTP id 17-20020a05600c029100b00305eac9f29aso497559wmk.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 06:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iu9zMq7VH8HxvbrRseM1CzfWgZBkbaUNi4Cw0YJuwM0=;
        b=rcypZBIRzADOZNKGmD4vV2vLPuNKn0TkKs15abvBwB0M5/fjN3hdX64sgjFI3DJV0k
         CsRY5okA+CNF3vXcNDwRxBfYmiBuHAbfv5A282F+VMSCd7AbnlYPqb8AqR/QL9je4Z1a
         6iyrxkYxtkSHHYVw3oye9sZkNnTwKNhI46I8GAtwV+2lPu2AR9lH1ius9OXGNlrBx+bp
         j7vTXmkv1hh9BgjL4JDAn1UfqNasixgyN5Gl8Ktj/+xHVeKBfzF6jPOjf5YPoHZbT2rp
         prwUrK+f8X2qWrUz82JviotsKjAlkeSkL9b3+1OwQLeSvYoRd/IHlIVhu5EYTWF0Xflr
         T9dA==
X-Gm-Message-State: AOAM5332HS5KHvwzTJ8cAjLDbdFhub8ldiRVv94VRus+Js1iRYfscN27
        vFqiJiN+J0ZbS0Lcr9hr3E3jfBD98y9C8962wjgkE0It/bd8etgyYi0tF5pzTbGzil7R9GQ7/92
        2Kc7nMeyoD6j7nHN0kyxts/ujokbM5tahR95N
X-Received: by 2002:adf:ce03:: with SMTP id p3mr12573883wrn.261.1631538156546;
        Mon, 13 Sep 2021 06:02:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyaSKSMIX4A+QSHz2WtdORfG6b/MogxIP65fow2RNuWACKEFXZ5iZ+P8QZMy4+VzDS4hEY9Q==
X-Received: by 2002:adf:ce03:: with SMTP id p3mr12573843wrn.261.1631538156267;
        Mon, 13 Sep 2021 06:02:36 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id o2sm7876376wrh.13.2021.09.13.06.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 06:02:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] power: supply: max17042_battery: Clear status bits in
 interrupt handler
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        Ramakrishna Pallala <ramakrishna.pallala@intel.com>,
        Dirk Brandewie <dirk.brandewie@gmail.com>,
        stable@vger.kernel.org
References: <20210912205402.160939-1-sebastian.krzyszkowiak@puri.sm>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <0123524d-b767-5b5b-8b14-60d8cea3c429@canonical.com>
Date:   Mon, 13 Sep 2021 15:02:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210912205402.160939-1-sebastian.krzyszkowiak@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/09/2021 22:54, Sebastian Krzyszkowiak wrote:
> The gauge requires us to clear the status bits manually for some alerts
> to be properly dismissed. Previously the IRQ was configured to react only
> on falling edge, which wasn't technically correct (the ALRT line is active
> low), but it had a happy side-effect of preventing interrupt storms
> on uncleared alerts from happening.
> 
> Fixes: 7fbf6b731bca ("power: supply: max17042: Do not enforce (incorrect) interrupt trigger type")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  drivers/power/supply/max17042_battery.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index 8dffae76b6a3..c53980c8432a 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -876,6 +876,9 @@ static irqreturn_t max17042_thread_handler(int id, void *dev)
>  		max17042_set_soc_threshold(chip, 1);
>  	}
>  
> +	regmap_clear_bits(chip->regmap, MAX17042_STATUS,
> +			  0xFFFF & ~(STATUS_POR_BIT | STATUS_BST_BIT));
> +

Are you sure that this was the reason of interrupt storm? Not incorrect
SoC value (read from register for ModelGauge m3 while not configuring
fuel gauge model).

You should only clear bits which you are awaken for... Have in mind that
in DT-configuration the fuel gauge is most likely broken by missing
configuration. With alert enabled, several other config fields should be
cleared.

Best regards,
Krzysztof
