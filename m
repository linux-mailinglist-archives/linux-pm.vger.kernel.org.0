Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFE7568AE9
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 16:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiGFOJc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 10:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiGFOJb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 10:09:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E2F18B39
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 07:09:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266E4adx009659;
        Wed, 6 Jul 2022 14:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Ju333EevykJC+oO5GpKD0IuVeKHmhu3wjVKTB540CcM=;
 b=X5eu8LslX4k+aTmXhpc338EjblrF8Prx85G5WVDPZVlwWPpssqfW398xSPwG04g77ca7
 3eTDtmjDnD//wxnh+ypE7TB9CpRDBNaf7lqbVG6UWfpSti80aupcr6b22lRpQoEDUsvE
 RzUD6vetTDmttK5RatYn15UPZMI1lgGKFu0GXlP+3QCX4PW+tdwcg/XHRrXdzRpaXYQo
 htHgasj7A19cjIFZ/Bg5CYT/eHwUkgXY+KDCENgCpuTgOKJ8y+nLfDZ2rmW9joD6UMGL
 vi9Uk3aJ804CiQ37XQYZ5ft45Lxch/iEIwNm7wzHm576rbvZEkYTC/i31AZ00uelkXNr qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubya4aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 14:09:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266E5qp4003889;
        Wed, 6 Jul 2022 14:09:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4udekace-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 14:09:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k12Q0QURfq+B9tUDqOPWulbbsqmNoUP8MrsPkJLiayOIzE/6gmglJZ5JU/JN0rtdrotp7Vjf7/kG2IGy85U7N3EcSwyhYqHXdUYEyOvWPQyVkA6GrWdTmOIFfkpRe7vyjzKzMvN+prqF4hOIc9w/PUsDZnPXPgTLiL9mWh52RGSICMlGId+ljDVffg8CTI16ZbXcGlmEBI/RrHfIoCzOa0WuX4hbsI5ndJsFHrd00VieYKmscLjTXFJly1pC+WjkDOdKUgAt3DZwoa4PJBg+v5p72DZdhDOs9oD2kEpcB2edtUDpYjFGj0O/akw3TfJyyG5iOJN2S654w2UCaxmhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ju333EevykJC+oO5GpKD0IuVeKHmhu3wjVKTB540CcM=;
 b=TRsTsiyqmV15ZJTRSxyg5TF34G//tYO3invjyXBWJvJT1qnUCavCulzNvjsDeYHlvoqNothZ/T9CN9BkgMX49A3DyzyTAlJjE6TOtXApoUUFJAuXy66d/cih+Wts0e/OsYcPaSWJGqR3TCPGwcjjI0utxH8Ni9kaVrMsKBJGmtBV+4RU2W7Z/UBg3n9j7xRoVeVI0UbkKJ/VB9kiYuq6yVOQohzJLXi3F4KtO78uYwjzOj0CyLHZNdc5xw0dgnbvutpqcdQflhx1F4V0ZDMrAJhXpZQmne4RJHOk/70vB4lvNBS5zeim0VcHmuTxoDpHVaNOYLAtsyyULpyxjdGL1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju333EevykJC+oO5GpKD0IuVeKHmhu3wjVKTB540CcM=;
 b=FNatv7vaIqzvGHgVFn8AbSdgxGBj723iCELYyJ4v9Vd7GTP9Ep8KhNHr6AGXHOzA/lyBQRMM6qN0J+bk53LQidFLITDOxBkXOLiUK68JhnlGyEthKFA4R4NhSZnxbakdOchScsIOp5DP+Wu3OgY/d6jYk7R0EYWiAFGpUjGzJcA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5514.namprd10.prod.outlook.com
 (2603:10b6:510:106::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 14:09:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 14:09:23 +0000
Date:   Wed, 6 Jul 2022 17:09:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     cristian.marussi@arm.com
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] powercap: arm_scmi: Add SCMI powercap based driver
Message-ID: <YsWXievahG19PODw@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0154.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe39c729-f562-49e9-9995-08da5f5920b9
X-MS-TrafficTypeDiagnostic: PH0PR10MB5514:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8V29JCBWwNA+hITimiRM+YqEJDuYYI8pXaDleul5aVdtOIZghSrHXXGPcvRg+VNt8ZRvK+C67SIIJQdx3E3H3Mbed9kKH0q1J+voT9V+aM46SwJnJZNfLTGPsmngTA0dGUSetNH18boIDNsua5ocXTedj5OAFLLogefxxPwee9+/Tc0CArwhy+gsHPEiIGpm7bAzdodJ8zPOT0XKCnDmJJ3EKU72zDkRd+ia8x7SlMI5YKinQAmJH5i9E5TbryLFYOm5eJSSGQhhFup+J52PO8eF6iKK73b98VVQINiZ1WgrjkRfgZZUAoGZI7SX31Hmy7Pf2fWnfqW0zI5+3I+idxWAjq/9nwWV+mfmM8GSgx7zMblkFDt62NcvRhfjKul1pex5AeQaDyl1+5wzxizWs46YLv9ixB2aH73VwjnI0qRwLhoJkj/D2J6UI9cSHUTGw18yJR6136U/5ILyOgGzCKcj7OfVuDIwjiHyUAPwOIunQ0bmecF3cxBQ+bbua2EiF3oHOHUQvyq+vvzBUlzm1qI19UbXqKuD8EBxEMJIFfrd3HMU/4P73hNUXtLKphngoQu/yqtuKCGOa0wol64J71AGqaVPL4+yt4VQRtWvHB/K3vgGmW5kOgexjnrvYyNubDew0+3oqvg/MbUDFb1CTijT8auB1reZR1jN8S4UJPKGa1hCVqDIsx1lN/5nJWRJotm39N+rAncXLcGn7vIczLTB3/5benhRdKk65b1Iahmj+hBshNItbnILwQ9aoz2A10HsLZGI/Z+wxTVbP7nfy3uSczfXV48dDLIznxdWWYCITyNaWUZi+smgTL3939s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(39860400002)(396003)(376002)(136003)(83380400001)(186003)(8676002)(66946007)(66556008)(66476007)(4326008)(86362001)(478600001)(6486002)(5660300002)(44832011)(26005)(9686003)(6512007)(38100700002)(38350700002)(41300700001)(6666004)(52116002)(2906002)(8936002)(33716001)(6506007)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9PIneneFQVo26JsUJ5fhH9945HYASKBQ2P9sYqbDIs9fFq0iLDAUkkMrV1Cd?=
 =?us-ascii?Q?tcSeB5XnMzPJy51YAGWxD+16TKGTl1jJwxsEKV1t1fCG/0AkrLNI5YzcqkiW?=
 =?us-ascii?Q?a4hn7/C0VdT+0JdALpN3WsscQJYqRScwUPi4i766iayPm1ad3StTyY1hv/XY?=
 =?us-ascii?Q?TIIBM+GKACDjO9ZO5MZAxvIXS2vDAE+Obowg52evI3AxBxS/fIj9rCChhPlS?=
 =?us-ascii?Q?KsxQSBmYDzLSqxvhM7FG8imI/uKRjppnZ75oLoA1jioQnMG66O4YH3a07Yat?=
 =?us-ascii?Q?dACcD1+w09ZX+RHEITXDhJ3t3XP+rewCOPCLXhkwNipeoOiWWIEaI+NGONJI?=
 =?us-ascii?Q?9O94bX8/Y1ckzn9P0XMMJL4gijlZYGuRmf+yXdvqwGGpTHCvQyDgxYm7jvFs?=
 =?us-ascii?Q?5VNbwa6va9WYeR7MZEiEnmtphsCWEyWrXcDlliAiFvcvpxtSeAZVqDmMPOph?=
 =?us-ascii?Q?NBWrO5jtNbIrXTf98gxB0h6mDW10v5iJqRs+UoNKfsiTUPQW4QCNeJPGAbm9?=
 =?us-ascii?Q?6q+bE73woCDkdII9g5Kq0HgWBUqG2/M7giTBAu0EiOnJOdMawr1WWAq562kN?=
 =?us-ascii?Q?4JtIylwhssFarKSgWQqBV0NT0XAE3qdSZi4PIZsiH1Hcnq6f4+mBIrUmlX0g?=
 =?us-ascii?Q?EEV8uTrEByLCFTKGRvzrTmk9HoBGUkTdWAE0qwBzVzAwMTh95zByGPVbayfA?=
 =?us-ascii?Q?yvQCMqxjUWm6OdeakUv/Ju8tNBfiH+LAcs9lU0Teu47NefpxOaB1QTiaN1UE?=
 =?us-ascii?Q?pwEi4uO8vKl68ED4/JrwnOw6m+BDSMGzSr2qhpzkXrOxDGpcuWk2JBJjK5og?=
 =?us-ascii?Q?ZDoSdd9xRN2v7mIcQRD1BbgoHDdJ+8BTemWsIbXOiFqgXqwJXDz7lPE4ICaC?=
 =?us-ascii?Q?mFtUeE28Kezam+8Orn+mg6Rwn5TfyhGKc9hrUOf+leK2QAlKtLSfxaXeZvCR?=
 =?us-ascii?Q?OoMInvmBeUcqUGOOIMwp+cNDrVPMRx66QM8cvwRacS/M/pr1h9lx4/zsezl7?=
 =?us-ascii?Q?nyd5IrZGL6KwQZPzz5bhzj5lFgxkhatx/vXbGbriEMoptLcdHqTEVwgwFvtX?=
 =?us-ascii?Q?xFUOs20zIl4yHX+YRDF/U00AYisAQyVUxH0zW7+jBeax8dznbAxpe7cYkDa8?=
 =?us-ascii?Q?G3H9vgzTpyR8N8OpZH6cj9GhnxjcOjFb82VpJ6hWo0oS0KbSpjZS5DxqlnSW?=
 =?us-ascii?Q?+diX+GQrEAEJfDl99YdGfwsw4+ovL8zPUW5qzxdXQbmH/oFwwqmF1y9gWzq9?=
 =?us-ascii?Q?m7voatfh/Jgh+htYg+LKMrRLBk2RfTdk5D/3TgH+jCnIpzWQahru31djZE75?=
 =?us-ascii?Q?/sh4Gq/iBBd1POmlzGoauCMS6x/Npa2gcmn6bN2TLRsEgVQmUfyHqRj8kDAB?=
 =?us-ascii?Q?0IPzGSL6mfINfuwvhK9qascvQVVK7hWcLg3MB5cHg8aE1afFbqJ7YAq8HSRu?=
 =?us-ascii?Q?Z1RRnf1e8Ge59hL2h/RR1XCcWanX5OQOonAcWKLLdqmK9CNRdVQYSI9d7abk?=
 =?us-ascii?Q?GM4HSk8g4b3WLnA4hMuUs4EYsAPrT3ZTu/kskRpOMzYmOaYvgOimX3aLpB2Y?=
 =?us-ascii?Q?7pwZZbMYfdNYAHFiTNjcVYzKiS5SKXL4qHrbj2QeYbUVB1eXDCNvSZOrfZCl?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe39c729-f562-49e9-9995-08da5f5920b9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 14:09:23.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +W0VcIi40oaoz8+jmfJ5QhAYgmbEwariTP3qDuEjURp05sIwrA2AJAw2GtbLtPIwKC/2dKJiayvUZe/2T6C/PQlID0Nw4CUh//CqRW/GOUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5514
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_08:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=526 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060056
X-Proofpoint-ORIG-GUID: E4Dvrh_z5Yr2djvQzVq_otBZiHHZjI1V
X-Proofpoint-GUID: E4Dvrh_z5Yr2djvQzVq_otBZiHHZjI1V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Cristian Marussi,

