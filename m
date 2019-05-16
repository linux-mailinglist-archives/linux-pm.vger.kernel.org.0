Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C168B21116
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 01:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfEPXo6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 19:44:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42534 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfEPXo6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 19:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558050299; x=1589586299;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UoVngPZ21XehvHWQydJoF/hcGNqN8uoBSAr7T4auy6Q=;
  b=IZOdQigSX1rUzNPs5l1VGpCjgyJS78magDyITyiIV86ejq7OdJDKjvRR
   +Tc6x0mLEbWf+0Mbs7pqJimrWEvYzY4y4tZ31hhP6qDz22Bg74KxKygav
   8SODv+Rl/gB8mrxNwHshO+ICFxb7ngeR5MU/uH/T86ndcgcxo3tG8h64N
   wswJ2Fa2tuMsAoS0yoUh47Jlj2e1UM6DUCijJpMtnwrj9RG7dWlgWXxRB
   8R4gBCEu1jEUPP5bbXconO+Yk6SbaNWpjcUso1+mQMVX7FcogbQ7hKI74
   5VrVeh4qLZpsihUimdBjq1ksNatc/OncUgwAUCt8Onq7h5naGOt7ttiLj
   A==;
X-IronPort-AV: E=Sophos;i="5.60,477,1549900800"; 
   d="scan'208";a="109706905"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2019 07:44:57 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z40tYaAq2LWKqy7yR73W+9Mrg4ip0ALKjYUKiRefUfg=;
 b=CdzbMZjI0xpXTMKKcjegFgw7FR4MTYdHrQWs8LJwffoTywK1fI+JZwkFvqmxkR8jfjlO/F+KHAeRU66rirJesm7AiCmuhll7TwQGD/zbl+d/ANUQa9LoAcXUH2iNgTxuqC1rQwSwjtWCOLLdF4M4NoAy1Hg+GKgocRHXFTORKIM=
