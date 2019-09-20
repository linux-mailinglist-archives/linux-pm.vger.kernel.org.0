Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8741EB8BA4
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437528AbfITHgo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 03:36:44 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:63207 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437511AbfITHgo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Sep 2019 03:36:44 -0400
Received: from [10.18.29.226] (10.18.29.226) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 20 Sep
 2019 15:37:39 +0800
Subject: Re: [PATCH 1/3] dt-bindings: power: add Amlogic secure power domains
 bindings
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>,
        Zhiqiang Liang <zhiqiang.liang@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
References: <1568895064-4116-1-git-send-email-jianxin.pan@amlogic.com>
 <1568895064-4116-2-git-send-email-jianxin.pan@amlogic.com>
 <CAFBinCCxeYgso3WQWqNgWUwwCM835uo_6FftVv0YwYTFJV2Ovw@mail.gmail.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <8a8edde7-b9a5-8824-cfd2-a94dbe4ee023@amlogic.com>
Date:   Fri, 20 Sep 2019 15:37:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCCxeYgso3WQWqNgWUwwCM835uo_6FftVv0YwYTFJV2Ovw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.226]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Martin,

On 2019/9/20 4:06, Martin Blumenstingl wrote:
> Hi Jianxin,
> 
> On Thu, Sep 19, 2019 at 2:11 PM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>>
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
[...]>> +examples:
>> +  - |
>> +    pwrc: power-controller {
>> +          compatible = "amlogic,meson-a1-pwrc";
>> +    };
> not a comment about this binding but about the secure monitor in general:
> there's a recent discussion about the secure monitor in the nvmem bindings: [0]
> 
> 
> Martin
> 
> 
> [0] https://www.spinics.net/lists/arm-kernel/msg750010.html
> 
Thanks for your remind,I will update and send the second version after Rework of secure-monitor driver is applied.
> .
> 

