Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86106453B01
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 21:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhKPUiZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 15:38:25 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.116]:57428 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhKPUiY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 15:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1637094926; i=@lenovo.com;
        bh=EpwRR0N7Dal5zpGQjWxpXXvigL6aaWTCYVu2zm2GK6Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=mPS5MuFbenM/TpMWx/yz+lToujBPWigVURTx9dhPRum79Rml/GLeeyMW5XlezDh+Q
         6cMIg490yXeYJ+J8A/aPhd3zjzGo/y3rP/VjwvFzX1fW7Fa2G/nkOlzKjipNrRa9/q
         MYQbk5uTpq16wcFVIk1iDXm5R0bBwPcoephr7Gg/zEGmc5LMs3QwJMRfJGxmgwlZko
         KEV1M8pJ9NDat/GSLjbupaqs4W1I95UovDCM7FDSbco2MjwvGmWFt1FtwIWWcIBT+I
         WzMLQr9yXaS2dA8GK+qK/pk/i8kJZ+WqytEyk5wuFZsFppVqlZ7C46qTLDtTjtG79p
         3r1R4Jg16QihA==
Received: from [100.112.6.161] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-c.us-east-1.aws.symcld.net id 96/74-27078-D0614916; Tue, 16 Nov 2021 20:35:25 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTf0wTVxzn3V2vB+PgaEEeZGBWgj/YWqgx7Bb
  GZDO4qkExZnEuWfSAg9aU0vWKAtGFSGBDYHShuFEkMswShSGzCv62DAYGXKfhlyI4hSCByvgx
  fgzbbdmdh4799/n1vt/PS94jUFmRNJRgc8ysycDoFbgPpo0+Gqck11iZGHeZjHbch/Ti0pCUn
  rr9DUI3ec5hdHX7u3Thb26c7r12Cqfny34GtGd5HKFbK0+idEtBO6AbbkygdF/FA0DfuW5O8N
  NctT2Sas7YHbjG3fIDpvG0Ao29vhjXXK+dRzQzt/pxzbw9XFNe0ilN9v5EojOkZOUclGhbHnT
  ixmk6548nxXg+sESfAD4EoL5H4bCzFBVJnQRay3skIilD4B2nExGIjLIhcOniSYlIWnniWMAE
  AqnbAJa0nV+JFQO47OrGRGJBYNuF8RVnDEDHeA9PvHnyBMArzk9PAIIgqXjYcJ4SZIyKhLWXv
  0IFTFIBsKtqDBMiQdQ+mD/MCbKc2g8flnQBAaNUMHw4dvrFxECqE4HNw1uEVSjVCOB3rjkgrj
  oEF4r6X4Rw6k146ZIbF7A3FQf7mn5HxUEbYeFlj1TEa2FBczUqno2A7vK7qNAB8np+lbcgQ+o
  gLP1nFBdxCBwYvCcVcRjscJ7CxHgSHLG8LcpR0LlYgolYD5s7llbwOnizaAm3AJVt1YVtq25m
  W1XOtqpcLcDqQWyKSZehNWcyOr1SHROjVKs3KTcr1e+oVUyeMlWVzSlZhjMreXqEU3G5man6N
  JWBNdsB/yTTjJjjCuh7NqtqAyEEoggi14xUMDK/lKy0XC3DaQ+YsvUs1wZeJwgFJGt9rIwswM
  RmsDnpOj3/sF/akPBVBJK7g3ib5IxMJqfLEK1uoCQskzV1qAwzZBnY0GByuxCihJA22/BqxMv
  v0QPCQuUk8PLykvkaWVOmzvx/3wWCCaCQk1mB/BRfncH8apOLL4HwJcJ6K4QSZuY/KzQf2f9j
  /PxPZ7cNvD+R/PTQNX+vW5UB4Y+tkqE9X+7YlPy4O3zrzfUXRwvu5TgkpePFNdPP2a11v/ZtK
  z/cV8cc7U08Zm+dbU6qur+07w2fga4zxmeJtTPnKlP0EZN50ue66hs7q3Z/saX326dnXYnutO
  NTybNvJfjtbVxvb9etmytVyPGOgbt/x9YUWmfj5pLjXCMTp79ee3ghY2qxO31Drrf8A3Z40LV
  nYTBlOSRJ6d8LZsrd8eHpY/WpGw9MVMiPN17Q+s8MjUcckWzor57OK/u4xdMUyX0URR4baQC7
  mt6LTZrtj0ydfGTmAh3crtd++dDPkrBj7+arg5//Fdo4+Nmfo9GExK3AOC2jjkJNHPMvUlxER
  5kEAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-9.tower-415.messagelabs.com!1637094923!56410!1
