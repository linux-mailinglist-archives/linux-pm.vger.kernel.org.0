Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC097521D
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 17:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbfGYPHg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 11:07:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58501 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388736AbfGYPHf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 11:07:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190725150733euoutp015aacb6a1eee821b7e2ccddaad2940d36~0ruFm35nD1510415104euoutp01n
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 15:07:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190725150733euoutp015aacb6a1eee821b7e2ccddaad2940d36~0ruFm35nD1510415104euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564067253;
        bh=KMR+yHrr6Lsx+SAlQwuxyLppRvSG65o1a3cPzAiZ3eY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=quKUtOtcSVLSKjsQ6VPUnGaY07Abnm03laIrVGXSYKyhJrtTVozzcubYVQTyNVMqI
         8JS6zR3tg/Ywh6sEwG6Be/c+L1OmD81Wa/hFOln1eHZrTkbRWp90SUWNpIV9e3yPNU
         /QGBJBJ1A1XD/kTYhbaoyt+FvdmsDXFeKqRv97ns=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190725150732eucas1p1b60118aafc1452cfd76098ce4cfc2f9e~0ruE0-g-w1842318423eucas1p1N;
        Thu, 25 Jul 2019 15:07:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B2.54.04325.4B5C93D5; Thu, 25
        Jul 2019 16:07:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190725150731eucas1p298d791d9323c8a01c55549d8419d4a08~0ruD_4PB71393413934eucas1p2h;
        Thu, 25 Jul 2019 15:07:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190725150731eusmtrp1d6c4b6a66e45b632987803de77157a7c~0ruDwcD9q2337023370eusmtrp1k;
        Thu, 25 Jul 2019 15:07:31 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-76-5d39c5b496a1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 84.C0.04146.3B5C93D5; Thu, 25
        Jul 2019 16:07:31 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190725150730eusmtip21bae62c8558c204244444a32360ef201~0ruDAG6Dz1452814528eusmtip2T;
        Thu, 25 Jul 2019 15:07:30 +0000 (GMT)
Subject: Re: [PATCH v4 1/5] devfreq: exynos-bus: correct clock enable
 sequence
To:     cwchoi00@gmail.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-ID: <a7aba1d0-8e15-ae23-aff9-bf35f991ecb7@partner.samsung.com>
Date:   Thu, 25 Jul 2019 17:07:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH0=skWJ3Dny7voeRzDp5oRkbNO=Pf6j+PM03=epmX-86g@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvZ2ZzkAsuRaUE9ybaBADaNRw3Zeo6aP45ALRChNQW9QOi2ii
        BVwJIKJRqQiIxRJksQUFUQmBYtkJGgUhhLK5ggmLW1CRdmrk7Tv/+c89508uR8k/M17c4YhI
        XhuhUiukrvTjFz9bfEtr1wavKG5eSky3ihnSPv6eIe9ql5MsSwtDrvR/pkhr60OWNMcPscTc
        /4YhryoypGQs2YLIrdZKCSm0dLMkt71NQrri8qRk6EezhJx/bmHJnzcmmpTYXki3yJUFmQVI
        +UTfzSrN+ZelyhLDWWVKaT5SWjvKJMox84Jd7D7XDaG8+nA0r/XfdNA1PH3wrfR42fyTxTkF
        Eh3q8UhELhzg1VCffJ5ORK6cHOchMFQYGLEYRzCR3YfEYgxB/Ogg+jeSbOh1uowIRr7nsWIx
        jOCe0UTZXe54FxSaciR29sBzoOzGgOMpCrcw8OrtA0dDigOgr6zJwTK8E+LTXzqYxkvgY66O
        tfNsvAdGbTWM6JkF9ekDtJ1dcCAkFLY6/BT2hM6BLCcvhIRHtyn7MsBXOch4ncCKd2+HpL5c
        ZwZ3+GQtderzoPFaEi1yDAzeTWHF4XMIbBdHnI31UGNtm7qCm9qwDIor/EV5K9TVWRwyYDfo
        GJ4l3uAGaY9vUqIsg0sX5KLbFzInmxiR50LiZBGTihT6acn009Lop6XR/9+bjeh85MlHCZow
        XlgVwcf4CSqNEBUR5hdyTGNGU1+w8Y/1azmq/HWoGmEOKWbKvPPXBssZVbQQq6lGwFEKD9mj
        8ilJFqqKPcVrjx3QRql5oRrN5WiFp+z0DNt+OQ5TRfJHef44r/3XlXAuXjp0VZ1acTr7zprx
        4W0bLQs+6GIHSkJH2JCimlVxWYGLcj4N1+7Y1GusafgShq+t+90lnDkyzxDU85TS/LgebiPf
        vb6dvY/JiZE8L58qm0+Om9HbbAxK607bO9mUMhE9mrhTXaVbmZuaYt091DIRYJHr6zvjkoTM
        3mdLvBebPBo2/1bQQrhqpQ+lFVR/Ab7LeUl+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xe7qbj1rGGtxpUbfYOGM9q8X1L89Z
        LZ4d1baYf+Qcq0X/49fMFufPb2C3ONv0ht1i0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFm9+nGWyaN17hN3i37WNLBabHxxjcxDyWDNvDaPHzll32T02repk89i8pN6j
        b8sqRo/jN7YzeXzeJBfAHqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
        k5Kak1mWWqRvl6CXMfPpTbaC7bIV6xetYWpgvC/SxcjJISFgItG75CFrFyMXh5DAUkaJfXsb
        2SES0hKNp1czQdjCEn+udbGB2EICrxklfn+tAbGFBfwknj5vYASxRQTEJLZPe8IIMohZ4BKr
        xJnj+1kgps5ikngw9xZYFZuAucSj7WfApvIKuEk0zbwEZrMIqEq8XNoAtllUIELi8I5ZjBA1
        ghInZz5hAbE5BQIlmteeB6tnFlCX+DPvEjOELS5x68l8qLi8RPPW2cwTGIVmIWmfhaRlFpKW
        WUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM+m3Hfm7ewXhpY/AhRgEORiUe3gvL
        LWOFWBPLiitzDzFKcDArifBu3QEU4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5HxgQsoriTc0
        NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cAYzKF6qjpsx/3Sr/wd3NeE
        a1dcmxL9+8LyNflsmTdC554yu76D+2S/YKaUYfYPTdvIxK+N16cHpTxaZbbGTurSDOngtwfv
        cDmr7Hlyy/H/KUvXjX0K/Gdr5e5kbCxxXPiTZ1rbKsc1V2LjnL2OXSloXalun1bFdFVv2Ynt
        h47sXrc3WfPU+eyXSizFGYmGWsxFxYkACYpdWhADAAA=
