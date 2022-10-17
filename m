Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3AD601019
	for <lists+linux-pm@lfdr.de>; Mon, 17 Oct 2022 15:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJQNT5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Oct 2022 09:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJQNTy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2022 09:19:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA5936BE6
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2022 06:19:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HCufAP025462;
        Mon, 17 Oct 2022 13:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=g5/Za99LFdl/HWXk1a2SFpJ7Vzl3Q8K+fVGXDN2BFao=;
 b=l5WblotMmtV9Z6QEDPeVDRR+4f+mzCxLrjs6EKlemTMmGoN43dtJM7ASxYU/E8T8cWZN
 +BKp9yL6ZwXLGxivFYGNI/jMD70+ZM0Z/aYIUkAeSNrXuVXZkQ3yXRo6l3SwHIe+QJPc
 zE2t9oF7NFwHUzrKfkZP6AVYjV2oVb0Hppbwe3kKufAmdH0txWmLVFOzEH6L7KtVXe6Q
 wf0kEPFCu0goWi/Qtp4HKH5mjYf3Vp050a1SqpXgIiwPGR0tDfgst5nnmRlp9M8/r6Jq
 L1cMXz5tF2eb9Ju3Y6j2H2EtH132Qn51f80387tkYPe/2vQ7EspqdBCP1pmEL202pbdx 9A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k94s0rgnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 13:19:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HCXQwe019197;
        Mon, 17 Oct 2022 13:19:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0p2sqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 13:19:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw3v0hEJXAAEcaDwGd1gz71rYWgc6Uvf8qZAeVi10MTzakr7dCFZ5Wxls97mMtTxefX+YdKaR4QBfLejp4xqjv4Dxk6gnuckjSoShSPKG2QgQ2qy/CW/cutJE7w+LLcI4cj/RB5vfK4vj0qYBWPm8HjS726axxn4QiVertkVhpHQ3pyFIFZoZ90iJpx0RUbjpXfthbDL1KzY1BpaNnw2Y00rfs98Yb+L3PuZbeRg2PmaRZVAPvsQBkbBd2CkaGTwDLExXz2WK75ak8cklrHuosifupHu319Q0MpMqjwlC6/5ioWjdWTfOjO3JDOOLOrWO4NVbvqYjFSA21vkcY8cEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5/Za99LFdl/HWXk1a2SFpJ7Vzl3Q8K+fVGXDN2BFao=;
 b=TvmahPbe3w2tbu70i24141Ink50YXUhaKaRN4sCoGKGu56HHooZ/NyWRkBHSb0ixnh7qlsTom3J6jzfitTsrVh03FlO1p3lhSZsoEcHv8ki4GF9WfMI8QOb2Fefk/B2RiXyMDSXsOjj+wglUEELsFA5nn9EUb7piiQbaoEhZeMRfhaqh3VUegBux+ZBvT6asXhgyntEmX8XF+Vf2lWnc5G7+ku2XhIJ0m4xldbnMlZdaTVb+ZIoffAI1Mb+ErxAkhVA4JDt16CHh+AmkOKStHfz2aquUFTTN5qQfGke8tKHMSo0HZBy4NOupjWNvayoCujLvRxpcMDlH5dG9Y41BJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5/Za99LFdl/HWXk1a2SFpJ7Vzl3Q8K+fVGXDN2BFao=;
 b=MJbTqHQEIAr1gHWDupyrl34jVvu7nrteBETNh9AuHOuv5y97FXF5BlaLwK/q4z8DTAcClFCyDx9AYksVuNFsZ8l1b0MQTfhJ9Y9C/CQWvJjntRvzaBIrIVoJnEolfL9oZMXf5h3WM7+5Mjx3cW4aAmNthLxtfprUieT/9+DjEDE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4304.namprd10.prod.outlook.com
 (2603:10b6:208:1d0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31; Mon, 17 Oct
 2022 13:19:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Mon, 17 Oct 2022
 13:19:47 +0000
Date:   Mon, 17 Oct 2022 16:19:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] thermal: Add cooling device's statistics in sysfs
Message-ID: <Y01WbMOnqnA0riM4@kadam>
References: <Y0ltRJRjO7AkawvE@kili>
 <Y0lylQhiGdVGTM1I@kadam>
 <20221017093829.h2yiawwpffn67qme@vireshk-i7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017093829.h2yiawwpffn67qme@vireshk-i7>
