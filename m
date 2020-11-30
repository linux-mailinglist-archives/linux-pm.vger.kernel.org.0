Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DC12C872B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 15:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgK3OxF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 09:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgK3OxF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 09:53:05 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD2EC0613CF
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 06:52:19 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id f190so22462121wme.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 06:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xRnSTPJtYHlLo5f9Pcsa1HU4sAtrN1byx2aGSuuHdV8=;
        b=KN3UUO6NsVuwUQVEDTZ2eiYecoqvNhR/NsquvyGZPENcBLAyo8q/C4dYMO+H+VQ96t
         5h9oUwxaBfOaLvuQ0L6H5f+d+IFUQEoUu1ofoqdOG/b9fvX7vUCmEyny6PlmOwJSQW3v
         AuI3AqTN2jX/dBo9wJwQMxb8MU8C63QRPm6wrG05BXMo4no3DMFCJosPhHrn+eKzznQO
         HI9tXsU0w7Z69+PrGI3zDrz9SK8Co0CXu+NmXIifeWxOWSCVo8lgXrvezUV5WGTw6Y76
         h80FhNNmb9WkXBX/jH2mGOv9iABOrVq11bdvGVIpU3ZsseaaIAt++1dt/x4ZgoaIFFgE
         LLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xRnSTPJtYHlLo5f9Pcsa1HU4sAtrN1byx2aGSuuHdV8=;
        b=VFgxQeAsbHEx/hbZcPm4QEL+7ikErXdMSC+U9lY9S18J+13G2xsttZebLQsKeIXZsE
         akFCJbnAEIiMDWJgwGnf7N8reyGFn7fhTzdSAsqdlWMXBPCMD7UE04XrQ85ulVOXyirO
         cqmqwTqumt2OPm2a4UKXtCLtz5UyCnzXMiuC+5vnEc95H3VHxbB3Nnca365AbD/d+r0w
         HZ52CJ72mdsQbzbQrqnVfqY6C/PdcR5vcGWnHZaPz6QK2YpltRkeNvELnbzEw7V6CL+G
         kYwtG2ypm7Bpwqillks8Iv6NLOFEnJauBY/bX8ZzvXdWw3HZjbjCdCY+PLsImMmo88d1
         m9Yg==
X-Gm-Message-State: AOAM533eyuoR5MfyPke1WSQLqrSXPoTF5n3uEvQR2Tf9REzKfEcoNRPu
        MVupy0SSvMPtuGN6rHTa2XyAQQ==
X-Google-Smtp-Source: ABdhPJzh786ywQLuYKfZnHtZFKJOE4q0GObaoeKTiokZ7B8y0EIQtjGY+u9FB3q3p8aiNx3HcptlMg==
X-Received: by 2002:a1c:a9cc:: with SMTP id s195mr1189482wme.97.1606747938163;
        Mon, 30 Nov 2020 06:52:18 -0800 (PST)
Received: from MacBook-Pro.local ([212.45.64.13])
        by smtp.googlemail.com with ESMTPSA id n189sm1072983wmf.20.2020.11.30.06.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 06:52:17 -0800 (PST)
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: Add bindings for
 Qualcomm SDM660 NoC
To:     Rob Herring <robh@kernel.org>,
        Martin Botka <martin.botka1@gmail.com>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        devicetree <devicetree@vger.kernel.org>, marijns95@gmail.com,
        Konrad Dybcio <konradybcio@gmail.com>,
        phone-devel@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20201017133718.31327-1-kholk11@gmail.com>
 <20201017133718.31327-2-kholk11@gmail.com> <20201019195807.GA3508546@bogus>
 <CADQ2G_HZ9nt88vW9MNiC-+Rdjzsu-hSHoqmqLC75vyiG2JKpQQ@mail.gmail.com>
 <CAL_Jsq+ZsOP1=+N0yu1Dc+2ZpkJic8XSGhTf0H8yRzYfbk1T9g@mail.gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <f9096036-b47a-bc0e-af32-041d800b19e1@linaro.org>
Date:   Mon, 30 Nov 2020 16:52:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+ZsOP1=+N0yu1Dc+2ZpkJic8XSGhTf0H8yRzYfbk1T9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30.11.20 16:29, Rob Herring wrote:
> On Mon, Oct 19, 2020 at 2:45 PM Martin Botka <martin.botka1@gmail.com> wrote:
>>
>>> Documentation/devicetree/bindings/interconnect/qcom,sdm660.example.dts:20:18: fatal error: dt-bindings/clock/qcom,mmcc-sdm660.h: No such file or directory
>>>     20 |         #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
>>>        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> This patch depends on my MMCC patch (sent by angelo).
> 
> Seems this landed in linux-next now and the dependency is not there.
> Revert, drop, or fix the dependency please.
> 

Thanks Rob. I'll drop it for now.

BR,
Georgi
