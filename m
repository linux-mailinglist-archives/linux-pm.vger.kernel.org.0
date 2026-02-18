Return-Path: <linux-pm+bounces-42830-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGruE4sElmm4YQIAu9opvQ
	(envelope-from <linux-pm+bounces-42830-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:27:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9616E158B2E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A9603004C64
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 18:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607092DC77F;
	Wed, 18 Feb 2026 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k/j4t03k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380521E0B86;
	Wed, 18 Feb 2026 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439194; cv=none; b=INR7Oz3EzwGBVrwpFsHec5/Y/arqVRFLl3Jpx1np81c9RoJdLElAnyHjmPALMOPzSWj7K+idqt/nIHo6RNinSNQyKb1FDWtk3mzwBGhsfPOlJraPvr5QGHIQmQ7k6jfPt3bTLr26cNdrfgWMuOk1sxpzFSDP5Ql0zQqCEYpxrpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439194; c=relaxed/simple;
	bh=7Yyd2HCvkaXIWy6qqXK6fOMN6hH5whlTZ+gAbEBvVLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbjVAVDKSogKgVUjtKXHe46vPJJHoYe6Mts2vcB2MRt2xoRkIE/I6AGnPzzkwlw4IP/Y3JIAIZLa2yPBC7k6ferXfe4H7E1hSmB9SZDVodwyr+TIx+2AVCasqspOmJKfyn628wwPeh2b0vPjVZFeChiOvcYdu3wto7rkxwbrl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k/j4t03k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I7igPR1709464;
	Wed, 18 Feb 2026 18:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aSMqx/
	8Wq8FVY87sQZOpIPky+fsQTmdhh/gNmO0nWrg=; b=k/j4t03kOjCLnUDSrqziU/
	HRvdqSMey09o40geJMmYYpqfNlIcYdz76Izp5jG2eFsARV54sH2P5Zva/iEMinCP
	PHjoJdoEvRzlC0AdhrF1kS6VvNe7Ybglxob0dwJD35jhXanc2IombmcJH6O2Mpzw
	nOU0vutotb6G4GTFEJOD4nIxqu9jU9km1hXqQC+0fuHkS5k/rPMcBBT0r9bTi0aH
	t6OrxwXXNfzT3OW4GNJUmqL07wPVG4T77V5UMlZl/fz2+4/qxr2TxwApTfVDyEy1
	eO+0Sod2EQ/5sNUyUXsJ0dkNIu7f1nS/ilwoTFjqD8SG/09GQcEnz/k4W3ywU3Ig
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjhk1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 18:26:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IHXDUc023889;
	Wed, 18 Feb 2026 18:26:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb4591mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 18:26:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IIQ0Ak30671362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 18:26:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D59342004B;
	Wed, 18 Feb 2026 18:26:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C7A820040;
	Wed, 18 Feb 2026 18:25:53 +0000 (GMT)
Received: from [9.111.93.209] (unknown [9.111.93.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 18:25:53 +0000 (GMT)
Message-ID: <9e2a3f47-5505-4354-a958-9afd80b8d39d@linux.ibm.com>
Date: Wed, 18 Feb 2026 23:55:52 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] sched/cputime: Remove superfluous and error prone
 kcpustat_field() parameter
To: Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E . McKenney"
 <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20260206142245.58987-1-frederic@kernel.org>
 <20260206142245.58987-3-frederic@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260206142245.58987-3-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: COMeTTok_dtfqvhDj6zW6pAdtHX4WVto
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6996043e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=r5z7TjAmST2rKvHaZ-8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE1NSBTYWx0ZWRfX53xzpBhIUsVG
 jiDf4CV4GJxna5FtVHCtF/1LXecpymWUk1xpLzUu4OlrSY4aRj8Swd25GqEXa1moMKJ4me+qn1L
 m2W+9BQG9NraJeD3jOTP2du/C10eUke7AVt+jwE8nLBIM8Uk7ubuc9+XhxVNZn71wB8PUXRJMRd
 wSUKnEHRf7jYojrf99y/aYaFneyAmooqSYYdgt5p70Iiue5u29wj4JIoQbQVk1ZNUhD9MPHAVmd
 Aam2YTuRKhyCMn7F4EyhCJ4ryvPuZyJTwVUxLXO4aum7DhHVVK7jR10Etb8klQvdQ2hotjXJvgf
 YAdgBd8UMIJ0pUPJnR016/q/hNzUmt7WYlp2unybKEh3/Pi98XyAQqCGxIjx4ToDsBPBqgauj0+
 uWJ2wLcU5e4eflUNTDKW2jr8q2jH4JTYH2kfQybflv5phHVE3okT8OFIFwNwsV3gUiQKtCkO+d6
 MqtfpBWXjqDarYYWd3g==
X-Proofpoint-GUID: 6DNaEwXNXqxD-fzPFmq5BHgx1hZ4Eslk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180155
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
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42830-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sshegde@linux.ibm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 9616E158B2E
X-Rspamd-Action: no action



On 2/6/26 7:52 PM, Frederic Weisbecker wrote:
> The first parameter to kcpustat_field() is a pointer to the cpu kcpustat
> to be fetched from. This parameter is error prone because a copy to a
> kcpustat could be passed by accident instead of the original one. Also
> the kcpustat structure can already be retrieved with the help of the
> mandatory CPU argument.
> 
> Remove the needless paramater.

nit: s/paramater/parameter

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>


