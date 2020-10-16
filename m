Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD25290957
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409243AbgJPQI3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 12:08:29 -0400
Received: from mail-mw2nam12on2041.outbound.protection.outlook.com ([40.107.244.41]:12919
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407825AbgJPQI2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Oct 2020 12:08:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGCH0APmghgOi6OwMMBI6Y3hlV1S6M+LlNwVGHSOZ4CQoYAjEbFv+pCJ4hgJeGPxEhDP7zieXqlDs8jV7Nr6PBmC6AqMQKbSOBHCLuBB0+UinFoeaz6Xlqaotx8RqldtnLumjqDR9v0K0JCk7ByZzEV3OuZoDyLMsMCIY8y0VoTBi8eWw+j9WJzJ1K5i0JWadZipgDA//JbyKdgMBhiXqUtwI73SD9YvLdx7oHD99pfFdGxEMZLc9W/M24rZcJjyyhutESRRcVACcqrwe/SH1ZPhVh3UJilTXucpGEo9Ny1AMdSBI6xCjn2ADP6FvYAXrpu/FQJmwKWlV+zgKeTeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPypsXyoaWfriDG48+4ErRc0Abe0MKq/FDiB4CxH74s=;
 b=WB10FVbAqOQBV6gmt11078VDXLmQY0DgaPC7WLHBcDSRtu5x7/72dvlY/8LAmeqB4v2yhn6VL+4Hu8diJ0dOnE4N7Sm49Hw7g0mPiXuCjX6VKbDdqO3In9VaYNhVEIeZSwZ26NB4aMf0ib27zLfapACcXaw6Wsns5rvHd7yjpIM3UAbKyFNSwHfZKHrqy9tgsyLVIVrNWbO+QgzNTAaxMBo8r2n5ltd2iF/l5H8g2quKykOq1yqTBjyF10Uu3BP/jVLJtNUFTwfsCkFwSKxO2kJaX9wE8zLKOq7TDL+hHexNjN5zEBthvmAFsVTPvtsxDfWX3uOgE17yGdcq4rr+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPypsXyoaWfriDG48+4ErRc0Abe0MKq/FDiB4CxH74s=;
 b=ZCmMqEQXk+7+UrskX5vNiCUS0kP0weRDXWxBprfhejbeVrUdhw/DeA/ue6vUNh0f0+dpdnYjeoSD+Pd80x/hatif20geF7EAgWlzP95f+grN4aORIRXIhHTmTkXR1Mw8OHK2PQBambN1Ao6kE+2/hZrsQwJ0aMXdkVS1z5Z4XBs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR12MB1607.namprd12.prod.outlook.com (2603:10b6:910:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 16 Oct
 2020 16:08:26 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::11f9:59c8:16c0:7718%8]) with mapi id 15.20.3477.025; Fri, 16 Oct 2020
 16:08:26 +0000
Date:   Fri, 16 Oct 2020 11:08:24 -0500
From:   Wei Huang <wei.huang2@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/1] acpi-cpufreq: Honor _PSD table setting in CPU
 frequency control
Message-ID: <20201016160824.GA63297@weilap>
References: <20201007204412.565881-1-wei.huang2@amd.com>
 <CAJZ5v0g3fzSHOjKhaF0Nof=81MkX_GF7A6NL8-=5gQgQVtkY+g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g3fzSHOjKhaF0Nof=81MkX_GF7A6NL8-=5gQgQVtkY+g@mail.gmail.com>
X-Originating-IP: [24.55.15.93]
X-ClientProxiedBy: SN4PR0401CA0013.namprd04.prod.outlook.com
 (2603:10b6:803:21::23) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
