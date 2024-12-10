Return-Path: <linux-pm+bounces-18905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C4B9EAF88
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 12:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7588A168AC7
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 11:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9F2253F0;
	Tue, 10 Dec 2024 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V40hQkeU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D15226533;
	Tue, 10 Dec 2024 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829024; cv=fail; b=Ok1N36XPBXTAcrd6jL53lXBJNqxFt2gRX0CAKD86NXO66bI/ni3rJEABhYINHk/aZmKUeqNLVL544Oa9jlwoP9pF0O8dYu4AxQC7n+HNon3vNvI+iELhh+hdPVB7kAeGPlXN2awTIKw3emjnu9gDWd+AA9ulleIjn5Meh62A5Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829024; c=relaxed/simple;
	bh=VmoiV8OjWBZwnAvrJKoCYqU2RU138IGVLpaojoxUcZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SnD6yCXHkWhlw2ib7zyrpkKduHRm7b2URHo0xLM4EX3nsIlTbyZB1YEo+/t1032LzD3Z1wwrru6/21NwyLZ1M8TeGgcyrR9+P2mPq8I/Yk+Rg8Tx7Fh1gmVg/ebZ5e8Nh3Wvtko/hH64WoFlN+nc2GPrup1WoTeZk89A9Icz+LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V40hQkeU reason="signature verification failed"; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qO4t6hhW1Uy0BNQVRj4l7GcaUcGD+KSA+0/HHIqxhN5VOkjf4hWZbcTc1lBiHAp8BElw6PmA9dhSOKQ+xKwftguwCJ87Olr6QKhLUMgG7jUGe+FzWu0GRmOP+J8QDVO/dvyGZHoishb+yz5MnoP1KRd+fbjI39gEtE1enD+q63AdSbbcQIf7vYBu7ujRxGxgLdPvVQF1vxgMjMQMf2avAX+JX8E+u8LJ+YgkZ9RuafQDtu/0UWgqJwDyeV3MTVZ3iJQ1tb2bNQ5/TX6Xi195cgjUiCPwnBjMlJhQ4XiOgI9BDhakL9f6gAbi5/khrmLcN0zwZJs3/HTuLe44DTG7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8gss+ZNkmD9ulobaRNqM0L4iVkEG8WJBlMmMF91kpw=;
 b=aVw4rRKj0kmYM6OiZXvkjbY29B+5ckqKOyLhKDD5JRdoNsRLwbAvUa0FByJemaLxZ6ISP1t4u8Ocs/cdt8qajerVrBFfV3iRjtRi6dM5pwqPdFTHXrFm/+qsxJew+nTUsc4s5idaYw4qnZgbiSoMGL1fhvjGSJ0rd+6qOXovF+QTnkRQPpE1ntwKbRnL5LFpDevsbXIjI2S44khzn0633k9+gEv1BIDng6mpAv+X8bQtpoXoH4+NJ9cnZ7UMtRHUOTo9BTE8UMoyWkysaXelsuf5Mb2WelDOISAZm399EEZx9Q6A1W8S/giR62CP5dO10LksbWCnxS9idL3E8co13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8gss+ZNkmD9ulobaRNqM0L4iVkEG8WJBlMmMF91kpw=;
 b=V40hQkeU+1GWHq26HX5jYbAXFB4gweILgolKZp9KgPGpaAwsOug5tu9tTO5XqMPFS5BvVRtn/j45/1/zMZ3DOKqEzYho0o8Q5d4HHWvlQsfPcbQbjeg9U6tLr3Mkt8DrLyuVXCZ7fyK+g6J07KKZ1ClirwuTlOARpr9EiSPzKDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 11:10:19 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 11:10:19 +0000
Date: Tue, 10 Dec 2024 16:40:11 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH v2 12/16] cpufreq/amd-pstate: Always write EPP value when
 updating perf
Message-ID: <Z1ghk3qDbeYVCs1Z@BLRRASHENOY1.amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
 <20241208063031.3113-13-mario.limonciello@amd.com>
 <Z1atZRyH3dbWQYjv@BLRRASHENOY1.amd.com>
 <c9fc8ee2-db38-48e3-86ee-69a33eab1473@amd.com>
 <ca241dad-d11d-4145-8753-d5f18291bd65@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca241dad-d11d-4145-8753-d5f18291bd65@amd.com>
