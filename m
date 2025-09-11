Return-Path: <linux-pm+bounces-34456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF53B52F06
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 12:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6450D481F7F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 10:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89B430F559;
	Thu, 11 Sep 2025 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AAwiu8kJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05F347D0;
	Thu, 11 Sep 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588330; cv=fail; b=Puv30/nPWw5w7NRN1HuD/lpqq4EZXwEBclZl5g9y+6wnOrHu5bsEUhwXn99ImKetT7gqFzsrKPB1F7c0Qjsm+96q7tVVOajG3nLsUdTP2lkGa7shThErNQh9aaxh0M6eohhCg+aY7oQQVXBUTko2W2BER2bgbEQnhr4FZzljxf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588330; c=relaxed/simple;
	bh=x8ECF3L8PULxlpjvWXbaI7wO2etpToKarafhYvSzCLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WFSPLCGGNPgVwGZquI/XNKdUfEcKhBXNzYpFjGVVLpTXN4ZYRSccaTCTVMZ3PzwceIJHi/NKURhRifRstjj60sOS3ibFDK3utjnfsjPJWbCFWDWhX/vszK40DvqcwK/LYJXHx5aA0zGaw+vAczTUaN0KkXTOJj2YYv3TlzodDyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AAwiu8kJ; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MK3Bi/b4vttubPoTOcWi8UnAnASFoWGntX8/i9P4YbWcH0hy86eBSHVDmkNK2gZ8KIbpAyTyldAFzVwzpNHnsGBntFfXWJ0wbuGq6cJZko8CGECJhHeMLD4FvEa42MC14espYAWH8C4IMsrzBp66eLAq7tkb3XSIH8ScjIeg87kLmioxfsnXP4Y9SNKU1CugXSpkRhjQyKrZVs4Y92REcoTPXJs5JceR+FiZ8h9uwDI3tvWTfDIEqVAZxlw8z+6arMolQLgNI85mLxLWqzkIlc6sFMf4D1Jy9P2EMlGLW3puXE82F0jwPMLPLGFoS1LtQov8JHXNoobI0MKxbE77Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FW4CWx3ScgdYyrq1E/+peGrO7Et/ANtQnqeoV8SsqU=;
 b=cOeASo0AuseKxrV8mzrRe7YYTy6/xNemfFxzVIb5HkgwJdlJPtuqGTP7filK5/d60vYS6tmBZCWTOa+oniYHon1u4n/o4BXuqsFTKQbr0tbuG/oE3b4mIB9uMcN3P9ZH1wJz1MbmHjdBmyxmHnwv+qX0F3UuyS3tNj6wIYPew4t1zYv9+X2rJrYIAmgkdIKBsz4lAxKQTsnahPuGJeuBqAU5gHM0khWGnnSWvGLmFtKY2j3CR8M0ZHLp2CiNKntiYexCEYPkKSrh58qKjT3IKvPgQNF0kEFMSywEhOsgcLMx7gkCqmRxkMcK44dY+dJHzuADo68L4Uedugs2yw0ghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FW4CWx3ScgdYyrq1E/+peGrO7Et/ANtQnqeoV8SsqU=;
 b=AAwiu8kJcdashOdldGRt6CK4qOHjG/7LLCBj/nfyaxY1xcj2xFN1I8yr9HaPXavRTWORMWBZWzIVbAmi8r9kwmgwst7IvCX9GOD9q31zfm3faYbn/S3lH7EtXMIIurj3yCut0RwJPA2WFgRO52rNwVedfnJ+V7IX7xpEQ61Espn6wV0sZCrMsBlXWcZbaZo+iMK0ZL9XOEGMx0CZzM15a2Eprsk7wGlIKrCAp64nn/KfF5JWJxUTMR5zNLzJc3G7C8D4o+D9ZCYk6cGKacQeD+61IZ1V6eXvkKuLxlcccYf1ug12ItywgFjLVjP/dry4f57gDMBSZWYUGszfxlgzew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA1PR04MB11532.eurprd04.prod.outlook.com (2603:10a6:102:4e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 10:58:45 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 10:58:44 +0000
Date: Thu, 11 Sep 2025 18:52:47 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Ryan Zhou <ryanzhou54@gmail.com>, 
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"royluo@google.com" <royluo@google.com>
Subject: Re: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Message-ID: <xbfvykzfi26pyaycd7efbqvmraxcu6zzgqjfxtk33wcsjsnnal@5e3g4pq5qcj3>
References: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
 <20250909161901.10733-1-ryanzhou54@gmail.com>
 <20250911013242.oxm2kwfaqvmybbhk@synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911013242.oxm2kwfaqvmybbhk@synopsys.com>
X-ClientProxiedBy: AM9P193CA0014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PA1PR04MB11532:EE_
X-MS-Office365-Filtering-Correlation-Id: 83082026-640d-4031-133e-08ddf1222d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9NnA4HbSh4z46koZrQNGU+6vsJ87MgeVNrXpzJOvIHuIM221pMaHpJ2Z3i+G?=
 =?us-ascii?Q?sIm8l0TzWn06xUgXs81/wR8247UyK4hr1e/A8yeMxGTRmI5Xfo5bgJbr17+l?=
 =?us-ascii?Q?tcrFU9X8Lh98nnrJSeJTm7KW0VUGvhFUOX+/sAbgjAFQ0QUYDJ1xjDEgwOS9?=
 =?us-ascii?Q?2GK1yKd13vjF0qZWTXqxNkt97xJ0vxIXLM6FQaBHIDDjuzNCLlHSux8IOpmM?=
 =?us-ascii?Q?e7C99O8WNJ8S/O+C2wThkILf7FDptWxhDgsu0Di9uYtetzLl05x004TlHoFQ?=
 =?us-ascii?Q?VNneskJ0ZcU/FX7Cumuq357HNZE/RAzpH0VBxfquU00yOYDqcuaWaNukQCsI?=
 =?us-ascii?Q?IZghR/tzQUdT+QezhIe0990G160IF9LsfEKDulLSxXm3AmJjLzj3lgm1R87j?=
 =?us-ascii?Q?EqR5qUdRogFvtQVeNc+qDM4EPfNHI0nIvv1CSCK50eW6h/Z8nBq5AOdoMnMO?=
 =?us-ascii?Q?i49xeFLBSoRlH+zBMUCtzgMDOpBoQZFTbUhuWm6fMdpx5Lbo/RhRGu2bp3Aj?=
 =?us-ascii?Q?ClBT9T7kwwOEF9Lm8C5V4nkO/z3gAAW8NrQB4UfjjOaq4mSVdwhxQNRS7jA7?=
 =?us-ascii?Q?Y2sfTF60AP3CneTJxT/cBxl1pWZgzFpuIiz/xXaYDPbaiYqpV0yhkcsPXhzI?=
 =?us-ascii?Q?nxMCmzSNT5NVobqU17nacXrlEPmE1CDWOSiCvMLd3pqcODKXsfkC5l/A2DDo?=
 =?us-ascii?Q?RRjv20GVdE9xfUwXHyUlhlItaLvt+aMMwUVRnmRxZ8ZFVjsG93NnWadzCWt8?=
 =?us-ascii?Q?xe44s8uy/u4sq+milYoIiEos/WodaVzM/HnYiqREfuD7edvOBPdJIVZ2OXsP?=
 =?us-ascii?Q?nvK3iV7SU//bWjWAc9zMGUTWaQPvdHNtz8XbEGaVMeZO3A3/EmmIslB0u51S?=
 =?us-ascii?Q?GZCOqaubOrEQW4kJGjMqozAs+cVJQVAsRhp97aHSHg5TPKMKLNvfUtpzMKn7?=
 =?us-ascii?Q?bFqha+hQHRiABwSdMTFiC50MDKIleWWgfSS5WtBHIhtzBCyNi+sPeOuvhRc0?=
 =?us-ascii?Q?UejyY2xrxOPtNRvkJ0pRezMP0WkitfykZabJu05VNcYD3ZGMKzQJYDHalgX8?=
 =?us-ascii?Q?IQZJF+rGlfW0K3JIvhQrQJFhrBIyG/qcfs0wHK8sHP/0J7PaArA+NOv2Mf4L?=
 =?us-ascii?Q?GKIWJwKfiV2MmGL7rtUtnBgfs79jGYkY2lVwUxOPOW6hVUq/bSqAhwaiRO7F?=
 =?us-ascii?Q?kF/Z/XJb980Aqu2ts+HcQ3h7aNMFUJAGuhkziZIdZpC4fqriZvO7h+y3bUv3?=
 =?us-ascii?Q?nCnnWNRxB2LQrryHioAVkcnXDx3G8+itq8oi//6P7dqQVhKgSMRTYNDHy4Vc?=
 =?us-ascii?Q?nl9HZOwB/a7T0haZU8oRbUVodU+AEFm3SSwQUkfSs01kTuoXKcZ/KF8znURs?=
 =?us-ascii?Q?Ovy5iNlRwnBpZ5rKRs99b4Khrp4YgBnuwCr+kjSqwgvlViIlvjNtoHLLri5J?=
 =?us-ascii?Q?m6Ys3aSUYFaR0QKVK9Rw91xmQsjZcjeYLKlZE0xl6rRD4UrRN/Hqf1jcC+hE?=
 =?us-ascii?Q?4SMnPG65u0VyPXU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wk63hA27OR7ub3TyiY4x50KM4ems+/LuAM4AMfQ2d7+fCFT8/SifYt9Ot8X/?=
 =?us-ascii?Q?pfWKCIs0nmk7jB/5o/QvddFdOQ0oV848/ppOOcn7ls+L3eYiAgPd+UBs/R4U?=
 =?us-ascii?Q?sC1/m3J1OvIEsTi2m/LrxBOhy2wJB+EZpINVhLf/jpDNSKdB5jHyINdQTbcI?=
 =?us-ascii?Q?vC5GYtP3rq+rpZwtntxOHoKCURjCFMDapfDo/Ehazkyl8pDQocqxQGNHOP4z?=
 =?us-ascii?Q?7urcsyXfTIqh67GV7D9VKFYaOiSdGmDoaCiP43pltsn9rhwk3RmH0uplCpli?=
 =?us-ascii?Q?vYo1Vlw8WMxI4Z6FpY5BsQNPqd7buvr47Zkt5kPdfMfxuK//jR+Fb5apBHfZ?=
 =?us-ascii?Q?WjFR0BqjB2QTA29WKpvCASFjP+vSbps8F9iQIboY21UNd+p7Cpf6dXPv0T2D?=
 =?us-ascii?Q?rJsRaMzR9JWhqkjyDSdQ729g2VqfatGgaDno2sK54SF2vNus10phldvZBT7J?=
 =?us-ascii?Q?LRBKBm8Od//LTIMuSpFy7Yd4G1DLEsJG9i1Kv1bUQBct5VCs7wsN6FTIqmBL?=
 =?us-ascii?Q?OnjEfrukbRNEnuDl4luQI5RCc9KYGexfSzfp9q5+ET4LpqxvchkVKwAu7Q0y?=
 =?us-ascii?Q?VpdAO+WPv3O2DlX5swF0LR0etIlaI+laXHIhPl5jpHGe/aWR7MWdxT4oqUbH?=
 =?us-ascii?Q?UDTJnWf/mDPB5YlbRF+e0Ic0XP3teuTjrXKpF1gB6CNScZZEdDssOF0rEltH?=
 =?us-ascii?Q?J15GDzC+EKbbiiAtStHvNgGwV469IQrby0OC3fR6xZXk7WBNo5kN/qdozm1A?=
 =?us-ascii?Q?aah+EBKXN+k8cpacEd08WxvMsPQ2hx9l5Mqt854hD8+0Ve0oiztqeL/FeVef?=
 =?us-ascii?Q?jM6u0OSKhIgADZ4vSVj2eaTjl2y0L4F98pcpKWlc9WaVYwQIibiGQHwp9y+l?=
 =?us-ascii?Q?bFk2dUGgP8ta71aIJ3+BLDTvKeTJVRMQaBC0iNYNYV1iwXOwhFm8GFYDA0VH?=
 =?us-ascii?Q?AE9kzur/tIjtUkLfQmhykzZ7UVjQe1oimGEhAHF9oEj+H8mrmX1/b3OHq4Zp?=
 =?us-ascii?Q?2/+9Z8qJof5teqNuIKwhVR2cAIeUBslaqd+ZNrnvH6jQeGIjaZ4CNydZAsgu?=
 =?us-ascii?Q?4tDWFluhLi6/z4NuxsRJ/cyqvpBZHt//rFSxJbuIyJ+VCi/alfIo55AFrEKs?=
 =?us-ascii?Q?BJPWfTEgb/2/CKPf9hTAfWBslwWQIYvfwEpygbOPEPogs87pR71+1jmRTXPf?=
 =?us-ascii?Q?GDZyL8wKFPuUGYyp4l2pJ68mu6VlIxTGFGXqM6aveAoMCeqzldOD4DpzPCPT?=
 =?us-ascii?Q?3VXhuXON6Vpj9EDi4e1My0aYkPEp+WU2HIf4E/GPNTcknMZp8jQibrYrDdSt?=
 =?us-ascii?Q?4EDUMfTPMOZUgmWW4pVXrVvpX6ay3fx1tjfsxvn8N5n8BDFXnd9JAFaWS4+I?=
 =?us-ascii?Q?qILJQ7D4BZcWqOyiQPig9itSM15vWrAwbNndM6ACqyGlUjRUF8+fvVJGwCq2?=
 =?us-ascii?Q?M4mCVxt6sUVcUkDUHRO4WGSA6W/OPA4zHIhauV9Yu5mpDnw2POQbBeEblWOX?=
 =?us-ascii?Q?fYEaGY84/5gxOpvTiWby/LnDF25WHyhSj75zRwNZYNEKTvo1bdZ5i6JSgyjQ?=
 =?us-ascii?Q?EQ/7wkxAq1hZhsi7XGZksZiuByLjjt+292ZA33Pa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83082026-640d-4031-133e-08ddf1222d10
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 10:58:44.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XH3i2faGJxSQR/5Yvkxx2SbXoDJI0+UQUn4Iea19o8xZ9mABA2qTc0Y1G6DMAAC9WMUiHnkP3PRqiQV1PARNMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11532

Hi Ryan,

On Thu, Sep 11, 2025 at 01:32:47AM +0000, Thinh Nguyen wrote:
> On Wed, Sep 10, 2025, Ryan Zhou wrote:
> > Issue description:During the wake-up sequence, if the system invokes
> >  dwc3->resume and detects that the parent device of dwc3 is in a
> > runtime suspend state, the system will generate an error: runtime PM
> > trying to activate child device xxx.dwc3 but parent is not active.
> > 
> > Solution:At the dwc3->resume entry point, if the dwc3 controller
> > is detected in a suspended state, the function shall return
> > immediately without executing any further operations.
> > 
> > Signed-off-by: Ryan Zhou <ryanzhou54@gmail.com>
> > ---
> >  drivers/usb/dwc3/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 370fc524a468..06a6f8a67129 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -2687,6 +2687,9 @@ int dwc3_pm_resume(struct dwc3 *dwc)
> >  	struct device *dev = dwc->dev;
> >  	int		ret = 0;
> >  
> > +	if (pm_runtime_suspended(dev))
> > +		return ret;
> > +
> 
> Is this a documented behavior where the device should remain runtime
> suspend on system resume? I feel that that this should be configurable
> by the user or defined the PM core. I don't think we should change
> default behavior here just to workaround the issue that we're facing.
> 
> What if the user wants to keep the old behavior and resume up the device
> on system resume?

What about resume the device firstly if it's already runtime suspended when
call dwc3_pm_suspend(). Therefor, the old behavior can be kept and the issue
can be avoided.

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 370fc524a468..1b8dbb260017 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2672,6 +2672,9 @@ int dwc3_pm_suspend(struct dwc3 *dwc)
        struct device *dev = dwc->dev;
        int             ret;

+       if (pm_runtime_suspended(dev))
+               pm_runtime_resume(dev);
+
        ret = dwc3_suspend_common(dwc, PMSG_SUSPEND);
        if (ret)
                return ret;

Thanks,
Xu Yang

> 
> BR,
> Thinh
> 
> >  	pinctrl_pm_select_default_state(dev);
> >  
> >  	pm_runtime_disable(dev);
> > -- 
> > 2.25.1
> > 

