Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A4B35D97
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 15:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfFENNE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 09:13:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:39985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfFENND (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 09:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559740362;
        bh=CsyA08ei/fkFPEU+VZzXBGyaujNAU5Gy3eeVl2SOv88=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WM1pOGDdgKHjwYyxlipNYIbaCQQ5xTbCWZCxgoWIqcZYbm64B6+KNH/rzHN6GbbcY
         /0ExKmctWc3eClmLB5jdsIo7/uAydaoxAkNx7p/pRjw8IN0mWSnX08BdEiDX21ROHI
         4cbr+XBnZSPzu8DFU50iyy134g8nwkS2pfEOLI2E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.160]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfSyv-1gnq6q3VcX-00p0wD; Wed, 05
 Jun 2019 15:12:41 +0200
Subject: Re: [PATCH 0/4] cpufreq support for the Raspberry Pi
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     f.fainelli@gmail.com, ptesarik@suse.com, sboyd@kernel.org,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
References: <20190604173223.4229-1-nsaenzjulienne@suse.de>
 <2ece3f20-ef8c-c39e-941c-76635ddbe185@gmx.net>
 <1a86637dad1d2f33450950143a82016beb91bdb6.camel@suse.de>
 <1c9708c9-a3c9-8a8f-4693-8f29d3e60634@gmx.net>
 <8d6eb920ebcaec2ede413439a7080ae030b7e44e.camel@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <755148da-60f5-2925-b6b3-1ac452e13d9e@gmx.net>
Date:   Wed, 5 Jun 2019 15:12:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8d6eb920ebcaec2ede413439a7080ae030b7e44e.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:T2nRa6wC5hotv0MUYJECymggpzwZZkIP8CPzeYgz+zuUDoRadhn
 e/xr55USxwJa/QCDfYDHD9QP0j5JnINKIzfgCakveqoO2DKlJ4XFLR2AjJnD+0fJUpdK7sl
 XN6RnM+AKMlQqvqZV4sSPKB2yLdldF2uN0EEw039KFt8pVb3BrJSB7WmYhjeqw1EXcdRPfX
 7Yx2jOQ+/wTUd9pzxjR1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C+5z9L5eeVA=:PWHJAJrDPJ+7s+qj4HLNvg
 ut19EjEacdchwt67zVwnnPj87yAgk259phrB8MrOsEXEN3pEv7GCtMPfftUmUvu3I6rhW0MD/
 ikmpbWLyr0UMbrtl4tnGfOGqkel0tciLSwoNPfZvEjJ5F10fiHCfgraCG0bvDpYegudUByfh1
 1Z5p2cg1WKQQ2aji1T6uZBbS7PcauPkA6n5r1xOoGYcSxVckM7A5NQi4koi1l2EvyjjTwkTX1
 KXj9I00PaYFDuiBBvlv3+hviqUNHdA1qpqimcSODtpK3ybQm7yGhQ7o8sdE74ckCuBX2Lsahx
 dFfLBFVrgy/wfCZMozE2AuFPuUDZ13/26ShDYSTT/PY6s28L7qdFej6gMs4P0GqKKo3bhRRrD
 M1pVqxD2S61v44gWdasb4GsoF3c9z1AEpM7WVv3wVw1a85LxpuUrB3jn09AKewmGgrVIHfOxs
 ap0nG1pKEXUDd4V1YMktqWyZ0pEIFT9tCCPJBBspoMsIVwkeuTFmJbcI7UzV7ZXnr+5I9cUla
 n5VkVOygZR1oxuVv8y7Yt1WVE3KALOqLl+zLAT8ta2qaiiINBlCX0t29hJkMtRtH8e5DZ0obV
 ZZETEBpL/qkkwmDe3XvNTOWXEdT43gUkSPa6j7yFW3pbmx6uoARXGvtGQXq0uHTX0BknIx8zJ
 mFbtHsbwTP/YnRSi/14RvBj73wUqRl3inY7+fs1K959A5pvmOw2+zEokSQg8f+erT7P8b0+m5
 heShF8P/T3GLkOrWAQqQCqCv67srOHgqaa54sqr26Btjl7ohsDMWKsq3x2s2xlonVlhyQqHPb
 8iUhigE6zx8IwafY8MQYWOBeQzYr+vUbr6caawMAMvlJBiGna1LKffzb3h+u8Vm+w62rrx6MA
 l/tVQcOMkgXJCDwb3b6v8rzHRM9wkaKkMk40cSIFeLHcwD6GZVuOw/cYQG4kJ84rxuD0dMKRt
 0htCukKkImfDp3aWdR2LsamZmUouaahHenfmKsFFgUYAGJUVqn+nM
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am 05.06.19 um 14:27 schrieb Nicolas Saenz Julienne:
> Ok, this looks more more like my fault, probably an overflow error somew=
here. I
> saw something similar while testing it on RPI2b. Which board & config wa=
s this
> run with?
It's an RPi 3B+ with multi_v7_defconfig
> Could you confirm the clk-raspberrypi.c message verifying the max and
> min frequencies showed up and was correct.
[=C2=A0=C2=A0=C2=A0 4.253294] raspberrypi-firmware soc:firmware: Attached =
to firmware
from 2019-03-27 15:45
[=C2=A0=C2=A0=C2=A0 4.269727] mmcblk0: mmc0:0007 SDCIT 14.6 GiB
[=C2=A0=C2=A0=C2=A0 4.282464] raspberrypi-clk raspberrypi-clk: CPU frequen=
cy range: min
600000000, max 1400000000
>
> Regards,
> Nicolas
>
