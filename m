Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 000D3A822B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 14:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfIDMNq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 08:13:46 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:53008 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfIDMNp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 08:13:45 -0400
IronPort-SDR: wSW1NYsqKpJIijW1m5xjctkQXDHcwJOSW+XW5M3EqzCc4ruQSi16XrKe9arVLtA+C9DWQeNheY
 Hy5b8q3RN9+Z+Vrsng8tnYo74Dxj90g6/40I00oplmSIEyN+4gMv0iaQbMZOdPlSUS49SSOIlq
 VHp7XM1Y6lCfTV3t0qnU7VU6CLU4pDN3TOqqGRnhlWR+pyGaWbueREUZRx6hbObnn3pVgu20XQ
 aIvia4TLxK+Gb/rMNQyshAYmw8QY+Hi5c4VpD753/rxvcRl5GboX5sg7zgVut3ZF1Ba6SqWkhr
 ALI=
X-IronPort-AV: E=Sophos;i="5.64,465,1559509200"; 
   d="scan'208";a="230947032"
Subject: Re: [PATCH] power: reset: make reboot-mode user selectable
To:     Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20190805075812.1056069-1-arnd@arndb.de>
 <20190902203857.zusvlv3yv5arel6y@earth.universe>
 <CAK8P3a3uNPepYweCN9+_cQNQyiSGdidwNGL0+xhti2vm8g9O_g@mail.gmail.com>
 <20190903000454.lul7fn5nxqcvi5x5@earth.universe>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <a85385da-c631-4a9b-4b05-888daa640129@vaisala.com>
Date:   Wed, 4 Sep 2019 15:13:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190903000454.lul7fn5nxqcvi5x5@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Sep 2019 12:13:43.0517 (UTC) FILETIME=[31EC58D0:01D5631A]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/3/19 3:04 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Sep 02, 2019 at 11:16:27PM +0200, Arnd Bergmann wrote:
>> On Mon, Sep 2, 2019 at 10:39 PM Sebastian Reichel <sre@kernel.org> wrote:
>>> This patch does not look good to me. Better patch would be to
>>> allow compiling CONFIG_REBOOT_MODE without CONFIG_OF. Obviously
>>> the configuration would not be useful for anything except compile
>>> testing, but that is also true for this patch.
>>
>> Ok, I'd suggest we leave it with the bugfix you already applied then.
>> [caa2b55784, power: reset: nvmem-reboot-mode: add CONFIG_OF dependency]
> 
> That's also fine with me.
> 
> -- Sebastian
> 

Sounds good to me.

--- Nandor
