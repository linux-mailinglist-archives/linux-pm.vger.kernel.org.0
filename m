Return-Path: <linux-pm+bounces-38969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C119C9794E
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 14:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFB424E1739
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571B3313E0C;
	Mon,  1 Dec 2025 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N84a5KJd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3093E313551
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595496; cv=none; b=bXthCIyl2sMFVFMwJB1+IVC7t4EmDwv9fEgzuS6My1rC63UV7nS9+5x4xeh7bAo7nppkUpI9cblfd0UQi/Y0/5qePD+2KFtFSoeSlYMu/WosgWQPldYBjBoRjuiawXyG95ERO23WSNB24C3ub/rpwno3P7IMlkMkbTrAxrAwmj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595496; c=relaxed/simple;
	bh=5GtfvEamOb36UlZ9M8pmWqfLVmFtCOex/TlM7yTBMzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgOuUGfW9uDFGV7Em/2vktLvSLxejALTovIM4NMgdj6IdM4TjC31H9ZmUWSSR2p0/Dl+6MPqiu2fCLu/cHzaM15ZfaxJD0VXSK4u0PBW1IL7pTZYxNemVGmFIPemDKM4V8dAk3xN2AFKLrSkNohMyEC6uVO011Vtbqo9WapAG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N84a5KJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15B1C19423
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764595495;
	bh=5GtfvEamOb36UlZ9M8pmWqfLVmFtCOex/TlM7yTBMzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N84a5KJduWuFDMNezYrvOMS4ZjLNS3+joJutvi5CEUCaeF595XZedc4qjpDerHTRI
	 o9lmcDDW4eytGz/UEttw96aZGkg3EI1TQfqrYh5gIVkHDdPG//pWg4l9EE+xDcBPPG
	 qDio/qwe2aAu4AM7gueQ/NBEQouOmK9pdCFV+8gGM6x9XrZBoxfHeO883AN6XCcMrI
	 F+Eh2vuy5MasjMCoDlC9IvPqQcjcaKQOLWVo+DgoyBFBftHq7BnJTEhOSxEfULqUCS
	 PWbKzlE9M/Qmqe98casx0byq+IfTTj3ay2dIbYwnsiEhq0wAgd3Q+7JcXJMUuHs8qn
	 1rQY/Opmme1tw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37a5bc6b491so35497261fa.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 05:24:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQeIEGR229a+X1yX4fzztWmtNEBWdKC2EBnwe7xy5/tZUPf/Kv0DURf2doM9i3xwXRYf50Yai3DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhRF/qgreSPm5mWe/KlQpetN1845I+hbqyvYM56wva751pRPch
	MXcWq5CIGJbgZHqd6O3//kKjs8xlEzGBp/7vnkbijoi4xWzK3yTu8Rgog1OcwZk07Axio/X0yzp
	wQGtR6zxOHy7QXxtopS7T3SfoSUUhxJe7BHMe1EoqTA==
X-Google-Smtp-Source: AGHT+IHb3sWkAFRrThmJQLnYkJ9rjKoSCxK4x60iolT/AUZB1FC2DOyecU1Hz0Cho006PhNB4p39YUe3XQpDJc9zWRc=
X-Received: by 2002:a2e:a26e:0:b0:368:c52f:fb64 with SMTP id
 38308e7fff4ca-37cd9251409mr66505071fa.34.1764595494518; Mon, 01 Dec 2025
 05:24:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130-next-15nov_expose_sysfs-v20-0-18c80f8248dd@oss.qualcomm.com>
 <20251130-next-15nov_expose_sysfs-v20-1-18c80f8248dd@oss.qualcomm.com>
In-Reply-To: <20251130-next-15nov_expose_sysfs-v20-1-18c80f8248dd@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 1 Dec 2025 14:24:41 +0100
X-Gmail-Original-Message-ID: <CAMRc=Med5nupGE_q1m8cuy7OWpLnPi_BF_mq=ztaD11fxk5D9A@mail.gmail.com>
X-Gm-Features: AWmQ_bl0joR1HCe9g6Wj_VZjQY3fs93FJ83IJKLh9Xuuy6r60veByoARM8WBskw
Message-ID: <CAMRc=Med5nupGE_q1m8cuy7OWpLnPi_BF_mq=ztaD11fxk5D9A@mail.gmail.com>
Subject: Re: [PATCH v20 1/2] Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartosz Golaszewski <bgolasze@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 7:21=E2=80=AFPM Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
> Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes, a
> read-only sysfs attribute exposing the list of supported reboot-mode
> arguments. This file is created by reboot-mode framework and provides a
> user-readable interface to query available reboot-mode arguments.
>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

Ah, nevermind my comment under the other patch about documenting it.

Reviewed-by: Bartosz Golaszewski <brgl@kernel.org>

