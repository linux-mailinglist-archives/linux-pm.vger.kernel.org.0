Return-Path: <linux-pm+bounces-9761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7438D912694
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 15:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A56D28397C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 13:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9DE155732;
	Fri, 21 Jun 2024 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APKep3kw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529B71552F8;
	Fri, 21 Jun 2024 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976183; cv=none; b=o2xj6sDWCwQmhu+Ip99YHpY0SO25z5IeywMtIKsfNFWFcJXuA8vD8wRjYUj087n8eS4FRQg0DBpAjunxjtD8/4W3eDjH/F2TeQO/a824cseV+Q2zY4Y3PHqTJq0XU7GkwXhfBa0LMjQGTDE/CuKCPr1xLnKhmAMF/9ikZP2LHeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976183; c=relaxed/simple;
	bh=g7bboVn+4mTG5/bDrV3XJeW4xRp+qP/A3ABHSqiPqrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8frD1nVQscIWLYOgBKenl3n7LKEb90R1NJezH5hkaLh9n2NHLpnbhMAJgpO0rsH+uWky0i4wtPnvyTMeIUmJJ00sMeHgErPxzVDztvkHzWGOrDjvM6PEnxEnKzFkXd72/LF7bsQKLpJf/ZFpdL7P3fZLr+L2MQ9e0QHFTyRXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APKep3kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FC3C4AF09;
	Fri, 21 Jun 2024 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718976182;
	bh=g7bboVn+4mTG5/bDrV3XJeW4xRp+qP/A3ABHSqiPqrY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=APKep3kwN6yS0EYi/iE8yMO19bWPAD2IN9BFbfSx6Ym10XI9egF6BsrCmqWkDxJY1
	 BxRL5Ag+0cDfh/1B6LemhjFc17jaRkG52s00v3Mh4sl3GjgFQ//jaEM5eAXQnZg7Q5
	 6svs4Xk9RLm27B+9god3oaQgBvd/63xgDeCR5idL4pFuB6MKivpYXKHVxwxwGztshF
	 Sw8Ccv5xfhvulT5yrqUhS1FYMUhcjGptza2NX05RQjndKmkUthJx4ZBQvn7dQH1bRz
	 /pFZLaajHGdU1PHCe2m0m6YRQ76chdrzOU0aX5RE6rI1knFbL0gLtx8AfxnGH2Kuam
	 fCMs5kW1HXLSw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25cce249004so175959fac.1;
        Fri, 21 Jun 2024 06:23:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUu52XGdT5OTUnyaSRH9sxnejGErIk/U363qD0/mP1VuaDkPKMcgoUeQ07z6vjonoDIcF5huOh0wgUon8dcWc4iMeK2hwabQ3lyJEOQ/Rz90DrD4aLJZKdA4/tVh2PGMOPMsX2EQzM=
X-Gm-Message-State: AOJu0YydmJjphM4J8QKJaJlacLQRm3QtNJbH29HL/oZyaUtVrpr9y4W1
	MMSxRTNF9FTVTzEFB9eL5mNenfpC6bOW7F3Eg3dAv0ortUaRYRzwPL+lnM+LCFHvXS/sFyUt0vy
	rW2wUlWcHotv9+xqYWvA+7xpWcuY=
X-Google-Smtp-Source: AGHT+IFrTYpiWnKhAHbBnJrK1aevO7iJ8DrQXC/QIR0Q0bTXlTh1H4Uu6ydmKpHymCsxPTNI0aUiPbcQ0gAlF9F2oeI=
X-Received: by 2002:a05:6870:d154:b0:254:ecbd:1815 with SMTP id
 586e51a60fabf-25c94e406ecmr8726222fac.5.1718976182229; Fri, 21 Jun 2024
 06:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619172109.497639-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240619172109.497639-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Jun 2024 15:22:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jN0RXsMSLDr2O-xNGVz2xxAk1u=ZvBA_qM13hWq-5Jxg@mail.gmail.com>
Message-ID: <CAJZ5v0jN0RXsMSLDr2O-xNGVz2xxAk1u=ZvBA_qM13hWq-5Jxg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Processor thermal interrupts for Lunar Lake
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 7:21=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Enable MSI interrupts for Lunar Lake. Also enable Workload hint and power
> floor support.
>
> Srinivas Pandruvada (3):
>   thermal: intel: int340x: Remove unnecessary calls to free irq
>   thermal: intel: int340x: Support MSI interrupt for Lunar Lake
>   thermal: intel: int340x: Enable WLT and power floor support for Lunar
>     Lake
>
>  .../processor_thermal_device.h                |   1 +
>  .../processor_thermal_device_pci.c            | 116 ++++++++++++++----
>  2 files changed, 91 insertions(+), 26 deletions(-)
>
> --

All applied as 6.11 material, thanks!

