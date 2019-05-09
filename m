Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06EF194BF
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 23:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfEIViD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 17:38:03 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:33564 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726993AbfEIViD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 17:38:03 -0400
X-Greylist: delayed 9623 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 May 2019 17:38:02 EDT
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49LaX8P032686;
        Thu, 9 May 2019 17:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=5ng9ARN0oDz4cGb6TWH/O58xZPqWYya7FvGZEm/HGDg=;
 b=ZRZg3gZhizm+XWRYWxk3ZwE3Dut+aOtP05YRomxHWQBQVel+fRZblSEEsjNhBMECUHx5
 AWtaRbzQ8siYTtl47RVDiqn/hnU+s/nTxKK0c0l2nVSfPxbhN97wpFHbPXHqwZu4rQeC
 mLAFAG55Rs4SFwT7Cvac91yoSpAGhy4OmEFnxAyt4GpdhwzbOz/UPsahN9UDJwRGFPNu
 QT6isY2oQoOH4Y4bVu2zER28Bq2BO5H+HRV5rO35KLjlyn4E47ph9c2cKNZGqsRJSKrz
 wfpeWaPZUUmlugP0gtywCpQP+XpTTiEamJymVcpZS+NDFzF+GobSoyAp179NT239cvMb fg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2scbpeujmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 May 2019 17:38:02 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49Lbqdu194461;
        Thu, 9 May 2019 17:38:01 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 2scuga0pm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:38:01 -0400
X-LoopCount0: from 10.166.132.132
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="354717234"
From:   <Mario.Limonciello@dell.com>
To:     <kbusch@kernel.org>
CC:     <kai.heng.feng@canonical.com>, <hch@lst.de>, <axboe@fb.com>,
        <sagi@grimberg.me>, <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <keith.busch@intel.com>
Subject: RE: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Thread-Topic: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Thread-Index: AQHVBdBS/xizqbOjGUOY5SKUREVH6KZh7T4AgAAD4gD//6zksIAAWSuA//+yBvCAAPthgIAACiqAgAAmlACAAAnmAIAAA8eAgAAJFgCAAADiAIAAGKaA///lboAAEvm1AAAGPtNA
Date:   Thu, 9 May 2019 21:37:58 +0000
Message-ID: <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
References: <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
 <20190509061237.GA15229@lst.de>
 <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
 <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
In-Reply-To: <20190509192807.GB9675@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905090122
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090122
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> On Thu, May 09, 2019 at 06:57:34PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > No, current Windows versions don't transition to D3 with inbox NVME dri=
ver.
> > You're correct, it's explicit state transitions even if APST was enable=
d
> > (as this patch is currently doing as well).
>=20
> The proposed patch does too much, and your resume latency will be worse
> off for doing an unnecessary controller reset.
>=20
> The following should be all that's needed if the device is spec
> compliant. The resume part isn't necessary if npss is non-operational, bu=
t
> we're not saving that info, and it shouldn't hurt to be explicit anyway.
>=20
> I don't have any PS capable devices, so this is just compile tested.
>=20
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6265d9225ec8..ce8b9bc949b9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1132,6 +1132,22 @@ static int nvme_set_features(struct nvme_ctrl *dev=
,
> unsigned fid, unsigned dword
>  	return ret;
>  }
>=20
> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned npss)
> +{
> +	int ret;
> +
> +	mutex_lock(&ctrl->scan_lock);
> +	nvme_start_freeze(ctrl);
> +	nvme_wait_freeze(ctrl);
> +	ret =3D nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, npss, NULL, 0,
> +				NULL);
> +	nvme_unfreeze(ctrl);
> +	mutex_unlock(&ctrl->scan_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvme_set_power);

I believe without memory barriers at the end disks with HMB this will
still kernel panic (Such as Toshiba BG3).

This still allows D3 which we found at least failed to go into deepest stat=
e and blocked
platform s0ix for the following SSDs (maybe others):
Hynix PC601
LiteOn CL1

> +
>  int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>  {
>  	u32 q_count =3D (*count - 1) | ((*count - 1) << 16);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 527d64545023..f2be6aad9804 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -459,6 +459,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q,
> struct nvme_command *cmd,
>  		unsigned timeout, int qid, int at_head,
>  		blk_mq_req_flags_t flags, bool poll);
>  int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned npss);
>  void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
>  int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
>  int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a90cf5d63aac..2c4154cb4e79 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -18,6 +18,7 @@
>  #include <linux/mutex.h>
>  #include <linux/once.h>
>  #include <linux/pci.h>
> +#include <linux/suspend.h>
>  #include <linux/t10-pi.h>
>  #include <linux/types.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> @@ -2851,6 +2852,8 @@ static int nvme_suspend(struct device *dev)
>  	struct pci_dev *pdev =3D to_pci_dev(dev);
>  	struct nvme_dev *ndev =3D pci_get_drvdata(pdev);
>=20
> +	if (!pm_suspend_via_firmware())
> +		return nvme_set_power(&ndev->ctrl, ndev->ctrl.npss);
>  	nvme_dev_disable(ndev, true);
>  	return 0;
>  }
> @@ -2860,6 +2863,8 @@ static int nvme_resume(struct device *dev)
>  	struct pci_dev *pdev =3D to_pci_dev(dev);
>  	struct nvme_dev *ndev =3D pci_get_drvdata(pdev);
>=20
> +	if (!pm_suspend_via_firmware())
> +		return nvme_set_power(&ndev->ctrl, 0);
>  	nvme_reset_ctrl(&ndev->ctrl);
>  	return 0;
>  }
> --
