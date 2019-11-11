Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1ACF7269
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 11:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfKKKpp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 05:45:45 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:34933 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfKKKpp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 05:45:45 -0500
Received: from [10.18.29.227] (10.18.29.227) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 11 Nov
 2019 18:46:03 +0800
Subject: Re: [PATCH v4 2/4] firmware: meson_sm: Add secure power domain
 support
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
References: <1572868028-73076-1-git-send-email-jianxin.pan@amlogic.com>
 <1572868028-73076-3-git-send-email-jianxin.pan@amlogic.com>
 <7hk188stcy.fsf@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <420073b1-0a3f-1bfd-4422-34f8cd7e0d2d@amlogic.com>
Date:   Mon, 11 Nov 2019 18:46:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7hk188stcy.fsf@baylibre.com>
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

Hi Kevin,

Please see my comments below:

On 2019/11/10 4:11, Kevin Hilman wrote:
> Jianxin Pan <jianxin.pan@amlogic.com> writes:
> 
>> The Amlogic Meson A1/C1 Secure Monitor implements calls to control power
>> domain.
>>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>  drivers/firmware/meson/meson_sm.c       | 2 ++
>>  include/linux/firmware/meson/meson_sm.h | 2 ++
>>  2 files changed, 4 insertions(+)
>>
[...]
>> diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
>> index 6669e2a..4ed3989 100644
>> --- a/include/linux/firmware/meson/meson_sm.h
>> +++ b/include/linux/firmware/meson/meson_sm.h
>> @@ -12,6 +12,8 @@ enum {
>>  	SM_EFUSE_WRITE,
>>  	SM_EFUSE_USER_MAX,
>>  	SM_GET_CHIP_ID,
>> +	SM_PWRC_SET,
>> +	SM_PWRC_GET,
> 
> These new IDs are unique to the A1/C1 family.  Maybe we should add a
> prefix to better indicate that.  Maybe:
> 
>        SM_A1_PWRC_SET,
>        SM_A1_PWRC_GET,
> 
> Thoughts?
> 
I consulted with the internal VLSI team, and it's likely that the latter new SOC will follow A1/C1.
And then it may become common function in the future.
> Kevin
> 
> .
> 

