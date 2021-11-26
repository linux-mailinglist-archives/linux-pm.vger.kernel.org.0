Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A1A45EAA5
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 10:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346763AbhKZJtw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 04:49:52 -0500
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com ([40.107.93.51]:64577
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1376481AbhKZJrv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Nov 2021 04:47:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EONjeP14MQ+f/19J0tCuXPwp9Qz+i9n88s5PmLVmhaEuxDcNbgmd9Cjio4QBStMzwDpnEq7zV6GFAD7VexZ6Eqosb8wrobUezBP0O6/HbFj0sryMZYKiAoJ7wr3bKD0r6HL3D6RSrbqDL8KwaXgURWA5WOI8MKPDmG7Vocfkm5nFU/XlsKw9Ks51o3T+zg8UwwLwZyZv4fOGB6lPmFdeYkWqdW8ZsFtSdF218l2dh6i2E+1rRNaRaNujoheC+k8rYxOv53uQUZOaC0U2HlcqyExq6MNYnaogCMVLf703djbUxQyoV6RUtRmLqt5oNH+A+rg5YniDfLAlDCqimKT8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNdLYHlwSMIFV77yaAr7X9oqB7xuxcOcPCYZ0x2uo3Q=;
 b=LJmuU36N4cd2OIuOyU333kLHa5qXBtr33cO4UFRuq5UVkjJLJlw17UIGc3HpzE+5Ay8x+uSHORPZVdJMa/XwJ4ITOtNNOaKDNypiPtwRDW+a0kgxjMyHgHTJbq3Orh+vw/Ch+GA/G1ANeB3yW6DHcdxghYwlR3q/1f84fcHJxJkzVwj2D9OTduHLgEN7s5c9LXCql+ncgn8ZrirfzSzqTHFNUnpQ4rTq6q/pUY9v15jCfk15paQ0PDK05yCXX97JUc9s7ohex5uP8M8I1ecAu4ynBWse0y5xIj8ZtSW8TE0R/8smBvHtUBIKGwePZ9sCSU/MqXXHrL434PRa2rwt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNdLYHlwSMIFV77yaAr7X9oqB7xuxcOcPCYZ0x2uo3Q=;
 b=Sn/TET8sFNv6g1UHYpJaJsoow43LcsJX8ZfsXxk1Xv0w0H2esKqoY1nkaUu0eO0aIx39sPtYJRviBNyXiLpU1B/34T1ireO4auuJwMxY3DC5gKkJ+K2vO2n1XyTbNkYxiArkJF8hQCjVfSERycBRBn82CKCHFN1Gbm9MgRnzGXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22)
 by BYAPR12MB4598.namprd12.prod.outlook.com (2603:10b6:a03:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 26 Nov
 2021 09:44:36 +0000
Received: from BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193]) by BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193%6]) with mapi id 15.20.4713.027; Fri, 26 Nov 2021
 09:44:36 +0000
Date:   Fri, 26 Nov 2021 17:44:06 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 06/22] cpufreq: amd: introduce a new amd pstate driver
 to support future processors
Message-ID: <YaCsZqIl4+Dbefg7@amd.com>
References: <20211119103102.88124-1-ray.huang@amd.com>
 <20211119103102.88124-7-ray.huang@amd.com>
 <dbb61b3a2602150aa091d3b456c1866a580e3c53.camel@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb61b3a2602150aa091d3b456c1866a580e3c53.camel@suse.cz>
X-ClientProxiedBy: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To BY5PR12MB4918.namprd12.prod.outlook.com
 (2603:10b6:a03:1df::22)
