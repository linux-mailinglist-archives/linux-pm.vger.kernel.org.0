Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8C920196B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 19:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgFSR0L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 13:26:11 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:7186 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729255AbgFSR0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2020 13:26:10 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JHOhmc004121;
        Fri, 19 Jun 2020 13:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Y47GOtysBn/U+lyIQcdu534W6B4NcD1Ao2pjkmc0fuA=;
 b=LfxYUNiq613Vy1wMd0RPk6Ek0ZMT1N7vtxgwo/hu7cYPMfpIK1TItwPnhiXkrMFNlBvs
 FdEYym64KsId7NzCVkc8Tc1PNwqL0sK4qLFoMUmla84eyWrTX5824gQsz9HJLwBbA0fs
 /2jHzDQk0ESuzh6Lel7D4zK+5dhSMLeVYuriwt2A3AbUsjhn/g5Tf+ldqA9YpQLxg0vM
 5is+CRDGgnk7neI0R89XjSD04MhCmx8QljBc1qp6L3KFMqkUTzqHZknzkg7P83twVd8U
 zUV4O//+VqUGd/TIsSA9F0sKqvWGFCDUY7wEuMgEmIDYgb30Rms4D8AdyOior3i5sVL0 tQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 31q66c3mmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 13:26:09 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JHLgYZ026082;
        Fri, 19 Jun 2020 13:26:08 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0a-00154901.pphosted.com with ESMTP id 31rh3evwts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 13:26:08 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="560532163"
From:   <Mario.Limonciello@dell.com>
To:     <sebastian.reichel@collabora.com>, <hdegoede@redhat.com>
CC:     <pali@kernel.org>, <y.linux@paritcher.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <mjg59@srcf.ucam.org>
Subject: RE: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Thread-Topic: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Thread-Index: AQHWPUx5kZ6BCWcrZkepA13uOwTuTKjO2RsQgACifgD//7DjgIABl+YAgAAPn4CAAAPSgIAPnq6A///ItkA=
Date:   Fri, 19 Jun 2020 17:26:06 +0000
Message-ID: <1bf60afb825a4a4abd5b4e6c278ac710@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
 <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
 <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
 <20200609154938.udo7mn7ka7z7pr6c@pali>
 <20200609164533.qtup47io2aoc5hgl@earth.universe>
 <136a06e3-0f00-d252-ebdd-a76c8a575db8@redhat.com>
 <20200619153103.k4ewdaljqubcrvvc@earth.universe>
In-Reply-To: <20200619153103.k4ewdaljqubcrvvc@earth.universe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-19T17:26:03.0514757Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=92cccc85-be94-41a6-a2ed-fffbb3b162be;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_19:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 cotscore=-2147483648 lowpriorityscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190129
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006190129
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> >
> > This is not so much about non-genuine as about the adapter having
> > the wrong wattage. E.g. plugging a 65W adapter in a laptop which
> > has a 45W CPU + a 35W discrete GPU will not allow the laptop to
> > really charge while it is in use.
>=20
> Ok. So how much information is available over WMI? Exposing the
> max. input power via the power-supply API makes sense in any case.

WMI is event driven.  You plug in the adapter and the platform will
evaluate its power needs and advertise it to the OS in the event.

It's important to note this is not a fixed value.
For example if you have a dock connected the power needs might be higher.

>=20
> > One issue I see with doing this in the power_supply class is that
> > the charger is represented by the standard ACPI AC adapter stuff,
> > which does not have this info. This sort of extra info comes from
> > WMI. Now we could have the WMI driver register a second power_supply
> > device, but that means having 2 power_supply devices representing
> > the 1 AC adapter which does not feel right.
>=20
> I agree. WMI and ACPI information need to be merged and exposed
> as one device to userspace. It's not the first time we have this
> kind of requirement, but so far it was about merging battery info
> from two places. Unfortunately no code has been written so far to
> support this.
>=20
> > I was myself actually thinking more along the lines of adding a
> > new mechanism to the kernel where the kernel can send messages
> > to userspace (either with some special tag inside dmesg, or through
> > a new mechanism) indication that the message should be shown
> > as a notification (dialog/bubble/whatever) inside the UI.
> >
> > This could be useful for this adapter case, but e.g. also for
> > pluging a thunderbolt device into a non thunderbolt capable
> > Type-C port, a superspeed USB device into a USB-2 only USB
> > port and probably other cases.
> >
> > Rather then inventing separate userspace APIs for all these
> > cases having a general notification mechanism might be
> > quite useful for this (as long as the kernel does not
> > over use it).
>=20
> I don't think this is a good idea. It brings all kind of
> localization problems. Also the information is not machine
> parsable. It looks more like a hack to get things working
> quickly by avoiding using/designing proper APIs.

When you have the data to populate in sysfs at init time I
would agree, but at least in this case it's not always
static data that can be queried on demand.  You would have
to wait until the first event comes around and populate
some kernel structures for the sysfs attributes to read from
at that time.

As a similar suggestion to Hans', what about letting the kernel
advertise a table of fixed printf style strings for translation?
When the dynamic data comes in the event can just be an index to one
of those strings and the data in the following bytes.  Userland
could then map the strings accordingly.

Running with this concept, it could even be an overhaul to your typical
content in dmesg to allow errors and info messages to be translatable too.
