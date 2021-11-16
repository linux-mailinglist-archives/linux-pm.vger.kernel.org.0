Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DBC453B40
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 21:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhKPU4E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 15:56:04 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.114]:19940 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231510AbhKPU4B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 15:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1637095983; i=@lenovo.com;
        bh=tPA0v+1rxlNKGftCn8CJPkZNF6Rrq/mSTCsdgUDOjjs=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=12MwLMvl8QqgXySG426D+8rzLG4pxWx9tfIPVMY4qwQCN5zF5oBIqv8J+KJwLcp0K
         D7BeyqGigLtxHihBbxUqFtmJQQrU56VQNhWXhcKAEhH3psdSt6x6uRYY2azKdeRPy+
         dz9FnCNWibuPRtmCG3kNyCk/k6Eq4c9e+pD+Vf88aiOShjlEUD7h7Sa0g3cVcxcdhj
         wB1+PBZJ/SwinyiL7eSeHGE3a9QUBkcmar2Ak/rkJa+YOdE9TIrnKUnk2Lgnq5cHy+
         M3y+IdeWENXgDME7Qjr6u0fOGlABp8hvIF19kldsBc9J/uJdMkFqi7rd6WxQy2Bgya
         ReiNwzHhEuY/g==
Received: from [100.112.4.164] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-c.us-east-1.aws.symcld.net id 25/D0-32713-E2A14916; Tue, 16 Nov 2021 20:53:02 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTfUwTZxzmvbter4Syo8B46URNHSwWrlBGlmO
  4zf2h6WaGi8zMmH14QKWdpZBeibhk0gGSKAzkQxkVFbUMBhqBQrutQBHwC0bcBGZFRhQR+fCL
  Mc2kju0uh4798+Z5fs/ved7fL3lfApWViOWENtusNRkZgwL3xXTRciWlklcwMZ5+knZfg/TjJ
  zfE9L2LlQh91vs9Rh/pWUfvG1vA6cGfqnF6/pteQHv/mkTorkOHUdqR1wPoxvYplB4q9wC632
  Ve76/50fq7WHOqxY1rFhynMY23C2haGvbjGlfNPKJ52DmMa+ZbVmpKCi+IP5RsF+mNyRnZO0Q
  6ywMPkmmjsv/pnhZbQG74AeBLALIWhc/63IhAToqge9iBCWQBwL8vW1CeyEgrAkfzK3GBuBF4
  byxXzBNIDgDYWmXn2iSckgHPOdqWLGUI/NntWbJMADjydfuSchPAuZuLOG+Rkm/B07+OYzzGy
  HDY0DyDCfUAeLlqgsMEEUx+DC2jLA8DyW3Qfm4r34GSIXBk4jjC4yDyAgLbRt/h41HyDIAnZu
  YA3y8jv4B/no3ge3AyEra2LuB8WUImwJ7p14SYtXCf0ysW8CqY13ZkaZc1cKHkCsq3Q65uqZL
  wZUjugEWL47iAQ+Fv138RCzgMnh+oxgT8ATwzPyYWrEpujyihbIAPGzqXEiPg6P1NB4HKumxZ
  67K1rMtmsy6brQZgDeCNZJM+TWdOZ/QGSh0TQ6nVsVQcpY5Xq5gvqRRVFktpGdZMcXQ3q2L3p
  KcYUlVGrbkFcO8xNRNz/wCGZh+pukEogSiCpS/fKmdk/skZqXt0DKv73JRl0LLdYAVBKKC0xr
  eCkQWYtGna7J16A/eqn8uQ8FMESSshJ0vZTCad1acJUh+IJw5OHz2JEgeKTnBnWa/LicowY4Z
  RKw+RPuYNJG/QZRlfxD3/J1dBmDxQCnx8fGR+mVpTut78f30GhBBAESh9FMKl+OmN5he3znAD
  IdxAYYPl/EBm5j9JbkE2BqhevVSZfzdxTZzpOt6+ZfeAhOjd9nTO9sraqUlXX85HK7aGvqlo7
  6peN55ZP11ZWk/g+wv2Xtnl05RaN2xUIqL37IO392KqnA1lnk6n6HhJ8Ez+XKG3NDwyr7ZjNO
  fd8SKR/+vOyA5quqt+tslU2JwSW089vTT0R1Z1se7Oyif13ynTDuObSh7Uxta9Xxrdn7H5k5o
  kWxPmuBF1t7j2WddniUlJEZ6E1bmhpauic8YmgkpXI1dHnJNmqW3xzk6F3d5jnepwHPXkht2+
  lXAt0SZ/adf2gmrpt42zzRu3rD/vrd3Q+FU+MEUqovKK3u6enXVcrKgr9jEXfHr/lCsuO/6YA
  mN1jFqJmljmX4cgBNqiBAAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-9.tower-406.messagelabs.com!1637095980!50706!1
