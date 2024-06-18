Return-Path: <linux-pm+bounces-9497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F1A90DB9F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 20:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75823B21893
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 18:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE0515E5CF;
	Tue, 18 Jun 2024 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lrzMnMf+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6182B1581E9;
	Tue, 18 Jun 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718735634; cv=fail; b=ODnMOQGrMEil+ho3516Zo4IaTFNnF4tot69af5VXy00waN7EEa7gI30u+1pzhI7HQNjJ1tn02KrRKzaiCFlFbpItNQ6cUhNsZVKVhRg3cVISUdqH2P4HCEaB9lkwJB4Gqi/3/sO8VzqFc7oU84SgPIzcNT4ZuzDb0OTZf/tjqSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718735634; c=relaxed/simple;
	bh=LFzUthoM1BXExljKAixmyKLODJwzVcifZGltd2nsIxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MYMlKbAYQpAQ8Q4R8X+N3jwc6Wv8W79kL+4x5BS+7XdIGa0AkeMgtFCDaJ+m55LZ/56rQU35UpoJXzXju5in10V1vT/HiiJM0gavn+FKl8fXaP2dttbWChDYopUDV7szLmRbZ07aG6y4E15xCOUT1lpsRUoo5FXGn0NVyDQS51k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lrzMnMf+; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9u56sykacbDtnLKqqIjOdK9VWEQiY7gCKucOZyYEiVKfPJ69IFGMd4RXiMKv+qYL/K7wU1rUtHjuywiaLaoJUYR1ThBT/S89+gJrrDtLsms8RNAalJtFotWkUgiOO7T63wrnStAu8RvenJ8W0ReYVACGGqExHOrDTspW+6J/NvPml5irQm3js1f2Q3cJh+ZG7udatzUwo/YAbTUzGTDPxUviCa0IjxNriQ82wrG8NF2QVMyWoXQCFffT+9n2SnXFlidW/hh+Gr8Ca5e9XHsVxwU27eQK+htpQQqORAy+q0Zn8Ah1YCSf4XaR1eWSMwvAQ5kH2bNYH23C7oa+o+Q9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K57Ck2EoACRkJcvW6iE8gT1MkTr1IgjlB4UgSKx7JTE=;
 b=mvp6uu2++rP+gV0DTL87oaL+w80FGY5rqD9h7v3i0wXUEnBa18xQGB/m7AyYXoh5WvZsIs3fqeWlg0/8TGNg0nsO4mVmMgKTyFM0dU3xKzHTTp03SvdmTV6CxIHF+McodYzrLPesXA3bzcN+NTN8mzizwd3vy4S7j/invwC6r+SZeiuhDgRC1JWpnukamEwxefvyYksC6+nQs0x/B4yacwcPFHe01hkzrjDyqhHvvarnmsLM+fzORAleHn5mFKZB8aWQ47oXyhTt9sSGLp8HqMkCtgCGUiXhvK843mYEuloJIzZ9CG7Yu9A5hbVQR4UKSbd2dmRjUfJTOP+1QzH8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K57Ck2EoACRkJcvW6iE8gT1MkTr1IgjlB4UgSKx7JTE=;
 b=lrzMnMf+ifIEFT7stxYRaqHxJEj/N67N1P/2HyXdVXCnhd596nfY0mmR+lNSwIG/22n9zJ1Pgu4zgrQFVyq2xJd3eUkbon5TY2DNEBfzV4vk2xDJz64nftMj9krnWuOoh56j6QFt1syDZtPKbt/+OzyES1tcX0NXEYYPpftgo8U=
Received: from MW4PR03CA0318.namprd03.prod.outlook.com (2603:10b6:303:dd::23)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 18:33:49 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::b2) by MW4PR03CA0318.outlook.office365.com
 (2603:10b6:303:dd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 18:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 18:33:48 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 13:33:32 -0500
Message-ID: <1035ec64-b3d3-c398-d6e7-99745a14c294@amd.com>
Date: Wed, 19 Jun 2024 00:03:30 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 00/14] Introducing TIF_NOTIFY_IPI flag
Content-Language: en-US
To: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>
CC: Vincent Guittot <vincent.guittot@linaro.org>,
	<linux-kernel@vger.kernel.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
	<ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, Michal Simek
	<monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn
	<jonas@southpole.se>, Stefan Kristiansson
	<stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller
	<deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen
 N. Rao" <naveen.n.rao@linux.ibm.com>, Yoshinori Sato
	<ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "David S. Miller"
	<davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Daniel
 Bristot de Oliveira" <bristot@redhat.com>, Valentin Schneider
	<vschneid@redhat.com>, Andrew Donnellan <ajd@linux.ibm.com>, Benjamin Gray
	<bgray@linux.ibm.com>, Frederic Weisbecker <frederic@kernel.org>, Xin Li
	<xin3.li@intel.com>, "Kees Cook" <keescook@chromium.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Tony Battersby <tonyb@cybernetics.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Brian Gerst <brgerst@gmail.com>, Leonardo Bras
	<leobras@redhat.com>, "Imran Khan" <imran.f.khan@oracle.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Rik van Riel" <riel@surriel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, "David Vernet" <void@manifault.com>, Julia
 Lawall <julia.lawall@inria.fr>, <linux-alpha@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-csky@vger.kernel.org>,
	<linux-openrisc@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-sh@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <linux-pm@vger.kernel.org>, <x86@kernel.org>
