Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB6F454CFB
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 19:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhKQSXz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 13:23:55 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.4]:24265 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239918AbhKQSXt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 13:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1637173250; i=@lenovo.com;
        bh=hs0uHshYKdR3OJTjnzTWG7apkyD6aSmFAyi/ma+Bxy4=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=NXHoRXt3UzLZICvS4EnjTAG1RTGConfFW2LxVVgG9JmBdj/2R9K0QVmewSI5qCi0P
         SOekT7kCfESmW2Uwg1C6KS6PkO7QFz8eb/TYV1AsQpEgsg4ncPMnVPBEBZaKhoNYve
         QG5ioIcWNFRYZJClfviQLpl3uf+itC/b5GTZXWlxKvn0JG4IJA4hNqyMYy5kbbezil
         w/j6oMd/BjlFOdTuKK9V0x6Cs6tSYYyn0xKD1GCz+QFssKLf3XyBja7LpSha2vWob/
         793tZFVKHO51NUZtCESgcKHI8Yyuu+ATW62JKH7vedB2SGe4LFoj+i+nLVv8R9wxjK
         y+sZkOlO/43Iw==
Received: from [100.112.129.81] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.us-west-2.aws.symcld.net id 1A/62-10907-10845916; Wed, 17 Nov 2021 18:20:49 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUxTVxjGe+69vb0UitcC47QR3GrGIksrBYk
  3fjD3h+NmmW4xLpubcV6k0i79Sm8R2Mzs+EgoamDUbsiXoLgNYYFgZQrG0uogyLQwmN0YMoRu
  MCGAYzpWJlvLBcf+e97397znfU5yDoGKrQIpoco2q0x6RivDhZh607Etch5tZxLqhrZRTi+kH
  j3+SUBNdX2GUE0L9RhVcWM7VTDsx6n+tkqcmjt1E1AL878iVIf9U5RqzbsBqIZrEyg1YPsBUD
  3t5p3h9NXyewL6fIsTp/2tjRi90AHolotWnG6vmUPomevf4/RcSyxdfKJT8EbIO3yNPs2QfYi
  vLpn6CzVWR2Q/7MMtYGpNERASgLyAwhpPHc4V5/jw0lwx4Ao/gE+6LWiwEJNlCMyt8/K5wonA
  Mrd7qYDkNIBF46WBmZAAMUBX6+XlkU8Q2OVy8TngA3B6IpYDowAOPhpBg0BE7oCOxkJBUGPk8
  /DbXxr4XH8t7D7jw4oAQUSRb0HLEBtsR5BZcHjKhQQ1SkbDQd/ZJR1JHoR3pt0Crl+Lws4vk7
  ldFQBOuEaXAE6+CB0OPx7UIeR22OD9HeMGNsKCrxeWh9fDvMsVKBd6A/QXe5Y0JJ+FubMnAac
  PwZOLozinJfDuj70CTsfAb25XYpzeDXvtTcueeOg5s+LRQkvj3eUz4+D1/mG0BCjKV125fNXd
  ylfFK18VrwZgFwGVZtJkqM06RqOVKxMS5EplolyZpJQnJiUrmA/kjCKTlWepWLM8UcFksQo2R
  3dYm67Qq8wtIPAq0415k1dA89Sswg0kBCKLEi3E2xlxeJohPUfNsOr3TJlaFesG6whCBkXHUg
  NsrUmVoco+otEG3vYKhkSYLFLkCWIRa2R0rCaDQ7eAnCj5reocKsb0Br1KGi1itwVMZNCkztQ
  /PWLlh3wHYqQRIsDj8cRhRpVJpzH/nz8A0QSQBRzBVWEavfnppgeBEEggREy/LRjCzPyHpBYk
  n7Lp6OQj/4QKTScc1uj8hIbG15AKQ8qG15/0PZeJpfQaFBfGqgpvDdD1ic6fRYNVuxJapHG13
  t1bcu0davr44T5PzJ77tfdO53ylfJgb/uHbTLNlsXCgf+fk/frUXlW7v6bzPI1Y0Y2lZZLQHe
  OhzgP7tl7bc+rVFB7TdHDrzIij+qN0/QH/2cdfbLYaqy3r1qTeftPZc7XouGt0/53uwaFX3hf
  20Kjk0tGRpNZ5vyQs8o+9Y7P6hs3OAumVqkVJXF644c+XKvNfjuoRRt9se8H3dz/atKvaP/lx
  c2xr27vVzX373Tbv+hLBzOc5rrFN7tKjXUk+re2Z3JyZ/PHYrnmhDGPVjDIeNbHMv0yKfx+cB
  AAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-9.tower-336.messagelabs.com!1637173247!57816!1