X-Originating-IP: [104.47.26.42]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27284 invoked from network); 16 Nov 2021 20:53:01 -0000
Received: from mail-psaapc01lp2042.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) (104.47.26.42)
  by server-9.tower-406.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Nov 2021 20:53:01 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncX/PGmNfi3GAL9YOsuOZCiz6GvkpO0YtdK45UyGsp7VtXxzYOUrZaLH3quef+MncZJhUhs0TEl8719KY3pIIltd9Y5Bk4pkgyVySm6AaSxTLpz+IfBeS1dkW2cx0ECI+2moPbrXftkbduFe/KFoNHu64Hd2L+VCgXBPU8ZMc5f1PK4AIdi0LQmPTfMmijYud1Ws+h1wgv3L1a/cWiPJw02pLCgYbC2Wlu2QuzQyy0mFUhmLGXoYtTs2tuoXDEyMdPXnXHaqZW1iwuGel8DAseZ20oKQycQtvAzcqcLKVpWlMX+DBxxwP2xd0ShC3ybj/6bbANUXpa8ZZq8pahvTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPA0v+1rxlNKGftCn8CJPkZNF6Rrq/mSTCsdgUDOjjs=;
 b=B4lrsWwDhZR4RYvBljWBhhD9tXu9uoJxt35Sr/bg5TBm5KuoiQi947ERgcB36O+RxRlhr6bEb3P0FvvHAXCatuuIu46n/qD1tLu/FciQzoTuXMwd5s39/r9n3lB+xNx0b0JsD9RDhJ22uWPnJMLzPYB7i/sRAfz2mp6SB7JXK3PJhwX4SnDwPgZ7Hvl1G3VTzsAKmzdX2N6CgjcOQImFRi2ALv5bwAS+32Pq+jTRn3rF6A585DNX/52eRmt7GSSghB8W/mhM48/24HJ+2GwVpr17IMFcdjRKB3VtYWoeuQ8PwzuraV8TuClQSGpeXv7nFTKjIYzhTZG++6k3/zPGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 104.232.225.6) smtp.rcpttodomain=weissschuh.net smtp.mailfrom=lenovo.com;
 dmarc=temperror action=none header.from=lenovo.com; dkim=none (message not
 signed); arc=none
Received: from SG2PR0302CA0015.apcprd03.prod.outlook.com (2603:1096:3:2::25)
 by SG2PR03MB3959.apcprd03.prod.outlook.com (2603:1096:4:33::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.18; Tue, 16 Nov 2021 20:52:58 +0000
Received: from SG2APC01FT015.eop-APC01.prod.protection.outlook.com
 (2603:1096:3:2:cafe::6f) by SG2PR0302CA0015.outlook.office365.com
 (2603:1096:3:2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15 via Frontend
 Transport; Tue, 16 Nov 2021 20:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 104.232.225.6) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=lenovo.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of lenovo.com: DNS Timeout)
Received: from mail.lenovo.com (104.232.225.6) by
 SG2APC01FT015.mail.protection.outlook.com (10.152.250.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 20:52:56 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.20; Tue, 16 Nov
 2021 15:52:54 -0500
Received: from [10.38.49.20] (10.38.49.20) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.20; Tue, 16 Nov
 2021 15:52:53 -0500
Message-ID: <82ec6164-223b-940a-6992-48ccbe47a615@lenovo.com>
Date:   Tue, 16 Nov 2021 15:52:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [External] [PATCH 4/4] platform/x86: thinkpad_acpi: support
 inhibit-charge
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
 <20211113104225.141333-5-linux@weissschuh.net>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <20211113104225.141333-5-linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.38.49.20]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0814060b-177a-42bc-d170-08d9a94311ab
