Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9A2695CB2
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 09:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjBNIQn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 03:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjBNIOq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 03:14:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C4321A10
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 00:14:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o36so10403106wms.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Feb 2023 00:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aI2uDJmlrj2FAxpoONeR47ofLkA/PV3rqzJUm7/U26E=;
        b=YLNQ0jeiw6LdVVTZCSFrrZCcXl7uGgqgz4n4GMoI9tDYRtH3I7ihDaP9rmqXFGXFCM
         y772i0B0SQk8NbxO4jnMoXTKf2nOonGxH3tUii2Lc0EvJpUp3fzhO5xD4OT8DVtBwIjP
         a9NYOIr5ZAzBLj8Lf541lFmjjw3dwL9BA7ywyVVMW71JpXVa3oswg2uMkI8USPKM3seF
         ETWGWVNSXmDIVscf1rWsOXCqQXZDv4+PZ92S+5ohDELknEUivh65UV3oMLT7lHyloPLa
         ccbp6cmnGgQe6ArGJ7iRW2S+bzZPYIRME4sDeQ/d3nGUryE+e7AP5nnNlQD90I3bpeK+
         AE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aI2uDJmlrj2FAxpoONeR47ofLkA/PV3rqzJUm7/U26E=;
        b=5nF9PSJGTBos5ne3XzqkB7dUJOwFK7rsgMWlX8UrKO15A+W9XgbhFxiwpbpOIw76bY
         5YT/6WsKZ1szr3AuMGwPGim8E4mUhTfZ4YRnJco/CR06ADuq7rN3Wa89Z/Ff7p41xW/9
         df/HjbATNSGzMnBUC6I4JjZTcL2dPbrsGrOrXcpGQFNjBRgCHt8jJF8KRfF1QBCEjgxE
         OhE5tMvYle7u9GcyjktxmIM5ig+cuGPcKFWeKJzwEljCdg7VEr63e4qxFruX1o2kNHpe
         cw7/Hkw/5fLh8mZ5+iHn5O4wtrTMlsRrdalwfN7dDwONXygrWExeb+N35Hhno4myV4Ae
         a8eA==
X-Gm-Message-State: AO0yUKWwxHID8Kub3Bx4dfO6kiWTeK2MojlXlMm9/tUUYuXGOC7xkrlc
        BqO0rbjkgy/jTyo+HsdBJoX/DA==
X-Google-Smtp-Source: AK7set9MrlNet8v7SENBgYBlDkF9xPm2qhgh5VFy9STLxHqofqua/v/M0vua3J4lRGjXQvWaJVu4ow==
X-Received: by 2002:a05:600c:994:b0:3dc:5937:35a2 with SMTP id w20-20020a05600c099400b003dc593735a2mr1864019wmp.9.1676362483629;
        Tue, 14 Feb 2023 00:14:43 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c5445000000b003dc492e4430sm16145215wmi.28.2023.02.14.00.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:14:43 -0800 (PST)
Message-ID: <75d37ae7-3632-a195-b12b-44e8a940be4a@linaro.org>
Date:   Tue, 14 Feb 2023 09:14:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch][next] dt-bindings: power: supply: Revise Richtek RT9467
 compatible name
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterwu.pub@gmail.com
References: <dc8873c3125f7aa6f84dc7b33a44bf00907e0814.1675853673.git.chiaen_wu@richtek.com>
 <20230213205321.xrhvrdqy5ksiagbv@mercury.elektranox.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213205321.xrhvrdqy5ksiagbv@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/02/2023 21:53, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Feb 08, 2023 at 11:14:24AM +0800, ChiaEn Wu wrote:
>> Revise RT9467 compatible name from "richtek,rt9467-charger" to
>> "richtek,rt9467"
>>
>> Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467 battery charger")
>> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
>> ---
> 
> Is there a new version of this fixing the issues pointed out by Krzysztof?
> Also I think the filename and $id should be changed to richtek,rt9467.yaml
> in addition to the compatible change.

Yes, indeed.

Best regards,
Krzysztof

