Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEDD3C6768
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 02:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhGMAZn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 20:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbhGMAZc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 20:25:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5747BC0613E9;
        Mon, 12 Jul 2021 17:22:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x25so34059549lfu.13;
        Mon, 12 Jul 2021 17:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LHMjl6v+1/z8wJKRrF+q+23p2ixGAoh6EkLjt4MZTjE=;
        b=jiW8y8g6pdyhRM4uMdpXkWIFO7Xb89L5NGKePWnVUe+yA7+VP5URwMjPobX5jfWulK
         gSb17dKjQdHcOQmvCyTekQFiWtEBOJi/Dl44qAZ4bCgiFIRXdnlR4exZw6QFLV+NxYrI
         hiRJVYtwS+pj5u1yVrWfiQQviYYnUKAKDl0YloHnh9u35bNL0Gni6EtmDDlAci4+Zgp/
         MHK1XrLdc4l4WINofxSEN8wyj5yuUpQo2hzdhPelq2ybm5G8+ZE+00HJW8QeSep4ncVc
         MKwumlXVVL79ZHBN++QiG29p1zlmKOuz+M0Iu3wH/CkTYZpXRxhfzsd7O3yNwIvQs7aE
         mu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LHMjl6v+1/z8wJKRrF+q+23p2ixGAoh6EkLjt4MZTjE=;
        b=CZ+Nl/6ZiuYQPlTd9l/IIACU7TRSiUk8hdWxoE66wWKQ/SBT3ptm0N9PRT1cZWGJhn
         5evh+nzNcUDUOwh+i84LWMzCPecX+x6dpPXkJzfajfyxqLvAqi9TmCsAIsD1GNdIRZhQ
         TOo8eNVGsdt70hsz3gIC8oGqVfMuKMqaKNRfSaCXmbAcMMyS6eQ97TTVyePsNKifQHYT
         tvNBqkJ3+GxCR4OR+Z5npq0ETsuXbp0G7el0RGCqlNxZHiptUWTbmL7HvUaBtNddNeRL
         F6KMTjEpSyByKT+l4xY39uiluA/30/Ilv6eHNkO5eu1fvD1P2+0GuDZjzJXQwBGPlBMK
         Y+KQ==
X-Gm-Message-State: AOAM5300Dyb8C38u8RjWgbTnAzFapJ4PXuegeCfg771PacOwzua0gob/
        b0ObVd57GP6mSwJSaODkDzYr6lQtByE=
X-Google-Smtp-Source: ABdhPJyklp2niBlI5qcNHdbeTgIqoUU9MU2T6GictWwRo4KZQc1szt0TRJ+VAnZmAp8XOGBpm1z3eg==
X-Received: by 2002:a05:6512:260a:: with SMTP id bt10mr1119212lfb.636.1626135761389;
        Mon, 12 Jul 2021 17:22:41 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.googlemail.com with ESMTPSA id r19sm1801133lji.108.2021.07.12.17.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 17:22:40 -0700 (PDT)
Subject: Re: [PATCH v3 06/12] dt-bindings: power: supply: smb347-charger:
 Document USB VBUS regulator
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210704225433.32029-1-digetx@gmail.com>
 <20210704225433.32029-7-digetx@gmail.com>
 <20210712153905.GA1980362@robh.at.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9032e807-b4d3-bacf-6c39-d3a2c7c57f3e@gmail.com>
Date:   Tue, 13 Jul 2021 03:22:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712153905.GA1980362@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

12.07.2021 18:39, Rob Herring пишет:
>> +  summit,inok-polarity:
>> +    description: |
>> +      Polarity of INOK signal indicating presence of external power supply.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum:
>> +      - 0 # SMB3XX_SYSOK_INOK_ACTIVE_LOW
>> +      - 1 # SMB3XX_SYSOK_INOK_ACTIVE_HIGH
>> +
>> +  usb-vbus:
>> +    $ref: "../../regulator/regulator.yaml#"
>> +    type: object
>        unevaluatedProperties: false
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

I tried to add the unevaluatedProperties + a random unrelated property
to the example usb-vbus node and dt_binding_check is happy with that. So
the unevaluatedProperties has no effect, is it supposed to be so?
