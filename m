Return-Path: <linux-pm+bounces-25345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9CDA87883
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 09:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8931516E365
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F30323A9A0;
	Mon, 14 Apr 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GwG03lGK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68647239083;
	Mon, 14 Apr 2025 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744614937; cv=none; b=D8rfxXvYej8cry7NyH7STCzGWawqNv85ImbBtafvZcYKe1bJmHsc3UEWMOPPXSXugxj7Ec7BkgV67avtbBAPiG71hL+YbQMEk1+vwkqLOWszHXQ/HIIdFhJ1qKWgsN/NdZUDhcfBdl5u55bs/azfZDsiNHNMPb318HC2VokVrVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744614937; c=relaxed/simple;
	bh=Tw2tXWs2wGcWRTPB0gJYGHNMRJ7yGZsEUJwm+877cbg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lu6JwR9zIstucU4bkNDfS2QkGHB4hMF+AhJBCjWM6vFTlfY3+HNU5V8jco09j0b66wtSddwXcVd9qJ+yG+tOrcnUmW5766kQXBY8e0d+iiaDIlm0l1sZW7LO3jmfcN6JUMk2I3AutRSpOFZN0SmHDVkyQNf3DC7lfGq7lVaF03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GwG03lGK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E708fH025241;
	Mon, 14 Apr 2025 07:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Tw2tXW
	s2wGcWRTPB0gJYGHNMRJ7yGZsEUJwm+877cbg=; b=GwG03lGKemGPtTBlyeeP7z
	t5PiQtP/NQoZ8ZIaxdgVmAeKI2Qo8W/+LXMLBaSrbHsHmBApl4BJIQhU4jHRF5Yq
	2uFBnIEx61zaLFsnM07EDNY5Y62akaP2fVnL5ZOO+FKy8D2xY6iETh8QYih2rbta
	MfOQ+AxqWOGqy0YdxARMK4ahvAmEZ7KrLAEjKR92pDwEa0bl48viavBkzLzZYIe7
	FJmuIn+GdhuRBa+F7QoepQURCx8FzA7wHMSEnsKguL6BV1YKAqNzycOKW4XxRGxr
	jlPmHF+D+avU+BKaLJkH6fOuFbOP14M8qZONd9Lj0gPoBEcl69cgsWZ/Ie1lUs4Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460bqpb8gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 07:15:27 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53E7FQNP001293;
	Mon, 14 Apr 2025 07:15:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460bqpb8ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 07:15:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53E3vXLw017170;
	Mon, 14 Apr 2025 07:15:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040kn0d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 07:15:25 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53E7FNTW21955250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 07:15:23 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 489C758061;
	Mon, 14 Apr 2025 07:15:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F09DB58056;
	Mon, 14 Apr 2025 07:15:21 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com (unknown [9.43.55.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Apr 2025 07:15:21 +0000 (GMT)
Message-ID: <23742d13848a8cdf24da43c08ebe061211f46ecc.camel@linux.ibm.com>
Subject: Re: [PATCH v1 0/2] cpuidle: teo: Refine handling of short idle
 intervals
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano	
 <daniel.lezcano@linaro.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Doug Smythies
 <dsmythies@telus.net>
Date: Mon, 14 Apr 2025 12:45:20 +0530
In-Reply-To: <4661520.LvFx2qVVIh@rjwysocki.net>
References: <4661520.LvFx2qVVIh@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qgar2r_EoA08XHseT2LeY_WhDTieWko-
X-Proofpoint-GUID: CsHK94dMR4RWHs-9S7HhOpJZ1qXzrPII
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=643 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140049

On Thu, 2025-04-03 at 21:16 +0200, Rafael J. Wysocki wrote:
> Hi Everyone,
>=20
> This series is intended to address an issue with overly aggressive select=
ion
> of idle state 0 (the polling state) in teo on x86 in some cases when time=
r
> wakeups dominate the CPU wakeup pattern.
>=20
> In those cases, timer wakeups are not taken into account when they are
> within the LATENCY_THRESHOLD_NS range and the idle state selection may
> be based entirely on non-timer wakeups which may be rare.=C2=A0 This caus=
es
> the prediction accuracy to be low and too much energy may be used as
> a result.
>=20
> The first patch is preparatory and it is not expected to make any
> functional difference.
>=20
> The second patch causes teo to take timer wakeups into account if it
> is about to skip the tick_nohz_get_sleep_length() invocation, so they
> get a chance to influence the idle state selection.
>=20
> I have been using this series on my systems for several weeks and observe=
d
> a significant reduction of the polling state selection rate in multiple
> workloads.
>=20
> Thanks!
>=20
>=20

Hi Rafael,

I'm running some tests and going through the patch.
I haven't noticed any deviations so far, will post the results shortly.

Thanks,
Aboorva







