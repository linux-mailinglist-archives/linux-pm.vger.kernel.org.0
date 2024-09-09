Return-Path: <linux-pm+bounces-13898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357C5971DFA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 17:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CB928446D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B7025624;
	Mon,  9 Sep 2024 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qLRK9MW3"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EAE19BB7;
	Mon,  9 Sep 2024 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895446; cv=fail; b=dKw8Z6asqizP9jdxFPHp31PdlLG5mI6H5fBYQr6RzHqJUBSb6KoBjVXkwO84WCUnQXpaCyUyopHaZMOxDF2sGuTeqaFucV6ZYnYeco9zICrgd9MCFwG/SMsxtzMf8eNEJbhOri2VfEU77CnR18vwNPKYWNGOLlksaiXJoHEqeWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895446; c=relaxed/simple;
	bh=8WXWU1ilk4rfOX9LzVIJGlSAAN2fVxLMqkUMnrb+XKc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WQZ5f2PA9pfM3OH8Vq+48WwbXm+uFAuUUd/X1oUNEIzdxMiJJWbBRmQWrEBhZuXKqmsOuPVlWTZJtC0VImCW0xddMzOv3nhY3fXFtXAQBnMsVylC339q+5wmbSg/kMSLIs6S3kzk50ZYZoMEmWCz6jjcooh2TVylc6qgI82g9jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qLRK9MW3; arc=fail smtp.client-ip=40.107.96.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbHDqwR6d9Yf3FRY+1mBbaL23hrZt+6sCwITFjynKjwqXJbkQ2YsA9GxfJb++AWdMWWmZCyf2YT7DCCCKNFnzeXd+1krmLOEGlME3/6MiT1UrtYUabFFKvAYOq7niXyUlgNMjDhnkcFf7GE7EkuH4/CY9U4dea9Y/UwsqyRyokTlpXx/FswUp4JIGHeYh3s7Y1mydWbc/gEBPRQBbp7+jpoCqB+zII4J5lNZN5KnUW9IyR2fPQMuEG83OIYnh2Fea5lZbopPDYgrBWqEHY7x3RdT5AF+X7/nScXx6BUTHdh3xofFzol7xF9knDuOYFLrl+VwfpLEwufAjmVzfBpFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTqBDhD5Wvzd4YKPa8mro5Et5XV4rXInECgGcEOiK5w=;
 b=ALx+vdAYJB0T7jnnizmZymsviBLvv+2oElN57ucFOpec04UbAhPRjPwBnrKCVNKzO/Fu+z7otNwehmThojwKk2LlOWCE9qwEoNQ0yMVtWNH2W9l6MgbzeSJNgBm5jCahZrtO1/Z8UuPnqehLJJyYdWP8WtaaMnyrBV+Ypld8H01hQr19PGLnzgDbZhoUHDo17hTOYSFwgd70a5Yfw/tMz7RUOvwxcYL/rSJqvO+cJDyO5r8umvAQi0GBUXGYCcZt/ynAruV6sInv2uu6F7GXvrreSF0NHjnsRUgUXsfZb37cisP5IaIkAxE5UjLMLGvZZwuIXesl/8JF0Jdmek1hHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTqBDhD5Wvzd4YKPa8mro5Et5XV4rXInECgGcEOiK5w=;
 b=qLRK9MW3WaBrGziyfeP0U6QBFB8qenzPgxnL45IsIdGQK+7vwVgSZ8UE3f3TZ0QaGmLU+lp8FOQkDOMgcdktRgOPWVIK5ZYRjt2no6rS4m+lhlk3cmbahlENTLskzRNN5Ao0Hb7ceBGmcWGhHoLOMV3yxD9ixgMGFmP7uPsEq1w=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 15:24:02 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%7]) with mapi id 15.20.7918.020; Mon, 9 Sep 2024
 15:24:02 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Mario Limonciello <superm1@kernel.org>, "Meng, Li (Jassmine)"
	<Li.Meng@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
CC: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
	<linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING FRAMEWORK"
	<linux-pm@vger.kernel.org>, "ptr1337@cachyos.org" <ptr1337@cachyos.org>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 2/2] cpufreq/amd-pstate-ut: Add test case for mode
 switches
Thread-Topic: [PATCH 2/2] cpufreq/amd-pstate-ut: Add test case for mode
 switches
Thread-Index: AQHa/BmYJTUPXbdfGk+34UnO+t5XsLJPnsAg
Date: Mon, 9 Sep 2024 15:24:01 +0000
Message-ID:
 <CYYPR12MB86552794829E16A9F8CDDDFE9C992@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240901024912.1217014-1-superm1@kernel.org>
 <20240901024912.1217014-3-superm1@kernel.org>
