Return-Path: <linux-pm+bounces-25224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EBCA85A0B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 12:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB004A476F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DE117D2;
	Fri, 11 Apr 2025 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqsYxC9G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885B278E5D;
	Fri, 11 Apr 2025 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367462; cv=none; b=ImmpVVuucHrbalVV+CiRAeBAkrUiA2mZokYpmjuWge8KvblQXmlktgw01Roc2v4oRtmQ49s+ieJCDqPULcm506DEnQLXwPIoxAJQS+5n/UiOlq87/bW7hgT1oK6xKQSGrGRDH5JF/YGMLxnG1tpROkSB/PecoKkf+AVAHm8O+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367462; c=relaxed/simple;
	bh=6Gwa5w3owrBlIZyBkzhAeBY2fksfigo03OfNrgjBtbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPZtYgmihKTPEBsZhgnEMsrNQWIvb2jHOIIMOOXJhjU88Mket5v8KqI5AIXQMALpgrM7nTT19ve36E0SnWpzbcT3RTjgwP/C4dZbouuJnVRQwSmHxZWRuAy2UitL5Iwkq9abRTV+hcrk1WDU0qiomPAXvBHmd/pCSthVuxuf5ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqsYxC9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DEBC4CEF0;
	Fri, 11 Apr 2025 10:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744367461;
	bh=6Gwa5w3owrBlIZyBkzhAeBY2fksfigo03OfNrgjBtbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FqsYxC9GSdc3kIp0YcBtpyQpp10sGD1DZM4LgjlRF3+PvvX/AtSzFHCb/kh0arojD
	 eO5+BaWLftgF6MxPcobSNezgMErH9MJmu/EG4LbUiUikCrlZYCCpAJTdBy1C8sTvq2
	 c+K3oJc+OH12x0RBFF9AVo7TS58pHh/9ZKlBJ+lgC/VjPTg8K43BxCX70YVpelF8gC
	 kZmovlpy5El+5lfSvZSws35SaTXaVPUOE1yIOzNc1D2RpytKRqh/iC/PclFB2H2dTP
	 fwCxEkoaoMt0VwII/oLXJoaiuaBMZ9gXBPVn7GAObiGNTNU61aLjwJgZJL+jI0H/Nb
	 KQar3532qazuw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2c6ed7ec0a5so817512fac.1;
        Fri, 11 Apr 2025 03:31:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJdqnfofj1W08gUTMbGoPWwIIGxF7RfnbrcROjjtJJFV1kh53bZA19jD5UWcvVCo7zZAbXJZyyQmg=@vger.kernel.org, AJvYcCXb7S16wVqOAGicd46kOQyS+Qbqd1L8vGxuUwkPkWBhLGTw0TRt0KnxNcPtSlRZdRcqgBKa4Ol2BW1FOcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYlD/2GabW3B3mCvWYsfRpZ43dtZ87/9sFRYG+sgCwwcbt+jZW
	KaFxgl5G0GX14KBuiMsd/5AsFAA2FQs5ZlAdAEpP9lRSG+t9M/tVPHj9vc506H8s2PJlm2lDkPx
	OSh4ujRmVz3zWWKeCWZ7Dj1OFxzA=
X-Google-Smtp-Source: AGHT+IH0LX3bDDoDBM0kIknin6Kvq5ZRj0ozncoHMNHLV1Eir1yLnmQSTP9h3Tww8fkeKeA6kWZsW4FwIzMNMKuSkRA=
X-Received: by 2002:a05:6871:e71a:b0:2c2:5639:3a4d with SMTP id
 586e51a60fabf-2d0d5fcc80amr1201791fac.38.1744367460800; Fri, 11 Apr 2025
 03:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410024439.20859-1-sultan@kerneltoast.com>
 <CAJZ5v0jKyy-3cELyDQTynE3Dv29V15F5f+w0A-H_nu+4LuaaYw@mail.gmail.com> <CAB8ipk-EAALE1bhihF3k8i=uk_cPtDom+dD0KP-U3k=vgVj9ZA@mail.gmail.com>
In-Reply-To: <CAB8ipk-EAALE1bhihF3k8i=uk_cPtDom+dD0KP-U3k=vgVj9ZA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Apr 2025 12:30:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hTb6+cNA4fP6ovg2M3woLjid-fMy8jAp8S--=tv+7f4Q@mail.gmail.com>
X-Gm-Features: ATxdqUHSAKFBNaCPYAfEF12zbgjVtf7UFcyxO-QAEdSoxtit892-U_G_UKOm0hs
Message-ID: <CAJZ5v0hTb6+cNA4fP6ovg2M3woLjid-fMy8jAp8S--=tv+7f4Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Don't ignore limit changes when util
 is unchanged
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sultan Alsawaf <sultan@kerneltoast.com>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 10:22=E2=80=AFAM Xuewen Yan <xuewen.yan94@gmail.com=
> wrote:
>
> ...
> >
> > AFAICS, after this code modification, a limit change may be missed due
> > to a possible race with sugov_limits() which cannot happen if
> > sg_policy->limits_changed is only cleared when it is set before
> > updating sg_policy->need_freq_update.
> >
> could the following patch prevent the race?
>
> https://lore.kernel.org/all/CAB8ipk_Ayqmh=3DCh2aH2c+i-q+qdiQ317VBH1kOHYN=
=3DR9dt6LOw@mail.gmail.com/

The first hunk is essentially a partial revert of the problematic
commit, but I'm not sure what you want to achieve with the second one.

