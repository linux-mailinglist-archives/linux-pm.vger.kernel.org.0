Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C17F2169
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 23:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfKFWKn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 17:10:43 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40231 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfKFWKn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 17:10:43 -0500
Received: by mail-ed1-f67.google.com with SMTP id p59so150944edp.7;
        Wed, 06 Nov 2019 14:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SDr75JeUJsJ8dZL/F1Be4/O1quSb0nw2X9hrHND8Y8U=;
        b=GANudTF+1UsLE9mwYGatQdZ9xW827oG/pClc3lKYYg/7SRSfh4AxD+YbTxwiEof0xS
         7I8Hj4e+3LyJT+sS2AdizrwRxnmhCvo89bfMYafgivJ4ZGei4MSMxELjSnOyEg4/hiYw
         JEOXqc1W8chNN1+jU48HL1C/M4S1HHHfn/tjxmNTPlD+U88n9lZd/WdP9rMS0kVmfT9E
         j2802XFtbb0aCZtx09n7Bq9jT+D6aIln6u7htKHyO5Pn2ouMdF2Tt6M2LkuPdCFWyP3a
         ZetB760Ovy1LyLCDpvlPiKI55/WzLE2nJ1hnoYXI3F/sDYOCHGDrlgePZLZ9NgJtZCKQ
         RQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SDr75JeUJsJ8dZL/F1Be4/O1quSb0nw2X9hrHND8Y8U=;
        b=IExiqUMGmlfBUsbViLEtc9iHe+eg6zaP7sAPybNPjeTsF2r1macOsMwFX3F1pchMIc
         Rvh50oC6RdnhcCSAgxNlROw17rr5sNUPZcoLsm0qzFuUVDn+wHvwBBcLVaFCBzShqZBD
         /t907aPWGVRgeTOyxsnng6tlIWPixtFPEDVIHYWQbEHwf7GiAp/7NinKospYhc7TQ7iS
         F+/vzyHTNdVGP2wD4IXWviw5QPLv1cM9msuzePRZhEYYK7GnYf/y8Q8rVUp3Ags1uLff
         +BUGKstuF0Owt2Lp3YghpUKYR2XynXjmX1DYGYs7/+g8EQ9su1umve6+x3UM6+LN++r/
         FeAg==
X-Gm-Message-State: APjAAAVTpO0vR+F+ysyFbBREo2QVQ8RMOAYAl/QTs4pu4pNDAREWHVvj
        DG5be0Gwqnx7ijhqdH+Vcu0=
X-Google-Smtp-Source: APXvYqwG75vte35QkvT6lDd1vdJ/jH+dGJ7ahEnC2vQZyVqVLeC5SH0ROIIEHzS74SFsspMtbQEEVQ==
X-Received: by 2002:aa7:d842:: with SMTP id f2mr49149eds.262.1573078240727;
        Wed, 06 Nov 2019 14:10:40 -0800 (PST)
Received: from [10.67.50.53] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m20sm1280edb.60.2019.11.06.14.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 14:10:40 -0800 (PST)
Subject: Re: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
 <1553701479.2561.38.camel@pengutronix.de>
 <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
 <1553702767.2561.40.camel@pengutronix.de>
 <85c91392-9cbf-a5fc-b037-3d58f2b0ac9c@arm.com>
 <cb2e5521cc0d29b7c3ac42a6717256ec2e8d35e6.camel@nxp.com>
 <20190328104542.GA27459@e107981-ln.cambridge.arm.com>
 <ebf1b5f3-1612-9dae-72bb-cc67be69ebf2@gmail.com>
 <VI1PR04MB7023BCCCE80A02B00F5F2ED0EE790@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <8e5de17a-b81b-fa92-3ffc-58ddb5b864b3@gmail.com>
