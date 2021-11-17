Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4742454997
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 16:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhKQPNA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 10:13:00 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.114]:19357 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231697AbhKQPM7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 10:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1637161800; i=@lenovo.com;
        bh=8Wace4vgsr6K04P42YLHpI7mpF1rF9Zxa1s2cQnZoc4=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=TLbhJBTVSuVP9nvoA4RRvfY+MSiOZRJjlc6GVDnp83f3oGbN62q5pbtnA9h/8DaYu
         +qtfjoqAFuzMG3LXBrCR4BXvXWD2j93hdi0EwU5VhuO+HBP547boMLvdg89FaPMiv/
         0anwoJtOR6ejqi9fpRi59nqSkQNpIpUIJ1i21FhoOpiK7khdxPRsxDjx4sm/N+ExZq
         H5WwZaGvuDB8hwIeet5pilNuhZqP7nJQLLcOiVc0kFfiysNOr6sKSqe/Zp9NR4+TWJ
         FlZb0+RQyaTuEtYR9SYraNjsYR97I8tCu1918hA3W22tDKQrYgtULny+wksMKn8p+h
         71//p4al8r4CQ==
Received: from [100.112.133.242] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-west-2.aws.symcld.net id A9/72-31742-74B15916; Wed, 17 Nov 2021 15:09:59 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLsWRWlGSWpSXmKPExsWSoS+lr+suPTX
  R4ISjxf7rEhZfv91mt3hzfDqTxfrfK1ksZh+2sWi994vN4vKuOWwWn3uPMFr8/vGMyeLA1GnM
  FtuaDzNarN7zgtniyuQbjBand5c48HnsnHWX3WPxpv1sHr+2rWHx+H2A0WPTqk42j90LPjN5v
  N93lc3j8yY5j/7uY+wBnFGsmXlJ+RUJrBl3ju9gLnhiVvH5nkAD43TdLkYuDkaBpcwSqze3sk
  E4i1gl1m6exQjh9DJJnD57lgnEERKYzyRx9sw9KOcQk8TSH+dYQBwJgeOMEt2H1kFlOhklfrw
  6xQLhTGKSeNK0Esp5wihxfelFqLJHjBI7nm0GWsrJwStgK/Hs1gEwm0VAVWJqyyl2iLigxMmZ
  T4C6OThEBcIlGu4Ug5jCAhESmw+GglQwC4hL3HoynwnEFhGwkVhx6TEryHhmgW3MEr/n/GCH2
  HWOUeLl1i8sIFVsAtoSW7b8AtvFCdQx/fx/ZohJmhKt23+zQ9jyEs1bZ4PFhQSUJX71nwezJQ
  QUJJo+9DBC2AkSPf8esUHYkhLXbl5gh7BlJY6encMCYftKXF+4BqpXS2LO9wdQ8RyJLdNWQMX
  VJHZ0/maZwKg3C8nLs5A8NwvJebOQnLeAkWUVo1lSUWZ6RkluYmaOrqGBga6hoZGuobGJrqle
  YpVukl5psW55anGJrpFeYnmxXnFlbnJOil5easkmRmCiTCloY93BeP71B71DjJIcTEqivLGMU
  xOF+JLyUyozEosz4otKc1KLDzHKcHAoSfBO4APKCRalpqdWpGXmAJM2TFqCg0dJhHeWBFCat7
  ggMbc4Mx0idYrRkmPCy7mLmDm6ehYCyUlHdm9nFmLJy89LlRLnPSUJ1CAA0pBRmgc3DpZZLjH
  KSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5o2WAprCk5lXArf1FdBBTEAHyV6eDHJQSSJCSqqB
  qVztkmPw8wDLNCZFv5sSG31NEjvk77vUrTz02nD2s73nHh+8sMGu5MnH/xcvarCGHFj88+PWs
  /HlrC88ogL1pnonfZh16Ipi0+XZLllz+zYm/lM9H/T5h9bERuXe63EarnufpKtJLbl/LsonVb
  WKUeizlEP4iqCaj4GWjvpvhWR4eIx5lFSfK/Vo2WR7Fy6Quf4hQfG04c+q3J33eTTu/Eq5c/n
  goZAMNjfzTV1eEet2LXL38fEx880sEJo7f/t07YNnLzrz5jhpxMz22My76pL32gWXmoUfNtS2
  ZWzhOMQgsztc9NBj2zt1NqE7GXzK/O/23XRvWZUd/qh2Zdqek70q7me4Nm/dceTW6U3HlViKM
  xINtZiLihMBeAnobKcEAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-13.tower-355.messagelabs.com!1637161797!11294!1
