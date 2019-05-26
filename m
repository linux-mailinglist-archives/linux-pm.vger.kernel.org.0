Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A4B2AB46
	for <lists+linux-pm@lfdr.de>; Sun, 26 May 2019 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfEZQpk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 May 2019 12:45:40 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11229 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfEZQpj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 May 2019 12:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558889139; x=1590425139;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=r7PrKTAJP0CBeIN350Jev5/QzYe5L9OobCsJehrhxRU=;
  b=Wlwe/RdmP/KzCLvdVjRuj2Ut25M8veYg+zhThRjL/4/FqthtAZK/z34U
   IBKUjAUdpVg4fEehBligSF6NyrSEy3QqvN4/lZlMTGjgJ+5kS9akbV8OU
   oppt68oU04j7pzIqzog1t3SxrAP4D6OXcUfOmApD9hWIPsoV2E+wPZEEX
   3NOtPwWmIK0nZEImNKTaVG2nocPZ/iH8zKYjSH+aSMXcJYEpT00VFefDk
   +W4P3Jgve4qyieXnSQ9bY9kzXoEb0nW6OffWwkpskwjcB9UAJoFU5OWPZ
   SjlgkVbFpmR7eav67Aya6ro1Vvfznx9YOM5RwPFVSv7Wo43/oHftiSusV
   g==;
X-IronPort-AV: E=Sophos;i="5.60,515,1549900800"; 
   d="scan'208";a="215334042"
Received: from mail-dm3nam03lp2051.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.51])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2019 00:45:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rKv6bUwySXN44uWb5hM4QaJOPg4+eOKVreyr1Na+s0=;
 b=WcVbw7xx5O1AwvQirCd/HFa57lXEMOls4IHm4HUTXQXV650jVPHYI1uC87UczhduYHVB5g+5VY0zlxfcZwWdY9yhnUxaOs9MYqyBUbGx4TdSdJ40daUtk1vhF6RQgnlESrKp8zWlxHyQW+qXAz5FMoL+9PWCyJakNhsf5t5EPHc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4502.namprd04.prod.outlook.com (52.135.238.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Sun, 26 May 2019 16:45:36 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1922.021; Sun, 26 May 2019
 16:45:36 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v3 1/3] nvme: Export get and set features
