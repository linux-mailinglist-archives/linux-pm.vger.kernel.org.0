Return-Path: <linux-pm+bounces-19278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8319F2AB4
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 08:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9461611F5
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 07:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C5B1CEAD0;
	Mon, 16 Dec 2024 07:08:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021102.outbound.protection.outlook.com [40.107.57.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE22E401;
	Mon, 16 Dec 2024 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.57.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332891; cv=fail; b=Qk3LCt5JzCX2EfSPHoMG/JDnGwNuplO1rktkDYYGmWoPorOwqfTnXUVEvJ7jCg70X53lmhrMQDzxLCuY9YxE5HBh+eWSQhtd83HW45T5DZTl2rGdes5637S1DtvyJ6Q6P5zeSE6ORKj1GLrV71UzAACdNHuxttxI8bv6HE+DXJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332891; c=relaxed/simple;
	bh=qMQt1uri8UmhwOfZ7qd4UMIzS9Mr4DVSZb5Sngu/lHo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nccRhd58wEgsBGdlRa1xzNTDatY2800gp4gS2LJpfT4FDlKEeUGQhvUYEIzmr3BkqWdT9zR0Lb1gTqLcbzAaM1NwtP1Ozi11KnN85hgeMHm1ERtFUaW177cvbYQjDegOZJpUWLT1PmKvMW9D+oNg9GwuYEF+OQ//1ocphuNkukA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.57.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIKxA4zjG5/adb00UdFDHitgRcm70v6rYd8bxoTLvL/d2pEXEWCQVMenEOjyMYYT2dMcSiMGaAzptdqAHIx2mUwpFcw5c782bqN+4dynSYRkKdu5tULDkteEkblyEZeoJvwk53DMBUCdITsTWUOqmHWzUuJI/f5tFGBOYP/6l6o64swxSAVZqnm6vSqs0ZsSc6p/BNd+L1tN3nsZ5cmP5e0CntP62QWC8AHG6J0EixtfSGhU8QokCu7LcHpd0ca2rwqMuxcN/ZnVy9dUy0F+ngt26V+aI4zTu110SA3NjK0+QHvwNe92U9oM+GVm/Pbt98whb5ptkJY347WvzPoZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoV/pt3LjTsXHW600pzkQFtozihrwte83MTFT3+KSwY=;
 b=MN5iXhfjTMTtP76z0+aYJ1cXU/xpqhWD2/FRRalA3g6LtDyyp/dbjAghEeG59q9yrw+2wfxmsJqP0PEeUkq5jMCpp/ZrtOX0Thj9IM24gHJJFCmiTNLQD7OlPo/OHt4AzgYmVtd1jUWb8CCMuwt4U3jj5zJgctW5yvgHZOudj7X7K21sUcb4pFoQWNsV4/QTKOvxSDHIam6cRxDxCCbQAItPFhfAmj01O7l1Q4VxiciAarETOh41vxauDHF7aoi5wsKpQoR0BM/aPVEDPEmxoEpI9OWnJKiyWdn/0Ycur7e8uSy6J35VjsB/Bh74n7Q7WH8ZU1s6dabOvlCIxyqlsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN2P287MB1855.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:08:06 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:08:06 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 0/2] power: supply: Add STC3117 Fuel Gauge