MIME-Version: 1.0
Received: from amd.com (165.204.134.251) by HK2PR04CA0063.apcprd04.prod.outlook.com (2603:1096:202:14::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Fri, 26 Nov 2021 09:44:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95dfb4c4-02a6-4e0c-d23e-08d9b0c15b89
X-MS-TrafficTypeDiagnostic: BYAPR12MB4598:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4598A37DD207C406793B347DEC639@BYAPR12MB4598.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzS2ank4HbBFLBoTJsujONjVRFUi6YWzm77khXFjN5sP4ANh/3WQwK0v8l+W3KRurV6PuQtQxgo2mdOJ9FX1NsW3yEftoG1y6sEJD+e8XuntDgG5I9U0bH3Lne6qSWJfKLJq4OMkXGPHqQ98Rz6xKnTItA9cdSR+OX4JToZ1jzROXB/NGWjB5v4XWjRU6nADBl+/zabdE3fxD3lYFWXlLgdSlTRlmZtrKkDq4tEFL+bV2X2Z8T6lz3Svv51kWpcQ6+9ORLhN33LVOMpdZbc/azqtXb31cyIy3AK6i1dw7Tt2cJnHBQS20/OqL9C4A+CnKEBlOzfPBbB9zmMhxIm7N+p/NjCAHUSSojkTWHXGx1ythkQ6f7I2PfB2q927mWMbXwnmmf7I3b2+H1h4jdnJ26XaPK0ylT7s2cnWDEePillO3anRW5+iSXYMAIURclbJNS1NgrREMFnhff9XS3btkXq9f5FzKDEfUh80+3a+1Gi8KaEJzSS92GA96FuwQqJuAk0n4BTGcik7r8hSIc+vwmCwSpqHrWPoOnBMViNON1eovJJ/cV1e6l/Q6JzQIbwLr9W5hl7Vkvq6yZR/uWnGxDKqeoPmxNn7byqgTPrpvw/0zjVWa4hUuSj+6G5Q8JDLNrC9G0nP9sA8t8GMFeF2jWPE2is72uXo4Otwdh8YnU73bTVkCy7QoQu3DxnQ+8rYxaYr/OH8pHyBLncvipXDc0FwWSctDoDYLAmjLJU5VEAUGaofqckD2el0iBBP8Vri7OJ136TLZLsw1wuvOfG0jBxrMANMh3IN0HpLQxXDxnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4918.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(45080400002)(86362001)(6916009)(966005)(6666004)(26005)(5660300002)(66574015)(186003)(2906002)(956004)(2616005)(66556008)(66476007)(7416002)(8936002)(66946007)(7696005)(8676002)(4326008)(316002)(55016003)(4001150100001)(8886007)(83380400001)(54906003)(38100700002)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JjW4SZ165jTnY/LBoqQSZ82jeXis4toQZcCMBo/VzHH9fAIv5XrwwAcW2uEy?=
 =?us-ascii?Q?+PFVXNKM47IMHVnEWjaua6caALq1gZqOYlsIIQGp/RUg5exETXJSI5LLASBC?=
 =?us-ascii?Q?kfUvWfND0G830peShAM+DoyhiJ0vOffC9fyHbQOxbjJ2nL/T7AEfJm2VlOGb?=
 =?us-ascii?Q?r4dLS2n8qRlgBM4zpINFVp2bFfBO0GmY0C0fVUvK+v05i1pT3ggfI3iPq8qG?=
 =?us-ascii?Q?vFxufUqWSIGApin2A5VA2Q55sMW9xvfh1gAIgTKS700zgJex2cKcAJ96zMQY?=
 =?us-ascii?Q?wGD0V4KWM8vW8SIexDW2MHWxy1yh7Fi+ewqOxQ5MRkX8sqY9c9HS2MhhMU8W?=
 =?us-ascii?Q?XvKdJGqz+xlrV/3WIev7EUD/QUba6DTlfDTFQjYGDy7dEMZFJB8Xq10xY3jR?=
 =?us-ascii?Q?0HYfRYaK+K0R+74sQI366pKj2h6Bi/qPLrhD26BAXiG4Y7Cc61CuQcYzHFFF?=
 =?us-ascii?Q?TwsSpmOWhqvlCTtAwYXu02lxytgWcqGtUdLbqrwnxdYtU5r49a+B4m5tQGLW?=
 =?us-ascii?Q?00Wyrau7tPLUbzU4PK+4nc210Dv8J6AQeXxsRxdGtk4k8JV3ydqicQ2koBZ5?=
 =?us-ascii?Q?VCRYZ3ukw/3jCHiYiyDI/+pqIAMFXyD7gJMSu4AreBJ+Q8iKlGR7yzRSa8Nu?=
 =?us-ascii?Q?USBhcjktMaDM3sSAmuf9VFIMci+jQB4BcohZGqpJe9R/bLqZ1HVP19rkiv42?=
 =?us-ascii?Q?mIvJ6mEX+jHtwnWhyMm6cSIM8ER8krHgmsFrH9oyF2QMiusUMGLMUx47XTTi?=
 =?us-ascii?Q?8QI97hefohnIDvfiYGb8IRiZ3BulP3F1COS7CfntsqQh+f1GuTAGLhggWcs7?=
 =?us-ascii?Q?xFkaUcqN8C5NbZfvVxNesCVATH3Pja9KsmcIxgm8xdrlT825+3T3CauLUiaw?=
 =?us-ascii?Q?0bbEosEmxgqG5W/AolaqXtENdl/vF80hQMl68dACvQYsPBHGsqRU8hxtAYFE?=
 =?us-ascii?Q?WvlNftBiHaRPv8XnozZJYQxIAJkWRj0C+H2zMHjxJ0fujiWgbFOzeRwc53V9?=
 =?us-ascii?Q?hYTN7Be3CymQ27VklMWpooGltD4CSYE31yw2YzfM8G4+e/oU5B0fW07CmgAD?=
 =?us-ascii?Q?58/Eh8kH4k2tVpRhAM9G61YCBPeaqoUL5fizhwykI/46eFgmiDxhgDXg+ZzD?=
 =?us-ascii?Q?N0rzACBWGNQPiSUXkaTtS1ILLNrudPZv+NI+wshy2yJKcSJ7pJX/q1yq67FT?=
 =?us-ascii?Q?Lyem8amPlP+h2TgfDOfDcCQhoto4ADp5PtjPc9GlONoK5yelWrmCIs+xqTci?=
 =?us-ascii?Q?+E+RZJjkEQUVsQJP+wydiymi6ZzJB4s5BrKL0f/NGzvWjFHsYOE62eNI0HF+?=
 =?us-ascii?Q?fOhrDIaMGI06+y4v3HSsH3RJpRW7A+wHDv8PByQ2X3SJ8lRCroVXfoNlkhyZ?=
 =?us-ascii?Q?gOqoEOKZVweP/O772cKIfYgv1USpw7EZPyZNACDWUYRu/FFTThDDqzPfzAI5?=
 =?us-ascii?Q?sRqeMgBoXY4gfPVQ7lIAi4gUUlaC9DupsdYjSz/+XkgTTrIl7I0KkG+t+arp?=
 =?us-ascii?Q?0VHmyl9XODEqT/aZ3QWtm1mjYa3Agw09FFpVBPzxeNzHa2vUx3v19+y4MWbS?=
 =?us-ascii?Q?jHlvN+LoN60voTGWnyR/he5xJMsC5Tf0Y0Sm0f+WyANmK/qIBXUzJogaTNkr?=
 =?us-ascii?Q?cf5mYM/GIlMW/VbVfwHw/zE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dfb4c4-02a6-4e0c-d23e-08d9b0c15b89
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4918.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 09:44:36.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ullcQQvGiMYDjgq2EQKEfA14MPrco/u1o8UDstyPAmETaWE7XZMNBmgz/0uSvOKasgYFzZp6zUEvJoxa35KpMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4598
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 25, 2021 at 11:03:58PM +0800, Giovanni Gherdovich wrote:
> On Fri, 2021-11-19 at 18:30 +0800, Huang Rui wrote:
> > <snip>
> >
> > Performance Per Watt (PPW) Calculation:
> > 
> > The PPW calculation is referred by below paper:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsoftware.intel.com%2Fcontent%2Fdam%2Fdevelop%2Fexternal%2Fus%2Fen%2Fdocuments%2Fperformance-per-what-paper.pdf&amp;data=04%7C01%7Cray.huang%40amd.com%7C65f95f752ce142a5356d08d9b024d0de%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637734494579654964%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=6SzLLzQ1mRlbxdO1skcnrjulOmaqGWCrtDpIZToVjMM%3D&amp;reserved=0
> > 
> > Below formula is referred from below spec to measure the PPW:
> > 
> > (F / t) / P = F * t / (t * E) = F / E,
> > 
> > "F" is the number of frames per second.

This "F" should be the number of frames, not per second.

> > "P" is power measured in watts.
> > "E" is energy measured in joules.
> 
> Hello, I'd appreciate if you can remove the reference to the above paper and
> formula, because it is not really relevant to this context, and ends up being
> confusing.
> 
> It describes performance per watt tailored to graphics benchmarks, in the form
> of frames per joule. Nothing wrong with that, but it only works for tests that
> measure frames per second, and none of the tests below is of that type.

OK, actually, we would test 3D steam game benchmarks as well on our
processors with amd-pstate. :-)

