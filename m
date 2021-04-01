Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EF1351E99
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbhDASn5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:43:57 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:60700 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbhDASdj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 14:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617302021; x=1648838021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KmC/f7IrT5G4/YF4WjHSg5l192KYZRhDIkklFPXKj4k=;
  b=zz283xH5/1Hv7fOJIm7Zo70tvhvx9J/Zt8eBWnZ/Ftny4M4nrNstbQPW
   GjZv656khhTlEThIRDfwZAm6al07+QhAK3LaB1ayFDaEysCuKuZ5NUROV
   z6rLQLdsmDQ+cnwo8oyBGM0NeREKd/pXagWvAl/3wekV27VGZ7xHkd8TA
   1x28wXhyFi1zMnk5feMkjtPXdPfgMTd4taJzUY95UEf52XBB1/7G//Han
   xtnCjXwqb7DWvSmrWbVQxXId1BbcAGqCvbvAYtDUhFiHXe0oMDcNyB6fI
   PHpChWRGfe53QpUTh5FH7Jt6WiZ/uqUYcvOpTmKxJc5y2/M6zgrtb9ej6
   w==;
IronPort-SDR: 0lS7gE5IWsPzXAQqFZdtq2N0iRBMqpYsqSWJHKTTVsgWzuc3E4m2vFF2Ira8G3XkmmNARgMZc8
 IRDr82Zoi3EZ+6AKafT+7OHBhoYQZyQEpshU2+kZa++9SJITQG6891C19sAlwKl2NwReccTApx
 /aWgR2khjyaIVv3+X4M7m0bWAnsL9UieXwa5zaZV7djw3q6Eq4gLZ3t9RUayaDh1v/yOP8XlDF
 XSlHQaLKzonCavdi6DTmO9G4kdwuIqA/w12WP0aiyUsOcLMB8PDdOb301BWp5SgUqrq7Qz+fLy
 FF8=
X-IronPort-AV: E=Sophos;i="5.81,296,1610434800"; 
   d="scan'208";a="114997807"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2021 07:42:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 07:42:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Thu, 1 Apr 2021 07:42:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxEMLVpTLcoaj6gpKcAxLcmrrZRg9s9W24CNv6NoNED075ETXutJo86sG/NC2qz8FqeFxiKJ8N/PIN0YUz3TWQZEVdlrDYS+cO64ykZHKSaVE8jZ8a/S4Y3/pX9pYLT8+A3iz8krbOQIWxcLburdcPNfLOLGN8glnQ7cb5H/68ZuyvMZNZEOrzvjq9TH+vbXMx+Hn4Bh50RV28L0bNxKU01/iU1xlPSxGgDiA3bJ18LGUbQks4keWTB7NmgR/lzNBz8dn7/yeqK/p0ipi+NelzrpqH/VnufInDwaTOxspLh5HCVOLKz6ZBUnADayfy3gW0U4vJYhEFxxgASMNSh9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seXRfUZ9JdQYFJMZSzRgRV9WBLqDkyQOVloTvw4yvF0=;
 b=NhNrgsm2bXpQbb7KTGxiRw/kfRLuAbBw/0VSrq7T7lFQeVOI9z++KBCZM+wkXpoZKVw7W+CD2y+L52AzV/4rg20tNvMhMwQckCWn+zsV182rcyxrHUiVHcKZa+z+NRnlEKB775byJNG2dm3OgJhtMOVb54s+h+y71MbRPNOHkWYvv3qzsc8l89oef4pn3D66c0MFoHHnSwYj+yJNM3l/K2As48xS6UdkongATL/93Nq8lydk8R0+HRmnOgwZ6bsWO6ct64h0ctMXPHuJQNhxSnQd9cNeavmC3eTDUHT2dOCLb6k+uXQ/pVuv1wMQqeVrQ8h7ZDQJEV/uW2dymfPRog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seXRfUZ9JdQYFJMZSzRgRV9WBLqDkyQOVloTvw4yvF0=;
 b=HBgVgpukalA+3QBPRybptmfqHEtjz4HHPjJYs+NLXdaK7SpV3aRH/+HmSB7XRWNpBRydrac8Z1WjcJC9UCBy3aKzaXPtfQELX3dagTDLXIu1yXpwpode+cKtBNLobD4qK4h4qAuQd2qYlgIG0SSB4+sCn1fM7APp06V2hzL6XfM=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB4722.namprd11.prod.outlook.com (2603:10b6:5:2a7::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.26; Thu, 1 Apr 2021 14:42:47 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7%2]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 14:42:47 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <sre@kernel.org>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lkp@intel.com>,
        <dan.carpenter@oracle.com>
