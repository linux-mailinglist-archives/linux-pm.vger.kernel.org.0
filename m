Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1219525696
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 19:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfEURX1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 13:23:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30462 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbfEURX0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 13:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558459405; x=1589995405;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5Xv7McQjhNv3tV3VfoBIauyEwFi92aj5337LhxFzpno=;
  b=LAm2kA5WGLooTAwFix9csD0K5VPbRB+gIvmaWV38v5VFjRq5ICXhCG/5
   9z4kkG2ynKI8SfSHr534Kl7LzeOzq5NoiGt2iDddOfINpPnUZYt5K28kF
   jis6lAhzTcQvS6ju9KyiMM60NdgXZ/RJOwdlHSs7c9m4Ym9Ku0bYh215l
   yLG4TKBWWKAeRsuftGdlypgcgrJg+vq1xrFv1PwlRiaB/pB7nnVNyBc3J
   mwTssokaRs9Il9afYEqnPHZTfFhmQcPl+38dgujls+7a2Ml8TsYk6bctY
   9qMU1JNHUXKtts9Wk3WSYkzl453P9eOOoKDgdYsGLqCSgzqe+7vVujsBt
   w==;
X-IronPort-AV: E=Sophos;i="5.60,495,1549900800"; 
   d="scan'208";a="113714443"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2019 01:23:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKFpdTpIPrTtwGEKQqm8I1ZatHPIM4VQdAenSqAMPn0=;
 b=yQDV3ltvbhPxRQdP4FHvL1cYkRwQois2Nd+t0ffBE2sUnMbZNjRJuEqEBedEKJqqUIYJaJAXXUnPxb1oiXddGgq7gtpJAV5iEOsPPZt7hcq9/R7VxAcoKd9veyiagTgOj8/u+BjySJdjObUPJWz3cLDPMOlo3FQiFBQHOu9kI9c=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.52.22) by
 DM6PR04MB4652.namprd04.prod.outlook.com (20.176.105.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 21 May 2019 17:23:20 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::749c:e0fc:238:5c6d]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::749c:e0fc:238:5c6d%4]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 17:23:20 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v2 1/4] nvme: Export get and set features
Thread-Topic: [PATCH v2 1/4] nvme: Export get and set features
Thread-Index: AQHVD+7yPLaHS3C2sUacWM+7/ICPTg==
Date:   Tue, 21 May 2019 17:23:20 +0000
Message-ID: <DM6PR04MB57543310310DD72F98E361AD86070@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-2-git-send-email-akinobu.mita@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0b65af0-8da8-4223-96da-08d6de110533
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR04MB4652;
x-ms-traffictypediagnostic: DM6PR04MB4652:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB4652C3D32F3F58F3ED2F98FA86070@DM6PR04MB4652.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(136003)(376002)(39860400002)(199004)(189003)(8676002)(52536014)(5660300002)(81166006)(110136005)(99286004)(81156014)(76176011)(7696005)(7736002)(316002)(8936002)(53546011)(74316002)(2201001)(102836004)(71200400001)(6116002)(86362001)(2906002)(66066001)(6246003)(3846002)(71190400001)(53936002)(72206003)(486006)(446003)(6436002)(9686003)(229853002)(2501003)(55016002)(6506007)(25786009)(14454004)(476003)(33656002)(68736007)(91956017)(14444005)(64756008)(66446008)(66556008)(66476007)(76116006)(66946007)(73956011)(305945005)(26005)(4326008)(186003)(478600001)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB4652;H:DM6PR04MB5754.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a8IxN8xGEPH1GD2DuSU5ayGubMfqbxQ2fpzSplSmSKr0F0rleRfBALcxblxBGu/eSQrSQZOEv4JDOBL2uX91Yy5/cXjefcsqHX3XqgBqoLqiaiglttYeB5xEAT42FC+/lN5juTTzhfXEZh7oDWKln2gq2DxUQgqe62ERy+Zcy5BM9W9uTQLFtKvq9mZWQl0iUiXiZQekTROHUOqzF631YmoMpNYb6YDp0LC3jtjqdnURrHT7OkIvN2PoYflYI0rHdNHTXR9wZ3HceHrFUjv8qSnBoLSNxg3MGaSKJag84c6UlxRHwsfKcSnhuxElIYwKm5d+ZAbgAOBG4TDePCk23QL7KiYe03h7WemGiiY/EQJT5WldYaBVUhrgFi1NRdgLppbFxppXaVAmKQJtg6NwH0/56Et995Ez72akJjFbscM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b65af0-8da8-4223-96da-08d6de110533
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 17:23:20.0382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4652
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/21/19 9:05 AM, Akinobu Mita wrote:=0A=
> From: Keith Busch <keith.busch@intel.com>=0A=
>=0A=
> Future use intends to make use of features, so export these functions. An=
d=0A=
> since their implementation is identical except for the opcode, provide=0A=
> a new convenience function that implement each.=0A=
>=0A=
> Signed-off-by: Keith Busch <keith.busch@intel.com>=0A=
> ---=0A=
>  drivers/nvme/host/core.c | 22 +++++++++++++++++++---=0A=
>  drivers/nvme/host/nvme.h |  4 ++++=0A=
>  2 files changed, 23 insertions(+), 3 deletions(-)=0A=
>=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index d352145..c04df80 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -1113,15 +1113,15 @@ static struct nvme_id_ns *nvme_identify_ns(struct=
 nvme_ctrl *ctrl,=0A=
>  	return id;=0A=
>  }=0A=
>  =0A=
> -static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsign=
ed dword11,=0A=
> -		      void *buffer, size_t buflen, u32 *result)=0A=
> +static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned fid,=0A=
> +		unsigned dword11, void *buffer, size_t buflen, u32 *result)=0A=
=0A=
Your patch is generating warnings, can we please avoid these warnings ?=0A=
=0A=
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'=0A=
#28: FILE: drivers/nvme/host/core.c:1116:=0A=
+static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned fid,=0A=
=0A=
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'=0A=
#29: FILE: drivers/nvme/host/core.c:1117:=0A=
+        unsigned dword11, void *buffer, size_t buflen, u32 *result)=0A=
=0A=
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'=0A=
#45: FILE: drivers/nvme/host/core.c:1135:=0A=
+int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned=0A=
dword11,=0A=
=0A=
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'=0A=
#45: FILE: drivers/nvme/host/core.c:1135:=0A=
+int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned=0A=
dword11,=0A=
=0A=
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'=0A=
#53: FILE: drivers/nvme/host/core.c:1143:=0A=
+int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned=0A=
dword11,=0A=
=0A=
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'=0A=
#53: FILE: drivers/nvme/host/core.c:1143:=0A=
+int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned=0A=
dword11,=0A=
=0A=
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'=0A=
#72: FILE: drivers/nvme/host/nvme.h:462:=0A=
+int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned=0A=
dword11,=0A=
=0A=
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'=0A=
#72: FILE: drivers/nvme/host/nvme.h:462:=0A=
+int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned=0A=
dword11,=0A=
=0A=
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'=0A=
#74: FILE: drivers/nvme/host/nvme.h:464:=0A=
+int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned=0A=
dword11,=0A=
=0A=
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'=0A=
#74: FILE: drivers/nvme/host/nvme.h:464:=0A=
+int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned=0A=
dword11,=0A=
=0A=
total: 0 errors, 10 warnings, 50 lines checked=0A=
=0A=
NOTE: For some of the reported defects, checkpatch may be able to=0A=
      mechanically convert to the typical style using --fix or=0A=
