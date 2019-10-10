Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF535D1EEB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 05:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbfJJDbi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 23:31:38 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:21232 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfJJDbh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2019 23:31:37 -0400
Received: from [10.18.29.227] (10.18.29.227) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 10 Oct
 2019 11:31:39 +0800
Subject: Re: [PATCH 1/3] dt-bindings: power: add Amlogic secure power domains
 bindings
To:     Rob Herring <robh@kernel.org>
CC:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>,
        Zhiqiang Liang <zhiqiang.liang@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
References: <1568895064-4116-1-git-send-email-jianxin.pan@amlogic.com>
 <1568895064-4116-2-git-send-email-jianxin.pan@amlogic.com>
 <5d93ce88.1c69fb81.aec64.6b1b@mx.google.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <3152a4ac-5059-502b-3bf3-71f7e2d8118a@amlogic.com>
Date:   Thu, 10 Oct 2019 11:31:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5d93ce88.1c69fb81.aec64.6b1b@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.227]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob，

Thanks for your review.

I'm sorry to reply so late, for I've been on vacation in the last week.

On 2019/10/2 6:09, Rob Herring wrote:
> On Thu, Sep 19, 2019 at 08:11:02AM -0400, Jianxin Pan wrote:
>> Add the bindings for the Amlogic Secure power domains, controlling the
>> secure power domains.
>>
>> The bindings targets the Amlogic A1 and C1 compatible SoCs, in which the
>> power domain registers are in secure world.
>>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> Signed-off-by: Zhiqiang Liang <zhiqiang.liang@amlogic.com>
>> ---
>>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     | 32 ++++++++++++++++++++++
>>  include/dt-bindings/power/meson-a1-power.h         | 32 ++++++++++++++++++++++
>>  2 files changed, 64 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>>  create mode 100644 include/dt-bindings/power/meson-a1-power.h
>>
>> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> new file mode 100644
>> index 00000000..327e0d9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> @@ -0,0 +1,32 @@
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
>> +  A1/C1 series The Secure Power Domains node should be the child of a syscon
>> +  node with the required property.
> 
> 'a syscon node' is not specific enough. It must be a specific node.
> 
I will fix this.
In A1/C1, power control is in secure domain, and syscon parent is not needed.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - amlogic,meson-a1-pwrc
>> +
>> +required:
>> +  - compatible
>> +
>> +examples:
>> +  - |
>> +    pwrc: power-controller {
>> +          compatible = "amlogic,meson-a1-pwrc";
> 
> But why do you need this node? It has no resources.
> 
> #power-domain-cells needed?
I will add #power-domain-cells and secure-monitor here.
Thank you for the review.
> 
>> +    };
>> +
>> +
>> diff --git a/include/dt-bindings/power/meson-a1-power.h b/include/dt-bindings/power/meson-a1-power.h
>> new file mode 100644
>> index 00000000..6cf50bf
>> --- /dev/null
>> +++ b/include/dt-bindings/power/meson-a1-power.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc.
>> + * Author: Jianxin Pan <jianxin.pan@amlogic.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_MESON_A1_POWER_H
>> +#define _DT_BINDINGS_MESON_A1_POWER_H
>> +
>> +#define PWRC_DSPA_ID	8
>> +#define PWRC_DSPB_ID	9
>> +#define PWRC_UART_ID	10
>> +#define PWRC_DMC_ID	11
>> +#define PWRC_I2C_ID	12
>> +#define PWRC_PSRAM_ID	13
>> +#define PWRC_ACODEC_ID	14
>> +#define PWRC_AUDIO_ID	15
>> +#define PWRC_OTP_ID	16
>> +#define PWRC_DMA_ID	17
>> +#define PWRC_SD_EMMC_ID	18
>> +#define PWRC_RAMA_ID	19
>> +#define PWRC_RAMB_ID	20
>> +#define PWRC_IR_ID	21
>> +#define PWRC_SPICC_ID	22
>> +#define PWRC_SPIFC_ID	23
>> +#define PWRC_USB_ID	24
>> +#define PWRC_NIC_ID	25
>> +#define PWRC_PDMIN_ID	26
>> +#define PWRC_RSA_ID	27
>> +#define PWRC_MAX_ID	28
>> +
>> +#endif
>> -- 
>> 2.7.4
>>
> 
> .
> 

