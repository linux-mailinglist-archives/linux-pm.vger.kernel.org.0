Return-Path: <linux-pm+bounces-30059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D02AF7974
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B67A164FF3
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED17C2EE29D;
	Thu,  3 Jul 2025 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOBudWEd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E332E7F1A;
	Thu,  3 Jul 2025 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554758; cv=none; b=WqAu1VZC4y20JBE83S29zx/KjNZyrsf1lFhrr4KJ926x7QPCZivhgeVif/FZ6KtopUbyNMD6ReWSAG5WJsiDH/X5jQLJ5RDpJJfEM5thPX/ZfxRl01YcoCN5WZlKudhNXpGKaW3n8nn+cK79NkybmYjmF/USf22xVYmmV3JoH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554758; c=relaxed/simple;
	bh=ff9oYNuQUjEFu3J8AsdAlUyzg1ssWZNtQ/uwSo+turY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGOhq7OYLSHMn46hAPKa59DlhkwubZQuBIPtOKq8l+rQZJbGuYCLdIJmgawpQ7VgOv+5rojgJi/dIeZXfdFG1a3b2+sHYxGCHjWN7BT6sDlF0FMcdQEIzccAunIrwDsscIHPKvNM1nwgqCWrAFdclSDdcB79vrF4gNPRyKDF0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOBudWEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891D3C4CEE3;
	Thu,  3 Jul 2025 14:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751554757;
	bh=ff9oYNuQUjEFu3J8AsdAlUyzg1ssWZNtQ/uwSo+turY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AOBudWEdghvvFNqAgPtFc9aWgb2/Vj/cDemwuvmMarZm1zVc2M+Elt27stm5k9jW2
	 KXuAhX5gayBRRg+LPnyOuckH/8Fqgnb4cKUpwvF0pkK5lZjvnfBc2tQxs56vK78zTQ
	 LCHiYZFsEYD3R7KPyK5//ypLjsL2ShtF6JratXPoZ0Ry/Ri923TOvs7X/uHTQYiUnz
	 C6JI51vTeN2vKXBHugpKgXdmMsZuopI+UDd/wtsjZe7v5go7W5ODw5oUiZzbryTsUX
	 XWl/7IdHU6sIIg7sL94C3smdIQo6aOheAbQ4PpA8yR13PRyjLMWU//BGyH7DdBfj35
	 3pvuZHYhBvB4A==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40ba2ad38ddso31733b6e.0;
        Thu, 03 Jul 2025 07:59:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9/7U4wVSUTRMczGC8XyTfgC+YD6P0avcHNei1FFLvgO2Mx0kNFFa3ZRe1rLjLKToC9AaOChyJqXo=@vger.kernel.org, AJvYcCW6R70nD5J/TM8GU2QMtAoGKY3QCE058SLjLmcblgnGVO7qZ3LT6dwWhKFb1yl7CE81jyWTQgdvzc8AGsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymTarp6E1KvA7v9W4eM3RiIP0dA/ySQXyW7QnvdmU9r2uzGkzm
	eLZLTOMBvRgbsbz8OyGN5EtuRZBwfEEIoLRvOGSYoCyAiAFAJ0QnZYSlsUKKlxc1w6uMPMakuwc
	TD0pQuNtqLTfFV/1D4wkkvq2+yZeggGg=
X-Google-Smtp-Source: AGHT+IGUNnWc6ttFUV9nW/7DEV1wUgCWbL6Ei/UD+4lf3y4vuTNqy/P7bfhxYpg/UYeBmDCDsSuXEzZstvwl1oECUQA=
X-Received: by 2002:a05:6808:1b90:b0:3f8:3489:d93d with SMTP id
 5614622812f47-40b88816cbemr5270609b6e.25.1751554756905; Thu, 03 Jul 2025
 07:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
 <20250623133402.3120230-4-zhenglifeng1@huawei.com> <CAJZ5v0jvdttYihgNcTF=VVnd2K5QsC+W9XJJanqy4F_PXw+u2g@mail.gmail.com>
In-Reply-To: <CAJZ5v0jvdttYihgNcTF=VVnd2K5QsC+W9XJJanqy4F_PXw+u2g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 16:59:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jKY2og0bSwq97fwu7W690E-GeYxGkeju3kq4DVgOFCaw@mail.gmail.com>
X-Gm-Features: Ac12FXxgW8YzL8MpjxfmQmYqohwRl87wSd5TsFBz8agO_QGk5OPbcTw6P0Vv3dY
Message-ID: <CAJZ5v0jKY2og0bSwq97fwu7W690E-GeYxGkeju3kq4DVgOFCaw@mail.gmail.com>
Subject: Re: [PATCH 3/7] cpufreq: Contain scaling_cur_freq.attr in cpufreq_attrs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, viresh.kumar@linaro.org, 
	ionela.voinescu@arm.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 5:30=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Jun 23, 2025 at 3:34=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei=
.com> wrote:
> >
> > After commit c034b02e213d ("cpufreq: expose scaling_cur_freq sysfs file=
 for
> > set_policy() drivers"), the file scaling_cur_freq is exposed to all
> > drivers. No need to create this file separately. It's better to be
> > contained in cpufreq_attrs.
>
> Fair enough.

And so applied as 6.17 material along with the [4/7].

The other patches in the series need more work IMV.

Thanks!

