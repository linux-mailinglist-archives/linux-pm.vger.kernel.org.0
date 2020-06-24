Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E3C206AC7
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 05:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbgFXDvq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 23:51:46 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:19952 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388393AbgFXDvp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 23:51:45 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05O3pT70016100;
        Tue, 23 Jun 2020 23:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=lzYYmvJ8mehXNfscFFbTl65C+wIxaRGl4Dotn4Pd5x8=;
 b=ZSVvINVfhjV5lZ33fyDAivBiZK0HA5gYwKd9NEo1McNHTvTAoDEpncava85fTwLJE1Cz
 +1dOM88Kf85CWGTmDUu5PWBC9ryH6JDQsQrLpaygmw/GM4ia4bhnvSiGMftv07hcs+Bb
 2/wQ4Ehh9WXfNJIm4tzpWG3C25qbKh+K0b5khFG8dKaGsEgmwsG0EgBiKSww0zp+Ba/j
 sPI/9BEuaxNVHQxZqGduPawYq8atkIPP80nW1v4utnERxu75MMe0cgbcgUDOcW/4tK2f
 7b3md0vfqPigJIdyNB4naIiUMU2t28yEeIIVPi+UuUtI0jMJmqCXEM1vM0ySD/V+Yo9X zA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 31uuspgkbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 23:51:44 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05O3lxKa076012;
        Tue, 23 Jun 2020 23:51:44 -0400
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0a-00154901.pphosted.com with ESMTP id 31uxv5r8d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 23:51:44 -0400
X-LoopCount0: from 10.166.132.127
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1455323127"
From:   <Crag.Wang@dell.com>
To:     <Mario.Limonciello@dell.com>, <crag0715@gmail.com>,
        <sre@kernel.org>
CC:     <mathewk@chromium.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] power_supply: wilco_ec: Add permanent long life
 charging mode
Thread-Topic: [PATCH 1/1] power_supply: wilco_ec: Add permanent long life
 charging mode
Thread-Index: AQHWSTdLlppOCCC6Bki6k0A/v494M6jlsVIAgACTARD//8PXAIABEw/w
Date:   Wed, 24 Jun 2020 03:51:38 +0000
Message-ID: <23e76b5eda0849fdb4e1ef8b81807558@KULX13MDC113.APAC.DELL.COM>
References: <20200623082016.23188-1-crag_wang@dell.com>
 <6a804505400e4109906fadcf945edf76@AUSX13MPC105.AMER.DELL.COM>
 <ecda5d3852af4a1a8c08e0dc07983f35@KULX13MDC113.APAC.DELL.COM>
 <05bbf37785bd44ce8cc8777f107b16ff@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <05bbf37785bd44ce8cc8777f107b16ff@AUSX13MPC105.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-23T13:48:06.9996956Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=f22c6ecd-fc33-4d94-beba-f01c0a6f3fa5;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [125.252.73.115]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_17:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240026
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006240027
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > > Since this is normally only done in the factory context, can you
> > > please confirm does something need to be artificially done to block
> > > userland from trying to set the battery charging to this mode?  Or
> > > will the EC already
> > handle
> > > blocking it directly?
> >
> > This is a feature of the battery, when the EC receives this setting it
> > will be sent to the battery and stored there. Afterwards any attempt
> > to change this mode will return a failure.
>=20
> Sorry this still isn't clear to me.  You're saying that if EC receives lo=
nglife
> setting it will be able to do this in the field?  If so, then I think thi=
s patch will
> need to block that setting to not allow field conversions into longlife m=
ode.
>=20
EC does handle blocking the attempts from changing the mode.

EC reads current mode ahead of a new setting. If it sees permanent long lif=
e
already in use then any attempt to put the battery charging in a different =
mode
will get failure 0x01 from EC.

> >
> > It's even better to block mode selection in the userland if long life
> > mode already in use.
>=20
> Yes, I agree.  This sounds like a good follow up to me too.