Date:   Wed, 6 Nov 2019 14:10:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023BCCCE80A02B00F5F2ED0EE790@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/6/19 1:31 PM, Leonard Crestez wrote:
> On 06.11.2019 22:15, Florian Fainelli wrote:
>> On 3/28/19 3:45 AM, Lorenzo Pieralisi wrote:
>>> On Wed, Mar 27, 2019 at 06:40:07PM +0000, Leonard Crestez wrote:
>>>> On Wed, 2019-03-27 at 17:45 +0000, Marc Zyngier wrote:
>>>>> On 27/03/2019 16:06, Lucas Stach wrote:
>>>>>> Am Mittwoch, den 27.03.2019, 15:57 +0000 schrieb Marc Zyngier:
>>>>>>> On 27/03/2019 15:44, Lucas Stach wrote:
>>>>>>>> Am Mittwoch, den 27.03.2019, 13:21 +0000 schrieb Abel Vesa:
>>>>>>>>> This work is a workaround I'm looking into (more as a background task)
>>>>>>>>> in order to add support for cpuidle on i.MX8MQ based platforms.
>>>>>>>>>
>>>>>>>>> The main idea here is getting around the missing GIC wake_request signal
>>>>>>>>> (due to integration design issue) by waking up a each individual core through
>>>>>>>>> some dedicated SW power-up bits inside the power controller (GPC) right before
>>>>>>>>> every IPI is requested for that each individual core.
>>>>>>>>
>>>>>>>> Just a general comment, without going into the details of this series:
>>>>>>>> this issue is not only affecting IPIs, but also MSIs terminated at the
>>>>>>>> GIC. Currently MSIs are terminated at the PCIe core, but terminating
>>>>>>>> them at the GIC is clearly preferable, as this allows assigning CPU
>>>>>>>> affinity to individual MSIs and lowers IRQ service overhead.
>>>>>>>>
>>>>>>>> I'm not sure what the consequences are for upstream Linux support yet,
>>>>>>>> but we should keep in mind that having a workaround for IPIs is only
>>>>>>>> solving part of the issue.
>>>>>>>
>>>>>>> If this erratum is affecting more than just IPIs, then indeed I don't
>>>>>>> see how this patch series solves anything.
>>>>>>>
>>>>>>> But the erratum documentation seems to imply that only SGIs are
>>>>>>> affected, and goes as far as suggesting to use an external interrupt
>>>>>>> would solve it. How comes this is not the case? Or is it that anything
>>>>>>> directly routed to a redistributor is also affected? This would break
>>>>>>> LPIs (and thus MSIs) and PPIs (the CPU timer, among others).
>>>>>>
>>>>>> Anything that isn't visible to the GPC and requires the GIC
>>>>>> wake_request signal to behave as specified is broken by this erratum.
>>>>>
>>>>> I really wonder how a timer interrupt (a PPI, hence not routed through
>>>>> the GPC) can wake up the CPU in this case. It really feels like
>>>>> something like "program CNTV_CVAL_EL0 to expire at some later point;
>>>>> WFI" could result in the CPU going to a deep sleep state, and not
>>>>> wake-up at all.
>>>>
>>>> This is already a common issue for cpuidle implementions handled by the
>>>> "local-timer-stop" property. imx has other timer blocks in the SOC,
>>>> they generate SPIs which are connected to GPC.
>>>
>>> It is not a common issue. The tick-broadcast mechanism relies on
>>> IPIs that are sent to specific CPUs upon timer expiry.
>>>
>>> If IPIs don't work for CPUs in shutdown state (which is what this patch
>>> is fixing AFAIU), the only reason I can see how a CPU can resume from
>>> idle on a timer expiry is the GPC waking up all cores upon the global
>>> timer SPI; if that's the case there is precious little point in
>>> implementing CPUidle at all - too bad people worked hard to implement
>>> NOHZ in a power efficient manner.
>>>
>>>>> This would indicate that not only cpuidle is broken with this, but
>>>>> absolutely every interrupt that is not routed through the GPC.
>>>>
>>>> Yes, cpuidle is broken for irqs not routed through GPC. However:
>>>>
>>>> * All SPIs are connected to GPC in a 1:1 mapping
>>>> * This series deals with SGIs
>>>> * The timer PPIs are not required; covered by local-timer-stop
>>>> * LPIs are currently unused (I understand imx-pci uses SPI by default
>>>> from Lucas)
>>>>
>>>> Anything missing?
>>>
>>> Yes, LPIs must be able to wake up CPUs and only the CPU for which
>>> an IRQ is actually pending.
>>>
>>> >From an architectural perspective, an ARM core executing the WFI
>>> instruction must resume execution upon an IRQ occurrence targeted
>>> at it and that's true regardless of the idle state entered.
>>>
>>> Anything deviating from this behaviour is not architecture compliant.
>>
>> What if you enter a deeper state than WFI, which leads to the power
>> gating of your CPU core, and you are missing the necessary hardware that
>> should be driven from the GIC's nIRQOUT/nFIQOUT signals to automatically
>> bring the core back on upon the GIC seeing a pending interrupt targeting
>> that core?
> 
> imx8mq has a secondary "GPC" block which receives SPIs and can wake the 
> cores. Do you have something similar? Because if you only have the GIC 
> then that sounds much worse: you'd have to ensure that all peripheral 
> interrupts are routed away from sleeping cores.

