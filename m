Return-Path: <linux-pm+bounces-16298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C939AC805
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 12:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026501F24887
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 10:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A62156F5F;
	Wed, 23 Oct 2024 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sM8ux3cT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2423143C7E
	for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679475; cv=none; b=dfIgLw7V1S5UNsuZh+1L6IMp3WQHrJjr3XBPMCAXyGtEaB3kOI5LvqojpnIMfDTun/VoBkBdb1UI3Isg3It+1oIRqqtgSP89uriNE9kIIFltHQTx+sdsbCmgFKRkVxdE4JOgOpKB2DEeZ4WjgkCzRPAU25F6uebwaDlTi9K2RPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679475; c=relaxed/simple;
	bh=pJtEb689hOMrY/QKMxNz+64AETjs4WYE6V1GEIuLRLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekTxnmT+lEGV673kBsi+oUqOyKZYU0S77IhHWkP+Gb7l1tFzQL38fhFTGJm4yssyO4bjnCf/gLpScN2O0ObaRCI4AP3WfGZa4G6M5t7ui+IwiSV4BF3MtYxHPVFlDcX3aYNqqOnHMCRwAeO9bHOw4agwClyM2H5VF7gfIvM6eLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sM8ux3cT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A338C4CEC6
	for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 10:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729679475;
	bh=pJtEb689hOMrY/QKMxNz+64AETjs4WYE6V1GEIuLRLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sM8ux3cTtOkTNCqZWHMyP+8AQWE1qSRqYtseBQg6IcrijxYHScrJs17ocQ3ZIl/GN
	 cioj88uz8JhgH8yzGP2wEk7oNjwSVWUDIVdWJIvHngCDG4WnJBptn7k/BwFdpPcuB4
	 ZBtJ7hEMQrCA2qk4o8gD2l+DHcA1lYCjnE44eTbhvhNPYIgBi5QOLBYzddg0fWcKYA
	 apA3+yxH4oRKpyJf7uJzVwVGaWc3cBYITiqkGIoMVEvkfj7CvTCsG9eOXaSMslFLl9
	 LUc4Z55k2yojsul0HzhYkNWQRs9Q3Zqis5PiAzLdFJgaXniA7Y5DgrSl24aj9GPZrE
	 g2rV9U2RwaOOA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ebc1af8e91so1538494eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 03:31:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrhve9DvHjvH+H7oS/hrtr/2KGsPKIpFl5mTk6EfXtnGhgPdlzSHqokWY94RERBGH4L1lobmok1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkzC4BYShKa77aHWfcQNdEQbw4oL7Yh++NUnK3ZBxC4auWE3zl
	5Fee1/HD/i9LLtbcY23WBnKgQ9IchRCFbU2ArPwxvd5B/KIaINOQPttBcI/STBZK6V40Ot0DaZj
	Om2578VfiIC+Sv6iD7iBGJSsLEG4=
X-Google-Smtp-Source: AGHT+IH/0YV6yHJzaVDzz3AyxOEkpgK8AyJqyVhueQEJygjjI/3en9UqqyP8aMqL//h6FKJPFXJm32OL98UIScx0BE4=
X-Received: by 2002:a05:6870:46ab:b0:261:1f7d:cf70 with SMTP id
 586e51a60fabf-28ccb605da4mr2083370fac.36.1729679474819; Wed, 23 Oct 2024
 03:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022155147.463475-1-daniel.lezcano@linaro.org> <854974d9-fc56-4a40-977c-9ce90b783338@linaro.org>
In-Reply-To: <854974d9-fc56-4a40-977c-9ce90b783338@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Oct 2024 12:31:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4K5BFUWcZFfyR=AFwdAGfuEEKu-EK_vRH4NTSPP=iUg@mail.gmail.com>
Message-ID: <CAJZ5v0i4K5BFUWcZFfyR=AFwdAGfuEEKu-EK_vRH4NTSPP=iUg@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Add thermal user thresholds support
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, quic_manafm@quicinc.com, 
	lukasz.luba@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 5:54=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Please note, I did not fixed the locking issue assuming it will be fixed
> when the series is applied as stated in v5.

Yes.

Applied now.  Note that I have skipped patch [1/5] because it has been
applied already before.

It is on my bleeding-edge branch ATM since the commit IDs may still change.

> As soon as the series is merged, I will send a couple of changes, one to
> fix the memory leak and the other one to fix the warning reported by sysz=
bot

It should get to linux-next and thermal in a couple of days.

Thanks!

