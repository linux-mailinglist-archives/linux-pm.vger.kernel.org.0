Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A754E8545
	for <lists+linux-pm@lfdr.de>; Sun, 27 Mar 2022 05:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiC0DpE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Mar 2022 23:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiC0DpD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Mar 2022 23:45:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3205F52
        for <linux-pm@vger.kernel.org>; Sat, 26 Mar 2022 20:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILfRpmTbV92ewXYECUcP+Vt+/sgig4qvtmoURiMGQxa86p2Xdq1bxY06KT1uahmO+K82iqIScJlFqXYaIwzdCQ85zCjmxr/nclK1oUS4g+2zTF0E0LV+5p90bYwIL7zx5DaBwHQv0hQdR+RaH2/sWpK3fkN28O7LbxOV0YN7NtloBF5CgMb2aM/cf6OJeWgkBjd4uMxGjUcgTEFEODXXiieQDGKYsadc2ujuB2H5uo0cyvL/Eq9IxXLmI4MOOzY8rgrc2QFZ73nx7OnM4WRNXmJebwLBqfcLyAo6FQnE9HVYjCgPfWG6i6wR3+vmrKUpKA0Z2qzlFTJle5rJIi+6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbCXmqZ4wXTm15wZ0zUYbfxvuVccX2hxVmFFpmLzNwk=;
 b=UMhVpSciKjQ4bxc48MNRHhXwVqQBVZkj8Zl9Ru+iDGrgBSKia4o/YYgN60yfbylbGl2NybZYM54viYFbDcr5Kcg2SCmQylJ0VEFniNPrW20i8hC7OZrzQPvWVHr61ORil5NjsU1BJxiM4mixAUL76bjlsJw0nH17dk6l3mkexucgoXVw1UPQh47vTkSAv1SDWmZZu+15lJLlyTjWSWiEr0D2AjHM+DPda75zlIFYBjbn9M0NHf/KqqnsYwNn02EPV/WeyWLqiy+M236QgF+x2CBE9+DFWXrkr8eUW0xfCgNTodacIvVqGh+/CqPFu9Ku5e5x4ClDKuqFnWigGOWQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbCXmqZ4wXTm15wZ0zUYbfxvuVccX2hxVmFFpmLzNwk=;
 b=rFK+YWpEsEEuoItrh1CtoIHh5BSYeqIPEUVRFWRtZgCWNO8v5MQcHBdpxbCMHTlFrALXoXEP0X4vXsse1bBFJbrgLy7rlywKUyOysTq7IO5KCQQxyitV++gbNpPo9b4RagFjTBq9G9HlMLjIQHMgaH7BUfdNQeB7usWL8+vMPtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN8PR12MB2849.namprd12.prod.outlook.com (2603:10b6:408:6e::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18; Sun, 27 Mar 2022 03:43:17 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 03:43:14 +0000
Date:   Sun, 27 Mar 2022 11:42:54 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jan Engelhardt <jengelh@inai.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] Documentation: amd-pstate: grammar and sentence
 structure updates
Message-ID: <Yj/dPphSSJYxCvgO@amd.com>
References: <20220323102602.29259-1-jengelh@inai.de>
 <ffe84a5e-9788-773a-6326-c9c10f79cf10@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ffe84a5e-9788-773a-6326-c9c10f79cf10@infradead.org>
X-ClientProxiedBy: HK2PR04CA0090.apcprd04.prod.outlook.com
 (2603:1096:202:15::34) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65fd2b72-fe9e-44b9-ba99-08da0fa3ec0d
