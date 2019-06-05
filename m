Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C82036537
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 22:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFEUQ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 16:16:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:39527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfFEUQ2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 16:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559765745;
        bh=rijiQSXdFy2isPAAqnaADCu9R9ZY3RJXS+RUCx+UfTs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VJXJDhnDH3ex3dDL7itq0g4lKdjZcUZbtrGmw9d61c5zy5a8seGbh2HVSwNLRVvn5
         koMKEj/v+1NXTABfa/sgn9ERg9rSf7dONwUE4mEkp31xzodKqguf7iGnsjyDfGOD4s
         NXaaHUuBhOCCfD+ibFQy8puryJ8ldsnADt+ABVTA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.160]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBVwM-1hRR2s3Qv8-00AVYp; Wed, 05
 Jun 2019 22:15:45 +0200
Subject: Re: [PATCH 0/4] cpufreq support for the Raspberry Pi
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <wahrenst@gmx.net>,
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
 <6f40f43ed32c5c519761879245423f7c371e4ae6.camel@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 xsFNBFt6gBMBEACub/pBevHxbvJefyZG32JINmn2bsEPX25V6fejmyYwmCGKjFtL/DoUMEVH
 DxCJ47BMXo344fHV1C3AnudgN1BehLoBtLHxmneCzgH3KcPtWW7ptj4GtJv9CQDZy27SKoEP
 xyaI8CF0ygRxJc72M9I9wmsPZ5bUHsLuYWMqQ7JcRmPs6D8gBkk+8/yngEyNExwxJpR1ylj5
 bjxWDHyYQvuJ5LzZKuO9LB3lXVsc4bqXEjc6VFuZFCCk/syio/Yhse8N+Qsx7MQagz4wKUkQ
 QbfXg1VqkTnAivXs42VnIkmu5gzIw/0tRJv50FRhHhxpyKAI8B8nhN8Qvx7MVkPc5vDfd3uG
 YW47JPhVQBcUwJwNk/49F9eAvg2mtMPFnFORkWURvP+G6FJfm6+CvOv7YfP1uewAi4ln+JO1
 g+gjVIWl/WJpy0nTipdfeH9dHkgSifQunYcucisMyoRbF955tCgkEY9EMEdY1t8iGDiCgX6s
 50LHbi3k453uacpxfQXSaAwPksl8MkCOsv2eEr4INCHYQDyZiclBuuCg8ENbR6AGVtZSPcQb
 enzSzKRZoO9CaqID+favLiB/dhzmHA+9bgIhmXfvXRLDZze8po1dyt3E1shXiddZPA8NuJVz
 EIt2lmI6V8pZDpn221rfKjivRQiaos54TgZjjMYI7nnJ7e6xzwARAQABzSlTdGVmYW4gV2Fo
 cmVuIDxzdGVmYW4ud2FocmVuQGluLXRlY2guY29tPsLBdwQTAQgAIQUCXIdehwIbAwULCQgH
 AgYVCAkKCwIEFgIDAQIeAQIXgAAKCRCUgewPEZDy2yHTD/9UF7QlDkGxzQ7AaCI6N95iQf8/
 1oSUaDNu2Y6IK+DzQpb1TbTOr3VJwwY8a3OWz5NLSOLMWeVxt+osMmlQIGubD3ODZJ8izPlG
 /JrNt5zSdmN5IA5f3esWWQVKvghZAgTDqdpv+ZHW2EmxnAJ1uLFXXeQd3UZcC5r3/g/vSaMo
 9xek3J5mNuDm71lEWsAs/BAcFc+ynLhxwBWBWwsvwR8bHtJ5DOMWvaKuDskpIGFUe/Kb2B+j
 ravQ3Tn6s/HqJM0cexSHz5pe+0sGvP+t9J7234BFQweFExriey8UIxOr4XAbaabSryYnU/zV
 H9U1i2AIQZMWJAevCvVgQ/U+NeRhXude9YUmDMDo2sB2VAFEAqiF2QUHPA2m8a7EO3yfL4rM
 k0iHzLIKvh6/rH8QCY8i3XxTNL9iCLzBWu/NOnCAbS+zlvLZaiSMh5EfuxTtv4PlVdEjf62P
 +ZHID16gUDwEmazLAMrx666jH5kuUCTVymbL0TvB+6L6ARl8ANyM4ADmkWkpyM22kCuISYAE
 fQR3uWXZ9YgxaPMqbV+wBrhJg4HaN6C6xTqGv3r4B2aqb77/CVoRJ1Z9cpHCwiOzIaAmvyzP
 U6MxCDXZ8FgYlT4v23G5imJP2zgX5s+F6ACUJ9UQPD0uTf+J9Da2r+skh/sWOnZ+ycoHNBQv
 ocZENAHQf87BTQRbeoATARAA2Hd0fsDVK72RLSDHby0OhgDcDlVBM2M+hYYpO3fX1r++shiq
 PKCHVAsQ5bxe7HmJimHa4KKYs2kv/mlt/CauCJ//pmcycBM7GvwnKzmuXzuAGmVTZC6WR5Lk
 akFrtHOzVmsEGpNv5Rc9l6HYFpLkbSkVi5SPQZJy+EMgMCFgjrZfVF6yotwE1af7HNtMhNPa
 LDN1oUKF5j+RyRg5iwJuCDknHjwBQV4pgw2/5vS8A7ZQv2MbW/TLEypKXif78IhgAzXtE2Xr
 M1n/o6ZH71oRFFKOz42lFdzdrSX0YsqXgHCX5gItLfqzj1psMa9o1eiNTEm1dVQrTqnys0l1
 8oalRNswYlQmnYBwpwCkaTHLMHwKfGBbo5dLPEshtVowI6nsgqLTyQHmqHYqUZYIpigmmC3S
 wBWY1V6ffUEmkqpAACEnL4/gUgn7yQ/5d0seqnAq2pSBHMUUoCcTzEQUWVkiDv3Rk7hTFmhT
 sMq78xv2XRsXMR6yQhSTPFZCYDUExElEsSo9FWHWr6zHyYcc8qDLFvG9FPhmQuT2s9Blx6gI
 323GnEq1lwWPJVzP4jQkJKIAXwFpv+W8CWLqzDWOvdlrDaTaVMscFTeH5W6Uprl65jqFQGMp
 cRGCs8GCUW13H0IyOtQtwWXA4ny+SL81pviAmaSXU8laKaRu91VOVaF9f4sAEQEAAcLBXwQY
 AQIACQUCW3qAEwIbDAAKCRCUgewPEZDy2+oXD/9cHHRkBZOfkmSq14Svx062PtU0KV470TSn
 p/jWoYJnKIw3G0mXIRgrtH2dPwpIgVjsYyRSVMKmSpt5ZrDf9NtTbNWgk8VoLeZzYEo+J3oP
 qFrTMs3aYYv7e4+JK695YnmQ+mOD9nia915tr5AZj95UfSTlyUmyic1d8ovsf1fP7XCUVRFc
 RjfNfDF1oL/pDgMP5GZ2OwaTejmyCuHjM8IR1CiavBpYDmBnTYk7Pthy6atWvYl0fy/CqajT
 Ksx7+p9xziu8ZfVX+iKBCc+He+EDEdGIDhvNZ/IQHfOB2PUXWGS+s9FNTxr/A6nLGXnA9Y6w
 93iPdYIwxS7KXLoKJee10DjlzsYsRflFOW0ZOiSihICXiQV1uqM6tzFG9gtRcius5UAthWaO
 1OwUSCQmfCOm4fvMIJIA9rxtoS6OqRQciF3crmo0rJCtN2awZfgi8XEif7d6hjv0EKM9XZoi
 AZYZD+/iLm5TaKWN6oGIti0VjJv8ZZOZOfCb6vqFIkJW+aOu4orTLFMz28aoU3QyWpNC8FFm
 dYsVua8s6gN1NIa6y3qa/ZB8bA/iky59AEz4iDIRrgUzMEg8Ak7Tfm1KiYeiTtBDCo25BvXj
 bqsyxkQD1nkRm6FAVzEuOPIe8JuqW2xD9ixGYvjU5hkRgJp3gP5b+cnG3LPqquQ2E6goKUML AQ==
