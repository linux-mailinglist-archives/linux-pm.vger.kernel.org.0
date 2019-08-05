Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E87AB824A1
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 20:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfHESGH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 14:06:07 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8967 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfHESGH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 14:06:07 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d48700d0002>; Mon, 05 Aug 2019 11:06:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 05 Aug 2019 11:06:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 05 Aug 2019 11:06:04 -0700
Received: from [10.110.103.110] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Aug
 2019 18:06:03 +0000
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
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <b45ca99a-188a-c695-3f3d-48d273808f9c@nvidia.com>
Date:   Mon, 5 Aug 2019 11:06:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6b1482f6-0578-f602-d8d1-541d86303ce2@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565028366; bh=u9t5KV0bHB75n4lpd6FYtATWM0z27WV2yxpqjZZtxoc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=LmZso5Mdq6S+I0KfwQU77iIz1ylo93ZTYRz6BtZiUOsI9mJQ3tzZf/e7MP6RvTp7P
         Te+W1C6VZfAOyTG5eRVi14ZeGH6Q429HWebwZAhNqFrZEdD3ueab1hx2gCyVKtLFyf
         /K5nyn0FZyzlVdXVEku3aMJwN3meAjE2jHaVDpDp0Dl/SCARviwCIQZ6DrZvojFM7w
         3KImXiHDVDHjovUyAgDzsJ262Q2+NKa6zUv7zLUmvrAVCpMxrtJqG7RgFPLOhEQ+z2
         fnrpbFSr8vBHAhSzd3P3/kOrOHbbxokOAb2n+53lPQ6P+1ig9trEk5PK4XTN04lWqi
         g6z/VwJjUAZdA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/5/19 3:50 AM, Dmitry Osipenko wrote:
> 01.08.2019 0:10, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> This patch adds support for Tegra pinctrl driver suspend and resume.
>>
>> During suspend, context of all pinctrl registers are stored and
>> on resume they are all restored to have all the pinmux and pad
>> configuration for normal operation.
>>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/pinctrl/tegra/pinctrl-tegra.c | 59 +++++++++++++++++++++++++++=
++++++++
>>   drivers/pinctrl/tegra/pinctrl-tegra.h |  3 ++
>>   2 files changed, 62 insertions(+)
>>
>> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/teg=
ra/pinctrl-tegra.c
>> index 186ef98e7b2b..e3a237534281 100644
>> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
>> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
>> @@ -631,6 +631,58 @@ static void tegra_pinctrl_clear_parked_bits(struct =
tegra_pmx *pmx)
>>   	}
>>   }
>>  =20
>> +static size_t tegra_pinctrl_get_bank_size(struct device *dev,
>> +					  unsigned int bank_id)
>> +{
>> +	struct platform_device *pdev =3D to_platform_device(dev);
>> +	struct resource *res;
>> +
>> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, bank_id);
>> +
>> +	return resource_size(res) / 4;
>> +}
>> +
>> +static int tegra_pinctrl_suspend(struct device *dev)
>> +{
>> +	struct tegra_pmx *pmx =3D dev_get_drvdata(dev);
>> +	u32 *backup_regs =3D pmx->backup_regs;
>> +	u32 *regs;
>> +	size_t bank_size;
>> +	unsigned int i, k;
>> +
>> +	for (i =3D 0; i < pmx->nbanks; i++) {
>> +		bank_size =3D tegra_pinctrl_get_bank_size(dev, i);
>> +		regs =3D pmx->regs[i];
>> +		for (k =3D 0; k < bank_size; k++)
>> +			*backup_regs++ =3D readl_relaxed(regs++);
>> +	}
>> +
>> +	return pinctrl_force_sleep(pmx->pctl);
>> +}
>> +
>> +static int tegra_pinctrl_resume(struct device *dev)
>> +{
>> +	struct tegra_pmx *pmx =3D dev_get_drvdata(dev);
>> +	u32 *backup_regs =3D pmx->backup_regs;
>> +	u32 *regs;
>> +	size_t bank_size;
>> +	unsigned int i, k;
>> +
>> +	for (i =3D 0; i < pmx->nbanks; i++) {
>> +		bank_size =3D tegra_pinctrl_get_bank_size(dev, i);
>> +		regs =3D pmx->regs[i];
>> +		for (k =3D 0; k < bank_size; k++)
>> +			writel_relaxed(*backup_regs++, regs++);
>> +	}
> I'm now curious whether any kind of barrier is needed after the
> writings. The pmx_writel() doesn't insert a barrier after the write and
> seems it just misuses writel, which actually should be writel_relaxed()
> + barrier, IIUC.

pmx_writel uses writel and it has wmb before raw_write which complete=20
all writes initiated prior to this.

By misusing writel, you mean to have barrier after register write?

> It's also not obvious whether PINCTRL HW has any kind of write-FIFO and
> thus maybe read-back + rmb() is needed in order ensure that writes are
> actually completed.
I believe adding write barrier wmb after writel_relaxed should be good=20
rather than doing readback + rmb
>
> The last thing which is not obvious is when the new configuration
> actually takes into effect, does it happen immediately or maybe some
> delay is needed?
>
> [snip]

Based on internal design there is no internal delay and it all depends=20
on APB rate that it takes to write to register.

Pinmux value change to reflect internally might take couple of clock=20
cycles which is much faster than SW can read.

