Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C27F1EB0DB
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 14:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfJaNJD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 09:09:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:38039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfJaNJD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 09:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572527319;
        bh=3wJKVyYoiMGL1Akdx/qSGtrh6JUYmofzwoIvlXnFXwk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dkGXCXXobHmwW4S3SW3V4aJGZ+enVdpz2hZRJDeL7eJiaEgx8j6VtB+pEpzds8gpO
         yLkSMXG3CQ5qTDbZT1RSzW2JKfcr5nDxPuEKVLB+JQ4Y1itNaBOvJ3UY6u0/yTKXLz
         CEQSzHqb8J9ZU4+WQDfFo3Q7vGKfUa6IovsuDQFE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.112]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7i8O-1hucyr0uXK-014iie; Thu, 31
 Oct 2019 14:08:39 +0100
Subject: Re: [PATCH] thermal: brcmstb: enable hwmon
To:     Chen-Yu Tsai <wens@kernel.org>, Markus Mayer <mmayer@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20191030163807.17817-1-wens@kernel.org>
From:   Stefan Wahren <wahrenst@gmx.net>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <91017889-2ae7-d467-eed3-6d3b2bb130b9@gmx.net>
Date:   Thu, 31 Oct 2019 14:08:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030163807.17817-1-wens@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:wwKDXPdQHu57MA+3650WQGgXGwGXrGlPlc4zDxz9XyuXEPqLCLm
 /mp4YrvcTWFdBPgrqhzHE+7PZ1PeQOBditQHh9qA9bCQm2/TcLMi8licaey/4dBjGJKxMBt
 7ksj2pZ3k3QtRerJjPEI/oDRAxPmw/svRSaH04VOu+++sSa2E/3wDNxIkKApL0fHzGjBMme
 oNuYPWrOuIVc4SDbjuu2Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fKcvFjiuPSw=:dYR/7xc/3ZaVePP3IFARWP
 2/dhssqIRsfRe6qnvT5sNnZessTX/NXOFAfN1nBPghAehQkYOMMmjfiUCj6qKbo7ix+6HQOt6
 vWGsOqhudwkPU6R7MWGjZx7WdSQpwiXa0564r4wVa8rnN8vRNz7JPVCYQJ/QN5x2LiHR2Nawr
 mklu5Ydgz/uHjgQpOCPnBjzIO8PYvKjuGgTkE9nHrBBBNSjPi1arShGYrKtzJywxm5iTj82J6
 MgHBoeYIiQOKikGKosMZvG0wLNpw5N2lP2CfKd3y5l/6xPl8o7R45mqq6mGXqzQjWtxxBDdZM
 /WaHHeoL79QqaibqCK0qnFEuzAntdnNW0UmkpQNN1sfS9UftSwm5yq+bmEx3UXT3OpBE3dFeC
 hyP+ilJWMF3vqT/CkAPouYTMijST900XMrNjZxznFyiPzZl4n9yp9RWVVf3bjRlf8O6dTGaxx
 OS6qa9t10eY89Qq8+1ll/IVSTXof09cdxwbIWjVTtW0G/dZvJZOIxVm57lMjwJy5a/RH2tNm+
 PrCrOaYrFTWVlCK7XoVb+SLpobwOcdVVH5rPTfY+mLZaZqvo5Wztp4rAK1vevugQc3ASN2ehv
 +Y3GCQ+ROLdI4dTKaBnLMIiiGEr3Ai6327pkGPmNTAVt6e2PA8Zf8JmiGe5NlHH0zYcA5Zb7g
 H3pgi+mHyy+xu4NmObfUa8dzvjs2cqGDaHhyMRNnrfSpnC+8ov+geKvcbxULocK1IweqSFuZK
 AvfMWlET3DkNInGD+1YhHCg82yKDzfHzjD5rqY/J7rt+DSz1iH/aEXMDgMAzVOJwOuLZkXfm9
 mEjNnpaki/aXNz92Nr+t4FrvEwIOMLPXLe/4ezWsKVGXdQnwhh0nKGWA3Vr9A8AxyzM+iJW/z
 bSHoozSiuXzouOoE/sVI3OySy9lnrzG9WTZbF7bMocXzIb5kORJcs+xmUMtVz8qpM7BBPzWtR
 RyA5iCEVuH93dlAwqsHnMtQ+AmYz1XpnvG/HtZgXZw8GYIWCR78tc6iXgQelmoxUx43offKyr
 CW6RAXOBqvPmaNLesVU6lceiJNChHoODupSEb3/+vJjNkUbjaohu0qjvmxig4WTbSFKhUekAv
 Oj6bNya64wGfv7fEQZKs67eEDXTRdbMGfJ/FIu0/zEy3mGqDrqxjZ4cVeFGPsa55H//pJY36d
 EP9O9LkesVv7CEThbBoTS7Uc5Zi4TAx9kJHs796C8S3rHFpkvMcevgYQq6MVhZzwnl/2FPPn9
 BpyKjxhLXCrLQNhAuBcGmEl5lazpH2Nx/9N1KSMxyGJ2GaOLFydaQqyDmBL4=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chen-Yu,

Am 30.10.19 um 17:38 schrieb Chen-Yu Tsai:
> From: Chen-Yu Tsai <wens@csie.org>
>
> By defaul of-based thermal driver do not have hwmon entries registered.=

>
> Do this explicitly so users can use standard hwmon interfaces and tools=

> to read the temperature.
>
> This is based on similar changes for bcm2835_thermal in commit
> d56c19d07e0b ("thermal: bcm2835: enable hwmon explicitly").
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>
> This patch was only compile tested. A similar patch [1] was submitted t=
o
> the downstream kernel, which I did build and actually run on a Raspberr=
y
> Pi 4.

just a note: from my understanding [2] the brcmstb_thermal isn't the
right driver for BCM2711. Please consider the current downstream
solution for BCM2711 support as a quick hack to avoid writing a new
thermal driver. But must confess that i didn't test Florian's recent
changes yet.

Regards
Stefan

[2] -
https://github.com/raspberrypi/linux/issues/3101#issuecomment-527554223

>
> This one for mainline is much simpler, as it does not need to deal with=

> the error path or device removal, due to the use of devres.
>
>  [1] https://github.com/raspberrypi/linux/pull/3307
>
> ---
>  drivers/thermal/broadcom/brcmstb_thermal.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

