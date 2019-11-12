Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702CFF9A9C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 21:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfKLU1J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 15:27:09 -0500
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:10245
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbfKLU1J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Nov 2019 15:27:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2kb0yMxQxFQpLG1zPgw1drf/LiaRtHtlG5MoLW/+jiYXYi/xxf4MwLSSzoQoPG9XsIhQsCgP3+ieFcm6iOywxZ6awrW6e6N91WKrDD2Db36gg8/N6S4sRrALeJxbsHxH9/mURdqOulzJzRVnYyDfT69W74oKUBW1vQqKTiQ4EcKQXHCXCo38QpYIJoTZO3B/s0wkki9bTZ1K/X97LADm6km56zKgNXU2We00B05RSqYH4gfuv9T2/Mzhpn0KnW58CYsRkCowMCwyKrJi+VyReXbtpc6VjER93EVkaqRfpm/npNAs4PLodOvtEaT64s2/E8vgapfLZD7unH8+phBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXwDyMCDdTgqGm4Qnp41N4dbwBjkyzQC7VilWRpb/S8=;
 b=O3chbwZkkwH2GjJI5K+tX5hIV0NGPih/AkonhhONajBF5noANCF5NHvurvHjo0zZvsNitF3ogB0yl96GCwyQ6CWEtFJ14kpey5Y6ktSYQf+uDduQSL/QfOiN1gmsDs5xCq159VLkA+VD+0aLGmYpv/A9zdg0HwtsJGFk4Q3hhskp9G2EKLy8uHxkEH8jKfussn6t6dePiHMXvu4yGMTcHs+FpN96hWj9ykmRoLFgAJcmb1vUbuzqRvRBzsRZQXU7gB6XvF0nl2MbmcJEQDkkuA6/Eh4NfoAQguJ6jhl5rvXaW0BSUdWrPGZ/yeyLiRGqdXEQs24J84cMns6QeteL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXwDyMCDdTgqGm4Qnp41N4dbwBjkyzQC7VilWRpb/S8=;
 b=ACkjPitvo0AT5u35qbdeZjqatzj/EzdNUibDMr7ZqnMzVCShxrk9O3k2EQqGm1JICYHohJE51K4zum6+dfRvKCgYtDusdMNNSIFNKhpPy+CYOkBd2bS+5W4uAtxviCLAXHkk7pUl/IqMii5qkKagbQjHpCbKf+969a4RFGv4Y6o=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5662.eurprd04.prod.outlook.com (20.178.204.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 20:27:06 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 20:27:06 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/4] irq_work: Slightly simplify IRQ_WORK_PENDING clearing
Thread-Topic: [PATCH 3/4] irq_work: Slightly simplify IRQ_WORK_PENDING
 clearing
Thread-Index: AQHVlk7q8ewqzqG/7U6Uj+DHGZkRhA==
Date:   Tue, 12 Nov 2019 20:27:05 +0000
Message-ID: <VI1PR04MB70239C2E838B72C171CC62C7EE770@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20191108160858.31665-1-frederic@kernel.org>
 <20191108160858.31665-4-frederic@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81ddda22-03e4-4b85-b07a-08d767aeaf71