References: <20240613181613.4329-1-kprateek.nayak@amd.com>
 <20240614092801.GL8774@noisy.programming.kicks-ass.net>
 <CAKfTPtBTxhbmh=605TJ9sRw-nFu6w-KY7QpAxRUh5AjhQWa2ig@mail.gmail.com>
 <ZmxwWdW78hjNuxWU@chenyu5-mobl2>
 <4748fabf-c359-9199-16aa-469840201540@amd.com>
 <ZnE77ons3lb/JAxP@chenyu5-mobl2>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZnE77ons3lb/JAxP@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 325485c3-40ee-4043-14a7-08dc8fc53210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|7416011|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTArVUU0K09aZzM4Q2t5NTJBaGs5U0t0bXY0NVJXMmcvakdqSmp3T2lVaUJn?=
 =?utf-8?B?c2V6WU5JVko5KzFjK3p3UHMvQnlJZmQybVM1ZWRqeHRFUGdpZ3hoNEovU0c0?=
 =?utf-8?B?cHBEb3FFdy9kbnM4L0dpNTJqNDBMWW1SZ3lhNnFoTm83VWFFby9sOTcvcm1N?=
 =?utf-8?B?NTYvcDczTkYwRVZOcU54VVJPNDdEQVR3Sm5sS0JlM1RlcTUxY01TUEFLZ3Nw?=
 =?utf-8?B?bmxQai9HU01TUEdzdWJudzUwNTBmM2FMVy9xOTU2eHhDVG9NQ29MUXkyQUhZ?=
 =?utf-8?B?dU9VY2JvUlZ3UWFURVV4WDZNUkpTUm1pSUpMaytBNlNQRlJFNzExMnZXQyt6?=
 =?utf-8?B?SHQ1QW1DUTRFMExmS3hHOUJZS1hXdElVVm84bW9ZYlc4eHFrcEU2OU1Pckp6?=
 =?utf-8?B?OXgrL1dEaXVoZlNPWFV4TnlsR0ZRZXI1WVV5VE14Sk92MkV2ank0ZWdYL0Fj?=
 =?utf-8?B?b29YUVdsNEZoOTNwcEZXbmREcjVneW1OR25sQmc1VTBDU1FPRmpjS1ZyaEVu?=
 =?utf-8?B?ODYzaE5ocU9EVGpLSlJmY0djcEJDMFhsMU5SQ2RDaW4vcXRoRjJMRWZ3NWdv?=
 =?utf-8?B?SFloekQrVllmdllGQk8xRklhaW5nZE5zMWVoQ3BidVRTOThWOHRlUDA0WWRC?=
 =?utf-8?B?SldsNFJzbHFtaFZQc0U2ckFlZE9qS21EVUhjWGN4T1FyYlhPL1R3Z2VUck5P?=
 =?utf-8?B?d2VXcnlJRFg2dnE2NzduMm50MGxwV0pPRWo2aTFwb3kreWxOTHBQUTBkMjVM?=
 =?utf-8?B?WFBoc0crODNjRkROWURsc25Fa3R0ZVRFQUl3dVVIUFRqejI4bjhBQm5xY1oz?=
 =?utf-8?B?VHZ4SnBkZTQwYUJjdmZxekp4RnZSSG5MZmk5cmlHY2VmK3NHMDBOYnc0OHNi?=
 =?utf-8?B?dG9iRkFSVDhrQXQ4aUFtays4am5ZaDJkRkIxNkxjeTVSdEUxR0Jrd2VBUlhY?=
 =?utf-8?B?NVJJNkdhTG50bHZKQ0Rlc3BraE1udWZYMjVKdjFkbnQzTHJjMjMxbGJGeFR1?=
 =?utf-8?B?ZnJGWmU3VFJZQWl0bDBPUHl6eHVMNUpHcDBxNGZOdFcxK1EyRVFUL0xramZv?=
 =?utf-8?B?bDFQQk9ZRTE0WlN4c21NZlJhZk04UWNLaVNlSWNEaFZvVGhoNC9LTm5sbjEz?=
 =?utf-8?B?d2k5a1FSR3JpUHJBRlJHZWJVMzFlVHNlUVhLdFB2TDdkaWRTZEhqM041aTVp?=
 =?utf-8?B?d0ZMdGgwS1pmM3NGU25tbWtldkNGdkZyK3QrdWtsNElQcUtkZVo1SDYzRW41?=
 =?utf-8?B?Z2gwdFVjMG85MDEyTVA4Y3MzWDBRVHdpTXRTa3ZrU3FvWFJFWkFsWEFyKy8y?=
 =?utf-8?B?ZUhIckZwRkczbmQzRlMxMUJaVkxDVDZqZ1V0NUxpcjZ1cGszSC90ZkRwRS9i?=
 =?utf-8?B?TDYvamFCaGVQZjNsS3ZjUXNNN2lCczMwL0NuYXN5TG9aSS9aY0ZoMTk2Qk5o?=
 =?utf-8?B?WElXcnlSVHFQMDcrUndvNitmQnlRWUtmdHdGbGx6dGNUS2cvUXdHcWFmeTFv?=
 =?utf-8?B?QkUwWFc5R3VhelpYd3hGVjBRc0N5c0F1aXhKb3FaeUlFQkhGSnZFUTg4QWRa?=
 =?utf-8?B?Ujd0ZjBOUFFHczAxcW1rSWtOYUZqUERZLzRxZ2dBUUJHVTBYQUprVWJaL0FM?=
 =?utf-8?B?cUlyWnd6OEM2V0x6WVFvZnJKMlMzWFpUOXgreGFsa0lsRk9YajBWejVnbng2?=
 =?utf-8?B?K21KUTlTTS9tOWJpNFhDVkpiWTNlM3dvY0dDUmlDNWFPNlV1Slh4aC9KTSt1?=
 =?utf-8?B?SzJEZWtWNUxYKzQvcURsRExyUVVlKy9VQU9UVk8vK0ZyVmFBZ2xTaXV0cGJx?=
 =?utf-8?B?emQ0VjhzUytMQUhOTEpJRW5ZRHR3NDFxRW9DUGFGb2RSZnI5YnVzTFB4VTAr?=
 =?utf-8?B?N1JJN2d4aDE1dUoxNjdOVW0rbTU0cU04QkxURlUvcE9rV0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(7416011)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 18:33:48.9136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 325485c3-40ee-4043-14a7-08dc8fc53210
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979