Date: Mon, 16 Dec 2024 12:34:53 +0530
Message-Id: <20241216070457.8083-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN2P287MB1855:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9f62f0-eff9-4e82-a61c-08dd1da0639a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDVPZVpkdjBscUZUdkZRQi9jd1plaFhmYnFjbGZaWHU0Y2lCNms5TFJjaVdN?=
 =?utf-8?B?Y1NxRHYzWDhuejFESVg4UVZNeXBtdGVWLzlERGFWL0NEODU1U3U5RlhMZHds?=
 =?utf-8?B?V0ZsZDZrRWlNaU8xa3lKMlptQjhFNFl0Zm1rMVVlTTRzUjh5MUQrV0loZU9R?=
 =?utf-8?B?RW1YTjM0c2ZDbk93clNxVWF4dkJ5UngrMzVzb0N5cVMrd1Q0YXNUZTlNdE9z?=
 =?utf-8?B?LzlRWnhpRmJwUEZYN0dBRWdZbXREZTBTaXVWT2djWHh1bUc2VlZPK2c0Yk45?=
 =?utf-8?B?K3dySXhXY3UxT0drUzhjQkFSOE9hNEhjSnBkaU9ocTVMMit5VGlYeXhlc0FF?=
 =?utf-8?B?ZS8yTFhwaldGbTR1Sy84RXAwMWNPYThzY0d1dC82YU1qNWxmZGZKQWdpeENX?=
 =?utf-8?B?blVLdXU3cWdIc3JZMVcvUGtuemYxSzRXd3NKNHFBZmtzZ3grUnhkMEx3N3gr?=
 =?utf-8?B?dit4ek9wYmpueGxydTJVYlowK2RobFNMbVVFcEVocEtnS2Vmb21QMjF4Z0F3?=
 =?utf-8?B?d3pnQlhYMG4rYVY1MUMxZHZNZGdxQlNsN1AvWENvUWRYTzRWNnM0Tmg3QXNG?=
 =?utf-8?B?UWZ4S1BwOHNIeWwwdHdjZUdmQWpiL1JQQ0ZsakFsK3JXdzhXcHhXQWc3YUpG?=
 =?utf-8?B?Z2Y0d0tpOVVMWUlkbXlxeGxjSnR2dllQZEF1UXBrcS9MbFJ5ajFNMklWd1BG?=
 =?utf-8?B?WnFLeFBHWTZONSsvcDExWjNoeDFDZUN5ODlTWU1CTEhORU9INXM1NFlnQ09S?=
 =?utf-8?B?b2YwMFh5eHBKb0l1eDBhWElhb0lyb0YxVDMwbGRBam00Wmw5N0hXYzhGeDNh?=
 =?utf-8?B?MnEvZGVwQ1JrWmFiRjdsc2RHNGMwZ2U5RlRjdXNMMHBsMHBVcy9NVDRWbzhC?=
 =?utf-8?B?K29nZ05kRmloMEV4MDhjeEFKcUhnZHNlQVhRdlJkbWY2a2xsbmh6MThRUHRj?=
 =?utf-8?B?RUdHOXIzSnQwNnlkR1JJMEpKZzk0TkQxVFRhODQrc25LRjgyUDZVeVdwSHNu?=
 =?utf-8?B?MU5kSk9BbXRzeTFRc3VKOUEwTlM2UnVGM21IZjJ1VjNPZ05aMzRQcVRwS2RM?=
 =?utf-8?B?NXhIN0piSnhodTAxUVYzN2tLMlNGaVhrdlVZUXZIOXRrc25neUFTT2FDV0hv?=
 =?utf-8?B?dmRKaVRnNWRNYlZvVW9KTHhDRHBxd1BYTEcxMlQ5Z1YwektXbmpvSFJnbjho?=
 =?utf-8?B?aFN3SmRYaVBlVVBCd000VDduT1pQRnF2a2M4QTUrZDFKNm4rZFRsZktla1FG?=
 =?utf-8?B?RGZ5Yjg5MWxLdGRwZ2JhMElUUnhaRnprQ0o0RDNydVcvMVJYWm5QM2tOTUJu?=
 =?utf-8?B?SmZCZkltRkxtZjY0RXQwS3dRa01hc0JUYVZaVkJmRXRacFozU0M0TWIxbFF2?=
 =?utf-8?B?eHhBUWo1aEZ0eG53YVlnMGo0b0hYWWJiTy9jVmVndVZFOTQvelA1VTIwWDVL?=
 =?utf-8?B?QnNka3l5TklPS0YzUENFRDB0YUlvVXlEMWEydVRSQkV3ck1teThRT3VkeTgr?=
 =?utf-8?B?UU9zTTZmb0IzT1JHSG50NzU3K29OMDQ2NUpnQ1d6UnJuREcycmg3V09xQUZ5?=
 =?utf-8?B?T3RCSnNNVXdWWkRkaWFqam1KUnpPQjlPZzlESitXK3lFQXJ2VDVZNkgxVnF6?=
 =?utf-8?B?cFU2K3Rrdy9Qc0tZU1V5L1phVGZKWjNvOUYyYXJDUzhnRU82a2dMWm15S0NY?=
 =?utf-8?B?THdsSm1rc1h6S3M4d0k5REU0ZzRDaWhJNlVWaWNKS0UvS3dwMkdIUktlNTQ1?=
 =?utf-8?B?Ylc2eUZIUlRBZXF2N2tFL2Nwb0tWYmlCWGovR2lXN0F5d29hUWYzUVdkaS9t?=
 =?utf-8?B?WURjU3N0ZGh2SHNpS0VRbTA2RkoxaWp6akpqTHdveS9wWENBS0dNT1Z5cGhF?=
 =?utf-8?Q?LANAeZv7N3IPR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXcxeFhBclZaak5mbGo2RG9kcnVFSFAvY25zd01sNzVIYUg3eStiVVVGRnJy?=
 =?utf-8?B?aFhnaFYvNDNOcUtNaTFzejI0Qzk4ZWFpQnEzdVRIdWRYUERoSno5Sm5vMGpm?=
 =?utf-8?B?cERlcWRYTU9acmJJcDUwU1dQa3hBdUlQRzZyc3I0UVdQUHFLTXAwalZuYjlj?=
 =?utf-8?B?bVI0N2QwS3FlRGE1WUV2MU1WRHZURS8vZ2FUdjFUNjBseFhrcnViQXJhdTM1?=
 =?utf-8?B?a0tyT1g3N0xYU253dTVJdW5zYm82WWVKZ1BDT1AwaDZxQWR5UnpyV1IrY3Zm?=
 =?utf-8?B?cjdROStxRXFJRlVYclFZdmNDY3BFMnQxaGw2aGhSWEQxTUYyODRyUnJ0L2pE?=
 =?utf-8?B?eS9qd0MxZUpYWFoxVGJtY0I5c0NHRTlQRmk0TGxFdEE1QitHWkVWNXNSSnFB?=
 =?utf-8?B?bVAzY1pMdmRkSjMxZDdHWHoxMTNUSEcraHRBZENkSXJFVU9zcFZUamtuY0pl?=
 =?utf-8?B?T3Fsb2UzV3h6c3V1ZFY3RWxQb01KbDZLZ1pMZklPYUdHTE9oRHZaWlZwanhR?=
 =?utf-8?B?RDU2Wm9tY3p4SnBwODhMcTBJeFZrOXdrZFk1Y1hwb050WFpMMG80cTdXQlpv?=
 =?utf-8?B?K0Z5cVpZKzdKWGpCVUk2eHg0cmdmaDdidExsdXd1SEVjT3dOM2FwT3pzUlJh?=
 =?utf-8?B?MnkwM2hrVXNJOEF2OFJCdnVXTG5IWjJlZEVvMXM3ZFNxSSsvSHpsR3htbGNw?=
 =?utf-8?B?MlMvR2hTQXBraEpUMUM0amdQZmhYMUcwM2pTNW1JL05nSmJ5bVA3Vy9oa28v?=
 =?utf-8?B?OXF1bUU3VE9FYm9nU2tldTFZd3ZyMTN6LzBWaXJZeE9jQ1hlMGNvdUR4VGUw?=
 =?utf-8?B?N1BrNUFFN3VvQ3RaRHBRZ2ZBaUZNSVk3REh2eXFyUGhjUDRDOFpGZThpRXp1?=
 =?utf-8?B?a0xuZDVLNUpiVDhGdFpIWFJKOVU0OFd4RHlqeFVKM29oVnVLYmpPWTE4T2lU?=
 =?utf-8?B?aUVQQ0JxRStRcGFHZjV1aUxnRlQzRHZMMko5cUluZnBMeVpoTTNLRDRyZXli?=
 =?utf-8?B?RkN6N3RSVmdoM1pkVDRpRTc0MlJTZjRUZVMzaXZwdVIvMzI1SWxaTXZEbWFl?=
 =?utf-8?B?cWZDcVpWd1JzYWREUDIreGRKM25JaHl0R3BqajFoRXlac2QrWDA5VFR4WHpt?=
 =?utf-8?B?b013b0hXRm15dGtvU3AzT3U4cE5rclVIb3JZY1pLWjk4enU3a1pJRnpQSy9k?=
 =?utf-8?B?UFd6MjBpdjhKaXlrU2Nzc2VzZUtQNFpSYXlIOVFua0FBUVNEdXpQWmZHWTBB?=
 =?utf-8?B?M2NLVU1UWTR3TExiU3ZPSytFV0wrbXo3TktOQXFNNE5WRmUzZWVUbmRybWN0?=
 =?utf-8?B?MWZaN0dCd01uelpmTFVMOG9XR3dQUjBJRXMycDIzN2dMOGJVVmlacU1aVHFm?=
 =?utf-8?B?TlorU3dVa1NTK2hnTEFTWmVoSWpvZ0NBLzg3WlY4OVZkUDZpREFCaFoydE9F?=
 =?utf-8?B?UlA1OXhycUZqeFFlMXRDdy9OeWUya3BvQngrZjRpTUt3VTIxVXNoMkJtNEg1?=
 =?utf-8?B?WnhGZVdybGJMME1INVppeWtxQ2RDaklLWlA4WU5MSWwwM1VxQ25Gdittbkw1?=
 =?utf-8?B?U3RpTlJ3cFRjaHdGT0xqU1plUnQ4VCtkeHA4dDFiTlBYN3dyNFl6M0hrUGRn?=
 =?utf-8?B?QUVuek5sV3pyNzJ2TXlvYm81cXEySUJYQ3hRUml2NERYR3FOMEtKUE9MaWN4?=
 =?utf-8?B?VURiVTFqc1FXUkxIWjhudjhpWGhBc0N5Y0lDYmxNdVFjMUs5MHZnb3B1bkJO?=
 =?utf-8?B?VHZrVlo1K2pGLzlib29DQ2Rkc0JadnhvenVBVTBIejdKWmp6T016ekZOdW1v?=
 =?utf-8?B?RjFORGVRSS90YnFkRFcxT3hpZVdRYUloOUpoZWp6T2VFRWZxQURsTjBEV2R5?=
 =?utf-8?B?MkdqRkZlVTdIQ2ZJbjZwOC80dXh6RG4xdnQvVnpYZVlodUJuS1RiZExxbFhz?=
 =?utf-8?B?TVlVelVtd1ZUdHhkaGN0YUo0ZWVJUUMxcnFrNVByMWhTSUZWK28yZk0rY3lL?=
 =?utf-8?B?bkorZ09CeUhHN1ZtbFZqaWdKT2o5STd5d21KSks0czRXQkFnSTIvdkNaVU8y?=
 =?utf-8?B?UTJqNjNsMWhqcEZ0VDZNZlY1dTdvUWpOSVNQTEN1KzBsVU5VcC9JeE51SEpG?=
 =?utf-8?B?UGREL1pxY0s3YkJxZmtrMFpHWkNVUzdzVHRIaWhuU2pScjB3WFVTblk2L0VX?=
 =?utf-8?Q?Ix2DBHyOL0BsR0ALv9jz8lc=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9f62f0-eff9-4e82-a61c-08dd1da0639a
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:08:06.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9waxoKzICF6gg/lv3RRbPMKdsvht/Gqk3waqAMOeupWjMKdZU5pV6d746uJVVEg2YNnCUDSd7B52mkFXT0FvwbgbMov1HjqZ3PX7tyL+u7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1855