X-MS-TrafficTypeDiagnostic: BN8PR12MB2849:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB284949306DFB29760A1CD893EC1C9@BN8PR12MB2849.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8xCu1/1aQfmErvl0kIk3bxfPHIrJR3NIniczHVN5nxzRZLfsInbbAX+dlJc/EdlVCvmVpb3lfByN81GOhRU/2JFNwQsBmIEDIyRFC4+l/lLlQq3kPi0MA/tS6WW+61mcQcfHn8ZmjoIx+PtDiMxc7qxWUwBLEAJxPHbFI2k5Fhc6OxSwbxsvtPFflguOaehYcGlzWLDjoh8pjd4vuihT2xuSSPArHTNZ9C5ZdEyzoJrv9CkNNCgbUnnjIq+JxdP8vpG2dXETlH9VVZjKzMH8NhC/Y1m78PlmgMER8eCqy46Pse7xJOhExm40ahI3jpx6Cta0ChlK0XvDeXE4DCmYKrlIuSq1EisFZ1c5hFiV6H3ngxjHgiPIzHW25juORFVZwaR/KBAKppq2fy+eJvoL+Utft7AKDJjej2gNlpF0iLBbCBJ2EAjGtgqrWxj/YA+Jr1NrfYkRRNElwujPZoFtFu1jpxJkYDfmyc25DNPmPvUjyzbspwV8MnhWMIflKpmIrv47DNtkZc9sU9g/842BUOpIN+sxNAe/LdxlfOhsLy642Puq8tYr48QlgGbYCAZisZRL2IG31fUuKbr1R3g99cHp2BNTMTDKfMl3vI6js5i6il8nkFrLLTP4UndemX503W1V1nEVlEx4FBEgiXKhFNI9jE7C7qS6uGLzz/+noxU2c9XvBZktVGxIWAKeTscCW9BKvNPJEqdtg8yH39cm3k+MMC66Q4RvdfQsgzvcBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(36756003)(5660300002)(4326008)(30864003)(66476007)(66556008)(8676002)(38100700002)(66946007)(6512007)(2616005)(83380400001)(15650500001)(6916009)(316002)(54906003)(2906002)(186003)(6486002)(6666004)(26005)(508600001)(86362001)(6506007)(53546011)(21314003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IQ6pS8XWq3UEg1iBAD9ePUI/QA8picPCIL8DyM5edBEqHlavPXjhtgwaEp68?=
 =?us-ascii?Q?gl4yRypIIxMDUvn21VixYHXnMhJuDs85d7Aj1FZnrBZKWNug2rhD/kzguRJ3?=
 =?us-ascii?Q?Vr4XDHQqUYUPLzxnURr4uQL7/3FDG//B8XgSzWH2Q7zL25ZoSHdB6VNqyAy1?=
 =?us-ascii?Q?UmZaLk04Ov/nP61Ex4N87VyQz6lrVFZSHenn4yqmR3/3N7MpQ1gmTeey6+CX?=
 =?us-ascii?Q?/SdLZE05xnQ2EWJN0DIDGLhbZ7A5WckHWMmsL/JLlDGrNuBEH1JmPxPebi2n?=
 =?us-ascii?Q?7c2aAAedESDeZOYYrmMi8+dKsFtKJnY/UytMEDFCPnTZ2KMbYAeN5LIZocKx?=
 =?us-ascii?Q?Bb7C2mlffa7lj3sooFxoHFSkH6sO08KUog7KAoqZThOj/OHgIHNAGy8s+zdh?=
 =?us-ascii?Q?9HAceS/w+OCdbPnnoVCy5a1a+5/9GPGfDEcFi75vPSPGhw2hdDDLLVXzGa0t?=
 =?us-ascii?Q?nFRruCM3FnqZR8HJfvj/PWnL1nOpbn7g218KTVO56J9IHFiJtHvWbx4shbGG?=
 =?us-ascii?Q?h/3AwLlO/3ELa+Letam67OcXJADe3CotcxF5d2+7dJ3ygf/AWt6++8vCW2XV?=
 =?us-ascii?Q?5t/0zmZomk9lcP5dr0TaQt+ufzkQUFL6uw0YJNW7xkSmzKK79M/3VvCwbIBe?=
 =?us-ascii?Q?Y6SlrQ86pb6oJxIU/PS+aVaT/kjNp33SeJFxFzuNXhOixiS9gv1m804warXc?=
 =?us-ascii?Q?mi/k/Pw3gCPbyM21VktngQtMC4/O1/2KW7MAWohnoxEa2YYc5cXjvOBHou12?=
 =?us-ascii?Q?/jGDLgFvz5sPnpsgCeiPfT5Mv4Lda8FEHRVovRQv8cRKW50m1KRtYG0o+KoP?=
 =?us-ascii?Q?giCfpHklvO9w87OmelQ/y9RjVmTG+BQMPEsQLqh2VaoZQvDYbx7om+/Q9TH6?=
 =?us-ascii?Q?LohM2Gw1z8eaQ4cx8cDEaSvD/R5KBUucra5SgeHe0w2iigruUVojARbm0pvX?=
 =?us-ascii?Q?+NX9cOYw8R0CTCI4c+zpoHQ2/UgWMetQ+TWkTw1r0zF1OviG86/wgkKcQ1ak?=
 =?us-ascii?Q?5OEwcCZK7aFV5RN752b6uGmZ01k0QqeZcN43tSQnJrrJbu046G/cUXWGqVJr?=
 =?us-ascii?Q?yrEw9q1Mvy8WbOKe9YfFSdxdKYXXaZU/1KGX6b8eothrMF8Ek8oBqv5oyq0X?=
 =?us-ascii?Q?pRqyFHsga1omHPCSkxPOlM7FmmjuDDsPGrnQnBeJKU825B47lUw1xS7fkOv8?=
 =?us-ascii?Q?CZJSLbdzLDaMyWihOIjBguQtFPsLeZNmCuAxQuGgBI1LXp6GqdytREYSGu2L?=
 =?us-ascii?Q?jMYh1hIro4GTOUCbrvGi/pjmyb4KJi1I98IX59wPMda/6riaphhJpMD8KkbK?=
 =?us-ascii?Q?YN+CX23keKaiXdf7m6SmSNAzyu9r2mJGtWD1rArEG1ABeE8ZA6GKmctIeYXw?=
 =?us-ascii?Q?rvdUKiUpNTUGS4FSpRJGZNEDjq1+hU3t/sapTL7aEgEHQj0YiD2hpQ0cI3hv?=
 =?us-ascii?Q?VUKcLBsS4ahDkZLnAKJmyUPLF9d8gDczkKnlnyszrBA+yrnlUEYNrjBkfhB6?=
 =?us-ascii?Q?F20vfoLgy09nNV8dDHHCsJb/UkfrV1fEamD2U22i2peP2bM6q/V4KGXsRhN/?=
 =?us-ascii?Q?sJaIAtEn70OZwDXdzDoaUw13+n3dPTI44eDVlzTtoce644JxkYEMQAmSxKAP?=
 =?us-ascii?Q?D+5+nZYyCLoyvCh87pI6KNYnu72fxfLBkax7fm5eR67Y4/Xo3SS5raS7Cbk+?=
 =?us-ascii?Q?yGs/K4ma8HMta/SRTInY/6clphVoAP8iYrU2wlOTgwiJo71w67HyElX+4mpZ?=
 =?us-ascii?Q?jdUnnw6YDA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fd2b72-fe9e-44b9-ba99-08da0fa3ec0d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 03:43:14.5442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52ii37JykWbf5oFmk0obz7zoRILRtmIoIJnhSXuCwj0EvElJrBbKrcEWBIYwbhTit72hia5P13KGsNyWHGxGWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2849
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 24, 2022 at 05:00:40AM +0800, Randy Dunlap wrote:
> Hi--
>=20
> On 3/23/22 03:26, Jan Engelhardt wrote:
> > Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> > ---
> > basis is v5.17
> >=20
> >  Documentation/admin-guide/pm/amd-pstate.rst | 135 ++++++++++----------
> >  1 file changed, 67 insertions(+), 68 deletions(-)
> >=20
> > diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentatio=
n/admin-guide/pm/amd-pstate.rst
> > index 2f066df4ee9c..c83db37695da 100644
> > --- a/Documentation/admin-guide/pm/amd-pstate.rst
> > +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> > @@ -19,7 +19,7 @@ Linux kernel. The new mechanism is based on Collabora=
tive Processor
> >  Performance Control (CPPC) which provides finer grain frequency manage=
ment
> >  than legacy ACPI hardware P-States. Current AMD CPU/APU platforms are =
using
> >  the ACPI P-states driver to manage CPU frequency and clocks with switc=
hing
> > -only in 3 P-states. CPPC replaces the ACPI P-states controls, allows a
> > +only in 3 P-states. CPPC replaces the ACPI P-states controls and allow=
s a
> >  flexible, low-latency interface for the Linux kernel to directly
> >  communicate the performance hints to hardware.
> > =20
> > @@ -27,7 +27,7 @@ communicate the performance hints to hardware.
> >  ``ondemand``, etc. to manage the performance hints which are provided =
by
> >  CPPC hardware functionality that internally follows the hardware
> >  specification (for details refer to AMD64 Architecture Programmer's Ma=
nual
> > -Volume 2: System Programming [1]_). Currently ``amd-pstate`` supports =
basic
> > +Volume 2: System Programming [1]_). Currently, ``amd-pstate`` supports=
 basic
