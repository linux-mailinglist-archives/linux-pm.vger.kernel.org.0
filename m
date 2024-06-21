Return-Path: <linux-pm+bounces-9736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7CC911C04
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 08:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934241F24584
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 06:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983C113E022;
	Fri, 21 Jun 2024 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EBwcZpZm"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1DB15624C;
	Fri, 21 Jun 2024 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952193; cv=fail; b=A7TqfPg1gs8l3NZjo+ELqq0v2Kr71qPN1/V+EgznlNoZn+AUYtfwI4XkRiZ5yU/5WeJ2vvgt0sXW2t8Ovx6KoWXWaiQ4ojjz/HZqD9OJX+BZgtP/IUfJP5p0KFkdwiEJ9H3pdifbmYu2RtycCSP+G1FEt7dix7Y6AsPUzACy99A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952193; c=relaxed/simple;
	bh=g+D7/zt4VfGoDs5QKnM3JQOH6sumWJW+dp5WaKgvins=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NtgiHOFjh4dBItkMF9v/hf5WHWeouvCYKBP5HVOZjCALG7kuPJfyfYdKUxo6mG7btr2iCG9Osf3bB5lhP4YZrlYcbYnakzUj5eBlVhMG2kf8QyIjdwAbL4bNvG2MnC6+zYqTUw+SqYs/JlJjashFrlkLCek0KPJ9PWQA3DpvIuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EBwcZpZm; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR30zfuv4LKot4xZ+n1buIdRrHJet1voOkybaEzoOrg9ppOOv8Z98FNnF10ET1e22Jx+Ys4KX7BXwjmGy+X5xYsJska2IDw64iDN9JIArWhC7yzpLMas6kl8MQ6Ow5TCmMZqj2BuE89ZXnQ2NzdJ4xzrW5Je9ba8DEZXqVOerZRsKXRDlgaxeVvrk0QpqzPRPDgbzG+of210NL6AAJCa57b2QrT9hiqewOGv4dGWOiDD7M6QywWXj4TUrCWMOuk4ahQHOGRUVyIKloO4GFTBy9jfWLM4niFG0qDGPadnkYlaYc88cDB6vf1IOsh1Vc3CKwxBkHmwwajwEwt+dQW48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15lLPBzK7+7AZ/frt2Y2orQ/qFHqQ6JeXjWB3ZRlMfw=;
 b=M0OaYHDiIL086kBgF3AMf1+5jumWVbbawp2cAB3GFcoDHnVSeCg9phS32tdnrGSqnpunNt5XgoqzMhc62TDTPmVPKIlZd/ODgEgl3rntosnyzMALIZfAS1o9IKFJQMiq6B+WeGp9SwBaOO3fHbkqC/TabMEtsHYBPHL8aUZTLUMSyVAy8v3jVFyskLrAY8V74SsYnxpxGQcJ9dEbbrAoV5iDz+RNdYNCD35dQTVpwzUW5ebJjI0WB074GOHsts7Mk01ONra4BmLonlw4VDHS/NNIe1CF/IJjx4eQH0HS/vqEWY6cGzp2Q6dMiEJIcsllZEFmJwJCyx5dv1psjs9SwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15lLPBzK7+7AZ/frt2Y2orQ/qFHqQ6JeXjWB3ZRlMfw=;
 b=EBwcZpZm5PqWxS24G30xQAdVeqXb0A+oe2AkMFCImzISAH8hGwGPdqMahU2pHR1f6d4Jqju/eBt4sxqGQa+xx2O/lNDkx/kYSD8a2Tfkf/D+UlEXtCPz7BS2zg3ZroO6iZjTamct4sL42PHuIYK4FaYzEyQbYrLlBGC9+LA5kwg=
Received: from SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::17)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 06:43:09 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::3f) by SJ0P220CA0008.outlook.office365.com
 (2603:10b6:a03:41b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Fri, 21 Jun 2024 06:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 06:43:09 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 01:43:05 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan
	<perry.yuan@amd.com>, <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 9/9] Documentation: cpufreq: amd-pstate: update doc
 for Per CPU boost control method