Adds initial support for the STC3117 fuel gauge.         
                                                         
Output of test_power_supply_properties.sh                
                                                         
TAP version 13                                           
1..33                                                    
# Testing device stc3117-battery                         
ok 1 stc3117-battery.exists                              
ok 2 stc3117-battery.uevent.NAME                         
ok 3 stc3117-battery.sysfs.type                          
ok 4 stc3117-battery.uevent.TYPE                         
ok 5 stc3117-battery.sysfs.usb_type # SKIP               
ok 6 stc3117-battery.sysfs.online # SKIP                 
# Reported: '1' ()                                       
ok 7 stc3117-battery.sysfs.present                       
# Reported: 'Discharging'                                
ok 8 stc3117-battery.sysfs.status                        
# Reported: '38' % ()                                    
ok 9 stc3117-battery.sysfs.capacity                      
ok 10 stc3117-battery.sysfs.capacity_level # SKIP        
ok 11 stc3117-battery.sysfs.model_name # SKIP            
ok 12 stc3117-battery.sysfs.manufacturer # SKIP          
ok 13 stc3117-battery.sysfs.serial_number # SKIP         
ok 14 stc3117-battery.sysfs.technology # SKIP            
ok 15 stc3117-battery.sysfs.cycle_count # SKIP           
ok 16 stc3117-battery.sysfs.scope # SKIP                 
ok 17 stc3117-battery.sysfs.input_current_limit # SKIP   
ok 18 stc3117-battery.sysfs.input_voltage_limit # SKIP   
# Reported: '3704000' uV (3.704 V)                       
ok 19 stc3117-battery.sysfs.voltage_now                  
ok 20 stc3117-battery.sysfs.voltage_min # SKIP           
ok 21 stc3117-battery.sysfs.voltage_max # SKIP           
# Reported: '3200000' uV (3.2 V)                         
ok 22 stc3117-battery.sysfs.voltage_min_design           
# Reported: '4200000' uV (4.2 V)                         
ok 23 stc3117-battery.sysfs.voltage_max_design           
# Reported: '325000' uA (325 mA)                         
ok 24 stc3117-battery.sysfs.current_now                  
ok 25 stc3117-battery.sysfs.current_max # SKIP           
ok 26 stc3117-battery.sysfs.charge_now # SKIP            
ok 27 stc3117-battery.sysfs.charge_full # SKIP           
# Reported: '3000000' uAh (3 Ah)                         
ok 28 stc3117-battery.sysfs.charge_full_design           
ok 29 stc3117-battery.sysfs.power_now # SKIP             
ok 30 stc3117-battery.sysfs.energy_now # SKIP            
ok 31 stc3117-battery.sysfs.energy_full # SKIP           
ok 32 stc3117-battery.sysfs.energy_full_design # SKIP    
ok 33 stc3117-battery.sysfs.energy_full_design # SKIP    
# Totals: pass:12 fail:0 xfail:0 xpass:0 skip:21 error:0 

