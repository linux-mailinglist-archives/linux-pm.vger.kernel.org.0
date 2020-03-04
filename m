Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F14D17956E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 17:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgCDQfc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 11:35:32 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:43444 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgCDQfc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 11:35:32 -0500
Received: from [10.18.90.110] (10.18.90.110) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Thu, 5 Mar 2020
 00:36:00 +0800
Subject: Re: [PATCH v2] dt-bindings: power: Fix dt_binding_check error
To:     Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>
CC:     <linux-amlogic@lists.infradead.org>, SoC Team <soc@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        <devicetree@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1583164448-83438-1-git-send-email-jianxin.pan@amlogic.com>
 <20200302201554.GA22028@bogus> <7h5zflrfp3.fsf@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <b1fc2451-7eec-aa03-3d4d-3a7ae186105c@amlogic.com>
Date:   Thu, 5 Mar 2020 00:35:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <7h5zflrfp3.fsf@baylibre.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.90.110]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/3/3 16:43, Kevin Hilman wrote:
> Rob Herring <robh@kernel.org> writes:
> 
>> On Mon, 2 Mar 2020 23:54:08 +0800, Jianxin Pan wrote:
>>> Missing ';' in the end of secure-monitor example node.
>>>
>>> Fixes: 165b5fb294e8 ("dt-bindings: power: add Amlogic secure power domains bindings")
>>> Reported-by: Rob Herring <robh+dt@kernel.org>
>>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>>> ---
>>>  Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>
>> Please add Acked-by/Reviewed-by tags when posting new versions. However,
>> there's no need to repost patches *only* to add the tags. The upstream
>> maintainer will do that for acks received on the version they apply.
>>
>> If a tag was not added on purpose, please state why and what changed.
> 
> I've (re)added these tags:
> 
>   Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>   Acked-by: Rob Herring <robh@kernel.org>
> 
> when applying this time.
> 
> Jianxin, please collect the tags in the future and add when you send
> follow-up versions.
OK, I will do it next time, thanks for your time.
> 
> Thanks,
> 
> Kevin
> 
> .
> 

