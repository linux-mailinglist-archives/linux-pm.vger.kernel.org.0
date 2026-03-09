Return-Path: <linux-pm+bounces-43945-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGdIIDnCrmmRIgIAu9opvQ
	(envelope-from <linux-pm+bounces-43945-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 13:51:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBBA2392CE
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 13:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B36C53001F8D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 12:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCB23A900B;
	Mon,  9 Mar 2026 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gWmicFp4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080738B7AB;
	Mon,  9 Mar 2026 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060268; cv=none; b=MLyAfuhaMukMpPODUAEA7mzX9tVZ6W7s9FkL05GGZzrB+O8PVgVjwHEW6/nIcm1nExxC+AT6D6GwzSnZWXAztx+NEJA9PhG9KuX3uf5pJ1FDHG+l3GFaY5wpZPGqmD5+Uxdr2fH3I65RoKdjIW0B4R+aUOGTbs2OlvWpgYiogQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060268; c=relaxed/simple;
	bh=fq652Rvi77S5uemnWQ3EvcHvuY1ulZFhUvcc5f+vdfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t7vmxoLaTPAFhKO5nA9WsAUSu1O9kffMsqJPeDbxhocslJMU4MXXtBCnYrxvkNPc3CZhuSGWcgsEb9ZhfvpMN5O6r0d1yhPNAFU5YZHBd9HEZnGzp5i6+7eClprbcXqZjQxdOjjfIxCO+Bjkm9D3L48WqAMUUvfnFR0dReSb2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gWmicFp4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629CWNFA512979;
	Mon, 9 Mar 2026 12:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QiqoG4
	BC0uPELLC3dEq1E9PYw3Gkjn1RjSkdWrdOp8A=; b=gWmicFp4PvopN4RwYkuEB6
	AmIVSswA9Xfrn1TXQVnJxoZgdNLZQ7GMBQIw0o915pzxNIa3LSeNha3mSzA22RJR
	u47KcH1TGTui42mX6zM0akHwUTXWK7PzeTaIGqX/25vfslzN3Gw4Vq9SI609QWQr
	FzPfv1M23xZXl5Y5eTZPK14Q+j0KZf2DvacZJISQgYz77+XS/tCI4znJAOYQvqsW
	yl7I4Rv/3PLif4OwTzAlHVP45BltSicc6bjvNYFmiP23UW/keA05wcJC/CF5wL0W
	VXdQE5Hytqn67ME7eVJdpUWqs5GysKoUZ9IAyk4X1UHDQTDKidh1bkP7NFCV7deQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1me9ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 12:44:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6298iJXa029359;
	Mon, 9 Mar 2026 12:44:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6uhjhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 12:44:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629CiBma53936452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 12:44:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5233F20043;
	Mon,  9 Mar 2026 12:44:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3A1B20040;
	Mon,  9 Mar 2026 12:44:08 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.43.43.220])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 12:44:08 +0000 (GMT)
Message-ID: <76613552dbe7e7d82100edb06225069964f13014.camel@linux.ibm.com>
Subject: Re: [PATCH v1] sched: idle: Make skipping governor callbacks more
 consistent
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM
 <linux-pm@vger.kernel.org>
Cc: Qais Yousef <qyousef@layalina.io>,
        Christian Loehle
	 <christian.loehle@arm.com>,
        Thomas Gleixner <tglx@kernel.org>,
        LKML
	 <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker
	 <frederic@kernel.org>
