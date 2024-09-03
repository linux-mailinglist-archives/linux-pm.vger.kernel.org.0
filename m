Return-Path: <linux-pm+bounces-13430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D5796A003
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 16:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CBA1F266F3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E27813E41A;
	Tue,  3 Sep 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9T3iIxv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4638F13DB92;
	Tue,  3 Sep 2024 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372629; cv=none; b=YvPmKcAtadhymH93WTAebl6eLr5N0xXLYgQOkdSFIPI1NTWlUJKKIPzN3Y4sKpxRCwWecRd+iJf+bk6ujbZ0SVM3aYkyO8V23qrE5WxCpw6Ri5XjDIdRV9rJbnx8+Qj4+2irOdL2kwww8J7+N3YQNAqartNNDLf8C0xmjzxghnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372629; c=relaxed/simple;
	bh=RWW0YMDKvzh75ZWqq5GEi6cn8xPLNIShRiEe89fToRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDq8MZ+xkbznDj67zT+qvI3be/p8AhNkHakeDQFhy6f6NXSUzsI4Uharc3DuUrwuLIF+aaE2DXV50AfxFxvJNw7YA5Fe06qP4bGkqgs9UBnQRRcxIT0fPsdgie3X8SZtN4HMdh/KEC54n1IYs79gFtT9+KXeUddGwYbX8aDMjm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9T3iIxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8616C4CECC;
	Tue,  3 Sep 2024 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725372628;
	bh=RWW0YMDKvzh75ZWqq5GEi6cn8xPLNIShRiEe89fToRk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p9T3iIxvzpqGJFyDLBQFUAgCE1uWJRAQPt7NCAgL9bN6oD2vu2G+jgFAitpffV+eD
	 GcmPhOZVspqfeoJI7rtDGMVZs/EbohbwGXAyaa7UCJAii1lWfTOwb0Hf3LLKn6LbvU
	 ulCF2w3JY26aVmym1mBCbu/TuKSPYkhBqkZ7VhJNtl11OydZmu81Rf3OQ+MQOYDCKh
	 FPAOyje10paNt18ZJdfZ14qCBqWshyueLmRhcHUbQD52HSvzaESYy2hBYzgkPenIpf
	 dGc7B7hJHgtI46/oHUj0eSvC12iiTD4NqVUczMI9mL9HwPZeqn1TrJsmcy6uZuUFW+
	 M5XOlgONhn0lw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-277ccb777baso1264598fac.2;
        Tue, 03 Sep 2024 07:10:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWeDcYVKsFwDvkQuMayzXMmYb0QLdnPcd2JzynpkNAZfZGDQGw5bKRfuNVLPWoNin4dao3WdFm0YgSmRU=@vger.kernel.org, AJvYcCVH0NPIEfWzKeS8uvn0SnOuM5AQ4owFrsSjkbRb956FgDDeyusQ6V1tqODp3mCe5r0H6cAOuNeOclQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMZY/a+X0YJRTxQNugq84QWhHivdORGgbSfYrbUfdzeb3OjHg
	4JGv887aPi35xoai00G43bL6BDjYPJTp6l3/NhJ+5ZEqDRL+ENarJKhxevPKI/QNBw5+f+HT/s0
	ZkNkeS2nY9pnQBe7Gb0grrzHyqyw=
X-Google-Smtp-Source: AGHT+IEKnInHbh9MLHEnTt2+WEiYwLOirSgfsGIMEIxu/8PIdC4VupcI2jvIt+WKZBS+UPnsdnLXaCt0QyL6YCeJoSE=
X-Received: by 2002:a05:6871:889:b0:270:449:291e with SMTP id
 586e51a60fabf-2781a945890mr2446784fac.36.1725372628147; Tue, 03 Sep 2024
 07:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902054959.28073-1-00107082@163.com> <CAJZ5v0gZ9oAByawssaARFN1_crTuMZ-CnU5Fy9D1sWv+Moo-sg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gZ9oAByawssaARFN1_crTuMZ-CnU5Fy9D1sWv+Moo-sg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Sep 2024 16:10:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0itLuorOY-4PyDL5eFkWTf2s9JX++oBkzqi1cYcaHYdmA@mail.gmail.com>
Message-ID: <CAJZ5v0itLuorOY-4PyDL5eFkWTf2s9JX++oBkzqi1cYcaHYdmA@mail.gmail.com>
Subject: Re: [PATCH] PM: add: move warn message out of mutex lock.
To: David Wang <00107082@163.com>
Cc: len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 3:01=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Mon, Sep 2, 2024 at 7:50=E2=80=AFAM David Wang <00107082@163.com> wrot=
e:
> >
> > dpm_list_mtx does not protect any data used by
> > dev_warn for checking parent's power, move
> > dev_warn out of mutex lock block make the
> > lock more efficient, especially when the warn
> > is triggered.
>
> It does protect the power.is_prepared flag of the parent.

In fact, the update of it in device_resume() is racy with respect to
the check in device_pm_add(), but the purpose of it is mostly to allow
the device driver's resume callback to add children without triggering
the warning.