We have a legacy interrupt controller that receives all SPIs as well,
and it can be used as a full replacement for the GIC (with the loss of
nVIRQ/nFIQ) but it cannot wake-up the cores unfortunately. This is all
custom logic, so we could have done at least wake-up based on SPIs, but
we missed that apparently, at least we were consistent.

Out of curiosity, does your GPC somehow know the affinity of a given
interrupt to a particular core?

> 
> On IMX only SGIs need special treatment and a newer version just 
> replaces __smp_cross_call in a platform-specific manner:
> 
>      https://lkml.org/lkml/2019/6/10/350

Right, because for PPIs you leverage the timer broadcast and for SPIs
you have that GPC, so all your left are the remaining "intra GIC"
interrupts which are SGIs.

> 
>> Would it be acceptable in that case to "help" the platform by ensuring
>> that there is at least one core that is not allowed to enter the deepest
>> idle state and be able to help wake back up the others? I am asking
>> because I am facing a similar issue to what Abel is trying to solve here
>> with ARCH_BRCMSTB platforms which do not have the ability to have their
>> CPU cores wake-up on their once power gated.
> 
> Maybe you can workaround in ATF: if (last_core) wfi(); else powerdown();

Yes, that would certainly work, the biggest problem in my case is
dealing with SPIs, since we still have no way to wake-up from those,
other than by getting the help of another CPU that is not power gated.
Lovely, I know.

> 
> But you still need special treatment for interrupts targeted at gated cores.
> 
>>>> My understanding is that this wake request feature via GIC is new in v3
>>>> and this is maybe why HW team missed it during integration. Older
>>>> imx6/7 has GICv2 and has deep idle states which always rely on GPC to
>>>> wakeup so the approach can work.
>>>
>>> If HW designers really wanted to have sensible power management policy
>>> in this SoC they would have paid attention, I am against patching the
>>> kernel heavily to fix a platform bug.
> 
>> HW designers may not be aware of how the cpuifle framework operates or
>> what its constraints are, so they may not understand that any interrupt,
>> must be able to autonomously (with lack of a better name) wake-up a
>> given core, given any idle state it has entered.
> 
> My understanding is that this is a requirement of GICv3 architecture.
> 

The systems I use have a GICv2 architecture though this is still no
excuse for not having hooked the nIRQOUT/nFIQOUT to a power management
controller, this is clearly an oversight, and it should have been
possible to automatically take a core out of power gating, since we did
design our own power gating logic, but this was done that way. Hopefully
future designs can remedy that, designers are aware of why this is a
problem now.
--
Florian
