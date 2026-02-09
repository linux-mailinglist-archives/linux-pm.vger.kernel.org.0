Return-Path: <linux-pm+bounces-42313-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIzgIIdHiWm25gQAu9opvQ
	(envelope-from <linux-pm+bounces-42313-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:33:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF9910B214
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 03:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 961BF3005662
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 02:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C567A2C21CC;
	Mon,  9 Feb 2026 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RFJBT0xz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m1cvyd2/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1692D9798;
	Mon,  9 Feb 2026 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604372; cv=fail; b=HBtjJ8T12xcPQ75MfU8H9+562oanHA8+q7kChiE+Xz5w2s+3eq1nCUpcQW9GY2md4GGb3TvqzCPE0mr8Eh9pmBzf5BOwQY8XWB9muaxa7exqa853kiAffHR5oNbPFYdSswgQ359AzetSFgYZshigYGFCfyCYsrcoeeN/LsVyNtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604372; c=relaxed/simple;
	bh=kRu2Wv5Z65JaJeYVyx5JC3LHWthPA2ALbSzwARt5nMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rnz3MwqEkj9Oxx67LMYE1FtsrtIHQA7ej3pNXqzPP8Sv7gnFOHEQNzCS11wsIKhkJe9c68WvYo/NUlXcaD4YKu7g7GITu4G053OXHRA7iMyayFQZ4334E/N773Q4keCU7l49Z7fJX7G2UxA2r4zoj3k6jLIhONfVHXAbTNz2BNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RFJBT0xz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m1cvyd2/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618LlXwn3754172;
	Mon, 9 Feb 2026 02:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MSv3SXtyYg42xnKQSsMXPSLnnjdeR8uNgoBd7VaQeDA=; b=
	RFJBT0xzdEyVtvOXVIBXxGlm+tKA9jmoFpAwhCpHdY9W3CED+lGX84Wo1Fyo22aB
	1E8YD+Q9eSykmxyvXenc7A6BWpN2/F6bAmgYgrAuEGLGlVsNMJYHLNKYiBxq1bqo
	Oe6dL2MLPou6yDQcTraiNg8S4F6cIQZaKBpBJGTbqYQnA4SFmJnba7hFXoxalYYR
	TS4bw1S2tMX9qQdadv/QNemVRPnjwfyOPXSRQUC2tvwJgAfN0551/pfo2ldV5EAC
	sRKqjjW8qiuDPyQgcDowznV4G6/ya1Tikw94Vb15Fz1BwAJwCRgRQQMtEcrhSqLK
	Ajrnt7oh+A6SZyYoW3Va5g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xjys9cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61924QZF019786;
	Mon, 9 Feb 2026 02:32:06 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uu8g9q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 02:32:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiitfIE/2zu2bynXQqv4Huqj56dXOlDUbG+sj4rLsMEIvkq9Y5UZB3d8cBDMuI039eqIPWKYoxPXfe8R08thIXC32+enXDxE0BGeFp2tzJ03SC/LLLs2Ta3Xw+PPfg0noyBU5Ne+XR7fhO/ElTyjaDo3xFnzLTbwPi5Xm6ZO7C4DH/SbVXcDRCg0u6ZRmf+ZZJ3hMmuBEOv9+zLJg3kOmEY6jOFEPPHOTyaJ/VO5yRbd8JFhWGjbcMaKjZO2mbKo0lcXN/uepOVR9IxazAN89oVJJo9St98Eq2vNnn3FnwoekagtlXJKANEzfc1cNB+16p+swYPshZiInOJJpNZ2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSv3SXtyYg42xnKQSsMXPSLnnjdeR8uNgoBd7VaQeDA=;
 b=J/8t1qURC/BD7wQa8aAIUW8/nCBTrC2hc/JbL3azv72lU4+myX/eaKRgObk7rkzJwQqvgnJxbzQBruhNyZvn9H15VY+RhtB7vSFtauGPkqw+ZtTP7OCCTs0L+Ig+157kstp3UpsGtiWHnU+bYjyGcK/zWvC85Z3AwGLYx43SzJ0DDgzEmQXctrII5wQscrHMmFSJXWsVcUpmjqKF28ufeDvbZU0YqYYGUWm0io0416F6K4dUIxIfGpjdhBZhAbbfKVmQC3bYBv8rjgk1HjOMtZZegom/jqHKqw79M2pkAgVVWhZDV2MdjsFfzwedGQagajxl+ggeMJDdDAMMsKJOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSv3SXtyYg42xnKQSsMXPSLnnjdeR8uNgoBd7VaQeDA=;
 b=m1cvyd2/L+mg/qdkM7h/WTskhVM5622aLqDNtQX/4sccWNk56gTuOaAX4jLKEIoJWECODq57W0VonpuKFdMkC3DrixoAX1ugqCqmU+eKin+ezk5+FHiVU4dajaigAlu/kXLmFXaTNQtWNBM1hjkf1rZgJhZpRd0oGpz788bICrA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 9 Feb
 2026 02:32:03 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:32:02 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH v9 03/12] arm64/delay: move some constants out to a separate header