X-CMS-MailID: 20190725150731eucas1p298d791d9323c8a01c55549d8419d4a08
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190725144325eucas1p1463ecde90f9c93cb73d3c54c7cf3f1ff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190725144325eucas1p1463ecde90f9c93cb73d3c54c7cf3f1ff
References: <CGME20190725144325eucas1p1463ecde90f9c93cb73d3c54c7cf3f1ff@eucas1p1.samsung.com>
        <20190725144300.25014-1-k.konieczny@partner.samsung.com>
        <20190725144300.25014-2-k.konieczny@partner.samsung.com>
        <CAGTfZH0=skWJ3Dny7voeRzDp5oRkbNO=Pf6j+PM03=epmX-86g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 25.07.2019 16:59, Chanwoo Choi wrote:
> Hi,
> 
> You are missing my Acked tag.

I changed code, so I can not add your Ack in v4.
Please send new Ack for this patch.

> 2019년 7월 25일 (목) 오후 11:44, <k.konieczny@partner.samsung.com>님이 작성:
>>
>> Regulators should be enabled before clocks to avoid h/w hang. This
>> require change in exynos_bus_probe() to move exynos_bus_parse_of()
>> after exynos_bus_parent_parse_of() and change in error handling.
>> Similar change is needed in exynos_bus_exit() where clock should be
>> disabled before regulators.
>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>> ---
>> Changes:
>> v4:
>> - move regulator disable after clock disable
>> - remove unrelated changes
>> - add disabling regulators in error path in exynos_bus_probe()
>>
>> ---
>>  drivers/devfreq/exynos-bus.c | 31 +++++++++++++++++--------------
>>  1 file changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>> index 486cc5b422f1..f34fa26f00d0 100644
>> --- a/drivers/devfreq/exynos-bus.c
>> +++ b/drivers/devfreq/exynos-bus.c
>> @@ -194,11 +194,10 @@ static void exynos_bus_exit(struct device *dev)
>>         if (ret < 0)
>>                 dev_warn(dev, "failed to disable the devfreq-event devices\n");
>>
>> -       if (bus->regulator)
>> -               regulator_disable(bus->regulator);
>> -
>>         dev_pm_opp_of_remove_table(dev);
>>         clk_disable_unprepare(bus->clk);
>> +       if (bus->regulator)
>> +               regulator_disable(bus->regulator);
>>  }
>>
>>  /*
>> @@ -386,6 +385,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>         struct exynos_bus *bus;
>>         int ret, max_state;
>>         unsigned long min_freq, max_freq;
>> +       bool passive = false;
>>
>>         if (!np) {
>>                 dev_err(dev, "failed to find devicetree node\n");
>> @@ -399,27 +399,27 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>         bus->dev = &pdev->dev;
>>         platform_set_drvdata(pdev, bus);
>>
>> -       /* Parse the device-tree to get the resource information */
>> -       ret = exynos_bus_parse_of(np, bus);
>> -       if (ret < 0)
>> -               return ret;
>> -
>>         profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
>> -       if (!profile) {
>> -               ret = -ENOMEM;
>> -               goto err;
>> -       }
>> +       if (!profile)
>> +               return -ENOMEM;
>>
>>         node = of_parse_phandle(dev->of_node, "devfreq", 0);
>>         if (node) {
>>                 of_node_put(node);
>> -               goto passive;
>> +               passive = true;
>>         } else {
>>                 ret = exynos_bus_parent_parse_of(np, bus);
>> +               if (ret < 0)
>> +                       return ret;
>>         }
>>
>> +       /* Parse the device-tree to get the resource information */
>> +       ret = exynos_bus_parse_of(np, bus);
>>         if (ret < 0)
>> -               goto err;
>> +               goto err_reg;
>> +
>> +       if (passive)
>> +               goto passive;
>>
>>         /* Initialize the struct profile and governor data for parent device */
>>         profile->polling_ms = 50;
>> @@ -510,6 +510,9 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>  err:
>>         dev_pm_opp_of_remove_table(dev);
>>         clk_disable_unprepare(bus->clk);
>> +err_reg:
>> +       if (!passive)
>> +               regulator_disable(bus->regulator);
>>
>>         return ret;
>>  }
>> --
>> 2.22.0
>>
> 
> 

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