Received: from DM6PR04MB4521.namprd04.prod.outlook.com (20.176.105.142) by
 DM6PR04MB4619.namprd04.prod.outlook.com (20.176.105.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 23:44:55 +0000
Received: from DM6PR04MB4521.namprd04.prod.outlook.com
 ([fe80::984c:651f:d40d:f8ef]) by DM6PR04MB4521.namprd04.prod.outlook.com
 ([fe80::984c:651f:d40d:f8ef%2]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 23:44:55 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
Thread-Topic: [PATCH 1/2] nvme: add thermal zone infrastructure
Thread-Index: AQHVCzFoHFFF5ExL0ECGVZaOXi7wYg==
Date:   Thu, 16 May 2019 23:44:54 +0000
Message-ID: <DM6PR04MB4521D53A9243977EF0B1EE2B860A0@DM6PR04MB4521.namprd04.prod.outlook.com>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f3f9307-a6f7-4f07-5ab6-08d6da587f8a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR04MB4619;
x-ms-traffictypediagnostic: DM6PR04MB4619:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB4619DED98CD671DB0D55BFB0860A0@DM6PR04MB4619.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39860400002)(136003)(199004)(189003)(68736007)(316002)(64756008)(71200400001)(110136005)(66556008)(53936002)(74316002)(2501003)(66476007)(91956017)(186003)(6116002)(3846002)(66946007)(66446008)(486006)(71190400001)(76116006)(26005)(73956011)(54906003)(2201001)(86362001)(478600001)(446003)(2906002)(30864003)(33656002)(5660300002)(25786009)(72206003)(14444005)(9686003)(256004)(53946003)(55016002)(6246003)(81156014)(102836004)(8936002)(6436002)(14454004)(4326008)(229853002)(7416002)(7696005)(81166006)(53546011)(6506007)(66066001)(476003)(76176011)(52536014)(99286004)(305945005)(8676002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB4619;H:DM6PR04MB4521.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T+ixRyiapJeFYTJYU5id1aHW4hVa9v1ot5Hb0I0xQIRV969BX1dmgzIqYxltecRQaWtWQhOoseDVqL6No2XYC+wIZkVlFv6feHt9E5QxEHTragaeaVBodUs55SZsTHAI721G1Q44QMRSDfIXryB0MJalxY7zy6q5t4uMctdwHP2AB1kfYLmzxY7lHr7HfkyNUrfYuPz4HrxsqT96UcZ0kM074GFf2vNg6YHx7zTlEAPm7vSu2VFeWGdfgWzjETSbzDAO2S8qcXoARiTgtbJ5DQYjgdGLttofrmiVu+WDCJhSwHE3o8P82fwwnA8AbRm7fafQ/sU+uszSMRQNDUTrBXluM6Zms570eEEPIZxiq2qlovBMBx/EB/QO3zwDEpdy3lgSplXnRmAvtJggmJ/b+cNBj8WcF8vPOABlNJMq+aM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3f9307-a6f7-4f07-5ab6-08d6da587f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 23:44:54.9365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4619
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks Akinobu for this work, please see some nit comments.=0A=
=0A=
On 5/15/19 8:18 AM, Akinobu Mita wrote:=0A=
> The NVMe controller reports up to nine temperature values in the SMART /=
=0A=
> Health log page (the composite temperature and temperature sensor 1 throu=
gh=0A=
> temperature sensor 8).=0A=
> The temperature threshold feature (Feature Identifier 04h) configures the=
=0A=
> asynchronous event request command to complete when the temperature is=0A=
> crossed its correspoinding temperature threshold.=0A=
>=0A=
> This adds infrastructure to provide these temperatures and thresholds via=
=0A=
> thermal zone devices.=0A=
>=0A=
> The nvme_thermal_zones_register() creates up to nine thermal zone devices=
=0A=
> for valid temperature sensors including composite temperature.=0A=
>=0A=
> /sys/class/thermal/thermal_zone[0-*]:=0A=
>     |---temp: Temperature=0A=
>     |---trip_point_0_temp: Over temperature threshold=0A=
>     |---trip_point_0_hyst: Under temperature threshold=0A=
>=0A=
> The thermal_zone[0-*] contains a symlink to the correspoinding nvme devic=
e.=0A=
> On the other hand, the following symlinks to the thermal zone devices are=
=0A=
> created in the nvme device sysfs directory.=0A=
>=0A=
> - nvme_temp0: Composite temperature=0A=
> - nvme_temp1: Temperature sensor 1=0A=
> ...=0A=
> - nvme_temp8: Temperature sensor 8=0A=
>=0A=
> The nvme_thermal_zones_unregister() removes the registered thermal zone=
=0A=
> devices and symlinks.=0A=
>=0A=
> Cc: Zhang Rui <rui.zhang@intel.com>=0A=
> Cc: Eduardo Valentin <edubezval@gmail.com>=0A=
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>=0A=
> Cc: Keith Busch <keith.busch@intel.com>=0A=
> Cc: Jens Axboe <axboe@fb.com>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Sagi Grimberg <sagi@grimberg.me>=0A=
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>=0A=
> ---=0A=
>  drivers/nvme/host/core.c | 368 +++++++++++++++++++++++++++++++++++++++++=
+++++-=0A=
>  drivers/nvme/host/nvme.h |  24 ++++=0A=
>  include/linux/nvme.h     |   4 +=0A=
>  3 files changed, 392 insertions(+), 4 deletions(-)=0A=
>=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index 172551b..a915c6b 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -1113,15 +1113,16 @@ static struct nvme_id_ns *nvme_identify_ns(struct=
 nvme_ctrl *ctrl,=0A=
>  	return id;=0A=
>  }=0A=
>  =0A=
> -static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsign=
ed dword11,=0A=
> -		      void *buffer, size_t buflen, u32 *result)=0A=
> +static int nvme_features(struct nvme_ctrl *dev, u8 opcode, unsigned int =
fid,=0A=
> +			 unsigned int dword11, void *buffer, size_t buflen,=0A=
> +			 u32 *result)=0A=
>  {=0A=
>  	struct nvme_command c;=0A=
>  	union nvme_result res;=0A=
>  	int ret;=0A=
>  =0A=
>  	memset(&c, 0, sizeof(c));=0A=
> -	c.features.opcode =3D nvme_admin_set_features;=0A=
> +	c.features.opcode =3D opcode;=0A=
>  	c.features.fid =3D cpu_to_le32(fid);=0A=
>  	c.features.dword11 =3D cpu_to_le32(dword11);=0A=
>  =0A=
> @@ -1132,6 +1133,22 @@ static int nvme_set_features(struct nvme_ctrl *dev=
, unsigned fid, unsigned dword=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> +static int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,=0A=
> +			     unsigned int dword11, void *buffer, size_t buflen,=0A=
> +			     u32 *result)=0A=
=0A=
1. nit:- can we align the start of the line to start of the character=0A=
and not to the (.=0A=
=0A=
+static int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,=0A=
+			      unsigned int dword11, void *buffer, size_t buflen,=0A=
+			      u32 *result)=0A=
=0A=
> +{=0A=
> +	return nvme_features(dev, nvme_admin_get_features, fid, dword11, buffer=
,=0A=
> +			     buflen, result);=0A=
> +}=0A=
> +=0A=
> +static int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,=0A=
> +			     unsigned int dword11, void *buffer, size_t buflen,=0A=
> +			     u32 *result)=0A=
> +{=0A=
> +	return nvme_features(dev, nvme_admin_set_features, fid, dword11, buffer=
,=0A=
> +			     buflen, result);=0A=
> +}=0A=
> +=0A=
I think above code change should go into the prep patch.=0A=
>  int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)=0A=
>  {=0A=
>  	u32 q_count =3D (*count - 1) | ((*count - 1) << 16);=0A=
> @@ -1168,6 +1185,9 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)=
=0A=
>  	u32 result, supported_aens =3D ctrl->oaes & NVME_AEN_SUPPORTED;=0A=
>  	int status;=0A=
>  =0A=
> +	if (IS_ENABLED(CONFIG_THERMAL))=0A=
> +		supported_aens |=3D NVME_SMART_CRIT_TEMPERATURE;=0A=
> +=0A=
>  	if (!supported_aens)=0A=
>  		return;=0A=
>  =0A=
> @@ -2164,6 +2184,334 @@ static void nvme_set_latency_tolerance(struct dev=
ice *dev, s32 val)=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> +#ifdef CONFIG_THERMAL=0A=
> +=0A=
> +static int nvme_get_temp(struct nvme_ctrl *ctrl, int sensor, int *temp)=
=0A=
> +{=0A=
> +	struct nvme_smart_log *log;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (sensor >=3D ARRAY_SIZE(log->temp_sensor))=0A=
Can we add a print warn or error message here ?=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	log =3D kzalloc(sizeof(*log), GFP_KERNEL);=0A=
> +	if (!log)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	ret =3D nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,=0A=
> +			   log, sizeof(*log), 0);=0A=
> +	if (ret) {=0A=
> +		ret =3D ret > 0 ? -EINVAL : ret;=0A=
> +		goto free_log;=0A=
> +	}=0A=
> +=0A=
> +	if (sensor)=0A=
> +		*temp =3D le16_to_cpu(log->temp_sensor[sensor - 1]);=0A=
> +	else=0A=
> +		*temp =3D get_unaligned_le16(log->temperature);=0A=
> +=0A=
> +	if (!*temp)=0A=
> +		ret =3D -EINVAL;=0A=
> +=0A=
> +free_log:=0A=
> +	kfree(log);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int nvme_tz_type_to_sensor(const char *type)=0A=
> +{=0A=
> +	int sensor;=0A=
> +=0A=
> +	if (sscanf(type, "nvme_temp%d", &sensor) !=3D 1)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	if (sensor < 0 || sensor > 8)=0A=
=0A=
nit:- please avoid using hard coded value 8 in the above, can we please=0A=
define=0A=
=0A=
a macro in nvme.h ?=0A=
=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	return sensor;=0A=
> +}=0A=
> +=0A=
> +#define KELVIN_TO_MILLICELSIUS(t) DECI_KELVIN_TO_MILLICELSIUS((t) * 10)=
=0A=
> +#define MILLICELSIUS_TO_KELVIN(t) ((MILLICELSIUS_TO_DECI_KELVIN(t) + 5) =
/ 10)=0A=
> +=0A=
> +static int nvme_tz_get_temp(struct thermal_zone_device *tzdev,=0A=
> +			    int *temp)=0A=
> +{=0A=
> +	int sensor =3D nvme_tz_type_to_sensor(tzdev->type);=0A=
> +	struct nvme_ctrl *ctrl =3D tzdev->devdata;=0A=
> +	int ret;=0A=
> +=0A=
> +	ret =3D nvme_get_temp(ctrl, sensor, temp);=0A=
> +	if (!ret)=0A=
> +		*temp =3D KELVIN_TO_MILLICELSIUS(*temp);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int nvme_tz_get_trip_type(struct thermal_zone_device *tzdev,=0A=
> +				 int trip, enum thermal_trip_type *type)=0A=
> +{=0A=
> +	*type =3D THERMAL_TRIP_ACTIVE;=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static int nvme_get_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool=
 under,=0A=
> +				int *temp)=0A=
> +{=0A=
> +	unsigned int threshold =3D sensor << 16;=0A=
> +	int status;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (under)=0A=
> +		threshold |=3D 0x100000;=0A=
hardcoded value, possible macro ?=0A=
> +=0A=
> +	ret =3D nvme_get_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL,=
 0,=0A=
> +				&status);=0A=
> +	if (!ret)=0A=
> +		*temp =3D status & 0xffff;=0A=
hardcoded value, possible macro ?=0A=
> +=0A=
> +	return ret > 0 ? -EINVAL : ret;=0A=
> +}=0A=
> +=0A=
> +static int nvme_get_over_temp_thresh(struct nvme_ctrl *ctrl, int sensor,=
=0A=
> +				     int *temp)=0A=
> +{=0A=
> +	return nvme_get_temp_thresh(ctrl, sensor, false, temp);=0A=
> +}=0A=
> +=0A=
> +static int nvme_get_under_temp_thresh(struct nvme_ctrl *ctrl, int sensor=
,=0A=
> +				     int *temp)=0A=
> +{=0A=
> +	return nvme_get_temp_thresh(ctrl, sensor, true, temp);=0A=
> +}=0A=
> +=0A=
> +static int nvme_set_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool=
 under,=0A=
