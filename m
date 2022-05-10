Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE8B52272B
	for <lists+linux-pm@lfdr.de>; Wed, 11 May 2022 00:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiEJWsG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 May 2022 18:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiEJWsE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 May 2022 18:48:04 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0836521B17C
        for <linux-pm@vger.kernel.org>; Tue, 10 May 2022 15:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLt+OUtjER5+t8dvxVEmWOXudlxh0xiGniOxI0lCo/pm0WkqmFcdH8LxEs6wpz1jQ53TM2Tjl2VUaT4qIiW7i4ftw32t5WaWqBsq6ItDXwrgyTM1j2wOilvUJhZ7YdvK0RaR3sx9SyMA76Mv3cXJJbuq0PjW2R9kQ4N1M0jvl/HJLAWUbZZqXosJySgJQD/sI1DP9QQvq7qON2KohprNP27rs+gz4fZ3ldJW/KxA6MlBnukejQ8UaLi+4qHwBV/sXjMd7hJUVIQITo4fauP9tGQkAPHjfBNdwsw+8SlaK9h2xgceD+78y9vfdu0g7wy6ZekFva6EJr6uzOTGxeTgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZKIprCp4WYtnqunuaTaWDQXR7P+wOJzfTfAsnyLkiU=;
 b=gSUP3iKz4NyM/+ufPBWJCWIJVjCU3CcGWTIIO0zNI8CoIga5MR+Mz3CDXa4Z/WWT4XuqtoeG/uBdjBBbM4aYnYlPA2LE96M/DVRkL7hBZAw8KWIyOO/7lYKPJ+0JdRQc95mD5cJMrMqclMzaJHJ8I+shHMar3gwyYYAzYpOM+oF3sQVtnYD8OoxJ3Z9l3ENs6/d9nBAbZ7P4Q2Dcrwyoy5mCTyxkXsQ2vtb1f7zsDIjdlw0rFMy+lVmbk5s2cSgh5B13D4v9yeGuCEMlMknehIkwJoMWr9A9MG+dNJhR95dG1m5uLSWe2ULSI5sFtUNeXdgAb8ye/ZCkPGSFlYvwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZKIprCp4WYtnqunuaTaWDQXR7P+wOJzfTfAsnyLkiU=;
 b=nj1Z+9HMHOcAXjCA5r1n/Es0GHxaOwhYjcoJSH/H1fjFDsOUowheUrOHuWA64RmLkv0NffXPP2J0EKiJyVnxzlj+MrmELHzLIqRbxdciTGzYiieuvdRdvAab6PKKUomUmbo+zgiKlss4eEMH+rWdQHH0L11A/cfAZDHkOKpw43Y=
