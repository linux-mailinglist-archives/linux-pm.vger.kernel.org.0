Return-Path: <linux-pm+bounces-18796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9DA9E8DB2
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 09:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3628116129F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F207E2156F2;
	Mon,  9 Dec 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1y23mgng"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB9A136357;
	Mon,  9 Dec 2024 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733750; cv=fail; b=u+ctQuiQNe+ZYEJJfpiqLr0MbIDxeQKT5A2YXdOOlQluH1KfAqGM0ot4DV0GNMtYu/8m+mEjVx9I5BlL5KwS5nhYETVLT6Cy1GwHq/Dj/GYRoZuceSacUagUTZkz/hIpW6G4rH3Q8NErW0BFszNWklBkxUMd5LOKFSlGifxg/YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733750; c=relaxed/simple;
	bh=ZrLfjKW8547+Ny3YS+hl+jpa9eVFgfkjN5ACUJVym34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bisjqz/pXPYrG6mK/F5khOAMfQuJVkyc838mgxuJ4KsOP/VejIfFmyZ6KwF+OiG7f3DZTKHUvtyB19c8Gv756v01gUe5HJ7AUOgg2KaQzJ7s1qbUAQmjYSpbkJ9gNL2eajN2BgbgQp/T6mWy7C5HrduL+CRcJVuQqB5K63ucxP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1y23mgng; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnfZ1/+HPW9JsjUqWmZ3PLrU+dc5/ODQhU6oNb5gd2dYRo2kS9rW9HhNKKBe76XigRfCw87bUoIu3M7OjLrwgXMF1dtO05RXhzuNTB76gkh0XhlaOlLLuVyIL2Ybg8D8dU/vU+3G2D9zVQA4Iw3+n2uQrZFAFPKbH4QydE185iHoJXTg4vWXyk9Oi+O6q0SJl6sjNVIH4Qr9H8wbIwPEMaXUxw3GBqTWCklF43ziUnXU5iAi7YnU/D9Uvp8RNEW3U+/iWJH2hx2nWnI3Pc3gZzuj53dW8EzER48t/kD6nxN5D54yqtprXZ5XPLmYBLVW+kZlUlqpYXo5VXQLzLkQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIfdz+LPIG91BCsOvka1Yu3yIJS922sz0X8U9Dx2GRg=;
 b=ugd1zeDIuslzUkJe7xapXpf07LDIB8dlFtyxxLoH9tvSYAELj0D1oPQ/xBKPipIZYeNqVBAOvt2KSADUeGOTR3eu+VZ1QGTnhcRWylI6bdnLvXplutSjVkdYXBFK0Ve4tfXfQdzx7fgzUwRc0WGBz2AzMTcyIA/McvCBnAaNxGN17hU1mmCwX+GBbvw+1QinwZkBn3GcHNgc8fIZx1rD+ZRh1WmsvO3qcaDmmKZ47MhAviXF+d6W8mQmqtOyhsD0mSryS5LQlWqrd7E0bBCyj8NQs9PRklnQqaLCRgcaDlqI03xwVGHHkVnvq2od9AtX1PGlVlNi24Vcz0CPOqQHOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIfdz+LPIG91BCsOvka1Yu3yIJS922sz0X8U9Dx2GRg=;
 b=1y23mgngVt4vznZVEmQu5fgzHqjto+b9cN+E8Q8PDBZpPRTvD4Ym5lMVoBULgs2FAh7/51Sq6xi9CHbQbwhfYsSiqm5eMGk0w3D71+tp5XjhXlShH2Q2XqurqacarYJC9MJ5e4p1KxRKTbefZO2H+nFvQ1GBAKc7NYOFai+l348=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 08:42:26 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8207.017; Mon, 9 Dec 2024
 08:42:25 +0000
Date: Mon, 9 Dec 2024 14:12:13 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: Re: [PATCH v2 12/16] cpufreq/amd-pstate: Always write EPP value when
 updating perf