In-Reply-To: <20240901024912.1217014-3-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=85b347c2-ad5d-40d5-9969-2229f0b76527;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-09T15:18:08Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|MW4PR12MB8610:EE_
x-ms-office365-filtering-correlation-id: 46749da4-633a-4cd5-af59-08dcd0e36f1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Aa+LdaaYyHbcVu1vHsNGU2LrbUq898u0C6Qgg8uQrBHR9ZvC8HcZ2WtfsSNy?=
 =?us-ascii?Q?M75AHfYACGXdAgBT75Z4sCx0fmejMjrn2uFX3R0nzW53EUVS2WPDfdQHxL4p?=
 =?us-ascii?Q?BXqeVbVsc6zecFF2Kqz99ih5/J3h5FtPcJchVSTx4I7qxN/34JRnLPSS6VC0?=
 =?us-ascii?Q?FO7mi4MQTatTz51FLg/nWFZTfHk0u6UC+lSx1xS+1NwvWVCl2zMwb9PNz9fp?=
 =?us-ascii?Q?bT265dn+O5PwksdjgToAJvbz8slYr3ZJ009pnfSbOZVwXNSFyutBkNzYmA9Q?=
 =?us-ascii?Q?92ldbwmZQ7WqVKM9akoqw4gVPaMDe6sGLRCALm+asZqwugnVjb9ofG+k9F5e?=
 =?us-ascii?Q?S442RXamnOZbrf8q0mH/xcbUwEX7xl+AdLQuAqHRK+eujfWaGvyh8pyurFMQ?=
 =?us-ascii?Q?cScSPLAeukA1IjmW7p4/128v555JsUJkL+WdcAVUTqbYOYW1lbi1NE5S0/jW?=
 =?us-ascii?Q?E2mKSp66KsjagSGwxZ22bi1V/9249yBVlttdrUos8uSHbkpDYfVovOm5Bp55?=
 =?us-ascii?Q?5D44AqoSqSySvUsQjGV0CZLFnkgdFamYphHoZpGV0V/LL8icxEAsDOxEyzRY?=
 =?us-ascii?Q?wJ7BX5L5jjAnxGIDomt18s9ubY+ARIAUi/kHM8+aQP280YZDYqYt8wbY9PWb?=
 =?us-ascii?Q?S4Kf6F7u4pdfe2j595O5C6DKQVLRJ0RYrucPyCSEELp6XTOWnfmLXJLdtk8q?=
 =?us-ascii?Q?Z5Bz9iDdGE51WNtUsiIZaAO02zBadH0kR6ko2JItBWaV8ncxsw/RujzO52Q3?=
 =?us-ascii?Q?HgInwHfV4sT7UJ2zy7d6r0cZfG82lLXc73i4tqOTurTUuC0iJE1pB3i9QqYM?=
 =?us-ascii?Q?pq0MwU9DOsQ2yYyVmJ0ijzAIpDErqr1MUSwyrjmBdMDlQkd/XyJFnDiJqIRn?=
 =?us-ascii?Q?FjEYDtcgvCZBzsqPpmoTwb1Kcib2ymMTBRAq0Phj90N5qlY2NTfoBmEh2BDZ?=
 =?us-ascii?Q?JLF2d6Vdku4FjCsVOhtDJKllbWNvpjUGRDHcWhCoMTLUtb4bzK23CvGmzMcR?=
 =?us-ascii?Q?pBA8m7xenfW3XF9wmXpGIrxo6oVHzX1pcPpRCGwMeJkaV/LHP+Uk44X5Y/o2?=
 =?us-ascii?Q?U1dfT0M0s6nO3nLlFufWMccmEc3oUNKgIuzu3VcvWq+xVFxhGnlbCqDfL3xf?=
 =?us-ascii?Q?VzxHLvZZg/THDIzLNGwO0mGMLYYlnRUlj2fIs2al1NlNzVE5rFIiLyR6GU3O?=
 =?us-ascii?Q?FXorZvevE+EzwMK2EJjMaOkX2l1h/VJsfI2MfF9sDJsPiBERBvvT5alTEzPF?=
 =?us-ascii?Q?UmGwvQRZA3aNIFiGt+Pu1OZmZXH2rgHzu43lHzejivtgmWuLzOusUfkWk5Yb?=
 =?us-ascii?Q?wc4bfILrjN0YxxPQtC7Kp3xyY/gB0zm0ewY6B45uNg5Q+ggxPxsLfYOX0Xg4?=
 =?us-ascii?Q?y6BNWkG75xOoJI/hevSLOurLWLBfAZ0Mud3j2JOO49loG+AOJQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iXGU6K+ujZm/rWUtXoePHxLw9zxSIrcpBTFq4sufDEYpQSb9jOSbz/yLgjC4?=
 =?us-ascii?Q?FpPz4afAFXANd3J5X39UKnSaQLV//7C+ddQulbJr7CHJ3R4NR/wqTzgNZ1r1?=
 =?us-ascii?Q?0vKHfmsVPKA5h+aA9QyjLAdvrw/QRNCA5nXAKpYStEeu70TqnMbKIbYW18lE?=
 =?us-ascii?Q?KlAcK7hfP9QD0TjJU9gfQxAltx2Arv2IOmdxt67m/IhiUw7SDEg30rRNrWOP?=
 =?us-ascii?Q?ilOVAH8uNVxA4JHWbL3opYeAFnnQeoFY2C8zKLFiwwhAEdubw/yH5tNnumTG?=
 =?us-ascii?Q?WO+9F63yJGjyoOwf3x80XuSphIf1nHk+91JIHkOvfS3sw7srXH6mctnSZoqF?=
 =?us-ascii?Q?CXoofoN86n/HyLA8x6oElCePouLQdPtA3JynpnPAm2jXDKCObMo1076RKKdr?=
 =?us-ascii?Q?vVxce0agJCdoTHnMQFc/SkzDlMx+UoaWNcDcp9LqNFTjVG9R0yrZlfyy5sGn?=
 =?us-ascii?Q?kDJkv1wq0AEXxM1Si30fD07J8e9cak3JFnh7zAFGw610EgeK0/cLWo/Z2LOG?=
 =?us-ascii?Q?GKA9m4Ib+PIVsQ2ivqNoxWR7w9IMqwa5kcxYphKo2fAYvuc705SqgZd7XRl2?=
 =?us-ascii?Q?bc96t9tSVdzTMiy/MTxnm8JB+HZpWGiva5KrnIhh8SfWUMedBEzSW77rVl8W?=
 =?us-ascii?Q?Ut2RGEa86OV4WFHJPk0GuHy3bePOJAgCcCmbRH7le3dbND4wC3juawBVVG+G?=
 =?us-ascii?Q?KUa8AbAtN205LQmnT4xaWq4yMmJ3q2GH7RfQeVPy95NtKvNOLAyZtn7lGTkp?=
 =?us-ascii?Q?Sg6ovGtj1jn9QAubnRnnAXM1bhHbCjgFhx4YjIHhXP9WB+0p9eK+IotFcZD6?=
 =?us-ascii?Q?BkTJQxylJWKl4fYwD4strVk/GzlZBBH4JaJYJULsMld/tn6w5gXyyiH6aRr8?=
 =?us-ascii?Q?1eV1u7DOzaBvuKQwiuZHuBhiCpfSe5OoxeaV8ifAsd4YnzAnKjucxYQ6XxjG?=
 =?us-ascii?Q?SQUneAJehu50Y8V+e6p7alzSmUnUkBjOkQs47YjlWKG7Uc+KFTZ6j9VsMM3X?=
 =?us-ascii?Q?th/KxI2TdiEOiEp/99S+P5iXuHwF5uHN2uABtP5l8K/8ftpSRvwCeyCovI1G?=
 =?us-ascii?Q?YqNLCe7wm/W2SCKbxKy2Yi5zqlOHs8oc1c1LraA6ifEtYMEb+8D9kB4Kmk4m?=
 =?us-ascii?Q?IyM0X7OGDnmumMJwQUwYj4DKqouRUFIEmLEkEQFmqZbrP8vgp7llgPj7QrQp?=
 =?us-ascii?Q?uORPMikUCPKK3AbdWiD97DEenaC6mvsS2a/yuyeWWkCRzfLu9GcrZ/qnX6ej?=
 =?us-ascii?Q?inhbJBf1M9cni5q4UEG02vFwHaF8DMm/iropo4S9jR6D0J/M2Ch28USy1UBz?=
 =?us-ascii?Q?xYBoMrgv0X9DT6MY5V+H4bggCc4w4eMb1ApDKt3nZ5hA2Aex+Tsn85F2IMcj?=
 =?us-ascii?Q?xdirZSGjvTAcz5HyVDw9loYtGv7PUTTsPmYaHjsvXbEQ7Trdcp68Cb9uDY/2?=
 =?us-ascii?Q?7oDBDiigAoQbSMq8OZdGWo/at5GmdHlMFORg+G//QrgNj8Ccj+f1S6j0pEUc?=
 =?us-ascii?Q?VuLYHNTcxLQ/3ppqDhP3GXP78kxG8Vy6WN8I5nNBGWHkzI56c9kxeZJkujBk?=
 =?us-ascii?Q?CEYnvCEXhcDNLIuuQig=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46749da4-633a-4cd5-af59-08dcd0e36f1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 15:24:01.9651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zgst4gDYumJmPeXMMMg5E3FJfaLbpB1SoqGKx8japTvPJ1w7oSODURxoLk7QHTO5YNG6rjqiDCegkpt157kf6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Mario Limonciello <superm1@kernel.org>
