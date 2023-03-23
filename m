Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7FA6C7242
	for <lists+linux-pm@lfdr.de>; Thu, 23 Mar 2023 22:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCWVZp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Mar 2023 17:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCWVZo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2023 17:25:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98E027980
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2023 14:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc9jC5zef/J24TiC+56TItkOnLKO8NL2bHiIvBAtkkY7z9ipEZrD9UAmVtkjcW8EXq3cZ/+kkyuGereIzXsoaHLuw0RMNDBfLfIBQvKv9mUdCPeWFyJO/7lkXIqOQNVg8A2/iCr8ZFm1e3mQdJHt6j5SoZrvGe0kxRk+UPPUJGzCbIAM7QTNp1Kb9OIhJdyCJDiSZcyWAESAHlkpphYDBm55eszZuXNI3vB37K44TyJQxQz7sc29vMrpY6w9D6pFuw72G397c+Xs0jQNLHhHjvUoF1/hZFEYeUGE4gQOSGxBkXbpiTrjZNK0ymSZC3jqUD+DiVE5CFmmvtWZPMmSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VZgUVJ993MBDUNQIGhfFm1j0fyEthRYJdKAscBsCTk=;
 b=H/KVcDHAG9OL5iNwO1BVlnrYb7MGD7MeGHoYFicGnn65SzOGLX5ftK/010rnSwnteN8DLMNnwS+w0Kio4HNg6CtSGcOBDK83FX+t/wFFPXvoJuKxyLKVUVmzVYuYCcyIXsjB454SX6Ox+jjtvgtxAC0mW3KWQ8rrkXctbpnDE0noXQMsfBehRU9rER9qVhHqept0QL+mp5AbroRWA9U6CwGas+yoeVK2L4l5QTFfTHPeWvz+yIDfsGd7Du3IjEtHK21GWtRRTAdSSH6+4ggFNKGD5Kp7Eti61Ksk5rGwXpUzmAnn/cnA0XwJR8LF5+EhpfT3nz6DsUU6B3xmi/hPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VZgUVJ993MBDUNQIGhfFm1j0fyEthRYJdKAscBsCTk=;
 b=tNRytaPLMuhsHN8/W+PDa5blk8XHGajNtrSABdoeuAU0VLQYr7W/bX45p169NvwGAYbCteRIy6kLXCNIlTNhnqBhsXCPzt9oN2GiI890erDO0Q7JNbEUh1J7Ta9aM6lQwS8BXsDQPL28NRHv7s5m0dVvjkqV348wr3Fptdt5rke1KhlP7f10/OctNQp+kIzwyRptQknAq1F037CAiTMyS4tjYOGsOQQ8pT0wvHLJc97XEwpibUoqT4T/KpcxYEFg37zPcVm7dd0SVGRg+xdK9LviAvdnxbhdBRxArrvpkXQVfESoJOr2EYdK1yHT63uVKWhE4sLj48FdFuoXfjV2FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 21:25:39 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::d228:dfe5:a8a8:28b3]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::d228:dfe5:a8a8:28b3%5]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 21:25:39 +0000
Date:   Thu, 23 Mar 2023 23:25:32 +0200
From:   Ido Schimmel <idosch@nvidia.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, mlxsw@nvidia.com,
        vadimp@nvidia.com
Subject: Re: [PATCH] thermal: core: Restore behavior regarding invalid trip
 points
Message-ID: <ZBzDzOWfGCXrsdaz@shredder>
References: <20230314155010.3692869-1-idosch@nvidia.com>
 <CAJZ5v0gKR6xzZUgATEMCGnAgtq3dGo-QyM372yvWqJPMu3r=GQ@mail.gmail.com>
 <ZBC+gUXyTsHHIX8O@shredder>
 <CAJZ5v0hiPqpN1O4fXhoORwmi3fU_5Us5U6FKxAoVJkvGAvn6HA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hiPqpN1O4fXhoORwmi3fU_5Us5U6FKxAoVJkvGAvn6HA@mail.gmail.com>