Date: Sun,  8 Feb 2026 18:31:44 -0800
Message-Id: <20260209023153.2661784-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:303:2b::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: c2dedb10-39c8-450b-aa9a-08de6783689a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8/osd+00Yn3SDTNcCQtYF7BcJOAeWW+okuPL4jnzWunyz1LRZwnTvxsSn0xA?=
 =?us-ascii?Q?f7VBEiWVYOZ8kkgpw9QIGZixlEH0pqNqyV4uljlY3/51IM04e3+VTgvNVD/I?=
 =?us-ascii?Q?l4ME/POnyEFHVPRvDqsTlgbljtvK9twGPUTBNqMpq5lVN//bgJy806hQ5PEB?=
 =?us-ascii?Q?PYPc/2QfvHufvDO3mQZyF7lSEqitAehjZeZdbUFoVGrfZB0t3jxkhcryBJFl?=
 =?us-ascii?Q?1utpw/3EmPy6e6fLOHyqllUkhqqgzR/dyTO0c6O/TrSKbDbkZlBlo5dGOTjI?=
 =?us-ascii?Q?YeKV2z2WnM9sCWFslaKlQEpFRsZuXx8Js+JjaP3narlU1kGKllGKGW/basOy?=
 =?us-ascii?Q?JbZ5eHkQOq3lrTd3+BAQHQlNz6PzNWpqOlGsKqUgOpzRClRbObZJUlghoCVk?=
 =?us-ascii?Q?nX4FDRD9SH2NJDfBSNMfYkZr2+LKPYAhCYMUs8m1PribwT/exiVbP7ewed/Z?=
 =?us-ascii?Q?fYLIk7+4s3G4+URq3OtvUDFHTSV6XHGHVYUqGuxQ2Ef+qZ0eC/uZGqioa+L8?=
 =?us-ascii?Q?rthcYM9nll4a/XpwbESSS26CblH7/ee/SmJ78BmsPxZ/ugkYKMOVdYJWgd1z?=
 =?us-ascii?Q?AaM4P9gaQTvIbTx7tBExeniXQRO3zsLzrEpqqnx7m1tCEHM7X1kYJ6r617fU?=
 =?us-ascii?Q?gUGNoeixTDXY5XRYSM3FarvNuo/N/gS7MlUduwdRa/TyQj4JnQY+abTlF2fy?=
 =?us-ascii?Q?ZU8qIx26VhX5N5BCH7Vh6Yl8PeUvspW2n1mgySRqWyVIu+pCpHM6icmWJatl?=
 =?us-ascii?Q?zw8p8EtCIImBfZj/QCfbzecdDtgm1zzeroJyK5TUGIVNdrEtvZ1jk882KRnX?=
 =?us-ascii?Q?t/+GCh6nQnnXtm3CfnIzPLPYOy5nOPmQ8ds6Ywl0bfzHtDydpVptWLY30Bsa?=
 =?us-ascii?Q?OuMNLM7aJOZXVV86EB2mepuEzExKYThk3F2oKVbSGWQqXYnx+f8tC1gnB6Pc?=
 =?us-ascii?Q?se+26Wf+p0tdC8T5BR4onitORbgBwPBoqR41inDCFX/vUYjmsT9wOOGgVORB?=
 =?us-ascii?Q?qGbMP+qp417E6Csc2oAjHzGRFhve2CtCG/z9pPsp0p6xJ0wEz7QYbL7dAjZ4?=
 =?us-ascii?Q?Qs4aS9uJeDDTV6oKKq5gYko4Y5K1nv7KHP1lWk3P6KCPeLK0cIp7xyeLrV5P?=
 =?us-ascii?Q?489TYC5gDNjyPQFS4h8sKyPpC26vj53eOgfCk4EJSxzOov56OV+0k16bMEpM?=
 =?us-ascii?Q?f1Ry/CSudl2eszrtDolVeSVgPN3Cxr1Dm0L+7X4ogi7ZZZCIdyZI50kxLMz4?=
 =?us-ascii?Q?XTsp3HFcgm0wuG8z4p+GUYC9STGfFl/CIapphiFRHkuctgvIPfOYd4eOjqOQ?=
 =?us-ascii?Q?NgIjTB9lC+6/dikjIGcONPdCpGCuJDY6RgHjFz4ynX2P2K3n9MopjP1lGgWZ?=
 =?us-ascii?Q?3cM50fppRxfJ7tsOn0e+D9WwW9DVqENdRzqXMWxu+nToQz38S9DW36czYgXU?=
 =?us-ascii?Q?Lom2pQLeXiCnzLVbiC2sz7vrnK0RlXSAX1e6DAoXsvCXPMRP3DXAZb476y+3?=
 =?us-ascii?Q?KUUyhnRIB4doNolUsup/GlIRPelmRi+dnn9DDm841Nq+WqRau4rSaGmhF+5W?=
 =?us-ascii?Q?RHLAwdFnCr72M3HDfAE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GgUsDfKdmp/5Mn/w5o2sK1xpSL7IvxVz7x/kn1unTPKBsn9fzkJmg2HTYUpI?=
 =?us-ascii?Q?EaRd0CPAmbWE9jzvXmqrgfAX13JLHcbg1DMBilwnIkPXkgmsprn+mR6N0JrJ?=
 =?us-ascii?Q?VWjxqljnJ21gaLkejDQyYPysSwRaygBuizzOGpUrISqagaJUF/EqDZ41QNZJ?=
 =?us-ascii?Q?bwBBrF5TPueafdxV2R1+k0lP513RNVlGM/sbyWJ7T6oQ1bvoNqhdB8rTLm7E?=
 =?us-ascii?Q?ZLB/jTx8PC51Yrx/ibbSyGBullFbWX1UKCT15oTDZ/OiuGbYWp8BkqIF1tde?=
 =?us-ascii?Q?hXlTtvvvHczBZDUinGoObv6g7321nu2Wu55pEan8KZt+smsMfsokkdu4jtM8?=
 =?us-ascii?Q?+4KXacOozwiLjS9FvU/K/GnhyycipdVK0qAgKnAYj5LsAIhijjov+pah1TVO?=
 =?us-ascii?Q?2ockNSHZDqgwfBF8IAM/aZqaJsZ1xAak2pubgac6Zw/u74NCnT0LrWW4xQZe?=
 =?us-ascii?Q?9qkgnUurerWqcfASpDskcHyW5qMjYuz1IEmDqhTJ5VOxzuTkDuopZjyn8+MS?=
 =?us-ascii?Q?HFM3rPwvhlzu4dP3fJgcZA6othNbSfQdHaCb8RBEI97KACZJUim14BJuVHnQ?=
 =?us-ascii?Q?sBPF0rZSZRMeA9JabMRNQno0CUdH9BDdH0Rs6oapsFb/YRX1XNc7Mr+9ff6g?=
 =?us-ascii?Q?myvTSNWHfi0cgziDKTXyA6cvggeATl0Zbq1MIBDmtHM9RJ4SIkcB0MEvrId2?=
 =?us-ascii?Q?ncnHMGBUuYK4uV/B+hL8CK40xig03fYXsbelvhCSs+ko7dEXGmVFALbzKSkg?=
 =?us-ascii?Q?YKhZ2/7u86JQP8H0OZvVfA/hFeV5i9jZcgPBNwnPZVaf1gU/rbySa5pAIFF3?=
 =?us-ascii?Q?TlVfdmie4XCVHT7BOvSWm6vX5EkGKmdiN9N57dPo8yaEaaH+8U8FnjyNVDa5?=
 =?us-ascii?Q?wrymtg7l8qCs7MTRRttmMCH6MU1kPTUKsAfQ5fxGrwierzp8U+Yir4MNH8F9?=
 =?us-ascii?Q?1SudpbaX+9lMPlcFaOFFqGK5RlXP66QJbnpq+o7cSBZa63rFppj302xL1o43?=
 =?us-ascii?Q?3Trwiw8erZp5q7W+G4TGejh8blesyopULxA5JQZKQRHyKJcQ4pGuE2XVRYea?=
 =?us-ascii?Q?f2Ox+X6WFMcRQX2/iXN9WIPTVluHHlxWd1V2AtQBNOnG095FQ7gyu3UTYVn3?=
 =?us-ascii?Q?yx01Os8IZYq5y56lBUqVz1vD8NyL4+fqbWxxh4KFylVyppMaXK8YBH22OQVD?=
 =?us-ascii?Q?bSak5HjyhY30Uz7Rn+uk7SwFu/pNAIdQvX6P7JrQVYXKsLg+fOYp31tVaDuu?=
 =?us-ascii?Q?CMuy+nZ5rf9dZXCoFYJqmv4qre6vjxRglIoE7PmdWFq3Cwqju6PrKIu7b+Kh?=
 =?us-ascii?Q?McB0H+gUeeBL7Rqw8/Se8UgvW5Ri6u9B/ICdJaKI++uBkT0yz5GOQC6TEqij?=
 =?us-ascii?Q?SPsYF8bkWsTWe5VR7G7FUZnw1VioDaMtn7Esi33mqUaKMbtMnroF4jOWIhSb?=
 =?us-ascii?Q?9fv2pcvvjKRiKtvUbGEdKRl2Vj9Qw35wiAp3sTJEzHJ0ArA0Ske40NkTmP4d?=
 =?us-ascii?Q?NGWbi3+Hld0NNDgj51edzlyZbGQzji+wzRSbdx/8mEZhO0ZXT6evFEcyitiD?=
 =?us-ascii?Q?J9a8zuV8GDA/VPZI8xWcY6zVRdxlD2dE42AwCJxsbBPcIgsy2or/D0pvySb2?=
 =?us-ascii?Q?tpR949uDGfUiZ6Q1BGSewoHSVj+vyWyLZIaM/HTMboDy6GnRx7XB2nIdqSTV?=
 =?us-ascii?Q?vqpoRww1UsbM7oMgNcJOGWoTUqQntH6TLiP4X43MlVxZwSWqfaoJ2ggrCRzp?=
 =?us-ascii?Q?bjhwuhdDAXDLvA4ukmg1fAPLLqWpIUY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jRrHa9xz7NNBMPOmjEvFk3ZDTfuzT3aRRd/vIgcAbiF7IYK6xbhMGPxs2HD87Pue1P7TTDMr3Jj+hX98iHP28NbsmtpvnyuzgGUF3mRhWG3Q9IWSbqcHtQ6wYA+3RHMLhoCfGNywJ8eisI5v3IA/bf0FkhAC4RirCR6popbJ+MfqEKtarQNhb1JIQGW+gffO4bHHOIAvuXjMa0QKmU4tiFPZDyGgfX6C9PxdOK3uGrhzFv2y+5XU2RpFZyWxhOCi9dFZnpsjcJm+xEKi90GXXmGk6CX+UZcpVmDevvUKXibHbhgIV1LLrZznxraxoJ+LmO5sQJZf/NIlqwoTe9PitfbMrwjpAMepMPd34CnT83OMCEhc9LVZ4Y4LHFgo4HAWYicn/MlGtYkneXRE7hKsismgEv7EFml6Dp3RTVceu8ZfZeeycQ+bVzmLOZDbfw3jWwOD7xpR5Z/Lqk7NIh0pXRdmR5mGg5yVe5Q1zDU3hP1FTnvFccGpgbgqrnzbQGCkHZvK6uv9FxW2cndAy6/KgoH9b+hRnEU05xrZmTMKxA2S7rxPzMHlxnaFXOUoQnVIOW+OOyJELWNwD45Jpxd/ZO8XrI+k+WwiNyhFUcTd8Vw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2dedb10-39c8-450b-aa9a-08de6783689a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:32:02.7519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNC044aPVIdF0oKaNG9nthbTnBwt39rhViDQVpfWAfdwSrRoVAl6DMU+WMjmjAKXrMCKnr9LN8SoRRjqQ4BvSXQeWnN+oVMtYPlsTS/X/Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB8212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090019
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMCBTYWx0ZWRfX8TID+xS11Ch/
 wg/8pnolQRIbHQFFZNI3LdlPx1Wdcv39XILQ2HmPevpo9UWG5BsdBaQN8M9VX4s7PXbxW9IU+GP
 hxDemj566t6i8u0GylU6/0igbtq2Lnt/xSEwwDRzBAfyIjqIjXgyYMzlXv/ucIQONPYoLmbfapR
 uzwt+52JZDPc9Eu0WkJMMazlBcCW3fLqzOyhFpws2WcdDChMlUOIuQijPs9JivXQZzoUrG5BQRV
 48ihoF5uiZMRDdQvvXHmb9KZ2RVpfvOadDSZ/GWOrRmV/G4Y02LApYJnOG0h0WRPWOIqQy40ED2
 9kWFjMDrCKPSLxzYk7XD57elHj4XTCKU7b8slnhaIb91Lo/9dk6WB8kmws5QukyqtHWtJ3fiBU/
 pCvTxbZQOCal/CWOR2oJHu42GDfRDke6QdyTqLKv7ugRGWJ+r8yjiDHw1sQ/UCTON2tBnzvIi9N
 8yvQiIdTVpLkb1RBpoA==