Thread-Topic: [PATCH v3 1/3] nvme: Export get and set features
Thread-Index: AQHVE+BH4hNGcND6B0CJO4oB0T3IRA==
Date:   Sun, 26 May 2019 16:45:35 +0000
Message-ID: <BYAPR04MB57490DD9161F123005DF3457861C0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-2-git-send-email-akinobu.mita@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [24.19.218.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd3f4f32-93aa-4b5d-f390-08d6e1f993b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4502;
x-ms-traffictypediagnostic: BYAPR04MB4502:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4502E56B163A726A3A05C6D3861C0@BYAPR04MB4502.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-forefront-prvs: 0049B3F387
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39850400004)(136003)(346002)(199004)(189003)(86362001)(476003)(486006)(66066001)(8936002)(446003)(6116002)(53546011)(5660300002)(6506007)(81166006)(81156014)(2201001)(8676002)(102836004)(74316002)(71200400001)(71190400001)(256004)(14444005)(110136005)(33656002)(3846002)(26005)(186003)(66476007)(66946007)(73956011)(66556008)(7736002)(66446008)(55016002)(2501003)(68736007)(305945005)(6246003)(99286004)(6436002)(478600001)(76116006)(64756008)(7696005)(14454004)(52536014)(25786009)(2906002)(76176011)(316002)(72206003)(9686003)(53936002)(229853002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4502;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: INNYE5otYeUzibD155LVTXhfrDP9FuXKXZOSAet829SAZ3R1O2f+ApD8/i/81Dc1Sxm1lRLe0s9woYCYWEX5wjKqG0xnGY138ZmVZF8welzviQPs1GLW3qXdz6/K6c3ZgTW/4O5EHQDmasfhbZ0h9uN9et62snshl3WdaSoheob09o64A53w+VG8ls++rDWCM4sXaAyiRbfy7obsh78ZQNTyyUOn2Ma7e5mu37KP1i46F+upgu0NufEDlPyuOZtFxU/C5oWR3VRTr1g9DlXzzmHhW40koIw//SSr5+xL1Y0/oENCIJW8ouU2a3qFdSUr7Ejyi6/9LkQfkqgAb0h615zRtEhfAKRe5fA+Q0q1EGmDyLWeZ7TX8SwQHNNNGojl59iUNBjeWSVxJlHlYOnz86mTsSmFVB8L/zRDSNKNZKU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3f4f32-93aa-4b5d-f390-08d6e1f993b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2019 16:45:35.8565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4502
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 5/26/19 9:30 AM, Akinobu Mita wrote:=0A=
> From: Keith Busch <keith.busch@intel.com>=0A=
> =0A=
> Future use intends to make use of both, so export these functions. And=0A=
> since their implementation is identical except for the opcode, provide a=
=0A=
> new function that implement both.=0A=
> =0A=
> [akinobu.mita@gmail.com>: fix line over 80 characters]=0A=
> Signed-off-by: Keith Busch <keith.busch@intel.com>=0A=
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>=0A=
> ---=0A=
>   drivers/nvme/host/core.c | 24 +++++++++++++++++++++---=0A=
>   drivers/nvme/host/nvme.h |  6 ++++++=0A=
>   2 files changed, 27 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index c6a29a3..c950916 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -1113,15 +1113,15 @@ static struct nvme_id_ns *nvme_identify_ns(struct=
 nvme_ctrl *ctrl,=0A=
>   	return id;=0A=
>   }=0A=
>   =0A=
> -static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsign=
ed dword11,=0A=
> -		      void *buffer, size_t buflen, u32 *result)=0A=
> +static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,=
=0A=
> +		unsigned int dword11, void *buffer, size_t buflen, u32 *result)=0A=
>   {=0A=
>   	struct nvme_command c;=0A=
>   	union nvme_result res;=0A=
>   	int ret;=0A=
>   =0A=
>   	memset(&c, 0, sizeof(c));=0A=
> -	c.features.opcode =3D nvme_admin_set_features;=0A=
> +	c.features.opcode =3D op;=0A=
>   	c.features.fid =3D cpu_to_le32(fid);=0A=
>   	c.features.dword11 =3D cpu_to_le32(dword11);=0A=
>   =0A=
> @@ -1132,6 +1132,24 @@ static int nvme_set_features(struct nvme_ctrl *dev=
, unsigned fid, unsigned dword=0A=
>   	return ret;=0A=
>   }=0A=
>   =0A=
> +int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,=0A=
> +		      unsigned int dword11, void *buffer, size_t buflen,=0A=
> +		      u32 *result)=0A=
> +{=0A=
> +	return nvme_features(dev, nvme_admin_set_features, fid, dword11, buffer=
,=0A=
> +			     buflen, result);=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(nvme_set_features);=0A=
> +=0A=
> +int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,=0A=
> +		      unsigned int dword11, void *buffer, size_t buflen,=0A=
> +		      u32 *result)=0A=
> +{=0A=
> +	return nvme_features(dev, nvme_admin_get_features, fid, dword11, buffer=
,=0A=
> +			     buflen, result);=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(nvme_get_features);=0A=
> +=0A=
>   int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)=0A=
>   {=0A=
>   	u32 q_count =3D (*count - 1) | ((*count - 1) << 16);=0A=
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h=0A=
> index de624ec..802aa19 100644=0A=
> --- a/drivers/nvme/host/nvme.h=0A=
> +++ b/drivers/nvme/host/nvme.h=0A=
> @@ -460,6 +460,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, =
struct nvme_command *cmd,=0A=
>   		union nvme_result *result, void *buffer, unsigned bufflen,=0A=
>   		unsigned timeout, int qid, int at_head,=0A=
>   		blk_mq_req_flags_t flags, bool poll);=0A=
> +int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,=0A=
> +		      unsigned int dword11, void *buffer, size_t buflen,=0A=
> +		      u32 *result);=0A=
> +int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,=0A=
> +		      unsigned int dword11, void *buffer, size_t buflen,=0A=
> +		      u32 *result);=0A=
>   int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);=0A=
>   void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);=0A=
>   int nvme_reset_ctrl(struct nvme_ctrl *ctrl);=0A=
> =0A=
=0A=
