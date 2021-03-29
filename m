Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB934CE58
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 12:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhC2K6m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 06:58:42 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:23118 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232589AbhC2K6j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 06:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1617015518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2azz0nfyNlieJRiSKglfO1fVmN0IQYIRcBf4xgEtFKM=;
        b=axtt7bGXpKNfFXm97SdZgWWbsm9nWX2hYRFsR25XSWvdFHN3eusuuEHsDu3k56Ei0OvDln
        y2FPliVno3WZ8xrw1+NW7JX38wlFn0bslgq8gN5i30dmx+eWV4QeDkWh0qWa7KX790ZECi
        mdykbopNwG/nqam9DXwqSzk5vXmP7Ms=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-13-HgtS0-cWNiKPV_1W37aepg-1; Mon, 29 Mar 2021 12:58:36 +0200
X-MC-Unique: HgtS0-cWNiKPV_1W37aepg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6CfLy6mSHghUGayKYr5YFvhyesMp0i1eX4V3d92CQgD21S0BWspQySZIpSgZjZlJQIexxTEJACfJ7GKcKU6Hg/04ZmsAd3qOFUcclBUvsRSy2Bb7GUksueBw/WLxdd/O8zrEkQYFjd2HuWhAgKs1qOTC1O9U8XoMSEmMsHnw8bfYyuyNrHfMnB9FXcPdQYRRjm2wL7WHSpELpsGf1yle4I+enXW9bXHELcHf4Wyqz/JQS75RU3eJo6q4ClaQhes/Xh5/uHrYqOTKFejS0arTGlPEd300/ulcCz6HvLbfAhXryQes9DJnt+yz3aqc9I29+0ZQ4l12F+UQactbVWv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2azz0nfyNlieJRiSKglfO1fVmN0IQYIRcBf4xgEtFKM=;
 b=Ne+KmQ1Dk0KMcNebL7g5WBh9NPebwj8Snot0k2G6hXSpv7DMV+6/sjtOW//tMTqKcWlVjP7cIc7bnF7aVezKZ5YbTtwJ5ykDjjPiH9Jzl3kH5VeBkb2mTDmZIGDhtEDkTnNBpOuivMRautMnzi8KJ16NGsG9+GBbZUPrL5B+1Hg/YMgigDQR/jdRTayz3fD60O5hjYJ8KlF62zTuV1Aqqi96L96NU0m3Fgl0AvNSXq0zW9nml81/6/5Z7K5eCyFSyG/HUxZ4QBq0Np/y15por2P/f+5p5k9lLH++1l0QcsDv8b3NWQrwanYA/1RGsgZQOZ4eBCHQGfXSxCIwqiAhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dominikbrodowski.net; dkim=none (message not signed)
 header.d=none;dominikbrodowski.net; dmarc=none action=none
 header.from=suse.com;