X-Originating-IP: [104.47.124.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1364 invoked from network); 16 Nov 2021 20:35:25 -0000
Received: from mail-hk2apc01lp2059.outbound.protection.outlook.com (HELO APC01-HK2-obe.outbound.protection.outlook.com) (104.47.124.59)
  by server-9.tower-415.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Nov 2021 20:35:25 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwYKDVf85SUkctZvdYXS/cyYnxD0Vy0n8RDpnTGE9pT3y9hi+6O6O0t+EMkzfdeVaV9E67O8ULQO83C/ERNVU7ItttcELKeUTZbGtd6WJVP/YcQCUjANkqRsk2OJnEXDSb++G5OmSezJr2Ct3W4D4xvBbHpIP8LbIyXWH9JoiQQkg9CGLgEW9yP3jn19mf5gjBV7zzATn5NO8lHYnfIIytQLGWqSUPf3q6vheZtWcMRfxJVb4GpL46NEs+Ct27NTQ8mhK6M0E0biUA2h5nafOfUpz38gzb3N8IpCVHGoN2xIOgP/UkAfm7e8RkTOaMD1l8ZApsOSx8JX1KUeJTFpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpwRR0N7Dal5zpGQjWxpXXvigL6aaWTCYVu2zm2GK6Q=;
 b=IdI/8vx4EIbLdgsrzXb3wzBI4MwZYCa8HPpgew4KcXbwFxQlBzdDXfFeprki7mKQyd7BQdnC8Zmyr0eYcrmxSpB+5ei78vj20WYJWEzCFYsC36RS+OYDiNBJR1KrWpYH/4azrY9wQtymKiDxojgLgTF1T27xu5eIoUY6+UKPJufW8AnmnuLtv72cJXoCJYbYF88MzaeUhqKt5aq+mUWuI+dYUvi9KN3uPz2CH0k3AsbFvCivsLiKKWdpHmE7e/Cr4YyQStVE/9UI0PrmQxi7/AMKOFTvxj1as7b2yWbHZ35DzxpJDorTmtdT9ZE9ZRwhlrF7qdp7I47J9OemjpbB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=weissschuh.net smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from SG2PR06CA0208.apcprd06.prod.outlook.com (2603:1096:4:68::16) by
 SG2PR03MB3338.apcprd03.prod.outlook.com (2603:1096:4:17::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.15; Tue, 16 Nov 2021 20:35:22 +0000
Received: from SG2APC01FT0034.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:68:cafe::77) by SG2PR06CA0208.outlook.office365.com
 (2603:1096:4:68::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25 via Frontend
 Transport; Tue, 16 Nov 2021 20:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 SG2APC01FT0034.mail.protection.outlook.com (10.13.37.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 20:35:21 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.20; Tue, 16 Nov
 2021 15:35:19 -0500
Received: from [10.38.49.20] (10.38.49.20) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.20; Tue, 16 Nov
 2021 15:35:18 -0500
Message-ID: <f5b7c3fe-dfcf-da4f-b0a8-2ed256b95d47@lenovo.com>
Date:   Tue, 16 Nov 2021 15:35:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [External] [PATCH 3/4] platform/x86: thinkpad_acpi: support
 force-discharge
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
        <ibm-acpi-devel@lists.sourceforge.net>,
        <platform-driver-x86@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
CC:     <linux-kernel@vger.kernel.org>, <linrunner@gmx.net>,
        <bberg@redhat.com>, <hadess@hadess.net>,
        <nicolopiazzalunga@gmail.com>, <njoshi1@lenovo.com>,
        <smclt30p@gmail.com>
References: <20211113104225.141333-1-linux@weissschuh.net>
 <20211113104225.141333-4-linux@weissschuh.net>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <20211113104225.141333-4-linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.49.20]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdabcf4e-9762-4fc1-2fd7-08d9a9409cba
X-MS-TrafficTypeDiagnostic: SG2PR03MB3338:
X-Microsoft-Antispam-PRVS: <SG2PR03MB333821AF6F25867F228E45A4C5999@SG2PR03MB3338.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsoB4dk+sD66on8UVfr5djAhGDrmpY+GMyhkCEdbifW+8a+/Bj7gKvXMmC8lGuNw2xyFbwX1PCGQVCaBFMBo4oaybmVacpNzJj7GQSZ14wVPcRpQLGXthd6c2c6OiS1wuQAH//iINdlZrmHjNsU/Bbfp0J5d933+v0LDzoK+HjbkPJOAEutvPClHyMlYk1AQ7yuDIe/JJ5dybHiCGwNiAqPhxbWKs8NzG0683MgBzYNsrOJb4tQc1IKgBko3w3lx5jWEFWUH9hCW+Zh942jHnKN+a9wDsL/ec6tJcr+R8RUpqDT/LWacJa54axzMF0FP2GItaI0MiWAC/VJKqb+Q9lwjppyoPSvcpkdigaUNoDqRa9QiI28KcoaW5UxbS/uGAn+xLqHgPGXq/FYguy4REg48jvnRVEyMahT4SEBcBr8YAMXpDwyIGjtO1GsqZQ7s5qNgszVwkkQumT4oLH38YMoYcGFpfMuVwOuEdh42cXgpeSZJ4V9iF+j90rZCTYL1G6xttlS53efivM/8zFiXWjtAGAspU9CtU7OdsR1v5G0rnL7jfJ9MkxgBkMaiYXWUJQuPQGaOp2kgpImQKCcwAzFvxpvWI+CuXoeumvPMKOYCxS0qGJoRjab7zHDBPPDtN9hICasRo1EgjTCSqD7BeuTh9ustTKJUwxgugF0TUJ4Qu8ySe1DI/S05O1maZVDY/WBxP7/VtRzRM6qnBVrigo5eriS9Fsf8/59q1pgucQVZP0GXcifoy/XMJYK+/ha5ZLLcK/iuQGUnWTVYJmyhlOVx2iNQrpvj4+vnhTvJl7v/b087pU+YtRAo32lXcAUTNbY204EteHPGeMwNdfZZU8BGXstPJfad+6U9zsKG14j55mlhgy0+ba3zqLETW/m9JQ+NwDcq/D3NhQnBN221MA==
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(83380400001)(966005)(36756003)(66574015)(81166007)(316002)(36906005)(82960400001)(8936002)(2616005)(47076005)(508600001)(31686004)(53546011)(26005)(356005)(36860700001)(70586007)(2906002)(8676002)(31696002)(54906003)(82310400003)(110136005)(4001150100001)(16576012)(4326008)(5660300002)(426003)(186003)(70206006)(16526019)(336012)(7416002)(86362001)(3940600001)(43740500002)(36900700001)(2101003);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 20:35:21.6917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdabcf4e-9762-4fc1-2fd7-08d9a9409cba
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0034.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB3338
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thomas,

On 2021-11-13 05:42, Thomas Weißschuh wrote:
> This adds support for the force-discharge charge_behaviour through the
> embedded controller of ThinkPads.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> ---
> 
> This patch is based on https://lore.kernel.org/platform-driver-x86/c2504700-06e9-e7d8-80f7-de90b0b6dfb5@gmail.com/>> ---
>  drivers/platform/x86/thinkpad_acpi.c | 103 +++++++++++++++++++++++++--
>  1 file changed, 99 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 9c632df734bb..e8c98e9aff71 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -9319,6 +9319,8 @@ static struct ibm_struct mute_led_driver_data = {
>  #define SET_START	"BCCS"
>  #define GET_STOP	"BCSG"
>  #define SET_STOP	"BCSS"
> +#define GET_DISCHARGE	"BDSG"
> +#define SET_DISCHARGE	"BDSS"
>  
>  enum {
>  	BAT_ANY = 0,
> @@ -9335,6 +9337,7 @@ enum {
>  	/* This is used in the get/set helpers */
>  	THRESHOLD_START,
>  	THRESHOLD_STOP,
> +	FORCE_DISCHARGE,
>  };
>  
>  struct tpacpi_battery_data {
> @@ -9342,6 +9345,7 @@ struct tpacpi_battery_data {
>  	int start_support;
>  	int charge_stop;
>  	int stop_support;
> +	unsigned int charge_behaviours;
>  };
>  
>  struct tpacpi_battery_driver_data {
> @@ -9399,6 +9403,12 @@ static int tpacpi_battery_get(int what, int battery, int *ret)
>  		if (*ret == 0)
>  			*ret = 100;
>  		return 0;
> +	case FORCE_DISCHARGE:
> +		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_DISCHARGE, ret, battery))
> +			return -ENODEV;
> +		/* The force discharge status is in bit 0 */
> +		*ret = *ret & 0x01;
> +		return 0;
>  	default:
>  		pr_crit("wrong parameter: %d", what);
>  		return -EINVAL;
> @@ -9427,6 +9437,16 @@ static int tpacpi_battery_set(int what, int battery, int value)
>  			return -ENODEV;
>  		}
>  		return 0;
> +	case FORCE_DISCHARGE:
> +		/* Force discharge is in bit 0,
> +		 * break on AC attach is in bit 1 (won't work on some ThinkPads),
> +		 * battery ID is in bits 8-9, 2 bits.
> +		 */
> +		if (ACPI_FAILURE(tpacpi_battery_acpi_eval(SET_DISCHARGE, &ret, param))) {
> +			pr_err("failed to set force dischrage on %d", battery);
> +			return -ENODEV;
> +		}
> +		return 0;
>  	default:
>  		pr_crit("wrong parameter: %d", what);
>  		return -EINVAL;
> @@ -9445,6 +9465,8 @@ static int tpacpi_battery_probe(int battery)
>  	 * 2) Check for support
>  	 * 3) Get the current stop threshold
>  	 * 4) Check for support
> +	 * 5) Get the current force discharge status
> +	 * 6) Check for support
>  	 */
>  	if (acpi_has_method(hkey_handle, GET_START)) {
>  		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_START, &ret, battery)) {
> @@ -9481,10 +9503,25 @@ static int tpacpi_battery_probe(int battery)
>  			return -ENODEV;
>  		}
>  	}
> -	pr_info("battery %d registered (start %d, stop %d)",
> -			battery,
> -			battery_info.batteries[battery].charge_start,
> -			battery_info.batteries[battery].charge_stop);
> +	if (acpi_has_method(hkey_handle, GET_DISCHARGE)) {
> +		if (ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_DISCHARGE, &ret, battery))) {
> +			pr_err("Error probing battery discharge; %d\n", battery);
> +			return -ENODEV;
> +		}
> +		/* Support is marked in bit 8 */
> +		if (ret & BIT(8))
> +			battery_info.batteries[battery].charge_behaviours |=
> +				BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE);
> +	}
> +
> +	battery_info.batteries[battery].charge_behaviours |=
> +		BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO);
> +
> +	pr_info("battery %d registered (start %d, stop %d, behaviours: 0x%x)\n",
> +		battery,
> +		battery_info.batteries[battery].charge_start,
> +		battery_info.batteries[battery].charge_stop,
> +		battery_info.batteries[battery].charge_behaviours);
>  
>  	return 0;
>  }
> @@ -9619,6 +9656,28 @@ static ssize_t charge_control_end_threshold_show(struct device *device,
>  	return tpacpi_battery_show(THRESHOLD_STOP, device, buf);
>  }
>  
> +static ssize_t charge_behaviour_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	enum power_supply_charge_behaviour active = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +	struct power_supply *supply = to_power_supply(dev);
> +	unsigned int available;
> +	int ret, battery;
> +
> +	battery = tpacpi_battery_get_id(supply->desc->name);
> +	available = battery_info.batteries[battery].charge_behaviours;
> +
> +	if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE)) {
> +		if (tpacpi_battery_get(FORCE_DISCHARGE, battery, &ret))
> +			return -ENODEV;
> +		if (ret)
> +			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
> +	}
> +
> +	return power_supply_charge_behaviour_show(dev, available, active, buf);
> +}
> +
>  static ssize_t charge_control_start_threshold_store(struct device *dev,
>  				struct device_attribute *attr,
>  				const char *buf, size_t count)
> @@ -9633,8 +9692,43 @@ static ssize_t charge_control_end_threshold_store(struct device *dev,
>  	return tpacpi_battery_store(THRESHOLD_STOP, dev, buf, count);
>  }
>  
> +static ssize_t charge_behaviour_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct power_supply *supply = to_power_supply(dev);
> +	int selected, battery, ret;
> +	unsigned int available;
> +
> +	battery = tpacpi_battery_get_id(supply->desc->name);
> +	available = battery_info.batteries[battery].charge_behaviours;
> +	selected = power_supply_charge_behaviour_parse(available, buf);
> +
> +	if (selected < 0)
> +		return selected;
> +
> +	switch (selected) {
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> +		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 0);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
> +		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 1);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	default:
> +		dev_err(dev, "Unexpected charge behaviour: %d\n", selected);
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +
>  static DEVICE_ATTR_RW(charge_control_start_threshold);
>  static DEVICE_ATTR_RW(charge_control_end_threshold);
> +static DEVICE_ATTR_RW(charge_behaviour);
>  static struct device_attribute dev_attr_charge_start_threshold = __ATTR(
>  	charge_start_threshold,
>  	0644,
> @@ -9653,6 +9747,7 @@ static struct attribute *tpacpi_battery_attrs[] = {
>  	&dev_attr_charge_control_end_threshold.attr,
>  	&dev_attr_charge_start_threshold.attr,
>  	&dev_attr_charge_stop_threshold.attr,
> +	&dev_attr_charge_behaviour.attr,
>  	NULL,
>  };
>  
> 
Sorry for the slow review - been busy this week. Thank you for
implementing this - it's great to be getting this into the kernel and
it's something we have had on our todo list for a little while now.

I can confirm the BDSG and BDSS APIs are correct along with the bit
field defines you have used. Not sure if that's helpful but as I have
access to some internal documents I figured I'd check :)

I'll note that bit 10 in BDSG should flag if the 'enable breaking by AC
detaching' feature is supported. You're not using it so I don't think
that's important - but figured I'd mention it because of the comment
that not all thinkpads support it.

Mark