In-Reply-To: <19cbf20f-cf06-4776-8d14-973b090f7242@amd.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
 <6b705dc178d484dd4f99e6bd134bdf09ee0a879e.1718787627.git.perry.yuan@amd.com>
 <19cbf20f-cf06-4776-8d14-973b090f7242@amd.com>
Date: Fri, 21 Jun 2024 12:12:56 +0530
Message-ID: <87a5jevlsf.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CY5PR12MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 5563cc09-f5a9-44f8-9f57-08dc91bd69f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|1800799021|82310400023|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WXn1MVW5XzdUsPrKfE840L0VE8c93gq3PwAjGdZugNsMkgI6hmYCVoV+WQXZ?=
 =?us-ascii?Q?h3roRwy2LJhAzIsEdkgijK0x3x5c5H0mLP0jIlfq5UsmYsCnYg6kQuao3NDJ?=
 =?us-ascii?Q?CupqnJco5A3+3N+LT4fvCmMNz77O7yKBOPZ4fq4x+QCQ4ld8esUs+a3RZGcV?=
 =?us-ascii?Q?YwW38sNxTKpSdrl9Tmb3gCGtb1w9x16v52xs6/xWyg0Kxj0eXhbMb5ONMaJE?=
 =?us-ascii?Q?jbxknN0yDrRTohZOnmb3o0u6n3vKNyN5kXUC7dgqpW4S5IPOVCHjWM8cIOpL?=
 =?us-ascii?Q?mt+IWsHD2UDZwRaMq9ebPKkQOCDJY3sdvAHuM9ToqtF4p4jlxK0gZkm1VUrs?=
 =?us-ascii?Q?9cAYn7fg3KEleGHC24QWn8t0Pzyn7MRvup/hj/nyS31rGhh03EnLIGwT/hD0?=
 =?us-ascii?Q?HJvbGNAnZe4v5sdfFer0UD4lrW35kVtkXJrOorAA61xr4CmIUTnyacc6+1As?=
 =?us-ascii?Q?d3V/ppGvuYCj6o9XCOaSwx16OD36qIi7bDKwkL9NaoahK0n9y8QMtgNH92+5?=
 =?us-ascii?Q?kiNYH3r4PxtluP2Y4klmwSA6z/OkCWfVBHNqAPwp3kXuP64GvuyDppRPrGAi?=
 =?us-ascii?Q?NZZv4XIKmZkLkYuC53jj76orFrnus9EjbLYJ7LFHVtP5BK/I0ft+SBlFZU33?=
 =?us-ascii?Q?q2JULePmBzCaSM4ACK/HL5bczNAUvR6FT74VWh9jvjz0iXJZJPEmx3V5bQEp?=
 =?us-ascii?Q?b5/Dz+82NcSKswHZyw5g06vSOAYCJiJpaQPn6Vv6LqpNJaTbELxab71dTyLg?=
 =?us-ascii?Q?TOQ+Gj6S0XVsOOrowxHM0EVftphB8QK7OW4JWkHJf0WjAHD4EPf4lgyJA1VP?=
 =?us-ascii?Q?QGvbXEOSSbv9JY53mL88YtaU2QzZ3y8lCqM5YD1qYLN6xvoiJQdJ3N/ixt08?=
 =?us-ascii?Q?e5cK6wLrQSZXZaroRNz4yIaa1UMtp9NqWHQ7nkA/HSfkuu3gOIu6ewxNN2yZ?=
 =?us-ascii?Q?3x+zwsjsv7iRqKIcLcJ7MOHkoaaHkz9G8bFjWCbTCYBEERM9XFhv5LhVrWgO?=
 =?us-ascii?Q?ZT6Sj8PQTi7+DbJKSRBWOZN8Fmbs8o4hkl3ngj/bLWroJtpSod3PbMsSSMHf?=
 =?us-ascii?Q?kGqOSagoH6cmwxmv5ZWMkqeAZa/fPPzjLDUnQaXFvxgK7FSGuK8sklbxgR+j?=
 =?us-ascii?Q?20pVnDjoZkNA9pZAZRpDKI0xO43onqFeK/j6fBTaylRgXqfnpRXNyFNkAr+W?=
 =?us-ascii?Q?DmkOA/nY0USAdWw6Wi3TurdVRsNjrUBuKEw+Lt7ADwmSixbKP7Idb7/QdEfA?=
 =?us-ascii?Q?unxt9TjmL5tTthVRFOXUq0wTnj6+xcnIQoQNp62ceJmWl63+F+ArMyvok7Vc?=
 =?us-ascii?Q?ztkt3h8NQnMQIMO1JcSu0uRGz7frCtEPq+vGwxqkXw9D08lUcK6euQWicjag?=
 =?us-ascii?Q?WEb5chYvOpCLGBElHEnoRsjhP34nGSQtjCwsxVz7O3oXN7sBBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(1800799021)(82310400023)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 06:43:09.0312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5563cc09-f5a9-44f8-9f57-08dc91bd69f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324

