Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04610CF12
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 21:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfK1UGK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 15:06:10 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43172 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfK1UGK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 15:06:10 -0500
Received: by mail-lf1-f65.google.com with SMTP id l14so20854177lfh.10;
        Thu, 28 Nov 2019 12:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FjNGi4sGPAMOwSu//4rjJ+SnF7x7q5U9m2ivWbacmrs=;
        b=prlw5sTfXskWdLGt1n1eJ5Y/HudXYVV3XQf//ICFu7YD/09HJLyK1Gt/eUqntGMq7j
         MZxGrohvVH6Dt8zQSBdM82OBOsRclo678gkPc3GJTckx4aDYNkip2t+71xebU5f2nFFl
         cRMUsgK0E73k/jnILquqQdmjxai2nVLnwLBA4v9fcLobpDuuQr3LVRgjJ/EPJRHZFWXF
         jPYHvfhYr+VY1Z2o46InkqOw6/0HhGbhM5sncUxKEJGXgXyjGllKB/qXS0/NE1JeZX91
         ADno3NmCgdKAKvCIXk9O2THtzM6650KH/LaL8O0n+gx+E4ocM+OlAOLPkN38n+r4qfB5
         JUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FjNGi4sGPAMOwSu//4rjJ+SnF7x7q5U9m2ivWbacmrs=;
        b=NsBPPyg0ZdcgXsioX+aFa5mzGCt3xY4vd/E6FMeI94h79QRHRkzBnRw/JkhFe9ACYH
         rxW4BXl+H9Q+EdU8YLuXqRVMou/uB5J8Q8jtIwdAl3iSuaFV9GiaIe5u5tHstJ92y3pE
         71uZqKCtA73oipqQZxsPadrMRUpTAB5hdEFKPXawl8pKremOXlinTYF8bJyNmmZXQFT/
         dU9n5ZKkQU+JQiswfZADKhYBiSEIDEowYj20/U2cl+qzj/WIq4CQ9u06i6ddQWvNfnyV
         D8w8vNnpwyQb2sbmiMUrtBci2sVo2DuBqJ9Dr8e7f56AfBQZqoXQBVfZ2ks/WNMhGwEe
         dOpg==
X-Gm-Message-State: APjAAAUSYUcf2WOGS+QgiBOM/X1FsmefLdNve0H7nGpqZJHvYbWkPk88
        /PqX5WUjeaRYTUfyHPebwXMprzXq
X-Google-Smtp-Source: APXvYqzgPP9GLzInH7+s9jf2E5EQByrAmOEH9D4KiMZ3l/KM0WdjxySOJ/KXRCdKijAKz7DotGJUKQ==
X-Received: by 2002:a19:6a15:: with SMTP id u21mr30911327lfu.31.1574971567031;
        Thu, 28 Nov 2019 12:06:07 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id n30sm10178631lfi.54.2019.11.28.12.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 12:06:06 -0800 (PST)
Subject: Re: [PATCH v1 08/29] dt-bindings: interconnect: tegra: Add initial
 IDs
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20191118200247.3567-1-digetx@gmail.com>
 <20191118200247.3567-9-digetx@gmail.com> <20191119062535.GC2462695@ulmo>
 <8cff3af3-42c7-3312-5f98-cd5eb98b7b7a@gmail.com>
 <f0f36176-8070-08a6-a61f-77221d916f04@gmail.com>
 <20191125113218.GK1409040@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a3c16696-8ecf-ac7f-4f8a-2dd3221e5334@gmail.com>
Date:   Thu, 28 Nov 2019 23:06:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191125113218.GK1409040@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