Message-ID: <008bf9da-b2eb-8858-a58b-4252b7920856@gmx.net>
Date:   Wed, 5 Jun 2019 22:15:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6f40f43ed32c5c519761879245423f7c371e4ae6.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:TijECVh98arPrcmwN3J8EqR3bttBi4JP2mkLKSUCsKLttPAEda6
 vgUKwT6larHeCrNof/v6AeWluYqdpyICbs1C6QLuSTvT6m6GHgZzHa4efCHhGr+9alKGNgJ
 kspPB4/jMmsDDi94JiTvMhYqDguCkXj6gxGRHLJcy289xmKFRHqdU4t06wRU9aiAlpkLjYl
 BeU3PI5fh+IsAUe8cZb2Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wjRpJFh5V5Q=:sXUFJUqTYNiSwsF5XvN/yW
 w+4gVP272Vh513kJHKFVldzPTVSDiUmTsQRLNaq29uvqusIl8hnEHaimvN7A0Ljfjkpc9+zke
 aQIPueHWT2506vFI/YBANiZ3RoqyAX3n1wZChg7zfTHmgAq+8bV4cTxgvFCu44prF9/nI/Q3o
 +Bonq/81uuNf/jPyqIv1+zfUXopiuiLPEqaFstodjh2gfWHf6qgd8lVSZtT8auEJf2x0VTcVQ
 +iFffj5JbT+/XKMPXYLMJG6sCFs3US+po7KfJN2lxsRn3+r19K+F+XP2/8J06XlC+N/fc58X/
 4JtGgAR9Mp8G5FAC65XMTufHkdCBi7c+sdC3FR1e5I4PlN6Cl0Ya8Av2LKapzZ2b8eQRl4APo
 7gZsr2iTBVJaCQLhSPPaYbtrVwUm5AlBiAEv9wFOQ8zfbDTHB4ROFp+i1B7cG8MtdM8rFyAf3
 hbGwv2gWDTxriHf4FpY1yWyDr6j9D7k4PvtQa9yior25PCNrULM0ySc8QC3WDZDowHkmeiRm4
 z1v6bIalnMiHPdKB0EI+Py4lRynA+GZUnwZdLEPBTi86rnl7ulqmVskitd0HNxS2FPGrUChmx
 OKE8epnMuizky9pEvj1s0N6bKPQy0497avYNBjaoUhbe7YCfVc2J12KNtdCnUDO5PxP4Bnorj
 LeXmGuvkyzN3IMz+OPGd3Hm5fUJMCiKvRvIjJZqfAPYqVGaDMh734zPi6a2/2WV++JkcnwByP
 qrEGHjy+V9CAgRaM0C1y844Sx4eDFvqNVExmvwEPXPH5zc/pOsWAJcZBnFfdTRzNwBvFvJ3jx
 gRrAZvgjdGEj9/9weEKw67e55BuzZ3QCzkExCxZH/HwJObXxos9uVWk6DmxDEQzC6JjOFG/h5
 8vu7jyQII98OflI+C6k1GacIPu9rSFAlYyMv67Y1O8WxaM7P5KSSOew78X8VA6EbJeZeZCl+8
 KB2n8TZcdCOE3hKQmtAP/97XpogPc9ikz7vkEYlhKYPCvyK1S8/hQ
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Nicolas,

