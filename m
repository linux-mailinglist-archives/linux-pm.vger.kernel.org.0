Return-Path: <linux-pm+bounces-28025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E030ACC895
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 16:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2C31894CB7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 13:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A61230BD9;
	Tue,  3 Jun 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qruePmhX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1791DFF8;
	Tue,  3 Jun 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959178; cv=none; b=fPtuidXdwwZYn5cXVOhqJ3QVxAsLry0I/+OoqzypUAPHFy8biCHk0vl54E0t1c+8EGY7x/fLEqtzPBOsyY/PXom+hBJ4dQUX1UVHpBiop+9hkxVYzcxL/fUxoxcTf5tlTwAiwU0SGv28VKZ2BpnBMOpbAK784j46Uq5zgWAFXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959178; c=relaxed/simple;
	bh=8O01BeD3JeBGoCXMVGKmioU2y+7W8/zk5PFp0PTzOCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhwrhQG6w6DpT1rCEKG3MSnY8i0t5ob1W4Niy78PCemadnh1nAvK5H4zGSt4WHTSc3JEc3n9UYM8kGpCdgUMCMjROR4sYyEAnIYcLLB1IyLislHmMV9h+kcNocGbetlICkkZg9LlQTB3xZ+glaW+m6EkmQW8Qy0Bspbz58qT+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qruePmhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15506C4CEF0;
	Tue,  3 Jun 2025 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748959178;
	bh=8O01BeD3JeBGoCXMVGKmioU2y+7W8/zk5PFp0PTzOCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qruePmhXwLwIT7yubZ2rZ1crCtxzob6uzm08WfAD1wV3bvYzhB2xlL0O329ckyApr
	 arPLahzg+pfFk+0spIfnt+5aUpPE54/q8nleDN/gqWPT7YfsKsdwkd8EqQZVmIPy7h
	 pTUgBvuwntrQYTWLISg0JX6O7Ypl5uwJc3OLha7wFy8vBDlIs5gCGvyTRmhNqpxjn5
	 GW84N5NzxOvq/7dMln14mrOknedBIMPJL78poPaQ2sB3sdIw+242UGSjh7kyjgn9l2
	 arfVwCR9iINO4k7DT5dJzq01R/NCe24FsleitVkR/zB82eCGuyMFs5Oa9KrgTLbdhq
	 dyb+mBzZohBSA==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-40791b696a2so898051b6e.2;
        Tue, 03 Jun 2025 06:59:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCoaWc0HWsLtZOYb4LvdNDzynRpHaLb+wzkuBMqJcoSAD3mO2P5CNoTMr9OjxetgjLfCJVuYTcC/A=@vger.kernel.org, AJvYcCVIgVFtycb2ubqcHQ/14zYeLrHGeUTGkR99Gh+6KSVZPA89Ss83xJFFSIgyiEb0AlvXXKCMDPjI1AhkDCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv6gSNILBWK2X5pshGOEtdFwFjJRaU80qWOhvp1k8apoynpvsR
	6IN5XVXF08JdTUN5XZyUPh2Zsgurq2mW3AWCmQ9JUVgpGDegCk6Z3O0AMdLJ5ttmHQIL22VMEPp
	ifoCqxeObO8lgxWduPPsMqV1jdPTgrVc=
X-Google-Smtp-Source: AGHT+IGz9sON12m2CdSik0QSY1yX71qiBMm+dsJBK0M2V5gvh+KI+TPMkvmjVzkb2Wmx5U1j+QnI/M+7F/k3doV8KA8=
X-Received: by 2002:a05:6808:6f89:b0:400:fa6b:a104 with SMTP id
 5614622812f47-4067e6e30d2mr9667733b6e.33.1748959177407; Tue, 03 Jun 2025
 06:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
 <aD7L0RD4HT-mEtBc@debian.local> <CAJZ5v0h65Gt1Fw35vp2k8kKu62+goCD8WF8u-tvhfWW6a7xHxQ@mail.gmail.com>
 <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
 <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
 <CAJZ5v0hpJSVdiCN29=kbV8KfgU1y1d3hFfshtBoMpVFXf+LvBQ@mail.gmail.com>
 <aD7nOMP3xA9BR781@debian.local> <CAJZ5v0gAcohRWuSZbFWvyfAU9Vjc7nRyj+AFRYQ7hcGEXdPxyQ@mail.gmail.com>
 <CAP-bSRbVjcXBvxDT6ZQuoRB+JF6A4LhdMVnNqnaQC0bg-xg2BQ@mail.gmail.com>
 <CAJZ5v0gTRtPzrROdkxRjTeXv4BsRyUkyGpCWmh-gHNx3X2L9RA@mail.gmail.com> <aD76cCE5qyALjKHc@debian.local>
In-Reply-To: <aD76cCE5qyALjKHc@debian.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Jun 2025 15:59:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gy1Fi6QYw1XYwfszZN=x5O=gWDnassPfsh5RY5_Ap-fg@mail.gmail.com>
X-Gm-Features: AX0GCFtkYKFF_TFvKerspJLAsqHSQV36SIt8zWO8vVSk14cy87pDGd1iE5I0DQM
Message-ID: <CAJZ5v0gy1Fi6QYw1XYwfszZN=x5O=gWDnassPfsh5RY5_Ap-fg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending children
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mario Limonciello <superm1@kernel.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Saravana Kannan <saravanak@google.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 3:36=E2=80=AFPM Chris Bainbridge
<chris.bainbridge@gmail.com> wrote:
>
> On Tue, Jun 03, 2025 at 03:04:33PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jun 3, 2025 at 2:27=E2=80=AFPM Chris Bainbridge
> > <chris.bainbridge@gmail.com> wrote:
> > >
> > > On Tue, 3 Jun 2025 at 13:24, Rafael J. Wysocki <rafael@kernel.org> wr=
ote:
> > > > >
> > > > > This patch does fix the list corruption, but the "Unbalanced
> > > > > pm_runtime_enable" still occurs:
> > > >
> > > > Have you applied it together with the previous patch?
> > >
> > > Yes
> >
> > So it looks like some devices have power.is_suspended set from the
> > previous cycle which causes device_resume() to attempt to resume them
> > even though they have not been suspended in the current cycle yet.
> >
> > Please try the attached patch in addition to the previous 2 patches.
> >
> > Thanks!
>
> That fixed it. Passed 30 attempted suspends without error.
>
> Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>

Thanks for verifying!

I will add changelogs to the patches and send them later today.