Hello Chenyu,

On 6/18/2024 1:19 PM, Chen Yu wrote:
> [..snip..]
>>>>>
>>>>>> Vincent [5] pointed out a case where the idle load kick will fail to
>>>>>> run on an idle CPU since the IPI handler launching the ILB will check
>>>>>> for need_resched(). In such cases, the idle CPU relies on
>>>>>> newidle_balance() to pull tasks towards itself.
>>>>>
>>>>> Is this the need_resched() in _nohz_idle_balance() ? Should we change
>>>>> this to 'need_resched() && (rq->nr_running || rq->ttwu_pending)' or
>>>>> something long those lines?
>>>>
>>>> It's not only this but also in do_idle() as well which exits the loop
>>>> to look for tasks to schedule
>>>>
>>>>>
>>>>> I mean, it's fairly trivial to figure out if there really is going to be
>>>>> work there.
>>>>>
>>>>>> Using an alternate flag instead of NEED_RESCHED to indicate a pending
>>>>>> IPI was suggested as the correct approach to solve this problem on the
>>>>>> same thread.
>>>>>
>>>>> So adding per-arch changes for this seems like something we shouldn't
>>>>> unless there really is no other sane options.
>>>>>
>>>>> That is, I really think we should start with something like the below
>>>>> and then fix any fallout from that.
>>>>
>>>> The main problem is that need_resched becomes somewhat meaningless
>>>> because it doesn't  only mean "I need to resched a task" and we have
>>>> to add more tests around even for those not using polling
>>>>
>>>>>
>>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>>> index 0935f9d4bb7b..cfa45338ae97 100644
>>>>> --- a/kernel/sched/core.c
>>>>> +++ b/kernel/sched/core.c
>>>>> @@ -5799,7 +5800,7 @@ static inline struct task_struct *
>>>>>    __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>>>>    {
>>>>>           const struct sched_class *class;
>>>>> -       struct task_struct *p;
>>>>> +       struct task_struct *p = NULL;
>>>>>
>>>>>           /*
>>>>>            * Optimization: we know that if all tasks are in the fair class we can
>>>>> @@ -5810,9 +5811,11 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>>>>           if (likely(!sched_class_above(prev->sched_class, &fair_sched_class) &&
>>>>>                      rq->nr_running == rq->cfs.h_nr_running)) {
>>>>>
>>>>> -               p = pick_next_task_fair(rq, prev, rf);
>>>>> -               if (unlikely(p == RETRY_TASK))
>>>>> -                       goto restart;
>>>>> +               if (rq->nr_running) {
>>>>
>>>> How do you make the diff between a spurious need_resched() because of
>>>> polling and a cpu becoming idle ? isn't rq->nr_running null in both
>>>> cases ?
>>>> In the later case, we need to call sched_balance_newidle() but not in the former
>>>>
>>>
>>> Not sure if I understand correctly, if the goal of smp_call_function_single() is to
>>> kick the idle CPU and do not force it to launch the schedule()->sched_balance_newidle(),
>>> can we set the _TIF_POLLING_NRFLAG rather than _TIF_NEED_RESCHED in set_nr_if_polling()?
>>> I think writing any value to the monitor address would wakeup the idle CPU. And _TIF_POLLING_NRFLAG
>>> will be cleared once that idle CPU exit the idle loop, so we don't introduce arch-wide flag.
>> Although this might work for MWAIT, there is no way for the generic idle
>> path to know if there is a pending interrupt within a TIF_POLLING_NRFLAG
>> section. do_idle() sets TIF_POLLING_NRFLAG and relies on a bunch of
>> need_resched() checks along the way to bail early until finally doing a
>> current_clr_polling_and_test() before handing off to the cpuidle driver
>> in call_cpuidle(). I believe this section will necessarily need the sender
>> to indicate a pending interrupt via TIF_NEED_RESCHED flag to enable the
>> early bail out before going into the cpuidle driver since this case cannot
>> be considered the same as a break from MWAIT.
>>
> 
> I see, this is a good point. So you mean with only TIF_POLLING_NRFLAG there is
> possibility that the 'ipi kick CPU out of idle' is lost after the CPU enters
> do_idle() and before finally entering the idle state. While setting _TIF_NEED_RESCHED
> could help the do_idle() loop to detect pending request easier.

Yup, that is correct.

> BTW, before the
> commit b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()"), the
> lost of ipi after entering do_idle() and before entering driver idle state
> is also possible, right(the local irq is disabled)?

 From what I understand, the IPI remains pending until the interrupts
are enabled again. Before the optimization, the interrupts would be
disabled all the way until the instruction that is used to put the CPU
to sleep which is what __sti_mwait() and native_safe_halt() does. The
CPU would have received the IPI then and broke out of idle before
Peter's optimization went in. There is an elaborate comment on this in
do_idle() function above the call to local_irq_disable(). In  commit
edc8fc01f608 ("x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer
reprogram") Peter describes a case of actually missing the break from
an interrupt as the driver enabled interrupts much earlier than
executing the sleep instruction.

Since the CPU was in TIF_POLLING_NRFLAG state, one could simply get away
by setting TIF_NEED_RESCHED and not sending an actual IPI which the
need_resched() checks in the idle path would catch and the
flush_smp_call_function_queue() on the exit path would have serviced the
call function.

MWAIT with Interrupt Break extension (CPUID 0x5 ECX[IBE]) can break out
on pending interrupts even if interrupts are disabled  which is why
"mwait_idle_with_hints()" now checks "ecx" to choose between "__mwait()"
and "__mwait_sti()". The APM describes the extension to "allows
interrupts to wake MWAIT, even when eFLAGS.IF = 0". (Vol. 3.
"General-Purpose and System Instructions", Chapter 4. "System Instruction
Reference", Section "MWAIT")

I do hope someone corrects me if I'm wrong :)

>   
>> On x86, there seems to be a possibility of missing an interrupt if
>> someone writes _TIF_POLLING_NRFLAG to thread info between the target
>> executing MONTOR and MWAIT. AMD64 Architecture Programmer’s Manual
>> Volume 3: "General-Purpose and System Instructions", Chapter 4. "System
>> Instruction Reference", section "MWAIT" carries the following note in
>> the coding requirements:
>>
>> "MWAIT must be conditionally executed only if the awaited store has not
>> already occurred. (This prevents a race condition between the MONITOR
>> instruction arming the monitoring hardware and the store intended to
>> trigger the monitoring hardware.)"
>>
>> There exists a similar note in the "Example" section for "MWAIT" in
>> Intel 64 and IA-32 Architectures Software Developer’s Manual, Vol 2B
>> Chapter 4.3 "Instructions (M-U)"
>>
> 
> Thanks for the explaination of this race condition in detail.
> 
> thanks,
> Chenyu

-- 
Thanks and Regards,
Prateek

