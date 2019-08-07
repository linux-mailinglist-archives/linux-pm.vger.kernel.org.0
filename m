Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC0A84E96
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 16:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfHGOVX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 10:21:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36263 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729968AbfHGOVX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 10:21:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so6412259ljj.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2019 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ym3TWnNJEGFgpteRuO2hxD/LdHQA3MDsH07HbJofTfQ=;
        b=INI+HycjT3+g4qBx9Ko5IoZjmKKYITZXt33h42PGL4N4OFmj4XRfzycycphtJLGrEr
         hvhZ40Ag3dRe6Zqw6qglZV/I0D1HMs6W3oiJtQbJunhuUcivoYQpQRF7Io1n2yFLn4er
         VDv+j3c2O6IruavHGhCEIEfI48WfWSLFarEAh3qELg1H3kYJVBE0O37FORW3scp+WAkx
         gg0qVrUYF56BxCuDfSZgHcS6n0K/yUvYiSnTs8NfqRTxo3d+JOevUhhq4DH7ecvcHzzq
         W1OLejawnQSEzC2/hozP0ETdmb+t3rCSzwOpHHXkdVO5KDQ4LTcWwzTNbhROzi8PjiGN
         VY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ym3TWnNJEGFgpteRuO2hxD/LdHQA3MDsH07HbJofTfQ=;
        b=EX8SwiSCgC49n3bV4ZIHBJV44865mcnyC/asSxifooMytzvl5pETByipObu75+mbTp
         i7pdDY5t1/Bq9NcpdHOeZty3VKDDgUjhl93KHrEVM938+zzHOvAv4tjC68K2nJ1138g5
         zX8XOwBwIEgC6M9KA778PrDgYC6MmuC/qnbPV3c0iCIQhzgYNLzl6fjOrsUIrZUsUisp
         N5VVQmTjldypOLgu8gkKKxaa8uDckIcW6WjMeKH6NjLlM4gLE9QGsuclTVFKQP4kBnHe
         KUnTQPCLxDPMU64Gq55W+M6pFNlByDOAfWd1NFntdKCpyTjxe0pJbfHKhv2ChSFCChTt
         FSrw==
X-Gm-Message-State: APjAAAXvbERqsLaV4UponO7FG6LqZYfOOQNn3TBBgYildS9tj/Lw8Gtd
        16ffdvTJtvOBvRLrx+PVaxuzEg==
X-Google-Smtp-Source: APXvYqxcQ5lxNvBv2pxpv7dxod4WchOzutIsq7iwKp5scxXoeS4ecQlLYFiSdRaDVQjZg8kQ68gzuA==
X-Received: by 2002:a2e:65ca:: with SMTP id e71mr5113463ljf.61.1565187679266;
        Wed, 07 Aug 2019 07:21:19 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id q17sm3417148lfa.82.2019.08.07.07.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 07:21:18 -0700 (PDT)
Subject: Re: [RFC PATCH 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        m.szyprowski@samsung.com,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
 <CGME20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b@eucas1p2.samsung.com>
 <20190723122016.30279-10-a.swigon@partner.samsung.com>
 <6e8b2081-2fb3-9ab8-37d1-8b5fe5fd8e11@linaro.org>
 <62557522be4924a01d3822d4734c30f2965c608b.camel@partner.samsung.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <4155482f-8f8f-a659-63ba-25701540b2c5@linaro.org>
Date:   Wed, 7 Aug 2019 17:21:15 +0300
MIME-Version: 1.0
In-Reply-To: <62557522be4924a01d3822d4734c30f2965c608b.camel@partner.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artur,

On 8/1/19 10:59, Artur Świgoń wrote:
> Hi Georgi,
> 
> On Fri, 2019-07-26 at 11:05 +0300, Georgi Djakov wrote:
>> Hi Artur,
>>
>> On 7/23/19 15:20, Artur Świgoń wrote:
>>> This patch adds interconnect functionality to the exynos-bus devfreq
>>> driver.
>>>
>>> The SoC topology is a graph (or, more specifically, a tree) and most of its
>>> edges are taken from the devfreq parent-child hierarchy (cf.
>>> Documentation/devicetree/bindings/devfreq/exynos-bus.txt). The previous
>>> patch adds missing edges to the DT (under the name 'parent'). Due to
>>> unspecified relative probing order, -EPROBE_DEFER may be propagated to
>>> guarantee that a child is probed before its parent.
>>>
>>> Each bus is now an interconnect provider and an interconnect node as well
>>> (cf. Documentation/interconnect/interconnect.rst), i.e. every bus registers
>>> itself as a node. Node IDs are not hardcoded but rather assigned at
>>> runtime, in probing order (subject to the above-mentioned exception
>>> regarding relative order). This approach allows for using this driver with
>>> various Exynos SoCs.
>>
>> I am not familiar with the Exynos bus topology, but it seems to me that it's not
>> represented correctly. An interconnect provider with just a single node (port)
>> is odd. I would expect that each provider consists of multiple master and slave
>> nodes. This data would be used by a framework to understand what are the links
>> and how the traffic flows between the IP blocks and through which buses.
> 
> To summarize the exynos-bus topology[1] used by the devfreq driver: There are
> many data buses for data transfer in Samsung Exynos SoC. Every bus has its own
> clock. Buses often share power lines, in which case one of the buses on the
> power line is referred to as 'parent' (or as 'devfreq' in the DT). In the
> particular case of Exynos4412[1][2], the topology can be expressed as follows:
> 
> bus_dmc
> -- bus_acp
> -- bus_c2c
> 
> bus_leftbus
> -- bus_rightbus
> -- bus_display
> -- bus_fsys
> -- bus_peri
> -- bus_mfc
> 
> Where bus_dmc and bus_leftbus probably could be referred to as masters, and the
> following indented nodes as slaves. Patch 08/11 of this RFC additionally adds
> the following to the DT:
> 
> bus_dmc
> -- bus_leftbus
> 
> Which makes the topology a valid tree.
> 
> The exynos-bus concept in devfreq[3] is designed in such a way that every bus is
> probed separately as a platform device, and is a largely independent entity.
>
> This RFC proposes an extension to the existing devfreq driver that basically
> provides a simple QoS to ensure minimum clock frequency for selected buses
> (possibly overriding devfreq governor calculations) using the interconnect
> framework.
> 
> The hierarchy is modelled in such a way that every bus is an interconnect node.
> On the other hand, what is considered an interconnect provider here is quite
> arbitrary, but for the reasons mentioned in the above paragraph, this RFC
> assumes that every bus is a provider of itself as a node. Using an alternative

IIUC, in case we want to transfer data between the display and the memory
controller, the path would look like this:

display --> bus_display --> bus_leftbus --> bus_dmc --> memory

But the bus_display for example would have not one, but two nodes (ports),
right?  One representing the link to the display controller and another one
representing the link to bus_leftbus? So i think that all the buses should
have at least two nodes, to represent each end of the wire.

> singleton provider approach was deemed more complicated since the 'dev' field in
> 'struct icc_provider' has to be set to something meaningful and we are tied to
> the 'samsung,exynos-bus' compatible string in the driver (and multiple instances
> of exynos-bus probed in indeterminate relative order).
> 

Sure, the rest makes sense to me.

Thanks,
Georgi
