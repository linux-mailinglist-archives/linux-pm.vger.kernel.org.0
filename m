Return-Path: <linux-pm+bounces-39270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB309CAB3D8
	for <lists+linux-pm@lfdr.de>; Sun, 07 Dec 2025 12:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F735305AE77
	for <lists+linux-pm@lfdr.de>; Sun,  7 Dec 2025 11:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C09C23C50A;
	Sun,  7 Dec 2025 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nowSBs0H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273177640E
	for <linux-pm@vger.kernel.org>; Sun,  7 Dec 2025 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765106596; cv=none; b=O5UgbBH1xt1+iZ9HJnkBm+FNGdVaeHu55K0WnyjMTspOgY6dRQH3pWqWuIs4LnBJOrn5Q6JAHHtyhc2nV1ZAUdgDoSlUK9OnC23v//JYzENNdChbAFS52fNjoyrcD/1R+obrGIDbj495UwKpcE9iMmkXPh4IA4gMcl9CR0GxJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765106596; c=relaxed/simple;
	bh=e9HBNQgjUh1rsH/YnTHVmfpzTgApm/xoqNTylAfXTcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4Nk1c8JQpGhidy8d5OEuFg1lg/1VCj/oNk90QctwGYt/2mviMNJHtwEI/X+vv+Dfjqy0NPLOE0L+j5KwbVVUITSxlT/cAk3KLYV4uI9vdGFoLSD9worQypmfzsdRCM7RN0Sfuc9qH4E1OiQ7hjKgchwhr+586Fga4uWk9+CNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nowSBs0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44AAC116B1
	for <linux-pm@vger.kernel.org>; Sun,  7 Dec 2025 11:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765106595;
	bh=e9HBNQgjUh1rsH/YnTHVmfpzTgApm/xoqNTylAfXTcg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nowSBs0HbbS4urUlI7eYDqEYmuJDXW8ZrfFhjgtwu2Xq75ZoEXRhR45fhM+VFoDXc
	 uL5cqzoV+VaeQ57grcpYNykmZbgf/SYkCYh/W59pWZecf1WkbWYlqoVe99AklzrWwj
	 sIkmKamplwlPjg/Bl32KqFP3sQEM0igjAbV/4zRqiAzeaNM3LK4U83lOvYveYucBTK
	 tPWLkvfpOQf0E/a/JIp0PCedL0D68FkTx8FiFMbBBNtMRu12q+p8AGM7qLl31QY/cd
	 7g4Cm0qsFaZfIGyWh+5vj7+8S98xN6xKbpItlu/uJD4l+p3OO2ycoKxmy2O4BH5ULn
	 iL83ZPjLfsfgA==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c704bdd57aso2093520a34.3
        for <linux-pm@vger.kernel.org>; Sun, 07 Dec 2025 03:23:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+wEq8aAasjtOh7KxyuEGYVezZS27B4dULY4XaOAyQq/mdWRpEIu+ZmF5nlFwLUvGPmLvt91gXYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTCnjd0FuiNqfWyvhMkCnbvZjW9yfzzWPD2I/0VNmS2FVJ9mYN
	gDGXm5dRhi4B2yO8vUUgu8T38f+QbnktLNcw0DQQDqoogHKZt22j/Rms8nF9RPW2/4m4lAJ0K3G
	5kH+Y/OlI8HrWbK59DXTxulhNZgKLq4w=
X-Google-Smtp-Source: AGHT+IFOqX6bOvqk1FUQ9VHLw8abr4UWv14E6gdAhuKmEwnGkoicIKL75B0LBMR8Kohk2nJgzKZB1a/DQtki1s71fcA=
X-Received: by 2002:a05:6820:1b19:b0:659:9a49:8f3f with SMTP id
 006d021491bc7-6599a999b0emr2140301eaf.80.1765106595174; Sun, 07 Dec 2025
 03:23:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
 <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
 <12794222.O9o76ZdvQC@rafael.j.wysocki> <fcecd822-a2ec-43e6-8dc4-290516e2187d@acm.org>
In-Reply-To: <fcecd822-a2ec-43e6-8dc4-290516e2187d@acm.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 7 Dec 2025 12:23:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iT_SgQPP6R8Ys37h80Db7aDu7o0UaVW1EeiN=TtV+Lbg@mail.gmail.com>
X-Gm-Features: AQt7F2oRevcA5FNEmmTCrFU3lKMiva1wqDaOG8IVl98MO5Xc4XUdEPXLwm3X7zc
Message-ID: <CAJZ5v0iT_SgQPP6R8Ys37h80Db7aDu7o0UaVW1EeiN=TtV+Lbg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: Do not flag runtime PM workqueue as freezable
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	YangYang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 8:11=E2=80=AFPM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> On 12/5/25 5:24 AM, Rafael J. Wysocki wrote:
> > For example, it has been reported that blk_queue_enter() may deadlock
> > during a system suspend transition because of the pm_request_resume()
> > usage in it [1].
>
> System resume is also affected. If pm_request_resume() is called before
> the device it applies to is resumed by the system resume code then the
> pm_request_resume() call also hangs.

Rather, the work item queued by it will not make progress.

OK, I'll add this information to the patch changelog while applying it.

> Otherwise this patch looks good to me.

Thank you!

