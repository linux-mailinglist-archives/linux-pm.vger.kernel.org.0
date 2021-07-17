Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B963CC520
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 20:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhGQSF0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 14:05:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57522 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhGQSFZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 14:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626544948; x=1658080948;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0pccix1+qs0fYhcoFWn17IACEE+Te3pbLviTJofN1ps=;
  b=lYtAB3pLWYHsTyYd/CmXtfCGbz29sVkJbGoMTUyiJvVAqWMrCDfjO4cW
   zFX/EdBbiHle+oAAiCRNkDS3OVklTdFuAsCEx7I/m3HS3YDv17hnW2FH3
   BRYVr6kzsD1bjZa1FtuqQYKUvWszhqvYlIP8CksPyfb9Ilo1Q4oZGQJ3k
   uRiOf5NSrUGQO57LP0Nr1mgoLScXjXLw36VCfXIqLdY8sO7XRKDtjub9z
   UOreRfq21GIt6aZGmMoDLcd7ieYeH0yXQMOQBMk6OS3u4MklmkiozdCZz
   90hWtWTfUlrsNm5ybCi278QtzAV1YbRSHB6jllU94vk+zSfntKkiwvBT/
   A==;
X-IronPort-AV: E=Sophos;i="5.84,248,1620662400"; 
   d="scan'208";a="179654449"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2021 02:02:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z33xlIHQm6ib/ZlRY5hN0Qf0cXicLOH8X9IsNerWxRoNNiSZi7Af0MbU9MuiSjpfFB32YV6jXTsIB015O4hB5Vsv2LbTEGUMTNjBglHU8KzoTz30SWFSYarNdfJGCKZLzTOCF2T1LgsSkg1Fth8tk7YkmX8hB0fN1RBXFKQhlGymh2ZCOK563C+V5aBhZdAxABBtd7IMRVqzrriJUWA7bzs6tjCgFbRraJkCdQMtt++s+APTP0TliANnDxeUc6lS9uq3z+3D1Yf2uSn0WbzGLQiEv+Z0gj5Im7/86+c9F+GKjQjCvt0Wf844LODTgo+H69o2zzG2vRXD5F84DmaCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAOxxIlxVAwGTU6Qe8+bxDopd0mpHrcn/JHrWD+mqwM=;
 b=FvVs6Qtqz3zioHhEzsDIurtnLIxYJcLs3ZP0o0f/D7pBdUU4AIuHzpPYFaBgLGCzolPicmvZKR2LkzedOYe4YcwF4vyD/hsVEGmLQA+zkaEedofYT190wgAMXl6PgOJX5Xh4DQ7eGzHTI2uciunKfXzFoSTsDcHKPMtyVWXVex+D5ADGbrnVhGtcs3XkBzLc1ZjxsYY0beD55L6T8Ow15bnDnmAbYkHcx3+ntzFajy/1W7gZSjFq98X0ISmtW5pQIdPrMxwq1kW2FIQcAEK656/i/S+Nf7/67zKM5p1zsgJUI44naTRbqNPgHBkDTBDdKJ0sU4tCvk3tyyjPfmzBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAOxxIlxVAwGTU6Qe8+bxDopd0mpHrcn/JHrWD+mqwM=;
 b=tjXCjvg8ZySXVdcrTCEwwHcuTIt2qrw0sJFRQEYYchCFvhv7Ee0P9E1jZOcKmoj4rUekdN0ijdIucUrXdm3pfbf44mTdRbGBOByyM4u9fJV9fuTtol2M1wsjhIjOIF1y1SOHuZvwvrZ669gEh9C62Zvo6Ka8WaSpAZIHQ3uZbq4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB7130.namprd04.prod.outlook.com (2603:10b6:5:243::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Sat, 17 Jul 2021 18:02:26 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ccfd:eb59:ccfe:66e4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ccfd:eb59:ccfe:66e4%5]) with mapi id 15.20.4331.029; Sat, 17 Jul 2021
 18:02:26 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
