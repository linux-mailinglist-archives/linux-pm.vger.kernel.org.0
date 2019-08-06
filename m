Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A6883CFF
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 23:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfHFVyY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 17:54:24 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6328 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfHFVyY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 17:54:24 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d49f70d0000>; Tue, 06 Aug 2019 14:54:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 06 Aug 2019 14:54:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 06 Aug 2019 14:54:22 -0700
Received: from [10.110.102.151] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Aug
 2019 21:54:18 +0000
Subject: Re: [PATCH v7 01/20] pinctrl: tegra: Add suspend and resume support
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <linus.walleij@linaro.org>, <stefan@agner.ch>,
        <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <rjw@rjwysocki.net>,
        <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
 <1564607463-28802-2-git-send-email-skomatineni@nvidia.com>
 <6b1482f6-0578-f602-d8d1-541d86303ce2@gmail.com>
 <b45ca99a-188a-c695-3f3d-48d273808f9c@nvidia.com>
 <36351140-afd4-38c4-3722-4ee0894287fa@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <961ceece-f42a-b933-9184-97e9d30ea381@nvidia.com>
Date:   Tue, 6 Aug 2019 14:54:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <36351140-afd4-38c4-3722-4ee0894287fa@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565128463; bh=PVOjXIF+h+isaZujY/+iB+zLIz1zcPjtFjV9ZXA4++s=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=a3WZIm9XcXwus1d36RFmpHdqXZHFkFcDczX0E1fQhmQZlYCIoC3p1cAKACHZoJ51L
         zmiGE5+ZLVbes5JkcO1DEKwZOv44Oio7LW7JngdMWVcWv19fF00FBcDyvl0QO75vku
         3VhkchAk7YLUw108KAwmJKT5NpIGc48m6lMAFd5D39T59FtF3OhBtrWyHav2Xi18Dd
         0p3d8TiiR0Re6ikOPHJvJSUZKdWpn9+09aThtpIynYuNEhygJK+/F20l6X+RDLV2E7
         VOckSGhgSDh1xp+BaVcw6zEwJJI7jAiRm7jiidyUOB5AEOxIupaDDXqaZ/TQ3dPkzC
         XGRzKbwX2A+Gg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/6/19 10:59 AM, Dmitry Osipenko wrote:
> 05.08.2019 21:06, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 8/5/19 3:50 AM, Dmitry Osipenko wrote:
>>> 01.08.2019 0:10, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> This patch adds support for Tegra pinctrl driver suspend and resume.
>>>>
>>>> During suspend, context of all pinctrl registers are stored and
>>>> on resume they are all restored to have all the pinmux and pad
>>>> configuration for normal operation.
>>>>
>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>> ---
>>>>  =C2=A0 drivers/pinctrl/tegra/pinctrl-tegra.c | 59
>>>> +++++++++++++++++++++++++++++++++++
>>>>  =C2=A0 drivers/pinctrl/tegra/pinctrl-tegra.h |=C2=A0 3 ++
>>>>  =C2=A0 2 files changed, 62 insertions(+)
>>>>
>>>> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c
>>>> b/drivers/pinctrl/tegra/pinctrl-tegra.c
>>>> index 186ef98e7b2b..e3a237534281 100644
>>>> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
>>>> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
>>>> @@ -631,6 +631,58 @@ static void
>>>> tegra_pinctrl_clear_parked_bits(struct tegra_pmx *pmx)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 }
>>>>  =C2=A0 +static size_t tegra_pinctrl_get_bank_size(struct device *dev,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int bank=
_id)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct platform_device *pdev =3D to_platform_devic=
e(dev);
>>>> +=C2=A0=C2=A0=C2=A0 struct resource *res;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM=
, bank_id);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return resource_size(res) / 4;
>>>> +}
>>>> +
>>>> +static int tegra_pinctrl_suspend(struct device *dev)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct tegra_pmx *pmx =3D dev_get_drvdata(dev);
>>>> +=C2=A0=C2=A0=C2=A0 u32 *backup_regs =3D pmx->backup_regs;
>>>> +=C2=A0=C2=A0=C2=A0 u32 *regs;
>>>> +=C2=A0=C2=A0=C2=A0 size_t bank_size;
>>>> +=C2=A0=C2=A0=C2=A0 unsigned int i, k;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < pmx->nbanks; i++) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bank_size =3D tegra_pinctr=
l_get_bank_size(dev, i);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regs =3D pmx->regs[i];
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (k =3D 0; k < bank_siz=
e; k++)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *b=
ackup_regs++ =3D readl_relaxed(regs++);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return pinctrl_force_sleep(pmx->pctl);
>>>> +}
>>>> +
>>>> +static int tegra_pinctrl_resume(struct device *dev)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct tegra_pmx *pmx =3D dev_get_drvdata(dev);
>>>> +=C2=A0=C2=A0=C2=A0 u32 *backup_regs =3D pmx->backup_regs;
>>>> +=C2=A0=C2=A0=C2=A0 u32 *regs;
>>>> +=C2=A0=C2=A0=C2=A0 size_t bank_size;
>>>> +=C2=A0=C2=A0=C2=A0 unsigned int i, k;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < pmx->nbanks; i++) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bank_size =3D tegra_pinctr=
l_get_bank_size(dev, i);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regs =3D pmx->regs[i];
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (k =3D 0; k < bank_siz=
e; k++)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wr=
itel_relaxed(*backup_regs++, regs++);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>> I'm now curious whether any kind of barrier is needed after the
>>> writings. The pmx_writel() doesn't insert a barrier after the write and
>>> seems it just misuses writel, which actually should be writel_relaxed()
>>> + barrier, IIUC.
>> pmx_writel uses writel and it has wmb before raw_write which complete
>> all writes initiated prior to this.
>>
>> By misusing writel, you mean to have barrier after register write?
> Yes, at least to me it doesn't make much sense for this driver to stall
> before the write. It's the pinctrl user which should be taking care
> about everything to be ready before making a change to the pinctrl's
> configuration.
>
>>> It's also not obvious whether PINCTRL HW has any kind of write-FIFO and
>>> thus maybe read-back + rmb() is needed in order ensure that writes are
>>> actually completed.
>> I believe adding write barrier wmb after writel_relaxed should be good
>> rather than doing readback + rmb
>>> The last thing which is not obvious is when the new configuration
>>> actually takes into effect, does it happen immediately or maybe some
>>> delay is needed?
>>>
>>> [snip]
>> Based on internal design there is no internal delay and it all depends
>> on APB rate that it takes to write to register.
>>
>> Pinmux value change to reflect internally might take couple of clock
>> cycles which is much faster than SW can read.
> Still not quite obvious if it's possible to have a case where some
> hardware is touched before necessary pinctrl change is fully completed
> and then to get into trouble because of it.

To be safer, will add write barrier after all writes in resume and also=20
will have separate patch for pmx_writel fix to use writel_relaxed=20
followed by write barrier.

Thanks

Sowjanya

