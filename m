Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB17A3EE4E1
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 05:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbhHQDSf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 23:18:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49552 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237018AbhHQDSb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 23:18:31 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17H3CfnW026153;
        Tue, 17 Aug 2021 03:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iK+yCxNDsDk/0pjq8/lGFVrGce4AMTADr2/sbhyZP9Y=;
 b=bQb7tz5OVjAJiJoUEnDmWglZLaoYBlMT15JWzcVbRUvZoj1Eq9/IawC57FkZ1XIaDZE7
 7XIUab4jXlP6rJ9Z1FnvGy+Y1KVw92ssDVpGlsn56nx1cVdOdd6sqTAvIUT52uETvROg
 VVpo0G8QGc4jCx22XHSUpfrdeXAsTVwjnokx29aIPlBAxped0U8O0bS5fYZ5ktoBOePq
 uq4tKbsIOoVtSi8WBfhyEhkXk2NbzPTtX3DHEsiN/OAxvMpK3oki+MEhdAhDx+37inaT
 h817DVoKUrq4/J84X7GvpSnAhnYztPcEyWGWHS+Xe9RxwpczyO7mfWinj/Wu/ekhyMLs KQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=iK+yCxNDsDk/0pjq8/lGFVrGce4AMTADr2/sbhyZP9Y=;
 b=brYQBcXwtCrLUik0xfbdGQZcNmDshRKg9uQEFHBWWlXbwh1DbRAT1e6bZ1/By///zKln
 LVJ+r5W707HzVZD625Ls0NbotB6/tbQ0Jti1qFqjSqqXB+8MrYwTRJFun6qx7ylc5nN2
 XFTdXMdvwzsLYCms4PjXSkMi7uS8c2bFLR4lViTDhnpbu+3dY6EnSEV66zGvLlu8lFVv
 IN7iEvQAQrPgJ/SInU54OIMbqh9V58cXeIIUY78umwwZRmTBx7OrkOr1KTd8u4qu816P
 n1DBBfB75K05zTUdTGcxb/sgxyAY3STX1RfNca7AP8wMVnCnvyqVcE+lEA8eo+8zNhqP og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmban62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 03:17:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17H3AxqY038849;
        Tue, 17 Aug 2021 03:17:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3020.oracle.com with ESMTP id 3aeqktadm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 03:17:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vr93iVyL6BAUcHiYBO7Nqpe7Xtht997mCLjkyNTHrMJfH0/aWrl9g8dMWI1fYHaFBF3Bwa3DjtJTydBII3TYGtSjsmbwZDu4lj4Fabzc4NsM6QOWIBvD1NKVOKML2IEU57WZYWAZIzPZCuUlYylUw41tDDMnYcquqtmAg+KQLxrZUrUgr4SJvB/r8BEbi+FmMUs7x3VbZcleMRJa74ayUSyLCaU/JGoMobc3epZbF5AcgkUe2YSz3l2WfwO3Agcq43tyQxKTvO7TB6OXJwAvCLb6ytBpdIkrD57Pee5jSOSiijYmC9Ap33rwOUSdvqzO05PI0W8QAdjPpA94M5bmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iK+yCxNDsDk/0pjq8/lGFVrGce4AMTADr2/sbhyZP9Y=;
 b=k30SEWeOWQknUs4jzPy1arnvVLkV6KLseV5amj8JTmnqv90JDN3+lgrJjOKyaUiIm13wVO9pIr0uwDFcGwbMzXzTxH1yTJcyoluJrZJ45jmiDU+lKUQDCnuFBZAMIY/tiDEPe3HdZ1EHP7XG91eXdB2hTbSuYFgSvU9JQ1y80VA1z4dwaKwORplHWRLdn7xZJDfacPnQKGdhLKu+c55E1gDOxLJPZdX/wR7mat+w2X99lTXtlnifG8aN/5gYA4EQPj6+FniU+kdZbk/d/4hpXh8iTyu/TIjeZ5hkmdm/SrVLF9UqmXgsRY9WezTgXH+ZcMFDoFS6lZEPolz1X1hhqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iK+yCxNDsDk/0pjq8/lGFVrGce4AMTADr2/sbhyZP9Y=;
 b=jbbyDflzEIPDeIPHGLIS9oXcAKTMBjRop9E40CwJYJnqfgZVWG8fhCSwI0PLDvPndwQshXoSctU+xrp2raj9zrwIAAqDzKAqumnmJ1nnAjMNcp0Vzk2Ma8B38Tu36mXHft7W8Q16uraPwlA3elUOzCTuI1oIhzS6323icbu2ZAw=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4566.namprd10.prod.outlook.com (2603:10b6:510:36::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 03:17:46 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc%6]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 03:17:46 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>