Thread-Topic: [PATCH V4 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
Thread-Index: AQHXejfny8us3PDZC0W2/Kbb+ap76qtHdlmw
Date:   Sat, 17 Jul 2021 18:02:25 +0000
Message-ID: <DM6PR04MB65758A834069CC7B56669905FC109@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210716114408.17320-1-adrian.hunter@intel.com>
 <20210716114408.17320-3-adrian.hunter@intel.com>
In-Reply-To: <20210716114408.17320-3-adrian.hunter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dc20888-4f79-4d23-dd0a-08d9494d08eb
x-ms-traffictypediagnostic: DM6PR04MB7130:
x-microsoft-antispam-prvs: <DM6PR04MB7130AC0D85D388EFF2837403FC109@DM6PR04MB7130.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M9+hJuQvCnBZplFxWXeeKVre6wks+brQw+78Bv8WY3yA/XV+Iw/gZ1Ysg6b+QCcSuo8MpMXDk6nruGcxqTyBWWJ1XE72Af7HE3UgBxarNq31H+IqEiQlPnxz3gTJuDptyTpQHrH1tkN5viaO6dOZm2F4AOCFeA1+duFIQF92NzuBaI2px8mBVgVT9FIM7LWy3t3VdfNFhC/JF1Rac1zvCaHE9kdFTwOlmiO7ZIxan/VIT7mkbsaeJm0fpVs0TKpLJQiI+Jzo7/+EPrYARhNDtORnnJeg1VkjEuLcyF8QhtnkE7KW+2rV91Y3AOjLzS3Gs/QQ8kjUQ1NfoFkgbgxp9imI8tSHxPwoed2XAtBJsK0VxY1n+w/Sv5FKMaOHk7VD9OkddZ0YRPO0CvEuhP+GTFXCFwP1Rja+24duJp08MghcdoHnLjuONTSUs9Nv/KILvnCbLljtjY6rfqrLEPVRyeFEh02wxeK7iruVu5qOymCrvrRce6qvcDbfdo5MUY7hm6mHeaK3avWfhTpBurzAoc6HyrD6LS4SJwftkgxY8jKh90aOaVVcGUYD2Kju8f6NC/s3lRji1TiaJ+xH9o5Gk456QuXEyrkwRqitWthC6p6xXHGJqmN5YlBBKw8QRTGfEoPfLWG80FiPBqORsqeYairzE2dRJC170X2aTlnW39Fel3uwHpkCx2fHtjWyTns+b4s0H514y0ZH+t3Ysu0+Gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(2906002)(110136005)(71200400001)(54906003)(186003)(316002)(86362001)(26005)(8676002)(33656002)(6506007)(55016002)(5660300002)(478600001)(8936002)(7696005)(52536014)(7416002)(4326008)(38100700002)(76116006)(66446008)(64756008)(66556008)(9686003)(66946007)(122000001)(66476007)(83380400001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5agPjYHNj29H8p+7hJ16AwN+YVdxz3RQ+4yZzXw4D9iTQPqkjGjTwRop4xkt?=
 =?us-ascii?Q?L6XcMk5SWV2MhfH+lXoEEptRZ9oiWpiFmXIbW0fPxwFAHM8aip3+EFAewS7N?=
 =?us-ascii?Q?MMbRpv4N8rCwYD8yOtRnM1OSwk6b3X+3XPHqnMvDaJM3XLZ5urLFbzIfX1ax?=
 =?us-ascii?Q?yZJ7D+YQq9PjGsIixZCJeb3wifOMoHuYLEfm+usOo5mCizaGGb33/4dMKbbZ?=
 =?us-ascii?Q?bKI4JXuEkRyX9AS2fzYh3lEAsFN3UMdiISNW+Bzqpq2hJdEs/LeYDjiwXKxL?=
 =?us-ascii?Q?6bujdpKuWHWsDGIpb92+ssyhuy2Kb2hXFhdFfIy9nWTjZBM0tqyX0EeeUFjB?=
 =?us-ascii?Q?tUvBa2uqEmmwt8DwxeaoQpm1PlzPKNnQuKvKV34Krq9KGxRcVO3Hyo+JrnNr?=
 =?us-ascii?Q?KL0CGvA/cN1LQbPgIRjR5FX2ajpx6/Vocsu7HmcFYAxz4yWeP5e0RWlgSyS8?=
 =?us-ascii?Q?gQ8mzfh6hjooIXae3Edg1ypvaQLfk6CUTWlbGDMgbk4z46KToX0Zfr0XcktB?=
 =?us-ascii?Q?XPaBZU3ApFSk5L+j3WAuwuKvouED81OGfB+eBeFeqz6MvwrHAYdQpncp2ngk?=
 =?us-ascii?Q?de0P09Rlm0OoYEjK4hmd3SXIGYdV6yASo/5VKM+0NZJlHvfHGLALUdClE+dW?=
 =?us-ascii?Q?faUvSLgT4TwPRzsWhBCmgLlK7FufJQ6eb+9SDPxuJkGd2GYBqya1/KaASAhZ?=
 =?us-ascii?Q?bHsMqc/7q7wa3Y7NOX0XzncioUkW98xDSmFlB6DiR/Mrnj+cTIvxkGdziSSd?=
 =?us-ascii?Q?kajYXJGIA0aG04sr8txsqTznly6qMiy/OtttH1O/O3+XYLuVYpi9AF8u/139?=
 =?us-ascii?Q?k3bE0QXZUClN2tFqmLzLVnlQYxU5nP+mK4K6vSAJnEUlLWsGB25jz8Zi9Q3u?=
 =?us-ascii?Q?kPFd8GQ0aZ4F3Fa+e5NBq0sZodKU6gKHlmHHu4UtKecKxRdNQiS/6E/TbPNO?=
 =?us-ascii?Q?U5KZ3MYz4NWPPVsyDv8/YnU2lpDnCGyjX0u5nmOlW2r1Hg5pvUeUcGvcV09z?=
 =?us-ascii?Q?8oKRrsfRYMa3EdYmyaf5ABMR+i6Ro4XHoyWfDFu0hd8Up8dTMtf5Zz/kR06T?=
 =?us-ascii?Q?Wh+EYNyUEZ1VSNQjwJC9t3ayIJjpqEg6Tv/PkZYqQQBynyWgA5d75Q7TMXvk?=
 =?us-ascii?Q?EMIASwqOmQ50INgUBO/JvchdVePOtYlt+/PvixKyvWO7MLxD/LeyeNq6L+xq?=
 =?us-ascii?Q?IXcpHx9M3ROGvoy1MYkiq9t4E6HIPN3OuWmeNkPecU+h6ZsgkQslM6lbYOl0?=
 =?us-ascii?Q?KG/oMdI0XC0ZRgS+OfrKQr0KLwQzDTIHFNSKmlHjaYpYDKrBaVzC8tbfI4Ij?=
 =?us-ascii?Q?sig=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc20888-4f79-4d23-dd0a-08d9494d08eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2021 18:02:25.9853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6D9pFIsCHdzX7ZGOKIpT9dMxq7yoUskL91pLxKNSCYWtixfm5Nt1Kkl2NbbKKmBZlKjQFJDxtkYIviz/vSpZgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7130
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 708b3b62fc4d..9864a8ee0263 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -5020,15 +5020,34 @@ static int ufshcd_slave_configure(struct scsi_dev=
ice
> *sdev)
>  static void ufshcd_slave_destroy(struct scsi_device *sdev)
>  {
>         struct ufs_hba *hba;
> +       unsigned long flags;
>=20
>         hba =3D shost_priv(sdev->host);
>         /* Drop the reference as it won't be needed anymore */
>         if (ufshcd_scsi_to_upiu_lun(sdev->lun) =3D=3D UFS_UPIU_UFS_DEVICE=
_WLUN) {
> -               unsigned long flags;
> -
>                 spin_lock_irqsave(hba->host->host_lock, flags);
>                 hba->sdev_ufs_device =3D NULL;
>                 spin_unlock_irqrestore(hba->host->host_lock, flags);
> +       } else if (hba->sdev_ufs_device) {
> +               struct device *supplier =3D NULL;
> +
> +               /* Ensure UFS Device WLUN exists and does not disappear *=
/
> +               spin_lock_irqsave(hba->host->host_lock, flags);
> +               if (hba->sdev_ufs_device) {
Was just checked in the outer clause?

Thanks,
Avri

> +                       supplier =3D &hba->sdev_ufs_device->sdev_gendev;
> +                       get_device(supplier);
> +               }
> +               spin_unlock_irqrestore(hba->host->host_lock, flags);
> +
> +               if (supplier) {
> +                       /*
> +                        * If a LUN fails to probe (e.g. absent BOOT WLUN=
), the
> +                        * device will not have been registered but can s=
till
> +                        * have a device link holding a reference to the =
device.
> +                        */
> +                       device_link_remove(&sdev->sdev_gendev, supplier);
> +                       put_device(supplier);
> +               }
>         }
>  }
>=20
> --
> 2.17.1