X-ClientProxiedBy: PN2PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::9) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e161764-3f7d-43bc-b3d8-08dd190b3b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?C+0JDL/WLlX0N96AEi+4tXpY72w7aPOSG2wAJ18WXfeZ1YgCJkezNf5Mir?=
 =?iso-8859-1?Q?UXoifaiIyGMF4IIRfIrCQsBRrLd9IRlx9nyAiguqsaP+3IijwqMNc/0pqm?=
 =?iso-8859-1?Q?oMWJBOLqGERYLC9SjhlmyjUnCPWHQp+qX7m4jxoq4hl/EMLvbB+gt4Y/p7?=
 =?iso-8859-1?Q?kIQH+1ej7E4bM5U1bFQjM16JciszWS9jlsyvXEmv/JvzvQ7kh0XkPOfvgJ?=
 =?iso-8859-1?Q?1cW0ZS2KEd3z+KZ7uks5mmQKuDuDWoMSKeUEHDQpqPV/jbRJsqQr2YC2I0?=
 =?iso-8859-1?Q?tVonaYLniRAyIjSAub0p0wmHQoYeQTUvMuJsEVcae9rPQBrGUMCKL07AV3?=
 =?iso-8859-1?Q?UbCjflAbOXgOfF+bZUBIA3vck7IUvbtyLuLrNLlIXP+C221SoPfBedGyC+?=
 =?iso-8859-1?Q?l98jdxpb4nmLVSrXmVyYjlwOpg6MIlpFM2FE5M/r8kOA8oGywjzw1wrQ5X?=
 =?iso-8859-1?Q?DcmggFuOKH1PmiZE/Q++mik+DJCgjG2o8oomyijarGhpLsMDVu5wB40+Z9?=
 =?iso-8859-1?Q?F5CrfOe0Prd83I2CSlgR1IMdWNzz+N/yppkbrJ+QLfxOLDa+4r5pesnrwG?=
 =?iso-8859-1?Q?4BPFbgM0w+GWm86OjTYRXSUptwN7+2TFPnZruyMzxJ9/yIyctWmxBpVdEE?=
 =?iso-8859-1?Q?lQyt5pZofKnXSip7WYPAv7s4iC9T8aaQ7+Qq7BzqvcTfNxUfy9DdeHos6E?=
 =?iso-8859-1?Q?A0sBWIuU+KaWbhTrz+lTbS97nGL2SxdtFVungu1RbLWTFGjPLDejXCBCld?=
 =?iso-8859-1?Q?/XkHXcWU0tat5YdVQfhX60Ic1C5VpmmmQcV/oLfFQJNwD8N704bz2WZ5jN?=
 =?iso-8859-1?Q?lHdsdk3z2D5Z+vSufqsuJ6jeH3+j3ZSwOld6SxOS8zdOmk5g+OUH/tix1Y?=
 =?iso-8859-1?Q?xh1N0QaU2g5apeUgYiBB52BN+TTW2TidV6bbnaAXyIZa/Ker8UREC+8Hc0?=
 =?iso-8859-1?Q?qVWJgsBuneIqWu6NiF/CUyE96pb32sycbDNZnyKbsFrjNfPoqjvYWLtSqx?=
 =?iso-8859-1?Q?P4KHTNDwYJDlNoMz0qAQIg86S82Xd1Ui0e8WAxa1KMD8IDiQDPWzoP2PyI?=
 =?iso-8859-1?Q?w2cAAeFN9NFVTTgEEAf6T0lDbpr04tols04/PHldtUTibR1qFiMa53+1RL?=
 =?iso-8859-1?Q?usgpiyVJoRrDhGflbffYCnfXLoEXIjpYT5nLx3H7ekg/ZHdyDaefwXesGb?=
 =?iso-8859-1?Q?MW1s+lr5fXNVdmqIr3NRDNSsSQRdDLvIpe/vrjczfw5i/Qb+VCdpx2JUpu?=
 =?iso-8859-1?Q?En4UP5xDTYg/OxAP0rHkBFS8nbMgAV9waDahHFArpNILYCjHJIL1KBntug?=
 =?iso-8859-1?Q?Yl5tUlbjnqja5kM1MuoA1+ycTF9+rYRix70tW6+OBqY8FgHFHnP4P3TBzq?=
 =?iso-8859-1?Q?elMhRpWiDjpRc9Emdg5V5KTdpewPl6Idq/LzgVWagZcTFltEeIOD0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?UFNv2QSi38nY7ZA4gM74wTnaCLNhzYf4R/456iN5QADfghmTJ0nrZCe6j4?=
 =?iso-8859-1?Q?x/hsZNuoN1hNbufzrcwS/NbGA1iMP/M1TEe8Ss9QmDiJXym9QMnHnQWvFD?=
 =?iso-8859-1?Q?urxXvQxX04tlq8iGYYH4QaAl3A7SXxyN1d/yPxsY30Dw6NopRCSqTb2EeH?=
 =?iso-8859-1?Q?bmKApWoZ8HKx9RIIvThxXjo4WU6OQT2eLumvRVLw7dcS+hsqTYGV2yxs39?=
 =?iso-8859-1?Q?YqDYxlXZJxP2rM1dG61nc+vHkrkzr0OZBc84SYhGexub5ypXSfzvUu0804?=
 =?iso-8859-1?Q?eTnjcJAtcdilQPgqhwdH0ek4jK5Y1LEIaGdC7iMWHMQSb2a+hB26I0P5N1?=
 =?iso-8859-1?Q?Z23WTwdyTJFOKLfeY3tncYqC5+aPszygvEY31DxrSwSvOJtp2ufzJ9gEa2?=
 =?iso-8859-1?Q?3tG3GlrC0KkbNzXxFlxWw7OlVS6c9JIDLDA33lGxRJvNw4uPA5nhaMStbd?=
 =?iso-8859-1?Q?7/1sPWOe7Y8AyeX6be37r3w0RevAY1q5SHGctnBipNv6XbPIXdURvdkVEB?=
 =?iso-8859-1?Q?2u01GNwvbVH367IVzQjl1X4nq3MC8///aRYCaCiYNst9w9OglaDJxjpnGT?=
 =?iso-8859-1?Q?kHEzDrCwwu76zbNQqj2A0CgOCVmE/TELAzxTITCzvhGvGvplPvs8fPSVCW?=
 =?iso-8859-1?Q?2LiJ9ZaHoIcb5A91pX4jCxd1Ly66YWiiG3qCXI3BHxAGrpziUK7uYIpInU?=
 =?iso-8859-1?Q?oTtYiFPcwe3zAXpBQUP3nfBaDwzPJ65wJgy1006O3apoXV/Ejvvivg4Xdp?=
 =?iso-8859-1?Q?AItVDPuZpkO394oYO/hNb0hsEQXDXAJDfDntIeAiQ+CWn8f6mY356F6MiM?=
 =?iso-8859-1?Q?3fQ732tGyPewTzjSKNSQ9b9RJ7HPxVmCTzy2d6UHT4Z6Pnga4akc27HI69?=
 =?iso-8859-1?Q?gdLG3UbQdAtAEg2d/zwUmlH10JAMcestxP3ImMc2i5j4ypIBZPdKWpINOm?=
 =?iso-8859-1?Q?AW4H9ajgwwERpkE0lE/R554utOHgsspyg6FNNqbNakXXbXOAv4Y6ZFvXHa?=
 =?iso-8859-1?Q?gWnznm80OWEHnTVlhzMe2yaFGqwq2ZQlxITXFsVmRSFUOR8dMt2zc2Dwa5?=
 =?iso-8859-1?Q?C78Rf0omafXVYKso91eWZPIuIZ7+rBXKMgXYRLC2mgf/PmRyW6uWqD4iV8?=
 =?iso-8859-1?Q?2SiAUwfZ69Upb+ymNUHv41fw4khdbS4fxrFyMgvmdhk+bGCmlt2kFwFq63?=
 =?iso-8859-1?Q?vYI+bYJWBDh1fS3ZWyQEnpL/OClBZMGo09owc/rMdG4VWN2ohiVJaHAxPN?=
 =?iso-8859-1?Q?kKRC9HDI2Aep35alqtlI8yhsh07VUO8+jJZRwqhM4NVs9+ruZ1caJbGEEl?=
 =?iso-8859-1?Q?9oHETp1tpL2tS3mSC5niDIweXGb6UD8wgPJ9V9XO/Z2YSHPq0xgAGlh+eV?=
 =?iso-8859-1?Q?MZ4fYk2W/QrZFgvvrc7yDD11WfjUk07nopwT8IlyH0C15pqKsYI5g3DgVg?=
 =?iso-8859-1?Q?UyrTGlq93qRGPORFB97HwYieiKZXvrSIbPR+0a9H9d5/SvWSYRJkLjUBXV?=
 =?iso-8859-1?Q?zzGFbLseXtIaDMxqFmIQULgWo68aYoeb04630aisunr8A6Xg2Rh5W8sQXX?=
 =?iso-8859-1?Q?BfsvmdKLPPpVAJsD58m2c4FEpIKM+TJiVdpphRDxtLqjlwSAa2WtzZXE/5?=
 =?iso-8859-1?Q?kEfU9nCxcK44wEWC04Wm20TInfFwBWAGGs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e161764-3f7d-43bc-b3d8-08dd190b3b7a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 11:10:19.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JafcHxqRK9qld9surxx8UXpyEyjCoA/ffMbNiASm6w1vbyrIELN4cmsqZEZ86SkGpL0PV94BxOKOJqpaOEwYqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910

