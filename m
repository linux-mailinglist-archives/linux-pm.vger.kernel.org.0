Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0320564B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 17:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbgFWPuu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 11:50:50 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:13488 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732942AbgFWPuu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 11:50:50 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NFb6aR003719;
        Tue, 23 Jun 2020 11:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=wfGJi2x/cGO3hKFinFoAd7i+031gk+2rulG4DzOmBN0=;
 b=RWPIKmVcEeMXUcvWwErNfKTSNZWjQzoKZw4CIqkvMMdVFrJXhN++jU0LTNitPLPTR+AH
 2C4BoyRz8CWcqfQgXXpKyl7Ur9FLb8sXLLT/dHkxb8GKdnXXgzCJTwHLzab+7efuNGQE
 cjc5+R9UCELRFmunDjbayLnQvdcQDmtfukd4QT8kvxUaYk10sAeConPxp9BhJwm/OwIH
 z0ZPXWJgM9dNqU3hDMKFUuy/JI+PWLX/LbAR40Bm6vvpek0LnEhiReVNkhTaQog8KoZz
 CgFlNeLdHvh5jZkkwj2HziCZjwfgDVAQYHd9yjp/Cho0XlPnTRuljGUw8hoDxxpacmId Bw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 31uk320g6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 11:50:48 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NFkG4b040966;
        Tue, 23 Jun 2020 11:50:48 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 31um3g8my5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 11:50:48 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="514092608"
From:   <Crag.Wang@dell.com>
To:     <Mario.Limonciello@dell.com>, <crag0715@gmail.com>,
        <sre@kernel.org>
CC:     <mathewk@chromium.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] power_supply: wilco_ec: Add permanent long life
 charging mode
Thread-Topic: [PATCH 1/1] power_supply: wilco_ec: Add permanent long life
 charging mode
