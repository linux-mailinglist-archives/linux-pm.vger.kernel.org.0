Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C87139FBD
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 04:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgANDL2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 22:11:28 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:47518 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbgANDL1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 22:11:27 -0500
Received: from [10.18.29.227] (10.18.29.227) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 14 Jan
 2020 11:11:52 +0800
Subject: Re: [PATCH v5 1/4] dt-bindings: power: add Amlogic secure power
 domains bindings
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
References: <1573532930-39505-1-git-send-email-jianxin.pan@amlogic.com>
 <1573532930-39505-2-git-send-email-jianxin.pan@amlogic.com>
 <7ha76rdj35.fsf@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <61dcfe1a-e987-aa40-34da-71150554f708@amlogic.com>
Date:   Tue, 14 Jan 2020 11:11:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <7ha76rdj35.fsf@baylibre.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.227]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HI Kevin,

Thanks for your review, I will put pwrc under secure-monitor node.

On 2020/1/14 7:37, Kevin Hilman wrote:
> Jianxin Pan <jianxin.pan@amlogic.com> writes:
> 
>> Add the bindings for the Amlogic Secure power domains, controlling the
>> secure power domains.
>>
>> The bindings targets the Amlogic A1 and C1 compatible SoCs, in which the
>> power domain registers are in secure world.
>>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     | 37 ++++++++++++++++++++++
>>  include/dt-bindings/power/meson-a1-power.h         | 32 +++++++++++++++++++
>>  2 files changed, 69 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>>  create mode 100644 include/dt-bindings/power/meson-a1-power.h
>>
>> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> new file mode 100644
>> index 00000000..2ed269f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +# Copyright (c) 2019 Amlogic, Inc
>> +# Author: Jianxin Pan <jianxin.pan@amlogic.com>
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/power/amlogic,meson-sec-pwrc.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Amlogic Meson Secure Power Domains
>> +
>> +maintainers:
>> +  - Jianxin Pan <jianxin.pan@amlogic.com>
>> +
>> +description: |+
>> +  Meson Secure Power Domains used in A1/C1 SoCs.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - amlogic,meson-a1-pwrc
>> +
>> +  "#power-domain-cells":
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - "#power-domain-cells"
>> +
>> +examples:
>> +  - |
>> +    pwrc: power-controller {
>> +          compatible = "amlogic,meson-a1-pwrc";
>> +          #power-domain-cells = <1>;
>> +          secure-monitor = <&sm>;
> 
> As requested by Rob, please put this under the secure-monitor node.
> 
> Kevin
> 
> .
> 