Message-ID: <Z1atZRyH3dbWQYjv@BLRRASHENOY1.amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
 <20241208063031.3113-13-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208063031.3113-13-mario.limonciello@amd.com>
X-ClientProxiedBy: PN2PR01CA0231.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::7) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: f611227d-16ac-45d1-86ab-08dd182d683a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z//mI9iJEPMB7/0va6NDvU0Xq7wOdI7jjmQiQop91ZN7zp6iGZC6u/BS6IZ/?=
 =?us-ascii?Q?lZ5d3jdEdon7NmBjXL8i4zwP3C7Gpt8SpnHeGv+VAHgzhDbkZDy101Fpf6xL?=
 =?us-ascii?Q?HugAHFB6ILjjL626ueJH/D7Ju4Od7Lz0kS1EEPEVgDUPmoJsv089ka5TYKBW?=
 =?us-ascii?Q?Uh9k+yenGGvl46pJdVlqXaoTBSwFXz9tjuVzo1MwfHZBMHAXtmEsFaZvF1W0?=
 =?us-ascii?Q?PnSEpIrQKU+kvsNc4sQzUTesRNJTRKtp4W6FzFbDnNbgRPpDmb6VrO1HCKuo?=
 =?us-ascii?Q?4NXCegtb7NKjnn1yE4gqhbppnKVdjZkqm0uQXF3PJGAgFUzuSWfMmUEDtVrS?=
 =?us-ascii?Q?jCLYZAhM98EBrfB4FgJLhWoPziZi79DTuO7OOu9zcjd4qbWc772FuitO9IKA?=
 =?us-ascii?Q?6thlspfbBkzfQn9jgScnqX9ph70EvAbs4B3M4pntC02GaOK6O1zXfPdXphVD?=
 =?us-ascii?Q?dMGmJCRmXBX4q9VqWebB0nV3awWPrrQxwprrkFscs/UPvJ5mJLU0ASH7gRsv?=
 =?us-ascii?Q?GdbgM6T8Wes4qDBtoLEP2Z9fHiZdmwTQ6ZOr81qcUNLQ0+0ptxlUyELVepe0?=
 =?us-ascii?Q?xjuehqOg/BGrMewdEYssw2sBMG2hB43GWdvs3UWpErKxI1AUUHLu/LECn0I3?=
 =?us-ascii?Q?6NFrgNr9Bmk20s2K5qiV9eJfVnFhlpC5GOdrWxMNhvC+zPGbO/nmz3hQx6ge?=
 =?us-ascii?Q?JKnETkrI8CvKq3Vu1eftu3L8xuUsghbTxPm9BtdzA4aqVSzPei6RmVzGcutd?=
 =?us-ascii?Q?5lZytjuZlfysr8cz9YEt0D/ruoHY6pzo/sBimrw9rae+axi6MFk9mZlcQgdd?=
 =?us-ascii?Q?sleK0if7vJbhv8G1i59X0OzAnenrHyT47TRpLSp/VqmMRvGsGTCnAkudNtp3?=
 =?us-ascii?Q?eXi7r/1wQcopfeGJCZaG7W2xhPJhskpCUJ2LcBHUlH6tNrpQmYy8S+rjkow9?=
 =?us-ascii?Q?2Ma+2nZEIamLoO4L70VsJw4sjpGe2g4WHRMIEG/Wj1YSzRQJHAs4rzvuErhF?=
 =?us-ascii?Q?SQmG5ycujt/qpTH+KEnNLBpVRTaJGSHposu8/4fhEdLZU/+9gUUhobp2nmAh?=
 =?us-ascii?Q?iYvO3+ioTw7Tfy1Ez5va/fW0qopAHr4qEIeNxnApfirPsk6W1sJtMMt5fjY4?=
 =?us-ascii?Q?Y9YnXlghqn8AdzYdIyAqeXfSsqLSszUTb4ljdbMMXvCgqtxqRKtmQeTSyv7N?=
 =?us-ascii?Q?ex0hNzIIQouU0BZWwhgPG8x0xAqAL+b6CZyoVR/UVc/TFUB9GWu9lQH1VdKE?=
 =?us-ascii?Q?HH2NAY5QBBIEgt92RWxSg0rXRMGK3zhEzscBM6jQgQHLb0pWeQ3Ra9F/jgEw?=
 =?us-ascii?Q?P7/3h5Kz9zsY5E2UVYHX6NxSpqRcEt4+2eBGKLKcxBwyg5IBq/QZbT2q+WOc?=
 =?us-ascii?Q?D/BKehQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tQF8TxX4ntPB4UlqaaAifuJGjwxWIzPuvDkOB7xPoUxW7W4LEBr1PVQfoTct?=
 =?us-ascii?Q?gVY0yKheI4DTfYdBULc3Q2GbVwbDyyff+/JabZqfgtv2EVFq+2nSlUdoLkaW?=
 =?us-ascii?Q?6o9qKW0pg5xM6zu+DqU2i7L/b+pya4ZxuruqAdHcW5EUbHGYqTzsZp0SiAEL?=
 =?us-ascii?Q?05KJTpK1mHXzgGX3wwoEXT0mGOqjiYUNDspp16LUHNCteKFPzX4Sg26tHbq2?=
 =?us-ascii?Q?jNqfcH507NrUHmYVBJbU26ZqIIxkVolDqIOAdV5VnSDq/aAX2bYUtP1KgxEE?=
 =?us-ascii?Q?9J/wjb9mI2WYS6D6IQpM6aUhE+y5ty8anqgzm3HrUqPI7lJFDfadB6SOpZCm?=
 =?us-ascii?Q?HQTATqFkGXYOFKDQ9KZD530WUwonC314s0oB7DbVmN3PVfMqcG+zsWzQIltJ?=
 =?us-ascii?Q?sq5r3ecdneVz4nAD+NvU+QETvzN9WdaGMoQDbL8PSrb9xi9c1Lv51gtD8Nst?=
 =?us-ascii?Q?aC1KbdFf3bDXH8mdalPsQsmvh9xdy5uJRZVbqnYSX8idAdhFFHnhycxKGNNJ?=
 =?us-ascii?Q?+bxL+SkOHZ7sk0tQxq6D7jyiCAAhcn0ItqCU+HUNsiE9jm7Xq6RzXbD4Imv2?=
 =?us-ascii?Q?8cd8Y5ybStTXpFL03aZEFAmlJxh6BP+MQx0d0ns0b+psikZXS02e6TaG/itd?=
 =?us-ascii?Q?lhnjQkW8nf/890E3srWL60ELARp3KHAoHPB6oKiANUG/2tWvP23hDV4he6hq?=
 =?us-ascii?Q?J1ZKsuWc0fRqKHncRpFAjkcEzsJqb9cgZSd/7R3OvxwVNuoRbuSepvJw3wcP?=
 =?us-ascii?Q?JrNUScj7J5Fp805Vg7Nrmpirmu7KorUGD8UaD1gWIdGZYfFjd0kvCNnnUuNR?=
 =?us-ascii?Q?3Hz731vhkrjWYqhoukhZbr0Af9lMO1gwvz69AhMq8NhtQxI3BrfKcLxtxsM5?=
 =?us-ascii?Q?4QFeCh7PuhfyzKz4L9Dk499aF3vBdiggTYNUa4wG5ZJBUkEn+C9K9Vc61i61?=
 =?us-ascii?Q?OCuN6iVIP1jfQ4jOkWHsyKI96HDYzcUT4dREUn8g67lhqsKaXqtn3w7UU2sn?=
 =?us-ascii?Q?tS70dpL9Aw2t66De1mcoHg4MoMWWC+t5S0BhN3AxbG07Ja/D5Kvx7wItt1dy?=
 =?us-ascii?Q?tHfdB/3aEC2cmnBNzuVWazCghx4ACxuOeofki1YgspgP66WBCyMppandpnYJ?=
 =?us-ascii?Q?+s08e/qHz9IAWu1T4rOA+8e1CuP3oB+puUGFCZ2cZUmuaXxF7wdsE68xaKg8?=
 =?us-ascii?Q?PYR6g1TULXYXPtqLIFTJ171KvuyZeyS/cre1fx4v2EXiDsqF8zC2hk/QZ+tr?=
 =?us-ascii?Q?lf/yEuRQ8zlK9xZQPgmLgAy5thHSZrXMlhvrdu+ZlDaEBB+qisgOMB+r4u5F?=
 =?us-ascii?Q?EfKYF3UxKjWtOE4ZyS7tgQf1F0gXsJ3j4CFRk2iuEcGkHmP7t4mP8QosDZ7f?=
 =?us-ascii?Q?LleWhXTatgBYtqDkBKzFrvutHRzZWL5UV4q5EhuZVgpUKF1tznKmna4y6T3e?=
 =?us-ascii?Q?TLOMFQtwMB1tkpsYZ8BzcBj/CljxpaUvB+WVGv4LVvaKfzWBGI4Dmp+K695O?=
 =?us-ascii?Q?58Y/2RmC6Om+WMWpb+aDaP+dmiXGHpcY5BESNQ0E0Q0GqBE4ZukDzUN127dc?=
 =?us-ascii?Q?+SyCzcwdS2P+/JV18z7FZutb7HjC9+oi6XHjbQlE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f611227d-16ac-45d1-86ab-08dd182d683a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 08:42:25.9195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yQDy7LGxbW2oZRCJ/4yPMWx0YQXHOpmvDrPS8MY9c7tUfyZwPn9JJFjGoEO5QnjqsFH0EQdi1Ljlh1Vsf5TuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910