X-MS-TrafficTypeDiagnostic: SG2PR03MB3959:
X-Microsoft-Antispam-PRVS: <SG2PR03MB3959B03F564CB51C3B384A50C5999@SG2PR03MB3959.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfoApSh0HKoNK3PLaXIHfYgY+vPBT42rj8r/shEyrRp6M+ymsPI5TMr2403pZqlg58lYENhwMTZkWnZ9fIvbwevdqncMkJETHfTFMLQWpQVW+G04Ml/YIs0Ri9IDJhfIH9JGGDmfVzfX3ccfCRCrDTE9LmeJhhrraUYp39cCmgtzQSbwwHIi7HTgbBXNKk48jdv1uHb/Ptym+/kdFtmANLev08w/VIEAzJaE/kmydEW4bEuEqOZ70jJMKQoVLVNYBKKJv3/xNalKk5WhfF6UVc0cCM3tN9tZ9wv3Dw1LAZ7UMUD1RjtEW6KMf9i54A99ztxKA3RZNn4LeVTgFOAE7GZ4e7jbXKkd92QBrUajJeGV0A7gGMHJe2bThE2CMsH3q8NtuyhMCJtTMNPLxqFIBzT78ZNNrByoaa8ZSc3BxhmvK6jplLm364sk0A5z+x8EBxOsy47jmv3TEA90nPdnzj0dxVtosetJeM2ovTCE8D277xKvx0OvJ5l21d7cqueDM1cQeCZ1yM9A3ZnMKIZtkG/bGIGBHHhoik4bhTJn2A1RyWM8g+0krMxVpVXGg/eeFEmUyP8771+TMGrOhb0yS+XeVkjc0buYz09rmFvtQn7vDzU9PlgbQ9K+o6DXh8xl3nGdrWUwI8d5GKY+TTKh3SBH1Xx1fkLxmpu53ughObSaizOMXFBBkOEVwqMZH+ll80Ryhrc+pTlIOkaeEQHWbfbAXvdXIA0gHupSSyJb1LQGozFQNsi9vgiEGwG04UYnutjSenmHIjz2MRzVwPjD+zq63chqlvwWKv0KbQ4qtHycMtrzc+OwGFfOQHGBi5VKq5T+9C10YSpy718qaR4kf5dEA6p8WXDpbSVreMA1LfS9ghNQqooyY/B/zl/LXKshUOIuilWLFg09ggTpXachLg==
X-Forefront-Antispam-Report: CIP:104.232.225.6;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(63370400001)(16526019)(186003)(53546011)(966005)(70206006)(83380400001)(426003)(336012)(2616005)(31696002)(356005)(82960400001)(47076005)(7416002)(81166007)(86362001)(66574015)(26005)(70586007)(36860700001)(82310400003)(54906003)(110136005)(36756003)(16576012)(5660300002)(8676002)(36906005)(2906002)(508600001)(316002)(31686004)(8936002)(4001150100001)(63350400001)(3940600001)(43740500002)(2101003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 20:52:56.8735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0814060b-177a-42bc-d170-08d9a94311ab
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.6];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT015.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB3959
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thomas,