> >  frequency control function according to kernel governors on some of th=
e
> >  Zen2 and Zen3 processors, and we will implement more AMD specific func=
tions
> >  in future after we verify them on the hardware and SBIOS.
> > @@ -41,9 +41,9 @@ continuous, abstract, and unit-less performance value=
 in a scale that is
> >  not tied to a specific performance state / frequency. This is an ACPI
> >  standard [2]_ which software can specify application performance goals=
 and
> >  hints as a relative target to the infrastructure limits. AMD processor=
s
> > -provides the low latency register model (MSR) instead of AML code
> > +provide the low latency register model (MSR) instead of an AML code
> >  interpreter for performance adjustments. ``amd-pstate`` will initializ=
e a
> > -``struct cpufreq_driver`` instance ``amd_pstate_driver`` with the call=
backs
> > +``struct cpufreq_driver`` instance, ``amd_pstate_driver``, with the ca=
llbacks
> >  to manage each performance update behavior. ::
> > =20
> >   Highest Perf ------>+-----------------------+                        =
 +-----------------------+
> > @@ -91,26 +91,26 @@ AMD CPPC Performance Capability
> >  Highest Performance (RO)
> >  .........................
> > =20
> > -It is the absolute maximum performance an individual processor may rea=
ch,
> > +This is the absolute maximum performance an individual processor may r=
each,
> >  assuming ideal conditions. This performance level may not be sustainab=
le
> >  for long durations and may only be achievable if other platform compon=
ents
> > -are in a specific state; for example, it may require other processors =
be in
> > +are in a specific state; for example, it may require other processors =
to be in
> >  an idle state. This would be equivalent to the highest frequencies
> >  supported by the processor.
> > =20
> >  Nominal (Guaranteed) Performance (RO)
> >  ......................................
> > =20
> > -It is the maximum sustained performance level of the processor, assumi=
ng
> > -ideal operating conditions. In absence of an external constraint (powe=
r,
> > -thermal, etc.) this is the performance level the processor is expected=
 to
