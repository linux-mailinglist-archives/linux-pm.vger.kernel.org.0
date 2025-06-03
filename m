Return-Path: <linux-pm+bounces-28016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BC3ACC750
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 15:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E704B1894CCB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 13:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DB2229B12;
	Tue,  3 Jun 2025 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpiLr4Yy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C66E555;
	Tue,  3 Jun 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748955887; cv=none; b=cERXxbfC6SznHVFq2VP9KMMTn783gC/9kA/vyuUe7QVX6TV2MdshnpXrJB9KgZUQ6B4aATaQNe7V8M4MvMJdKyUhEIhp6uwXOoNhe7BUG25WK75V2gDvU+RcZlkG/8CRJIkndRaWsusdAuZRKlg8bG+0xBpkg33WGGF3uaDVToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748955887; c=relaxed/simple;
	bh=DoAXo4OnDoZDuAMbwm5BIR0ENeifjBrBXXHSJzqMr00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgLPtY1l/7iJEgdWyZADmlfAATGynl2lCVzW9jWsaUo9tUUKuzTFdwyKDIppv+d1fAvbnb1sLcjxrqXmEsgJQbJm9Nq417v++A9KejSv1W51g/MEw/YdJqZEA6KtCPQj2NpJ7oaOjOPVKqTZPy/R6UvIrIqmdz3GyUyNdFXwk5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpiLr4Yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0DAC4CEF5;
	Tue,  3 Jun 2025 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748955887;
	bh=DoAXo4OnDoZDuAMbwm5BIR0ENeifjBrBXXHSJzqMr00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CpiLr4YylX3AxM3o89JCo1GxXmRkLiF4MIJZ36P1QJdEE6P9wwpUEEdk90h1xOOz4
	 OyKP2I7pYha6q1nX8GBDsrZ5+tmILfYUePakFLi+YVJzCL6VwPnFOmfG+YUr79Z7G5
	 fsB47LyIVIuP5+S4tsLbvdcOySExmu+R3r7O2vi3zImiuEah5F0hu0wIkjKcgoYAh/
	 etfpsd4z3GHD2LS3u1UatP/m8U0Fjj0FZrBZ/2CG+4yzc8ha2n6a4FmVX5e+xcpUCn
	 jhVvODiXfOSdD4UmMGnM9tpVfnxO4ergaPZBQIUb2otdzeABcLtot2mLnVtqHAYJNU
	 Q7erll6/4CpFw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6066c02cd92so2631928eaf.2;
        Tue, 03 Jun 2025 06:04:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxwtU7qEcpaB8LIZlCqupsIUqkUdI9oTlwzhmS9ZbnL9QsLdicI71FZfFqHwUVwE/9TEMhV/WSDRA=@vger.kernel.org, AJvYcCXtZaUi1iIxdfpSKgdIJEB/6wp3WWfLOjvvLB1uTliavLgOCWABblEmytSvduyjWspLfFlZRXR4PVnkNRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGnP96UmHMNDoPZmzZWCBLEyGu1QHCCKkOSGk7lmXBy4JEPlHS
	Lx5iNasmZGSkxXOYXcFwM6EEKxbMu8d3Z/zv3SP/ALXxSPjy0119Y9unLlzPivghiGWplLfY7jv
	7I92ixL1TLPMeEBTD50mHlbkP6WbeQ1c=
