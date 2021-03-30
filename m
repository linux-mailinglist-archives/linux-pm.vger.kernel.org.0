Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF4F34DDE4
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 04:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhC3CAJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 22:00:09 -0400
Received: from mail-eopbgr660078.outbound.protection.outlook.com ([40.107.66.78]:18392
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229483AbhC3B7n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Mar 2021 21:59:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezJ6tO8yTZqFbZzCj/pxsCd5rc3kvZDiR7/uBttYwEtV2yMfhkZh6IO3i+k5Q/wXleGAPZHsGy/5mXbUbFr9KzZI3BjGc9CWSOn9MbDw3SpPWEDK7ZcbmuuNwPXJMsSMAIpR9E464WbEB9b6Rb0hDPwq7NnollVAJYqrDynKpdDJG0/crkyktVlLPfMFCVta/aMToK4jREc1aeo+rMot01MgI+thZzhyV+w0veiYZf2HdVcvoTUVSVhcUphiTQA+uWFVAyKimYXuYckCjbKvgBWRyUsgwTwxMvhk4MaYVTNzFbTRodN/bH4PFXPcrcAwcijtFKnl0207Dw2et3mRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PluljONvciY1yxGEG0IAKjCe9RVEsZ5+Lqgxtj7e+pM=;
 b=dU8T/mM8srB3lRrL0l5Ti0eCraX7J3uzftHf/9c2w0kPsvAnNbUXnbwmNkgj2kC2DbDBBRaBsiIMqE1f0K+viqlWyEZwKhp7SCh3mHKV7kDoVkbbFoLMH4Ea5vb1YvP9YfIRN0XGbykEhE03ku1XOq3pac7OWRvVekVQsJOT113QdgtXvQ2v1MKCRLoSUSElgo4LeIBtwVtpCZss4oic203wq9IZrSlScKwNP67a7IRucglCsYjP7gRZw3avIIptg6AHAgQrNv9voWP41ailqI3bzObz6oKw+ZBcA8aHpGZVReFGkjDyVUkjQj4zRVziG0G+J+KLSRwCiz4g+pI0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stfx.ca; dmarc=pass action=none header.from=stfx.ca; dkim=pass
 header.d=stfx.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stfxca.onmicrosoft.com; s=selector2-stfxca-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PluljONvciY1yxGEG0IAKjCe9RVEsZ5+Lqgxtj7e+pM=;
 b=XbbtG+5PHdeBIe2F7aO62TATyhI4/5kMIo7WHu9sD1Bjh0u0GktPk1erFyjY3YHmrTvGzsNRj22TWMPpn7qkQNey4uRrhxbeUvaOQmupdsPJUtXearYhYVz/wv6/q0wg4vVZEN0wEktSrFLQYAafRtYmHDvH9X3qVpfa3p8eGCU=
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:17::19)
 by YT1PR01MB2412.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Tue, 30 Mar
 2021 01:59:41 +0000
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c087:282b:4ebb:81b3]) by YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c087:282b:4ebb:81b3%7]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 01:59:41 +0000
From:   "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 5/5] cpuidle: menu: Take negative "sleep length" values
 into account
Thread-Topic: [PATCH v1 5/5] cpuidle: menu: Take negative "sleep length"
 values into account