v10 -> v11

- No changes

v9 -> v10                                                                       
                                                                                
- Use error code instead of arbitrary values                                    
- Use Co-developed-by tag                                                       
                                                                                
Link for V9: https://lore.kernel.org/linux-pm/20241213063813.32371-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v8 -> v9                                                                        
                                                                                
- Corrected the error message                                                   
                                                                                
Link for V8: https://lore.kernel.org/linux-pm/20241210080954.5067-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v7 -> v8                                                                        
                                                                                
- Add output of test_power_supply_properties.sh script.                         
- Change 0X to 0x in macros.                                                    
- Fix typos and Specify units in property comments.                             
- Remove stc3117_update_battery_status function.                                
- Convert voltage and current from mV/mA to uV/uA.                              
- Represent temperature in tenths of a degree Celsius (1/10 °C).                
- Export average current and open-circuit voltage (OCV).                        
- Use devm_delayed_work_autocancel.                                             
                                                                                
Link for V7: https://lore.kernel.org/linux-pm/20241202094328.14395-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v6 -> v7                                                                        
                                                                                
- Removes extra spaces.                                                         
- Fixes error handling.                                                         
- Fixes the logic for checking battery status.                                  
- Fixes typos.                                                                  
- Removes unnecessary commas.                                                   
                                                                                