X-Google-Smtp-Source: AGHT+IH70pTjoyraAJHi2TFHPJtOz3pkE8jHNSJbFcVKb6HyzZg4kpHwMOUUaBz8jHmx5I+H0d1MTCu/TuC6HKfEFb8=
X-Received: by 2002:a05:6820:270f:b0:60b:d692:7c53 with SMTP id
 006d021491bc7-60c4d747a4cmr9965476eaf.8.1748955886491; Tue, 03 Jun 2025
 06:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aD2U3VIhf8vDkl09@debian.local> <CAJZ5v0h-nrVamqiAJ957aYjHqaeAZUUW7BRi0WxPgCFc40M5cQ@mail.gmail.com>
 <7f0e2865-d35e-4a13-8617-8679afb4b23f@kernel.org> <CAJZ5v0gL3rW8dOxXdPWYjZuq5kAaD8qTa4vZ5++k9+0WniNAdQ@mail.gmail.com>
 <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
 <aD7L0RD4HT-mEtBc@debian.local> <CAJZ5v0h65Gt1Fw35vp2k8kKu62+goCD8WF8u-tvhfWW6a7xHxQ@mail.gmail.com>
 <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
 <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
 <CAJZ5v0hpJSVdiCN29=kbV8KfgU1y1d3hFfshtBoMpVFXf+LvBQ@mail.gmail.com>
 <aD7nOMP3xA9BR781@debian.local> <CAJZ5v0gAcohRWuSZbFWvyfAU9Vjc7nRyj+AFRYQ7hcGEXdPxyQ@mail.gmail.com>
 <CAP-bSRbVjcXBvxDT6ZQuoRB+JF6A4LhdMVnNqnaQC0bg-xg2BQ@mail.gmail.com>
In-Reply-To: <CAP-bSRbVjcXBvxDT6ZQuoRB+JF6A4LhdMVnNqnaQC0bg-xg2BQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Jun 2025 15:04:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gTRtPzrROdkxRjTeXv4BsRyUkyGpCWmh-gHNx3X2L9RA@mail.gmail.com>
X-Gm-Features: AX0GCFtu4dUDCitADOsGBJLQC6GA0pUrhBB1aNLhVDidgU_jWioLD5HwF13ubQo
Message-ID: <CAJZ5v0gTRtPzrROdkxRjTeXv4BsRyUkyGpCWmh-gHNx3X2L9RA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending children
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mario Limonciello <superm1@kernel.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Saravana Kannan <saravanak@google.com>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="00000000000057bb180636aa868e"

--00000000000057bb180636aa868e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 2:27=E2=80=AFPM Chris Bainbridge
<chris.bainbridge@gmail.com> wrote:
>
> On Tue, 3 Jun 2025 at 13:24, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > This patch does fix the list corruption, but the "Unbalanced
> > > pm_runtime_enable" still occurs:
> >
> > Have you applied it together with the previous patch?
>
> Yes

So it looks like some devices have power.is_suspended set from the
previous cycle which causes device_resume() to attempt to resume them
even though they have not been suspended in the current cycle yet.

Please try the attached patch in addition to the previous 2 patches.

Thanks!

--00000000000057bb180636aa868e
Content-Type: text/x-patch; charset="US-ASCII"; name="pm-sleep-is_suspended-cleanup.patch"
Content-Disposition: attachment; 
	filename="pm-sleep-is_suspended-cleanup.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mbgj46x00>
X-Attachment-Id: f_mbgj46x00

LS0tCiBkcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIHwgICAgMyArKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCi0tLSBhL2RyaXZlcnMvYmFzZS9wb3dl
ci9tYWluLmMKKysrIGIvZHJpdmVycy9iYXNlL3Bvd2VyL21haW4uYwpAQCAtOTkyLDYgKzk5Miw4
IEBACiAJaWYgKCFkZXYtPnBvd2VyLmlzX3N1c3BlbmRlZCkKIAkJZ290byBDb21wbGV0ZTsKIAor
CWRldi0+cG93ZXIuaXNfc3VzcGVuZGVkID0gZmFsc2U7CisKIAlpZiAoZGV2LT5wb3dlci5kaXJl
Y3RfY29tcGxldGUpIHsKIAkJLyoKIAkJICogQWxsb3cgbmV3IGNoaWxkcmVuIHRvIGJlIGFkZGVk
IHVuZGVyIHRoZSBkZXZpY2UgYWZ0ZXIgdGhpcwpAQCAtMTA1NCw3ICsxMDU2LDYgQEAKIAogIEVu
ZDoKIAllcnJvciA9IGRwbV9ydW5fY2FsbGJhY2soY2FsbGJhY2ssIGRldiwgc3RhdGUsIGluZm8p
OwotCWRldi0+cG93ZXIuaXNfc3VzcGVuZGVkID0gZmFsc2U7CiAKIAlkZXZpY2VfdW5sb2NrKGRl
dik7CiAJZHBtX3dhdGNoZG9nX2NsZWFyKCZ3ZCk7Cg==
--00000000000057bb180636aa868e--

