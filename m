Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A1A3C6703
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 01:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhGLXgF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 19:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhGLXgF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 19:36:05 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B523C0613DD;
        Mon, 12 Jul 2021 16:33:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e20so26957598ljn.8;
        Mon, 12 Jul 2021 16:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n2KW/XDIaqNrXeP9GTAr/bm4ckoh5thsGDsRbvj/Pbk=;
        b=Owv4CLGA218J8KYpe6xNiLnWrOqLqYCnPgE8GPlfepQo9AGBnTcIpPoY8h3gWvBM0i
         ZbpodRsr14sWYIiTEkWr9XLXJPCAXePkRExtI9yD6dbuxdXsV2QR0UqQJtqkDZqr4ADR
         YOYlp2c8828YY9YD3AR21qkhss9G7628Uz4os4DclCz1m3PHgjYV5lNoRRps78kppZ/Z
         7UYpoFup3+zfMPaezWRaSmM7cGuaslslsdhhvIy1hpeAjxBZ8WB/w8pACIP+GGW2ixAI
         LnY8c+XhMaA/Vy8w0yViSCBUgK4vDBe/X0fY99TYDKV4FbxDdavuUk34p7Zvh0T2Taof
         gxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n2KW/XDIaqNrXeP9GTAr/bm4ckoh5thsGDsRbvj/Pbk=;
        b=NQmNsNExjkeKruGsDGDarBaeNyEnz6aPD7QZmjilTeHRPiQX7WnKBtkc2JOMALAcR6
         F7gwHStWvbKUKzaQwi2wAuCcT7AiU3og/9q+c9r8OajoHCxS9hUjjmbcmo0Klsqcvyxq
         2c9g0XKj8LvcgpvB1XoraFBL5lWlCarRtEZLkS3NUUKhd0Xy9XxxfE+LErCTyx3T3ce/
         4Z1sN5b27HeGW5itQRRHod0pJux5ylHRahYFrgGXbeyv6ufgFYVoOEHqPEWv7QRAnCF+
         WoIpZoHdrqqqEQ/s+ki0o95o0GCPWmxd3gQ4kbxPOzBJiyR6DIrigOmiGWxejztlhTsc
         CzIA==
X-Gm-Message-State: AOAM531kP9RIlF+47BFmSk44l5BXBDlrQW38wUYGLQsKIEM6mXgasDxJ
        pZwMzYhRRRxbqJ5x1LNYKJclIhOH+QM=
X-Google-Smtp-Source: ABdhPJzJy18EgS4wledN8ulkyVqcUt8RL+aow3BijC3gkzemV4AD9r07ns1dt1kzAQqMY9KTyy6uTQ==
X-Received: by 2002:a2e:8447:: with SMTP id u7mr1406527ljh.356.1626132793122;
        Mon, 12 Jul 2021 16:33:13 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.googlemail.com with ESMTPSA id o14sm1317892lfr.296.2021.07.12.16.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 16:33:12 -0700 (PDT)
Subject: Re: [PATCH v3 02/12] dt-bindings: phy: tegra20-usb-phy: Document
 properties needed for OTG mode
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
 <20210704225433.32029-3-digetx@gmail.com>
 <20210712154139.GB1980362@robh.at.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8fe56e89-9e1e-f5e2-5a47-242b5b3d085a@gmail.com>
Date:   Tue, 13 Jul 2021 02:33:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712154139.GB1980362@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

12.07.2021 18:41, Rob Herring пишет:
>> +  nvidia,pmc:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to Power Management controller.
>> +
> Add a cell to this for the PHY reg offset and then get rid of the index:
> 
>> +  nvidia,phy-instance:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 2
>> +    description: Unique hardware ID.

The instance ID belongs to the USB h/w and not to PMC. It may look like
I added the ID just to get offsets within PMC, but it's not like that.
The Tegra documentation explicitly assigns unique IDs to the USB
controllers and PHYs. Hence this ID should be the property of the PHY
hardware, IMO.