The patch 31afdd34f2b9: "powercap: arm_scmi: Add SCMI powercap based
driver" from Jul 4, 2022, leads to the following Smatch static
checker warning:

	drivers/powercap/arm_scmi_powercap.c:214 scmi_powercap_get_max_power_uw()
	warn: cast after binop

drivers/powercap/arm_scmi_powercap.c
   203  static int scmi_powercap_get_max_power_uw(struct powercap_zone *pz, int cid,
   204                                            u64 *max_power_uw)
   205  {
   206          struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
   207  
   208          if (!spz->info)
   209                  return -ENODEV;
   210  
   211          if (spz->info->powercap_scale_uw)
   212                  *max_power_uw = (u64)spz->info->max_power_cap;
   213          else
   214                  *max_power_uw = (u64)(spz->info->max_power_cap * 1000);

What's the deal with this cast?  It would make more sense to do the cast
before the * 1000 so that it doesn't overflow the 32 bits.  Is the cast
even required though?  The cast on the line before is decorative so
maybe it's not required.

   215  
   216          return 0;
   217  }
   218  
   219  static int scmi_powercap_get_min_power_uw(struct powercap_zone *pz, int cid,
   220                                            u64 *min_power_uw)
   221  {
   222          struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
   223  
   224          if (!spz->info)
   225                  return -ENODEV;
   226  
   227          if (spz->info->powercap_scale_uw)
   228                  *min_power_uw = (u64)spz->info->min_power_cap;
   229          else
   230                  *min_power_uw = (u64)(spz->info->min_power_cap * 1000);

Same cast here.

   231  
   232          return 0;
   233  }

regards,
dan carpenter