Hello Mario,

On Sun, Dec 08, 2024 at 12:30:27AM -0600, Mario Limonciello wrote:
> For MSR systems the EPP value is in the same register as perf targets
> and so divding them into two separate MSR writes is wasteful.
> 
> In msr_update_perf(), update both EPP and perf values in one write to
> MSR_AMD_CPPC_REQ, and cache them if successful.
> 
> To accomplish this plumb the EPP value into the update_perf call and modify
> all its callers to check the return value.
> 
> Reviewed-and-tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 71 ++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d21acd961edcd..dd11ba6c00cc3 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -222,25 +222,36 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata)
>  }
>  
>  static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> -			       u32 des_perf, u32 max_perf, bool fast_switch)
> +			   u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
>  {
> +	u64 value;
> +
> +	value = READ_ONCE(cpudata->cppc_req_cached);


There seems to be a mismatch here between what the API is passing and
parameters and how this function is *not* using them, and instead
using cpudata->cppc_req_cached.

The expectation seems to be that the max_perf, min_perf, des_perf and
epp fields in cpudata->cppc_req_cached would be the same as @des_perf,
@max_perf, @min_perf and @ep, no ?

Or is it that for the MSR update, the value in
cpudata->cppc_req_cached take precedence over the arguments passed ?

Ideally, the "value" should be recomputed here using (@min_perf |
@max_perf | @des_perf | @epp) and that value should be cached as you
are doing below.


>  	if (fast_switch) {
>  		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
>  		return 0;
> +	} else {
> +		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> +					READ_ONCE(cpudata->cppc_req_cached));
> +		if (ret)
> +			return ret;
>  	}
>  
> -	return wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> -			     READ_ONCE(cpudata->cppc_req_cached));
> +	WRITE_ONCE(cpudata->cppc_req_cached, value);

