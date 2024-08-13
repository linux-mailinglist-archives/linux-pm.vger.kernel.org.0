Return-Path: <linux-pm+bounces-12142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC1E950267
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 12:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696D4B25303
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8EC18DF62;
	Tue, 13 Aug 2024 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RDTeBjVE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70414208AD;
	Tue, 13 Aug 2024 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544753; cv=fail; b=i89H5tTE0NNQkgmjuTB0H3B/IP2d/W/GgHPL2NuawHhEM3GBTzx07LK00DCaXrFZ2BxFA/b8Ex+SwXWDthmeuC89xk6og1nATaHqsH1NcJZDG9peuQuLW5OujO+BJ1Q2GHRBICz9NRXyzgKToJLEW6wpTNGM7mCn14qeCjAxbME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544753; c=relaxed/simple;
	bh=Jyp9dO3Ww2v4d/E5EpWvmEA3y3Ch+WAlVWGPkk7PHuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q493hpSC9n287OxHxoWpZ4z8mqW9CJG+m6s7dyD5HZ/zjtlRrsaxGOZ2yE7Xc3vwggTKSUobdt2RCqXiu2OuERivZDhhDYt7ctY06aTTsWnkqqc5OaXvLzhF6+ABef0cIyKGnUajOallxM5L954pzE7rWdwHeHHJLEskWex3IXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RDTeBjVE; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRih1cay4VsdEdzZ8EoOU02Fv4MEsTqHNPVxMs6kOmJ6FYY1ctl+g64sVnXp1xMrmrYL9sL85BxOUwt3NqTgost63cPgnprNmblGWJYVaQKScawob8w+Tj/5Sme3J55lLYciNRtqq1x6YuPIoaB/FCY+BmUxHqEfCGBjjV9kWEbt6EkMHjHb/gasqWKKjqiaDLh9u1PoDrnc4awE0LzR/rl1vlt3HMWkXkbNHpW5+zl9MOSIPOPuHXjT6eROUXwOp4luDjlrAlXR+k9D6kxLjdzLtfGqJYqWKVw272CpbXNzvHWX7+MoH8ZqbFYVTyAFdrW/zMmR5Ubn8635O0EEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MRUz1o7KtJ04eIwwvEw6uvfzmd4TJqe1hZ7ZlH69x0=;
 b=GHeKOYczkw3MgTl1gsXDXEWRWPqAWhGlaH1k4mnbXw2dEhkajzc7UESGjhfvLfRpE4noSTf8gQXMIyaMwC+Orvxx3RdJizG4KqU1KH780kkBMVFGWw4EXBaGyI24MQQYHJjHbQePG60+KwZyAubRuRULddcOt+cb7G3lZtDzURZppPGsy0V7taTSp92ZLTWbPQsUMimw3PxcOx4K3w7a1cJxZkn39yb/GH90c/r2qamrJY4q+OU3ov00RGtyp5KDPXPF9gBbRIMLWERoD2rZ389RkjM89mqr/2Uw5RMQPWPvLHy4/7CpWZ0gZYRzWMeSnexNvaqkFM5m8df26mAMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MRUz1o7KtJ04eIwwvEw6uvfzmd4TJqe1hZ7ZlH69x0=;
 b=RDTeBjVEM40vxsKy/pNyThGPWHnu9OqYMc7dIkEcwd6bhDRp1k4+0sYK9cULK7jxasLnwQ7FOCMJ4Y75Eglr8LWGay7dKVrAm08ncNMdb2Ym8blKVpBSnScaWS2gHocKNB8QNmtUao+izvqtWbCpY1bctxll81AvaRD0B3WlXglWAQBxqmEtdtWjdcQPPvPxN3OQ4v9/XFOQeqYOTUrCvtu88mcAA5+ZHEPx27k9LfRIum2TYa3NK0ikpTWmL5I4heBBXE2nerqYcvJUqaQWIDgmJrvzowdCTxZ/ilIL+qztmB3QRk+GO389WeqagDdstyO/TEF/zfuZp5kf2YikOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 10:25:48 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 10:25:48 +0000
Date: Tue, 13 Aug 2024 13:25:35 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
	Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 13/17] mlxsw: core_thermal:  Use the .should_bind()
 thermal zone callback
