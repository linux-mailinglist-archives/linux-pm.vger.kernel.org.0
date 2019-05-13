Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCC31B97A
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 17:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfEMPFr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 11:05:47 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:37590 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727725AbfEMPFq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 11:05:46 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DEeUPA030344;
        Mon, 13 May 2019 11:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=chAF8huIeWFNVTfXYbNZpQo2VqCwIsV6gSMQwM6imN4=;
 b=KCktDra51lSdw3/Hcdg/Ti04mtb5zqnCfDPzFLjlCZkXXjEF3xwiKuqe4zlJzV2aLinF
 w7uoeahba440Gu+LDXau3tZhIu1JF8W2aDRhxK/t2gQ+vYjViZKot/C38X5ENv7GFtNw
 reByQtHSWyFjMead6GlsbCsaE2Fskb4Wei39FrAvKicWtzRdTdcOm23TH22+D0Usf2zW
 +2Yr/g52mlpnp76s31FwjZS+eOkmoAXFe0E4I1MD9mL28Bj+QRVzCqwRjS0RS/7oaoCk
 VsPCUfXIx3/goezeAuG9VAJq6y6Zgxrk9mivYOTYv31ZtHwqXrOcI9B0yrJMTOWyodBh pQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2sdsf3w32t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 May 2019 11:05:45 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DF3Fxd135653;
        Mon, 13 May 2019 11:05:44 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2sfa5s8sxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 11:05:44 -0400
X-LoopCount0: from 10.166.132.131
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="397025192"
From:   <Mario.Limonciello@dell.com>
To:     <kbusch@kernel.org>
CC:     <hch@lst.de>, <keith.busch@intel.com>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <kai.heng.feng@canonical.com>
Subject: RE: [PATCH] nvme/pci: Use host managed power state for suspend
Thread-Topic: [PATCH] nvme/pci: Use host managed power state for suspend
Thread-Index: AQHVB3g9crBQ5iluoUuygL0xp1WIm6ZlFnpAgAQIfyCAAFi+gP//rRIQgABX4QD//638cA==
Date:   Mon, 13 May 2019 15:05:42 +0000
Message-ID: <d69ff7154191492eaa8f55535a7effa5@AUSX13MPC105.AMER.DELL.COM>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143741.GA25500@lst.de>
 <b12ff66f8c224e4199ff1b90ed6bc393@AUSX13MPC105.AMER.DELL.COM>
 <20190513145522.GA15421@localhost.localdomain>
In-Reply-To: <20190513145522.GA15421@localhost.localdomain>
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130104
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
> Sent: Monday, May 13, 2019 9:55 AM
> To: Limonciello, Mario
> Cc: hch@lst.de; keith.busch@intel.com; sagi@grimberg.me; linux-
> nvme@lists.infradead.org; rafael@kernel.org; linux-kernel@vger.kernel.org=
; linux-
> pm@vger.kernel.org; kai.heng.feng@canonical.com
> Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Mon, May 13, 2019 at 02:43:43PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > > Well, it sounds like your partners device does not work properly in t=
his
> > > case.  There is nothing in the NVMe spec that says queues should be
> > > torn down for deep power states, and that whole idea seems rather
> > > counter productive to low-latency suspend/resume cycles.
> >
> > Well I've got a thought, quoting the NVME spec:
> > "After a successful completion of a Set Features command for this featu=
re, the
> controller shall be in the
> > Power State specified. If enabled, autonomous power state transitions c=
ontinue
> to occur from the new state."
> >
> > If APST is enabled on this disk, what is to stop an autonomous  reverse
> > transition from queue activity on the way down?
>=20
> Regardless of whether APST is enabled or not, the controller may
> autonomously transition out of a host requested low power state in
> response to host activity. Exiting a low power state should mean some
> other task is actively using the device, and if that's the case, why are
> you trying to enter a low power state in the first place? Alternatively,
> if host activity really is idle, then why is the device autonomously
> leaving the requested state?

This system power state - suspend to idle is going to freeze threads.
But we're talking a multi threaded kernel.  Can't there be a timing problem=
 going
on then too?  With a disk flush being active in one task and the other task=
 trying
to put the disk into the deepest power state.  If you don't freeze the queu=
es how
can you guarantee that didn't happen?