Date: Mon, 09 Mar 2026 18:14:07 +0530
In-Reply-To: <12857700.O9o76ZdvQC@rafael.j.wysocki>
References: <20260301191959.406218221@kernel.org>
	 <CAJZ5v0h-bGU34d9OnhYqdzz+5UiKV1rBEB9NS-TL4=sK2jf-LQ@mail.gmail.com>
	 <20260304030306.uk5c63xw4oqvjffb@airbuntu>
	 <12857700.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69aec09e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=QyXUC8HyAAAA:8
 a=VnNF1IyMAAAA:8 a=D-ap4ctOF62sSQj1xwMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNSBTYWx0ZWRfX4QrExJTIQKM3
 cfbNtzH0wbzOS/T1x0wh3aB/IEtiac7puOFa4dYye6Y0kzvijK6Hwrm8ors5sXgzc19N8nB9g8p
 R5jzWYInsh3ocolNfmJ3tvCuDSqujF/bGUDZeSIFIQPb7HBFRYm518478Ez3grcFrjJ9MszyBKC
 lhfBf3+qdbhqrAK3J6Qi7C1weP4i8Pit+vj4PNna3RLzn9pOwLAVOiG3SJqMApiONWAzCc+6lRc
 xvF3h8J2VUwm6qjpKmoRx5PeE5+9l5Id9oa3Gd7BMKVfpqT4SbNEZiaoZ58QrEu/lvZ+axXX1jT
 wxhqINl7xJLwbHvIO2EhaQDGBeKUWpF4xTNW8et+EfUthrErguFxbPhz+k9mtrol2djs4X1IWzG
 MKrEe8dlmY/9O4Fh8dyfTiPTO6S7gLi0076t/W1FBN9Tc5KPuNJ9AtJrZzz5/bVdtEryxR/FQ7u
 UFhC2oKfaMH28TAUHQQ==
X-Proofpoint-GUID: QkRYEINMspQ1OUxXgRVq1C8rV2GoF0mY
X-Proofpoint-ORIG-GUID: QkRYEINMspQ1OUxXgRVq1C8rV2GoF0mY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090115
X-Rspamd-Queue-Id: 9CBBA2392CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-43945-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.ibm.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[aboorvad@linux.ibm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Sat, 2026-03-07 at 17:12 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> If the cpuidle governor .select() callback is skipped because there
> is only one idle state in the cpuidle driver, the .reflect() callback
> should be skipped as well, at least for consistency (if not for
> correctness), so do it.
>=20
> Fixes: e5c9ffc6ae1b ("cpuidle: Skip governor when only one idle state
> is available")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> =C2=A0drivers/cpuidle/cpuidle.c |=C2=A0=C2=A0 10 ----------
> =C2=A0kernel/sched/idle.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 11 ++++++++++-
> =C2=A02 files changed, 10 insertions(+), 11 deletions(-)
>=20
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -359,16 +359,6 @@ noinstr int cpuidle_enter_state(struct c
> =C2=A0int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_devic=
e
> *dev,
> =C2=A0		=C2=A0=C2=A0 bool *stop_tick)
> =C2=A0{
> -	/*
> -	 * If there is only a single idle state (or none), there is
> nothing
> -	 * meaningful for the governor to choose. Skip the governor
> and
> -	 * always use state 0 with the tick running.
> -	 */
> -	if (drv->state_count <=3D 1) {
> -		*stop_tick =3D false;
> -		return 0;
> -	}
> -
> =C2=A0	return cpuidle_curr_governor->select(drv, dev, stop_tick);
> =C2=A0}
> =C2=A0
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -221,7 +221,7 @@ static void cpuidle_idle_call(void)
> =C2=A0
> =C2=A0		next_state =3D cpuidle_find_deepest_state(drv, dev,
> max_latency_ns);
> =C2=A0		call_cpuidle(drv, dev, next_state);
> -	} else {
> +	} else if (drv->state_count > 1) {
> =C2=A0		bool stop_tick =3D true;
> =C2=A0
> =C2=A0		/*
> @@ -239,6 +239,15 @@ static void cpuidle_idle_call(void)
> =C2=A0		 * Give the governor an opportunity to reflect on
> the outcome
> =C2=A0		 */
> =C2=A0		cpuidle_reflect(dev, entered_state);
> +	} else {
> +		tick_nohz_idle_retain_tick();
> +
> +		/*
> +		 * If there is only a single idle state (or none),
> there is
> +		 * nothing meaningful for the governor to choose.=C2=A0
> Skip the
> +		 * governor and always use state 0.
> +		 */
> +		call_cpuidle(drv, dev, 0);
> =C2=A0	}
> =C2=A0
> =C2=A0exit_idle:
>=20
>=20

Hi Rafael,

Thanks for fixing this, sorry I missed it earlier.

Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Regards,
Aboorva