--fix-inplace.=0A=
=0A=
0001-nvme-fix-memory-leak-for-power-latency-tolerance.patch has style=0A=
problems, please review.=0A=
=0A=
NOTE: If any of the errors are false positives, please report=0A=
      them to the maintainer, see CHECKPATCH in MAINTAINERS.=0A=
=0A=
>  {=0A=
>  	struct nvme_command c;=0A=
>  	union nvme_result res;=0A=
>  	int ret;=0A=
>  =0A=
>  	memset(&c, 0, sizeof(c));=0A=
> -	c.features.opcode =3D nvme_admin_set_features;=0A=
> +	c.features.opcode =3D op;=0A=
>  	c.features.fid =3D cpu_to_le32(fid);=0A=
>  	c.features.dword11 =3D cpu_to_le32(dword11);=0A=
>  =0A=
> @@ -1132,6 +1132,22 @@ static int nvme_set_features(struct nvme_ctrl *dev=
, unsigned fid, unsigned dword=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> +int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dwor=
d11,=0A=
> +		      void *buffer, size_t buflen, u32 *result)=0A=
> +{=0A=
> +	return nvme_features(dev, nvme_admin_set_features, fid, dword11, buffer=
,=0A=
> +			     buflen, result);=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(nvme_set_features);=0A=
> +=0A=
> +int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned dwor=
d11,=0A=
> +		      void *buffer, size_t buflen, u32 *result)=0A=
> +{=0A=
> +	return nvme_features(dev, nvme_admin_get_features, fid, dword11, buffer=
,=0A=
> +			     buflen, result);=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(nvme_get_features);=0A=
> +=0A=
>  int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)=0A=
>  {=0A=
>  	u32 q_count =3D (*count - 1) | ((*count - 1) << 16);=0A=
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h=0A=
> index 56bba7a..bb673b8 100644=0A=
> --- a/drivers/nvme/host/nvme.h=0A=
> +++ b/drivers/nvme/host/nvme.h=0A=
> @@ -459,6 +459,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q, =
struct nvme_command *cmd,=0A=
>  		union nvme_result *result, void *buffer, unsigned bufflen,=0A=
>  		unsigned timeout, int qid, int at_head,=0A=
>  		blk_mq_req_flags_t flags, bool poll);=0A=
> +int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dwor=
d11,=0A=
> +		      void *buffer, size_t buflen, u32 *result);=0A=
> +int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned dwor=
d11,=0A=
> +		      void *buffer, size_t buflen, u32 *result);=0A=
>  int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);=0A=
>  void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);=0A=
>  int nvme_reset_ctrl(struct nvme_ctrl *ctrl);=0A=
=0A=
=0A=
