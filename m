Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7783434CE83
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 13:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhC2LLC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 07:11:02 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:28518 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231580AbhC2LKj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 07:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1617016238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYQ8ppeU9rXUSJJN/czxNYfAJ5ehP+WqggqJGH4iwRo=;
        b=QAFMcLVDRt/RH357M8SIJ7KncwNJ+j5mQiwEY0qQHNUsPKXTNM1dUeu3dY/DLDKDOvbZ0P
        DkVBPPTGmE6Rpu9cshspKIEyLPVa/FfRz6KQ/zTU2YVnfPmTi/RT+Gi6qylex2HQ2h0kvd
        /FHqwpp4J4SCbIVr8O4BW/caH/MWRv0=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2050.outbound.protection.outlook.com [104.47.5.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-gwaLYl8aNYCqVaE-a8Vf-A-1; Mon, 29 Mar 2021 13:10:37 +0200
X-MC-Unique: gwaLYl8aNYCqVaE-a8Vf-A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikwd1tMuaN3TcJphlqvuIXxnxuyRfDxIcTTuHt7qhcBZ19S8FuwhoSdQ6RgmM8eYjDLn1GHrGhKjjdbz6AJlzBa2zO2BqSzygpv5aIdQbmVYswevYKAoJvhRem2ckx9Y3uqjIwSaVVqmH8u9Xx3AKM//csxHVUYuDeXEEnDUvEyMAz2sSo+P2g/IlIcnsgUpWSgWkgeL3ZSmnBjl75V77TrUwYC7JcvuMndpvKs/i+qHnUR7gxepJItyeXpSrEkqlvbYs70aqh12SYXAC5gCjeu+83h1mclHBq8LTFbQU4Ae6dVG5r0SyMrCvjGMulCLW4xQzXMesMMNNuoYuoxHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYQ8ppeU9rXUSJJN/czxNYfAJ5ehP+WqggqJGH4iwRo=;
 b=YgsuZVZpiLt66hOoKRWpbM9QjIlSLZEG8OLxduekaPrNHoaUpk0bsXaSQFh3320VAFd2hfXMTQ1a5qT+78zjIVfR/8Tlre07xLgY0KqE2wrjzm2QYGUXNepR9TcyNsoeEwtYUizvTYxRnjJENRkug6sWsZXMG4f/z7xAumfnYI9cU57eJQxLWPkE6m45kYDxg7BaE3JzpYEArm9hrwIH+lAqEKITUDtI/POxuBk5PJaTqLX47Hs2ykF8GWQ++vidNKJfld48rntLhK9AFtB1WSaUt4eUu+udzK20kaHFuZRSgj5qe+m/F2bB0Gs/5v3J/iOPdz06ebcZkv5EhXJZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dominikbrodowski.net; dkim=none (message not signed)
 header.d=none;dominikbrodowski.net; dmarc=none action=none
 header.from=suse.com;
Received: from AM0PR04MB6995.eurprd04.prod.outlook.com (2603:10a6:208:18e::15)
 by AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Mon, 29 Mar
 2021 11:10:36 +0000
Received: from AM0PR04MB6995.eurprd04.prod.outlook.com
 ([fe80::8030:7de6:dcf1:f65b]) by AM0PR04MB6995.eurprd04.prod.outlook.com
 ([fe80::8030:7de6:dcf1:f65b%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 11:10:36 +0000
From:   Thomas Renninger <trenn@suse.com>
To:     linux@dominikbrodowski.net, sherry.hurwitz@amd.com,
        linux-pm@vger.kernel.org, xufuhai <xufuhai1992@gmail.com>
Cc:     lishujin@kuaishou.com, xufuhai <xufuhai@kuaishou.com>
Subject: Re: [PATCH 1/2] cpupower: fix amd cpu (family < 0x17) active state issue
Date:   Mon, 29 Mar 2021 13:10:33 +0200
Message-ID: <5120169.VkIDyNCUOm@c100>
In-Reply-To: <20210324082838.41462-1-xufuhai1992@gmail.com>
References: <20210324082838.41462-1-xufuhai1992@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Originating-IP: [2001:16b8:a006:2500:f68c:50ff:fe82:1b4e]
X-ClientProxiedBy: AM9P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::7) To AM0PR04MB6995.eurprd04.prod.outlook.com
 (2603:10a6:208:18e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c100.localnet (2001:16b8:a006:2500:f68c:50ff:fe82:1b4e) by AM9P195CA0002.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Mon, 29 Mar 2021 11:10:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0bfa1d1-950a-4e1f-c3e5-08d8f2a34706
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:
X-Microsoft-Antispam-PRVS: <AM0PR04MB68022A719EE6FF5C10E087D5C67E9@AM0PR04MB6802.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pp4OC39LG7qA7eb9H1TauqGLlMmM5BYGOkbeaapZUgwNYEkbrZEQPh/HPL6s59Ot1SnLLjNDmc7wcRWFdB9+it7JfWCXJNyqB2Q8a8/JHKRBtR7RmuF+UqIX3CcpS5ZgdEQly+arc82tMPrZ4rg5lmvJS/t0h3Ey1S3Zy0cCuWOSQy7YK/YnHr8SRFvYpgsz//qLTp+kW8Ifd/a9RVJmwr698T7X6V07Mk0VxfJWhd173wDvJVVVusXXiLk0Wf93Fs4jjlIlZp/uDWXcBkp16V+cCGB8tpMJ5yOG8xVKjO3l1PjiouaHg1GrHQ5KjqRX27QpmsLScqHst52q3TeC8e6ZEDftHysHm6pIwkC+3vBzP1n14jVYl2VLQOOonL2m9WRhuLnMYpzC3CM4PVtjnm3fCBYLQXA/Pq0iwpKpNjPxnQwGociHl+EUapnpbF4Zzst6eD/BtS+fRAHFkugL514DV6H7gGyS3kqMS+VZ1PUelRwJUNV9ks+diI5NFp7xvz7uBAVsjZ4hfDaWZRWCp9a8ksUgcCCOk69UN7v1NGpIEb4oQNvmrSbNiiOom2e1RDiQ89vIrV4+U8O72jlGdi9sY547oo6WEm/HAO7zRqsRSPznVuYXO75XajCqMXxjLinFD6RV+zo1BqvQAp9tVw1DxXVjA1fa+GwltTJICRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6995.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(346002)(136003)(376002)(396003)(33716001)(9576002)(6506007)(66574015)(186003)(16526019)(6916009)(66946007)(5660300002)(8676002)(316002)(38100700001)(66556008)(66476007)(2906002)(6486002)(478600001)(8936002)(9686003)(86362001)(4326008)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?AJV3YeunFNhaHYJ5qHf8H6zfWSe4s6vl7JJlPxmIivgeFSUyxOFotj/uap?=
 =?iso-8859-1?Q?OFhGrxYx7yl0FJs6L6DX7kaJWBq5tZgn7AFxNjgXRDzmvYw0VzLvVJ4/cU?=
 =?iso-8859-1?Q?LL/ZdH9w/0EYOXhkdsI8var100zBQihznibcxeXBvCBFHNuo8Q/cvB9YQZ?=
 =?iso-8859-1?Q?K0VoJ8Kf7SikhEUDx0C+5Ea1qwF69V/ib5bA4bTigpBhy70VlNUlNgcsf8?=
 =?iso-8859-1?Q?4hH0J+bwFD2JRs352PMMHFdWs1RRKgeQ6eXlnPF7OPNRLwK5EvCDZZyQCi?=
 =?iso-8859-1?Q?/J9DG8bigSWQjg/GByxBw/z2P8Mi/JJ1gSiU5zkowpd//sJQqS5d6Og49H?=
 =?iso-8859-1?Q?yYPJlUOcjJUCPTCPW/fmV7e3w5xdZrDBUVKnyfSNDyPiUpqvwakwQ81zTs?=
 =?iso-8859-1?Q?/HQ+EKtmO57LZsA/QAb3QIT1rdcnKpprtkF8rmTyTsgE/dOiQQazSpDyK0?=
 =?iso-8859-1?Q?nwGqbLbuUh497ThhzqtiXkTm2X5mKk8V8h4Sds9bOr0peya1CvPbyFbXoC?=
 =?iso-8859-1?Q?sAlbZUrnPlkL1Yr6IITR1r81+K+yCQ6vAgE9fQ/zFgVbPY2+qNzLMh240f?=
 =?iso-8859-1?Q?isg28qRdFsIn6IinIIO0PWA4uWc3T1rft2HHuT8z965d4m4/WFUHhdUgAW?=
 =?iso-8859-1?Q?74NlTpNEjYMgCzacxD/2KPJ9UxEjIZX/Y12QQ5oVPT65SQKLM5mSwrOkQJ?=
 =?iso-8859-1?Q?ci984pSaJzNAwv2PDNT/8kfi/Ffu7DZBovAxB+qm5SrykAkGo3H4BzLaQY?=
 =?iso-8859-1?Q?8x0ZZvDH+4lpV8X41LiuCYk3NzWrjt3MKRa8Ro/ftknS08J9lX9gFGAkrw?=
 =?iso-8859-1?Q?tlxuCJM6QKIC5VYYWmkp/xqST2579egV7GdxUQfsL8VKkiHdQE0b06fPrh?=
 =?iso-8859-1?Q?iOYcuFpdnaE7EwGLS7+TMtPkvdBULQ7qnGDH1apmfWEOTEEp4wVo2ApGuB?=
 =?iso-8859-1?Q?APNUmyfluhnf1327G9dwhnJ9L4ZfVni1CxCVMvBZ4dywZrAd/R+AMrbTda?=
 =?iso-8859-1?Q?cgR6eI0B6nfCg70PjDNAn0lJszX/kJZYKi7SqNi2537Ws7S63+J6BsltFz?=
 =?iso-8859-1?Q?Xj/jrM4enkFx0Nf3beMnQslV6v7Wlkx4DT9aBdt6n528hrTp8ZbENlKVaB?=
 =?iso-8859-1?Q?UAGFdt9H/lHyvQG9l5DV5QCYReWfxiFNz+addkcAM0Nj2ZhOCqNTmh1Ggp?=
 =?iso-8859-1?Q?grIxVYRJtgeaTAE3HAXs2fgikGBL+GRRpb7gXg/pWCu1ytSXbYG3a8bgmf?=
 =?iso-8859-1?Q?O6gtpYOt9DoXO7xjQpJ9p+w/NqZMj6tXizbl/bLVNyahWnaRSo7LEkgho4?=
 =?iso-8859-1?Q?Xk5bTTtC5CC1fZsupby9MMEWdrrGbr12mf5CCGXki5EZUSh0Yh0rq4PJVN?=
 =?iso-8859-1?Q?k1k2YIg6Pzi0dkhYYs9PUen5VMn7+3ha0tck5RyMlRlpAUbK+sKyrs4ISE?=
 =?iso-8859-1?Q?GN6Sm15RQsAUKFpW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bfa1d1-950a-4e1f-c3e5-08d8f2a34706
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6995.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 11:10:35.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiKIpa9eAi5BUW2GR1NQ74pMP4WkWmKBkWxGKYfEPomziaAQg0n+Ky93rE6PnD/Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6802
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Am Mittwoch, 24. M=E4rz 2021, 09:28:37 CEST schrieb xufuhai:
> From: xufuhai <xufuhai@kuaishou.com>
>=20
> For the old  AMD processor (family < 0x17), cpupower will call the
> amd_pci_get_num_boost_states function, but for the non-root user
> pci_read_byte function (implementation comes from the psutil library),
> val will be set to 0xff, indicating that there is no read function
> callback. At this time, the original logic will set the cpupower turbo
> active state to yes. This is an obvious issue~
>=20
> Reproduce procedure:
> 	cpupower frequency-info
>=20
> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
> ---
>  tools/power/cpupower/utils/helpers/amd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/tools/power/cpupower/utils/helpers/amd.c
> b/tools/power/cpupower/utils/helpers/amd.c index 97f2c857048e..6f9504906a=
fa
> 100644
> --- a/tools/power/cpupower/utils/helpers/amd.c
> +++ b/tools/power/cpupower/utils/helpers/amd.c
> @@ -137,6 +137,13 @@ int amd_pci_get_num_boost_states(int *active, int
> *states) return -ENODEV;
>=20
>  	val =3D pci_read_byte(device, 0x15c);
> +
> +	/* If val is 0xff, meaning has no permisson to
> +	 * get the boost states, return -1
> +	 */
> +	if (val =3D=3D 0xff)
> +		return -1;
> +
There is certainly a cleaner way to do this.., theoretically
pci_read_byte can return 0xff in other cases?

But I guess this is a sufficient way to handle this for now.

Reviewed-by: Thomas Renninger <trenn@suse.de>

Thanks,

        Thomas