X-Originating-IP: [104.47.124.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21046 invoked from network); 17 Nov 2021 18:20:48 -0000
Received: from mail-hk2apc01lp2055.outbound.protection.outlook.com (HELO APC01-HK2-obe.outbound.protection.outlook.com) (104.47.124.55)
  by server-9.tower-336.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Nov 2021 18:20:48 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBplUmpzwQMW1T+1ubjrLIIZGHlQKefKMlBTYK+OqCjCMrOhjj6Xj2pHUXN3tTkqev77DMMJG3kO3dqhxYg8Eu9tylKfzoDCQny1NhWY3SyONJpe/RcQlTdoGlR2SokPfUFEtyjWbno4CBOzZGFQ5CztD4ZI8Ml/nFwainIt9D0DHXBTZi0hoFH4gh36gJ7BgJ11eJvnuZFB8+6+vToX3NeViRSX6zqwiqVRBPDLz4fE2XgehKCDMRf3yYQoxiV/XU71VnGfdJ+zI5XhDEu/f7GWXYg7liSNkuXCJe/E75s5xpUGH4Kk6iy43LY81tTGnWBC1AakMVT5qTw9KS1ciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hs0uHshYKdR3OJTjnzTWG7apkyD6aSmFAyi/ma+Bxy4=;
 b=RJKqyX3NNRjydRPb9yL0LWa8LAvjtBSE8lit1JUnfxSc0EIA2+p2t3qHNNEgGDh8gK0rYAmF5ZQFlyArErgpfA/Bu2qExr/fENMINTc/C5UgzpYFoQWEJIvo0Vrlvl891jjLRLH6p8b5RNYQE36QeyD3xUZJ9zB35r8z/KvINXGntMVYhTfWq1B8HlJL5n3PyjO3DppuaISXC9bbIcjtdlTYETveka5OWAchEhn6Ro0FRL4tvjME3iV9nMdGXSbPCewZp0I9L+p4qXQ9EZziMgd2jHUdOuV28+FKB3bDfz+vrJvEgGQoo3dNOY8KxQ69+XCuNnwvSzd/CZ1R67W2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 104.232.225.6) smtp.rcpttodomain=weissschuh.net smtp.mailfrom=lenovo.com;
 dmarc=temperror action=none header.from=lenovo.com; dkim=none (message not
 signed); arc=none
Received: from SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15) by
 SG2PR03MB3595.apcprd03.prod.outlook.com (2603:1096:4:16::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.4; Wed, 17 Nov 2021 18:20:46 +0000
Received: from SG2APC01FT0047.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:c6:cafe::7f) by SG2P153CA0046.outlook.office365.com
 (2603:1096:4:c6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.7 via Frontend
 Transport; Wed, 17 Nov 2021 18:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 104.232.225.6) smtp.mailfrom=lenovo.com; weissschuh.net; dkim=none (message
 not signed) header.d=none;weissschuh.net; dmarc=temperror action=none
 header.from=lenovo.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of lenovo.com: DNS Timeout)
Received: from mail.lenovo.com (104.232.225.6) by
 SG2APC01FT0047.mail.protection.outlook.com (10.13.36.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Wed, 17 Nov 2021 18:20:45 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.20; Wed, 17 Nov
 2021 13:20:43 -0500
Received: from [10.38.110.13] (10.38.110.13) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.20; Wed, 17 Nov
 2021 13:20:42 -0500
Message-ID: <a0b82de2-827a-96e8-15c2-b1393ee8a705@lenovo.com>
Date:   Wed, 17 Nov 2021 13:20:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [External] Re: [PATCH 0/4] power: supply: add charge_behaviour
 property (force-discharge, inhibit-charge)
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Thomas Koch <linrunner@gmx.net>
CC:     <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
        <ibm-acpi-devel@lists.sourceforge.net>,
        <platform-driver-x86@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        <linux-kernel@vger.kernel.org>, <bberg@redhat.com>,
        <hadess@hadess.net>, <nicolopiazzalunga@gmail.com>,
        <njoshi1@lenovo.com>, <smclt30p@gmail.com>
References: <20211113104225.141333-1-linux@weissschuh.net>
 <9cebba85-f399-a7aa-91f7-237852338dc5@gmx.net>
 <d1bc62e9-a5da-4c23-b31f-8ba718faf4a3@t-8ch.de>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <d1bc62e9-a5da-4c23-b31f-8ba718faf4a3@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.110.13]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a1108a5-c64b-44cf-44e8-08d9a9f6f935