x-ms-traffictypediagnostic: VI1PR04MB5662:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB566297EA0E8BF6390C959199EE770@VI1PR04MB5662.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(189003)(199004)(446003)(6506007)(44832011)(102836004)(25786009)(7696005)(478600001)(8676002)(66066001)(99286004)(33656002)(53546011)(6116002)(3846002)(5660300002)(486006)(476003)(6916009)(52536014)(74316002)(2906002)(186003)(8936002)(229853002)(26005)(76176011)(6436002)(66946007)(71190400001)(81156014)(54906003)(4326008)(66476007)(66446008)(81166006)(91956017)(76116006)(64756008)(316002)(66556008)(86362001)(71200400001)(305945005)(6306002)(14444005)(256004)(7736002)(6246003)(55016002)(14454004)(966005)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5662;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /elBc2Tt/leJ0IFkcE4JE/9hM63yej9xotDGZ+K/1K9PZpa1Wbsvdo44BRbM6doE4s7JkwzByjSxDMetJ5R85Qh3IrWMSUBGHsu+UECLtmegFPaIlqIYTI7gwLOShdFHT6Kzg/DugVX2XID4iDxYhPx1v5uf5Lg+9yjKVoBcAtGYyETfD89k3Lzb/eXvZkIAE6Y9vDaVZAZZX5iQKmcukq3jXzYunnsoNTIJqUylU4xSnxfUREHWYrvcBe+40XEzVnUhIb6MwrIkNYszc3YLDe6vCehmQsHwYggiFZdRSIivBofJN8Nm7upUktt7HR9ZthAk4w9SPMzBWR8vThqb9LaZYzawyzxWi96ChwvVbZQ0sLHpjiDqajuIgEurIcICFkXEKmu7QC8OTxQoZMgi932OYbgFflNfLijt3GxEzM866wXhJBq2r2DWD9H2hCcaMDJFWva/qXPUrBUhZqa1Yyc580blqmr2qHGB5QQSEF4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ddda22-03e4-4b85-b07a-08d767aeaf71
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 20:27:05.9846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6L7tT7gwxWFeLmj2M6EJx5/VLYdSs9YnN3hAVOazLW6WM6FaxeDF0VAWUS9C1IVx3Hs5au7x4Dm7N/kd/eDsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5662
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08.11.2019 18:09, Frederic Weisbecker wrote:=0A=
> Instead of fetching the value of flags and perform an xchg() to clear=0A=
> a bit, just use atomic_fetch_andnot() that is more suitable to do that=0A=
> job in one operation while keeping the full ordering.=0A=
> =0A=
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>=0A=
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>=0A=
> Cc: Thomas Gleixner <tglx@linutronix.de>=0A=
> Cc: Peter Zijlstra <peterz@infradead.org>=0A=
> Cc: Ingo Molnar <mingo@kernel.org>=0A=
> ---=0A=
>   kernel/irq_work.c | 7 +++----=0A=
>   1 file changed, 3 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c=0A=
> index 255454a48346..49c53f80a13a 100644=0A=
> --- a/kernel/irq_work.c=0A=
> +++ b/kernel/irq_work.c=0A=
> @@ -34,7 +34,7 @@ static bool irq_work_claim(struct irq_work *work)=0A=
>   	oflags =3D atomic_fetch_or(IRQ_WORK_CLAIMED, &work->flags);=0A=
>   	/*=0A=
>   	 * If the work is already pending, no need to raise the IPI.=0A=
> -	 * The pairing atomic_xchg() in irq_work_run() makes sure=0A=
> +	 * The pairing atomic_fetch_andnot() in irq_work_run() makes sure=0A=
>   	 * everything we did before is visible.=0A=
>   	 */=0A=
>   	if (oflags & IRQ_WORK_PENDING)=0A=
> @@ -135,7 +135,6 @@ static void irq_work_run_list(struct llist_head *list=
)=0A=
>   {=0A=
>   	struct irq_work *work, *tmp;=0A=
>   	struct llist_node *llnode;=0A=
> -	int flags;=0A=
>   =0A=
>   	BUG_ON(!irqs_disabled());=0A=
>   =0A=
> @@ -144,6 +143,7 @@ static void irq_work_run_list(struct llist_head *list=
)=0A=
>   =0A=
>   	llnode =3D llist_del_all(list);=0A=
>   	llist_for_each_entry_safe(work, tmp, llnode, llnode) {=0A=
> +		int flags;=0A=
>   		/*=0A=
>   		 * Clear the PENDING bit, after this point the @work=0A=
>   		 * can be re-used.=0A=
> @@ -151,8 +151,7 @@ static void irq_work_run_list(struct llist_head *list=
)=0A=
>   		 * to claim that work don't rely on us to handle their data=0A=
>   		 * while we are in the middle of the func.=0A=
>   		 */=0A=
> -		flags =3D atomic_read(&work->flags) & ~IRQ_WORK_PENDING;=0A=
> -		atomic_xchg(&work->flags, flags);=0A=
> +		flags =3D atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);=0A=
>   =0A=
>   		work->func(work);=0A=
>   		/*=0A=
=0A=
This breaks switching between cpufreq governors in linux-next on arm64 =0A=
and various other stuff. The fix in this email doesn't compile:=0A=
=0A=
     https://lkml.org/lkml/2019/11/12/622=0A=
=0A=
I assume you meant "&=3D ~" instead of "~=3D", this seems to work:=0A=
=0A=
diff --git a/kernel/irq_work.c b/kernel/irq_work.c=0A=
index 49c53f80a13a..828cc30774bc 100644=0A=
--- a/kernel/irq_work.c=0A=
+++ b/kernel/irq_work.c=0A=
@@ -156,10 +156,11 @@ static void irq_work_run_list(struct llist_head *list=
)=0A=
                 work->func(work);=0A=
                 /*=0A=
                  * Clear the BUSY bit and return to the free state if=0A=
                  * no-one else claimed it meanwhile.=0A=
                  */=0A=
+               flags &=3D ~IRQ_WORK_PENDING;=0A=
                 (void)atomic_cmpxchg(&work->flags, flags, flags & =0A=
~IRQ_WORK_BUSY);=0A=
         }=0A=
  }=0A=
