Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 584F519AE91
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbgDAPJR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 11:09:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55303 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbgDAPJQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 11:09:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id r16so36344wmg.5
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2020 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QsyC5XbpdA/rmlnfYe4iva3k7o6K19W7aGVX/8LE71s=;
        b=drXfHyn/Sgn/OQv1If63LxfC2slBajC0r8s8otOEk+FQczecih3n6j44CKfWyCZPc8
         rK3gbuRyGSnRn188TuhWL1ESm1LdOcRtYLwwkpi4AVRqxzdsDFr14JIeE0ZQ15cqMBxn
         2hVkkUWjIsVivWqAEwQS513sfDOGRlL/Jkr+k7h15OIMMJi5CtVSCw7HddnIp9CHFXqP
         yxY9ZOXj26HvIa3rm5udKyFVzdihal6q+oJgyuprERWuh3NPKBjxKinCiCp0AlBgsRvw
         1ldlE5eF+RwYGcFHTSXCqEH9VD2YHC76OYah5Vq3yannF6Maz9YB613bJdG3n3N312/R
         TwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QsyC5XbpdA/rmlnfYe4iva3k7o6K19W7aGVX/8LE71s=;
        b=Wa+q2APWD7Fqv/x36r0yhKYmz/9FBP8kA7+VKJL7ClrVLytCNlBRc+EPP1uMS6+k7e
         Fe0VjCc/lpJgu49FFyLDchdCP8bIuuc0OCninUywvvR5xwvo9jmPxjBT8XfKXkiXBXyz
         Dx7Xu9kS+kFbbYxP2ES37c0Ok5H3j4uLBpVpq5H3ukD4yuOF7IncDcPyivCCnB+pduy+
         kRkRtoA8aZSqYlVFuU+fWD0n+/yT/3CWkBpUHJTux0nEGAqZrYPfQqBuwoL/S56QHGcb
         331qQ4TQzyNWK9cpmAYodP3jbD2iJEeLhsfAeVTDaTgSvJxywDAlZ/5k1ers7zO6YAI3
         zeTA==
X-Gm-Message-State: AGi0PubhC0ecHGcm7w42TRhY533DG6CrX6LRlWRiKmI57qndX72iV4Bi
        kXRofUzrInDmHh2RGQd4GGax3g==
X-Google-Smtp-Source: APiQypJaF4faY8l/5iAT9eY/9dKjhFsuJY2Qtseh5JoQOXF3ILTEkl8vRYMSOY5CmJmhoXVeWiwtvA==
X-Received: by 2002:a05:600c:4145:: with SMTP id h5mr4648989wmm.3.1585753753742;
        Wed, 01 Apr 2020 08:09:13 -0700 (PDT)
