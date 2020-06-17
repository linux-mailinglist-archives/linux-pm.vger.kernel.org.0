Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E831D1FD7C7
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 23:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFQVov (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 17:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgFQVou (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2020 17:44:50 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACE1C06174E;
        Wed, 17 Jun 2020 14:44:50 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y13so2229694lfe.9;
        Wed, 17 Jun 2020 14:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3OcGAL2Kxv5orG1lDTHD0HoSJEXX60m7KQNoTqlPNKk=;
        b=lwLEhOqZOSHhxFOByIhV3rIRcCYAe5MOnpIqr97dgc7IBAt8HUlXWmwTdUdVBN3Yil
         AIXG+lz1A9GjtfbeHLTAy5ByAoKe/J69M23vj5LouDto33ur41WZ39+M8J+mBCOFKcd+
         1SmI70N0Mrmbjy5L5BlR50PMzvgSqPW/hcw752TXc1QhhzcA2hAyAlG8uItDzTtLfvWP
         zAF+ofnEx9TuOqfh/o/+sxuPVr9Id+gXCTfPU7hzrmt4+1n6H/9kaerxQtBvPNILRMvw
         no479c9H+2B3pZ1fviV0iMhQBasoldZyLd8DJILVl3ETP/+am/FuGDcx8Xsf3ew2Refr
         8ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3OcGAL2Kxv5orG1lDTHD0HoSJEXX60m7KQNoTqlPNKk=;
        b=B+CI5WdMk6mq5AF6pRX+14DOzdI6F5R43KhLVzWij4ZSUt+ecc5BSPGl2vdQKp0PoY
         A01qV0kbg9yU4BDebC6l1yFWLe/+9MOrUO8S1MBsYAJJzMGE+8NZm77II0UPrBIAA72E
         PLeqfbBrj7mOpXvi9enbkcWzjAU/2dZE0DFJ3Bp4MWypL2jMBbkUvUXWGWrtiqlU5Qde
         zhb/FFeAU0lIE1JRQUjrGlGHIqUxuPJi7enpLS1oq2tX5z96mp8kdfNQ+3TGZDAYFozF
         J3jgQ/BWVhSV660G80/gPXJh9jGVU8DxTTM07zF6DS73RPSrRaOvBeGTxAo0Dxgwbsus
         tmuA==
X-Gm-Message-State: AOAM531/OiBetVu4Z4fiBhSvY4ahbctNn7vcgTIJhouSpQa94+MI8rhG
        2JmMPli0AY1TPqISgfkFpXLe8c/a
X-Google-Smtp-Source: ABdhPJzfx2jrwUo9clrvUJN/nulC28AYYrDluu8sqWs/XPSON6lTZzIVrcMhZ9p6NJk0K/p4inYxsQ==
X-Received: by 2002:a19:83c7:: with SMTP id f190mr528250lfd.14.1592430288655;
        Wed, 17 Jun 2020 14:44:48 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id 11sm219650lfz.78.2020.06.17.14.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:44:48 -0700 (PDT)
Subject: Re: [PATCH v4 22/37] dt-bindings: host1x: Document new interconnect
 properties
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20200609131404.17523-1-digetx@gmail.com>
 <20200609131404.17523-23-digetx@gmail.com> <20200617213726.GA2837398@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5303317a-2cb6-d7a8-361a-30867fc6eab7@gmail.com>
Date:   Thu, 18 Jun 2020 00:44:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200617213726.GA2837398@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.06.2020 00:37, Rob Herring пишет:
> On Tue, Jun 09, 2020 at 04:13:49PM +0300, Dmitry Osipenko wrote:
>> Most of Host1x devices have at least one memory client. These clients
>> are directly connected to the memory controller. The new interconnect
>> properties represent the memory client's connection to the memory
>> controller.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../display/tegra/nvidia,tegra20-host1x.txt   | 68 +++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>> index 47319214b5f6..ab4fbee7bccf 100644
>> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>> @@ -20,6 +20,10 @@ Required properties:
>>  - reset-names: Must include the following entries:
>>    - host1x
>>  
>> +Each host1x client module having to perform DMA through the Memory Controller
>> +should have the interconnect endpoints set to the Memory Client and External
>> +Memory respectively.
>> +
>>  The host1x top-level node defines a number of children, each representing one
>>  of the following host1x client modules:
>>  
>> @@ -36,6 +40,12 @@ of the following host1x client modules:
>>    - reset-names: Must include the following entries:
>>      - mpe
>>  
>> +  Optional properties:
>> +  - interconnects: Must contain entry for the MPE memory clients.
>> +  - interconnect-names: Must include name of the interconnect path for each
>> +    interconnect entry. Consult TRM documentation for information about
>> +    available memory clients, see MEMORY CONTROLLER section.
>> +
>>  - vi: video input
>>  
>>    Required properties:
>> @@ -65,6 +75,12 @@ of the following host1x client modules:
>>        - power-domains: Must include sor powergate node as csicil is in
>>          SOR partition.
>>  
>> +  Optional properties:
>> +  - interconnects: Must contain entry for the VI memory clients.
>> +  - interconnect-names: Must include name of the interconnect path for each
>> +    interconnect entry. Consult TRM documentation for information about
>> +    available memory clients, see MEMORY CONTROLLER section.
>> +
>>  - epp: encoder pre-processor
>>  
>>    Required properties:
>> @@ -78,6 +94,12 @@ of the following host1x client modules:
>>    - reset-names: Must include the following entries:
>>      - epp
>>  
>> +  Optional properties:
>> +  - interconnects: Must contain entry for the EPP memory clients.
>> +  - interconnect-names: Must include name of the interconnect path for each
>> +    interconnect entry. Consult TRM documentation for information about
>> +    available memory clients, see MEMORY CONTROLLER section.
>> +
>>  - isp: image signal processor
>>  
>>    Required properties:
>> @@ -91,6 +113,12 @@ of the following host1x client modules:
>>    - reset-names: Must include the following entries:
>>      - isp
>>  
>> +  Optional properties:
>> +  - interconnects: Must contain entry for the ISP memory clients.
>> +  - interconnect-names: Must include name of the interconnect path for each
>> +    interconnect entry. Consult TRM documentation for information about
>> +    available memory clients, see MEMORY CONTROLLER section.
>> +
>>  - gr2d: 2D graphics engine
>>  
>>    Required properties:
>> @@ -104,6 +132,12 @@ of the following host1x client modules:
>>    - reset-names: Must include the following entries:
>>      - 2d
>>  
>> +  Optional properties:
>> +  - interconnects: Must contain entry for the GR2D memory clients.
>> +  - interconnect-names: Must include name of the interconnect path for each
>> +    interconnect entry. Consult TRM documentation for information about
>> +    available memory clients, see MEMORY CONTROLLER section.
>> +
>>  - gr3d: 3D graphics engine
>>  
>>    Required properties:
>> @@ -122,6 +156,12 @@ of the following host1x client modules:
>>      - 3d
>>      - 3d2 (Only required on SoCs with two 3D clocks)
>>  
>> +  Optional properties:
>> +  - interconnects: Must contain entry for the GR3D memory clients.
>> +  - interconnect-names: Must include name of the interconnect path for each
>> +    interconnect entry. Consult TRM documentation for information about
>> +    available memory clients, see MEMORY CONTROLLER section.
>> +
>>  - dc: display controller
>>  
>>    Required properties:
>> @@ -149,6 +189,10 @@ of the following host1x client modules:
>>    - nvidia,hpd-gpio: specifies a GPIO used for hotplug detection
>>    - nvidia,edid: supplies a binary EDID blob
>>    - nvidia,panel: phandle of a display panel
>> +  - interconnects: Must contain entry for the DC memory clients.
>> +  - interconnect-names: Must include name of the interconnect path for each
>> +    interconnect entry. Consult TRM documentation for information about
>> +    available memory clients, see MEMORY CONTROLLER section.
>>  
>>  - hdmi: High Definition Multimedia Interface
>>  
>> @@ -297,6 +341,12 @@ of the following host1x client modules:
>>    - reset-names: Must include the following entries:
>>      - vic
>>  
>> +  Optional properties:
>> +  - interconnects: Must contain entry for the VIC memory clients.
>> +  - interconnect-names: Must include name of the interconnect path for each
>> +    interconnect entry. Consult TRM documentation for information about
>> +    available memory clients, see MEMORY CONTROLLER section.
>> +
>>  Example:
>>  
>>  / {
>> @@ -410,6 +460,15 @@ Example:
>>  			resets = <&tegra_car 27>;
>>  			reset-names = "dc";
>>  
>> +			interconnects = <&mc TEGRA20_MC_DISPLAY0A &emc>,
>> +					<&mc TEGRA20_MC_DISPLAY0B &emc>,
>> +					<&mc TEGRA20_MC_DISPLAY0C &emc>,
>> +					<&mc TEGRA20_MC_DISPLAY1B &emc>;
> 
> This looks odd or wrong. Each entry has 2 phandles? 

Each entry defines interconnect path, where MC is the start of the path
and EMC is the end. So yes, 2 phandles for each path.

Please see arm/boot/dts/qcom-msm8974.dtsi for another example [1].

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/qcom-msm8974.dtsi?h=v5.8-rc1#n1448