X-MS-TrafficTypeDiagnostic: SG2PR03MB3595:
X-Microsoft-Antispam-PRVS: <SG2PR03MB35953E952C25ABA7FB0229ECC59A9@SG2PR03MB3595.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D90otXHL3KcKmKUacEEK0gPRbHuYwBQgFbks3wouo8wgOuUZN3dy5B2HeEeKeTzhdMHQeEBTJj2e9vlfFiDTd8YD2+xehqw22M+I5sKfHriZkmkwKVQUci275aSRpKNhd8vmRgrJXeQjHRxDyEzcx9j61j6WyBqO/3jl3/pF/Rjm2ycyFmHz5r+5rSFBwAdmivfspB6xjUWaFg0VF2tfOuE7DHqhWTBdd39kAine6D4UzXPz31LtI+kKwabT1+Vk3x5MOWG/1pMuZVB4t9ZOZsZj/wkkTSi/IJwU9pLqwEWlCbjjjaHvrogaQZoTJcA23U0QNu7t0Yf59gBOgRNfFQ0UD3ZfjaZrEOfHJxgtOz9M/JcBGdEvuHq+vsY2Nt1Y5L+fwGeb7XNDJM2u1H5b6KWE3rMxR0arYthIwhHW/W9LTERpYVxA8SkX9hbnsfEw+dGHbxmOAWqJMRQnPw0xI51Bk8x5mvProVdkY/3546uAST316RFvdwJbD9nx6phxWqjIwEh/se8eVmmMPfGvy2XsFcq0MZQOuy/rtRmu22uHYojiMiYkzZup87RgxYDeDz8BnEeAX1khBOi+DL4u+PHezdGh3TKhoRHKW5xqcS18eoC3n37StObXjQ/3XU7X3KFtUc06EQu4Fetwnrfk2rQj/VQz6EuIwfb7A9hKhyGqNJ/VIwqPGdLrik+k+6sGxcyHlYsObtZN1vrlm0mhJiUwIJLxNC/9v2/Pib67J4cUDVPmgbe37c/upVp7sfK/32gQElQRxB/W5Ue0iTILNYhCFQ7K8/b5BsDLZxP4rdI=
X-Forefront-Antispam-Report: CIP:104.232.225.6;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(63370400001)(426003)(4001150100001)(63350400001)(70586007)(86362001)(82310400003)(31686004)(36756003)(2906002)(336012)(16526019)(47076005)(26005)(53546011)(508600001)(7416002)(70206006)(2616005)(5660300002)(81166007)(31696002)(66574015)(316002)(16576012)(356005)(186003)(83380400001)(36860700001)(36906005)(54906003)(110136005)(82960400001)(8936002)(4326008)(8676002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 18:20:45.2325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1108a5-c64b-44cf-44e8-08d9a9f6f935
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.6];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0047.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB3595
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thomas,


On 2021-11-17 12:57, Thomas Weißschuh wrote:
> On 2021-11-16 17:56+0100, Thomas Koch wrote:
>> thank you very much for working on this. It is high time that we leave
>> external kernel modules for ThinkPads behind us.
>>
>> On 13.11.21 11:42, Thomas Weißschuh wrote:
>>> Hi,
>>>
>>> this series adds support for the charge_behaviour property to the power
>>> subsystem and thinkpad_acpi driver.
>>>
>>> As thinkpad_acpi has to use the 'struct power_supply' created by the generic
>>> ACPI driver it has to rely on custom sysfs attributes instead of proper
>>> power_supply properties to implement this property.
>>>
>>> Patch 1: Adds the power_supply documentation and basic public API
>>> Patch 2: Adds helpers to power_supply core to help drivers implement the
>>>    charge_behaviour attribute
>>> Patch 3: Adds support for force-discharge to thinkpad_acpi.
>>> Patch 4: Adds support for inhibit-discharge to thinkpad_acpi.
>>>
>>> Patch 3 and 4 are largely taken from other patches and adapted to the new API.
>>> (Links are in the patch trailer)
>>>
>>> Ognjen Galic, Nicolo' Piazzalunga, Thomas Koch:
>>>
>>> Your S-o-b is on the original inhibit_charge and force_discharge patches.
>>> I would like to add you as Co-developed-by but to do that it will also require
>>> your S-o-b. Could you give your sign-offs for the new patches, so you can be
>>> properly attributed?
>> S-o-b/Co-developed-by/Tested-by is fine with me.
>>
>> I tested your patches.
>>
>> Hardware:
>>
>> - ThinkPad X220, BAT0
>> - ThinkPad T450s, BAT0+BAT1
>> - ThinkPad X1C6, BAT0
>>
>> Test Results:
>>
>> 1. force-discharge
>>
>> Everythings works as expected
>> - Writing including disengaging w/ "auto" : OK
>> - Reading: OK
>>
>> - Battery discharging: OK
>> - Disengaging with "auto": OK
>>
>> 2. inhibit-charge
>>
>> Works as expected:
>> - Writing: OK
>>
>> - Disengaging with "auto": OK
>>
>>
>> Discrepancies:
>> - Battery charge inhibited: BAT0 OK, BAT1 no effect e.g. continues charging
>> - Reading: always returns "auto"
> 
> I tested it on a T460s with two batteries and there inhibit-charge works
> fine for both batteries.
> What does not work is setting force-discharge for both batteries at the same
> time.
> This makes somewhat sense as on a physical level probably only one of them can
> be used at a time.
> 
> Mark Pearson: Could you confirm that this is the intended behaviour?
> 
Confirmed - only one battery can be used with the BDSS command