> > +This is the maximum sustained performance level of the processor, assu=
ming
> > +ideal operating conditions. In the absence of an external constraint (=
power,
> > +thermal, etc.), this is the performance level the processor is expecte=
d to
> >  be able to maintain continuously. All cores/processors are expected to=
 be
> >  able to sustain their nominal performance state simultaneously.
> > =20
> >  Lowest non-linear Performance (RO)
> >  ...................................
> > =20
> > -It is the lowest performance level at which nonlinear power savings ar=
e
> > +This is the lowest performance level at which nonlinear power savings =
are
> >  achieved, for example, due to the combined effects of voltage and freq=
uency
> >  scaling. Above this threshold, lower performance levels should be gene=
rally
> >  more energy efficient than higher performance levels. This register
> > @@ -119,7 +119,7 @@ effectively conveys the most efficient performance =
level to ``amd-pstate``.
> >  Lowest Performance (RO)
> >  ........................
> > =20
> > -It is the absolute lowest performance level of the processor. Selectin=
g a
> > +This is the absolute lowest performance level of the processor. Select=
ing a
> >  performance level lower than the lowest nonlinear performance level ma=
y
> >  cause an efficiency penalty but should reduce the instantaneous power
> >  consumption of the processor.
> > @@ -149,14 +149,14 @@ a relative number. This can be expressed as perce=
ntage of nominal
> >  performance (infrastructure max). Below the nominal sustained performa=
nce
> >  level, desired performance expresses the average performance level of =
the
> >  processor subject to hardware. Above the nominal performance level,
> > -processor must provide at least nominal performance requested and go h=
igher
> > +the processor must provide at least nominal performance requested and =
go higher
> >  if current operating conditions allow.
> > =20
> >  Energy Performance Preference (EPP) (RW)
> >  .........................................
> > =20
> > -Provides a hint to the hardware if software wants to bias toward perfo=
rmance
> > -(0x0) or energy efficiency (0xff).
> > +This attribute provides a hint to the hardware if software wants to bi=
as
> > +toward performance (0x0) or energy efficiency (0xff).
>=20
> Would be nice to say something here like (if this is correct):
>=20
> This value can be anywhere in the range [0x00, 0x7f]. E.g., 0x80 means
> no bias -- performance and energy efficieny are equally important.

