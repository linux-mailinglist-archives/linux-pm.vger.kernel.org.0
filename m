Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A81B8DD
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfEMOnt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 10:43:49 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:38390 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728203AbfEMOnt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 10:43:49 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DEeRjw018478;
        Mon, 13 May 2019 10:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=aImZ5J/Q/lhWgc1+GpSNxDkEPKzeyAmtinwTFVJFtQA=;
 b=lGtHMrTfFS94Yy/H4BjKhmjwkNzS9B3747GeyQ0+WmeU0LtpZT0H++KkBiTzSNJ5MRdY
 Vj1dBvpr5Uduopv0SFUW1pooTELJNO5651kdV6sKu4+wFiM8TJbilkCypJJnsBnxZ9hX
 cRbK/tu+3qeDwesX3ROcyWJxvmmzoW6MvfJhbdpNjhnwXopJFU9zt1Umn+aZ3oePugB+
 hzplAD0kJibeSjmQHN2jsHIGRZyJqcfsgmaqloQVarCwpxR2hrh80lRi9pRNsM8nHVAV
 E7t79OEpZVmkR35e4nqT5rZ2WwBM2CwqeCrdSZqDjX/MrMb7n99YykbdI6Mm+b7qbOgN GQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2sdu2mmvu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 May 2019 10:43:47 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DEc9h0157401;
        Mon, 13 May 2019 10:43:46 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0a-00154901.pphosted.com with ESMTP id 2sf9411tj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 10:43:46 -0400
X-LoopCount0: from 10.166.132.127
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="793587289"
From:   <Mario.Limonciello@dell.com>
To:     <hch@lst.de>
CC:     <keith.busch@intel.com>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <kai.heng.feng@canonical.com>
Subject: RE: [PATCH] nvme/pci: Use host managed power state for suspend
Thread-Topic: [PATCH] nvme/pci: Use host managed power state for suspend
Thread-Index: AQHVB3g9crBQ5iluoUuygL0xp1WIm6ZlFnpAgAQIfyCAAFi+gP//rRIQ
Date:   Mon, 13 May 2019 14:43:43 +0000
Message-ID: <b12ff66f8c224e4199ff1b90ed6bc393@AUSX13MPC105.AMER.DELL.COM>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143741.GA25500@lst.de>
In-Reply-To: <20190513143741.GA25500@lst.de>
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
> From: Christoph Hellwig <hch@lst.de>
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
> > I've received the result that from one of my partners this patch doesn'=
t
> > work properly and the platform doesn't go into a lower power state.
>=20
> Well, it sounds like your partners device does not work properly in this
> case.  There is nothing in the NVMe spec that says queues should be
> torn down for deep power states, and that whole idea seems rather
> counter productive to low-latency suspend/resume cycles.

Well I've got a thought, quoting the NVME spec:
"After a successful completion of a Set Features command for this feature, =
the controller shall be in the
Power State specified. If enabled, autonomous power state transitions conti=
nue to occur from the new state."

If APST is enabled on this disk, what is to stop an autonomous  reverse
transition from queue activity on the way down?

>=20
> > This was not a disk with HMB, but with regard to the HMB I believe it
> > needs to be removed during s0ix so that there isn't any mistake that SS=
D
> > thinks it can access HMB memory in s0ix.
>=20
> There is no mistake - the device is allowed to use the HMB from the
> point that we give it the memory range until the point where we either
> disable it, or shut the controller down.  If something else requires the
> device not to use the HMB after ->suspend is called we need to disable
> the HMB, and we better have a good reason for that and document it in
> the code.  Note that shutting down queues or having CPU memory barriers
> is not going to help with any of that.

So maybe the CPU memory barriers were probably just working around it in te=
rms of
timing.
