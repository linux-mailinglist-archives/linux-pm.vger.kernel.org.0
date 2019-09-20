Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFBCB8C1E
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 09:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393048AbfITH5q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 03:57:46 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:41549 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388411AbfITH5q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Sep 2019 03:57:46 -0400
Received: from [10.18.29.226] (10.18.29.226) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 20 Sep
 2019 15:58:41 +0800
Subject: Re: [PATCH 2/3] soc: amlogic: Add support for Secure power domains
 controller
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
 <1568895064-4116-3-git-send-email-jianxin.pan@amlogic.com>
 <CAFBinCDv2m_0tP+rdT1tgXhMs-hPE_cJ9TmO8h9ftDvJXvby+g@mail.gmail.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <dc57566d-81e2-5851-ff6d-e39dcf246a47@amlogic.com>
Date:   Fri, 20 Sep 2019 15:58:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDv2m_0tP+rdT1tgXhMs-hPE_cJ9TmO8h9ftDvJXvby+g@mail.gmail.com>
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

On 2019/9/20 4:03, Martin Blumenstingl wrote:
> Hi Jianxin,
> 
> I added three comments below from a quick glance at this driver (I
> didn't have time for a complete review)
> 
> On Thu, Sep 19, 2019 at 2:11 PM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> [...]
>> +               pm_genpd_init(&dom->base, NULL,
>> +                             (match->domains[i].get_power ?
>> +                             match->domains[i].get_power(dom) : true));
> .get_power is never NULL in this driver so the ": true" part is
> effectively a no-op
> 
OK, I will remove it. Thanks for your time.
> [...]
>> +static const struct of_device_id meson_secure_pwrc_match_table[] = {
>> +       {
>> +               .compatible = "amlogic,meson-a1-pwrc",
>> +               .data = &meson_secure_a1_pwrc_data,
>> +       },
>> +       { }
> many drivers use a /* sentinel */ comment inside { }
> 
OK, I will add this comment line.
> [...]
>> +arch_initcall_sync(meson_secure_pwrc_init);
> why arch_initcall_sync instead of builtin_platform_driver?
> $ grep -R arch_initcall_sync drivers/soc/
> $
> 
> 
> Martin
> 
The power-domain is depended by many other drivers, arch_initcall_sync is used to make power-domain probe earlier.
Maybe I need to switch back to builtin_platform_driver when use APIs from meson_sm.c. 
> .
> 