Thread-Index: AQHWSTdLlppOCCC6Bki6k0A/v494M6jlsVIAgACTARA=
Date:   Tue, 23 Jun 2020 15:50:43 +0000
Message-ID: <ecda5d3852af4a1a8c08e0dc07983f35@KULX13MDC113.APAC.DELL.COM>
References: <20200623082016.23188-1-crag_wang@dell.com>
 <6a804505400e4109906fadcf945edf76@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <6a804505400e4109906fadcf945edf76@AUSX13MPC105.AMER.DELL.COM>
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
x-originating-ip: [125.252.73.116]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_10:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1011 adultscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230119
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006120000
 definitions=main-2006230119
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Sent: Tuesday, June 23, 2020 9:48 PM
> To: Crag Wang; Sebastian Reichel
> Cc: mathewk@chromium.org; Wang, Crag; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: RE: [PATCH 1/1] power_supply: wilco_ec: Add permanent long life
> charging mode
>=20
> > -----Original Message-----
> > From: Crag Wang <crag0715@gmail.com>
> > Sent: Tuesday, June 23, 2020 3:20 AM
> > To: Sebastian Reichel
> > Cc: mathewk@chromium.org; Limonciello, Mario; Wang, Crag; linux-
> > pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH 1/1] power_supply: wilco_ec: Add permanent long life
> > charging mode
> >
> >
> > [EXTERNAL EMAIL]
> >
> > This is a long life mode for extended warranty battery, switching to a
> > differnt mode selection is unavailable. The power charging rate is
> > customized so that battery at work last longer.
> >
> > Signed-off-by: Crag Wang <crag_wang@dell.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-power-wilco | 3 +++
> >  drivers/power/supply/power_supply_sysfs.c         | 1 +
> >  drivers/power/supply/wilco-charger.c              | 5 +++++
> >  include/linux/power_supply.h                      | 1 +
> >  4 files changed, 10 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-power-wilco
> > b/Documentation/ABI/testing/sysfs-class-power-wilco
> > index da1d6ffe5e3c..1c91b17b6fd4 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power-wilco
> > +++ b/Documentation/ABI/testing/sysfs-class-power-wilco
> > @@ -14,6 +14,9 @@ Description:
> >  			Charging begins when level drops below
> >  			charge_control_start_threshold, and ceases when
> >  			level is above charge_control_end_threshold.
> > +		Permanent Long Life: Last longer battery life, this mode
> > +			is programmed once in the factory. Switching to a
> > +			different mode is unavailable.
> >
> >  What:		/sys/class/power_supply/wilco-
> > charger/charge_control_start_threshold
> >  Date:		April 2019
> > diff --git a/drivers/power/supply/power_supply_sysfs.c
> > b/drivers/power/supply/power_supply_sysfs.c
> > index bc79560229b5..af3884015ad8 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -87,6 +87,7 @@ static const char * const
> > POWER_SUPPLY_CHARGE_TYPE_TEXT[] =3D {
> >  	[POWER_SUPPLY_CHARGE_TYPE_STANDARD]	=3D "Standard",
> >  	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	=3D "Adaptive",
> >  	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	=3D "Custom",
> > +	[POWER_SUPPLY_CHARGE_TYPE_LONGLIFE]	=3D "Permanent Long
> Life",
> >  };
> >
> >  static const char * const POWER_SUPPLY_HEALTH_TEXT[] =3D { diff --git
> > a/drivers/power/supply/wilco-charger.c
> > b/drivers/power/supply/wilco-charger.c
> > index b3c6d7cdd731..713c3018652f 100644
> > --- a/drivers/power/supply/wilco-charger.c
> > +++ b/drivers/power/supply/wilco-charger.c
> > @@ -27,6 +27,7 @@ enum charge_mode {
> >  	CHARGE_MODE_AC =3D 3,	/* Mostly AC use, used for Trickle */
> >  	CHARGE_MODE_AUTO =3D 4,	/* Used for Adaptive */
> >  	CHARGE_MODE_CUSTOM =3D 5,	/* Used for Custom */
> > +	CHARGE_MODE_LONGLIFE =3D 6, /* Used for Permanent Long Life */
>=20
> Since this is normally only done in the factory context, can you please
> confirm does something need to be artificially done to block userland fro=
m
> trying to set the battery charging to this mode?  Or will the EC already =
handle
> blocking it directly?

This is a feature of the battery, when the EC receives this setting it will=
 be sent=20
to the battery and stored there. Afterwards any attempt to change this mode
will return a failure.=20

It's even better to block mode selection in the userland if long life mode =
already
in use.

>=20
> >  };
> >
> >  #define CHARGE_LOWER_LIMIT_MIN	50
> > @@ -48,6 +49,8 @@ static int psp_val_to_charge_mode(int psp_val)
> >  		return CHARGE_MODE_AUTO;
> >  	case POWER_SUPPLY_CHARGE_TYPE_CUSTOM:
> >  		return CHARGE_MODE_CUSTOM;
> > +	case POWER_SUPPLY_CHARGE_TYPE_LONGLIFE:
> > +		return CHARGE_MODE_LONGLIFE;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -67,6 +70,8 @@ static int charge_mode_to_psp_val(enum
> charge_mode mode)
> >  		return POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE;
> >  	case CHARGE_MODE_CUSTOM:
> >  		return POWER_SUPPLY_CHARGE_TYPE_CUSTOM;
> > +	case CHARGE_MODE_LONGLIFE:
> > +		return POWER_SUPPLY_CHARGE_TYPE_LONGLIFE;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > diff --git a/include/linux/power_supply.h
> > b/include/linux/power_supply.h index ac1345a48ad0..528a3eaa2320
> 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -48,6 +48,7 @@ enum {
> >  	POWER_SUPPLY_CHARGE_TYPE_STANDARD,	/* normal speed */
> >  	POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,	/* dynamically
> adjusted speed */
> >  	POWER_SUPPLY_CHARGE_TYPE_CUSTOM,	/* use
> CHARGE_CONTROL_* props */
> > +	POWER_SUPPLY_CHARGE_TYPE_LONGLIFE,	/* slow speed, longer
> life */
> >  };
> >
> >  enum {
> > --
> > 2.20.1