Link for v6: https://lore.kernel.org/linux-pm/20241130094531.14885-2-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v5 -> v6                                                                        
                                                                                
- Use shunt-resistor-micro-ohms property instead of sense-resistor.             
- Remove the battery node from the binding examples.                            
- Add interrupt bindings to the example.                                        
- Correct the Signed-off-by (SoB) order in the commit.                          
                                                                                
Link for v5: https://lore.kernel.org/linux-pm/20241129114200.13351-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v4 -> v5                                                                        
                                                                                
- Fix variable names                                                            
- Limit code line length to 80 columns                                          
- Add interrupt and monitor-battery properties to bindings                      
- Correct error handling with return dev_err_probe()                            
                                                                                
Link for v4: https://lore.kernel.org/linux-pm/21c08a45-34f1-443c-97d4-6baf9fa01b67@kernel.org/T/#t
                                                                                
v3 -> v4                                                                        
                                                                                
- Added support for current, soc, temp, and status properties.                  
- Addressed comments and feedback provided by Krzysztof and Sebastian.          
                                                                                
Link for v3: https://lore.kernel.org/linux-pm/20240205051321.4079933-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v2 -> v3                                                                        
                                                                                
- Resolved DTC warnings and errors                                              
- Formatted the changelogs                                                      
- Added monitored battery properties                                            
- Replaced 'additionalProperties' with 'unevaluatedProperties'                  
- Replaced '&i2c6' with 'i2c'                                                   
                                                                                
Link for v2: https://lore.kernel.org/linux-pm/202401080530.0hMWnrIg-lkp@intel.com/T/#t
                                                                                
v1 -> v2                                                                        
                                                                                
- String value is redundantly quoted with any quotes (quoted-strings)           
- Found character '\t' that cannot start any token                              
                                                                                
Link for v1: https://lore.kernel.org/linux-pm/46bba29c-330d-417d-ad84-ceb5207fdb55@wanadoo.fr/T/#t
                                                                                
Hardevsinh Palaniya(1):                                                         
  dt-bindings: power: supply: Add STC3117 Fuel Gauge                            
                                                                                
Bhavin Sharma (2):                                                              
  power: supply: Add STC3117 fuel gauge unit driver                             

 .../bindings/power/supply/st,stc3117.yaml     |  74 +++
 MAINTAINERS                                   |   8 +
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c     | 607 ++++++++++++++++++
 5 files changed, 697 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

-- 
2.34.1


