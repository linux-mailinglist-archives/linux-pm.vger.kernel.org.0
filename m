Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BDB45389D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 18:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbhKPRi4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 12:38:56 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:56359 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233537AbhKPRi4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 12:38:56 -0500
Received: from [77.244.183.192] (port=62096 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mn2NB-0000Vf-6r; Tue, 16 Nov 2021 18:35:57 +0100
Subject: Re: [PATCH v2 3/3] power: supply: max77976: add Maxim MAX77976
 charger driver
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20211108162706.2816454-1-luca@lucaceresoli.net>
 <20211108162706.2816454-3-luca@lucaceresoli.net>
 <20211116152108.z4qpfl43h4f2pbm7@earth.universe>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <7f91e875-3a87-0b01-4b40-232ca109ef38@lucaceresoli.net>
Date:   Tue, 16 Nov 2021 18:35:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211116152108.z4qpfl43h4f2pbm7@earth.universe>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 16/11/21 16:21, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Nov 08, 2021 at 05:27:06PM +0100, Luca Ceresoli wrote:
>> Add support for the MAX77976 3.5/5.5A 1-Cell Li+ Battery Charger.
>>
>> This is a simple implementation enough to be used as a simple battery
>> charger without OTG and boost.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>
>> ---
> 
> Thanks, I queued this to power-supply's for-next branch together
> with the other 2 patches

Thanks!

> with one small change: The of_match_ptr()
> is not needed and actually should result in a warning when building
> the driver with CONFIG_OF disabled.

Ouch. I made the same mistake in the past and the kernel test robot
noticed, I wonder why it didn't this time but hopefully I will remember
in the future!

Regards,
-- 
Luca
