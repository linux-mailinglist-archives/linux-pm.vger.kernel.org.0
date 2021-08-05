Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153A03E0E78
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 08:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhHEGil (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 02:38:41 -0400
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:21216
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230183AbhHEGik (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Aug 2021 02:38:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzSSCqlGodjBy1+Tv7D/MB6NV/KNRA6BrkC7xFtv1ILlr9dBsiUIc8HnInF9C7MMHGFkN6KHjcqPzDY8NHt8+1d6p8HBsJL/ORYxUfggyyH+oXlkxLQyJifd3G0PbKb0ndEif5JA0+yyMKwiwqEp9DB0Tq0HNBR/eaSgr34wIMdoJsEPqKkPPd817I7ONPZCch4Z2oBwETazJksf3EWvnMC5/LQT4QMzffTnTg9W60v5TrY0oC3TgLQj5Lp+nbXYI7BWQxAJ14PRypCUXijqnuhA7NBT1Bm4fvZgKdFQa7Rrho+20kf4Q15Q7KNFTghoRiW0mkeDXgELpoz3/pmBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZiFAwnD24B77wWcsip11Fo7nhOLlqgKp+t9wjgf/EQ=;
 b=kSDO2+nlODtGeeH+l3P1kSVDussvaMNf6kEQkWFz6GaTEotTt6vIpNc6ab24mxU6mEysConZoTRrz3scl2Xj0bURuSJaMu3QCR79O7S6Xuc8dwVN2LKfTRQLxSnKmXZfJ1QYLbD8RoPDDK+pSl/MNG0Xo+Nx7htywKsT/Qdd4J01UPsb/rotbKIRM7I+Uz46Hi7mkN30ZFjSLfrBTLYbP3FXLHC0Vef1d70HaRf425AW2dr5GD8VfjL+VlX4bfifeOpYxuh5pAZ2NLjZBruwCb0oSwR8Nd6nXrA81FCkV8FI8QM9H/G0yBxpFCENl6db2fSW+dQr0rHPb/b1BuEnGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZiFAwnD24B77wWcsip11Fo7nhOLlqgKp+t9wjgf/EQ=;
 b=jh5SFTBWAk79XMp64iVe3UVwBkqvUUctaCNSlgsLUGsfRMPIuEww3FiQIioDvj8vmUk5+yJsxaWoxGOcxliCPOap/Atu0k1DpcH09do4HdYiCDm6SZI/bKXFfBAAMxbMU6XW9Yz4uMq3noZUrxqVK3FWg2+YSBHGQHTO53X4P9c=
Received: from BN6PR1701CA0015.namprd17.prod.outlook.com
 (2603:10b6:405:15::25) by DM6PR12MB3995.namprd12.prod.outlook.com
 (2603:10b6:5:1c6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.22; Thu, 5 Aug
 2021 06:38:25 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::4d) by BN6PR1701CA0015.outlook.office365.com
 (2603:10b6:405:15::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Thu, 5 Aug 2021 06:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Thu, 5 Aug 2021 06:38:25 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 5 Aug
 2021 01:38:23 -0500
Date:   Thu, 5 Aug 2021 14:39:52 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: enhance the sequency of governor change
Message-ID: <20210805063952.GA2999065@hr-amd>
References: <20210721101658.9235-1-ray.huang@amd.com>
 <20210803001339.GG2563957@hr-amd>
 <CAJZ5v0gMqFBDubQyG3YSnt1RcGzfjnxvLtTNpCdqZDjdAMJh=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gMqFBDubQyG3YSnt1RcGzfjnxvLtTNpCdqZDjdAMJh=w@mail.gmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ff8dba5-4b3f-4ae6-b060-08d957dba0a9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3995:
X-Microsoft-Antispam-PRVS: <DM6PR12MB399504C5D4EF15B00D21B723ECF29@DM6PR12MB3995.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzORWzjy1ZGBKgZj+S03mWTbqbBqqmYrUjz7q50SDHsCEnYpvIE9GHTsyQmP5ehqiF3xiawCtx/O8RsrHH5wVyRzOSYHqQbmipJzbcIQC1e/JCIC+SsGdc6Hww7fdRBit78bVjR32DgHzvjJBAcNJVMV0zGG35uTw979e4NxKhFkIhLIeH45o72KmvS634Y9cKl3WFf41M/clbYWpsuqbmAfQZrwg6SomoBu55mm3qWy912JyYxsk/m2pb2DzTLePg6fJ6f2I1UrIXT2KdZa5U3/FWlc4XSQc4dr3EUwNejZw0JAVLaamvue79Vq3Sp9MtSVPJyl6ryhipWMr/Nubwocv2/TNBQIq+PshG4MS5GiM+oGcdfx+GmcNvsmTtIq/F+CLt4QERMRimmqnJjcqiIpb+h3kc2UASaQtwm8vV4obUSStwp8HRY66dXaxQoTPDJJLwt2zfcb8mnHaMqxjJnNO+txAsbEq3bMzEZZsRHlNvbQQUImqARoKJnhvr/39IG5de0pqqLRmbM5bQm0u+EH1tY0nwdXiZlTVqX714CR0T4x5k6YUv9oP2MfsJlL/wzqTrGKc77sq5iK4ZEGgu8anURR0U6monFBJpwMPZ0QahaVgxmJRCBKPahmPPhA3zg0FPALayxXqn2HPo7nyE9JILxjj34bDcVi4Zl2JcQNr2M5OSkv5qwtu5Ilhc9/9czA9FuU5PUcHovwkhqqPK14LKR1wx5m3lZ6GQWeAUE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(336012)(6916009)(316002)(83380400001)(5660300002)(54906003)(36860700001)(186003)(8936002)(9686003)(16526019)(82310400003)(47076005)(478600001)(8676002)(1076003)(6666004)(356005)(53546011)(26005)(33656002)(81166007)(4326008)(2906002)(70206006)(82740400003)(33716001)(86362001)(55016002)(70586007)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 06:38:25.4135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff8dba5-4b3f-4ae6-b060-08d957dba0a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3995
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 05, 2021 at 01:00:23AM +0800, Rafael J. Wysocki wrote:
> On Tue, Aug 3, 2021 at 2:13 AM Huang Rui <ray.huang@amd.com> wrote:
> >
> > Ping~
> 
> I prefer the existing code, sorry.

It's ok, thanks anyway for the reply.

Thanks,
Ray

> 
> > On Wed, Jul 21, 2021 at 06:16:58PM +0800, Huang, Ray wrote:
> > > Keep the "success" case of governor change in the mainline of the
> > > function not in "if" case. And using restart_old_gov flag to indicate
> > > the fallback case to old governor. This is more readable and no function
> > > change.
> > >
> > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 23 +++++++++++++++--------
> > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 802abc925b2a..4f7005ddb70c 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -2545,18 +2545,25 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> > >       /* start new governor */
> > >       policy->governor = new_gov;
> > >       ret = cpufreq_init_governor(policy);
> > > -     if (!ret) {
> > > -             ret = cpufreq_start_governor(policy);
> > > -             if (!ret) {
> > > -                     pr_debug("governor change\n");
> > > -                     sched_cpufreq_governor_change(policy, old_gov);
> > > -                     return 0;
> > > -             }
> > > +     if (ret)
> > > +             goto restart_old_gov;
> > > +
> > > +     ret = cpufreq_start_governor(policy);
> > > +     if (ret) {
> > >               cpufreq_exit_governor(policy);
> > > +             goto restart_old_gov;
> > >       }
> > >
> > > +     pr_debug("governor change\n");
> > > +
> > > +     sched_cpufreq_governor_change(policy, old_gov);
> > > +
> > > +     return 0;
> > > +
> > > +restart_old_gov:
> > >       /* new governor failed, so re-start old one */
> > > -     pr_debug("starting governor %s failed\n", policy->governor->name);
> > > +     pr_debug("starting governor %s failed\n",
> > > +              policy->governor->name);
> > >       if (old_gov) {
> > >               policy->governor = old_gov;
> > >               if (cpufreq_init_governor(policy))
> > > --
