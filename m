Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FCB459923
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 01:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhKWA0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Nov 2021 19:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhKWA0z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Nov 2021 19:26:55 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD86C061574;
        Mon, 22 Nov 2021 16:23:48 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso31284282otj.1;
        Mon, 22 Nov 2021 16:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9FoIoYfVPo+jVYUDdqZhq8BrrYA/SKv+OkPQoiLRuVU=;
        b=g/O9juuhllMVBlM4Ia/Ugw8GMOgyWhzX8wZWkZu3mvccUcIHaOJl6rB3C4QA0wTYOe
         uJRSZdF3yt16aQwnAw54EXsDHrQJ2ATwRI6sdJTEO7MWPpuQSRF3RLV93OGK6IdHZ198
         EAFQzhnhT6STxRpFHvdgNM9yIZrgqY/baPvwLYoox0R5mkbxIlqkfODs9+LlgFKk4oyt
         LZYk4pgdJ4O/DKfI/i34BgSnNCiq2FBXzjeYyi1Kmw6IYBBud5ToVErCrfqEXVstQpOx
         Z+oyNtIksBH4T9+Pwo2Z/Rrb6diaWiLzqukQKkJrKsNd4ftUrlh9jWxbQAJl3ZZqMStR
         iZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9FoIoYfVPo+jVYUDdqZhq8BrrYA/SKv+OkPQoiLRuVU=;
        b=U/GS6EeqK9+UXZZSPOTs/6UsdR15Rmuh+NdqLoZpz48qjQB5DNSeAKWkFrfLOqwKS+
         dONfZEki1RWyN8MKRO2xf8WtgA3SNc1dcOn43BUxhsUQ6VgKulSSLvyYrGUo5OeGlECj
         mui6JSeMyWnMud3VTCR5SGdrNIu9YwVfpfIPDnUws/w5jXijQNL7ydH3GQuXGp56nlEd
         dqPTjVUfwreRqIF+olE5S8YmiDZQbpHrOOPfzyGMqfxmuwe28SsZmEHj1DFomMscshiJ
         DlQthLeAC2ecAiNBOPxQACbKYlQVmVqLu9L2a9S9YmUSj0hlJzV3rlXTbctrl776eWiW
         wbxA==
X-Gm-Message-State: AOAM533Uad+iylSJ4nEWMgC28lh7+wLYMx+KVU0VDP44o6JAHF+safns
        GB2NHs4R3mpzduff4q3KjEbUS2qdDk0=
X-Google-Smtp-Source: ABdhPJxWUblhPBcjmMv7uKpJX79WULd7ebHTliq0dWmo4i6iVynGWkUfyD2xOTv6x5tIGqLyPzSSmA==
X-Received: by 2002:a05:6830:44c:: with SMTP id d12mr484963otc.66.1637627027244;
        Mon, 22 Nov 2021 16:23:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o26sm1881828otj.14.2021.11.22.16.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 16:23:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 0/2] More AB8500 charging props
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20211122234141.3356340-1-linus.walleij@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f0a38d3c-e7f0-ab75-f1cf-7c884515a7c7@roeck-us.net>
Date:   Mon, 22 Nov 2021 16:23:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211122234141.3356340-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/22/21 3:41 PM, Linus Walleij wrote:
> These two patches begin to put new stuff into the
> drivers/power/supply/ab8500_bmdata.c for:
> 
> A) battery temperature look-up and interpolation, and
> B) maintenance charging
> 
> Some design choices can be discussed, so I included some
> HWMON etc maintainers.
> 
> NTC resistor:
> 
> For the battery NTC temperature we should note the existing NTC
> driver in drivers/hwmon/ntc_thermistor.c with bindings
> in Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
> which is used for stand-alone NTC resistors.
> 
> It is probably possible to try to reuse the hwmon code but I
> wanted to see if we have buy-in from the hwmon maintainer first.
> 
Go ahead; anything that reduces code duplication is desirable.

Guenter