Subject: Re: [PATCH] power: reset: at91-reset: free resources on exit path
Thread-Topic: [PATCH] power: reset: at91-reset: free resources on exit path
Thread-Index: AQHXJwVGaY7mOnkUnUSKpK/+jjlOVw==
Date:   Thu, 1 Apr 2021 14:42:47 +0000
Message-ID: <ee7f39b3-8f7a-deb4-b4b2-dfc8e2ba86f9@microchip.com>
References: <20210209110109.906034-1-claudiu.beznea@microchip.com>
 <b18fc346-498d-4c6f-7f06-a6148a17d216@microchip.com>
In-Reply-To: <b18fc346-498d-4c6f-7f06-a6148a17d216@microchip.com>
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
x-ms-office365-filtering-correlation-id: bb2a6723-71ce-4bb0-1530-08d8f51c6acd
x-ms-traffictypediagnostic: DM6PR11MB4722:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB472251FEB5835790224DC339877B9@DM6PR11MB4722.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ve7EWc+gxUVaP7pYonsLiLYZ79Jv2hhR9+spgKwTZwSq2mOUS685K//m6NmmX7s+7d1YRFEUhuMNVlaJvc4Q9FmJyBD5ynVshPJBebO4cviFvJe3487OsXXq6ifJhFpwSqIMTE+EVVo04QV1+HJajHyNidL+OqK6lGT7eSLccjCenIqz6od9INFN5MbTg78sc4gfUQxYYA4Ha3uyZqmlji3/d1ASEHsRk0Zk/R1y3ZLhPsavH1it2RM4z7Tm7nj71TRYMG6cEg/f+VqvMDQvh2RAHO5B4t8iX6xNDabYroh7kyzxU0CUwLEbHeEIanOq2FssDm0R+ogMZs7xmDu/Q3ZO0gRzEF0N9EXgInjOVV7ae6EnZrVINzX7jV7Xa6fDT1rVZUpeVBvN5n9DpByvgbw9KP3s1+eVpWeE4uz4//cAdVC0cbrq+xJlcwSLC9HtWSQ3Z0UYOUzi6zlfe6BOv3rRwqsTvghXSU++xqUDdj3ZwR+LTsTC1dS+Ua+5xUZWFy8YttydZHYcpagLIZ5B3DlqNB22e+n+kYLso4vQDnEZEDesmgQDDPSg+v8eBFZislIpXiQdSmuvNsM4F/uGmn0PVaj33ewL5jOv3/xD4wSQPqmbGPeoSjpOW/lzBsk9VXlAKVOGyMej7GKJTW7NlCQnd+HW9eYT3J3evQhR1Kr4GPy4DBNHRF8fCoSgadBldrDa1SsaAMUlwkgdYXmVHjvu9t1l+7ABfPeC2Ysba4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(366004)(136003)(376002)(31686004)(26005)(38100700001)(4326008)(86362001)(53546011)(2906002)(186003)(110136005)(36756003)(71200400001)(6506007)(83380400001)(6512007)(8936002)(5660300002)(6636002)(316002)(478600001)(31696002)(66446008)(54906003)(66946007)(66476007)(64756008)(66556008)(91956017)(76116006)(8676002)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?NvzPAhSGxBopSh4BdoK7zfw82OG/lhzzByujjpz2Ccm8T5Qm0xoGkUof?=
 =?Windows-1252?Q?J0VM+CUxo4LbNmzmXAFVmYK+ZCtSiNkixQB3VvFND3zYQYbzd0mhTtMp?=
 =?Windows-1252?Q?BROV9t2Mt/nfXoxQxRJUGjid22mklJEYnd0tFuvoh3XzP1c1w9PeJmRt?=
 =?Windows-1252?Q?lfv+LUHaWKuNGdSkNlH3kHps6AfT87aayULOH6nm8ZM2PC9PuCx/RmO6?=
 =?Windows-1252?Q?aUarZ9B3z4uVrGQEuZ8K/BMtMtGqtVaiMviAsSi09iDbjve02wZ9X+zY?=
 =?Windows-1252?Q?VgZq/6elyDemi0Fj7AXmVk5b6ZLN8Vm4t+ruCtYxlac66GEFvnEqKYmT?=
 =?Windows-1252?Q?RD9144cRygbdVKm0uL1JKWSI0ADYKysHNGL4nKDGQewR/QsNJtzMniZx?=
 =?Windows-1252?Q?KLdq6EM1pW+S2QA4kwV0VCceMzGqazh/Lh9Zf2DTjQtpUYXRvfejTgfu?=
 =?Windows-1252?Q?CGCImsC+W8d61rXQvOph124uhrCMg85+kAAfUqN0bC1qxQnFuM5sWz8E?=
 =?Windows-1252?Q?ndYt94BpnbrnAIlqGNrXQWPxzAoG/iRQ+vQwh4Ms0D54UHzhqKEWuf4K?=
 =?Windows-1252?Q?LXo0PkAcF3zbKsShc24uQUHJLCVWiGj0W8B9jpFpOUT4e3toEVIgK0j9?=
 =?Windows-1252?Q?cKc/P5nuwUyN5emxdvVpgE1hJndnrHc+fwyhxnVN8isapMsZEuhbUERf?=
 =?Windows-1252?Q?cx/A/cDE6X8q0Ni68hI17c7cizZblpmpP0O6sdpF7dsq+Z4uyAgCTTrB?=
 =?Windows-1252?Q?JFnc8equq3fdBLAZts+fCZpPvl5jv8td1h2zLZHYet9q3RkWDtwGueud?=
 =?Windows-1252?Q?1GpqbFu4cFX8phehF5lvo4f4VWCC3KQl5orLOsHblMLrSz8aboOatQRL?=
 =?Windows-1252?Q?AihPcYufGqLA9VHcFvA/WIAtz0t0+fQ6FA/IUfI4LXWnbJfB2oDNktk2?=
 =?Windows-1252?Q?iZ7y6jA5ZxCbcOYR7jsSa1fI6V1iwzJTi4TNX1QdtSQsumV3Gfb22NWo?=
 =?Windows-1252?Q?X9Xs108PpAWme5u1qyqotBjDo+O5UryuHEYPyjcvzPWieDzv51K+bQWv?=
 =?Windows-1252?Q?OA5u0FhfBobtOagYXq4OkDzZgfzTAxEnNChHnHHeb3raI8MSilJ9nMNp?=
 =?Windows-1252?Q?03BGIPb9vZ0ViVII8MUE7wq2yTWuFDAh4OnChK/cYhoSK12rzRIo0RMd?=
 =?Windows-1252?Q?HC1m584eT128iKdGG5NKQKHytffg3NQcNkMLKiM7zBED1iVyGGfjl1PA?=
 =?Windows-1252?Q?zGoRWjTKJYXwOMm/gTCDCMUd6rXNJg3Y8td1np8cbsoYTGabOBrfahWc?=
 =?Windows-1252?Q?uwpq4qHhdK3Vcszy6I3OqszzKAmHWtcBNajoWcsOwgxAHuMcKqLcssCA?=
 =?Windows-1252?Q?AECT0kM3e+k6+XqWi8RJgVVCfj38gowo+9I=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <947C63E03A38D045A5DD32A21DDE0AA8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2a6723-71ce-4bb0-1530-08d8f51c6acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 14:42:47.1180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0t5jw+QHQ/l3wKQ7R7DENUDxEwGJp0xYSb3m8Z4IcCTyZQMp8yzsRo/RK4WUD+mAsdDIeX6KvY656FhCItYccAEAAKpZwBPo0e0pc7qKNr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4722
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31.03.2021 11:18, Nicolas Ferre wrote:
> On 09/02/2021 at 12:01, Claudiu Beznea wrote:
>> Free resources on exit path (failure path of probe and remove).
>=20
> I'm not sure we can use this driver as a module anyway.
>=20
> Otherwise, it looks fine, but isn't it possible to use devm_of_iomap(),
> even in loop, and avoid having to deal with exit path?

