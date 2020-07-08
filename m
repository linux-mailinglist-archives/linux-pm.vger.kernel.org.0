Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD0217D19
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 04:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgGHCdc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 22:33:32 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:9550 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728530AbgGHCdc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 22:33:32 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0682W6N8011832;
        Tue, 7 Jul 2020 22:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=453WNEVLFenePlfQdxY9hmxsb8VTxEZMoti+bi0oWcA=;
 b=D3FVXjRVRIlT5kpdJcHZ62eTEIdMg7M6KZbZ9J5nh20YsALPvdhKbUJ44DZVLIcDiGDX
 AVkg//kdiqysVIW4lZd8DT3wUH6/ihKlT+IdtnRYcx3QcoIYXGu+XSTEuhZTsHHL0Z72
 pfUbQOP/dikj4OEM5DMNutlK42PyYkzosxvlM4HQkEAl+LB2uT6gzqeinXIhD7WDas9d
 WiocjcXUq8CGCAtWHHUKVPsqU/RvtAMTiWg9kDhB7XcTrtf6m9FJh14eVXdt3LVQYjuU
 zvXQ5ZXQObCPS/IK6gdV8pPVmdhz1PpfV/M212Yuri6gGeJM26Qit7yamBNUwgI2Ahvw aQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 322nskk4x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 22:33:31 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0682UfrB071097;
        Tue, 7 Jul 2020 22:33:31 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 3255dr811n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jul 2020 22:33:31 -0400
X-LoopCount0: from 10.166.132.55
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="518766826"
From:   <Crag.Wang@dell.com>
To:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sre@kernel.org>
CC:     <mathewk@chromium.org>, <Mario.Limonciello@dell.com>,
        <crag0715@gmail.com>
Subject: RE: [PATCH 1/1] power_supply: wilco_ec: Add permanent long life
 charging mode
Thread-Topic: [PATCH 1/1] power_supply: wilco_ec: Add permanent long life
 charging mode
Thread-Index: AQHWSTdLlppOCCC6Bki6k0A/v494M6jlsVIAgACTARD//8PXAIABEw/wgBXu6sA=
Date:   Wed, 8 Jul 2020 02:33:26 +0000
Message-ID: <2bb356e814f74fcc9ea6e86a50cc7c1e@KULX13MDC113.APAC.DELL.COM>
References: <20200623082016.23188-1-crag_wang@dell.com>
 <6a804505400e4109906fadcf945edf76@AUSX13MPC105.AMER.DELL.COM>
 <ecda5d3852af4a1a8c08e0dc07983f35@KULX13MDC113.APAC.DELL.COM>
 <05bbf37785bd44ce8cc8777f107b16ff@AUSX13MPC105.AMER.DELL.COM>
 <23e76b5eda0849fdb4e1ef8b81807558@KULX13MDC113.APAC.DELL.COM>
In-Reply-To: <23e76b5eda0849fdb4e1ef8b81807558@KULX13MDC113.APAC.DELL.COM>
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
x-originating-ip: [10.93.131.111]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_15:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 cotscore=-2147483648 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=627 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007080015
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=688 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007080015
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi kernel maintainers,=20
I'd like to request a code review for this patch accepted, thanks.

Crag