Message-ID: <Zrs0n6oLSbG3MzMs@shredder.mtl.com>
References: <114901234.nniJfEyVGO@rjwysocki.net>
 <3623933.LM0AJKV5NW@rjwysocki.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3623933.LM0AJKV5NW@rjwysocki.net>
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: a56c2c4d-cd53-418d-aed7-08dcbb824c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J+SPa7AiJ0jamJEbP/J73+90SLJubWOoLtggk2BcwRc7TWyMTPGUODXs4CQF?=
 =?us-ascii?Q?Me5CdKiyCr9LxYXYYormYgeGTIpSU8RstpmfTu3rr+CFV9aXd2WFz2iyus0F?=
 =?us-ascii?Q?pMmCY9C6M2Zw0/Z6tTbAuDJtviKWvKTwzOT/uUigR6o4IyMg66ieJMzK+F5L?=
 =?us-ascii?Q?/6VQrN0fkVyu31c9XEuJwZ8yaebs3A3VkS8A9F5/tgdv4pFcaj6U/4QquO6V?=
 =?us-ascii?Q?XmHfOnOrZXjgUIy3E0phxEuqMBTgIeUMh8fVhv/GcxSoEUnjipZjmTysJh8j?=
 =?us-ascii?Q?NWvt9i8YAiO0AfZ+3eUAu+xV1EhyLpmaCHygjIwCDPSKAOoyWYok7nnaP8qO?=
 =?us-ascii?Q?Nw1sLjNViRVQ1XrK758yD2z+CSxjHWJwpcB5B3DPfWk5jEj7TMzpwyxfpdjo?=
 =?us-ascii?Q?MwBnpnKdr2EFIgFp4wuak00MMxZqx+ThxWwEqj25oQ3T4nZ1/S/02N75mTxX?=
 =?us-ascii?Q?q9K8qRxS63MIlG0fsZ2ndgkO/TYxw6ltxSfPSRd0yAQcBJG1jQRXXIEkA9XU?=
 =?us-ascii?Q?lV/AmQErBB4Syoy0cs/4z0Kjpa5j2Ydr3g8iU2BlbZtLTB8WsSdtm1w9jub7?=
 =?us-ascii?Q?TT2FfkFPoAFT5GReYw7QdUnqf+vlNeK+Cv2RCJHLxLbu7WA9bdip9dx7xXp2?=
 =?us-ascii?Q?oVFudj9HCEpnYOZWsjGV6k2ANKCuuABWDsxQamCBf7VuPhPzyg1Y/PcCrfO8?=
 =?us-ascii?Q?7OXg1lTC7ZNRvI7DiLXVhj9pZ1mgr7RvPLlFAKt0T2pZndxhtY0zFcCqyAiN?=
 =?us-ascii?Q?4RjVx+OmDQUxjAGbETVPKOUYlZSYCmkOEGRc6I4K+GxnjGOioh3h+X/KCjvW?=
 =?us-ascii?Q?GYQLb1FeQbUDqtkXLMVP06r/ac/aHOreYWXPL4fQ1Ebp0vLdcWLS46MyT+Om?=
 =?us-ascii?Q?p2n99Nsdrfje3tRMFkjgWg7EqGlQjdgKze4nMQ5kpHAY0X31RdtbjPe5JECy?=
 =?us-ascii?Q?NsPae4oha9fVzbjRMame/g3r0sWJCOgKKaP2Waf5U/pxFDe20J631EWi4jEz?=
 =?us-ascii?Q?trvUMksSQMcb69gpoOabfNqjCWJOLxlAKwm0VzmkxoXIlJ486YwhMQ1rXjdn?=
 =?us-ascii?Q?9BUIKVmogXPVQZcrSBxaZ2d6qN0ymP+JzA0YgP9nnaI8+kEh+mIeXgAuUQT3?=
 =?us-ascii?Q?oISNF6te/+NGAGshJWZOWPy5JSH7TeZnzSWbncAraAXu8CR7poXXyzYaE4Lj?=
 =?us-ascii?Q?eljDpBG765Jud8zSz/Fl/xGoyIO3KRm5QsisfMAvljrckZs+CBD80/xOhmFh?=
 =?us-ascii?Q?dR9xzNGPHyh3Y1tWTPAV4PE5dcMMmclO0BaY1Yi+oTW+eEBCrYoK+IFPY+EO?=
 =?us-ascii?Q?nHSPNguk6S1SlP8x8j/NnohKYBUN5YvXd3W2J2vGbPANkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NAd5uYsPrmrNwm6SpgoRs1D7Rq8iWovw4+Agnjn4LFU8iG2Id22J1MJdt2vX?=
 =?us-ascii?Q?/t8tMGMKx/TuEmK7Ox7v62gaTzAkLLt02cEGO0Kd5YOv//PybcAz+1hQVX/C?=
 =?us-ascii?Q?LMCU6Lzyd/xSijxbTv5esWL5rEcBRQJDmJFFKNvHNUdahna6/JetnGT9fX7I?=
 =?us-ascii?Q?NVgCh7ihJMS3K/50QzBYxOnr13NDveYI9OI1/lGoZszJejbl1krnxj6HVonI?=
 =?us-ascii?Q?g7SB5ApTaE5teUXNAcyuX9jtfFrH6dqrFB0hMym+94imUtaPXL9u0NFpFxw2?=
 =?us-ascii?Q?NWg/kmSDIlekBZBbvOj0Tk9lM5njJH3re/Njt5ScMzd1TwDdEqhJsVH+kbLt?=
 =?us-ascii?Q?2z/LnEbVmSLjWntkGj9GuyMhHyAaXgjWwuODBnTiUQ3B6+1vw/F2B738YVHG?=
 =?us-ascii?Q?PASUPyM2zPR91Cc/Z071VvuS9p74fjHjtnNtQ8E7ATBMPnDLDkxRhHcPwdYZ?=
 =?us-ascii?Q?GVPl0nnbrDofhXQ+RVkILX7aaEk9s/fmN9QJ2NbRlV9CoE/zTgTndHXtiO0l?=
 =?us-ascii?Q?3TAzMqI93CaLzOQFZv2qzaSPyczqcvYjZ23XDDZQnLaCcznHmfN9YvP8RyDl?=
 =?us-ascii?Q?HAIG1GLhXzmU3IgA0FgaEZjy/922rFpUHRdYK1nJH5dywcXlx39Vtj1dgWaE?=
 =?us-ascii?Q?r+koZdPpzS7Yb6da8Kd1X29HG8RsdiSCcWj07OhHplsPUjSs3XTMa6N5PEN0?=
 =?us-ascii?Q?NEPOTxtSex2A1sETPHBP418FbFz2IvNRedM7p1qZvuWabL1oGSMZoI446teG?=
 =?us-ascii?Q?x5APZySChM4R0kyvSxTSVofxXYhArH6u//wBOqhRu1wYbXPMk9dTDssQlu8W?=
 =?us-ascii?Q?4rM0cknGtjwTW9eU/hij9tHm0WjZju0X2lGfriE8ZOBgQRjrJqM1bCEH1XN+?=
 =?us-ascii?Q?hXp0CTxeQ9hRuMx7/amjam+swOAf4WYRLE8dznV5jCc4bYWdqig2Tctsfxnc?=
 =?us-ascii?Q?kTa2vxwAkxQCi68qp+qShVcf/9BZ1xFBzsCUP48Gjl0g+ue/mB3eYq//B27s?=
 =?us-ascii?Q?528BYqgNrCSfsDaBtGNuUs+MSw3cM37q89hSoKGpdbsf4ndQWzUK9RZ41/QW?=
 =?us-ascii?Q?PLExo6CJ9NS5xNdG3uyzNJ6wC5X/C6yi8sc0Oo3khZ/pSR1GvMF2NpRM+nSg?=
 =?us-ascii?Q?iJcvo3P/v4M67ulq2NTSS1Alp6MNri9mSCD0STZf8Pr05/7DvZYXffjDWQbz?=
 =?us-ascii?Q?+NicAfNfdBEYyZeifjPAP902ixdmo4BsYOKejjvRWzz6rFoIRH0F+D06PwW7?=
 =?us-ascii?Q?AIPjcGesMp/T4svn13g5b/tL7Sld/tzgPmajbentZSKkpMNqCelYnEWt8G31?=
 =?us-ascii?Q?+JtIg4PFAZXo7kjPn2ZxEBzMM1Y2R4U7NNpuUJbr+BiX6RLj6WajI0PvohAl?=
 =?us-ascii?Q?iDst9VS5c/jn29a20KGQNcdcNdEwaC5UT+jYj/WhgupR8gfaJ5iHqDQlSEDJ?=
 =?us-ascii?Q?GQTlW8n8kTwRRb7XJ6IRuN2ZI/oNSjWHrw/7plIs6A3xREGTE4h5o047yLn5?=
 =?us-ascii?Q?TUFNmY7Fu55kYq7NfLtQmelZ/4UJolWCBnzXAUcOGcbbct/HvCLri8iGUmcT?=
 =?us-ascii?Q?PBHvuViyhJplhr9ylMxD7cgPjzV9xqhBhIjRdYJW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56c2c4d-cd53-418d-aed7-08dcbb824c59
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 10:25:48.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKkWE5KasMGutbCUkYc+5ZfPajQpoRsBTCoCP+OtKcfycJ53zLy5GASP0K/v7GS2qsPa++EpfL2RvMCVNKF3dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904

On Mon, Aug 12, 2024 at 04:23:38PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the mlxsw core_thermal driver use the .should_bind() thermal zone
> callback to provide the thermal core with the information on whether or
> not to bind the given cooling device to the given trip point in the
> given thermal zone.  If it returns 'true', the thermal core will bind
> the cooling device to the trip and the corresponding unbinding will be
> taken care of automatically by the core on the removal of the involved
> thermal zone or cooling device.
> 
> It replaces the .bind() and .unbind() thermal zone callbacks (in 3
> places) which assumed the same trip points ordering in the driver
> and in the thermal core (that may not be true any more in the
> future).  The .bind() callbacks used loops over trip point indices
> to call thermal_zone_bind_cooling_device() for the same cdev (once
> it had been verified) and all of the trip points, but they passed
> different 'upper' and 'lower' values to it for each trip.
> 
> To retain the original functionality, the .should_bind() callbacks
> need to use the same 'upper' and 'lower' values that would be used
> by the corresponding .bind() callbacks when they are about to return
> 'true'.  To that end, the 'priv' field of each trip is set during the
> thermal zone initialization to point to the corresponding 'state'
> object containing the maximum and minimum cooling states of the
> cooling device.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

