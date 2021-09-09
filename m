Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D354047FF
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhIIJrs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 05:47:48 -0400
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com ([40.107.243.76]:10337
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230145AbhIIJrs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 05:47:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLn6jC9GBATI7CajF7XOl9nv2L/RC7q6zo/tCLCuWZNIGNowl56lcghlUUmb/mE+TEvyeOTLzvgP5hZJWad1sPZbNY8sZMy9ipg58VLnhd46zyT1yk5h/REJatQ2Drt/3z7iQbSEc56rpmnvu88gdy00uY2s7cw2KUPeIjGcMRshRZeJl+nHYYXdWjmyqStgvaAFKGDtfYKkXRVu/8yN7aR+T34g64PhOhGHK9F8g3YCdah9lBfauj6NMXdRACM5EK7/ohddSqT2UVhXVJQcFHePdILzNpLd4fYpZ3Bknevk88vBTftkZKDV2jQrMEa3JgrOKPZ5i4Eog0thHsZyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BU2VuCDQYyS3MqJC3JsnGsEp9mM4DdHBHoV7+JVGhS0=;
 b=i5yUnaMDdT1gW3pnUMk8MH0uVVGk62JSOcRtM4yUPQU/qrxwP84ddLVVeduqOsHmy1sS2UjpyIdPhBSR+tBTSmkKSngwnm32YY4hpwskhOkBLlbxQv0GOr6ie7/5DbGPssec+LNWvxWmSE/Q2Vh2Znji6is/XVHtNazuTf6gf4/nLEwLAjuJN/NZuX++fj4nbAwuRj6lj7HrmbA+9uHsiGX+2X74L6Bhbqt3tugqloYwsDNsHniMjTW2Nk6QrkvqjPavknnBXK2FgBi9VbuAi59YkgadYmkHpR/MK5K75hlGEdgmYM1rN3Z/ympTqKMTBdqkl2FVKvB5a7R1AGGTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU2VuCDQYyS3MqJC3JsnGsEp9mM4DdHBHoV7+JVGhS0=;
 b=JQdpr5i/vsUZLU22MJHmBDbRooHNE5f+70LGB3TnwrgtuqqTWTn1nXWJ1FG13knR6tmSEalH8lD8D3XHE+Egn6Q108ylhXPwMqsA6d9MfrJib7vrA0EW6wNnHhF0uFoZ5bWa0OmPMbH5nBSR/cY4VNPMTFLMsGXzul3Wc3b4CYU=
Received: from BN9PR03CA0401.namprd03.prod.outlook.com (2603:10b6:408:111::16)
 by CY4PR12MB1590.namprd12.prod.outlook.com (2603:10b6:910:a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 09:46:35 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::1) by BN9PR03CA0401.outlook.office365.com
 (2603:10b6:408:111::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Thu, 9 Sep 2021 09:46:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 09:46:35 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 04:46:31 -0500
Date:   Thu, 9 Sep 2021 17:45:38 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 01/19] x86/cpufreatures: add AMD CPPC extension feature
 flag
Message-ID: <20210909094538.GA3702717@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-2-ray.huang@amd.com>
 <c8c57be3-5a86-062c-bd5c-5132d05dde3f@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c8c57be3-5a86-062c-bd5c-5132d05dde3f@linuxfoundation.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbcb2fa3-55a7-455c-8b88-08d97376b6a1
X-MS-TrafficTypeDiagnostic: CY4PR12MB1590:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1590B498C043CA98A3D7526DECD59@CY4PR12MB1590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PocT39DiK2qq4gP40T8BAx5o1Ert2lrexefwf/157QcYVjGBj025Fzest0KNVVpX2WJAaMgegbixGEKZHrqdJnHjHvnRlpD0EDJBG+TGCEPoM5zdCJeGy0XriOCyyi2hUdfmL182YHh9mzqnjx3ormzJVLlDrtT3C10TF1IDDxWSwhge7qOHtQaOK7gxaGHYbTJkJ6tOznG0XZSZ82q8YvvVmjcQYo2GpH2KWsBHLlYCJJIz4Jbq1NxX2kRwBAHhH5F63vH7gP07TjOqQH+EmtgAEY3fQaYlb7D1hnFB5Ll07XuN9A6TSSSrAmjbydkW1hrU7JFEFroMIxHABkkP5BnYPic1XGK2Xqv/P2f4vbaAR6ZXGNc4D2dG3ubje3RvvLf11H1WcmM4R25tovW9QjzhZzkQYRhvUgK2rIEeFZTZnhBJMGLNruQIB36Yfx4cDEB1al7mGoXAxRRItWx1cYN3u3tuRG4Z5Vx8cdv/kXumzWH4xH9vYOXCArQEmz8/EDJe+1IQ9WXNrkzMn2PA1XL1LOYBKQWCf8Q++eWmf12p4ktSSJbdOZSR7xQzJHl9akZT+6acvoRGMI9NnDnwO+yFl1TT2fxm1aESTaz6spmj4BQEx6KPtaLHV9wN01LlWz6VFAZ1ke3PzVLjukuLjziA866tJJcWRCkFCE/rQ66dlwQuplWwDE0ZWCeqDaJZMEFzM0j3QvZfgVyP9eTFFpRSgjVpLCIs9lYTijAhvzs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(33656002)(336012)(316002)(47076005)(5660300002)(1076003)(8676002)(53546011)(82310400003)(478600001)(54906003)(86362001)(26005)(4744005)(4326008)(70206006)(82740400003)(186003)(2906002)(8936002)(55016002)(356005)(9686003)(6916009)(70586007)(81166007)(16526019)(426003)(33716001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 09:46:35.6582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcb2fa3-55a7-455c-8b88-08d97376b6a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1590
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 09, 2021 at 04:00:04AM +0800, Shuah Khan wrote:
> On 9/8/21 8:59 AM, Huang Rui wrote:
> > Add Collaborative Processor Performance Control Extension feature flag
> > for AMD processors.
> > 
> 
> Please add a couple of sentences about the feature and what it does.

OK, will describe details at V2.

Thanks,
Ray
