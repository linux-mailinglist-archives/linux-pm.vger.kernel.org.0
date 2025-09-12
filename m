Return-Path: <linux-pm+bounces-34531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2281B5444B
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 09:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456CB3BF837
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 07:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F262D3ECE;
	Fri, 12 Sep 2025 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mKD580pR"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CDE2D3A93;
	Fri, 12 Sep 2025 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663869; cv=fail; b=qZGoTCp3lXZWzt4ZVKJoqdJ7py0kRiV+NkwnJgm1i3uRcQgiB14iSXx3PFJ7Oua8OFHEANivpdxrcb4Ku876rweerK3Hp/qq/BC+R0vUlO272dKH4yjZoTgdUyBYpa5iIXr5Mx2qoWiEe8GHriLqnUijANFGx5rL1kle0+LNFkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663869; c=relaxed/simple;
	bh=z9YkGVkxoYzh5u+OvWb6ChlIPDwzzwfH6Ct8avpTkKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iuFjNfIrmPL13Rrf6LXVabfCKX1aXNkiuhnSUKsIDpkdGnlpylerIZwHxTsfcxMym2SbGc6pOHiI+lqN/v56dmv2nCBDONnOl5p7B9O5d9ofjGRz1vufslPzl6eYNuzyQv7ccgzAR3i1Ba7eQc0bvRsAWFxy/9arsvw8sb0m4rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mKD580pR; arc=fail smtp.client-ip=52.101.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRF6CgK+J8wDnZ1akxth/EElxgwhIK9coAfTsgw/SqxVhuUV+GWPOsVTjqeTY4NDFkp5XgMcinpzG8nRzKf9EnPm8GHE+PLxqyCJeN+FyH9wmJkquyHWOw2iZVOfppNjt5CFwY45c50hqt+HoF7fbgAqWxA8Iv2aSdr8UUTOv8JI+3IgL2KKVxn7wevUo38sNlfKZ8bwCmyCv5pZDuI5XWforWf7x/liPgWOZxsfbgAnxj0bcqKVi0akN3eTmNWepKm0xM/6Fzi5MBt6RfzrNyjDwb7SGiE+pnwy/QOo7SxSuKhksGKzlZgkOrcXPK/qLXvU0+Fzd6nzAcIog4S8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCnHDY9C2GD5ENtrSMcEgudjy3cZyig9b6PqVBaGU6g=;
 b=tZglbfAclOdeWsiSjlQdbBr5Ehp/DWXlrYogIzQaD7L8spFzXY59/WkarwRhfcZCe0xgqhJBilgYaizpxzELPViayMysDloWPxWEO9N2eah6kiB1hjqnxxYtSHaZmOjkB7fTT4M5IkiHI4Kpt24XnQ4omoV3Vs0Xe5T01xqNVvA6Nt/SKVascBjTedOYsEYWkd7TOpGyT9WRyRl4MOaPWRt2wOURWh/zumFR2932tjzdBfFnrw5oz3steCH62ymkWNGj2dsBPInzjpfRQsCxHzyqSOBo3Wt5fUeR47HcFeQ0lgS7oxn6v+Rwy0DbupA9hn7HtSZa7r4AM6cgMyB9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCnHDY9C2GD5ENtrSMcEgudjy3cZyig9b6PqVBaGU6g=;
 b=mKD580pRz0l2PaBHvjRbicYMe3hKplxuq8IY1jK2J0VEGkXv/mNMTeHuBkyCVG52/DdVumhQ15V9Ok1jHB2srnt78pQrSssPKXApIJGc88VPBLd198au4PCponeWzEuPQj4hTdQxTHo+c1N5XJRQ1R2HRzqEVEV8jxMMZGyOnZl3f5lR/XxxsQj70MqwNP4K2FewQhG7REOiDRnvxUPovCZ/OkDE0qxd0qX9XC3wxR+D6Tqw6UIkClX+K2bek0XJfi1sgL31UoKgE6IDW4blfjp03VbB89s4cGj9SF1UvRTICsrQsCA0/ycIPb4QNO3sWd9BfPO6mLIbvkhc3xh1Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8804.eurprd04.prod.outlook.com (2603:10a6:20b:42f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 07:57:39 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 07:57:39 +0000
Date: Fri, 12 Sep 2025 15:51:43 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Ryan Zhou <ryanzhou54@gmail.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"royluo@google.com" <royluo@google.com>
Subject: Re: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Message-ID: <lzkd5h7gwjojo7rio5z7jrdymkluoue4z6aozn3xmrdqnhlvak@3rflncbxe5ko>
References: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
 <20250909161901.10733-1-ryanzhou54@gmail.com>
 <20250911013242.oxm2kwfaqvmybbhk@synopsys.com>
 <xbfvykzfi26pyaycd7efbqvmraxcu6zzgqjfxtk33wcsjsnnal@5e3g4pq5qcj3>
 <CAJZ5v0gT26VK-sHmgK_S4RjjO3Uc-ZmoAYos43S5yWh0zWc9DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gT26VK-sHmgK_S4RjjO3Uc-ZmoAYos43S5yWh0zWc9DA@mail.gmail.com>
X-ClientProxiedBy: AS4PR09CA0029.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::18) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: bc007037-9987-4b1f-0376-08ddf1d20b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2lXSHBOQmZiR1RmOXZxL015S3NVajJIYVZCSERKeXRUZHdjZ2QyM0xvY2ZJ?=
 =?utf-8?B?a0g2M2Flc3draEUxYUhsbnM2WjJFVWlKY2JYc1NwKzlVWjJ1UGgxV3JjbG5Z?=
 =?utf-8?B?N0NDUS9ZQzd3SFZIVkg4eEMvaGNjaFNpd3VRdTlPV0tqZmIrcDc4TUpqUmFs?=
 =?utf-8?B?K0taWkJyK1AzMU5HV3ZvWEh4OFhUVGVGS0diSEZrcVAydzhjYlJwK1hzS0Zp?=
 =?utf-8?B?djNUdy9xM09xQ1pQVlM0UklqVkFwa3VuNC9jZUxYRnpJdEhtaG9xTVJEeHUw?=
 =?utf-8?B?UTF0d1lNZmRBL2tZMjlOdXpYOFhXYndjUDJYN2x4NzE3UllTSWR4WktqRjho?=
 =?utf-8?B?RllneVFMNXd5d0FEb1FmTGZ5a0YxZlk3bTdOSWY1Z1IwZ1kvQ2RCVFJyRitp?=
 =?utf-8?B?aW1aS2d4M0tGbjJLU29CRnY1THFYdDBaKzVDVjYwRmRXNXA2QkpMSTVMNTBr?=
 =?utf-8?B?R1NybDhPWkNCOHMvMXF5djkwVFlmY1J1U3R5REc5NWF2cXMvNlk5eVJEL2ZX?=
 =?utf-8?B?NDFTWXZkbm50a3dJa0FvbzltNHhFcFJoQ0xlYlNLNEswSEgzdDc3YTZlcmpz?=
 =?utf-8?B?N2QwL2xxSU5QZ3Z6V1N3V2EreTZqeU1kT1I0a1E4Z0xaNDR6SXVHYVU5T2tN?=
 =?utf-8?B?UDBDMXBsNEJiVnlWWVNVd3dZQ2Z5UTBkSGZ4NVAyQUJ5emZjZXF6L3JuZW94?=
 =?utf-8?B?a2pCTWxoZXdjbmF4MTFxSUthNEtuaVlNdTZpR0FEaFJWMGhFU2xsYnM0cTRB?=
 =?utf-8?B?MFl0WWl1OXIwaytKQ0FVN3RZMDJQOWdZVXJlNmQ5UFl2cGw5UnRKYTZLeFJO?=
 =?utf-8?B?K0dkL0hnSW42WDZJTWJTUG1Cd3BXSmJpNHphTEFLczRyVlljanl1dTB5RENv?=
 =?utf-8?B?OXpDeEVuaXdKbVZSem9ZazNrWmdQMUpHQTg0eXRZanNsQWozZm5pcmZjQ1Ju?=
 =?utf-8?B?YTdLOTJpKzZPSlRkZUVRajNaTHNxSVE3Y3B6SlFEL0pWQWpMSzN4cmFjeEta?=
 =?utf-8?B?bFhJMS91dk91K2Z5dGZxeGpkUmJ6WDd5dHlzckkvYkE2UzFmM21vNGVaM0hj?=
 =?utf-8?B?TWdzQWhpVlN1RmN3WUtBd0UyZkZ4RWlHNGtsbEFmQ1lMVXBvYkJUNnNVU3J1?=
 =?utf-8?B?RUswZ2hYS1RhaU9yWFBGWDhia0lMZkQ1emhFNE9OczV6MnY1S01BU0FoT2VB?=
 =?utf-8?B?TlBZUUtldkgwcXVYSHpQM3N0Qm82MC9ITFA3NVBDNHc0d1FxOWI2UExDK3Rt?=
 =?utf-8?B?aW80WlZqVlFuejlJd1RaN2VyeUxFNjRrNkoxUWJqejllWTRkN1ZVRHc1Lzk0?=
 =?utf-8?B?UjNDZ3ZkaGNFSytsR3NVekgxTGYxSDlPU1lZb2NQK2pWL3JvTUplVTlCVktz?=
 =?utf-8?B?THpLaURobU9JbjVSR1FuYTVHMkpnY2c2SmtHVWkzZFhaeUFVWHRCZVBNSlpD?=
 =?utf-8?B?MlpKMlFuK202NTRlZ1VPbW1QWjYzeXhnRjI0UjFFZ0tIVnhXSlBibS9kanJh?=
 =?utf-8?B?eU5JU2Z0cTB4NkQxbGlHTmg1TUdKRmhYV3dEaHFSRE5nb28yTjBNaU0xc0Z5?=
 =?utf-8?B?V3lONlVoSmd0NW9zVVF0dmxPbXdjWFAyRjVoTHkveUl2RjFrMVp5d2haYUI3?=
 =?utf-8?B?TWVNNnNPWldzWktFRGpXcWpSNS9YbWtzZW1WV0xVZEVvZ0piNU85Q080U0ts?=
 =?utf-8?B?L2VsazV4OHFOemZjcGt5SXVkTUxJdEU5cTZ4Z1pPTGxjM0Zacjk1S0VFSjRK?=
 =?utf-8?B?OUw2RkxxMTd0U3l6b3FYdkg4Zk5qMitHdG9RdWVaMUNVWi80ZUJoUUErZEc4?=
 =?utf-8?B?a0NZMUNLbjd4SzgzU2JUQ0grZElqdXc2Tm5SeXgrNmNUY0FCV2U5K1RQbURP?=
 =?utf-8?B?ZXFWM0xwVWpwcTdtdnYwTXYybGpyNldpcVk4UDdsay9rTEtRWFJXZ20vc3Jx?=
 =?utf-8?B?ZFpFcVM2WjNKV3ZpM2JqbWZqM0JkSFIwcyt3WU01dXdsb1FuSzdwVEs0c3JX?=
 =?utf-8?B?QzZEZitEaEZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHVueU51MDl1VkdmeWxlcjJ5Lytrc1VwU3hIRGNuRGVkSUJWaWN0UkJiMEhQ?=
 =?utf-8?B?V29DbFNLZmNPZk11UFVKZ05MbjI0eFN2RmVERzZ3VE5zU0hpSCtzMlV5bVlu?=
 =?utf-8?B?ZEVVdndtMloxY2dtU0RFSDFJZVpDK2JGUXNVVjVtUmxCNCszalhrVEIwUkJn?=
 =?utf-8?B?d01lbnVmdzNacU9NYzdpdzQwcFJ0NnNnTVVoR1F6Si9RUVVMNStpbXBWelA0?=
 =?utf-8?B?STcxMldiRHY1VEJ4dllCbkNBNkNpL3hkVy9FbnNVRVhXSSt2aVpSSXNmemlY?=
 =?utf-8?B?UzFRZXNQMmdWcUx4Y2M0QnRlaVYvaFcyREc4ZmFuMkRwczJVbG8wUmhqU2d1?=
 =?utf-8?B?aWlLYlUyWXFoREoxbFVrRmFDMTVMcCtoYXdmYXZWMnhXMWd1N0djK2ZJeFFr?=
 =?utf-8?B?YkxTSURIM2xzUm1tSFY0ZklVVjQ1SzBvdkE0U25lT2ZtQ2ZaSjFvMTE4Mys1?=
 =?utf-8?B?Wit3NTQ3UXhPY2VsZHdKbHVJdEVzKzVRNzFUcXpJRjFES3QzVWpFREpOanpq?=
 =?utf-8?B?TU4xeFkwc2psRldmMVZ3dGpXbjIyRXJxelhoNXF6STdCTm5UR2p1UjRROTVs?=
 =?utf-8?B?Tzd6SFFmU3A1NCtVTjVCaG1kSUtKdEw4WDNacEg0aXAxSUhwRzZkcGhnMmFW?=
 =?utf-8?B?L3BXd3NWTDF5WnJQbGpPTHlMS0gwc0xLQnB5VlByVlFNcExoVG5oek9Zd2hF?=
 =?utf-8?B?Ny9CTzE2MGo2ZDlhcVp0U3gyV2VTNmJFZVdkaE41eEUyS3ZaZ2JHNFNqOUdV?=
 =?utf-8?B?SzdnTE1lNXYvT1ZlZ0xLRERpYVdoL21iS2N1Wm80ZDU2U21aSVhOTmx6ME1k?=
 =?utf-8?B?SlloaW44MzY1TEtWMW5Ndmh2ejdhZ3lKVnk5OWFldFQ3T3gwd2pxb3QwY0Fp?=
 =?utf-8?B?cWJZc1UzOUNUalJuN29ESFh5N0x0UDZjbFBUOFd6ZWVBR1ljY3lUVmEyNkhk?=
 =?utf-8?B?VUIwNTNHM0ZTcjNJQXZSUmVGYzFzUDcxZm9rMDRJcnJmcStHV1BMOE9Wcjhy?=
 =?utf-8?B?STQzbm9Xd21VcjJWQ1QvZTIvbjhzajhBT0dRcE5JWk4vdlA3OXYyOWJoTDFG?=
 =?utf-8?B?Wnk1N2lTWEJMcW5zTlV6SWM4NHhJVmg4YTBEcFY3dUpVcjNLUTlxcXdMakVN?=
 =?utf-8?B?eWxqRUM4Rnd2N1B3UkpKbWZHRThjdDhMbXh1T1VGYWwyeElhdHA2dnBDZDVZ?=
 =?utf-8?B?TTVsc3QzdFhRckRqNXg5d0tpcERwUWJsTXMwMnU0d3hPYVlMUzJzemdqbVdZ?=
 =?utf-8?B?cDRyYUxJbkxPU3pyeVExVUNzc1FTNlhLS0FaZkZaY1ZlQ3paeFVXNkhlcnUz?=
 =?utf-8?B?TnhpbjBidno3VE1vOHRzTTdCUVZsY0M2WFNmYUFQRE9lYk0xbWlEQXdvQzZV?=
 =?utf-8?B?OUxaNnU5L3JhaURFVWRVUktTd1RMQWdzaUJFOUc3Tm1nQTRpUDdBYTVrbCtS?=
 =?utf-8?B?WG1Lek9SNmR2Wk81YWJjR0pxSXE3YjUxY0lzTEo3aitOTGsvWHZSTTVaR2Vn?=
 =?utf-8?B?cS8wOVdUUkwzblF3V3Y0TFp2QVB1c0xndm9NM2lGemd0MS8zTTRaQW1NM1Zr?=
 =?utf-8?B?Ni9zQXBLMUlVSHpNTEFHNGQ4T1puMnRFZmY5WDd0TlNvMUIweE4za0dnMVBF?=
 =?utf-8?B?RmRBWXo1M2dTTmh5eFFZV1hFVHZ6eEg0QzVEaTdFTTRnZWtDM01PUEpvazgw?=
 =?utf-8?B?eUtGQnRLSnJJcmJkb1M2OVZtNVJ4enBkc3hKT1NxMUhkb3gyL3JnQXJGcERV?=
 =?utf-8?B?R2x6alhGbmFJQzZ2YkkrcmFDT2VwZFhacHdTaTQ1a2JTbnVGaE9lYk5NRHZR?=
 =?utf-8?B?MHh4SCtNaHJ0ZG9UUDNvTjNXaDRzbUtnUzVIT1lEMW5XN090UXcwU2NHUTJ6?=
 =?utf-8?B?ZkJ2eXlQMVBuNTBsZ3FZQlg4dW5va1RXS0tuTUNLZFJKMFl3ZzlNVUM2cDdn?=
 =?utf-8?B?MnFCbVhCdXIzMkR5L1RFTVJST3RoZzZwVTJFTGJham1aU0JLUFd2ZWtKcmFE?=
 =?utf-8?B?bnArcGNTTk1qOVNFUG1NblkrUHRGTXk3OS9ybEVZWURRdWhDZjdZbnVOaDFQ?=
 =?utf-8?B?aEdUVjR2VW0yMEt2b3lGalFxSkE3SzdJdzA4am9kNTQyVk9EOWFQdXNmQjlj?=
 =?utf-8?Q?pPXSPG3YgiRvQLqzponkAZepU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc007037-9987-4b1f-0376-08ddf1d20b0a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 07:57:39.1224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG9AvBIxw6aaAZ4f5OzicC2w739zDz8Bul3vweWQs0/OZeuVLsvvyd7BZsQ7EUAgpFKHUrE+UawDAfPQdqV8HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8804

On Thu, Sep 11, 2025 at 01:35:59PM +0200, Rafael J. Wysocki wrote:
> On Thu, Sep 11, 2025 at 12:58 PM Xu Yang <xu.yang_2@nxp.com> wrote:
> >
> > Hi Ryan,
> >
> > On Thu, Sep 11, 2025 at 01:32:47AM +0000, Thinh Nguyen wrote:
> > > On Wed, Sep 10, 2025, Ryan Zhou wrote:
> > > > Issue description:During the wake-up sequence, if the system invokes
> > > >  dwc3->resume and detects that the parent device of dwc3 is in a
> > > > runtime suspend state, the system will generate an error: runtime PM
> > > > trying to activate child device xxx.dwc3 but parent is not active.
> > > >

[...]

> > @@ -2672,6 +2672,9 @@ int dwc3_pm_suspend(struct dwc3 *dwc)
> >         struct device *dev = dwc->dev;
> >         int             ret;
> >
> > +       if (pm_runtime_suspended(dev))
> > +               pm_runtime_resume(dev);
> 
> You can just call pm_runtime_resume() here without the preliminary check.

True.