We are working on the epp draft prototype right now. And will give a more
detailed introduction once it is done.

>=20
> > =20
> > =20
> >  Key Governors Support
> > @@ -173,35 +173,34 @@ operating frequencies supported by the hardware. =
Users can check the
> >  ``amd-pstate`` mainly supports ``schedutil`` and ``ondemand`` for dyna=
mic
> >  frequency control. It is to fine tune the processor configuration on
> >  ``amd-pstate`` to the ``schedutil`` with CPU CFS scheduler. ``amd-psta=
te``
> > -registers adjust_perf callback to implement the CPPC similar performan=
ce
> > -update behavior. It is initialized by ``sugov_start`` and then populat=
e the
> > -CPU's update_util_data pointer to assign ``sugov_update_single_perf`` =
as
> > -the utilization update callback function in CPU scheduler. CPU schedul=
er
> > -will call ``cpufreq_update_util`` and assign the target performance
> > -according to the ``struct sugov_cpu`` that utilization update belongs =
to.
> > -Then ``amd-pstate`` updates the desired performance according to the C=
PU
> > +registers the adjust_perf callback to implement performance update beh=
avior
> > +similar to CPPC. It is initialized by ``sugov_start`` and then populat=
es the
> > +CPU's update_util_data pointer to assign ``sugov_update_single_perf`` =
as the
> > +utilization update callback function in the CPU scheduler. The CPU sch=
eduler
> > +will call ``cpufreq_update_util`` and assigns the target performance a=
ccording
> > +to the ``struct sugov_cpu`` that the utilization update belongs to.
> > +Then, ``amd-pstate`` updates the desired performance according to the =
CPU
> >  scheduler assigned.
> > =20
> > =20
> >  Processor Support
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> > -The ``amd-pstate`` initialization will fail if the _CPC in ACPI SBIOS =
is
> > -not existed at the detected processor, and it uses ``acpi_cpc_valid`` =
to
> > -check the _CPC existence. All Zen based processors support legacy ACPI
> > -hardware P-States function, so while the ``amd-pstate`` fails to be
> > -initialized, the kernel will fall back to initialize ``acpi-cpufreq``
> > -driver.
> > +The ``amd-pstate`` initialization will fail if the ``_CPC`` entry in t=
he ACPI
> > +SBIOS does not exist in the detected processor. It uses ``acpi_cpc_val=
id``
> > +to check the existence of ``_CPC``. All Zen based processors support t=
he legacy
> > +ACPI hardware P-States function, so when ``amd-pstate`` fails initiali=
zation,
> > +the kernel will fall back to initialize the ``acpi-cpufreq`` driver.
> > =20
> >  There are two types of hardware implementations for ``amd-pstate``: on=
e is
> >  `Full MSR Support <perf_cap_>`_ and another is `Shared Memory Support
> > -<perf_cap_>`_. It can use :c:macro:`X86_FEATURE_CPPC` feature flag (fo=
r
> > -details refer to Processor Programming Reference (PPR) for AMD Family
> > -19h Model 51h, Revision A1 Processors [3]_) to indicate the different
> > -types. ``amd-pstate`` is to register different ``static_call`` instanc=
es
> > -for different hardware implementations.
> > +<perf_cap_>`_. It can use the :c:macro:`X86_FEATURE_CPPC` feature flag=
 to
>=20
> So there are 2 types, but both of them have references to <perf_cap_> ?
> Hm, looks like almost everything references <perf_cap_>.
>=20
> What is "It" in "It can use" ?

"It" means software (kernel) or user to use the CPU feature flag to know
the processor should be "MSR" or "Shared Memory".

>=20
> > +indicate the different types. (For details, refer to the Processor Pro=
gramming
> > +Reference (PPR) for AMD Family 19h Model 51h, Revision A1 Processors [=
3]_.)
> > +``amd-pstate`` is to register different ``static_call`` instances for =
different
>=20
>                   will register different
> or                registers different
> ?
>=20
> > +hardware implementations.
> > =20
> > -Currently, some of Zen2 and Zen3 processors support ``amd-pstate``. In=
 the
> > +Currently, some of the Zen2 and Zen3 processors support ``amd-pstate``=
. In the
> >  future, it will be supported on more and more AMD processors.
> > =20
> >  Full MSR Support
> > @@ -210,18 +209,18 @@ Full MSR Support
> >  Some new Zen3 processors such as Cezanne provide the MSR registers dir=
ectly
> >  while the :c:macro:`X86_FEATURE_CPPC` CPU feature flag is set.
> >  ``amd-pstate`` can handle the MSR register to implement the fast switc=
h
> > -function in ``CPUFreq`` that can shrink latency of frequency control o=
n the
> > -interrupt context. The functions with ``pstate_xxx`` prefix represent =
the
> > -operations of MSR registers.
> > +function in ``CPUFreq`` that can reduce the latency of frequency contr=
ol in
> > +interrupt context. The functions with a ``pstate_xxx`` prefix represen=
t the
> > +operations on MSR registers.
> > =20
> >  Shared Memory Support
> >  ----------------------
> > =20
> > -If :c:macro:`X86_FEATURE_CPPC` CPU feature flag is not set, that means=
 the
> > -processor supports shared memory solution. In this case, ``amd-pstate`=
`
> > +If the :c:macro:`X86_FEATURE_CPPC` CPU feature flag is not set, the
> > +processor supports the shared memory solution. In this case, ``amd-pst=
ate``
> >  uses the ``cppc_acpi`` helper methods to implement the callback functi=
ons
> > -that defined on ``static_call``. The functions with ``cppc_xxx`` prefi=
x
> > -represent the operations of acpi cppc helpers for shared memory soluti=
on.
> > +that are defined on ``static_call``. The functions with the ``cppc_xxx=
`` prefix
> > +represent the operations of ACPI CPPC helpers for the shared memory so=
lution.
> > =20
> > =20
> >  AMD P-States and ACPI hardware P-States always can be supported in one
> > @@ -234,7 +233,7 @@ User Space Interface in ``sysfs``
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> >  ``amd-pstate`` exposes several global attributes (files) in ``sysfs`` =
to
> > -control its functionality at the system level. They located in the
> > +control its functionality at the system level. They are located in the
> >  ``/sys/devices/system/cpu/cpufreq/policyX/`` directory and affect all =
CPUs. ::
> > =20
> >   root@hr-test1:/home/ray# ls /sys/devices/system/cpu/cpufreq/policy0/*=
amd*
> > @@ -246,38 +245,38 @@ control its functionality at the system level. Th=
ey located in the
> >  ``amd_pstate_highest_perf / amd_pstate_max_freq``
> > =20
> >  Maximum CPPC performance and CPU frequency that the driver is allowed =
to
> > -set in percent of the maximum supported CPPC performance level (the hi=
ghest
> > +set, in percent of the maximum supported CPPC performance level (the h=
ighest
> >  performance supported in `AMD CPPC Performance Capability <perf_cap_>`=
_).
> > -In some of ASICs, the highest CPPC performance is not the one in the _=
CPC
> > -table, so we need to expose it to sysfs. If boost is not active but
> > -supported, this maximum frequency will be larger than the one in
> > +In some ASICs, the highest CPPC performance is not the one in the ``_C=
PC``
> > +table, so we need to expose it to sysfs. If boost is not active, but
> > +still supported, this maximum frequency will be larger than the one in
> >  ``cpuinfo``.
> >  This attribute is read-only.
> > =20
> >  ``amd_pstate_lowest_nonlinear_freq``
> > =20
> > -The lowest non-linear CPPC CPU frequency that the driver is allowed to=
 set
> > -in percent of the maximum supported CPPC performance level (Please see=
 the
> > +The lowest non-linear CPPC CPU frequency that the driver is allowed to=
 set,
> > +in percent of the maximum supported CPPC performance level. (Please se=
e the
> >  lowest non-linear performance in `AMD CPPC Performance Capability
> > -<perf_cap_>`_).
> > +<perf_cap_>`_.)
> >  This attribute is read-only.
> > =20
> > -For other performance and frequency values, we can read them back from
> > +Other performance and frequency values can be read back from
> >  ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
> > =20
> > =20
> >  ``amd-pstate`` vs ``acpi-cpufreq``
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> > -On majority of AMD platforms supported by ``acpi-cpufreq``, the ACPI t=
ables
> > -provided by the platform firmware used for CPU performance scaling, bu=
t
> > -only provides 3 P-states on AMD processors.
> > -However, on modern AMD APU and CPU series, it provides the collaborati=
ve
> > -processor performance control according to ACPI protocol and customize=
 this