Thread-Index: AQHXJMqW2cL1o6UBuEaCN31sThmNSKqbxtcz
Date:   Tue, 30 Mar 2021 01:59:40 +0000
Message-ID: <YTBPR01MB3262DB49961DBCCE96C51AB8C47D9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
References: <2764850.e9J7NaK4W3@kreacher>,<7927358.NyiUUSuA9g@kreacher>
In-Reply-To: <7927358.NyiUUSuA9g@kreacher>
Accept-Language: en-CA, zh-CN, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=stfx.ca;
x-originating-ip: [141.109.104.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0302d3a-5216-464d-dc71-08d8f31f7b40
x-ms-traffictypediagnostic: YT1PR01MB2412:
x-microsoft-antispam-prvs: <YT1PR01MB24120376ED6600B54C954FACC47D9@YT1PR01MB2412.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g7ks6G3YNoph07mytqkia/kyMRm0thwW0nW2EY85naeJ3F4NvCFQyL6+rKsAVN39rIHLXe79yX0VTKusj/eMFSZZbIVwzeyWSV6GWWNU4c8518k0DS1z7STj6ybcghSfA8QthiIjWVxLPHte3yKCN/7za+38+I9m8LLES6m+sc36awpvxZ4PxgIhUmoTnq0iNlAdXd1snKV9QrmjUEkPcrlKyKfFANVEni+9mvhx6xzvjsoYdxqHA4CyhyTx+4GAUlLc3ct2sQla+DzdxL61rI8zHXWBGFWgpeyi26y1u7a3gOdU4a9OHgSZrLhBNXqkqMWEIK8fCzaOBABWzpAJaf43cljIUWhP8tQxzXnivTITlClXIDSoDP5zjWgVQSHRz3/PQSSBVER9Cg448HBpZlJba7slEb4mx201kbWmmeUgMn5hPFvSn+l0/oRXxiYxAO/DExK475tB33MtiE40g3t8sAE6XtQ02XKKh41Abv2Rvtg1kn1uhFM5Stfnh2uvCGMIypZBS3rIKQFl+RzuQedOXMbjhKi5cQrF+CA4nHGTTbnc6nhD2HAe64TsO060zWYvoEvgfHrpHDIRk8lIp4FT1Oboe0FN/0lkaJs3WKUxJ9FskGW868a1Gnnng1Ax74nlOdRSmV4FWGBo7IiNgO99yECQaifW4ZM32bl3c9Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39840400004)(366004)(8936002)(38100700001)(478600001)(316002)(54906003)(55016002)(9686003)(786003)(26005)(186003)(110136005)(7696005)(2906002)(71200400001)(8676002)(6506007)(86362001)(5660300002)(52536014)(66946007)(66446008)(76116006)(64756008)(66476007)(66556008)(33656002)(4326008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?FtcgJMv8UJSXtEi9YWcQHZuleuAhFo72iWAGVBnouL9Ryy79vqHhSlDTrr?=
 =?iso-8859-1?Q?4twC01cKdrpbxKnjFRoDxzOJi6TCsUNklF4GEDwz55bZQMzyz3Tyy5pfVH?=
 =?iso-8859-1?Q?BYX4dfsu5AwG/RX5eeiO4zphmIvQ8Re9OyxILa4/dCIsDUekhIF5ZYwxnY?=
 =?iso-8859-1?Q?iLXQpWUQb6mnOZ7Ne8efGQxXgbQ6lSL8Z00eEkF6dfgsNxTCF7wVteXIMq?=
 =?iso-8859-1?Q?N+4wPUmjibgF60rlgjGYIlJE9WdbGSxFxC7hcjuVtseu67fG8svcrqeiMp?=
 =?iso-8859-1?Q?nw3WdSsUYRg2xqEJ4A4FCzRu/J6IYqw65/HwmYnDtQ1EYjRX8QQcviZfJ6?=
 =?iso-8859-1?Q?EXAqZaFSJm8btRoHQiBlhD3j80nKgQHavvma4iPDHUHGx9srvOIR9EZI2w?=
 =?iso-8859-1?Q?jeUju4Bf1JYCMRc6/5TKAr52G5AWRnf1xxX4y3A8Yo9o1HqA8RH6UJb+E/?=
 =?iso-8859-1?Q?ZBNdj6rbMPKxB0kVyGlBdG3i5CJMnXAmm9X6FaSDM23LCNq0ZaX8cfVF9p?=
 =?iso-8859-1?Q?YW8tfWpsuKvnKCTBf+nM2n6iVICm8N2qlCdu5hPWxXNvFDFhyfYu86K5iT?=
 =?iso-8859-1?Q?m1mzy2pRddGEDV0e+oWU2Y4v2q7AT107xmz61rlxKzPaeLb4Hq8nXgRToF?=
 =?iso-8859-1?Q?usaK/VXGLOKpM/RRoa5qrMbG+2+Z/ZHIuzqh7vcHnprAylOuEmrRdB1K3w?=
 =?iso-8859-1?Q?3FbDM/2WRSImQshcTULKBQGmYRp/inNZd7DUIRdeDigo1cqmAE8Tymm0Jz?=
 =?iso-8859-1?Q?KXZpxEc82Pm5Z5Qy6dkuonz9/9XMwDAwSuZCbFN01zFCYaNm8QlAUJaBWh?=
 =?iso-8859-1?Q?uB+5453/9d4IY0fR1loPln6V+1GNrdY0+pYwfq3IsrfGmR6C6ABrm01CJk?=
 =?iso-8859-1?Q?PvNBXZQ348RakaDVtPTF3cErLpXU2lEeUhP4uY5ASS4u/yw94PcaJNyMXq?=
 =?iso-8859-1?Q?VzWf0+/AEkDZqTNfqTwA/Tu4g07PxbIDFnWEQcy7OxCv6w1Uz96xxOFZ5C?=
 =?iso-8859-1?Q?L8t9mubEM62hzpmGBTJFSMQvSGP3fct9w67F+FW4CIIOC0xW5DpZtnD09Y?=
 =?iso-8859-1?Q?8QGGW9qmMCdIZ/rQknwp+ZyEIdLSOd2zJOrZe0LJECx4Hi9lB/lBY6DeTZ?=
 =?iso-8859-1?Q?M456TQdbbYP7pfVytg9BCUC4wAqplkhSeoO0T7K4H4SdgZFNXz6N+bsOjV?=
 =?iso-8859-1?Q?wHEdYgSFABqFTTg0CkI/ASk07L0NMnU4Erm+g9Uu/Rw2ONz8oLjgWxT9bq?=
 =?iso-8859-1?Q?4KvwuLUHr8cTIkMXSN7lERSlPH6uQeTTy26S3CEkOGALqu63qmrrM07nh4?=
 =?iso-8859-1?Q?8Cfxc4LpU+dTHqXWnWZONLI875p/tFaPC6Kf1usT7iF97fTnrxZBahezYI?=
 =?iso-8859-1?Q?8v2fyy1M0r?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: stfx.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e0302d3a-5216-464d-dc71-08d8f31f7b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 01:59:40.8510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c46abc7-960b-4124-8950-1628b2b192f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /obn9Fg2RdzBuYYRSsjNtXmjGgLwpFMM4umR6sK5mlybw4FL2VtSadTyQS6vel9FenPjdhWsNUsSUDqwELb/TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB2412
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 2021-03-29 14:37 Rafael J. Wysocki wrote:=0A=
> Make the menu governor check the tick_nohz_get_next_hrtimer()=0A=
> return value so as to avoid dealing with negative "sleep length"=0A=
> values and make it use that value directly when the tick is stopped.=0A=
> =0A=
> While at it, rename local variable delta_next in menu_select() to=0A=
> delta_tick which better reflects its purpose.=0A=
> =0A=
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>=0A=
> ---=0A=
>  drivers/cpuidle/governors/menu.c |   17 +++++++++++------=0A=
>  1 file changed, 11 insertions(+), 6 deletions(-)=0A=
> =0A=
> Index: linux-pm/drivers/cpuidle/governors/menu.c=0A=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c=0A=
> +++ linux-pm/drivers/cpuidle/governors/menu.c=0A=
> @@ -271,7 +271,7 @@ static int menu_select(struct cpuidle_dr=0A=
>          u64 predicted_ns;=0A=
>          u64 interactivity_req;=0A=
>          unsigned long nr_iowaiters;=0A=
> -       ktime_t delta_next;=0A=
> +       ktime_t delta, delta_tick;=0A=
>          int i, idx;=0A=
>  =0A=
>          if (data->needs_update) {=0A=
> @@ -280,7 +280,12 @@ static int menu_select(struct cpuidle_dr=0A=
>          }=0A=
>  =0A=
>          /* determine the expected residency time, round up */=0A=
> -       data->next_timer_ns =3D tick_nohz_get_sleep_length(&delta_next);=
=0A=
> +       delta =3D tick_nohz_get_sleep_length(&delta_tick);=0A=
> +       if (unlikely(delta < 0)) {=0A=
> +               delta =3D 0;=0A=
> +               delta_tick =3D 0;=0A=
> +       }=0A=
> +       data->next_timer_ns =3D delta;=0A=
>  =0A=
>          nr_iowaiters =3D nr_iowait_cpu(dev->cpu);=0A=
>          data->bucket =3D which_bucket(data->next_timer_ns, nr_iowaiters)=
;=0A=
> @@ -318,7 +323,7 @@ static int menu_select(struct cpuidle_dr=0A=
>                   * state selection.=0A=
>                   */=0A=
>                  if (predicted_ns < TICK_NSEC)=0A=
> -                       predicted_ns =3D delta_next;=0A=
> +                       predicted_ns =3D data->next_timer_ns;=0A=
>          } else {=0A=
>                  /*=0A=
>                   * Use the performance multiplier and the user-configura=
ble=0A=
> @@ -377,7 +382,7 @@ static int menu_select(struct cpuidle_dr=0A=
>                           * stuck in the shallow one for too long.=0A=
>                           */=0A=
>                          if (drv->states[idx].target_residency_ns < TICK_=
NSEC &&=0A=
> -                           s->target_residency_ns <=3D delta_next)=0A=
> +                           s->target_residency_ns <=3D delta_tick)=0A=
>                                  idx =3D i;=0A=
>  =0A=
>                          return idx;=0A=
> @@ -399,7 +404,7 @@ static int menu_select(struct cpuidle_dr=0A=
>               predicted_ns < TICK_NSEC) && !tick_nohz_tick_stopped()) {=
=0A=
>                  *stop_tick =3D false;=0A=
>  =0A=
> -               if (idx > 0 && drv->states[idx].target_residency_ns > del=
ta_next) {=0A=
> +               if (idx > 0 && drv->states[idx].target_residency_ns > del=
ta_tick) {=0A=
>                          /*=0A=
>                           * The tick is not going to be stopped and the t=
arget=0A=
>                           * residency of the state to be returned is not =
within=0A=
> @@ -411,7 +416,7 @@ static int menu_select(struct cpuidle_dr=0A=
>                                          continue;=0A=
>  =0A=
>                                  idx =3D i;=0A=
> -                               if (drv->states[i].target_residency_ns <=
=3D delta_next)=0A=
> +                               if (drv->states[i].target_residency_ns <=
=3D delta_tick)=0A=
>                                          break;=0A=
>                          }=0A=
>                  }=0A=
=0A=
How about this.=0A=
I think it's possible to avoid the new variable delta.=0A=
=0A=
---=0A=
=0A=
--- linux-pm/drivers/cpuidle/governors/menu.c.orig	2021-03-29 22:44:02.3169=
71970 -0300=0A=
+++ linux-pm/drivers/cpuidle/governors/menu.c	2021-03-29 22:51:15.804377168=
 -0300=0A=
@@ -271,7 +271,7 @@ static int menu_select(struct cpuidle_dr=0A=
 	u64 predicted_ns;=0A=
 	u64 interactivity_req;=0A=
 	unsigned long nr_iowaiters;=0A=
-	ktime_t delta_next;=0A=
+	ktime_t delta_tick;=0A=
 	int i, idx;=0A=
 =0A=
 	if (data->needs_update) {=0A=
@@ -280,7 +280,12 @@ static int menu_select(struct cpuidle_dr=0A=
 	}=0A=
 =0A=
 	/* determine the expected residency time, round up */=0A=
-	data->next_timer_ns =3D tick_nohz_get_sleep_length(&delta_next);=0A=
+	data->next_timer_ns =3D tick_nohz_get_sleep_length(&delta_tick);=0A=
+=0A=
+	if (unlikely(data->next_timer_ns >> 63)) {=0A=
+		data->next_timer_ns =3D 0;=0A=
+		delta_tick =3D 0;=0A=
+	}=0A=
 =0A=
 	nr_iowaiters =3D nr_iowait_cpu(dev->cpu);=0A=
 	data->bucket =3D which_bucket(data->next_timer_ns, nr_iowaiters);=0A=
@@ -318,7 +323,7 @@ static int menu_select(struct cpuidle_dr=0A=
 		 * state selection.=0A=
 		 */=0A=
 		if (predicted_ns < TICK_NSEC)=0A=
-			predicted_ns =3D delta_next;=0A=
+			predicted_ns =3D data->next_timer_ns;=0A=
 	} else {=0A=
 		/*=0A=
 		 * Use the performance multiplier and the user-configurable=0A=
@@ -377,7 +382,7 @@ static int menu_select(struct cpuidle_dr=0A=
 			 * stuck in the shallow one for too long.=0A=
 			 */=0A=
 			if (drv->states[idx].target_residency_ns < TICK_NSEC &&=0A=
-			    s->target_residency_ns <=3D delta_next)=0A=
+			    s->target_residency_ns <=3D delta_tick)=0A=
 				idx =3D i;=0A=
 =0A=
 			return idx;=0A=
@@ -399,7 +404,7 @@ static int menu_select(struct cpuidle_dr=0A=
 	     predicted_ns < TICK_NSEC) && !tick_nohz_tick_stopped()) {=0A=
 		*stop_tick =3D false;=0A=
 =0A=
-		if (idx > 0 && drv->states[idx].target_residency_ns > delta_next) {=0A=
+		if (idx > 0 && drv->states[idx].target_residency_ns > delta_tick) {=0A=
 			/*=0A=
 			 * The tick is not going to be stopped and the target=0A=
 			 * residency of the state to be returned is not within=0A=
@@ -411,7 +416,7 @@ static int menu_select(struct cpuidle_dr=0A=
 					continue;=0A=
 =0A=
 				idx =3D i;=0A=
-				if (drv->states[i].target_residency_ns <=3D delta_next)=0A=
+				if (drv->states[i].target_residency_ns <=3D delta_tick)=0A=
 					break;=0A=
 			}=0A=
 		}=0A=