> +				int temp)=0A=
> +{=0A=
> +	unsigned int threshold =3D (sensor << 16) | temp;=0A=
> +	int status;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (temp > 0xffff)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	if (under)=0A=
> +		threshold |=3D 0x100000;=0A=
> +=0A=
> +	ret =3D nvme_set_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL,=
 0,=0A=
> +				&status);=0A=
> +=0A=
> +	return ret > 0 ? -EINVAL : ret;=0A=
> +}=0A=
> +=0A=
> +static int nvme_set_over_temp_thresh(struct nvme_ctrl *ctrl, int sensor,=
=0A=
> +				     int temp)=0A=
> +{=0A=
> +	return nvme_set_temp_thresh(ctrl, sensor, false, temp);=0A=
> +}=0A=
> +=0A=
> +static int nvme_set_under_temp_thresh(struct nvme_ctrl *ctrl, int sensor=
,=0A=
> +				     int temp)=0A=
> +{=0A=
> +	return nvme_set_temp_thresh(ctrl, sensor, true, temp);=0A=
> +}=0A=
> +=0A=
> +static int nvme_tz_get_trip_temp(struct thermal_zone_device *tzdev,=0A=
> +				 int trip, int *temp)=0A=
> +{=0A=
> +	int sensor =3D nvme_tz_type_to_sensor(tzdev->type);=0A=
> +	struct nvme_ctrl *ctrl =3D tzdev->devdata;=0A=
> +	int ret;=0A=
> +=0A=
> +	ret =3D nvme_get_over_temp_thresh(ctrl, sensor, temp);=0A=
> +	if (!ret)=0A=
> +		*temp =3D KELVIN_TO_MILLICELSIUS(*temp);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int nvme_tz_set_trip_temp(struct thermal_zone_device *tzdev,=0A=
> +				 int trip, int temp)=0A=
> +{=0A=
> +	int sensor =3D nvme_tz_type_to_sensor(tzdev->type);=0A=
> +	struct nvme_ctrl *ctrl =3D tzdev->devdata;=0A=
> +	int ret;=0A=
> +=0A=
> +	temp =3D MILLICELSIUS_TO_KELVIN(temp);=0A=
> +=0A=
> +	ret =3D nvme_set_over_temp_thresh(ctrl, sensor, temp);=0A=
> +=0A=
> +	return ret > 0 ? -EINVAL : ret;=0A=
> +}=0A=
> +=0A=
> +static int nvme_tz_get_trip_hyst(struct thermal_zone_device *tzdev,=0A=
> +				 int trip, int *hyst)=0A=
> +{=0A=
> +	int sensor =3D nvme_tz_type_to_sensor(tzdev->type);=0A=
> +	struct nvme_ctrl *ctrl =3D tzdev->devdata;=0A=
> +	int ret;=0A=
> +=0A=
> +	ret =3D nvme_get_under_temp_thresh(ctrl, sensor, hyst);=0A=
> +	if (!ret)=0A=
> +		*hyst =3D KELVIN_TO_MILLICELSIUS(*hyst);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int nvme_tz_set_trip_hyst(struct thermal_zone_device *tzdev,=0A=
> +				 int trip, int hyst)=0A=
> +{=0A=
> +	int sensor =3D nvme_tz_type_to_sensor(tzdev->type);=0A=
> +	struct nvme_ctrl *ctrl =3D tzdev->devdata;=0A=
> +	int ret;=0A=
> +=0A=
> +	hyst =3D MILLICELSIUS_TO_KELVIN(hyst);=0A=
> +=0A=
> +	ret =3D nvme_set_under_temp_thresh(ctrl, sensor, hyst);=0A=
> +=0A=
> +	return ret > 0 ? -EINVAL : ret;=0A=
> +}=0A=
> +=0A=
> +static struct thermal_zone_device_ops nvme_tz_ops =3D {=0A=
> +	.get_temp =3D nvme_tz_get_temp,=0A=
> +	.get_trip_type =3D nvme_tz_get_trip_type,=0A=
> +	.get_trip_temp =3D nvme_tz_get_trip_temp,=0A=
> +	.set_trip_temp =3D nvme_tz_set_trip_temp,=0A=
> +	.get_trip_hyst =3D nvme_tz_get_trip_hyst,=0A=
> +	.set_trip_hyst =3D nvme_tz_set_trip_hyst,=0A=
> +};=0A=
> +=0A=
> +static struct thermal_zone_params nvme_tz_params =3D {=0A=
> +	.governor_name =3D "user_space",=0A=
> +	.no_hwmon =3D true,=0A=
> +};=0A=
> +=0A=
> +static struct thermal_zone_device *=0A=
> +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, int sensor)=0A=
> +{=0A=
> +	struct thermal_zone_device *tzdev;=0A=
> +	char type[THERMAL_NAME_LENGTH];=0A=
> +	int ret;=0A=
> +=0A=
> +	snprintf(type, sizeof(type), "nvme_temp%d", sensor);=0A=
> +=0A=
> +	tzdev =3D thermal_zone_device_register(type, 1, 1, ctrl, &nvme_tz_ops,=
=0A=
> +					     &nvme_tz_params, 0, 0);=0A=
The trips and type values should be #defined with a nice comment.=0A=
> +	if (IS_ERR(tzdev))=0A=
> +		return tzdev;=0A=
> +=0A=
> +	ret =3D sysfs_create_link(&ctrl->ctrl_device.kobj,=0A=
> +				&tzdev->device.kobj, type);=0A=
> +	if (ret)=0A=
> +		goto device_unregister;=0A=
> +=0A=
> +	ret =3D sysfs_create_link(&tzdev->device.kobj,=0A=
> +				&ctrl->ctrl_device.kobj, "device");=0A=
> +	if (ret)=0A=
> +		goto remove_link;=0A=
> +=0A=
> +	return tzdev;=0A=
> +=0A=
> +remove_link:=0A=
> +	sysfs_remove_link(&ctrl->ctrl_device.kobj, type);=0A=
> +device_unregister:=0A=
> +	thermal_zone_device_unregister(tzdev);=0A=
> +=0A=
> +	return ERR_PTR(ret);=0A=
> +}=0A=
> +=0A=
> +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)=0A=
> +{=0A=
> +	struct nvme_smart_log *log;=0A=
> +	int ret;=0A=
> +	int i;=0A=
> +=0A=
> +	log =3D kzalloc(sizeof(*log), GFP_KERNEL);=0A=
> +	if (!log)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	ret =3D nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,=0A=
> +			   log, sizeof(*log), 0);=0A=
> +	if (ret) {=0A=
> +		ret =3D ret > 0 ? -EINVAL : ret;=0A=
> +		goto free_log;=0A=
> +	}=0A=
> +=0A=
> +	for (i =3D 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {=0A=
> +		struct thermal_zone_device *tzdev;=0A=
> +=0A=
nit:- a comment will be useful here.=0A=
> +		if (i && !le16_to_cpu(log->temp_sensor[i - 1]))=0A=
> +			continue;=0A=
> +		if (ctrl->tzdev[i])=0A=
> +			continue;=0A=
> +=0A=
> +		tzdev =3D nvme_thermal_zone_register(ctrl, i);=0A=
> +		if (!IS_ERR(tzdev))=0A=
> +			ctrl->tzdev[i] =3D tzdev;=0A=
> +	}=0A=
> +=0A=
> +free_log:=0A=
> +	kfree(log);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(nvme_thermal_zones_register);=0A=
> +=0A=
> +void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)=0A=
> +{=0A=
> +	int i;=0A=
> +=0A=
> +	for (i =3D 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {=0A=
> +		struct thermal_zone_device *tzdev =3D ctrl->tzdev[i];=0A=
> +=0A=
> +		if (!tzdev)=0A=
> +			continue;=0A=
> +=0A=
> +		sysfs_remove_link(&tzdev->device.kobj, "device");=0A=
> +		sysfs_remove_link(&ctrl->ctrl_device.kobj, tzdev->type);=0A=
> +		thermal_zone_device_unregister(tzdev);=0A=
> +=0A=
> +		ctrl->tzdev[i] =3D NULL;=0A=
> +	}=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(nvme_thermal_zones_unregister);=0A=
> +=0A=
> +static void nvme_thermal_notify_framework(struct nvme_ctrl *ctrl)=0A=
> +{=0A=
> +	queue_work(nvme_wq, &ctrl->thermal_work);=0A=
> +}=0A=
> +=0A=
> +static void nvme_thermal_work(struct work_struct *work)=0A=
> +{=0A=
> +	struct nvme_ctrl *ctrl =3D=0A=
> +		container_of(work, struct nvme_ctrl, thermal_work);=0A=
> +	int i;=0A=
> +=0A=
> +	for (i =3D 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {=0A=
> +		if (ctrl->tzdev[i])=0A=
> +			thermal_notify_framework(ctrl->tzdev[i], 0);=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +static void nvme_thermal_init(struct nvme_ctrl *ctrl)=0A=
> +{=0A=
> +	INIT_WORK(&ctrl->thermal_work, nvme_thermal_work);=0A=
> +}=0A=
> +=0A=
> +#else=0A=
> +=0A=
> +static void nvme_thermal_notify_framework(struct nvme_ctrl *ctrl)=0A=
> +{=0A=
> +}=0A=
> +=0A=
> +static void nvme_thermal_init(struct nvme_ctrl *ctrl)=0A=
> +{=0A=
> +}=0A=
> +=0A=
> +#endif /* CONFIG_THERMAL */=0A=
> +=0A=
>  struct nvme_core_quirk_entry {=0A=
>  	/*=0A=
>  	 * NVMe model and firmware strings are padded with spaces.  For=0A=
> @@ -3630,6 +3978,14 @@ static void nvme_handle_aen_notice(struct nvme_ctr=
l *ctrl, u32 result)=0A=
>  	}=0A=
>  }=0A=
>  =0A=
nit:- I think AEN modification code needs to be split into different patch.=
=0A=
> +static void nvme_handle_aen_smart(struct nvme_ctrl *ctrl, u32 result)=0A=
> +{=0A=
> +	u32 aer_smart_type =3D (result & 0xff00) >> 8;=0A=
> +=0A=
> +	if (aer_smart_type =3D=3D NVME_AER_SMART_TEMP_THRESH)=0A=
> +		nvme_thermal_notify_framework(ctrl);=0A=
> +}=0A=
> +=0A=
>  void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,=0A=
>  		volatile union nvme_result *res)=0A=
>  {=0A=
> @@ -3643,8 +3999,10 @@ void nvme_complete_async_event(struct nvme_ctrl *c=
trl, __le16 status,=0A=
>  	case NVME_AER_NOTICE:=0A=
>  		nvme_handle_aen_notice(ctrl, result);=0A=
>  		break;=0A=
> -	case NVME_AER_ERROR:=0A=
>  	case NVME_AER_SMART:=0A=
> +		nvme_handle_aen_smart(ctrl, result);=0A=
> +		/* fallthrough */=0A=
> +	case NVME_AER_ERROR:=0A=
>  	case NVME_AER_CSS:=0A=
>  	case NVME_AER_VS:=0A=
>  		trace_nvme_async_event(ctrl, aer_type);=0A=
> @@ -3776,6 +4134,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct d=
evice *dev,=0A=
>  	dev_pm_qos_update_user_latency_tolerance(ctrl->device,=0A=
>  		min(default_ps_max_latency_us, (unsigned long)S32_MAX));=0A=
>  =0A=
> +	nvme_thermal_init(ctrl);=0A=
> +=0A=
>  	return 0;=0A=
>  out_free_name:=0A=
>  	kfree_const(ctrl->device->kobj.name);=0A=
Also, definitions and data structures updates should go into the=0A=
different patch prep patch.=0A=
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h=0A=
> index 7f6f1fc..ff7bd8f 100644=0A=
> --- a/drivers/nvme/host/nvme.h=0A=
> +++ b/drivers/nvme/host/nvme.h=0A=
> @@ -15,6 +15,7 @@=0A=
>  #include <linux/sed-opal.h>=0A=
>  #include <linux/fault-inject.h>=0A=
>  #include <linux/rcupdate.h>=0A=
> +#include <linux/thermal.h>=0A=
>  =0A=
>  extern unsigned int nvme_io_timeout;=0A=
>  #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)=0A=
> @@ -248,6 +249,11 @@ struct nvme_ctrl {=0A=
>  =0A=
>  	struct page *discard_page;=0A=
>  	unsigned long discard_page_busy;=0A=
> +=0A=
> +#ifdef CONFIG_THERMAL=0A=
Add a macro here for tzdev[9] or refer to spec.=0A=
> +	struct thermal_zone_device *tzdev[9];=0A=
> +	struct work_struct thermal_work;=0A=
> +#endif=0A=
>  };=0A=
>  =0A=
>  enum nvme_iopolicy {=0A=
> @@ -553,6 +559,24 @@ static inline void nvme_mpath_stop(struct nvme_ctrl =
*ctrl)=0A=
>  }=0A=
>  #endif /* CONFIG_NVME_MULTIPATH */=0A=
>  =0A=
> +#ifdef CONFIG_THERMAL=0A=
> +=0A=
> +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl);=0A=
> +void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl);=0A=
> +=0A=
> +#else=0A=
> +=0A=
> +static inline int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)=0A=
> +{=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static inline void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)=
=0A=
> +{=0A=
> +}=0A=
> +=0A=
> +#endif /* CONFIG_THERMAL */=0A=
> +=0A=
>  #ifdef CONFIG_NVM=0A=
>  int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);=0A=
>  void nvme_nvm_unregister(struct nvme_ns *ns);=0A=
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h=0A=
> index 8c0b29d..7acc77d 100644=0A=
> --- a/include/linux/nvme.h=0A=
> +++ b/include/linux/nvme.h=0A=
> @@ -500,6 +500,10 @@ enum {=0A=
>  };=0A=
>  =0A=
>  enum {=0A=
> +	NVME_AER_SMART_TEMP_THRESH	=3D 0x01,=0A=
> +};=0A=
> +=0A=
> +enum {=0A=
>  	NVME_AER_NOTICE_NS_CHANGED	=3D 0x00,=0A=
>  	NVME_AER_NOTICE_FW_ACT_STARTING =3D 0x01,=0A=
>  	NVME_AER_NOTICE_ANA		=3D 0x03,=0A=
=0A=
=0A=