> Sent: Sunday, September 1, 2024 10:49 AM
> To: Meng, Li (Jassmine) <Li.Meng@amd.com>; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
> Cc: open list:X86 ARCHITECTURE (32-BIT AND 64-BIT) <linux-
> kernel@vger.kernel.org>; open list:CPU FREQUENCY SCALING FRAMEWORK
> <linux-pm@vger.kernel.org>; ptr1337@cachyos.org; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH 2/2] cpufreq/amd-pstate-ut: Add test case for mode
> switches
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> There is a state machine in the amd-pstate driver utilized for switches f=
or all
> modes. To make sure that cleanup and setup works properly for each mode
> add a unit test case that tries all combinations.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 41
> ++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate=
-
> ut.c index b7318669485e4..c291b3dbec381 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -54,12 +54,14 @@ static void amd_pstate_ut_acpi_cpc_valid(u32 index);
> static void amd_pstate_ut_check_enabled(u32 index);  static void
> amd_pstate_ut_check_perf(u32 index);  static void
> amd_pstate_ut_check_freq(u32 index);
> +static void amd_pstate_ut_check_driver(u32 index);
>
>  static struct amd_pstate_ut_struct amd_pstate_ut_cases[] =3D {
>       {"amd_pstate_ut_acpi_cpc_valid",   amd_pstate_ut_acpi_cpc_valid   }=
,
>       {"amd_pstate_ut_check_enabled",
> amd_pstate_ut_check_enabled    },
>       {"amd_pstate_ut_check_perf",       amd_pstate_ut_check_perf       }=
,
> -     {"amd_pstate_ut_check_freq",       amd_pstate_ut_check_freq       }
> +     {"amd_pstate_ut_check_freq",       amd_pstate_ut_check_freq       }=
,
> +     {"amd_pstate_ut_check_driver",
> amd_pstate_ut_check_driver     }
>  };
>
>  static bool get_shared_mem(void)
> @@ -257,6 +259,43 @@ static void amd_pstate_ut_check_freq(u32 index)
>       cpufreq_cpu_put(policy);
>  }
>
> +static int amd_pstate_set_mode(enum amd_pstate_mode mode) {
> +     const char *mode_str =3D amd_pstate_get_mode_string(mode);
> +
> +     pr_debug("->setting mode to %s\n", mode_str);
> +
> +     return amd_pstate_update_status(mode_str, strlen(mode_str)); }
> +
> +static void amd_pstate_ut_check_driver(u32 index) {
> +     enum amd_pstate_mode mode1, mode2;
> +     int ret;
> +
> +     for (mode1 =3D AMD_PSTATE_DISABLE; mode1 < AMD_PSTATE_MAX;
> mode1++) {
> +             ret =3D amd_pstate_set_mode(mode1);
> +             if (ret)
> +                     goto out;
> +             for (mode2 =3D AMD_PSTATE_DISABLE; mode2 <
> AMD_PSTATE_MAX; mode2++) {
> +                     if (mode1 =3D=3D mode2)
> +                             continue;
> +                     ret =3D amd_pstate_set_mode(mode2);
> +                     if (ret)
> +                             goto out;
> +             }
> +     }

Dose the mode switching test need to add some delay between the previous an=
d new mode ?
If lowlevel power firmware failed to handle the modes frequently,  you can =
consider adding delay in future.
Besides that, the patch looks good to me.

Reviewed-by: Perry Yuan <perry.yuan@amd.com>

> +out:
> +     if (ret)
> +             pr_warn("%s: failed to update status for %s->%s: %d\n",
> __func__,
> +                     amd_pstate_get_mode_string(mode1),
> +                     amd_pstate_get_mode_string(mode2), ret);
> +
> +     amd_pstate_ut_cases[index].result =3D ret ?
> +                                         AMD_PSTATE_UT_RESULT_FAIL :
> +                                         AMD_PSTATE_UT_RESULT_PASS;
> +}
> +
>  static int __init amd_pstate_ut_init(void)  {
>       u32 i =3D 0, arr_size =3D ARRAY_SIZE(amd_pstate_ut_cases);
> --
> 2.43.0