X-Originating-IP: [104.47.26.47]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3017 invoked from network); 17 Nov 2021 15:09:58 -0000
Received: from mail-psaapc01lp2047.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) (104.47.26.47)
  by server-13.tower-355.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Nov 2021 15:09:58 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cdjf+GzjiBjPU3CI73riZBs2pWq+W30cTF3QTjY9rHjZarkVJMyK4+uuYRgq3KvXKtHq0MZDmDgISlUEI9IZZ/idNrxyWLcTPgERbB5bGepUcy9PiUqFuf15a+Sy8/OY0bYqHURvzmHCj363PFd2cw4rrDEMmPC8KCMP4iTtM8KFuhfYgjmR7C2ioV8kjYEMKU7dkT0bA7hoBVnpec32F+j1xuO0ALT5SoMiR41tR4j10eIZnWAcjoCA1ET169ScwiwSsWts5I8+K/gHdLU5tmgj1ZnC53Yuf9tzE3xswAJYUlb3c9vLeH8+CJYU136D4hnRdnzcSgL/fFAzQflhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Wace4vgsr6K04P42YLHpI7mpF1rF9Zxa1s2cQnZoc4=;
 b=QHsvnM6V/7omj7ezr9AGLAv6kByNwBfagL5xnv89Ojtzm/JtCqjJxtEstsO90+2X9XmJJxWI4R1E8BineDuByfDhfNVwlOO8uAIvarjGt/k9x+f3vio1b2yn15edt3FPO4zpFqDbD5GQhg2iEdmulnztJ6G09WYo7O9ohPSNxiwcI2osj6sBmmKaIlmqjKHyxqfdhc6nYxm0DgOqU0/KdL5egq5LxwTIMcoTVQUwbsSbMKa2xirwU9qSimjP3oDHXMLaW+Zjc6GpHkFXGQ/945oq5LSTs+n/BnjJJ5xidPAU6nGcYtjZZdmKfJgwJ2EQ5hA0C3LCsRpZEcygdkKcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=weissschuh.net smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from PS2PR03CA0023.apcprd03.prod.outlook.com (2603:1096:300:5b::35)
 by HK0PR03MB4772.apcprd03.prod.outlook.com (2603:1096:203:b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.17; Wed, 17 Nov
 2021 15:09:55 +0000
Received: from HK2APC01FT011.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:5b:cafe::dc) by PS2PR03CA0023.outlook.office365.com
 (2603:1096:300:5b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.7 via Frontend
 Transport; Wed, 17 Nov 2021 15:09:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 HK2APC01FT011.mail.protection.outlook.com (10.152.248.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 15:09:53 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.20; Wed, 17 Nov
 2021 10:09:52 -0500
Received: from [10.38.110.13] (10.38.110.13) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.20; Wed, 17 Nov
 2021 10:09:50 -0500
Message-ID: <61226b12-6c24-334d-c635-8981c5ddcbaf@lenovo.com>
Date:   Wed, 17 Nov 2021 10:09:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [External] [PATCH 4/4] platform/x86: thinkpad_acpi: support
 inhibit-charge
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
CC:     <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
        <ibm-acpi-devel@lists.sourceforge.net>,
        <platform-driver-x86@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        <linux-kernel@vger.kernel.org>, <linrunner@gmx.net>,
        <bberg@redhat.com>, <hadess@hadess.net>,
        <nicolopiazzalunga@gmail.com>, <njoshi1@lenovo.com>,
        <smclt30p@gmail.com>
References: <20211113104225.141333-1-linux@weissschuh.net>
 <20211113104225.141333-5-linux@weissschuh.net>
 <82ec6164-223b-940a-6992-48ccbe47a615@lenovo.com>
 <986a547b-67c5-4116-9b2a-d3ba7b2f7847@t-8ch.de>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <986a547b-67c5-4116-9b2a-d3ba7b2f7847@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.110.13]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc1cc1e7-e550-42ff-aded-08d9a9dc4fb9
X-MS-TrafficTypeDiagnostic: HK0PR03MB4772:
X-Microsoft-Antispam-PRVS: <HK0PR03MB4772E1E9EE4BB3C29F28B99EC59A9@HK0PR03MB4772.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5+LE0mF7xghj4uQ1nMqalQLDUJIZC7bZqy9RdA1sbJ2PhbdH15/f81LS2Hl5fLYAAloqkrnb+W80TaifMbGLnhakh9m0FnjypaRKU6XVx9/DrsFeVjmA8UFF8GFXrOD0Z8zzKZUKv3JuIc6HFKTiY1VNrZBiN9lnyn/6rTmFcs8LEdmR9JecmpPiSpKY6/PHGmFGK7DQ5DyKNF2it0WBGmSQl/MA4w2uh5FYaLpIQ+G00AK0cdEDjGQGDvocRDcdg7+jZJa8p1eTofA4xasOQKp9C8sJMWmqA5QXazHXwxAbaPzS+ttnqAUuhhOFrI01pZHPPk146w+NpB/Zp8mNgRLdaVQZRVWpPrLWRgIe1apGvrj5YUzNeLh+kB64rNy8RXGsoflSa8a0xoIyWmLaQnTY2puV3IMB8q3Zs5tFawVN9UdVdfbxS5Fuw0TNZ3hzfeEe7W6RYikblBf5RFL0pZTMg01ktyQQEsl3to5Pd6E7rZ3n/C3n54rjyqsx0iQFGfn6+1CmwzOHOs1tTzEDdOCfShLnxLUNpaZ7OfBho37ccfP+9t/TB8zsAkzkfkjmp9Nx5ragySovFtQHQcqE4CZGXZCjhfr9z9pkzn2/Jkte2D9W6IHcBeXSxHmVM35/MgEasp2Ct7vxw8zokQY249o+fNo82RNb9MK9wB4WwMf6MqYRrX2v5C0gId4TIFtewHTsAqTxHGmZAW7JuekZIvvtsEOId2zJXEwr9VralraKiCidGVsQRZhMV2v9Nn+9SKBU6mC0YvIjfZ9+SW6OsyKfnnM2We6IBPXnzKGz4RGZe+5B8T0A81a1RNczoTD52xmlY9y6L1h3ZRRAcIx0nIlwPmZB6AP5CJKxQxdpjYSXlbVPBdziynq9WguwEMT
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(2906002)(4326008)(5660300002)(36756003)(7416002)(186003)(31686004)(16526019)(8676002)(53546011)(2616005)(82310400003)(4001150100001)(70206006)(16576012)(70586007)(54906003)(26005)(8936002)(36906005)(82960400001)(316002)(66574015)(83380400001)(81166007)(31696002)(47076005)(336012)(356005)(426003)(86362001)(6916009)(966005)(508600001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 15:09:53.9836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1cc1e7-e550-42ff-aded-08d9a9dc4fb9
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT011.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB4772
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thomas

On 2021-11-16 18:44, Thomas Weißschuh wrote:
> Hi Mark,
> 
> On 2021-11-16 15:52-0500, Mark Pearson wrote:
>> On 2021-11-13 05:42, Thomas Weißschuh wrote:
>>> This adds support for the inhibit-charge charge_behaviour through the
>>> embedded controller of ThinkPads.
>>>
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>>
>>> ---
>>>
>>> This patch is based on https://lore.kernel.org/platform-driver-x86/d2808930-5840-6ffb-3a59-d235cdb1fe16@gmail.com/ ---
>>>  drivers/platform/x86/thinkpad_acpi.c | 55 +++++++++++++++++++++++++++-
>>>  1 file changed, 53 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>>> index e8c98e9aff71..7cd6475240b2 100644
>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>> @@ -9321,6 +9321,8 @@ static struct ibm_struct mute_led_driver_data = {
>>>  #define SET_STOP	"BCSS"
>>>  #define GET_DISCHARGE	"BDSG"
>>>  #define SET_DISCHARGE	"BDSS"
>>> +#define GET_INHIBIT	"PSSG"
>>> +#define SET_INHIBIT	"BICS"
>>>  
>>>  enum {
>>>  	BAT_ANY = 0,
>>> @@ -9338,6 +9340,7 @@ enum {
>>>  	THRESHOLD_START,
>>>  	THRESHOLD_STOP,
>>>  	FORCE_DISCHARGE,
>>> +	INHIBIT_CHARGE,
>>>  };
>>>  
>>>  struct tpacpi_battery_data {
>>> @@ -9409,6 +9412,13 @@ static int tpacpi_battery_get(int what, int battery, int *ret)
>>>  		/* The force discharge status is in bit 0 */
>>>  		*ret = *ret & 0x01;
>>>  		return 0;
>>> +	case INHIBIT_CHARGE:
>>> +		/* This is actually reading peak shift state, like tpacpi-bat does */
>>> +		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_INHIBIT, ret, battery))
>>> +			return -ENODEV;
>>> +		/* The inhibit charge status is in bit 0 */
>>> +		*ret = *ret & 0x01;
>>> +		return 0;
>>>  	default:
>>>  		pr_crit("wrong parameter: %d", what);
>>>  		return -EINVAL;
>>> @@ -9447,6 +9457,22 @@ static int tpacpi_battery_set(int what, int battery, int value)
>>>  			return -ENODEV;
>>>  		}
>>>  		return 0;
>>> +	case INHIBIT_CHARGE:
>>> +		/* When setting inhibit charge, we set a default value of
>>> +		 * always breaking on AC detach and the effective time is set to
>>> +		 * be permanent.
>>> +		 * The battery ID is in bits 4-5, 2 bits,
>>> +		 * the effective time is in bits 8-23, 2 bytes.
>>> +		 * A time of FFFF indicates forever.
>>> +		 */
>>> +		param = value;
>>> +		param |= battery << 4;
>>> +		param |= 0xFFFF << 8;
>>> +		if (ACPI_FAILURE(tpacpi_battery_acpi_eval(SET_INHIBIT, &ret, param))) {
>>> +			pr_err("failed to set inhibit charge on %d", battery);
>>> +			return -ENODEV;
>>> +		}
>>> +		return 0;
>>>  	default:
>>>  		pr_crit("wrong parameter: %d", what);
>>>  		return -EINVAL;
>>> @@ -9467,6 +9493,8 @@ static int tpacpi_battery_probe(int battery)
>>>  	 * 4) Check for support
>>>  	 * 5) Get the current force discharge status
>>>  	 * 6) Check for support
>>> +	 * 7) Get the current inhibit charge status
>>> +	 * 8) Check for support
>>>  	 */
>>>  	if (acpi_has_method(hkey_handle, GET_START)) {
>>>  		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_START, &ret, battery)) {
>>> @@ -9513,6 +9541,16 @@ static int tpacpi_battery_probe(int battery)
>>>  			battery_info.batteries[battery].charge_behaviours |=
>>>  				BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE);
>>>  	}
>>> +	if (acpi_has_method(hkey_handle, GET_INHIBIT)) {
>>> +		if (ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_INHIBIT, &ret, battery))) {
>>> +			pr_err("Error probing battery inhibit charge; %d\n", battery);
>>> +			return -ENODEV;
>>> +		}
>>> +		/* Support is marked in bit 5 */
>>> +		if (ret & BIT(5))
>>> +			battery_info.batteries[battery].charge_behaviours |=
>>> +				BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE);
>>> +	}
>>>  
>>>  	battery_info.batteries[battery].charge_behaviours |=
>>>  		BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO);
>>> @@ -9673,6 +9711,11 @@ static ssize_t charge_behaviour_show(struct device *dev,
>>>  			return -ENODEV;
>>>  		if (ret)
>>>  			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
>>> +	} else if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)) {
>>> +		if (tpacpi_battery_get(INHIBIT_CHARGE, battery, &ret))
>>> +			return -ENODEV;
>>> +		if (ret)
>>> +			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
>>>  	}
>>>  
>>>  	return power_supply_charge_behaviour_show(dev, available, active, buf);
>>> @@ -9710,12 +9753,20 @@ static ssize_t charge_behaviour_store(struct device *dev,
>>>  	switch (selected) {
>>>  	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
>>>  		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 0);
>>> -		if (ret < 0)
>>> +		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 0) || ret;
>>> +		if (ret)
>>>  			return ret;
>>>  		break;
>>>  	case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
>>>  		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 1);
>>> -		if (ret < 0)
>>> +		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 0) || ret;
>>> +		if (ret)
>>> +			return ret;
>>> +		break;
>>> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
>>> +		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 0);
>>> +		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 1) || ret;
>>> +		if (ret)
>>>  			return ret;
>>>  		break;
>>>  	default:
>>>
>>
>> I can confirm the bit fields are correct for these calls (as for the
>> previous patch)
> 
> Thanks!
> 
> Could you doublecheck the behavior for multiple batteries to maybe find a
> reason why BAT1 is not inhibited as reported by Thomas Koch [0]?
> 
>> Couple of things to note, based on feedback previously from the FW team
>> that I found when digging thru my battery related emails.
>>
>> "Lenovo doesn't officially support the use of these calls - they're
>> intended for internal use" (at this point in time - there is some
>> discussion about battery recalibration support but I don't have details
>> I can share there yet).
>>
>> The FW team also noted that:
>>
>> "Actual battery charging/discharging behaviors are managed by ECFW. So
>> the request of BDSS/BICS method may be rejected by ECFW for the current
>> battery mode/status. You have to check if the request of the method is
>> actually applied or not"
>>
>> So for the calls above (and for the BDSS calls in the previous patch) it
>> would be good to do a read back of the setting to ensure it has
>> completed successfully.
> 
> I'll add that for v2.
> 
>> Hope that helps
> 
> It does, thanks!
> 
> Thomas
> 
> [0] https://lore.kernel.org/platform-driver-x86/9cebba85-f399-a7aa-91f7-237852338dc5@gmx.net/>> 
I got confirmation that:

<quote>
BDSS have to be used with specific battery. Please use with Primary(=1b)
or Secondary(2b) as Battery ID (Bit9-8)

Bit 9-8: Battery ID
= 0: Any battery
= 1: Primary battery
= 2: Secondary battery
</quote>

It seems you can't use BDSS with all batteries.
I'll confirm on BICS what the limitations are, they didn't update on
that piece yet I'm afraid. Unfortunately I don't think I have any
systems with two batteries to test myself.

Mark

