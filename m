Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3743E1B845
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 16:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfEMOYp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 10:24:45 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:58032 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728566AbfEMOYp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 10:24:45 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DEK9U5000451;
        Mon, 13 May 2019 10:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=AheufpGoAZmVN2qZEnWSLdnmv1iZb5Fww4rLoVmGa8s=;
 b=HDtgWSAxj75cdt85mMJfupaHh1QhLcJsjdkZuGcUp2PNdb57K8GZvRwXqteQUDS3yj5f
 lfFCCSK2OyHcgqTxqJfKXzLgPIV0LiVRcLymvKC+x/J9tkEU4Bz+D9dWT+/X6+VRQoAk
 FpMQx31wRcqCdIUiWgQNfG16mYBu3QOXT34iNGmTJDfzBlT41e8Mdwbb3ecNseURpraz
 JIoSnmLvqfMWyvAHfEv5D00InI6+EwYoh/Di6SqmH9fR16z8ml936ZKHveqq7mVR1zXz
 qkVqWTBzqK85z74ejgnP75tOKpNjtIHJlY/szfgdFtkzSt6ppSe4IRB9RMomepuKFfu1 PQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2sdshw4x0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 May 2019 10:24:44 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DEIj29048061;
        Mon, 13 May 2019 10:24:43 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0a-00154901.pphosted.com with ESMTP id 2sdrmrbnm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 10:24:43 -0400
X-LoopCount0: from 10.166.132.133
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="336316460"
From:   <Mario.Limonciello@dell.com>
To:     <keith.busch@intel.com>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <kai.heng.feng@canonical.com>
Subject: RE: [PATCH] nvme/pci: Use host managed power state for suspend
Thread-Topic: [PATCH] nvme/pci: Use host managed power state for suspend
Thread-Index: AQHVB3g9crBQ5iluoUuygL0xp1WIm6ZlFnpAgAQIfyA=
Date:   Mon, 13 May 2019 14:24:41 +0000
Message-ID: <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
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
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130101
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905130101
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > Cc: Mario Limonciello <Mario.Limonciello@dell.com>
> > Cc: Kai Heng Feng <kai.heng.feng@canonical.com>
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> > Disclaimer: I've tested only on emulation faking support for the featur=
e.
>=20
> Thanks for sharing.  I'll arrange some testing with this with storage par=
tners early
> next week.
>=20

I've received the result that from one of my partners this patch doesn't wo=
rk properly
and the platform doesn't go into a lower power state.  (The patch submitted=
 by KH/me
did work on said system to get it into a lower power state for them).

This was not a disk with HMB, but with regard to the HMB I believe it needs=
 to be
removed during s0ix so that there isn't any mistake that SSD thinks it can =
access HMB
memory in s0ix.
