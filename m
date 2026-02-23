Return-Path: <linux-pm+bounces-43036-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM2SKqZTnGktDwQAu9opvQ
	(envelope-from <linux-pm+bounces-43036-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 14:18:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F8176A99
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 14:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85F633053E07
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2A1C8604;
	Mon, 23 Feb 2026 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VhVTfmRZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F23936680B;
	Mon, 23 Feb 2026 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852502; cv=none; b=alew28rwiDs6+Y6XlsBdNyXjJuOHPvgt6CKRXSt/pQBGaiv9I/DF3m60hUiM/LvMCGNFWYltwCq6DFph7EXzsBnHN/M+5rJvq7NYrAqR0vZPPNe/rOtEmDRnYBwLlhaaR6rQJ5kUw7gI+OhnC3x1Lcjrn2+nE/yt0jmEPXelKI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852502; c=relaxed/simple;
	bh=9vMVLC6u6HwsJjrlQb/VRLODhHk+XdbvNFxqmNw0T/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=lDDTgwdueHykv/93U+wWl6A6B6iEaHeRC8UOWBsw0vulb2go10VZcptbjUc2f9vPS1rDlmAo1vasF+hj5G5QjCeiWtxAh09SQQU+DqY0P6zja2bXgyheGJnuQVXBau18qw8AQin60N396M9By95peRzB7Bzb6cZTq5uasWn9UIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VhVTfmRZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N1F85K2962734;
	Mon, 23 Feb 2026 13:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zYhRLo
	iK0VLHYOzUwBccbAM03Ht3O7rDyk48fwSLsM4=; b=VhVTfmRZlcgUlS2H4zoNjO
	cIoftXjrnJVO+eqs4xb2LmUjPaQvMLgx3ARvMEmIwP/wzgaXegXa4SMfxebr4Jl6
	rOrZqqcQQVdXVymS4xyFEhlh7kHdBUqOgX+u0fj6nYjsUiXPIPVeFEI78dC0r0og
	gBu6wELB17+OmxixdGAA+Np2BXE4pyxsunqdDVWs/UBpEt1i+S5lWwcNwrRFbWA3
	Sqbwh3UB5HI+rcOfsm98h8jwSnrrCYtuKxzjE31EPy9hMQOYJy4FynC5EQqFa4b4
	VE1MZ+O/BlCHbXVsqMxxfDDFtylqNuDNvU+Hu5Hq2CvooDNEb1G1Jb9Q1nVL1oPA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24g703j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 13:14:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61NBfIQK003836;
	Mon, 23 Feb 2026 13:14:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8jmn9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 13:14:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NDE1Qp49545712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 13:14:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F358B20040;
	Mon, 23 Feb 2026 13:14:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D9172004B;
	Mon, 23 Feb 2026 13:13:44 +0000 (GMT)
Received: from [9.124.223.211] (unknown [9.124.223.211])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Feb 2026 13:13:44 +0000 (GMT)
Message-ID: <68149255-7398-466b-9d97-7f0124fda25b@linux.ibm.com>
Date: Mon, 23 Feb 2026 18:43:42 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] powerpc/xive: simplify xive_spapr_debug_show()
To: Yury Norov <ynorov@nvidia.com>, linuxppc-dev@lists.ozlabs.org
References: <20260219181407.290201-1-ynorov@nvidia.com>
 <20260219181407.290201-2-ynorov@nvidia.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org,
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
        Geetha sowjanya <gakula@marvell.com>, Ingo Molnar <mingo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, James Clark <james.clark@linaro.org>,
        Jerin Jacob <jerinj@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Leach <mike.leach@linaro.org>, Moritz Fischer <mdf@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
        Rasmus Villemoes
 <linux@rasmusvillemoes.dk>,
        Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Subbaraya Sundeep
 <sbhatta@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>, Tom Rix <trix@redhat.com>,
        Xu Yilun <yilun.xu@intel.com>, Yajun Deng <yajun.deng@linux.dev>,
        Yury Norov <yury.norov@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
        hariprasad <hkelam@marvell.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20260219181407.290201-2-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=699c529c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Ikd4Dj_1AAAA:8
 a=VnNF1IyMAAAA:8 a=RRjIJgXTCtlgTdhHy9AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zk86Bjz-ydPJYTzK12ycUFUxtnx4SsWL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExMyBTYWx0ZWRfXzUksRw9myqEz
 UixBWMUBZhLNgjnHiRif4qEj6UTL9WGyZkn27yUtF6CWFb9SYDOGa8ybNIYcoScAvxJAjZvhNeN
 crWv2GETS4bYnOXhGA0j9jBzFducGZUXccIKv+/lCjc59Y7xepUBptqzpDWEqkQeTWTMZOLtDAe
 JKMVrv5POWEa1ALIBmUFCCdNJAw5xb1J1rgrHt8KhPKHVdM2T59DOL7PmtHzE85KWEwjN5v4NGp
 KwqvUOH7ymRE+6kwdl+0y/KIhzwB4XbaesJX00qvqjBCniVexgjmFtm0aMlvo60ZeN66AO42SpO
 fZ+eus7mxmnk4gnXvoIwI7BShUWgz1g/JfCJNmaSyECFzmtlwps2RusoWi6ud1HQYaHQSf5ROEo
 rm2QmGaze6ialIdxLy6AR7amIsOcyElw9lE3OHW750fh185sPBRKByN+/ioJoQpV2aiqznoRRJa
 UDMaxIW562x9oJGezoA==
X-Proofpoint-ORIG-GUID: Hf_7wRhC8iujCJ7VvfJzpi5rfR7wKIcE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230113
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[44];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43036-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,infradead.org,linux.intel.com,lunn.ch,linux-foundation.org,linaro.org,google.com,marvell.com,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,rasmusvillemoes.dk,fomichev.me,intel.com,linux.dev,lists.linaro.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid,nvidia.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sshegde@linux.ibm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 4A6F8176A99
X-Rspamd-Action: no action



On 2/19/26 11:43 PM, Yury Norov wrote:
> The function creates temporary buffer to convert xibm->bitmap to a
> human-readable list before passing it to seq_printf. Drop it and print
> the list in seq_printf() directly with the "%*pbl" specifier.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   arch/powerpc/sysdev/xive/spapr.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
> index 5aedbe3e8e6a..f818299579b1 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -667,17 +667,9 @@ static void xive_spapr_sync_source(u32 hw_irq)
>   static int xive_spapr_debug_show(struct seq_file *m, void *private)
>   {
>   	struct xive_irq_bitmap *xibm;
> -	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>   
> -	if (!buf)
> -		return -ENOMEM;
> -
> -	list_for_each_entry(xibm, &xive_irq_bitmaps, list) {
> -		memset(buf, 0, PAGE_SIZE);
> -		bitmap_print_to_pagebuf(true, buf, xibm->bitmap, xibm->count);
> -		seq_printf(m, "bitmap #%d: %s", xibm->count, buf);
> -	}
> -	kfree(buf);
> +	list_for_each_entry(xibm, &xive_irq_bitmaps, list)
> +		seq_printf(m, "bitmap #%d: %*pbl\n", xibm->count, xibm->count, xibm->bitmap);
>   
>   	return 0;
>   }

Looks good to me.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>