X-Proofpoint-GUID: owR7Wr3gX0M9MXs1Hjl091sHtNwcTiBU
X-Proofpoint-ORIG-GUID: owR7Wr3gX0M9MXs1Hjl091sHtNwcTiBU
X-Authority-Analysis: v=2.4 cv=VPLQXtPX c=1 sm=1 tr=0 ts=69894726 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=NufY4J3AAAAA:8 a=yPCof4ZbAAAA:8 a=d4sVeSq9ft_tFhUswqUA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=TPcZfFuj8SYsoCJAFAiX:22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[arndb.de,arm.com,kernel.org,infradead.org,linux-foundation.org,amazon.com,gentwo.org,linaro.org,gmail.com,huawei.com,linux.alibaba.com,oracle.com,linux.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42313-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankur.a.arora@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linux.com:email,arm.com:email,oracle.com:email,oracle.com:dkim,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2CF9910B214
X-Rspamd-Action: no action

Moves some constants and functions related to xloops, cycles computation
out to a new header. Also rename some macros in qcom/rpmh-rsc.c which
were occupying the same namespace.

No functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
  - workaround warnings from the kernel build robot.

 arch/arm64/include/asm/delay-const.h | 25 +++++++++++++++++++++++++
 arch/arm64/lib/delay.c               | 13 +++----------
 drivers/soc/qcom/rpmh-rsc.c          |  8 ++++----
 3 files changed, 32 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h

diff --git a/arch/arm64/include/asm/delay-const.h b/arch/arm64/include/asm/delay-const.h
new file mode 100644
index 000000000000..63fb5fc24a90
--- /dev/null
+++ b/arch/arm64/include/asm/delay-const.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_DELAY_CONST_H
+#define _ASM_DELAY_CONST_H
+
+#include <asm/param.h>	/* For HZ */
+
+/* 2**32 / 1000000 (rounded up) */
+#define __usecs_to_xloops_mult	0x10C7UL
+
+/* 2**32 / 1000000000 (rounded up) */
+#define __nsecs_to_xloops_mult	0x5UL
+
+extern unsigned long loops_per_jiffy;
+static inline unsigned long xloops_to_cycles(unsigned long xloops)
+{
+	return (xloops * loops_per_jiffy * HZ) >> 32;
+}
+
+#define USECS_TO_CYCLES(time_usecs) \
+	xloops_to_cycles((time_usecs) * __usecs_to_xloops_mult)
+
+#define NSECS_TO_CYCLES(time_nsecs) \
+	xloops_to_cycles((time_nsecs) * __nsecs_to_xloops_mult)
+
+#endif	/* _ASM_DELAY_CONST_H */
diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index cb2062e7e234..511b5597e2a5 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -12,17 +12,10 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/timex.h>
+#include <asm/delay-const.h>
 
 #include <clocksource/arm_arch_timer.h>
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
-
-static inline unsigned long xloops_to_cycles(unsigned long xloops)
-{
-	return (xloops * loops_per_jiffy * HZ) >> 32;
-}
-
 void __delay(unsigned long cycles)
 {
 	cycles_t start = get_cycles();
@@ -58,12 +51,12 @@ EXPORT_SYMBOL(__const_udelay);
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
+	__const_udelay(usecs * __usecs_to_xloops_mult);
 }
 EXPORT_SYMBOL(__udelay);
 
 void __ndelay(unsigned long nsecs)
 {
-	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
+	__const_udelay(nsecs * __nsecs_to_xloops_mult);
 }
 EXPORT_SYMBOL(__ndelay);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c6f7d5c9c493..ad5ec5c0de0a 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -146,10 +146,10 @@ enum {
  *  +---------------------------------------------------+
  */
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
+#define RPMH_USECS_TO_CYCLES(time_usecs)		\
+	rpmh_xloops_to_cycles((time_usecs) * 0x10C7UL)
 
-static inline unsigned long xloops_to_cycles(u64 xloops)
+static inline unsigned long rpmh_xloops_to_cycles(u64 xloops)
 {
 	return (xloops * loops_per_jiffy * HZ) >> 32;
 }
@@ -819,7 +819,7 @@ void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
 	wakeup_us = ktime_to_us(wakeup);
 
 	/* Convert the wakeup to arch timer scale */
-	wakeup_cycles = USECS_TO_CYCLES(wakeup_us);
+	wakeup_cycles = RPMH_USECS_TO_CYCLES(wakeup_us);
 	wakeup_cycles += arch_timer_read_counter();
 
 exit:
-- 
2.31.1