>> Am 05.06.19 um 13:00 schrieb Nicolas Saenz Julienne:
>>> Hi Stefan,
>>> thanks for the review, I took note of your code comments.
>>>
>>> On Wed, 2019-06-05 at 11:46 +0200, Stefan Wahren wrote:
>>>> Hi Nicolas,
>>>>
>>>> Am 04.06.19 um 19:32 schrieb Nicolas Saenz Julienne:
>>>>> Hi all,
>>>>> this series aims at adding cpufreq support to the Raspberry Pi fami=
ly of
>>>>> boards.
>>>>>
>>>>> The previous revision can be found at:=20
>>>>> https://lkml.org/lkml/2019/5/20/431
>>>>>
>>>>> The series first factors out 'pllb' from clk-bcm2385 and creates a =
new
>>>>> clk driver that operates it over RPi's firmware interface[1]. We ar=
e
>>>>> forced to do so as the firmware 'owns' the pll and we're not allowe=
d to
>>>>> change through the register interface directly as we might race wit=
h the
>>>>> over-temperature and under-voltage protections provided by the firm=
ware.
>>>> it would be nice to preserve such design decision in the driver as a=

>>>> comment, because the cover letter usually get lost.
>>>>> Next it creates a minimal cpufreq driver that populates the CPU's o=
pp
>>>>> table, and registers cpufreq-dt. Which is needed as the firmware
>>>>> controls the max and min frequencies available.
>>>> I tested your series on top of Linux 5.2-rc1 with multi_v7_defconfig=
 and
>>>> manually enable this drivers. During boot with Raspbian rootfs i'm
>>>> getting the following:
>>>>
>>>> [    1.177009] cpu cpu0: failed to get clock: -2
>>>> [    1.183643] cpufreq-dt: probe of cpufreq-dt failed with error -2
>>> This is surprising, who could be creating a platform_device for cpufr=
eq-dt
>>> apart from raspberrypi-cpufreq? Just to make things clear, you're usi=
ng the
>>> device tree from v5.2-rc1 (as opposed to the Raspbian one)?
>> sorry my fault, i thought it already has been replaced. The behavior i=
n
>> this unexpected case is fine, since it doesn't crash.
>>
>> I replaced the the DTB with the mainline one, but now i'm getting this=
:
>>
>> [    4.566068] cpufreq: cpufreq_online: CPU0: Running at unlisted freq=
:
>> 600000 KHz
>> [    4.580690] cpu cpu0: dev_pm_opp_set_rate: Invalid target frequency=
 0
>> [    4.594391] cpufreq: __target_index: Failed to change cpu frequency=
: -22
> For the record this fixes it:
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index aa51756fd4d6..edb71eefe9cf 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1293,7 +1293,7 @@ static int clk_core_determine_round_nolock(struct=
 clk_core
> *core,
>         } else if (core->ops->round_rate) {
>                 rate =3D core->ops->round_rate(core->hw, req->rate,
>                                              &req->best_parent_rate);
> -               if (rate < 0)
> +               if (IS_ERR_VALUE(rate))
>                         return rate;
>
>                 req->rate =3D rate;
>
> round_rate() returns a 'long' value, yet 'pllb' in rpi3b+ goes as high =
as
> 2.8GHz, which only fits in an 'unsigned long'. This explains why I didn=
't see
> this issue with RPI2b.

Okay, i understand the problem. But the patch doesn't look like the
proper fix to me.

Maybe the better way is to implement determine_rate instead of
round_rate in the clock driver. AFAICS this provides the necessary
unsigned long.

>
> I'll add the patch to the series.
>
> Regards,
> Nicolas

