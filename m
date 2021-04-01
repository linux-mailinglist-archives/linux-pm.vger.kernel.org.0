Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FCB351DF8
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhDASdb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:33:31 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:46406 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239116AbhDAS3B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 14:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617301741; x=1648837741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NkVLM6D4EzVocPythTlzE4Ng4Gn4jDkbBXaHAlWNA7g=;
  b=CaiZGhgSYnzB4VO/SqaMt/LLEb0GVBkdHRO/32CWQmNiErHzLuHRgZBo
   OLfYmUhEsVOfGY0yZD+y3dIIvoGr+lpPxyn4wBgZ9uxlxWcdzoiItJoKC
   O9VmLYKyK9AoS7mQq1ZVKNsVtUZUT7jczb3kYi5In5EgjBPQTBqBwKurn
   ZuEu8yh46RWj2Bw04n2mQEZPB+yqE8yB95Gxaf0PR1gBpYkILZt3VHjyz
   mkYRbBTyZ1DjzdrJ5SboiEAqmfRBQh6MsYrkhZHRxJ3Hmg/MVAO8Aq4h5
   C9O2tzZHW/iTGFGMuh/Nvz0q1MhJo+TZ10H9pfUiHoADHbUA6BkxkK9xf
   w==;
IronPort-SDR: vDEUb8LSPlrS3JE+YPvEKf9BoyD387jEE46ihAmYW+W3lpB6K4P4Lnb6w1/FTA+xrwcqaoze67
 Mfhh7LM/YmrVyd345oGUG1y8Hb4kafggLeD5qmQOL2zkdKZbt5k+W4weMSkD6oUW1Yrz5su1+g
 vAq3sJtH7crgBjz/QKEfy/sGg9hDiNOurKy2bZosMfNbHzX8sa8u45VpFR1TtRmEBYLK1OrRnv
 p3guOF9MZ1tgUfl1QT3VGoxrWeNR9FSIy3YEjLsAEPJLIewLoeVSPKQlENaSC1ZZQVUWqYnElU
 b/I=
X-IronPort-AV: E=Sophos;i="5.81,296,1610434800"; 
   d="scan'208";a="121423796"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2021 07:50:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 07:50:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Thu, 1 Apr 2021 07:50:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG3PdvaBpH/i1Sv/5V/dZ7WrPvS3h17Q0RmKIO3A0ByGiBmujkUqTdbF0EQfPdSA05bw+s7PbxV+Mz5ngkGEZxBojCas6N8N0DR9MRjkdIMDUyjlZ3PVRzdTFzbkJWPZqL+6BbRs+J1CoyLuuVwu7imw7LRHp0XIdc80OZU6HR5IQQBWIkhCpg+2hr8W6VvuKdBka9hCcIb6/GMXfF6OVnJYoOM0nRnkpe74zHYN6vSK64GiMRUVc6yiySDLM9LAwXNZ5rgQIinjvJRICh+PfkHSn7I7x6Q45D2eGKqXpstDHrRkhxUSnEQiMplUiVNp+bfPtioj4B4HqWxuvS8F3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUfF0sbszu9Vrac+8oTNsZ1oKdpVVkdUtEeHh8q3QvM=;
 b=Ds464eGtcUEtSrRcqd3ssT7dOq0lEBbtVi9ZR67EyyviruYgLLQm35ul9jZcH5DcsB+8OufjZU+DTkfkcp9BPLzNWAw4cXTET4AGxri8wQiK40vcHhaWLZ2Irp54b4FfrM3ZBIiGLZSklzNI9RbPcg6h6KJmY0TvtRegAFau9RzKLl+UcWxyUlJEk5ngYTHy+Y+oYOOPZH9KgCNEZGHGS+HysuyftDgyNY7sEnab8q0m8uVEjHuRcu5juYDGM0e/DwxCVqaB0Y4mdRZhqtDeyFl71mPbGCkoDErGWPe2Qu88gFeIzcvOIM5egm6voE8eAUMVf8iJKdj/5rKxmsc1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUfF0sbszu9Vrac+8oTNsZ1oKdpVVkdUtEeHh8q3QvM=;
 b=jUKYsXO2rASLCIu0tNzdaUfj600NGAztRVOz8Jr4mRFmgpDasiBzl8v27nHwF+jqQo39KvCUMTBlLe3GHtr3cs9/0MjNzv99m8P1y2T1Ghd7o6LlDNcnGWGcl8+aQxAp5/aLwCkOW6iK6iJkB2ukWNwqQf4PhiBMoJVcPz81MbM=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.27; Thu, 1 Apr 2021 14:50:14 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7%2]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 14:50:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <sre@kernel.org>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lkp@intel.com>,
        <dan.carpenter@oracle.com>
