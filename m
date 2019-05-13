Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF1391BC88
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 20:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfEMSBq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 14:01:46 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:45806 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727668AbfEMSBq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 14:01:46 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DHxhpx002178;
        Mon, 13 May 2019 14:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=7RQwiZOU3P8AwjFWtnYhWR2+zaHJysmliJcO7wy13CY=;
 b=r+teCQ/g7haRS7P0Yv5+MKvoTeZ+p3BR12R9BX+7nXGrAHYDAZ2NxYvLKf/vK/12uY/9
 Xl6Y8y3lMuMdkTOluMSz753mDRG9/IxDEPlMB6LegYPWdMQUCbJmCxHHzetnpw+OC8Fc
 1UsiFt1YnS5F3owHEenLoY3KiLprfcS428dyfeVKFImm1FDrTGRyWNgQ/n+XvN0fYZMi
 ze9kbv0C+XAWanAqOa7d2xLKJdyFPkxUywUkO6VWYgpX7ed7VaswHI06O+1RPeZAQ8rE
 PJtYAiuNzcFpD+sdhdgdFZx222vUSiqlEYJ0IB3KbCWsk77D2Q+0dS5l96TSUWL8VjVG iQ== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2sdqfsnx66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 May 2019 14:01:44 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DHwdoN042639;
        Mon, 13 May 2019 14:01:43 -0400
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0b-00154901.pphosted.com with ESMTP id 2sf9xpbpbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 14:01:42 -0400
X-LoopCount0: from 10.166.132.134
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1293478792"
From:   <Mario.Limonciello@dell.com>
To:     <hch@lst.de>
CC:     <kbusch@kernel.org>, <keith.busch@intel.com>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <kai.heng.feng@canonical.com>
Subject: RE: [PATCH] nvme/pci: Use host managed power state for suspend
Thread-Topic: [PATCH] nvme/pci: Use host managed power state for suspend
Thread-Index: AQHVB3g9crBQ5iluoUuygL0xp1WIm6ZlFnpAgAQIfyCAAFjOAP//rwFAgABWXgD//93q8A==
Date:   Mon, 13 May 2019 18:01:39 +0000
Message-ID: <df020e90e8b54244b37910a2a7965671@AUSX13MPC105.AMER.DELL.COM>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143754.GE15318@localhost.localdomain>
 <7ab8274ef1ce46fcae54a50abc76ae4a@AUSX13MPC105.AMER.DELL.COM>
 <20190513145708.GA25897@lst.de>
In-Reply-To: <20190513145708.GA25897@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=893 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130123
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=990 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905130123
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Monday, May 13, 2019 9:57 AM
> To: Limonciello, Mario
> Cc: kbusch@kernel.org; keith.busch@intel.com; hch@lst.de; sagi@grimberg.m=
e;
> linux-nvme@lists.infradead.org; rafael@kernel.org; linux-kernel@vger.kern=
el.org;
> linux-pm@vger.kernel.org; kai.heng.feng@canonical.com
> Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Mon, May 13, 2019 at 02:54:49PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > The Intel DMA controller suspend callbacks in drivers/dma/idma64.c look=
 to me
> to
> > turn off the controller.
>=20
> How is that relevant?  That thing is neither a NVMe controller, nor
> even an PCIe device..

When using HMB the SSD will be writing to some memory mapped region.  Writi=
ng to
that region would use DMA to access host memory, no?
If the DMA controller is not functional writing to that region won't work p=
roperly as=20
it can't access that memory.

>=20
> > And NVME spec made it sound to me that while in a low power state it sh=
ouldn't
> > be available if the memory isn't available.
> >
> > NVME spec in 8.9:
> >
> > "Host software should request that the controller release the
> > assigned ranges prior to a shutdown event, a Runtime D3 event, or any o=
ther
> event
> > that requires host software to reclaim the assigned ranges."
>=20
> The last part of the quoted text is the key - if the assigned range
> is reclaimed, that is the memory is going to be used for something else,
> we need to release the ranges.  But we do not release the ranges,
> as we want to keep the memory in use so that we can quickly use it
> again.