Received: from [192.168.0.136] ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id d1sm3361008wrm.86.2020.04.01.08.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 08:09:12 -0700 (PDT)
Subject: Re: [PATCH V4 00/13] Add driver for dvfsrc, support for active state
 of scpsys
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Mike Turquette <mturquette@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
References: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 mQINBFjTuRcBEACyAOVzghvyN19Sa/Nit4LPBWkICi5W20p6bwiZvdjhtuh50H5q4ktyxJtp
 1+s8dMSa/j58hAWhrc2SNL3fttOCo+MM1bQWwe8uMBQJP4swgXf5ZUYkSssQlXxGKqBSbWLB
 uFHOOBTzaQBaNgsdXo+mQ1h8UCgM0zQOmbs2ort8aHnH2i65oLs5/Xgv/Qivde/FcFtvEFaL
 0TZ7odM67u+M32VetH5nBVPESmnEDjRBPw/DOPhFBPXtal53ZFiiRr6Bm1qKVu3dOEYXHHDt
 nF13gB+vBZ6x5pjl02NUEucSHQiuCc2Aaavo6xnuBc3lnd4z/xk6GLBqFP3P/eJ56eJv4d0B
 0LLgQ7c1T3fU4/5NDRRCnyk6HJ5+HSxD4KVuluj0jnXW4CKzFkKaTxOp7jE6ZD/9Sh74DM8v
 etN8uwDjtYsM07I3Szlh/I+iThxe/4zVtUQsvgXjwuoOOBWWc4m4KKg+W4zm8bSCqrd1DUgL
 f67WiEZgvN7tPXEzi84zT1PiUOM98dOnmREIamSpKOKFereIrKX2IcnZn8jyycE12zMkk+Sc
 ASMfXhfywB0tXRNmzsywdxQFcJ6jblPNxscnGMh2VlY2rezmqJdcK4G4Lprkc0jOHotV/6oJ
 mj9h95Ouvbq5TDHx+ERn8uytPygDBR67kNHs18LkvrEex/Z1cQARAQABtChHZW9yZ2kgRGph
 a292IDxnZW9yZ2kuZGpha292QGxpbmFyby5vcmc+iQI+BBMBAgAoBQJY07kXAhsDBQkHhM4A
 BgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyi/eZcnWWUuvsD/4miikUeAO6fU2Xy3fT
 l7RUCeb2Uuh1/nxYoE1vtXcow6SyAvIVTD32kHXucJJfYy2zFzptWpvD6Sa0Sc58qe4iLY4j
 M54ugOYK7XeRKkQHFqqR2T3g/toVG1BOLS2atooXEU+8OFbpLkBXbIdItqJ1M1SEw8YgKmmr
 JlLAaKMq3hMb5bDQx9erq7PqEKOB/Va0nNu17IL58q+Q5Om7S1x54Oj6LiG/9kNOxQTklOQZ
 t61oW1Ewjbl325fW0/Lk0QzmfLCrmGXXiedFEMRLCJbVImXVKdIt/Ubk6SAAUrA5dFVNBzm2
 L8r+HxJcfDeEpdOZJzuwRyFnH96u1Xz+7X2V26zMU6Wl2+lhvr2Tj7spxjppR+nuFiybQq7k
 MIwyEF0mb75RLhW33sdGStCZ/nBsXIGAUS7OBj+a5fm47vQKv6ekg60oRTHWysFSJm1mlRyq
 exhI6GwUo5GM/vE36rIPSJFRRgkt6nynoba/1c4VXxfhok2rkP0x3CApJ5RimbvITTnINY0o
 CU6f1ng1I0A1UTi2YcLjFq/gmCdOHExT4huywfu1DDf0p1xDyPA1FJaii/gJ32bBP3zK53hM
 dj5S7miqN7F6ZpvGSGXgahQzkGyYpBR5pda0m0k8drV2IQn+0W8Qwh4XZ6/YdfI81+xyFlXc
 CJjljqsMCJW6PdgEH7kCDQRY07kXARAAvupGd4Jdd8zRRiF+jMpv6ZGz8L55Di1fl1YRth6m
 lIxYTLwGf0/p0oDLIRldKswena3fbWh5bbTMkJmRiOQ/hffhPSNSyyh+WQeLY2kzl6geiHxD
 zbw37e2hd3rWAEfVFEXOLnmenaUeJFyhA3Wd8OLdRMuoV+RaLhNfeHctiEn1YGy2gLCq4VNb
 4Wj5hEzABGO7+LZ14hdw3hJIEGKtQC65Jh/vTayGD+qdwedhINnIqslk9tCQ33a+jPrCjXLW
 X29rcgqigzsLHH7iVHWA9R5Aq7pCy5hSFsl4NBn1uV6UHlyOBUuiHBDVwTIAUnZ4S8EQiwgv
 WQxEkXEWLM850V+G6R593yZndTr3yydPgYv0xEDACd6GcNLR/x8mawmHKzNmnRJoOh6Rkfw2
 fSiVGesGo83+iYq0NZASrXHAjWgtZXO1YwjW9gCQ2jYu9RGuQM8zIPY1VDpQ6wJtjO/KaOLm
 NehSR2R6tgBJK7XD9it79LdbPKDKoFSqxaAvXwWgXBj0Oz+Y0BqfClnAbxx3kYlSwfPHDFYc
 R/ppSgnbR5j0Rjz/N6Lua3S42MDhQGoTlVkgAi1btbdV3qpFE6jglJsJUDlqnEnwf03EgjdJ
 6KEh0z57lyVcy5F/EUKfTAMZweBnkPo+BF2LBYn3Qd+CS6haZAWaG7vzVJu4W/mPQzsAEQEA
 AYkCJQQYAQIADwUCWNO5FwIbDAUJB4TOAAAKCRCyi/eZcnWWUhlHD/0VE/2x6lKh2FGP+QHH
 UTKmiiwtMurYKJsSJlQx0T+j/1f+zYkY3MDX+gXa0d0xb4eFv8WNlEjkcpSPFr+pQ7CiAI33
 99kAVMQEip/MwoTYvM9NXSMTpyRJ/asnLeqa0WU6l6Z9mQ41lLzPFBAJ21/ddT4xeBDv0dxM
 GqaH2C6bSnJkhSfSja9OxBe+F6LIAZgCFzlogbmSWmUdLBg+sh3K6aiBDAdZPUMvGHzHK3fj
 gHK4GqGCFK76bFrHQYgiBOrcR4GDklj4Gk9osIfdXIAkBvRGw8zg1zzUYwMYk+A6v40gBn00
 OOB13qJe9zyKpReWMAhg7BYPBKIm/qSr82aIQc4+FlDX2Ot6T/4tGUDr9MAHaBKFtVyIqXBO
 xOf0vQEokkUGRKWBE0uA3zFVRfLiT6NUjDQ0vdphTnsdA7h01MliZLQ2lLL2Mt5lsqU+6sup
 Tfql1omgEpjnFsPsyFebzcKGbdEr6vySGa3Cof+miX06hQXKe99a5+eHNhtZJcMAIO89wZmj
 7ayYJIXFqjl/X0KBcCbiAl4vbdBw1bqFnO4zd1lMXKVoa29UHqby4MPbQhjWNVv9kqp8A39+
 E9xw890l1xdERkjVKX6IEJu2hf7X3MMl9tOjBK6MvdOUxvh1bNNmXh7OlBL1MpJYY/ydIm3B
 KEmKjLDvB0pePJkdTw==