> > -for AMD platforms. That is fine-grain and continuous frequency range
> > +On the majority of AMD platforms supported by ``acpi-cpufreq``, the AC=
PI tables
> > +provided by the platform firmware are used for CPU performance scaling=
, but
> > +only provide 3 P-states on AMD processors.
> > +However, on modern AMD APU and CPU series, hardware provides the Colla=
borative
> > +Processor Performance Control according to the ACPI protocol and custo=
mizes this
> > +for AMD platforms. That is, fine-grained and continuous frequency rang=
es
> >  instead of the legacy hardware P-states. ``amd-pstate`` is the kernel
> > -module which supports the new AMD P-States mechanism on most of future=
 AMD
> > -platforms. The AMD P-States mechanism will be the more performance and=
 energy
> > +module which supports the new AMD P-States mechanism on most of the fu=
ture AMD
> > +platforms. The AMD P-States mechanism is the more performance and ener=
gy
> >  efficiency frequency management method on AMD processors.
> > =20
> >  Kernel Module Options for ``amd-pstate``
> > @@ -287,25 +286,25 @@ Kernel Module Options for ``amd-pstate``
> >  Use a module param (shared_mem) to enable related processors manually =
with
> >  **amd_pstate.shared_mem=3D1**.
> >  Due to the performance issue on the processors with `Shared Memory Sup=
port
> > -<perf_cap_>`_, so we disable it for the moment and will enable this by=
 default
