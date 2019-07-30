Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 754657B4BE
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 23:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfG3VF1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 17:05:27 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:39212 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbfG3VF1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 17:05:27 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6UKsoNK003924;
        Tue, 30 Jul 2019 17:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=mwWo+EACOG18Ohy9y6ZEYKunhMDAqAMxvrodiiKSbOY=;
 b=h8bJEt1HVijtfaPqWakRlng5Q77rpVXvjD/t0Zkorqu3TajZnc0hc9dRu+Ffk5sXsnQL
 kfy3sGw/KqOsn6QQYGJEi7DRyqjh7FnsNabGFiFdxYJ4Bj4u/uMbJDxtpiELbxmzj6JK
 LiDN7ys2lRvayjYyxAp0nEwWnmnHOFHoAMbOnI6DMwCUzbLDUYRNSynM774FnuHQEeX9
 jARdb4/Ch2d5aWKHeaQcYW2A5GM6td3c1t6epKCEnYa/JaA3JMgd/4Odc6WFFoiYgHnK
 wdaMHWAfOXTBd/qYz+G8Mds68ASI1IpC8CMajOD2ApYUwkAFseY1+7z3fCXXpTug5uJB 6A== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2u2kxtttuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 17:05:25 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6UKqlmG030857;
        Tue, 30 Jul 2019 17:05:25 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 2u2w3tgaju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 17:05:25 -0400
X-LoopCount0: from 10.166.132.128
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="402442619"
From:   <Mario.Limonciello@dell.com>
To:     <kbusch@kernel.org>, <kai.heng.feng@canonical.com>
CC:     <rjw@rjwysocki.net>, <keith.busch@intel.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rajatja@google.com>
Subject: RE: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
Thread-Topic: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
Thread-Index: AQHVQs6UiIesxZzK0UKkUWrQRuKoE6bbsW+A///PBcCAAGObgIAHcfaAgABB9YD//9WSkIAAb9eAgAAIQgD//8kpUA==
Date:   Tue, 30 Jul 2019 21:05:22 +0000
Message-ID: <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
References: <2332799.izEFUvJP67@kreacher>
 <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
 <20190730191934.GD13948@localhost.localdomain>
In-Reply-To: <20190730191934.GD13948@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-07-30T21:05:21.3406615Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300211
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300211
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Tuesday, July 30, 2019 2:20 PM
> To: Kai-Heng Feng
> Cc: Limonciello, Mario; rjw@rjwysocki.net; keith.busch@intel.com; hch@lst=
.de;
> sagi@grimberg.me; linux-nvme@lists.infradead.org; linux-pm@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org; rajatja@google.com
> Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state =
for
> suspend" has problems
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Wed, Jul 31, 2019 at 02:50:01AM +0800, Kai-Heng Feng wrote:
> >
> > Just did a quick test, this patch regress SK Hynix BC501, the SoC stays=
 at
> > PC3 once the patch is applied.
>=20
> Okay, I'm afraid device/platform quirks may be required unless there are
> any other ideas out there.

I think if a quirk goes in for Rafael's SSD it would have to be a quirk spe=
cific to this
device and FW version per the findings on KH checking the same device with =
the
older FW version.

>=20
> I'm not a big fan of adding more params to this driver. Those are
> global to the module, so that couldn't really handle a platform with
> two different devices that want different behavior.