Mario Limonciello <mario.limonciello@amd.com> writes:

> On 6/19/2024 04:16, Perry Yuan wrote:
>> Updates the documentation in `amd-pstate.rst` to include information about the
>> per CPU boost control feature. Users can now enable or disable the Core Performance
>> Boost (CPB) feature on individual CPUs using the `boost` sysfs attribute.
>> 
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   Documentation/admin-guide/pm/amd-pstate.rst | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>> 
>> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
>> index bcc0d9404c18..98e43c53c387 100644
>> --- a/Documentation/admin-guide/pm/amd-pstate.rst
>> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
>> @@ -281,6 +281,26 @@ integer values defined between 0 to 255 when EPP feature is enabled by platform
>>   firmware, if EPP feature is disabled, driver will ignore the written value
>>   This attribute is read-write.
>>   
>> +``boost``
>> +The `boost` sysfs attribute provides control over the CPU core
>> +performance boost, allowing users to manage the maximum frequency limitation
>> +of the CPU. This attribute can be used to enable or disable the boost feature
>> +on individual CPUs.
>> +
>> +When the boost feature is enabled, the CPU can dynamically increase its frequency
>> +beyond the base frequency, providing enhanced performance for demanding workloads.
>> +On the other hand, disabling the boost feature restricts the CPU to operate at the
>> +base frequency, which may be desirable in certain scenarios to prioritize power
>> +efficiency or manage temperature.
>> +
>> +To manipulate the `boost` attribute, users can write a value of `0` to disable the
>> +boost or `1` to enable it, for the respective CPU using the sysfs path
>> +`/sys/devices/system/cpu/cpuX/cpufreq/boost`, where `X` represents the CPU number.
>> +
>> +It is important to note that modifying the global variable
>> +`amd_pstate_global_params.cpb_boost` will override the individual CPU settings.
>
> The whole point of the global cpb_boost is an easy way for software to 
> turn on/off for the whole package.
>
> This makes me wonder if we want a "custom" string for the global param 
> if one of the CPUs has been individually modified separately from the 
> global flag.  Then software can very easily tell when it's been toggled 
> for a given CPU or via the global flag.

Yeah, this is one usecase which may justify the need for a separate
amd_pstate/cpb_boost interface. i.e., if there are users who do want to
reset the boost state on all the CPUs if individual CPUs have
independently toggled the boost states. 

>
> * Basically if userspace wrote to a single CPU store a bit in the global 
> structure to say cpb_custom = true if it's not already set.
> * If writing to cpb_boost from sysfs then "cpb_custom = false"
> * If reading cpb_boost from sysfs and "cpb_custom = true" then double 
> check all CPUs.

Actually, we can maintain a counter which is set to nr_online_cpus when
the global cpb_boost is enabled and set to 0 when global cpb_boost is
disabled. When each individual CPU disables cpb , we decrement the value
of the counter. We increment the counter value when some individual CPU
enables cpb.

So global counter returns "enabled" if counter == nr_policies, returns
"disabled" if counter == 0 and "custom" for all other values of the
counter.


>    - If they don't have the same value return "custom".
>    - If they all have the same values this means software has updated 
> them all, set "cpb_custom = false" and then return enabled/disabled.
>
> What do you think?

Could be done. But again, are there users who want to see the "custom"
value ?

--
Thanks and Regards
gautham.