Subject: Re: [PATCH] power: reset: at91-reset: free resources on exit path
Thread-Topic: [PATCH] power: reset: at91-reset: free resources on exit path
Thread-Index: AQHXJwVGaY7mOnkUnUSKpK/+jjlOV6qfvpmA
Date:   Thu, 1 Apr 2021 14:50:14 +0000
Message-ID: <5fbc077d-1f45-6bc0-8d73-6008c6a28e76@microchip.com>
References: <20210209110109.906034-1-claudiu.beznea@microchip.com>
 <b18fc346-498d-4c6f-7f06-a6148a17d216@microchip.com>
 <ee7f39b3-8f7a-deb4-b4b2-dfc8e2ba86f9@microchip.com>
In-Reply-To: <ee7f39b3-8f7a-deb4-b4b2-dfc8e2ba86f9@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [82.76.227.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a4a84a4-bd68-42b2-a9dc-08d8f51d7561
x-ms-traffictypediagnostic: DM6PR11MB4202:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB42025B3FC73ECF3F471492D5877B9@DM6PR11MB4202.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X5CH5T5BYF8zzP5UKv5REoP96ildquLheBT8p7xYHwYbZcb7mtZw59chWYbGViDuIV43cz27dDLRiYu/jkv2TRs8v7h5oApkFKOBTw82tiGKik2/C/fROb0OMEwPueY6zHkW/A5+m/1ejyjVpuuMCszlkXQDwnoIBtimJRVDZouZp2Qe58qOkXYxDDNkc56zIJjfbkB5AWbytaWpoegViHJntgX2JkmxJ4dVM5jDK6RjzHgy13ZxtY4sMfgSvZGQ272amxZFhuuJX7vLFrl625TNqUSQVV5aOs3bQM5wkiiUlfFMTyynOCR6uSU6+6gI1QJT34IrxBvrVqG/PGciK9tYEt3nmS2nQi6th1QV/Rsd8njru+U921KzGpAPKEuxLjzXQiAt6SdaH0uYvDJ5IcN/zymUl5ZEYTgtUVMfZVB+OJtATGke2wH7ESUfuytTJtwlFVrMGWqBlujr2FynktXbtgR1rV3LhpRqzL+CGd6gcwemRe0LoJd9NeP/H2N7Aps6byCBv5syatOtrJ7Qcv7gZoI99ct2MdaRR5vz/q27YC4Um7Ji74YiQH6twxNYcGIx3aSRdyN2ojPs0gHPRYPt4LDyA10Wg4ia2VSjnO/XiBIOfYuFJe9MPTqcYh8z795pD/9xtD0HLVPuGKlQSp2zxONMUVKInTN2mdxOQIiKiVUJemh0aOAMoZO+/NOoVS6/5ohcSi26C4GbmEcXxE5dCi/7tcxKESzHp1F4aLg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(136003)(396003)(376002)(36756003)(316002)(66446008)(64756008)(8936002)(478600001)(66946007)(91956017)(66556008)(66476007)(6512007)(4326008)(31686004)(186003)(5660300002)(76116006)(6506007)(2906002)(2616005)(6486002)(83380400001)(86362001)(110136005)(31696002)(53546011)(54906003)(26005)(38100700001)(71200400001)(6636002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?fDcEKklfbHszfCFmqU5G1Hv1M5xi7qFFUknLgphf3vSLgoKasHPHYKLr?=
 =?Windows-1252?Q?uBAi1fk/Qe2XayBaFkMrv1ehkN56EGTyEp/iHm6B5fqYbQndOsQ1GDUT?=
 =?Windows-1252?Q?gGzHEcL+mO/MQK9NwS3weWEqhcx3Ub8r43SBO0/jn5BhhWAsDjTftwDa?=
 =?Windows-1252?Q?w4uUt2nDvpvCkz2fDtbLB4Ls61csI1r0MsiL0usedfWfj6beYhGNX+QY?=
 =?Windows-1252?Q?A6kSyZYWE5STFmCxxtjoMd2iPLGLfxSTcjc+w3dFo41/W/RNEzlY91tf?=
 =?Windows-1252?Q?dbt1fTyza8Sllc2cGrF+uQ3xsfOVNwQW+taAoic4bmZ7YMFy1NkWuwrv?=
 =?Windows-1252?Q?cAUWm6SoNV9nN6+PQ7vkVvkIRAzP1/zmanDMhktpvmMmMuOYGrDGot6b?=
 =?Windows-1252?Q?o3OMiD3S9KzlWDms0ttxCvnzRUYlYHmbxuPcHtoZoULayeewYXBXSjsv?=
 =?Windows-1252?Q?ZRChcTGW/f8S+KKnL4s98O+db0RjoUPfYVM2MmgxspdBv/Vx55tSwSrf?=
 =?Windows-1252?Q?KUnFN9yBztWhCvgcakG8l+mpyP0JNRvPDRGB1L1DAaEIORCxLoX2Wfwo?=
 =?Windows-1252?Q?rX8XqkK1UFs3ITEebKwZvTpv3/byZFGV2zkiSO290xjmeBVFoqH9Yqk+?=
 =?Windows-1252?Q?tDBGshzoVdCVjqoANUpSjqTTp39EOKyWTQ94Wg+xWWRke/cQUExMUsTF?=
 =?Windows-1252?Q?ynFSg9GcHzbVhP78wDlzmOP2tNveE0N1pkwXVPu5Sxc7ZuPXbxUhNZMQ?=
 =?Windows-1252?Q?hh1lvZcOZvnVQGDQMdpke2bGr3jbLpqQywTOn0f9oSoRKUm5TL7G1svS?=
 =?Windows-1252?Q?bms0U6gDCLRgFlMP41A7k/IKhyf33UALy7xTa9Hi5KNdX+A88p9avk3J?=
 =?Windows-1252?Q?LskOzoJK5v+uEMQ9GNC9TLlZU7JzSkSV6jBnlaYs+AH3cqJ2oOUD7Pwo?=
 =?Windows-1252?Q?gmK/1Bh+WFxJhgnzN1VWDFlX49Lceb4doLvZcA6cckjpQjSkcI3rrcWn?=
 =?Windows-1252?Q?3VluI8I//GFkOX9oivPuldrIDiAwzJnD0HZ0+iHN/7/Mdss0fx5Y3VNe?=
 =?Windows-1252?Q?jH8gicu6ye25/v9lJ7QVyNmEGNbU5sitFe+B0Nk1VS9LQ5widgKzfo5w?=
 =?Windows-1252?Q?p9PTh14fm7MQYQWD2aOLGxU/y0sQAS/ZRm2yWULeIoIJV89YX3wIYx12?=
 =?Windows-1252?Q?zq9Ju6CrxBIKrD011Y85FOhFlcrrPDO7AzDnenD2iWOYETh9LeE56pTo?=
 =?Windows-1252?Q?he+n0xH+tFdodPuyzWRL0lp5/OI6saMPrc59cXYHUeGvw97ZA+yppveq?=
 =?Windows-1252?Q?ZUGH/wj0AqSf+GAnR3mjczlyMyqSrIZx0aF8gTF85slhKCD+coOi25gK?=
 =?Windows-1252?Q?boOwHgYLWkhIOiL3Ul0/gYFAOKhxEbcVlto=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1627C4EF6D6D4445930A1E637C215FF6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4a84a4-bd68-42b2-a9dc-08d8f51d7561
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 14:50:14.4237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VP7YqgTHO7Wc2H5EOU7p6He5giTMHe7B4rWyI3MgyJ4kGfEsIThxtJ9/UUSr9c7jIIhu8PC8lvViNJpgx2dJ+2AWoPZmHQULedeHL9O2U04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4202
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01.04.2021 17:42, Claudiu Beznea - M18063 wrote:
> On 31.03.2021 11:18, Nicolas Ferre wrote:
>> On 09/02/2021 at 12:01, Claudiu Beznea wrote:
>>> Free resources on exit path (failure path of probe and remove).
>>
>> I'm not sure we can use this driver as a module anyway.
>>
>> Otherwise, it looks fine, but isn't it possible to use devm_of_iomap(),
>> even in loop, and avoid having to deal with exit path?
>=20
> For:
> reset->rstc_base =3D of_iomap(pdev->dev.of_node, 0);
>=20
> it should work.
>=20
> For the maps in the loop I have to double check. Basically, the struct
> resource object to pass to devm_of_iomap() is needed and for this the

Just realized I looked at the wrong code. Anyway, I'll double check and ret=
urn.

> pointer to a struct platform_device object corresponding to the node we
> look for in the loop is needed. So, I think this cannot be done this way.
>=20
>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>> ---
>>> =A0 drivers/power/reset/at91-reset.c | 25 ++++++++++++++++++++-----
>>> =A0 1 file changed, 20 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/power/reset/at91-reset.c
>>> b/drivers/power/reset/at91-reset.c
>>> index 3ff9d93a5226..2ff7833153b6 100644
>>> --- a/drivers/power/reset/at91-reset.c
>>> +++ b/drivers/power/reset/at91-reset.c
>>> @@ -206,7 +206,8 @@ static int __init at91_reset_probe(struct
>>> platform_device *pdev)
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!reset->ramc_base[idx]) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(&pdev->dev,=
 "Could not map ram controller
>>> address\n");
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 of_node_put(np);
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -ENODEV;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto unmap;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 idx++;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> @@ -218,13 +219,15 @@ static int __init at91_reset_probe(struct
>>> platform_device *pdev)
>>> =A0=A0=A0=A0=A0 reset->args =3D (u32)match->data;
>>> =A0 =A0=A0=A0=A0=A0 reset->sclk =3D devm_clk_get(&pdev->dev, NULL);
>>> -=A0=A0=A0 if (IS_ERR(reset->sclk))
>>> -=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(reset->sclk);
>>> +=A0=A0=A0 if (IS_ERR(reset->sclk)) {
>>> +=A0=A0=A0=A0=A0=A0=A0 ret =3D PTR_ERR(reset->sclk);
>>> +=A0=A0=A0=A0=A0=A0=A0 goto unmap;
>>> +=A0=A0=A0 }
>>> =A0 =A0=A0=A0=A0=A0 ret =3D clk_prepare_enable(reset->sclk);
>>> =A0=A0=A0=A0=A0 if (ret) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(&pdev->dev, "Could not enable slow =
clock\n");
>>> -=A0=A0=A0=A0=A0=A0=A0 return ret;
>>> +=A0=A0=A0=A0=A0=A0=A0 goto unmap;
>>> =A0=A0=A0=A0=A0 }
>>> =A0 =A0=A0=A0=A0=A0 platform_set_drvdata(pdev, reset);
>>> @@ -239,21 +242,33 @@ static int __init at91_reset_probe(struct
>>> platform_device *pdev)
>>> =A0=A0=A0=A0=A0 ret =3D register_restart_handler(&reset->nb);
>>> =A0=A0=A0=A0=A0 if (ret) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 clk_disable_unprepare(reset->sclk);
>>> -=A0=A0=A0=A0=A0=A0=A0 return ret;
>>> +=A0=A0=A0=A0=A0=A0=A0 goto unmap;
>>> =A0=A0=A0=A0=A0 }
>>> =A0 =A0=A0=A0=A0=A0 at91_reset_status(pdev, reset->rstc_base);
>>> =A0 =A0=A0=A0=A0=A0 return 0;
>>> +
>>> +unmap:
>>> +=A0=A0=A0 iounmap(reset->rstc_base);
>>> +=A0=A0=A0 for (idx =3D 0; idx < ARRAY_SIZE(reset->ramc_base); idx++)
>>> +=A0=A0=A0=A0=A0=A0=A0 iounmap(reset->ramc_base[idx]);
>>
>> But if we keep this loop, I have the feeling that some kind of
>> "of_node_put()" is needed as well.
>=20
> No! In the loop:
>=20
> for_each_matching_node_and_match(np, at91_ramc_of_match, &match) {
> 	reset->ramc_lpr =3D (u32)match->data;
> 	reset->ramc_base[idx] =3D of_iomap(np, 0);
> 	if (!reset->ramc_base[idx]) {
> 		dev_err(&pdev->dev, "Could not map ram controller address\n");
> 		of_node_put(np);
> 		ret =3D -ENODEV;
> 		goto unmap;
> 	}
> 	idx++;
> }
>=20
> the of_node_put() is needed only if the loop is interrupted as the macro:
> for_each_matching_node_and_match() is defined as follows:
>=20
> #define for_each_matching_node_and_match(dn, matches, match) \
> 	for (dn =3D of_find_matching_node_and_match(NULL, matches, match); \
> 	     dn; dn =3D of_find_matching_node_and_match(dn, matches, match))
>=20
> and of_find_matching_node_and_match() will return a np with refcount
> incremented but at the next loop step the of_find_matching_node_and_match=
()
> will be called with the same np pointer and the np refcount will be
> decremented.
>=20
> struct device_node *of_find_matching_node_and_match(
> 		struct device_node *from,
> 		const struct of_device_id *matches,
> 		const struct of_device_id **match)
> {
> 	// ...
> 	of_node_put(from);
> 	// ...
> }
>=20
>>
>>> +
>>> +=A0=A0=A0 return ret;
>>> =A0 }
>>> =A0 =A0 static int __exit at91_reset_remove(struct platform_device *pde=
v)
>>> =A0 {
>>> =A0=A0=A0=A0=A0 struct at91_reset *reset =3D platform_get_drvdata(pdev)=
;
>>> +=A0=A0=A0 int idx;
>>> =A0 =A0=A0=A0=A0=A0 unregister_restart_handler(&reset->nb);
>>> =A0=A0=A0=A0=A0 clk_disable_unprepare(reset->sclk);
>>> =A0 +=A0=A0=A0 iounmap(reset->rstc_base);
>>> +=A0=A0=A0 for (idx =3D 0; idx < ARRAY_SIZE(reset->ramc_base); idx++)
>>> +=A0=A0=A0=A0=A0=A0=A0 iounmap(reset->ramc_base[idx]);
>>
>> Ditto
>>
>>> +
>>> =A0=A0=A0=A0=A0 return 0;
>>> =A0 }
>>> =A0
>>
>>
>=20