> > -once we address performance issue on this solution.
> > +<perf_cap_>`_, we disable it presently and will re-enable this by defa=
ult
> > +once we address performance issue with this solution.
> > =20
> > -The way to check whether current processor is `Full MSR Support <perf_=
cap_>`_
> > +To check whether the current processor is using `Full MSR Support <per=
f_cap_>`_
> >  or `Shared Memory Support <perf_cap_>`_ : ::
> > =20
> >    ray@hr-test1:~$ lscpu | grep cppc
> >    Flags:                           fpu vme de pse tsc msr pae mce cx8 =
apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall n=
x mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc =
cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4=
_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy =
svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit =
wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3=
 cdp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep =
bmi2 erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt=
 xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local cl=
zero irperf xsaveerptr rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save=
 tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avi=
c v_vmsave_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid ove=
rflow_recov succor smca fsrm
> > =20
> > -If CPU Flags have cppc, then this processor supports `Full MSR Support
> > -<perf_cap_>`_. Otherwise it supports `Shared Memory Support <perf_cap_=
>`_.
> > +If the CPU flags have ``cppc``, then this processor supports `Full MSR=
 Support
> > +<perf_cap_>`_. Otherwise, it supports `Shared Memory Support <perf_cap=
_>`_.
> > =20
> > =20
> >  ``cpupower`` tool support for ``amd-pstate``
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> > -``amd-pstate`` is supported on ``cpupower`` tool that can be used to d=
ump the frequency
> > -information. And it is in progress to support more and more operations=
 for new
> > -``amd-pstate`` module with this tool. ::
> > +``amd-pstate`` is supported by the ``cpupower`` tool, which can be use=
d to dump
> > +frequency information. Development is in progress to support more and =
more
> > +operations for the new ``amd-pstate`` module with this tool. ::
> > =20
> >   root@hr-test1:/home/ray# cpupower frequency-info
> >   analyzing CPU 0:
> > @@ -336,10 +335,10 @@ Trace Events
> >  --------------
> > =20
> >  There are two static trace events that can be used for ``amd-pstate``
> > -diagnostics.  One of them is the cpu_frequency trace event generally u=
sed
> > +diagnostics. One of them is the ``cpu_frequency`` trace event generall=
y used
> >  by ``CPUFreq``, and the other one is the ``amd_pstate_perf`` trace eve=
nt
> >  specific to ``amd-pstate``.  The following sequence of shell commands =
can
> > -be used to enable them and see their output (if the kernel is generall=
y
> > +be used to enable them and see their output (if the kernel is
> >  configured to support event tracing). ::
> > =20
> >   root@hr-test1:/home/ray# cd /sys/kernel/tracing/
> > @@ -364,7 +363,7 @@ configured to support event tracing). ::
> >            <idle>-0       [003] d.s..  4995.980971: amd_pstate_perf: am=
d_min_perf=3D85 amd_des_perf=3D85 amd_max_perf=3D166 cpu_id=3D3 changed=3Df=
alse fast_switch=3Dtrue
> >            <idle>-0       [011] d.s..  4995.980996: amd_pstate_perf: am=
d_min_perf=3D85 amd_des_perf=3D85 amd_max_perf=3D166 cpu_id=3D11 changed=3D=
false fast_switch=3Dtrue
> > =20
> > -The cpu_frequency trace event will be triggered either by the ``schedu=
til`` scaling
> > +The ``cpu_frequency`` trace event will be triggered either by the ``sc=
hedutil`` scaling
> >  governor (for the policies it is attached to), or by the ``CPUFreq`` c=
ore (for the
> >  policies with other scaling governors).
> > =20
>=20
> Anyway, this is a big improvement. Thanks.
>=20
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>=20

Thanks.

Patch is Reviewed-by: Huang Rui <ray.huang@amd.com>

Thanks,
Ray