On Mon, Dec 09, 2024 at 11:15:49AM -0600, Mario Limonciello wrote:
> On 12/9/2024 10:49, Mario Limonciello wrote:
> > On 12/9/2024 02:42, Gautham R. Shenoy wrote:
> > > Hello Mario,
> > > 
> > > On Sun, Dec 08, 2024 at 12:30:27AM -0600, Mario Limonciello wrote:
> > > > For MSR systems the EPP value is in the same register as perf targets
> > > > and so divding them into two separate MSR writes is wasteful.
> > > > 
> > > > In msr_update_perf(), update both EPP and perf values in one write to
> > > > MSR_AMD_CPPC_REQ, and cache them if successful.
> > > > 
> > > > To accomplish this plumb the EPP value into the update_perf call
> > > > and modify
> > > > all its callers to check the return value.
> > > > 
> > > > Reviewed-and-tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > ---
> > > >   drivers/cpufreq/amd-pstate.c | 71 ++++++++++++++++++++++--------------
> > > >   1 file changed, 43 insertions(+), 28 deletions(-)
> > > > 
> > > > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > > > index d21acd961edcd..dd11ba6c00cc3 100644
> > > > --- a/drivers/cpufreq/amd-pstate.c
> > > > +++ b/drivers/cpufreq/amd-pstate.c
> > > > @@ -222,25 +222,36 @@ static s16 shmem_get_epp(struct
> > > > amd_cpudata *cpudata)
> > > >   }
> > > >   static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> > > > -                   u32 des_perf, u32 max_perf, bool fast_switch)
> > > > +               u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
> > > >   {
> > > > +    u64 value;
> > > > +
> > > > +    value = READ_ONCE(cpudata->cppc_req_cached);
> > > 
> > > 
> > > There seems to be a mismatch here between what the API is passing and
> > > parameters and how this function is *not* using them, and instead
> > > using cpudata->cppc_req_cached.
> > > 
> > > The expectation seems to be that the max_perf, min_perf, des_perf and
> > > epp fields in cpudata->cppc_req_cached would be the same as @des_perf,
> > > @max_perf, @min_perf and @ep, no ?
> > > 
> > > Or is it that for the MSR update, the value in
> > > cpudata->cppc_req_cached take precedence over the arguments passed ?
> > > 
> > > Ideally, the "value" should be recomputed here using (@min_perf |
> > > @max_perf | @des_perf | @epp) and that value should be cached as you
> > > are doing below.
> > > 
> > 
> > Yeah - that's what the next patch does (which I think you probably saw
> > after you reviewed it).
> > 
> > Do you think maybe I should just squash the two?  Or would you be
> > happier if I re-ordered the two?
> 
> FYI - I looked into re-ordering and it's not feasible because you need EPP
> plumbed in order to validate the result.
> 
> So I'm going to squash the two patches, and I'll do another one that adjusts
> tracing locations for your other feedback.

Yeah, it is not possible to reorder the two. I like the newer version
better.


--
Thanks and Regards
gautham.