Message-ID: <2737cc5c-3876-6861-c44f-fc9f552bbdb9@linaro.org>
Date:   Wed, 1 Apr 2020 18:09:11 +0300
MIME-Version: 1.0
In-Reply-To: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Henry,

On 3/13/20 11:34, Henry Chen wrote:
> The patchsets add support for MediaTek hardware module named DVFSRC
> (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> a HW module which is used to collect all the requests from both software
> and hardware and turn into the decision of minimum operating voltage and
> minimum DRAM frequency to fulfill those requests.
> 
> So, This series is to implement the dvfsrc driver to collect all the
> requests of operating voltage or DRAM bandwidth from other device drivers
> likes GPU/Camera through 3 frameworks basically:
> 
> 1. interconnect framework: to aggregate the bandwidth
>    requirements from different clients
> 
> [1] https://patchwork.kernel.org/cover/10766329/
> 
> Below is the emi bandwidth map of mt8183. There has a hw module "DRAM scheduler"
> which used to control the throughput. The DVFSRC will collect forecast data
> of dram bandwidth from SW consumers(camera/gpu...), and according the forecast
> to change the DRAM frequency
> 
>            ICC provider         ICC Nodes
>                             ----          ----
>            ---------       |CPU |   |--->|VPU |
>   -----   |         |-----> ----    |     ----
>  |DRAM |--|DRAM     |       ----    |     ----
>  |     |--|scheduler|----->|GPU |   |--->|DISP|
>  |     |--|(EMI)    |       ----    |     ----
>  |     |--|         |       -----   |     ----
>   -----   |         |----->|MMSYS|--|--->|VDEC|
>            ---------        -----   |     ----
>              /|\                    |     ----
>               |change DRAM freq     |--->|VENC|
>            ----------               |     ----
>           |  DVFSR   |              |
>           |          |              |     ----
>            ----------               |--->|IMG |
>                                     |     ----
>                                     |     ----
>                                     |--->|CAM |
>                                           ----

It would be useful to also add the above diagram into the commit text of
patch 09/13. By doing so, it will be saved into the history, as cover letters
are discarded.

Thanks,
Georgi