On 2021-11-13 05:42, Thomas Weißschuh wrote:
> This adds support for the inhibit-charge charge_behaviour through the
> embedded controller of ThinkPads.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> ---
> 
> This patch is based on https://lore.kernel.org/platform-driver-x86/d2808930-5840-6ffb-3a59-d235cdb1fe16@gmail.com/>> ---
>  drivers/platform/x86/thinkpad_acpi.c | 55 +++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index e8c98e9aff71..7cd6475240b2 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -9321,6 +9321,8 @@ static struct ibm_struct mute_led_driver_data = {
>  #define SET_STOP	"BCSS"
>  #define GET_DISCHARGE	"BDSG"
>  #define SET_DISCHARGE	"BDSS"
> +#define GET_INHIBIT	"PSSG"
> +#define SET_INHIBIT	"BICS"
>  
>  enum {
>  	BAT_ANY = 0,
> @@ -9338,6 +9340,7 @@ enum {
>  	THRESHOLD_START,
>  	THRESHOLD_STOP,
>  	FORCE_DISCHARGE,
> +	INHIBIT_CHARGE,
>  };
>  
>  struct tpacpi_battery_data {
> @@ -9409,6 +9412,13 @@ static int tpacpi_battery_get(int what, int battery, int *ret)
>  		/* The force discharge status is in bit 0 */
>  		*ret = *ret & 0x01;
>  		return 0;
> +	case INHIBIT_CHARGE:
> +		/* This is actually reading peak shift state, like tpacpi-bat does */
> +		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_INHIBIT, ret, battery))
> +			return -ENODEV;
> +		/* The inhibit charge status is in bit 0 */
> +		*ret = *ret & 0x01;
> +		return 0;
>  	default:
>  		pr_crit("wrong parameter: %d", what);
>  		return -EINVAL;
> @@ -9447,6 +9457,22 @@ static int tpacpi_battery_set(int what, int battery, int value)
>  			return -ENODEV;
>  		}
>  		return 0;
> +	case INHIBIT_CHARGE:
> +		/* When setting inhibit charge, we set a default value of
> +		 * always breaking on AC detach and the effective time is set to
> +		 * be permanent.
> +		 * The battery ID is in bits 4-5, 2 bits,
> +		 * the effective time is in bits 8-23, 2 bytes.
> +		 * A time of FFFF indicates forever.
> +		 */
> +		param = value;
> +		param |= battery << 4;
> +		param |= 0xFFFF << 8;
> +		if (ACPI_FAILURE(tpacpi_battery_acpi_eval(SET_INHIBIT, &ret, param))) {
> +			pr_err("failed to set inhibit charge on %d", battery);
> +			return -ENODEV;
> +		}
> +		return 0;
>  	default:
>  		pr_crit("wrong parameter: %d", what);
>  		return -EINVAL;
> @@ -9467,6 +9493,8 @@ static int tpacpi_battery_probe(int battery)
>  	 * 4) Check for support
>  	 * 5) Get the current force discharge status
>  	 * 6) Check for support
> +	 * 7) Get the current inhibit charge status
> +	 * 8) Check for support
>  	 */
>  	if (acpi_has_method(hkey_handle, GET_START)) {
>  		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_START, &ret, battery)) {
> @@ -9513,6 +9541,16 @@ static int tpacpi_battery_probe(int battery)
>  			battery_info.batteries[battery].charge_behaviours |=
>  				BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE);
>  	}
> +	if (acpi_has_method(hkey_handle, GET_INHIBIT)) {
> +		if (ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_INHIBIT, &ret, battery))) {
> +			pr_err("Error probing battery inhibit charge; %d\n", battery);
> +			return -ENODEV;
> +		}
> +		/* Support is marked in bit 5 */
> +		if (ret & BIT(5))
> +			battery_info.batteries[battery].charge_behaviours |=
> +				BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE);
> +	}
>  
>  	battery_info.batteries[battery].charge_behaviours |=
>  		BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO);
> @@ -9673,6 +9711,11 @@ static ssize_t charge_behaviour_show(struct device *dev,
>  			return -ENODEV;
>  		if (ret)
>  			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
> +	} else if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)) {
> +		if (tpacpi_battery_get(INHIBIT_CHARGE, battery, &ret))
> +			return -ENODEV;
> +		if (ret)
> +			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
>  	}
>  
>  	return power_supply_charge_behaviour_show(dev, available, active, buf);
> @@ -9710,12 +9753,20 @@ static ssize_t charge_behaviour_store(struct device *dev,
>  	switch (selected) {
>  	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
>  		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 0);
> -		if (ret < 0)
> +		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 0) || ret;
> +		if (ret)
>  			return ret;
>  		break;
>  	case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
>  		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 1);
> -		if (ret < 0)
> +		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 0) || ret;
> +		if (ret)
> +			return ret;
> +		break;
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> +		ret = tpacpi_battery_set(FORCE_DISCHARGE, battery, 0);
> +		ret = tpacpi_battery_set(INHIBIT_CHARGE, battery, 1) || ret;
> +		if (ret)
>  			return ret;
>  		break;
>  	default:
> 

I can confirm the bit fields are correct for these calls (as for the
previous patch)

Couple of things to note, based on feedback previously from the FW team
that I found when digging thru my battery related emails.

"Lenovo doesn't officially support the use of these calls - they're
intended for internal use" (at this point in time - there is some
discussion about battery recalibration support but I don't have details
I can share there yet).

The FW team also noted that:

"Actual battery charging/discharging behaviors are managed by ECFW. So
the request of BDSS/BICS method may be rejected by ECFW for the current
battery mode/status. You have to check if the request of the method is
actually applied or not"

So for the calls above (and for the BDSS calls in the previous patch) it
would be good to do a read back of the setting to ensure it has
completed successfully.

Hope that helps
Mark



