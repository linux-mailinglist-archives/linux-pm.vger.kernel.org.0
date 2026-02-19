Return-Path: <linux-pm+bounces-42879-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEpvB3NTl2lPxAIAu9opvQ
	(envelope-from <linux-pm+bounces-42879-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:16:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D9E1618CA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 940B5307652E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 18:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5653353EE2;
	Thu, 19 Feb 2026 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mk/X5U7n"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838E83542E2;
	Thu, 19 Feb 2026 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524866; cv=fail; b=Z1f632lMBNjS+a0hME9RGRRF4Sw+hAMbF74zQXkfI7PV6kFV36OxdvUFw/iBt7S3NnsGR3NoslbWc8/t2khVgbLa3ErzDknCypBNEUWC+1hp9K5T44pIDmGbT9g24d0Ufd9xoEgOGhbyH/ncZXOnioUFgc+JdK3zAj9tXFI7l/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524866; c=relaxed/simple;
	bh=O3skWGv7SPT9OEftsOovcNTkKYkFCNVMLpniFIKuV/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WViKDAPJQPwlU7mmND2w3UW69WrttBIySmOmFwc2j3vF6c8Y3klfpeeBqHsAiOc3tSLJeiI62o4yW8hQRhSXGxOL5Vgfoj0icjRO47vKRTsESQO2sxnjc1imv3MihlzD58Nz31q5fS4/btqXXjflCRHBlzwpO8thUHR3/b67Z04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mk/X5U7n; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpDg5dCNWRUmQd1tcy8hKFaJ5VtsOV6zh2bXFF7hSoN27xeIDuDpv9Luwj3A3F01g9MxkFCBPvd5Xp9vrsMWWYgwiy6cFCd8ay/Hc071WSrs8osDgSgoPfrASW2rdwXcTF3627zeO/g2twLAPITqWkgrCUDfHtYPjG+bnlMYJ/qnlcSP4JGa3XPnqE6XQfieN6Z6fPaj9YsE392mNzU8UrcAzfAaLlx6Ol+zRG6XMtyu6Kgf17pZ+tHoyCOR8soPaz5PQKkb6/Fg19MZQe8EOA3za3ZDgzvUO+pdGa39bSZ0qrpHcDld9+HnjqP6zHyphjwtlbpy5svolGcVym2AbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNqqN498IDW5eyfcUD1vMMmrinlWyRwOjiSQNUbO5d4=;
 b=OasksYnizzcJ1OAC4dF2hU8cXHHlWnT05TirtSWTte+BHLdu/+Odnwpe+KrvzBaOYkAVdVxnClLzHNsOgFGJ7N0FETZKKNQ0rLjZwcD8Vczvvq5W/23duUHVXhJo+5ydFVGf7Wt9MNjFs2UesoyvePlJCStm6qi95Om7NVon+1e3yJQTM8OST6jUzachhcCKLzztQr9WPPoJ9ejdJF6YZMlp0NpfXw/gyQFlw+lw6FHIFMCWIYf3eul5/2J3D6BLwrvS00He+FoV1moARnq7qXzCq4i/v9/CZmdOb9VNrg5VUuNXXnWohZ37BPheojXPfquElaMz354ybFdSM0TiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNqqN498IDW5eyfcUD1vMMmrinlWyRwOjiSQNUbO5d4=;
 b=Mk/X5U7n6loB2ln8Vmp/FEMvE+NVnHQfkyPunhGI2jYHZWfXwfyweiEKLvxIW8hX9AfeDrcl4qLbCB1aO5n4cfHvxqQmbmU0mPz0yLZOTKXZ6pOEMCoLTneRHKjN58QaTOTrbdO+5UUW0Tci7Zk9uoaqLtnA5THNSRucr7xWaE9lRZDY2Wh19hTYB3HIPbSJRVzBBl8h1kKgJJ4XjTKFam9JQstgezEgk7462ipG3s7A3Bq1vOTifkfMpjAgtZOlsbdb+v42vs8TTSuwUT6eANS21PPZwTiveksZMce+8BqVCPdty15Z9PEseWMIHT3FaTuUSFOGk4rZ2ZXWOS6oMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 18:14:17 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 18:14:17 +0000
From: Yury Norov <ynorov@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Antoine Tenart <atenart@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Eric Dumazet <edumazet@google.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Jerin Jacob <jerinj@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Yury Norov <yury.norov@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	hariprasad <hkelam@marvell.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 03/12] thermal: intel: switch cpumask_get() to using cpumask_print_to_pagebuf()
Date: Thu, 19 Feb 2026 13:13:55 -0500
Message-ID: <20260219181407.290201-4-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219181407.290201-1-ynorov@nvidia.com>
References: <20260219181407.290201-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0466.namprd03.prod.outlook.com
 (2603:10b6:408:139::21) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: debf58ef-4fdd-48fc-913e-08de6fe2b1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?okh26n6KJb4O//AWNEdvb+8KOF6z+16O5T+vLE03DSeq9f0zK3z7eCnHwujl?=
 =?us-ascii?Q?grv5dTDa9APQqp8zCEkLpmOGU6o1ZqYniShK8kPRGOALeQ/+L65YklIFsj7f?=
 =?us-ascii?Q?bSv2w65PxOzC77ErkFYabLDMQi+QY3PiqEsNMYcJRTLzFdQiKa4bhJib9jvz?=
 =?us-ascii?Q?T9J0ermjcYcoCmXh99CCaAIKzyf206yLiUfN1pOuMD9oiL0smPaloTaWa2KO?=
 =?us-ascii?Q?nV4F68p3KdQpOW6xH8fIW2SH7N6hnhekP+JhJ4DZ2idmrRD1BDV1Hdl1eJ81?=
 =?us-ascii?Q?Xe0+Ka9Bd6hlMcvzDFaH6mBxeflZfuSGQw9E5dEyleT3Hn993/DeXFnuBFCi?=
 =?us-ascii?Q?rJqSAxNPE3LYJcqTTlkMyfP1czFHTOinaRhPpsEIHuRA4vjh+s+cqtEoE1bR?=
 =?us-ascii?Q?/FEQLjiUewKVQeuS0m6Axc1jGeoKsJiTFobtKkBooSaV6e6AGGvYX3y7xOGT?=
 =?us-ascii?Q?XoJ5viJJNYjj8LXw8NPPjoTAwestU4pEbjUCwHs6z/5bautvkBpWRJ1YdJsD?=
 =?us-ascii?Q?OL3Z2j2m85TWrGlrHXCgpCbgmaESDPRbbWhETPmmk3kJeI2Dx2GHe7w03w1l?=
 =?us-ascii?Q?QhpNHrZSVHonDFcK/U5dQn4anz0BspxhuXDY+Ic1FD2/LykOWXjWmq3Sht5U?=
 =?us-ascii?Q?Gw3WC9ocXkZgZqorKIXa4M++X+k5vWxqtU0Ffg/ufHBNyY1+U8C8EfmM9Be8?=
 =?us-ascii?Q?P61YiRbtM74OjlLWtVQCDKtuQNvX9VqVIHTeMkjyHiETGPPFLkouIs59vWQT?=
 =?us-ascii?Q?INsjYWe95YVloopXIF60E5sFpxy8v2ghwuzAMr18bHtGxDIulksg4vOvp5gp?=
 =?us-ascii?Q?PZcM7/0jkU+KK7YiNe+WNfY9ArE/pAW8+5Ujyd00Pfcij2kMoFjl9pj4elpE?=
 =?us-ascii?Q?/YcmSCcOlhcKgmqwrEw72kXyMGMEvtzaZ9la7kcpwJjky3S7tVwgbymFTLQX?=
 =?us-ascii?Q?OjyYYgUH1ZRBmXFWu0KbS5WoUscrZWqEmpiwvr7P6Uj5nXGmeSjZkKP5VMNy?=
 =?us-ascii?Q?PUKJDVH6gMDbrHydbQgdYa7z1LPdLn9xsHHB5EL4npIYbKanz4aapUldzKQ4?=
 =?us-ascii?Q?NXo7+adCu3FC84IUguqsmSjlFR5WAg0DphQ/beBp+hF5rUY13Jx3HTLaA49K?=
 =?us-ascii?Q?9L/AHqoCkhxsGpMdYzUZPXs/74sW6R75sB97kroWJBI4MFkFcehnysiMstIm?=
 =?us-ascii?Q?VOFGb7vNjV6q7AsDwms1oHZoPQtBPa1NsQMn6hvhR4CyNbjOhUfm7iiSXVqe?=
 =?us-ascii?Q?rrEXZy2J8WUdHu2K/BlPWhVMK1LD+7LeopC0ka98nTG1vG1JJmNg4DhTXSR+?=
 =?us-ascii?Q?5cj4Ur9cbULrsN/om0Wu6XXxx4mV7im54ZhY2kFgWK6McUYepq9W/L49lNof?=
 =?us-ascii?Q?aYXsbyTPEUcSbVK+/dDdddqRlPkBIEGeYRgynir+G+EJ866njF+07BeGXkPn?=
 =?us-ascii?Q?ttk7XDwX11vcVU3EBjyMGfw5RShvN/dE6mTWFAIHFF6GlA/6Rt8QJc7TwhMO?=
 =?us-ascii?Q?x0UtcKxouj8/91OAkKy/KEz4KAJsXuek7Ww9MQCQBnbdblPBK7nTHDAlmGE0?=
 =?us-ascii?Q?58G9/1BpmlbWuXfXAP+c/FMVinGvBxbr6xnyShG6uPpzaeFzw89TBSWDboXI?=
 =?us-ascii?Q?1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fxrgn0nn+Y8wpRc335WnxZ6I+lPqkPIoTS0qdiPjGyHnxR76rlfwpdIuavxZ?=
 =?us-ascii?Q?W0znZYACPahdm8Nm1VLGB2IafUDSju3OzDsuwLF3hYtNq6qlbyuGTgsqkL/F?=
 =?us-ascii?Q?lsfGLYb0Cg5l/Gwn/G864CtJ1R0I1ZG2oE6+rU63gB3GQu56bXZ4Wd39vKpV?=
 =?us-ascii?Q?WU4nmOzbiPDSXx2Qx7SuxE4wyPHTLOl9qfsNyiIQYaI8jKPnjveI5ha+mRwY?=
 =?us-ascii?Q?CacDy3wIJAYatGePYzfTK7p4pOrhuCYcgmXZZVK1/T4bYk0eWJXkKqT6T5qy?=
 =?us-ascii?Q?LtzwhldQu0zIHPMuKjgIo0sOJJYU35ZjabK8pBlPnn4WtTO6K9x7f4i0NB7a?=
 =?us-ascii?Q?IKYiH4M6qlZBOZxPa8TSoK5SkZgkcyavvm6KNYzC2IIVbXMEOpxZXYG1oulb?=
 =?us-ascii?Q?jVa6LN7sG1s1ubYWmDMXiFe2ksP2e/j8YUIx7qvz7jVhVKy2GpEEKxqo/kuj?=
 =?us-ascii?Q?0mURC5UA4aGNbUHld4RDFw1fWk9rBlmR6UUbylbWCSzZ5kch6PTkPdwmy1hO?=
 =?us-ascii?Q?lldaCqoxdjMOw+9Y0a5jb77GoV+SBNlaHxRpQUNZ/5KO1n0oR+XPdjzAHkjV?=
 =?us-ascii?Q?vFeY1mtrkWS9zNtgMVjaPuhbpm/mcYa7pQYO+M0FD52N3gqHdqlDtgiCOl7t?=
 =?us-ascii?Q?OK2xpPIryYFzhL9P+adbe4SKAgf/Fo9UkEDORIvwY/f8HL7HdkFdp0z9Z0Zs?=
 =?us-ascii?Q?44L/01c0nptpMPMfkKA+1kZpLNHKR4iDUvWw8eDFTKHig2X6m8QZaEh5/n0T?=
 =?us-ascii?Q?pPds/GLSmcW+hxJ79iV2CBVv8vfJXvm8bzDMri2CREDaV+2OxVxxf/C0jTm+?=
 =?us-ascii?Q?aTVgue48WCimhVItvfLVh86KmFzMJqw0i+e/DL32QQEjCcLjAX4BPIP0cusL?=
 =?us-ascii?Q?LcS6NqPFAQtDtU4ro1XkYed9W0+Ynhi9LNzEx5DNp803ntv26B5+4TG3NtK0?=
 =?us-ascii?Q?7uE+NoBqLRjC2uZl/FGm6J4+TFJ1xg28CtmU7KUlGsb5NmpfnCdVUyF3vCPq?=
 =?us-ascii?Q?l0jHfp/LHsSfVYD5XlLSUaSS13+LgTpCmcEq5x0rM6MIRPhJS/tVlX3y5/rs?=
 =?us-ascii?Q?pvw15G7wLkeul4NZ5OFZosggdJrTbmi7mII0DFYB3kLG4GLmDKUItRNKbflS?=
 =?us-ascii?Q?Ot1gmye7ztMbWf9JrIGVLMkM9zxOtza/LsVa0yIKLERjPCP09Vx5YF851APx?=
 =?us-ascii?Q?86gSbC8veWIEt2Qjczzriys5zxFBCmfTVDXAc980KUv8JzzC8TgyWRg9mkFw?=
 =?us-ascii?Q?fBroXkO0HmwOjjZe+5XSxeityM1ChoRhn9SoFgLrQYEVnI5/lf9u1sY+FgkV?=
 =?us-ascii?Q?0BMx1oV57xNfJVytbmhzBnoMouivCNtKPA44VSEUqGU4DwiDDWoo43GNVZTV?=
 =?us-ascii?Q?bekMY9/w5aSRdJP2uWmeVHBOF0SkNxf7W2bsvSSgugLL7hJxHohNHlmV1Vk9?=
 =?us-ascii?Q?zuElP0w7JBbQu5CsFOWiX/nQ8gCjHVbawjv5cHQEJdUZwYxrChP/bva202V9?=
 =?us-ascii?Q?BEF3eDMyfImbF9Amlxg8Pmmbkqn1JDYGtAvZR0iwpBg2J5ll525fZ2Qb0/yt?=
 =?us-ascii?Q?bchRDmoYkVELz97znoQtwhdsYpaOcWlhma3uFtcUpXRtAs5vhfoft/DYF0qM?=
 =?us-ascii?Q?+WI6u1GkBgpnISo3BvrNAsz6X5jxyhPM2rWEG5vHGxVhnAYevgAGDGpuTJYe?=
 =?us-ascii?Q?0ULzF+avdNhwFp6yI4644Hlro+ng0XSPgXz8RqlBF/EV6b2+rxbElEOqstYk?=
 =?us-ascii?Q?iNcuF8obbb8n+UA31yY6jbIhfAgKQA6lgPCyXS5a2EAgFuok5XTJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debf58ef-4fdd-48fc-913e-08de6fe2b1fc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 18:14:17.4014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghc1Dl+vObre1mqcUKUWiQ21UxCteP23S+waPqULlnOehbmgKXKO6RkckNVrNge7nm19F8n0TMBb0X4fomrxrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,davemloft.net,infradead.org,linux.intel.com,lunn.ch,linux-foundation.org,linaro.org,google.com,marvell.com,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,rasmusvillemoes.dk,fomichev.me,intel.com,linux.dev,lists.linaro.org,lists.infradead.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42879-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 69D9E1618CA
X-Rspamd-Action: no action

The function opencodes cpumask_print_to_pagebuf() with more generic
bitmap_print_to_pagebuf(). Switch to using the proper API.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/thermal/intel/intel_powerclamp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 9a4cec000910..ccf380da12f2 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -200,8 +200,7 @@ static int cpumask_get(char *buf, const struct kernel_param *kp)
 	if (!cpumask_available(idle_injection_cpu_mask))
 		return -ENODEV;
 
-	return bitmap_print_to_pagebuf(false, buf, cpumask_bits(idle_injection_cpu_mask),
-				       nr_cpumask_bits);
+	return cpumap_print_to_pagebuf(false, buf, idle_injection_cpu_mask);
 }
 
 static const struct kernel_param_ops cpumask_ops = {
-- 
2.43.0


