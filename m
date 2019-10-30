Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 341ADE9D13
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 15:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfJ3OEu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 10:04:50 -0400
Received: from cmta20.telus.net ([209.171.16.93]:52060 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfJ3OEu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Oct 2019 10:04:50 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id PoaZi6cp8N5I9PoaainIX7; Wed, 30 Oct 2019 08:04:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1572444288; bh=WJl/Zs24GFWlEsbeF89Dj/2Rqayile7sFsqtPXzJ8gY=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=b/0GuUzyyoTPlUH59Sb9pN/m0nMfbi04i6g17Yk0sp0UMVjc+Ms1djkgb/3PrgIF8
         K3r5vt0MkS+CK3qa82YAS6ZD1GEfuKoreWHWbLiNNPYo+Cc4KzR8G5OK6/KzBlPZHg
         0pTqUVXF0KkzQr9/Y1OJQ4poI09jp5lNHI24RQjpZNcbmVXqepcBrKlBHuhoxOx6Tu
         ZsMoPUXW0waNaJOkJaQG6yCz1zEZj9URWUzXTiYxG2Q0s4GPdZrVxFpgFVyrhVU2fZ
         gfvUh3KRwE4UnKEaSnMtY4uHD3n0gR8Ov3csEnaDlilogGqTqW7PQi4dtm4pm+9HQI
         ER5fnQJ4SEueQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=K/Fc4BeI c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=qIE3Bv85-ZitGDqRaokA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Vincent Guittot'" <vincent.guittot@linaro.org>
Cc:     "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'open list:THERMAL'" <linux-pm@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Ingo Molnar'" <mingo@kernel.org>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Sargun Dhillon'" <sargun@sargun.me>,
        "'Tejun Heo'" <tj@kernel.org>, "'Xie XiuQi'" <xiexiuqi@huawei.com>,
        <xiezhipeng1@huawei.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Rik van Riel'" <riel@surriel.com>
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net> <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com> <000c01d58bca$f5709b30$e051d190$@net> <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com> <001201d58e68$eaa39630$bfeac290$@net> <20191029160210.GA8343@linaro.org>
In-Reply-To: <20191029160210.GA8343@linaro.org>
Subject: RE: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load balancing path"
Date:   Wed, 30 Oct 2019 07:04:40 -0700
Message-ID: <000001d58f2a$fc593200$f50b9600$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdWOcj5NDaNMZsSTQUuRuqwCnNBdRwAt1ecg
X-CMAE-Envelope: MS4wfBxVetny6cp33PTZir3OVfW1MX09EzRaMXmcljIjr1EIXAbAncmTTjt3A8b4DoD/0OnHrJG7USEyLmh7l4PVT1/nPP7/sHEewTPkx0lIdzNsRCF3xCFq
 rMVbicXxj/2mdx+W96aevZ7QrczGPJO9siv8yY8hSxkFgR925ef50X/LpYp3I1V5MRIaq35EYzuMnnFWFGFB4mfTL7LTexpZa3PY05mJCRahAZEofEPfuuhL
 6r2W0CinsZ5cMO+/JddQe5MgZwkVSpIxgpvNU209CAlmNxO+nIMxcHO7zqvFWZ8R7zlR8fk3zsyJ3+vikuWMMslekMeEQ2mTQj49BtVTR6I+DX5DcUmnoPdd
 lznXl31M1sEPexiKa0WvKprKAM2dCVNweobewV9KHhIja7zKGZPdhScM2lhcl3UCxhXU+VqFGv0Zor9vpmVb+Opdo4BXJUrVX/vjQgQrhcXvyUCo4YQgVSc5
 IdOisKyK2uyR4NDwDbKPzSBKCNhWmzuBHII9Tl75KOLi9LytyCW7dw0fsgqT+Jh/7HOzjC2klcfTogek0eGg0ylLL20i6nu/5ace+w==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.10.29 09:02 Vincent Guittot wrote:

> Could you try the patch below ? It ensures that at least the root cfs rq stays
> in the list so each time update_blocked_averages is called, we will call update_cfs_rq_load_avg()
> for the root cfs_rq at least and even if everything already reach zero.
> This will ensure that cfs_rq_util_change is called even if nothing has
> changed.
>
> ---
>  kernel/sched/fair.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 151c0b7..ac0a549 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7552,6 +7552,8 @@ static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {
> 
>  static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  {
> +	struct rq *rq = rq_of(cfs_rq);
> +
>  	if (cfs_rq->load.weight)
> 		return false;
> 
> @@ -7564,6 +7566,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> 	if (cfs_rq->avg.runnable_load_sum)
> 		return false;
> 
> +	if (cfs_rq == &rq->cfs)
> +		return false;
> +
> 	return true;
> }
> 
> -- 
> 2.7.4

Yes, this patch works and solves the long time
between calls of the intel_pstate CPU frequency scaling
driver issue.
I see you sent a formal patch a few hours ago.
I'll try it and report back.

... Doug
 