And yes, below three benchmark tests are not related with "frame", but the
"MB" or "runs" of speedometer are actually another meaning of "frame" which
represent the performance data on each benchmark, right. That's is original
reason to put paper and formula here.

If you think it may confuse any guys, I can remove this in next version.

> 
> You have:
> 
> - tbench measures throughput (MB/sec)
> - gitsource, aka run the git test suite, measures elapsed time
> - speedometer, a web browser test that gives "runs per minute"
> 
> If you want performance per watt, you need to express your result as
> "operations per second", where "operations" is up to you to define. For
> tbench, one "operation" is moving a MB of data. For speedometer, one
> "operation" is one "run", as defined in the benchmark. Once you have op/sec
> (aka performance), divide by the average power measured over the entire
> duration of the benchmark.
> 
> In cases like gitsource, where you have elapsed_time as a result, performance
> per watt is 1 / (elapsed_time * average_power).
> 

The "operations" you mentioned here is another meaning of "frames" at the
paper in general. That's actual my previous purpose. :-)

> > We use the RAPL interface with "perf" tool to get the energy data of the
> > package power.
> > 
> > The data comparisons between amd-pstate and acpi-freq module are tested on
> > AMD Cezanne processor:
> > 
> > 1) TBench CPU benchmark:
> > 
> > +---------------------------------------------------------------------+
> > >                                                                     |
> > >               TBench (Performance Per Watt)                         |
> > >                                                    Higher is better |
> > +-------------------+------------------------+------------------------+
> > >                   |  Performance Per Watt  |  Performance Per Watt  |
> > >   Kernel Module   |       (Schedutil)      |       (Ondemand)       |
> > >                   |  Unit: MB / (s * J)    |  Unit: MB / (s * J)    |
> 
> The unit "MB / (s * J)" doesn't really work, it should be "MB / (sec * watt)".
> Can you double check that you divided the performance result by the average
> power? Same for the other tests.
> 
> It is also relevant to show performance, alongside with perf-per-watt.
> 

Aligned with you offline before, we will update the new performance per
watt data here with MB / Joule. Thanks to point it out.

Thanks,
Ray