Importance: high
X-Priority: 1
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (24.55.15.93) by SN4PR0401CA0013.namprd04.prod.outlook.com (2603:10b6:803:21::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25 via Frontend Transport; Fri, 16 Oct 2020 16:08:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 88d75eca-68c2-49d4-ad0e-08d871edb6e9
X-MS-TrafficTypeDiagnostic: CY4PR12MB1607:
X-Microsoft-Antispam-PRVS: <CY4PR12MB160730A739D0FB295A82EC03CF030@CY4PR12MB1607.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2wS+E6AIosGfTGKuPXFAopgjMkEzl5l8iUCMGDhm8sbG8OcPvvZ94i47AqFfYCs018RfejQbebtjnnZSnUu69CEFs2VGetGiAXAKOz8y5lzG90qOBiTnLI3btfCO5ZiIpFdf5G8hJh/RNX9M+nWinAQRZQPRNLb31Y6kYHstnglbaNsPsYmbd/MaoVluLEI9PIZzVlsffyuaSytpAj9Bjby/p7nzEl286e/EML9R28cWbuLMP1QLfjVNQjSPJfi1ENYHGstqre9ooLYbBh0s1r4glXppuXyI+3z0CSjN3kWPruUk5Fdgt/26hpKDyrPH0u8nED6JYn80yVaFZjAUvq5jNJJgjvL4wMW8jdKOz71CthQLOK498AcphTvn9pq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(16526019)(4326008)(8676002)(956004)(54906003)(83380400001)(478600001)(186003)(66946007)(66556008)(6496006)(52116002)(8936002)(26005)(53546011)(316002)(33656002)(9686003)(86362001)(66476007)(6486002)(34490700002)(33716001)(1076003)(5660300002)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NfxD/M4YbD1ekVXK5aceCzCxx6SyHmG0F87jOg63vY/A7TX4YloAxIl5XUOrNavIMCQ/eVfG0+qldGzX8J3J6OWSIIzD4Fa27jEINCbkPlKXcSUL2sKLUwMu2wx7XjFAMvxjK0PO/BOShJ0PZqfX+cM0BimNfx4yxRXuUEs82TCBrmk4DKexsSXIs+injuSQrhBXMJOPAE+ZCTr9oPNitVW2FzSfpMALzffY6kKn2vROHRYH2APF8GomoqXGamonl5X+6/QZWqSNOBK/WDYgUl2P3TqXOLh3pTvl1j1LUOXQos4HsZUJAwuK90QWT18xORpvoUF/aorxY984ZJi4UXLLJ5dSzyXAUCkEfFOcpHKm7rlXOZ1ucyOnEyikqjDyrPp/EXZLhma38xbgOqy/WJN9vJDuSWMou5ejqw2JyaKDyD0iqmgqDRsYUVJTgTSyFvBW2mQAnKaEqloNiZiA2p2xVskS6L1ZkgGUpgpT+KWvzZm+QEDwU8U6p5Xd7Y4K2OfN++vctt2BWqexKjZMoNxfDxBBbM3xEOWs5FbCi7z9UUwMtIkw+ISXcS9Fp+2I6UonVbAZUnqa7El/M6lVwVB//7xCVonoiez4HSpnaGp2t9oT354FwhrI4R+ysh5h7uuRs8gCkWrIIroKujbz2g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d75eca-68c2-49d4-ad0e-08d871edb6e9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 16:08:26.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UMXrAKExD1LaMFSGZ9sd1CCs6hAvFK0ciaY6XCfM9jNKc3XEnARjCNaI+gdNn2Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1607
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/16 04:58, Rafael J. Wysocki wrote:
> On Wed, Oct 7, 2020 at 10:44 PM Wei Huang <wei.huang2@amd.com> wrote:
> >
> > acpi-cpufreq has a old quirk that overrides the _PSD table supplied by
> > BIOS on AMD CPUs. However the _PSD table of new AMD CPUs (Family 19h+)
> > now accurately reports the P-state dependency of CPU cores. Hence this
> > quirk needs to be fixed in order to support new CPUs' frequency control.
> >
> > Fixes: acd316248205 ("acpi-cpufreq: Add quirk to disable _PSD usage on all AMD CPUs")
> > Signed-off-by: Wei Huang <wei.huang2@amd.com>
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > index e4ff681faaaa..1e6e2abde428 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -691,7 +691,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >                 cpumask_copy(policy->cpus, topology_core_cpumask(cpu));
> >         }
> >
> > -       if (check_amd_hwpstate_cpu(cpu) && !acpi_pstate_strict) {
> > +       if (check_amd_hwpstate_cpu(cpu) && (c->x86 < 0x19) &&
> 
> Why don't you use boot_cpu_data instead of *c?

Thanks for your review. c->x86 contains the same level of information as boot_cpu_data when
acpi_cpufreq_cpu_init() starts to execute. But you are right, it is better to use boot_cpu_data,
consistent with the rest code in the same function.

> 
> And why don't you do the extra check in check_amd_hwpstate_cpu()?

check_amd_hwpstate_cpu() is called at various locations. This _PSD fix doesn't apply at
other callers.

> 
> Also the parens around it are not necessary here and is there any

I will remove it in the next rev.

> chance for having a proper symbol instead of the raw 0x19 in that
> check?

Unfortunately I didn't find a replacement. Only x86_vendor has an acronym. The rest
(fam/model/stepping) use numerical values, including in arch/x86 boot code.

> 
> > +           !acpi_pstate_strict) {
> >                 cpumask_clear(policy->cpus);
> >                 cpumask_set_cpu(cpu, policy->cpus);
> >                 cpumask_copy(data->freqdomain_cpus,
> > --
> > 2.26.2
> >
