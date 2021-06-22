Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBB23B03B6
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 14:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhFVMKG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 08:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhFVMKF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 08:10:05 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F23C061574;
        Tue, 22 Jun 2021 05:07:49 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id E8FC53F370;
        Tue, 22 Jun 2021 14:07:47 +0200 (CEST)
Subject: Re: [PATCH v6 1/5] cpuidle: qcom_spm: Detach state machine from main
 SPM handling
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jami.kettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        robh+dt@kernel.org
References: <20210621181016.365009-1-angelogioacchino.delregno@somainline.org>
 <20210621181016.365009-2-angelogioacchino.delregno@somainline.org>
 <YND/2qJhUB1Iwk1X@gerhold.net>
 <229488fe-00ef-ea7e-27d4-6f24fdea1383@somainline.org>
 <YNHR3hvoKsQe5mq8@gerhold.net>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <52045160-e9f9-26b9-5218-aaf9e8cfd205@somainline.org>
Date:   Tue, 22 Jun 2021 14:07:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YNHR3hvoKsQe5mq8@gerhold.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 22/06/21 14:04, Stephan Gerhold ha scritto:
> On Tue, Jun 22, 2021 at 01:39:15PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 21/06/21 23:08, Stephan Gerhold ha scritto:
>>> On Mon, Jun 21, 2021 at 08:10:12PM +0200, AngeloGioacchino Del Regno wrote:
>>>> In commit a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic
>>>> CPUidle driver") the SPM driver has been converted to a
>>>> generic CPUidle driver: that was mainly made to simplify the
>>>> driver and that was a great accomplishment;
>>>> Though, it was ignored that the SPM driver is not used only
>>>> on the ARM architecture.
>>>>
>>>
>>> I don't really understand why you insist on writing that I deliberately
>>> "ignored" your use case when converting the driver. This is not true.
>>> Perhaps that's not actually what you meant but that's how it sounds to
>>> me.
>>>
>>
>> So much noise for one single word. I will change it since it seems to be
>> that much of a deal, and I'm sorry if that hurt you in any way.
>>
>> For the records, though, I really don't see anything offensive in that,
>> and anyway I didn't mean to be offensive in any way.
>>
> 
> I try to put a lot of thought into my patches to make sure I don't
> accidentally break some other use cases. Having that sentence in the
> commit log does indeed hurt me a bit since I would never deliberately
> disregard other use cases without making it absolutely clear in the
> patch.
> 
> By using the word "ignored" ("deliberately not listen or pay attention
> to") [1] you say that I did, and that's why I would prefer if you
> reword this slightly. :)
> 

As I said, I will reword it.

> [1] https://en.wiktionary.org/wiki/ignore
> 
>>>> In preparation for the enablement of SPM features on AArch64/ARM64,
>>>> split the cpuidle-qcom-spm driver in two: the CPUIdle related
>>>> state machine (currently used only on ARM SoCs) stays there, while
>>>> the SPM communication handling lands back in soc/qcom/spm.c and
>>>> also making sure to not discard the simplifications that were
>>>> introduced in the aforementioned commit.
>>>>
>>>> Since now the "two drivers" are split, the SCM dependency in the
>>>> main SPM handling is gone and for this reason it was also possible
>>>> to move the SPM initialization early: this will also make sure that
>>>> whenever the SAW CPUIdle driver is getting initialized, the SPM
>>>> driver will be ready to do the job.
>>>>
>>>> Please note that the anticipation of the SPM initialization was
>>>> also done to optimize the boot times on platforms that have their
>>>> CPU/L2 idle states managed by other means (such as PSCI), while
>>>> needing SAW initialization for other purposes, like AVS control.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>>> ---
>>>>    drivers/cpuidle/Kconfig.arm        |   1 +
>>>>    drivers/cpuidle/cpuidle-qcom-spm.c | 324 +++++++----------------------
>>>>    drivers/soc/qcom/Kconfig           |   9 +
>>>>    drivers/soc/qcom/Makefile          |   1 +
>>>>    drivers/soc/qcom/spm.c             | 198 ++++++++++++++++++
>>>>    include/soc/qcom/spm.h             |  41 ++++
>>>>    6 files changed, 325 insertions(+), 249 deletions(-)
>>>>    create mode 100644 drivers/soc/qcom/spm.c
>>>>    create mode 100644 include/soc/qcom/spm.h
>>>>
>>>> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
>>>> index adf91a6e4d7d..091453135ea6 100644
>>>> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
>>>> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
>>>> [...]
>>>> +static int spm_cpuidle_register(int cpu)
>>>>    {
>>>> +	struct platform_device *pdev = NULL;
>>>> +	struct device_node *cpu_node, *saw_node;
>>>> +	struct cpuidle_qcom_spm_data data = {
>>>> +		.cpuidle_driver = {
>>>> +			.name = "qcom_spm",
>>>> +			.owner = THIS_MODULE,
>>>> +			.cpumask = (struct cpumask *)cpumask_of(cpu),
>>>> +			.states[0] = {
>>>> +				.enter			= spm_enter_idle_state,
>>>> +				.exit_latency		= 1,
>>>> +				.target_residency	= 1,
>>>> +				.power_usage		= UINT_MAX,
>>>> +				.name			= "WFI",
>>>> +				.desc			= "ARM WFI",
>>>> +			}
>>>> +		}
>>>> +	};
>>>
>>> The stack is gone after the function returns.
>>>
>>
>> Argh, I wrongly assumed that cpuidle was actually copying this locally.
>> Okay, let's see what else looking clean I can come up with.
> 
> I guess you could just use a devm_kzalloc() and then have code similar
> to the previous one (data->cpuidle_driver = <template>). You could
> alternatively use devm_kmalloc() without zero-initialization but the
> advantages of that should be negligible.
> 

Yes that would indeed work. It's just that I really don't like it.

> Thanks!
> Stephan
> 

