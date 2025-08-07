Return-Path: <linux-pm+bounces-32024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9CAB1CFC2
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 02:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E74722618
	for <lists+linux-pm@lfdr.de>; Thu,  7 Aug 2025 00:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9CC224D7;
	Thu,  7 Aug 2025 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+cL1e6o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A2125D6
	for <linux-pm@vger.kernel.org>; Thu,  7 Aug 2025 00:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754525975; cv=none; b=hizYyFCNcRMzzoNFjH5940wQOszS0W3zucIOlatKSYr/f4TqXRq6Ls4oaR/jelmCyiozj1c3MfRhsbFz7m3m3sNVQzAAG27ZDl5Gm+pofdsP/8KtIh4WzjhkYJWqyxFhaFo7qe0a5H1HMThZSxCaSBlLAQbggH4GhepwHsfaCcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754525975; c=relaxed/simple;
	bh=V45+/g9l57X061i/AJfurAaQ1LktlWXKfnjc54KGRy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlnO46UPGURa00laviekSzo9i+G0XxWUEwcBsTm+tvKXZ33VUvI5gMDHll9pWEUGdE673lX3+BA0rbOUBg+E/zKpukHFSXdkU/YXWbjP/xZPBoB694EaypKBLSnhqUbeSg4M2W+Vr7Mc6OTySv/YnE39IeadSHauiaYbddN6ypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+cL1e6o; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso69191cf.1
        for <linux-pm@vger.kernel.org>; Wed, 06 Aug 2025 17:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754525972; x=1755130772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dgP+zhcaADygYaQXyTSbLIaYArUUmgQtwcAwUW61Z8Y=;
        b=J+cL1e6obB4ypVB5MWW+b6szs0z6nqCuQaxp4zuxJn0O12al5Z3pwvl1WEez4B16dh
         kIqlKsKqa+YXn1SuVjSDyzMB3oMW7nBT4OKsyQSV1ZB+BbYbnrkjklJsfCWRqshWfYSK
         mTwtfVHI1JFegKnlnOdYJU2j49oeWGuAdkcWkqFaCmEwRclaYvcWrvLolcZRHqwhq9Jt
         sTTT7RA4GRdKDy0U28uMiW3YreT7AOmv3Div0+JzANW2wk2VpEpkzKQmMBxMV3njJkgQ
         3/sLWkvlAVWa1adDAS0D7XY4SDUUaiAAZUyoWkLmpoVDhjOR3PXkLuDdi2tOKPo/Pse3
         46Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754525972; x=1755130772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgP+zhcaADygYaQXyTSbLIaYArUUmgQtwcAwUW61Z8Y=;
        b=UNwF2xNR0Eoj0pS1i5UwXjBFKcvR/zp/hPaMTlKrwEt5TBMeyyOHyzN6hrVvVfnhCp
         xe7jF9lw55KTnGYwS43yi9Eceh4WdG7vZb8Pv4JgdIpkMb8ciQB6tb+ibrVd7uIfHxh2
         V48AF5JsA/3F/ZrgZQfPgq+QUZToWmzi+A3zaDC2FCIsXlmHhVf3aj/fBJA3ohrUeJyh
         kcuKN4AOXsR5YgUGrvgSc4+atqU04EHmJT/h5STfB2Y8jGGIkMijIwgivNQgBPX3oFRE
         ceMiL8coeyX2eZ0lhfWZQskK+k+9anrLzGyjcIqhKXCdIlrxfL50YXFwrth3X2l7nz8Q
         yexQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/EO8Z29k2vssUpakWQkn6FWE3MaVwNYnSxZ94ppmOWWIyKxQ1ayMqaffTwrghifkEs2/zEP9h7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7gT3Ma3od3gbETiCflYxQ7o1P3UCo4CexyXONCnCSEhKwGFH
	TPzWunao8UHhkkX2XNE1Xwze1Fyu7xqaCIpq+CWZsxB78x1T4diiJ+geBFl4bdg8F6Suz/6SaKy
	YyWtpP9qbCbTpCP1MynLRmSN343WaCiCzZBPut5d3
X-Gm-Gg: ASbGncsrexLpsMAzdB8ExwpqMuXqHyq7cgMB493rIgobaijQRTCL2RSSjHMcgpMbIHM
	gQFhMy/D8r3D6C0bkXaXk6GmBDB2htUM2inSFxT7Sue5zzAqAASGxKpqFc6pJl/Tkq4dYdf+PdZ
	cy8lRpfeXsG1XnGHwZRC/AC+kNaow4k6eIimt7rTqvM8m5WPOTjvZSRNzXLCWRzyc74mXrVuUko
	d+mDA==
X-Google-Smtp-Source: AGHT+IEm2OZr5WMtmCHB+RT7oF6lUwc9a8EvYKHj0z/gLvtRLJO/PpUOF4nJhDVk8FyNRnVgayU+v6ZMDKG9re+oono=
X-Received: by 2002:ac8:5984:0:b0:4a9:a4ef:35c2 with SMTP id
 d75a77b69052e-4b0a37e19damr1095621cf.23.1754525972152; Wed, 06 Aug 2025
 17:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aHTOSyhwIAaW_1m1@arm.com> <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7> <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com> <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
 <aIvQvLL34br6haQi@arm.com> <20250801044340.6ycskhhkzenkzt7a@vireshk-i7>
In-Reply-To: <20250801044340.6ycskhhkzenkzt7a@vireshk-i7>
From: Prashant Malani <pmalani@google.com>
Date: Wed, 6 Aug 2025 17:19:19 -0700
X-Gm-Features: Ac12FXxojuuRrR58-DaRDywei9mlAi7OGPs5Bx-W4h0K6atiuzT9Wy5aIC8wuyE
Message-ID: <CAFivqm+gBBSCoVUxmeatu8TjwunzBtfjeDMNBL0JCsPhkFEg5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Beata Michalska <beata.michalska@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 21:43, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 31-07-25, 22:23, Beata Michalska wrote:
> > The reason why I mentioned that is that getting current frequency
> > for an idle CPU seems like smth we could potentially optimise away and save some
> > cycles (fixing other problems on the way, like this one).
>
> I agree with that idea, just that the cpufreq core may not be the right place
> for that. Doing that in the driver should be fine.
>
> > But if that's undesired for any reason, it's perfectly fine to stay with
>

So, do we have consensus that the idle check is acceptable as proposed?
(Just want to make sure this thread doesn't get lost given another thread
has forked off in this conversation).

Best regards,

-- 
-Prashant