Since cppc_req_cached is not changed, why write it again ?

> +	WRITE_ONCE(cpudata->epp_cached, epp);
> +
> +	return 0;
>  }
>  
>  DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
>  
>  static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
>  					  u32 min_perf, u32 des_perf,
> -					  u32 max_perf, bool fast_switch)
> +					  u32 max_perf, u32 epp,
> +					  bool fast_switch)
>  {
>  	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> -						   max_perf, fast_switch);
> +						   max_perf, epp, fast_switch);
>  }
>  
>  static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
> @@ -459,12 +470,19 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
>  	return static_call(amd_pstate_init_perf)(cpudata);
>  }
>  
> -static int shmem_update_perf(struct amd_cpudata *cpudata,
> -			     u32 min_perf, u32 des_perf,
> -			     u32 max_perf, bool fast_switch)
> +static int shmem_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> +			     u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
>  {
>  	struct cppc_perf_ctrls perf_ctrls;
>  
> +	if (cppc_state == AMD_PSTATE_ACTIVE) {
> +		int ret = shmem_set_epp(cpudata, epp);
> +
> +		if (ret)
> +			return ret;
> +		WRITE_ONCE(cpudata->epp_cached, epp);
> +	}
> +
>  	perf_ctrls.max_perf = max_perf;
>  	perf_ctrls.min_perf = min_perf;
>  	perf_ctrls.desired_perf = des_perf;
> @@ -545,10 +563,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  
> -	amd_pstate_update_perf(cpudata, min_perf, des_perf,
> -			       max_perf, fast_switch);
> +	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
>  
>  cpufreq_policy_put:
> +
>  	cpufreq_cpu_put(policy);
>  }
>  
> @@ -1545,6 +1563,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
>  	u64 value;
> +	u32 epp;
>  
>  	amd_pstate_update_min_max_limit(policy);
>  
> @@ -1557,23 +1576,19 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>  	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
>  
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> -		WRITE_ONCE(cpudata->epp_cached, 0);
> -	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, cpudata->epp_cached);
> -
> -	WRITE_ONCE(cpudata->cppc_req_cached, value);
> +		epp = 0;
> +	else
> +		epp = READ_ONCE(cpudata->epp_cached);
>  
>  	if (trace_amd_pstate_epp_perf_enabled()) {
> -		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
> -					  cpudata->epp_cached,
> +		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf, epp,
>  					  cpudata->min_limit_perf,
>  					  cpudata->max_limit_perf,
>  					  policy->boost_enabled);
>  	}
>  
> -	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
> -			       cpudata->max_limit_perf, false);
> -
> -	return amd_pstate_set_epp(cpudata, READ_ONCE(cpudata->epp_cached));
> +	return amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
> +				      cpudata->max_limit_perf, epp, false);
>  }
>  
>  static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
> @@ -1602,7 +1617,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
> +static int amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>  {
>  	u64 max_perf;
>  	int ret;
> @@ -1620,17 +1635,19 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>  					  max_perf, cpudata->boost_state);
>  	}
>  
> -	amd_pstate_update_perf(cpudata, 0, 0, max_perf, false);
> -	amd_pstate_set_epp(cpudata, cpudata->epp_cached);
> +	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
                                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
					       
On an MSR based system, none of the values passed here will be used,
and instead the value in cpudata->cppc_req_cached will be used, no?

>  }
>  
>  static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> +	int ret;
>  
>  	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>  
> -	amd_pstate_epp_reenable(cpudata);
> +	ret = amd_pstate_epp_reenable(cpudata);
> +	if (ret)
> +		return ret;
>  	cpudata->suspended = false;
>  
>  	return 0;
> @@ -1654,10 +1671,8 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>  					  min_perf, min_perf, policy->boost_enabled);
>  	}
>  
> -	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
> -	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
> -
> -	return 0;
> +	return amd_pstate_update_perf(cpudata, min_perf, 0, min_perf,
> +				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
>  }
>  
>  static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
> -- 
> 2.43.0
> 

--
Thanks and Regards
gautham.

