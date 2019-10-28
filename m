Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD90E7027
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 12:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfJ1LLC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 07:11:02 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:8678 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ1LLC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 07:11:02 -0400
Received: from [10.18.29.227] (10.18.29.227) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 28 Oct
 2019 19:11:13 +0800
Subject: Re: [PATCH RESEND v2 1/4] dt-bindings: power: add Amlogic secure
 power domains bindings
To:     Rob Herring <robh@kernel.org>
CC:     Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
References: <1570695678-42623-1-git-send-email-jianxin.pan@amlogic.com>
 <1570695678-42623-2-git-send-email-jianxin.pan@amlogic.com>
 <20191014173900.GA6886@bogus>
 <622c7785-8254-5473-6b35-7287830f3c60@amlogic.com>
 <CAL_Jsq+F9EGv2jEWw2BrmH0NDKMRt6=pG6LSHL8UYH9G+-OeMw@mail.gmail.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <730e5611-6dc0-5bf0-0489-4091bda18c9e@amlogic.com>
Date:   Mon, 28 Oct 2019 19:11:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+F9EGv2jEWw2BrmH0NDKMRt6=pG6LSHL8UYH9G+-OeMw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.227]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 2019/10/26 4:19, Rob Herring wrote:
> On Wed, Oct 16, 2019 at 6:26 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>>
>> Hi Rob,
>>
>> On 2019/10/15 1:39, Rob Herring wrote:
>>> On Thu, Oct 10, 2019 at 04:21:15AM -0400, Jianxin Pan wrote:
>>>> Add the bindings for the Amlogic Secure power domains, controlling the
>>>> secure power domains.
>>>>
>>>> The bindings targets the Amlogic A1 and C1 compatible SoCs, in which the
>>>> power domain registers are in secure world.
>>>>
>>>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>>>> ---
>>>>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     | 42 ++++++++++++++++++++++
>>>>  include/dt-bindings/power/meson-a1-power.h         | 32 +++++++++++++++++
>>>>  2 files changed, 74 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>>>> +
>>>> +  secure-monitor:
>>>> +    description: phandle to the secure-monitor node
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>
>>> Why not just a child node of this node?
>>>
>> Thanks for the review.
>>
>> I followed the style of the previous series of meson：
>>
>>   46         efuse: efuse {
>>   47                 compatible = "amlogic,meson-gxbb-efuse";
>>   48                 clocks = <&clkc CLKID_EFUSE>;
>>   49                 #address-cells = <1>;
>>   50                 #size-cells = <1>;
>>   51                 read-only;
>>   52                 secure-monitor = <&sm>;
>>   53         };
> 
> Looks like that was not reviewed by me and is only in linux-next.
> Please make functions exposed by secure world a child of the secure
> firmware node.
> 
> Really for power domains, you only need to add a '#power-domain-cells'
> property to the secure monitor node.
> 
OK, I will update them in the next version. 
Thanks for the review.
> Rob
> 
> .
> 