25.11.2019 14:32, Thierry Reding пишет:
> On Thu, Nov 21, 2019 at 08:14:35PM +0300, Dmitry Osipenko wrote:
>> 19.11.2019 19:56, Dmitry Osipenko пишет:
>>> 19.11.2019 09:25, Thierry Reding пишет:
>>>> On Mon, Nov 18, 2019 at 11:02:26PM +0300, Dmitry Osipenko wrote:
>>>>> Define interconnect IDs for memory controller (MC), external memory
>>>>> controller (EMC), external memory (EMEM) and memory clients of display
>>>>> controllers (DC).
>>>>>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>  include/dt-bindings/interconnect/tegra-icc.h | 11 +++++++++++
>>>>>  1 file changed, 11 insertions(+)
>>>>>  create mode 100644 include/dt-bindings/interconnect/tegra-icc.h
>>>
>>>
>>> Hello Thierry,
>>>
>>>> There was a bit of discussion regarding this for a recent patch that I
>>>> was working on, see:
>>>>
>>>> 	http://patchwork.ozlabs.org/project/linux-tegra/list/?series=140318
>>>
>>> Thank you very much for the link.
>>>
>>>> I'd rather not use an additional set of definitions for this. The memory
>>>> controller already has a set of native IDs for memory clients that I
>>>> think we can reuse for this.
>>>
>>> I missed that it's fine to have multiple ICC connections defined
>>> per-path, at quick glance looks like indeed it should be fine to re-use
>>> MC IDs.
>>
>> Well, it is not quite correct to have multiple connections per-path.
>>
>> Please take look at interconnect's binding and core.c:
>>
>>   1. there should be one src->dst connection per-path
>>   2. each connection should comprise of one source and one destination nodes
>>
>>>> I've only added these client IDs for Tegra194 because that's where we
>>>> need it to actually describe a specific hardware quirk, but I can come
>>>> up with the equivalent for older chips as well.
>>>
>>> Older Tegra SoCs have hardware units connected to MC through AHB bus,
>>> like USB for example. These units do not have MC client IDs and there is
>>> no MC ID defined for the AHB bus either, but probably it won't be a
>>> problem to define IDs for them if will be necessary.
>>>
>>
>> Since interconnect binding requires to define both source and
>> destination nodes for the path, then MC IDs are not enough in order to
>> define interconnect path because these IDs represent only the source
>> nodes. Destination node should be either EMC or EMEM.
> 
> This doesn't really map well to Tegra. The source of the path is always
> the device and the destination is always the memory controller. We also
> can have multiple paths between a device and the memory controller. The
> typical case is to have at least a read and a write path, but there are
> a number of devices that have multiple read and/or multiple write paths
> to the memory controller.
> 
> Or perhaps I'm looking at this the wrong way, and what we really ought
> to describe is the paths with MC sitting in the middle. So it'd be
> something like:
> 
> 	MC ID --- source ---> MC --- destination ---> EMC

Yes, this should be correct.

> for write paths and:
> 
> 	EMC --- source ---> MC --- destination ---> MC ID

Both write and read paths have the same direction in terms of
interconnect API. The source node requests bandwidth from the
destination node, where source is memory client and destination is EMC/EMEM.

> for read paths. I have no idea what would be a good connection ID for
> EMC, since I don't think MC really differentiates at that level. Perhaps
> #interconnect-cells = <0> for EMC would be appropriate.

It should be fine to define ICC ID for EMC that doesn't overlap with the
memory client IDs, say #1000.

> This would make the bindings look more like this, taking a random sample
> from the above series:
> 
> 	ethernet@2490000 {
> 		...
> 		interconnects = <&emc &mc TEGRA194_MEMORY_CLIENT_EQOSR>,
> 				<&mc TEGRA194_MEMORY_CLIENT_EQOSW &emc>;
> 		interconnect-names = "dma-mem", "dma-mem";
> 		...
> 	};
> 
> In words, the above would mean that for the ethernet device there is one
> path (a read slave interface) where data flows from the EMC through the
> MC to the device with memory client ID TEGRA194_MEMORY_CLIENT_EQOSR. The
> second path (a write slave interface) describes data flowing from the
> device (with memory client ID TEGRA194_MEMORY_CLIENT_EQOSW) through the
> MC and towards the EMC.
> 
> Irrespective of the above, I think we definitely need to keep separate
> IDs for read and write paths because each of them have separate controls
> for arbitration and latency allowance. So each of those may need to be
> separately configurable.
> 
> Does that make sense?

I'll try to update this series to use ICC-path per display plane and see
how it goes.

In general, looks like should be fine to have ICC paths defined per
memory client.