For:
reset->rstc_base =3D of_iomap(pdev->dev.of_node, 0);

it should work.

For the maps in the loop I have to double check. Basically, the struct
resource object to pass to devm_of_iomap() is needed and for this the
pointer to a struct platform_device object corresponding to the node we
look for in the loop is needed. So, I think this cannot be done this way.

>=20
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>> =A0 drivers/power/reset/at91-reset.c | 25 ++++++++++++++++++++-----
>> =A0 1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/power/reset/at91-reset.c
>> b/drivers/power/reset/at91-reset.c
>> index 3ff9d93a5226..2ff7833153b6 100644
>> --- a/drivers/power/reset/at91-reset.c
>> +++ b/drivers/power/reset/at91-reset.c
>> @@ -206,7 +206,8 @@ static int __init at91_reset_probe(struct
>> platform_device *pdev)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!reset->ramc_base[idx]) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(&pdev->dev, =
"Could not map ram controller
>> address\n");
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 of_node_put(np);
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -ENODEV;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto unmap;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 idx++;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> @@ -218,13 +219,15 @@ static int __init at91_reset_probe(struct
>> platform_device *pdev)
>> =A0=A0=A0=A0=A0 reset->args =3D (u32)match->data;
>> =A0 =A0=A0=A0=A0=A0 reset->sclk =3D devm_clk_get(&pdev->dev, NULL);
>> -=A0=A0=A0 if (IS_ERR(reset->sclk))
>> -=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(reset->sclk);
>> +=A0=A0=A0 if (IS_ERR(reset->sclk)) {
>> +=A0=A0=A0=A0=A0=A0=A0 ret =3D PTR_ERR(reset->sclk);
>> +=A0=A0=A0=A0=A0=A0=A0 goto unmap;
>> +=A0=A0=A0 }
>> =A0 =A0=A0=A0=A0=A0 ret =3D clk_prepare_enable(reset->sclk);
>> =A0=A0=A0=A0=A0 if (ret) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(&pdev->dev, "Could not enable slow c=
lock\n");
>> -=A0=A0=A0=A0=A0=A0=A0 return ret;
>> +=A0=A0=A0=A0=A0=A0=A0 goto unmap;
>> =A0=A0=A0=A0=A0 }
>> =A0 =A0=A0=A0=A0=A0 platform_set_drvdata(pdev, reset);
>> @@ -239,21 +242,33 @@ static int __init at91_reset_probe(struct
>> platform_device *pdev)
>> =A0=A0=A0=A0=A0 ret =3D register_restart_handler(&reset->nb);
>> =A0=A0=A0=A0=A0 if (ret) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 clk_disable_unprepare(reset->sclk);
>> -=A0=A0=A0=A0=A0=A0=A0 return ret;
>> +=A0=A0=A0=A0=A0=A0=A0 goto unmap;
>> =A0=A0=A0=A0=A0 }
>> =A0 =A0=A0=A0=A0=A0 at91_reset_status(pdev, reset->rstc_base);
>> =A0 =A0=A0=A0=A0=A0 return 0;
>> +
>> +unmap:
>> +=A0=A0=A0 iounmap(reset->rstc_base);
>> +=A0=A0=A0 for (idx =3D 0; idx < ARRAY_SIZE(reset->ramc_base); idx++)
>> +=A0=A0=A0=A0=A0=A0=A0 iounmap(reset->ramc_base[idx]);
>=20
> But if we keep this loop, I have the feeling that some kind of
> "of_node_put()" is needed as well.