X-ClientProxiedBy: VI1PR07CA0195.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::19) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 80969d30-a48e-4a23-dd11-08db2be52640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etr0JiicS4LizIY75x8PDi2EYAAHvfUAodIlBU2HveUQgAelEcTMz8ONQvpHPJk3Xn4hZEQK6D3KzQ66BrbGgRMXvjLPkJ6tinHKr16PrfUZ/e/u3oq+I0qGTVRX/nXZlZJe3yCWsSqqeoCHpR47giESmDJuhkShcCC7/Vd6XPY8Hu5oz1D05cinGyrCqedpEtVhh7PoNs2B8WNS8kFjKJYbx36abQuYS8iWBOYTVnHdLZVOt2VAFmr4qWXZog1n48NgUP3cxy6A/ncMLouINcXaBMnDC3KEZniNE8F18L2Rq4Z960Y29rng2kfs/AVlf0gqVSW9mrOL/6/tstXzg6oPlexVRc/hTazw0EfWFU15bjFjO/ldMrUkuUMM2EaB1y76pqYD4ZHyy5Vr9+S/GeftSc/C8r5kKdoVF6Kq1p+pwcZCTD9i2+hhYTjP9sWumtuYRhEonqkngMHT4dxL3dMN9cWZOIfZJGkkfSbUlsLj4smgS7gT0WaH/rAVLTwSYVr/s5gOIYN1cLDJ8EYwdQG1l+7kGTFA+TK5rnrlCm2+FneDjm8/MdXYgvxxrLCjr2rHXNL72Z8ZtD5vs7gHQx8oq9HRCJbCAfkuRflglB0NZ4BgLN6Od66V7UXb06wOXzrcFbtBIJrcRNxn6d74CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199018)(86362001)(6916009)(66556008)(38100700002)(41300700001)(2906002)(4744005)(66476007)(5660300002)(8676002)(4326008)(33716001)(8936002)(66946007)(9686003)(186003)(6506007)(83380400001)(6512007)(478600001)(316002)(6486002)(26005)(107886003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hOgr5R+QbaLnx4F89UGqwa/75eNCLDDzd69P7R42OKOxzdc48OA6I4pTuzyI?=
 =?us-ascii?Q?i7vEXLCHqa7z9mIPslRCtnIZGnZ1u0U2aoMJXuKMX33aJaG3huEIKvHxveQb?=
 =?us-ascii?Q?ySkqEkf2J9+jYZ7o1P3TGum7dmrEePtvkyehI4YSARf8ccuXtf0OwtgJZvaG?=
 =?us-ascii?Q?DqlH4hH3V1sH77iX80vfLsB4kS3OohH7pKvTXFTfgX7K0cCTHbTybMfH6OAi?=
 =?us-ascii?Q?2Zrk2hkXonN9Hf02bCUKptyXsln6kHmLFmwgstYWYCySQO6jtcFSo1iPUI+0?=
 =?us-ascii?Q?Ha4hKPb5rv5Y6L4YFd7rTVg/UMmqVFksZB0m2kcKJykM6Ql3/52u2zFFRTpW?=
 =?us-ascii?Q?oLjV4hbU0+TDH50wH0MAaYWyso0jn/+pPKwd0a3lCRm++XGAJX2LgJuyWylQ?=
 =?us-ascii?Q?/jrkkJobwQrqQcfPEqHerwEdU+35yMtD1uaKOZjAkjBT9o1Bd6pfbFYU0LqT?=
 =?us-ascii?Q?8WYZTm0YlmaDt4kmKpmQtgwxA3dcSTxKltApnZmdSzkMwa+p3zoVp2aOtcmP?=
 =?us-ascii?Q?mcfw1UnQzJqdo/xJueJhHkgOsg2roYYgVNOm1IL1RE0spW9t6IvmQ3iJfa0D?=
 =?us-ascii?Q?Wj89CX87ejYF3zk9dKlqrIXrDkgKDJpMfqNvYAaUAtsv9Pu+nzTG7Tkggp1u?=
 =?us-ascii?Q?PFJAPuFEVBTs3NDtYxWrIAmQ5X093XPSJKHXJcOZDXQjj9KISQSnW2XUjw/R?=
 =?us-ascii?Q?EphIS7nfYWVEIF+4A10rwdSOwqY8dJuVx26AbY7ZhMA+qr+TXU4jZsf9p9kl?=
 =?us-ascii?Q?iVYxYQYM6THdsbUidhPk0XFiq9D0rVZHBzY0uX69a/D2lC75yg9Jvxkc23Gg?=
 =?us-ascii?Q?Utqnr759+M5pUdUzVBrCzrG7RGItdoWI2CRdxoJk27mEc5b8YRtmlnCcaeDd?=
 =?us-ascii?Q?+TwJG01/NpLfvv0adMLqJS1L30NIjNKs8jkzkO3AF1jZjknxTKuY8+dZXkYJ?=
 =?us-ascii?Q?/nT/+gF9P6+hLXgJJw6/OLvAqoR1oIr2miAdqfsvSTmvwMM1un423qWeSy17?=
 =?us-ascii?Q?PjawW1XN1tzMtAonAzWnSzbdwh/8Yn0Y22QAk6OB+YVq34jqDBpIQ48EK/lt?=
 =?us-ascii?Q?AGEm10iqcZk3q71hv6LtqJdnGaBs5LyfBiWnPO7ZuN75i2rD3GbIOFuc0KOv?=
 =?us-ascii?Q?g4nesGeIInLeELqnw/zGsMRq0ez9DSon7VQEnaJRGNwpQoTtiOD8F7aARyxC?=
 =?us-ascii?Q?U2O0JV81rf53Hh1hyz5zXSlogLhLb4F5q9AzZQ86mTaVhnsZwXf5LwPdDyXi?=
 =?us-ascii?Q?u1jkqFwqil/ANo3QE9N7XLfgcH9aa6p4YRPm/U02MuUeGIR3ZVZXYmN333Qn?=
 =?us-ascii?Q?9eII4pao3rODc0TVYLmIEpffprAzRW1ZS4WfxPaoXblG5XCyDM6vvJS+oZaU?=
 =?us-ascii?Q?mLG9Nyt/u68FPwUaTU2DHYz15RK0r4ElyIUOXBd2aBKBDMzJ38eszmihRcTo?=
 =?us-ascii?Q?MdgK3uBosLqLZODKC+5gOAWt2UIarMukYk82hBKMAYn1of0/JM7eqnEo9q7J?=
 =?us-ascii?Q?OgaOGqkV7lZOzSVNkpeF8fQJdPSVCxUogX+jVbdJEs0CRs0qkaBA3lMGL0Iq?=
 =?us-ascii?Q?52vpwh7/dZBgnOH81b3SoC/RZeD5gaCVCQ+x/TtW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80969d30-a48e-4a23-dd11-08db2be52640
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:25:39.4079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsZ/c5iTpIJ3gNnrt01gDiQBSSYTPMHTZkClPyHVMvfu12ayrVfJLsZGm1AwYwHARz8RdF5fa5sXGFHJXQZyYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 22, 2023 at 08:04:54PM +0100, Rafael J. Wysocki wrote:
> So I've applied this as 6.3-rc material for the sake of avoiding a
> driver regression in 6.3, under the assumption that we'll get the
> mlxsw driver update on time for the 6.4 merge window.

Correct. Sent the patches for internal review and will submit them to
netdev (where this driver is maintained) next week assuming review is OK
and nothing explodes in our regression. Will copy Daniel and you.

Thanks
