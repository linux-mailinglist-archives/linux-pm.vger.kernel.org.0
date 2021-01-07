Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1156F2ED2AC
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 15:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbhAGOgG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 09:36:06 -0500
Received: from mail-vi1eur05on2046.outbound.protection.outlook.com ([40.107.21.46]:11041
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728920AbhAGOgF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Jan 2021 09:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSIAOALgDypgXeBtAvLnj/htPKcmA9t8zr70mi6mdvg=;
 b=xPWyhUt3Aja81Fqil5WlXizD4BE8A4idAb1a/++iMbIjLyBEnoKK+Q4cSr3jJNJ9O1N9oYoZxg3nTHPz8go5mlsaOUbQK9SeK0+1elnuxU2zEMHuw+eJmmy6q+ofnYGOqWsCia8OSyRDa/p8xIVbpcFiLHRHmIxWgcnBqxp9Jm4=
Received: from AM6PR02CA0006.eurprd02.prod.outlook.com (2603:10a6:20b:6e::19)
 by AM0PR04MB7012.eurprd04.prod.outlook.com (2603:10a6:208:19e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 14:35:15 +0000
Received: from VE1EUR01FT060.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:6e:cafe::94) by AM6PR02CA0006.outlook.office365.com
 (2603:10a6:20b:6e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Thu, 7 Jan 2021 14:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 VE1EUR01FT060.mail.protection.outlook.com (10.152.3.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 14:35:15 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (104.47.0.57) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 07 Jan 2021 14:35:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOxkWjXRkrbG2beZ/WXCv5rh9R2WMrkdbDiaNKjEoLwfi0q8uUN7s6u59CG7YDk/EgeI8WJnynexvBnTwSDDDIHiwKB7rDQw0pC+NU+BL6RqTv+db/qLd1+80vYjjYtw7mT9GdgyAhGhz1MRYpyykLU+2XCmoNpysjmugE8EavQ+80fOo15HXqz8JaWzQajLVLgxR0FjHF0bT74/KNZXnQKUA+NuAd2rDalgn195Z2nRRy+zDO6pYaeivbb1T3gjPX1VU1F266+p43DaiSqrhvCatkjwOjst4ZZUU4cfz4KeX8qskMjzt+PBPoshb6ubZsxREO9NUGvK6U9FZetBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF3akNC+Btkm8spnNIZ83GEahd7XOscmhYj7rGHLeaM=;
 b=g0dOy9xJ68qvPpBB+e/aRATF2YC/qk/m7Mt+VnoOAz+VFxtwioXfBghOujkMwuTcHJgjFVOaXKr9uy8ccM20ez0HvAeeKIImOr/HX45Ao4QGiKSFHehCTEdhwWvmeIEIl4roa8mwEP2aX5YESMTPe2StzfIpMOb8+krfOx/AtH6z6nxIO2k6VkAbDPPzelO0vqRP5WIr0rstOhDKw1ibV3WqRM876VHikI7YtwnsYyGTSbI55uO8JzfhA0IoJpPk4f9EhVFHhheG7t/EwrCDpnl2delk+lFtzVE32p47XDbIhfiRbEZa+WYfImD/eWCcIG4RMBrHFGUJoP3tZQslNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DBBPR04MB6313.eurprd04.prod.outlook.com (2603:10a6:10:c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 14:35:12 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::29a8:2ae5:def6:f92b]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::29a8:2ae5:def6:f92b%7]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 14:35:12 +0000
Subject: Re: [PATCH v4] power/supply: Add ltc4162-l-charger
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210106075557.21626-1-mike.looijmans@topic.nl>
 <20210106151644.jyfpjvazof565mhk@earth.universe>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2ff663b7-f328-4158-a5aa-d92c6c556384@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.90a3859f-b700-411d-bf45-dcf42e1ca00a@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <53f764f3-8a0f-92dd-4a22-cd05c785c178@topic.nl>
Date:   Thu, 7 Jan 2021 15:35:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210106151644.jyfpjvazof565mhk@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [83.128.90.119]
X-ClientProxiedBy: AM0PR01CA0166.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::35) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM0PR01CA0166.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 14:35:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c959748-8288-4673-fb5e-08d8b31972d1
X-MS-TrafficTypeDiagnostic: DBBPR04MB6313:|AM0PR04MB7012:
X-Microsoft-Antispam-PRVS: <AM0PR04MB7012DE34841781F73638D1AF96AF0@AM0PR04MB7012.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: XuXlp9+rAUs0uGb5pGjQUCX0+tj6yd4+T8PsSBF40azpPaT09/Bo5t3UKoKff9IsrEmWMtDAepvfR1Tly4hKLGtqkfQjkU6Lx9cw1fhGxsBsnl9Txt9IK2hWus2xJYckLXAA5pYLgqL1woqxn0VvRfSp9kyT4ytRKspUiSmpPxK0WRU9VpjGheRxsEwJfeRtwGiox0dcd7KFG6+01p07hPMkjzh52MkgD4z0BPiL2nWxLtE3FyX+nyIK3Vg6MMHhzlDCWu/s/rK/ueBLM6w49DL5lLRgb6y23Va4H/h2WlDQx3FMm1OFx3bl8sLkc1sEosYeVJJEHkFIdES7V4ITvm+kejCjD3rk//aNyw0OdRbe6BFpJJddLJMRttkJ3ozkY0VeNMI8tFFoR82C/L7NKQP3sLQ+oJ+aqryClGekNsYOnwZIMNOdqZ7w7xExBUa5
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(396003)(39840400004)(44832011)(6486002)(478600001)(36756003)(2616005)(31686004)(5660300002)(956004)(6916009)(36916002)(42882007)(8676002)(31696002)(53546011)(2906002)(8936002)(16526019)(4326008)(52116002)(66556008)(186003)(316002)(66476007)(66946007)(83170400001)(26005)(83380400001)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?BpNGRjyjo49UONz3yqbje1ppRL0QOoqv06yZtYy88VkOv2TwjkpZVGjJ?=
 =?Windows-1252?Q?FLP1sguyyzzgnGcXJRyHl1JrRwAPg1u/CISaviAkBljFzrRrKyXnJngZ?=
 =?Windows-1252?Q?DbykSDseGgmAFGHsGGyaAzAPC/pTAma3vSHmnW+DYGZZNOs3KTGqEjbo?=
 =?Windows-1252?Q?RbuC7o7S/9HQXBSguAkdUbZQHsD0/JmnlR1SXJFNssRel0koLq1CHUMh?=
 =?Windows-1252?Q?hRwQg4/E7RDkmhunCYwgwNeqDtEmlmvPcJClN64iSUlXblhZjNqAWNMy?=
 =?Windows-1252?Q?K893jmYT2y7PTqv2KXge4PAiJV5Xkqd5XwCK97EedzUD7B2QXxCzvUFd?=
 =?Windows-1252?Q?Y9wfTxDi3jHuXFEPWBl5naAJ/qtUPX/0jWUqIeyZkYNfLTnGKGjq0ZKs?=
 =?Windows-1252?Q?Dh6Sjlg+4ltVzU5WKSSW6Cw5vXSMDXTZz5OJrhXN9R4/s2O1A7ebgwwD?=
 =?Windows-1252?Q?reJVRqzomF16RD/HfP1KCqE7ywleKiTa2NVmF+7mSx+nEYVI/XVfW0ma?=
 =?Windows-1252?Q?LNXLfP0TxvRLSmT5DONOIP32gGr2GQlfgDafcMUa98N69+wLarQT0wSH?=
 =?Windows-1252?Q?WHaoy0Q4Z6yvfremMvi6jO9SZhEFO/fuZ5lzbtM2RnJyL5bW1nhom8YN?=
 =?Windows-1252?Q?gPXfxAgcIZb478e9NSbBWyOSYfyfs1Dj7cHRN3HgTIQHEAXNHSJcXrUT?=
 =?Windows-1252?Q?aJZrfP1do75XA1Nydf+UJQ4UxMRbwdwEbclRnW8LVPydqkyW1BnzgEHc?=
 =?Windows-1252?Q?NH2h9iADLwfdO4yRYJd+8Zq3Jd294ZAT9FA28YZIVwJ/aU2mRt7Yj+2J?=
 =?Windows-1252?Q?DBCGfkuJwviPJMlPLK4KRub+zUUOzwHGUzSmasp0imD3POagnDFdHyHa?=
 =?Windows-1252?Q?okCcwn1qSjngk+EdWCdQ2gYmhgI9uKZZJepEkr8fCFQHi3tWYknls0yI?=
 =?Windows-1252?Q?fi5GXOpbhzo9cuhJ4w3XsZnQKpSMJ7Wvl4iT7Ij1/DQpDI68wPRygzQm?=
 =?Windows-1252?Q?HbuTJEWkJ41S6dWQXDCyGfOd9jqs1xR7QdiwAa+fYuOLsGnAPwhd9W74?=
 =?Windows-1252?Q?tc6BYbGK14SL6nGh?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6313
X-CodeTwo-MessageID: 7e70aebb-43f7-4bcb-b6ce-5c38a07bda8a.20210107143514@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: c67f1e87-1052-425e-d844-08d8b31970d0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8OKKzMjhfUtM9+JW+HKmh0hAKHIU7DJ6eGLfFZTCYKHT9lL7fXUsf1vUeUiDcfF1Cs7O8NKxh3VqdY/NvPOz2kizm5/ny1uW9+02pOvXz55dUn8Z8yGexrCdcLxVv76znOD57SCoCeQe6jg+0LWVCCDpyQ1XJtoVi5HH1nGLaKQHhhLBrJhnR8VyFyesyT2UJxKeGIilUyKVjhpiP7U4NWqJSEFb2JMQRZTBWJYqXB8W5GxqMV7ho+Sp7AKOQeullFOEbFCtZJFhW9izgFXX0DLRyPzZLYTkWNo1Dy73u5AQikRcOEJFrfVnA+USgjS/CPlzJvMg3lKu8czt6fELrJ5VewJDUf9ArInJN2apD3PPEM1ZhQ4w+dTPpQ/Fbm+Qg6+fJdieYFB/7r2ZifzAj71pJ6SF5V2bAfBcTEd21rJ9T3Mh53t2xhkNXVTHcU8cZsmqphNiiM5xGt//Udcq9B3b6Iqa4pb+n+oOyTcw+dACFtyrOU8VwZCnlUhGfQMLc+MuMAmKPwgykNECtYK5anRQvvS4jroMnkWO2YKtjmo5sFaJ5ANcsq6tMc/ifUOEnfDgY3lnNaR9fvCLI8q0HIwlupG+4MJ4Hu3pvJRV6I=
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(396003)(39840400004)(376002)(346002)(136003)(46966006)(34070700002)(47076005)(16576012)(7636003)(6916009)(26005)(316002)(186003)(70586007)(82310400003)(31686004)(70206006)(83170400001)(7596003)(83380400001)(15974865002)(356005)(42882007)(6486002)(36756003)(44832011)(4326008)(53546011)(2906002)(8936002)(8676002)(31696002)(16526019)(336012)(36916002)(478600001)(2616005)(956004)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 14:35:15.3664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c959748-8288-4673-fb5e-08d8b31972d1
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7012
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topicproducts.com=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 06-01-2021 16:16, Sebastian Reichel wrote:
> Hi,
>
> On Wed, Jan 06, 2021 at 08:55:57AM +0100, Mike Looijmans wrote:
>> Add support for the LTC4162-L Li-Ion battery charger. The driver allows
>> reading back telemetry and to set some charging options like the input
>> current limit.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>> v2: Use microohm units instead of milliohm
>>      Add interrupt support using smbalert
>>      Support obtaining cell-count from devicetree
>> v3: Fix overflows in calculations involving resistor values
>> v4: Use attr_grp member to register attributes
>>      Report input current/voltage for charger and make battery
>>      voltage and current into sysfs attributes
> Fine with me until we have a better way to solve the problem. IIUIC
> you no longer have access to the hardware anyways? But you need to
> document the custom sysfs nodes: Please document them in the
> following file:
>
> Documentation/ABI/testing/sysfs-class-power-ltc4162l

v5 is on its way with a description.

I currently don't have access to the hardware, so these changes were=20
only compile-tested.

> [...]
>
>> +static int ltc4162l_remove(struct i2c_client *client)
>> +{
>> +	struct ltc4162l_info *info =3D i2c_get_clientdata(client);
>> +
>> +	sysfs_remove_group(&info->charger->dev.kobj, &ltc4162l_attr_group);
>> +
>> +	return 0;
>> +}
> power-supply core automatically removes the sysfs groups specified
> in power_supply_config.attr_grp.

Ah, good catch, missed that.


>
> -- Sebastian


--=20
Mike Looijmans