X-ClientProxiedBy: MR1P264CA0146.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|MN2PR10MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac25f5b-4c4f-49bb-e96a-08dab0424336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71k131EjsEjLNHByF3g4iC87LcnLkeAQJ8NafKWuL0UCrzSzjc37Pp70Fcxs2sfvTaODNwhqtvOGmabwHI6CwSudVTjGJYrt15PAZi5JE84unX97dfaWP1HW/zeu+NdjNmM06ygUbuhivfaJiGeEAUzVtLUgBj3HSel4b2kAULsuM4WEw0jUMeCNa8YbHuxOpW+tihO8Mi0bTv1hoDPWsYPd3YMAgoqknZhgNSqeunnPXebkmqrM27pUq7fjOBY62NGtQ5JoyIuC1CRatV6IW46VbTFCGAVM8p3+bv4gExbhqywlf1VGp9l0ICuw1ez0faNQvUZyADDNrfd8IiBYQRLJRdDmmb0fqfIl2zfGFS4YR5IaoX/U7uN0oYNjxMkZaufaQ3RI3AP80BmzRrO+pT3A6x2emlEgsNeDndPutiXnA1bxcZ/YO0mw0f6YHFAmw9RI7ElFOyjJ6X4REQkoz/X3ZudTGqCeG8hLNbvNyfKqYdHsYn95gVgSchbLRMcHF1WIcMQeqTWSt2Ljl+mrBCEZemaqUGAhfGU+S+A9aJomnawZcU8u8S9KvfnR7V2uAOssu1TWke/STnxRgKpjFvq+6wev3gziT8yWPGxhlomPXMqyfJELqTWkL4F4Z00LqArM+iFPN83SQG48K/sdbtEpPihuqlEMpgCO+NysTTYLAjzSRqHNWuHTUVKGxWeB6+DPe3L+oO/xadjmM4xfTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199015)(6512007)(9686003)(53546011)(26005)(6666004)(6506007)(83380400001)(478600001)(186003)(4744005)(5660300002)(2906002)(44832011)(33716001)(6916009)(316002)(6486002)(41300700001)(66556008)(8936002)(66476007)(4326008)(8676002)(66946007)(66899015)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XhpqMgV0Yi7cQlZ9MFcIJwFZG2R/aJ/1qPmQ7ny3mGJFY5m91XYjgtyNB/te?=
 =?us-ascii?Q?WSJccbKAHoo0EQiYLG7xtK1wFAt9NikSywealTkk9SvjZwY9Gqj+IESI5Dy/?=
 =?us-ascii?Q?aSqZkXlqoWlnU9gdkdcLFThAT2yXqznhIVO+QSilgGkZIHv+h0cepEuPkvuM?=
 =?us-ascii?Q?Wn6VMc7NgvftMVzlFiqakKUO0ONUyvM3VEzXrTiXrciO64Je+CQmUr9HfXQQ?=
 =?us-ascii?Q?3RJPkBsLxBicfVJ4aPmfdr/2hf4iOa8VcP5jQEzPAyXi0S3sMuUbx/Kiq7uZ?=
 =?us-ascii?Q?BzLr5thcT29X3t9mvJjlgCXAbX6HW/Ay/+xXI2KbliBnU5VExcHiW6VEGUvk?=
 =?us-ascii?Q?PVdn4p7jzN8HyGnerZvlOeR4rZFjCDu34YTFykomSAIiY706uzOm9qRpQ4xs?=
 =?us-ascii?Q?atHnJxKPOR9hLAQT7M0XD1aCDB/5J3s2pQU+lg/T+JjkZObATejiLKBCxB7W?=
 =?us-ascii?Q?9dPb4EO5Ony3ZcsRk8DeexB6Hz245SSCTZ5xImAK2WcrT9QDsnjp6AetvoWa?=
 =?us-ascii?Q?J3lbQ89mpv7w9xupHCMYzMYyVDbZF8glj5roYLOFT0J+ducGPg2N2sQfPigl?=
 =?us-ascii?Q?nEnG3rI0NkCmsGEcPoLfIkTmr2z+/5xdLCybyCVZybEHOHHYAeSehj17EthX?=
 =?us-ascii?Q?fEi2TD/0mGFA8cD0EQuTSnY+Z8ZSyTUYZsKaW5jOBl1HAGSVDXBUNrvuC50t?=
 =?us-ascii?Q?ykkpiYkHn9Fj/dPdyxX9XVHpmQmQQ/EFw6lFcowXtlHjglGJF07p05Tuaxlm?=
 =?us-ascii?Q?JTbtZXE/lBBVBAmuoA5TJ1GJcwp5vuf4qRqZZF3bZK2+0k007yp8xt6zmuM4?=
 =?us-ascii?Q?MG5Nyu5Fce2k1L0cVuv7rhYCtS3HovtDkW3V5d8mhcYtJ7yWXcwbI6G9VTp7?=
 =?us-ascii?Q?IsPjy5ULRPmavAOyC80emRIjIYgo92JRsZVNvv1+b+eXXc4RKG9sRzZ/usPa?=
 =?us-ascii?Q?/XBIPBbidZDmHp9WN3313S/xVztQMcZKyguFJkpGBhyaZ0jOOcL3CbKePN6o?=
 =?us-ascii?Q?JjEhhgN8tfG9TIut7K/CFhKs+O5cYBTAixU2n1pa0vR9j2uYM2OZCfxsvUfb?=
 =?us-ascii?Q?L7O/jfuqRXOpNG4d11BOB/g2/MKw/V5erLYuvjOeVS2iqnnjYZQYokuyAISs?=
 =?us-ascii?Q?2p4XzHvgNlpDekkpmMHXQnWIYaVN1xsnt9FkblFXB3qX/GPf0VExq0elKohK?=
 =?us-ascii?Q?eE42S67spqp9FWomFtvF1WZwdTKLk+UErrV4X0qnrFJ9Og8Mv8ItqDP8Kbjb?=
 =?us-ascii?Q?N83jOrOLOPE/lnmQOa+xTG0rNtRXWI9NFYUr0mpILJmw9os4VNShzqai0g+l?=
 =?us-ascii?Q?uc+OAcSmyxCAecxpnGh4E5fT/Dcn3mzLD+//jdG3qNZhfk5sgzK71lStVJs8?=
 =?us-ascii?Q?qEz121Tx1aiL5trI7jw7A2q4YCapUoiagswN8IUyBTdP6oKwDCE24ENEqr+X?=
 =?us-ascii?Q?9WlMjvxFIU/eSkfQ4NA6XBn/gWSYqvFLBrqrDZd0kV8KqGR1kWcG+BcmRMoy?=
 =?us-ascii?Q?yo8cVF9f4Cm9syiL8InHkgu7VmG0KH8YoSgljIJsg7v9Hy4Pq5hZy4XXyCqR?=
 =?us-ascii?Q?lftEwO/ygVH+Br9ZDscWCsHU/I9zrga62WCCqy+fukh4BRGLyS/JOAuphO0u?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac25f5b-4c4f-49bb-e96a-08dab0424336
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 13:19:47.1161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urH337DkFlpUX5POHUivqU1uaJ7+owxJelYbMigEBe+SwN2e/rq7ZUeRniBVhRZNikRDC2XpHei5Y6ZbgM3nSaF2/18v12G3kM2Z6cqV/Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_11,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170077
X-Proofpoint-GUID: 1NTlapp21S2bw6vEOzOUfvCFF5_f__g3
X-Proofpoint-ORIG-GUID: 1NTlapp21S2bw6vEOzOUfvCFF5_f__g3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 17, 2022 at 03:08:29PM +0530, Viresh Kumar wrote:
> On 14-10-22, 17:30, Dan Carpenter wrote:
> > (There are some drivers which might cap new_state.  I only looked at
> > tc654_set_cur_state() and it doesn't cap the value.  It's always going
> > to be safer to do the bounds checking in a central place).
> 
> I agree that it is better to do it at central place.
> 
> But, tc654_set_cur_state() seems to be doing it just fine:
> 
> static int tc654_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
> {
> 	struct tc654_data *data = tc654_update_client(cdev->devdata);
> 
> 	if (IS_ERR(data))
> 		return PTR_ERR(data);
> 
> 	return _set_pwm(data, clamp_val(state, 0, TC654_MAX_COOLING_STATE));

Ideally it would return -EINVAL for invalid state values instead of
clamping it to a valid range.

I feel like -EINVAL is generally a better API.  But also if we're
relying it to check and return an error code then obviously that's not
what it does.

regards,
dan carpenter