No! In the loop:

for_each_matching_node_and_match(np, at91_ramc_of_match, &match) {
	reset->ramc_lpr =3D (u32)match->data;
	reset->ramc_base[idx] =3D of_iomap(np, 0);
	if (!reset->ramc_base[idx]) {
		dev_err(&pdev->dev, "Could not map ram controller address\n");
		of_node_put(np);
		ret =3D -ENODEV;
		goto unmap;
	}
	idx++;
}

the of_node_put() is needed only if the loop is interrupted as the macro:
for_each_matching_node_and_match() is defined as follows:

#define for_each_matching_node_and_match(dn, matches, match) \
	for (dn =3D of_find_matching_node_and_match(NULL, matches, match); \
	     dn; dn =3D of_find_matching_node_and_match(dn, matches, match))

and of_find_matching_node_and_match() will return a np with refcount
incremented but at the next loop step the of_find_matching_node_and_match()
will be called with the same np pointer and the np refcount will be
decremented.

struct device_node *of_find_matching_node_and_match(
		struct device_node *from,
		const struct of_device_id *matches,
		const struct of_device_id **match)
{
	// ...
	of_node_put(from);
	// ...
}

>=20
>> +
>> +=A0=A0=A0 return ret;
>> =A0 }
>> =A0 =A0 static int __exit at91_reset_remove(struct platform_device *pdev=
)
>> =A0 {
>> =A0=A0=A0=A0=A0 struct at91_reset *reset =3D platform_get_drvdata(pdev);
>> +=A0=A0=A0 int idx;
>> =A0 =A0=A0=A0=A0=A0 unregister_restart_handler(&reset->nb);
>> =A0=A0=A0=A0=A0 clk_disable_unprepare(reset->sclk);
>> =A0 +=A0=A0=A0 iounmap(reset->rstc_base);
>> +=A0=A0=A0 for (idx =3D 0; idx < ARRAY_SIZE(reset->ramc_base); idx++)
>> +=A0=A0=A0=A0=A0=A0=A0 iounmap(reset->ramc_base[idx]);
>=20
> Ditto
>=20
>> +
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> =A0
>=20
>=20