Received: from AM9PR04MB8196.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::12)
 by VE1PR04MB6687.eurprd04.prod.outlook.com (2603:10a6:803:121::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 22:48:01 +0000
Received: from AM9PR04MB8196.eurprd04.prod.outlook.com
 ([fe80::b53d:b70:4349:9826]) by AM9PR04MB8196.eurprd04.prod.outlook.com
 ([fe80::b53d:b70:4349:9826%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 22:48:00 +0000
From:   Nitin Garg <nitin.garg@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/2] thermal/drivers/thermal_helpers: Adjust output format
Thread-Topic: [PATCH 2/2] thermal/drivers/thermal_helpers: Adjust output
 format
Thread-Index: AQHYSzooFv4Mx5tOt0qT2XwQfEcKQ6zvDd4AgCnWhoA=
Date:   Tue, 10 May 2022 22:48:00 +0000
Message-ID: <AM9PR04MB81964FA6990F9E19F39E2A399AC99@AM9PR04MB8196.eurprd04.prod.outlook.com>
References: <20220408110920.3809225-1-alexander.stein@ew.tq-group.com>
 <20220408110920.3809225-2-alexander.stein@ew.tq-group.com>
 <82d08ff0-41bf-d249-1216-0da3f0cdc5b9@linaro.org>
In-Reply-To: <82d08ff0-41bf-d249-1216-0da3f0cdc5b9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fef43b6-e2aa-4513-0c7f-08da32d722cd
x-ms-traffictypediagnostic: VE1PR04MB6687:EE_
x-microsoft-antispam-prvs: <VE1PR04MB6687D8A7A9DED1B1A14C21389AC99@VE1PR04MB6687.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Keo4m1eq20r4aJFGmKuEK3bCQsVN/R+afgN34qti3ubC5fOCDsqjylqDylSPEzp1jw11sNLWPxMkXmWUIyiQHOwdLbQnyIlHXlxw9TS4MH/3kf1WCay5ZDJyDv/70JbQuQ/iw7d7y+fgLOqKxyFO27Vux3fSFrZV3wU6UKFVYHQp1+fGt71msZcV+2j1JiZxG6ZVbKKKCefdlc/fde5Ueb9HrwAmM2H9YyZCoebOOMmYQc9KrWSpS2M5yCEZFRZo/9Csxy+7P10ppVX4MTmIKR63CFsXyECRuCy+AQl7L3d2lShKMFRwmnFJ1AjTjrUt4OvWSIoECHwlD7Vu1gudhBtvTUJYCpJdlMnRet0R4ibTHJjwm2pbfIEzLIZYZCObLeNpaJEDTKIG0+cWrN4j2BZf7hdm9gmnXMbHxznbFFhLEQ3/I8R8mLxQQ77Ss+n5f74NDZrv5EIdHEfAq6lurFVTW5EMfpMSnd4Qr5doWcFI6ADIOeOiVv1wBENVwaj2keegX79duXEvY/+6fMRNSg4f3naAQPHHZIcg85UR1DDxxHEgZ2xz+fWdR87h2pGQxWt+aBN1bU+Qe0QlVLkFp9q5WO0FsPzTXiTQKdQMDO+7rW1PtDeR3Ac4VrUmdc2pKIZO5Ubu6c8lBHtt2ALvTsrr3IbTRi403Muk8QtB0muXP3x8lvd93Ojwcfbdk6QE9JSM0+I/OYyQkSu2N9IF5Q9Ek82gxMipxoEuFGZ6Czw/jq/O1Lloqb6UfFMUhBTYBB8NBGUKd5iabDL2wgpJlx+g5Sg7fF4vfrcR8ww2jBo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8196.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(71200400001)(508600001)(45080400002)(9686003)(966005)(7696005)(86362001)(186003)(53546011)(83380400001)(6506007)(2906002)(5660300002)(7416002)(122000001)(55016003)(55236004)(44832011)(316002)(64756008)(4326008)(66446008)(76116006)(66476007)(54906003)(66946007)(66556008)(8676002)(38100700002)(38070700005)(8936002)(52536014)(110136005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TYsNN+OIG24hBFru8IUb6rVqmBSLIlm/VgPWu8Wk5PlLFn16D+ehLKpRMkKa?=
 =?us-ascii?Q?rnjuCLAKvGURtFYbFmqqnCEq3Zxz0PPKCgm4PdNcjXgLhj5l/rBRXO3IJpRp?=
 =?us-ascii?Q?+TWhj4UBnmhrsw2x56zNgqEZV7CdODb4P+iGyogmfzt159z64/omeAX5zSMt?=
 =?us-ascii?Q?HnElT+pV3WRkAnkaHhcP8ysOvzgjh8YtRSE7PQ094lPtB081CofYsb7t72a0?=
 =?us-ascii?Q?xUjwBI3MOK7Mq4FRd9T4uV9pEBl2MBrTNP8WslJLt5HpRVJoMTHwoM+NI2zo?=
 =?us-ascii?Q?iu1xoO6Nl0tRdKMB7uyhq04i2vFzyMizzrX4AwwnhYZg6cwsgW1s4pYPY3+Q?=
 =?us-ascii?Q?jGi/aEOpC1wkCK3IIZiAIdM3eWTZlb2H0R8anF4y9A+keg3Q/7rwCvfjE8OD?=
 =?us-ascii?Q?Xn4v8w1HGDYYVwIoSyKuYewpJuGNTrF5hs87yZOZRyQx5vb4sA+PFo8nKWBs?=
 =?us-ascii?Q?PyhBhXTmsuYVXc8C7hItc0ogkGwVrZPaHrC0byINnscVkUFjIrO8sCKO+y7X?=
 =?us-ascii?Q?kfMIhkgHspB8GjQPuMEw/ILGYpGvCsk83zU6kJcuoDIsbyLA+Qfbmwvicgr8?=
 =?us-ascii?Q?g8sC7Gpz2nwaaoziTznjVWNXnVt2A7G0cFehjYo/YjVWVXe4Mq+l05sPD5cx?=
 =?us-ascii?Q?Ft57mCmbcQiQ4cmgPcfj61GB7m/FO9J4d9vfpB66SlcFS/XLTGsyhE0cwxfs?=
 =?us-ascii?Q?vhzYV90wJ8hpgwsdCsOqa9IzUD7OB6yI1smBFT1aNQBYf2JHtyA6HF09A0Oy?=
 =?us-ascii?Q?3xQ8+82isKJ5kQ2fqaTIZ7BRV+rQ/1k/EdEp5vhzh1MS6bdDCsIczNRRulz4?=
 =?us-ascii?Q?AX6U/7vCoz0DVLRgfhmMFgAb3hwdMHHSLVekt3cN44zS6sMbYaWJgXUSfAxT?=
 =?us-ascii?Q?+SzuNnd5JAkWerc20W66KwVe/Upoa1t43fRXoRd3Bw0aygo+z3oKObpCpwcz?=
 =?us-ascii?Q?kNJ566bcFe+srZJIXesYmRQEvu2o33lBCfRuImfL8GliyI/hX6lDLReLTEkA?=
 =?us-ascii?Q?tkWHbhuBxo++6+e77XsG1e7HrEK/ffBktBVkop5pvcz0EsgiJMZdpzLYqpPl?=
 =?us-ascii?Q?BcClNnFk0sU0+Tgen8NqZ3aPnUzuzxbzEswfFku3W2w2qntgCEvp/EjSe9mP?=
 =?us-ascii?Q?YUV0I5Y0OSav91AcfgqkuoNFhQghAtqes1uyQ9wFoFICURIGk1Y82lgxjT+m?=
 =?us-ascii?Q?F45YjLrCDhlq3teTMvoXDWtDio/P1QbBmaKWmTnqGMMUWoqpCHggz/uajvJx?=
 =?us-ascii?Q?GwHxFf11a8dvL9xb0piKPulxMlZDIy1tWYRHDSYzS00dxXI0PguMvrMamt4T?=
 =?us-ascii?Q?q6oLSoi9Ytt1JFcTxLz7UvDXSvookhuIbGU9qh6mfftImhpjrTSU8WrgCVZ3?=
 =?us-ascii?Q?vqtC6K0sqq3B5pm9GF4xv5ad+DOGO9hsDex+Djfk0QwtiyEZH3dWRhnQBo5g?=
 =?us-ascii?Q?NMhLMerdikDV6Ai7AG2IvzrZFsnrfJGHm5ht9YbFaMzwZJpHSr4x7WMVVob2?=
 =?us-ascii?Q?cP92Y621xDcJwi3G/kKrjFCXe2b64wRUYHtJfMIAz50/HpyvB4BFmmB/FfdW?=
 =?us-ascii?Q?JvF5KwscfFtG19ZMevlWIZJnLH8OluESMo4e/44DVU0xxMwYE9wk0a63SZU9?=
 =?us-ascii?Q?HLAAAbes3G7qR7PYnV7VQXv+T3yG9UOZ+2qmntB512gTtFwE6CLC3t4g2km+?=
 =?us-ascii?Q?yeJYuyze6RoP6J7oVv6+VBEYmXpM15Qo6FvpUoveimNyy5SrPc9rEOqOkNEW?=
 =?us-ascii?Q?+90BE+ic7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8196.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fef43b6-e2aa-4513-0c7f-08da32d722cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 22:48:00.9254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nK+MKfgGJWVL2BVZWn/oH4Pkqj4WZ4bopeiD6wUlKvBQmaYAbHNPNtb8Q9rBVNTwPy8Bylav7x5iz/1sH0OY6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6687
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 08/04/2022 13:09, Alexander Stein wrote:
>> Outputs like this where -1 is printed as unsigned is somewhat misleading
>>   thermal thermal_zone1: Trip3[type=3D0,temp=3D48000]:trend=3D4,throttle=
=3D1
>>   thermal cooling_device3: cur_state=3D1
>>   thermal cooling_device3: old_target=3D-1, target=3D2
>>   thermal cooling_device3: zone1->target=3D1
>>   thermal cooling_device3: zone1->target=3D2
>>   thermal cooling_device3: zone1->target=3D18446744073709551615
>>   thermal cooling_device3: set to state 2
>>=20
>> With THERMAL_NO_TARGET assigning -1 as unsigned it make sense to print
>> the target as signed integer, even if the type is actually unsigned.
>>=20
>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>> ---
>> An alternative would be to change thermal_instance::target from unsigned
>> long to long, but this would entail a lot of API & driver changes as wel=
l
>> which looks less intriguing.
>>=20
>>   drivers/thermal/thermal_helpers.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal=
_helpers.c
>> index 3edd047e144f..0d0da6670267 100644
>> --- a/drivers/thermal/thermal_helpers.c
>> +++ b/drivers/thermal/thermal_helpers.c
>> @@ -199,7 +199,7 @@ void __thermal_cdev_update(struct thermal_cooling_de=
vice *cdev)
>>  =20
>>   	/* Make sure cdev enters the deepest cooling state */
>>   	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
>> -		dev_dbg(&cdev->device, "zone%d->target=3D%lu\n",
>> +		dev_dbg(&cdev->device, "zone%d->target=3D%ld\n",
>>   			instance->tz->id, instance->target);
>>   		if (instance->target =3D=3D THERMAL_NO_TARGET)
>>   			continue;
>
>Actually you pointed out something fuzzy in the target values.
>
>The unsigned long type for the target and THERMAL_NO_TARGET are not=20
>compatible.
>
>It would be much simpler to have THERMAL_NO_TARGET =3D 0 which=20
>semantically makes more sense than a negative value.

The compare of unsigned long and negative int is bad idea.
But there is serious problem introduced by "thermal: core: Add notification=
s call in the framework" patch.
When system resumes from mem suspend first time (this happen only on 1st re=
sume), the thermal notification is sent to drivers with value of 0 (meaning=
 system is no longer hot).
This is due to the fact target is init to 0 and when there is only 1 coolin=
g device; it gets out of the loop (due to continue;) with target still set =
to 0 and calls thermal_cdev_set_cur_state(cdev, target).
From there thermal_notify_cdev_state_update is called with argument of 0 wh=
ich notifies drivers with value of 0.

May be "unsigned long target" should be initialized to THERMAL_NO_TARGET in=
stead of 0.

[   29.107048] OOM killer enabled.
[   29.110225] Restarting tasks ... done.
[   29.124816] thermal cooling_device0: zone0->target=3D1844674407370955161=
5
[   29.138388] GPU0: Hot alarm is canceled.=20
[   29.145399] thermal cooling_device0: set to state 0
[   29.198954] PM: suspend exit

--=20
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.in=
fradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=3D04%7C01%7Cni=
tin.garg%40nxp.com%7C9b8d8247b7a24882faab08da1dea3606%7C686ea1d3bc2b4c6fa92=
cd99c5c301635%7C0%7C0%7C637855189012474295%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi=
MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=
=3DwAyLn2XgePgyZJJH50LC1PL1XHOQ%2BXjCw%2FJeq2qlSfw%3D&amp;reserved=3D0
