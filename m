Return-Path: <linux-pm+bounces-22708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C5AA4047D
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 02:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6903B2F0D
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 01:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDEB17578;
	Sat, 22 Feb 2025 01:02:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99754414;
	Sat, 22 Feb 2025 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740186162; cv=none; b=Ysh0dTDe6kzS+36JSztI/qEqkQJOLohHH8mGxnUY5io4weYiN9OYrA9DtblvJJPUOphKwFmvgSMvH/hVRVTjNkMtc+cuJy6TELxFQO4kOYO/MX6sFAMXamCageHUyQh835wup2f9aFwcac6UuuBEuFjENvRwmQhRBmfCFxzSnGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740186162; c=relaxed/simple;
	bh=NKLRRIgf3DYLDNRMQeCcvYWRQWxccqPowHRvi0rlWZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3BvcfhyB2nrGf+RU2+iKrrDZ37LFXOGPkbrpBxh7I8wjMFzQm/GV+1rPCqeEo1Xy40EIzpfGTDZWKrG3QCiZ1aIuPvkkP2wSrekjhWiZFYLzjfAWD2JD+ne0baBTWH7yIA0v+ajKzQPtK5rfwEEqwTJWWWAgbCN4wTQZTS14Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LMkGQ9018777;
	Fri, 21 Feb 2025 17:02:34 -0800
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44w00kcerh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 21 Feb 2025 17:02:33 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Fri, 21 Feb 2025 17:02:33 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 21 Feb 2025 17:02:31 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <rafael@kernel.org>
CC: <len.brown@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <pavel@kernel.org>,
        <syzbot+ace60642828c074eb913@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] module: replace the mutex lock acquisition method
Date: Sat, 22 Feb 2025 09:02:30 +0800
Message-ID: <20250222010230.9102-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0hu=Gi82zS27MwKj-uhEciuD6JN8cZLd+75J3VKY796wg@mail.gmail.com>
References: <CAJZ5v0hu=Gi82zS27MwKj-uhEciuD6JN8cZLd+75J3VKY796wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=N67TF39B c=1 sm=1 tr=0 ts=67b92229 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8 a=UbtQlmD_4ytLos8nrPUA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: xztup1q4mCWFVlMfifwdnYO1XlfN-GTu
X-Proofpoint-GUID: xztup1q4mCWFVlMfifwdnYO1XlfN-GTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=585
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502220005

On Fri, 21 Feb 2025 21:07:59 +0100, Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > syzbot reported a deadlock in lock_system_sleep. [1]
> >
> > The write operation to "/sys/module/hibernate/parameters/compressor"
> > conflicts with the registration of ieee80211 device, resulting in a deadlock
> > in the lock param_lock.
> >
> > Since the conflict cannot be avoided, the way to obtain param_lock is changed
> > to trylock to avoid deadlock.
> 
> An alternative way to avoid the deadlock would be to replace
> lock_system_sleep() in hibernate_compressor_param_set() with
> mutex_trylock(&system_transition_mutex) (and analogously for the
> unlock operation).  Why have you not done that?
Yes, you are right, I have confirmed that can work fine.
I will send V2 patch for using mutex_trylock(&system_transition_mutex).

BR,
Lizhi