Received: from AM0PR04MB6995.eurprd04.prod.outlook.com (2603:10a6:208:18e::15)
 by AM0PR04MB4900.eurprd04.prod.outlook.com (2603:10a6:208:c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 10:58:35 +0000
Received: from AM0PR04MB6995.eurprd04.prod.outlook.com
 ([fe80::8030:7de6:dcf1:f65b]) by AM0PR04MB6995.eurprd04.prod.outlook.com
 ([fe80::8030:7de6:dcf1:f65b%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 10:58:35 +0000
From:   Thomas Renninger <trenn@suse.com>
To:     linux@dominikbrodowski.net, sherry.hurwitz@amd.com,
        linux-pm@vger.kernel.org, xufuhai <xufuhai1992@gmail.com>,
        xufuhai <xufuhai@kuaishou.com>
Cc:     lishujin@kuaishou.com
Subject: Re: [PATCH 2/2] cpupower: fix amd cpu (family >= 0x17) active state issue
Date:   Mon, 29 Mar 2021 12:58:32 +0200
Message-ID: <1717786.6COvnHc5Zm@c100>
In-Reply-To: <20210324082838.41462-2-xufuhai1992@gmail.com>
References: <20210324082838.41462-1-xufuhai1992@gmail.com> <20210324082838.41462-2-xufuhai1992@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Originating-IP: [2001:16b8:a006:2500:f68c:50ff:fe82:1b4e]
X-ClientProxiedBy: AM0PR02CA0177.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::14) To AM0PR04MB6995.eurprd04.prod.outlook.com
 (2603:10a6:208:18e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c100.localnet (2001:16b8:a006:2500:f68c:50ff:fe82:1b4e) by AM0PR02CA0177.eurprd02.prod.outlook.com (2603:10a6:20b:28e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Mon, 29 Mar 2021 10:58:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4d0ee86-bb62-4d3a-13c6-08d8f2a19954
X-MS-TrafficTypeDiagnostic: AM0PR04MB4900:
X-Microsoft-Antispam-PRVS: <AM0PR04MB490064ADA9C8B28D89A896EDC67E9@AM0PR04MB4900.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qizcYTMoacGVMn1bthOzYVYVtbLQXtda8DiWN6PywmtUyU7CWur0t0rSkdXVtrhisbpkScXYi1SLGNdPnD9fWFY5Ah6GGY0on7LDk87pgCxtSmRgqODLTt3WpoJC5Go1a5DfR8w3xNy2bw9rYJZ78lIIFZdcO9kxKu4HRs0jJLWps33cJxMCAtOvTu+ILGVT4jwDZGrrTztNL2vCp+yeM/qCF7YJfcevolkVjbSDBiqKbhQFoqD92NiT8XTUkHfzB6f3JK1k0CsezVfHkdf8dR9hmhfaPjG2q4dfuf/pKHbaxOb678euDhi0r6/Rx6Y0jBNEhcTgVsOOGSp+EVHUz5HBFhixAk4N/x66lc1xhgAeGpwDtgGei5hLZ3rgWButpUuRqhs4NhLG7JxZmxTJ5ty1IDDm3VLlE7VAbc1ZzUR1kTFKbRGKGAaBsYg4zhOfKbspTPNYnDJeffz9XOzUJDIQsAFLBPn3XvlZpNWUnveIKVQcwpF9/tWxD4ICQ30mvyskmM6cEr5oa4cbdrbZHeNkkG2CaKOh7UVzGtOyYl0/o91uSCUO7aT7lBLsEb8TjLS8d8Fw3zJnQ59/DbXvFJoHDb+leortCcwBFF9bgfPLHP4WTqrfpkWJtwFcVY4pfcWNlbSPIn3tYvOxrxbH/zh2RDbUYa08v+5BIH8w0ZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6995.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39850400004)(136003)(396003)(5660300002)(478600001)(4326008)(66574015)(9686003)(6512007)(86362001)(186003)(2906002)(52116002)(8676002)(38100700001)(83380400001)(8936002)(6506007)(66946007)(9576002)(66556008)(66476007)(16526019)(316002)(6486002)(110136005)(33716001)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?FenyQX8sIaXP3pWshW5Hb/TuiIga/ptcBuw4KduSQwY6jOHpj3YY8WENLo?=
 =?iso-8859-1?Q?fM7NTMG6Bzzp5HWNGTtGl+FmiHVWE7qdgo8bR1Uwsm1pZlFrI1xC18MDQR?=
 =?iso-8859-1?Q?AdOK7WSOeNNCgkLg2UNtFuwXdgXvdEtiIImwaTl23YUnaqSmc1qBh7mDL3?=
 =?iso-8859-1?Q?cLjU0QYIo8SYVlllH7KsYPvtLP+2j2keo05GiIUdcSG+7nfrtgMPMlG1IW?=
 =?iso-8859-1?Q?vI0ULl+1FZi6kGZ12FqF8lrJNfFpFnsGSNdaXgTZW2UXl4kThkxnig3jSC?=
 =?iso-8859-1?Q?LCmtVkGShbej7PnRcnJHLH6yaeFogUBcwKv/4aP66kmodOBPXrXPRPPpmG?=
 =?iso-8859-1?Q?rKQgNEFIibBshEok+3xn2Xj0KH5sgsQAx4rIRUN+EXhafbpj/eUO9YKpCf?=
 =?iso-8859-1?Q?qj6QowJ/h4hfkwO3i2k6PWieUsqPxmxNWpI/SlZH4WLHYQ0RmDrPmtMn21?=
 =?iso-8859-1?Q?PZArukWBeO/ikStxtyPA9eRXVNM14p8KZnpXB03yHOpcBDGr5ysKr1DvUY?=
 =?iso-8859-1?Q?TkcNU52UPq+9O7mrWYIcb8iEqqVJ4LKQedqpxqk4rsjlGBNBx813QnkCmt?=
 =?iso-8859-1?Q?07Q8a72jHZ7RCJFpyDgPBPCPng7cXhA+LWacmgL3NiBwCuMOpDC2DSki1H?=
 =?iso-8859-1?Q?995/SxK8yl9jrRtIriuAtir4IUEyWF6GNgPJEyLD71e0eJYI8f1fi1RIfu?=
 =?iso-8859-1?Q?l/UAo1Ucn17rAyXH5ITMfDcZ8nX+mAYYMzC2HNTN4SlojvaZqwGS1Rd6pP?=
 =?iso-8859-1?Q?Dn1jE5gDZBVsoc02+Eg24Asyhh5ZIy2IoTG9JxBVkHw8Z2B5dxEcppA9yv?=
 =?iso-8859-1?Q?v1AcTKwvFr3niUTvzxLJg8qGwAUOKeulIKGxKrbzzgGGmSRUv7KB/fnds6?=
 =?iso-8859-1?Q?bbNmfPtiNUxvCDf7atU1Jg0t56RKykSrt8QYgXcGQgn23r7YZZfEkKRIcO?=
 =?iso-8859-1?Q?NAMmjrJbTX2iHSLPsq4LuCoNdyWpSVfE3F1XtpSDjuZkFulvwwHBlJ78Ux?=
 =?iso-8859-1?Q?yJA+jyedgtFN0vvVdLqW1IZYnpiJtitBzbCiTMAajfGW0fgLD4/1QXoOA3?=
 =?iso-8859-1?Q?+ISwNPlCxfN8Wg7nffcP9P180L3vxSrJYUuOjQsQ+AsWB3U0C/3apFfk9C?=
 =?iso-8859-1?Q?rlXAIT+tR20ZOUt/JDa2L/YZ17klwGVJNJWVgzdJr+69rAA3hgWHAH89/4?=
 =?iso-8859-1?Q?uWe2I94/w92hI/zOSdVQw2CMWfsJzfFogb++i7f4ud2YkWB8nrDGUmtJb+?=
 =?iso-8859-1?Q?pd3/YDbOvHsFGv/1rgGA+3mKEZk8fL7L849HHHJA2Rl2j+AavfrMmCODbP?=
 =?iso-8859-1?Q?pxX6SlJLXEePNhTLkjhDr1AEhpgb46Cu+TBy0r0iUlqB4zOB8nW0A5+utt?=
 =?iso-8859-1?Q?UHoqk4jSPKR2iQmC5dZhM+12ZGChA4qxH+yCTJTaTHXHHRj9V4hqJc6/hl?=
 =?iso-8859-1?Q?n8AjKNux/yZGeSuq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d0ee86-bb62-4d3a-13c6-08d8f2a19954
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6995.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 10:58:35.2599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTGTO87nSPTNUy3BuBkz+a4rsogv+Y/J7qXKURoB43sD6aeGcf8EqR3hyPeIx4le
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4900
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Am Mittwoch, 24. M=E4rz 2021, 09:28:38 CEST schrieb xufuhai:
> From: xufuhai <xufuhai@kuaishou.com>
>=20
> If the read_msr function is executed by a non-root user, the function
> returns -1, which means that there is no permission to access
> /dev/cpu/%d/msr, but cpufreq_has_boost_support should also return -1
> immediately, and should not follow the original logic to return 0, which
> will cause amd The cpupower tool returns the turbo active status as 0.

Yes, this seem to be buggy.
Can you clean this up a bit more, please:

> Reproduce procedure:
>         cpupower frequency-info
>=20
> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
> ---
>  tools/power/cpupower/utils/helpers/misc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/power/cpupower/utils/helpers/misc.c
> b/tools/power/cpupower/utils/helpers/misc.c index
> fc6e34511721..be96f9ce18eb 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -30,10 +30,15 @@ int cpufreq_has_boost_support(unsigned int cpu, int
> *support, int *active, */
>=20
>  		if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
> -			if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
> +			ret =3D read_msr(cpu, MSR_AMD_HWCR, &val);
> +			if (!ret) {
ret should be initialized. I would initialize it with -1, but as Intel case
is always "good"/zero, it may make sense here to set:

ret =3D 0
at the beginning of the func already.
At the end of the func, unconditionally returning zero:
        return 0;
should be replace by:
        return ret;

>  				if (!(val & CPUPOWER_AMD_CPBDIS))
>  					*active =3D 1;
> -			}
> +			} else
> +				/* no permission to access /dev/cpu/%d/msr, return -1 immediately,
> +				 * and should not follow the original logic to return 0
> +				 */
> +				return ret;

Then this part is not needed anymore, right?
Still the comment would be nice to show up, maybe slightly modified
in the if condition?
Afaik 100% correct comment would be:
/* ... */
for one line comment and:
/*
* ...
* ...
*/
for multiline comment (one more line..).

>  		} else {
>  			ret =3D amd_pci_get_num_boost_states(active, states);
>  			if (ret)
and these 2 lines can vanish as well at this point:
                        if (ret)
                                return ret;

What do you think?

Thanks for spotting this,

          Thomas