Subject: Re: [PATCH V5] scsi: ufshcd: Fix device links when BOOT WLUN fails to probe
Date:   Mon, 16 Aug 2021 23:17:31 -0400
Message-Id: <162916990042.4875.5784474271226040041.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <a1c9bac8-b560-b662-f0aa-58c7e000cbbd@intel.com>
References: <20210716114408.17320-1-adrian.hunter@intel.com> <20210716114408.17320-3-adrian.hunter@intel.com> <c78aac34-5c55-f6b6-3450-d5c3f09781fa@intel.com> <35b2bd0f-5766-debd-2b4c-c642a85df367@acm.org> <yq1czqrguch.fsf@ca-mkp.ca.oracle.com> <739a1abf-fca0-458e-5c8c-1d6ed90b56e0@intel.com> <a1c9bac8-b560-b662-f0aa-58c7e000cbbd@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:806:125::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.mkp.ca.oracle.com (138.3.201.9) by SN7PR04CA0178.namprd04.prod.outlook.com (2603:10b6:806:125::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 03:17:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 123e16e8-1252-4b44-d610-08d9612d9569
X-MS-TrafficTypeDiagnostic: PH0PR10MB4566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4566D6EEBEEA9BEC189D2B5B8EFE9@PH0PR10MB4566.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STqnS4BWfqk++wkRjyJ2JeaX/nkwtC+mcfgz8mdb6dXY1mVX6cR2Dm56V7qHPDJOhnhMr8P/EW68aWOdT8HLN9Jj7WEpy25Hd1b+xAInpAXw8LX4IzviER7cisVlaDodIMMYBI+Wi9w3H/5Me2TBXfisLWk8dpmt8Btz7OCA9/A6sGZOl8KYulp7gdmOpksas85LuS82wXBRSqeoE3wE0TtiIovutN4Nc0zibnfu+7FGfs2bnnMmcP4bPViyFMRLE239AGKiYgS+JAJ9/WuXqeOKPQ0AQkEMEpOQwHRHf93TNBrYNKJyDjpMTRzqo5IvnSchunnb4XwGFKFpihz8/VkhpHb42tc09ELEXqaRW6F8alh5s32UZgKfrDSzpzNY0f2ODw/8PTBfkqAdytPUangrlEs5O/Y+TEcA8EoPRTswiK1CW23y62qCVmnmYRlSsq0yB8y2DX9brF9M3OSKrFBa6YRCmD92evElihiS4/mCdqopXaI1HXVppGZ7x2ED/dwARlTVIdzroqMTsVewMb+BQJkJJ38yILLUdb5Kzcl/q/M1xj9wLke48yukbRFRATTwgpN2oOLCje5snuyHDFw1Xsyo66rGBNi/zeIhEaiq5garQNnJZ2JE30EmZeWkfPqnJfRH2NSRsxhOxhdpk3qj10h5Kdzzus79wqDCuVXp7lTDGx290B6eXPjPB3r/VU5gGQSrkmwQ5tywO9B/ZUM6IYveZ+qZVuRCs/PqWl7FQnIqBGhxW3m42toF4EltpdJLSrIJa1KBBefauleSyEGpyfvFTN3Xf8GjSQjEVCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(366004)(396003)(376002)(6486002)(52116002)(7696005)(4326008)(66556008)(66476007)(66946007)(6666004)(5660300002)(2906002)(83380400001)(7416002)(86362001)(186003)(38350700002)(8676002)(4744005)(26005)(36756003)(54906003)(2616005)(316002)(956004)(38100700002)(110136005)(103116003)(966005)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NCtXTGtnWmkrWjZaZnoraGZidzdNSktFaHliMC9LRDl6VzUrRTRiTzhJd0FS?=
 =?utf-8?B?RXFibFBhVkY5eXBBU3Q0TWJNbDVmUUxKcDdrU1dubGczVjI4MVNEbTNuTVcr?=
 =?utf-8?B?THVPR3VDU0NUNHpaZUJUS1RqOFBjeTFDdU5RQWQ3c3JWTU1PN29LUlV3L0lC?=
 =?utf-8?B?SjhRMVZpK3FlNWk2VXBlOE12cEFzenVzMjNib0YrM2hJL3lIZ0dDcm9oRG5l?=
 =?utf-8?B?d1RsV1M1blhqZkU2TWpiNkRjZnNDTVMrSWgvbmJuaHVGMjZBcWpqV0NSUkJx?=
 =?utf-8?B?ZnlmRHcyY2xhUytRQmVqaEVxRkExMVNsSGU4NGZwRUp1K3dlT1k2NFYweXNV?=
 =?utf-8?B?UlhpQkwrQm00bVNOQXloYi9lc3hzWjdHN05rTUpaUHMzSEY1cC9sTC9SMkJL?=
 =?utf-8?B?Qkk5OUEzb3dreC9zMXA0Z0JzRkRyM056L1NSRE1nUGdoMk50eFEyNHp6dFBn?=
 =?utf-8?B?UVB1M29IeUl6RFFjay9VSHgrREJ3L1hNR1pSTEdDMTdlUU1zYjNlOWp4eFFo?=
 =?utf-8?B?YXpJdnhzRENQWEdGaW5SRFc0SWFYQ1ZWWmVWcXpXeUl5dTlJcW8vUDlaMUIv?=
 =?utf-8?B?RmsyQ2l1SjBEWW5Pd1lkUWVqQUJWVVRyZWppN01tdnZibzhOTUNrZFU5MjU3?=
 =?utf-8?B?RzlGb3A4TDBKd0pDaElZU1ZCT1BpN01RWGMvNFBFTFI1R0RwRENUa1FDUldH?=
 =?utf-8?B?VmdFQjFCU21KNlJ6SkZ1ZGZ3cS9yN0dxSVV6aThNUUhJUjQ5R09mOTdFQ1pG?=
 =?utf-8?B?ajZzeVJqNjY5YnRtRDZVMDZnek50Syt4MzdMWjBzTzQ3VjlHb3JnbGRvODMv?=
 =?utf-8?B?aHpVbEVPazVtbjRFWG1vTkFNTlBxQkVIUGdjRFIxWUxRblhFbTh1NmYvV29s?=
 =?utf-8?B?dEpNSWtXMy9wNWQycXdoUytRTEVPNGZTdFNWN2RGcGdLWWcrRHNnK0lxZm5r?=
 =?utf-8?B?U1dmZkQvRVNrOXEwYy81R2E4ekUzcjRhc0NYMHNVaVNZYlFKSktuYjNnL2VI?=
 =?utf-8?B?Z1RITUVDOXJaVkxvajNKOFl6MXhGUDhYZHBocTltZUd6Ty9WTXFlOHlBOWh6?=
 =?utf-8?B?c2FFN3MxczlSaDNDQ3lHeHBpZC9tT2ZBNjBWTWg2NkNjeWZoS1Fhenh3NmNt?=
 =?utf-8?B?QmVIVEtiY0xnNlpid0g5bjVyTGk4Mm9MdmlGKzVnUjJHSmRIaS9QZGtSWFA0?=
 =?utf-8?B?bWlRRDVldU9lSktJSG5KakVETTQ4bGw4SitjSFpZbXk1V2d2NkpZNGI3VUhR?=
 =?utf-8?B?OCs3bG9GbWRxMGppRVNFVlJ5dWNRWlB6Z2NwNzBVeDJXQndWOUxvU1VuQ3FX?=
 =?utf-8?B?ZHVaS0Z6Y0ZaOXNOd0xtbEZqSi9ETmRxUEpZLy9SQ0d6bDlJbExqYUlCaHN0?=
 =?utf-8?B?MjNOeXIvMlViejdNTkFnK2huNzJFdTlZbXh5a2JUbXRHb05SQXYzNzhFYW8r?=
 =?utf-8?B?Wkg0QXFQbDkwTGk3WGFtR2R1OWcwSzRhLzNDTmtNSDFKdDRHTmZQWXI0Yzla?=
 =?utf-8?B?NldBeXZJMUsxbWdGemxZeG5aaHQySDlrbmtrNjZtWEZadVlaU0dnTTRjUjFK?=
 =?utf-8?B?Z3JzbDFSYWo1SHFCaGFNaHMxQ2hockV2cDZvNDQ1dXJKNzlEZkszKy9qRnJk?=
 =?utf-8?B?RFd0akJ2djYrVG1OWWh5eGMzdjUrcHoxUnVvcUVKWEluSWx6STNCMUFFcXoz?=
 =?utf-8?B?TDdJemtzNG9rS1o2MjFMUklhVXJoOG4rUW9tQW1IckJtd1QvZTRaVFNBYWll?=
 =?utf-8?Q?AE9EzYDkeWvXcQ7stoZ3VUKOSvZJU+K7aoLtuZb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123e16e8-1252-4b44-d610-08d9612d9569
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 03:17:45.9681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrfZexOdVS6klMrYge1couQwEhqNslfg2XtBBtZvkwjyF98SmzYETuPHCDSqf6DW9edSCdB/V3ZclmZmOLw11nl6BlcbRv5kPw2Z+xpj9zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4566
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170019
X-Proofpoint-ORIG-GUID: rVsyD1ywzLSaubIoYamODfWujyhit2eI
X-Proofpoint-GUID: rVsyD1ywzLSaubIoYamODfWujyhit2eI
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 6 Aug 2021 16:04:41 +0300, Adrian Hunter wrote:

> Managed device links are deleted by device_del(). However it is possible to
> add a device link to a consumer before device_add(), and then discovering
> an error prevents the device from being used. In that case normally
> references to the device would be dropped and the device would be deleted.
> However the device link holds a reference to the device, so the device link
> and device remain indefinitely (unless the supplier is deleted).
> 
> [...]

Applied to 5.15/scsi-queue, thanks!

[1/1] scsi: ufshcd: Fix device links when BOOT WLUN fails to probe
      https://git.kernel.org/mkp/scsi/c/bf25967ac541

-- 
Martin K. Petersen	Oracle Linux Engineering
