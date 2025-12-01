Return-Path: <linux-pm+bounces-38997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD5AC989F4
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 18:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC13B3A5678
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F443385B2;
	Mon,  1 Dec 2025 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEOG26r8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A3A3385A3
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611608; cv=none; b=D1pl2oVXXLEnesYXv9VE/iVlqiNV5bmapVPmqm2VVf/YU+NEVbOJjIw0rQbY2fucrg92lutpsx9kYk7dGzppP+4vqhmUwVtvSsnZ4smYmqLY4KYdEb/NdGCoo62kbugbhi8ScjHcl1zbnZPWxvRaoYdrCjQ/eFwCZmExcYKutc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611608; c=relaxed/simple;
	bh=wOcUSoHw4L8yWr2TYz61CvWjoUMQxzmV5HexGHkE1/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJw2pvzkEyUFx28/92FzoLvaHqW01kviCQtqEowj8QgVl1zqROM7KGyvKxwvf0itu9c7VeFcuYv33gKrXfS+ijy8U26rIQi1KcffQam0jBc6QGSk0NEXy+j7y1FGwe4rGLVPdY6g8GbUY8CXqMhl7Vvr+MEB1WHqDE+dwwnI64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEOG26r8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6B7C19421
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 17:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764611607;
	bh=wOcUSoHw4L8yWr2TYz61CvWjoUMQxzmV5HexGHkE1/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LEOG26r8+Ev4KCNxLNymIar0rt4RYZsf9aHnUBOh84fAZru+OKPJmIvYq2s7sLsrv
	 OLLEdcMeocBEK0JJ4CPqHcb4/7+kJOPzfS3OCGBOqOM4oAlHsouv6t7cqnwwHuApUY
	 yONr+tzbXFY+RmNpZQC1Ym81z2UDoVNfRqKWDIBBK7AwQa7KLHOVH/fXL3d3f/lRZs
	 sGH7lYfisxctnChQKILSS/3Jq9Lg/CJEvQpZSNUvg/vFWrwWQM7a3GoJ48vaReYfsP
	 dLEnv3DxHjsAY2TTdz+L8BNENgMK9XKT3in+TNYSAGmIwYdERBSFJFjtk3o7+3IFcf
	 VYvyQcRE9x8qA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-596a055b1b8so5059984e87.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 09:53:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUH5p+Vgra+LWqvn0r55Atm07RNtT++9UHrXYX8ZKnwknV8TBi5LVs5xqbodvnDMI1xGlJVqaxOOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtiaCdgjK4k5oT1HvyY86GoK+tMgimqXCchj+DMub5OLsThfNb
	ZUyB9Z68Q8tNAV3bTNRrK2Azjk97g90GRrcMGqV6Vcp206MbBCk7t8DS/grNEuAaf/f8FYSRxIk
	G/WaFwIcJ9lPRf6JhBAtbReUdOL6rzx301r8vyGyqzw==
X-Google-Smtp-Source: AGHT+IEsW4EO0KohCB67WRAVME17tU1t2/mw3bZxnnekDPsTNjDwb71ZLUXKANnkV+uYyxN1Aqe4aqeXWFAo+YPM4KQ=
X-Received: by 2002:a05:6512:104e:b0:595:9152:b93b with SMTP id
 2adb3069b0e04-596a3e63731mr12810420e87.0.1764611606183; Mon, 01 Dec 2025
 09:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130-next-15nov_expose_sysfs-v20-0-18c80f8248dd@oss.qualcomm.com>
 <20251130-next-15nov_expose_sysfs-v20-2-18c80f8248dd@oss.qualcomm.com>
 <CAMRc=MeUoFhmxcxsvboKx1E3KCsqkd081d8e9PypuYCCiL1XFw@mail.gmail.com> <4f8f9217-f6d1-1321-c2be-5ee1dd807eca@oss.qualcomm.com>
In-Reply-To: <4f8f9217-f6d1-1321-c2be-5ee1dd807eca@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 1 Dec 2025 18:53:14 +0100
X-Gmail-Original-Message-ID: <CAMRc=MegAtTRvrxXRc1uQLn2F2-DMip-aFwz-q1JbOkny_8dWg@mail.gmail.com>
X-Gm-Features: AWmQ_bmBI4MDfuoty_jfxTgdkVGtoLxRv-hhIkt-aXHMqaSSJQpIt4QFgkazSKg
Message-ID: <CAMRc=MegAtTRvrxXRc1uQLn2F2-DMip-aFwz-q1JbOkny_8dWg@mail.gmail.com>
Subject: Re: [PATCH v20 2/2] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartosz Golaszewski <bgolasze@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 6:43=E2=80=AFPM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> >> @@ -132,9 +186,13 @@ int reboot_mode_unregister(struct reboot_mode_dri=
ver *reboot)
> >>         struct mode_info *info;
> >>
> >>         unregister_reboot_notifier(&reboot->reboot_notifier);
> >> +       if (device_is_registered(&reboot->reboot_mode_device))
> >> +               device_unregister(&reboot->reboot_mode_device);
> >
> > If you bail out of reboot_mode_register_device(), you don't need the
> > above check anymore because the device could
>
> We wanted to continue on failure, as per reviews.
>

You're probably referring to this bit:

--
On that note, I would argue that aborting the registration of
reboot-modes, just because we failed to create the convenient "debug"
interface, doesn't make sense. I think it would be better to just
continue even when create_reboot_mode_device() returns an error.
--

Anything in sysfs is not "debug". It if is, then it should go into
debugfs instead.

Trying to register a sysfs object with the same name will result in a
WARN() splat from sysfs core. I'd say we should definitely return an
error if sysfs registration fails and just make sure it can't by
assigning a unique name.

Bartosz

