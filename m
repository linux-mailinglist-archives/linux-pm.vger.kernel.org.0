Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262411B931
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 16:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfEMOyz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 10:54:55 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:38602 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727997AbfEMOyy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 10:54:54 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DEeRlD015910;
        Mon, 13 May 2019 10:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Yfx/+fCoaUN7e6wNIZpP9YbxyLOlbZPBQ9HySR+Tmbc=;
 b=WrE+WqT3olCy7fiiyrMtLtHf1iKaslR3p2a8UGdZwDH1HZLQ8TIlkMtsvByEp6XzzzfD
 yEN8uOoYJy8JPfx4JGDGhk6e9xh1NjBH4NcMZ/zWHR+goq+aivrxfF3RMaKz8mTPm/JY
 qf/xGo/nbeciFo+BLzmnAh8FAS7TJZ8+17ist4yFAlFkaE+O8I84I8gMvP2WJYXZxsKi
 qZsoMoMtkbd6G5deSlAlfysLfWlpRoAwE1fH8Ez9gdRKQ3pS9OnL4AGDGtOlop5nMDCW
 kxiBBl9MggpodT4XFXv/h79US6hvlnAiTrxPrlM6SyytyxzdoTE5aBTNvWe/KtC5KTRp hA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2sdqfsn6b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 May 2019 10:54:53 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DEcAdV036272;
        Mon, 13 May 2019 10:54:52 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 2sf9r59736-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 10:54:52 -0400
X-LoopCount0: from 10.166.132.127
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="356506304"
From:   <Mario.Limonciello@dell.com>
To:     <kbusch@kernel.org>
CC:     <keith.busch@intel.com>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <kai.heng.feng@canonical.com>
Subject: RE: [PATCH] nvme/pci: Use host managed power state for suspend
Thread-Topic: [PATCH] nvme/pci: Use host managed power state for suspend
Thread-Index: AQHVB3g9crBQ5iluoUuygL0xp1WIm6ZlFnpAgAQIfyCAAFjOAP//rwFA
Date:   Mon, 13 May 2019 14:54:49 +0000
Message-ID: <7ab8274ef1ce46fcae54a50abc76ae4a@AUSX13MPC105.AMER.DELL.COM>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143754.GE15318@localhost.localdomain>
In-Reply-To: <20190513143754.GE15318@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=981 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130103
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905130103
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Monday, May 13, 2019 9:38 AM
> To: Limonciello, Mario
> Cc: keith.busch@intel.com; hch@lst.de; sagi@grimberg.me; linux-
> nvme@lists.infradead.org; rafael@kernel.org; linux-kernel@vger.kernel.org=
; linux-
> pm@vger.kernel.org; kai.heng.feng@canonical.com
> Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Mon, May 13, 2019 at 02:24:41PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > This was not a disk with HMB, but with regard to the HMB I believe it n=
eeds to be
> > removed during s0ix so that there isn't any mistake that SSD thinks it =
can access
> HMB
> > memory in s0ix.
>=20
> Is that really the case, though? Where may I find that DMA is not
> allowed in this state? I just want an authoritative reference to attach
> to the behavior.

The Intel DMA controller suspend callbacks in drivers/dma/idma64.c look to =
me to
turn off the controller.

And NVME spec made it sound to me that while in a low power state it should=
n't
be available if the memory isn't available.

NVME spec in 8.9:

"Host software should request that the controller release the
assigned ranges prior to a shutdown event, a Runtime D3 event, or any other=
 event
that requires host software to reclaim the assigned ranges."
