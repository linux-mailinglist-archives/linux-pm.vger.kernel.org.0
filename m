Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B84365603
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 12:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhDTKVL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 06:21:11 -0400
Received: from mail-mw2nam10on2062.outbound.protection.outlook.com ([40.107.94.62]:49109
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230264AbhDTKVK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 06:21:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nreLHs09Uyt+NQSIb6yY9rnPzIozZOKBgIgymMnJUOLGy2l45uZHM5ytlCbzZLBNynBBZtuk2OPfn3HoUfLWJgTpvRqT/xMI7pD3N4Nt+0vmo1t5jqOAWc39thns5A0WnmmmxKkl1+4fKf4K5ZJcx/mlHq52TbhccRXSmtELGHwN2AYtID2UZ47nmkRyzq1o/CfD7sHw5r3ReOsQ+Y1MUkYOpXpnRkDKFml0VNm+rl614/eTvAny5voOPityWNdcDyCJaOR56JMAjph6KtzVqOY3ktFtWeI3G91gBIMk3NtgsQ/2+giI8cpRxJOdd+eYPsgtVqUzaDxBc5DLrXk03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQUXm9+5GKZdOtDKVb8CyJmoOuu/VKRaTmPBqyf9AT4=;
 b=bvUbOyuf1bSaKukpMm5Ja4gjVgNNOkK9CmcfUrqnhAQAfKxLbsPq9fLYmeAO4W9vuIcHCGY2MYOG1wxHOvLnVjpN+//610oEmNJ5qY+/WHn/TbdhxiUTrrisAL5gh7DMdPfkgDRyyVUihthmnHE7tue8grf7hnD4t5boHJ6ksAxypRZE1PyHtcAsmEu9TgSN0fSOctz0OkjuxZy/hUO3gZ7SMkyxjHbWSDq/xeuBYFLg2AyFeNjfm79BryMQic7/fCl78RcLkDWIIDomNcyLbFRivCTaJCy4XAchx6iU7NrlG7p68pLbGdHc73xy09wduXbhjzGL56sTBIKPZ090xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQUXm9+5GKZdOtDKVb8CyJmoOuu/VKRaTmPBqyf9AT4=;
 b=0qVIkkZYemrLdu8E3ej9xmNxhTNd4gyAUgKTOTHI3LsKk303/9vJLnImtuZT+DCrXJ5SdhY3frKdZTSy2qGafLgeA+fMAtJetlg+eLgfkmziRW7xmbBhaL5oeckUORUWV6CXvoZFhmOuVIUUIVS0Hn0aSCe+7Kg+iapUA32HPkM=
Authentication-Results: bugzilla.kernel.org; dkim=none (message not signed)
 header.d=none;bugzilla.kernel.org; dmarc=none action=none
 header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Tue, 20 Apr
 2021 10:20:36 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 10:20:36 +0000
Date:   Tue, 20 Apr 2021 18:20:27 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     bugzilla-daemon@bugzilla.kernel.org
Cc:     linux-pm@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: Re: [Bug 211791] AMD CPU /proc/cpuinfo reported max potential boost
 frequency instead of actual operating frequency
Message-ID: <20210420102027.GA404763@hr-amd>
References: <bug-211791-137361@https.bugzilla.kernel.org/>
 <bug-211791-137361-FWoWFhjWLi@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-211791-137361-FWoWFhjWLi@https.bugzilla.kernel.org/>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.10 via Frontend Transport; Tue, 20 Apr 2021 10:20:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11e9bc34-814b-44e6-08f7-08d903e5efbc
X-MS-TrafficTypeDiagnostic: MW2PR12MB2586:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2586D8313054A42D43DD307AEC489@MW2PR12MB2586.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HSZsz/3vgTnzS/cjGhE+xu0xG/lrZmdZeFDUrYZdcWLjtbjEeHB5RY1tp7J9RObeukMW2olGhQpnfMq0HblYoT5Pz5fp+Q3rc5dhpOoV+KmaKqvJH9De/CLOOZgnAgiavTVgmc/09wVn5LFAuNTPCD64HqneZu5rL9yPPg2voUt8KmgPBtFGQRd+e68Xar7dre63Gc1M2CDKPCCyCUcYAxZcKgpHrT7M81yjymn/dSas4ZWpaqDV7wwGDQ9ajjfiFbl4yp6o0FFPmgwr3zYfkOssyhsYz0FXUYiqSqlrXJx/rvLbgyp8yvtoiUJmb/K7D8HWgLSg1QhTxlSGXfQzWEjyccjdFEAa1sIxm8s/MZX8MkffNVqIfySqz6jTnMJiin102Jr1pMATjJjG+gByK+dY67xZMpc308DeGSzHCbnmgZ5wmmZW057R4zE18EjYtFu5JpN1+8zy1Tfvyatk7QfZsLHcH+RoaGd3B1/GEWCX//w6JLJ6ee+cyHrDtZAoYegYL58JxOs9Gr+KX0UfGgJjZr1U3UnJvqdkNRmSr6aDNYGep8ld3dEoX8BIijpD4pKXbcRHuDAR8qnuFPSXpp9+WFcPtk5CXiNTRaLhocXeNKfTpeLklI3OzJJMbW7x1i2R/qnKi5QtFXqK6fU9BoJ3aCPBDcHedFszokdNaYngm+F9pubNK6q+WKstDn0Q1b2sLHIUrIvpWt3dclkqWf+t6olPmp93PVOuGiUqhfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(6916009)(66556008)(26005)(86362001)(66476007)(33716001)(33656002)(4326008)(45080400002)(8676002)(186003)(966005)(66946007)(16526019)(8936002)(6666004)(478600001)(9686003)(5660300002)(316002)(1076003)(52116002)(956004)(6496006)(2906002)(38350700002)(38100700002)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ueajZ8CeCXKWiEvkU+gppsWY/4z5wl62VzmLoiAGK4ko8/sj6ovjfycZ1UXB?=
 =?us-ascii?Q?VZsBEIXsMnsqxHq6OuDYohEcLOJlwIxjo+eqEZk3YGC3W7k+/4yYbjzaCTwm?=
 =?us-ascii?Q?PZ4NxYqc2nnE/wo4/POC0uzz2JP9qyReg0CdB8hatMZFOcPs/HsM362bsG6F?=
 =?us-ascii?Q?fcADVFFrPIm5q2ZZ6qPx9hdDpJkDYx1aHkek3ulFQ+tq2wIPg+dQTHUVvCm3?=
 =?us-ascii?Q?hyrRG2urrzYn3dDusMHoZ+LfPIea+xIHtP1ywQ3uFoWhPL7TDl+iF1RXj2aP?=
 =?us-ascii?Q?yaoKok0X1n+RlrAu9xALGcFxdeGQ5lWEJYaqZHksq7B8sMhvyvZI8p1kb9Jb?=
 =?us-ascii?Q?j1Lo6whocXh56z3svLO3zgB6iYpR+BdWoTwtpWVyVweMRedE/ad0SMaiS3on?=
 =?us-ascii?Q?g/pfPfgwmW5WRaWPhE2Uh22CFvR+IADHBNf/zztiYPT1n6SMB8zH09/xR5Nk?=
 =?us-ascii?Q?5BlNomhBlGIPlm9rlqXqEgoK51kq0QUGSHcaZlhyPVWX9M+f7EkNBhxXlFeJ?=
 =?us-ascii?Q?vDS0PDt9mT60IlhyY/xI+P1Yt2NKgreodfjE6uCfSacTn/3tKX20fLSj9iU/?=
 =?us-ascii?Q?M39WXLnmWLhg/C2Z/HFfPkKNy0Tuzf6A/5rCv7kucTDCSRnG9X31IbIRT1Ur?=
 =?us-ascii?Q?mbzyV/UnKuQD/MplIsh1lPwgXHwcyJ9pZIHQZ+vdXYHGbE4OPs+tAmZZRp2u?=
 =?us-ascii?Q?V9yIRaO+GSeoFIIFNbwYFWKDjRyYyugTH0usBaWirC+/CMfGbiPc5G4OUNpG?=
 =?us-ascii?Q?+oRzrbrvDN5vRa8aQuuoI0ILwf2znVe5JX5lU5xJ5qpK63YntYBDGMFB6BVd?=
 =?us-ascii?Q?cG6439fRJx3KWgLvBMmnsga7UZw9bJ81LU8hQY5c49FVU+shrmSkPRFvZotA?=
 =?us-ascii?Q?Y7a7rfok1/zghgnSMVxUBTsgDXvPQpSV4r7EJ4N0+vTVmTey10VRI/b1Nlca?=
 =?us-ascii?Q?yA2fQK/14bZmApBH6l5n9Z4JSrFuPc9i9reITQDe+ieui5HE7+kxVhUB8UVR?=
 =?us-ascii?Q?udV47mzh7rl8aeVbh9SSiKcZesRPVI308OL3L3+LTn9iItN5GjrcjP7o7rAW?=
 =?us-ascii?Q?80HY6k0vbguYRHZWnzgqpBK1mS0KMXmVXkMZmQ4NGywkW1dAWtshLBzaS2Vy?=
 =?us-ascii?Q?F8Me4lFIJALm1hhvuf/lNcdAAgZtIQKjSiS31v/dutMcCWPfPlOOxz8KPmHz?=
 =?us-ascii?Q?NU90uuoGen/h6YV6nqKexg4RAJ8oP9UtF56eEc3eVgIQp7isMiMlDYYjVwUT?=
 =?us-ascii?Q?LEy8TFD7YjtAZY7+6NiI2suqBO6a9xJi6hB5u0ecOSXxzn3lbIUD8mo/wsdD?=
 =?us-ascii?Q?ZZxaUc0H1IPYhpomavAu5UjQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e9bc34-814b-44e6-08f7-08d903e5efbc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 10:20:35.9275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dD3jLt6FkNZyc9OEbZL39DI/8NqJKAStREVMlnjuJTDyMA95dknHX/oVTI0p2hVXRiEES/mONHgAUZiMUCNN1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2586
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This patch should fix the issue:

https://lore.kernel.org/r/20210420080943.1045886-1-ray.huang@amd.com

Thanks,
Ray

On Tue, Apr 20, 2021 at 08:55:00AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D211791&amp;data=04%7C01%7Cray.huang%40amd.com%7Cc3e664b79fec434b1a2208d903d9fc2c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637545057044777992%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=eoZS70ZYQ7Rvh7XUNBL%2FPi4pxALBsbOyic6QnhOL2Xg%3D&amp;reserved=0
> 
> Eugenia Campos (rizwanali.462371@gmail.com) changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |rizwanali.462371@gmail.com
> 
> --- Comment #3 from Eugenia Campos (rizwanali.462371@gmail.com) ---
> Maxilla and all joyful end is placed for the founding items for the citizens.
> The show of the jump and https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.essaygeeks.co.uk%2Fwrite-my-essay%2F&amp;data=04%7C01%7Cray.huang%40amd.com%7Cc3e664b79fec434b1a2208d903d9fc2c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637545057044777992%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=NOvSMR08NNdIOik9fqcy2PE4IP8LDYQOB4SZfjx3Nlo%3D&amp;reserved=0 is
> shifted for the takes. The mode is pushed for the hope of the shows for humans.
> 
> -- 
> You may reply to this email to add a comment.
> 
> You are receiving this mail because:
> You are the assignee for the bug.
