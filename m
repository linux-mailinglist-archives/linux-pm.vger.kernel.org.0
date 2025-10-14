Return-Path: <linux-pm+bounces-36041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5429BD8035
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 09:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D77B3E7C89
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 07:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5650A30E823;
	Tue, 14 Oct 2025 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bM2vIbQ/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB8D305971
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428379; cv=none; b=a+4TKMZJ3NDagb7keKddpphhKAYScyy9SpiVQVIa7YAmhW1N/N+eSvvBGjt+XhjhBbTM9l3WzjO/M1uas+Y0HnAnJXxvhhIlnPotFW85anv6egBjU2fSBfOyaSTrVx1R6ewZ16dO/AxuFvMqIf6Z2emCMbWh3xsyXmZArTTtvlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428379; c=relaxed/simple;
	bh=vwrJbLqYUIs2hdIZr04E/5ekc/E1RfYrlr8r6ix4a88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNBye+GyeHDrJtc2lYMRww8dk386tgHd2WNjXa2ZvkNq4z/SCDGseNOc0YnvFRCgsN/hxjiBfmihRxxaTsfgXtU4D742MNRPysOmTKmFYeJHS/VaK6JMZ+lNcAjOYUdBjSPHIHUN+KyM0ekcNzqVf4tDSnUwsbcJ3/7DVFaq09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bM2vIbQ/; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-36a6a39752bso47704241fa.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760428375; x=1761033175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwrJbLqYUIs2hdIZr04E/5ekc/E1RfYrlr8r6ix4a88=;
        b=bM2vIbQ/T7wKhEPoz2u2iP2U8eDm6ZzLXRuCTG5L+Nkr51c1LuJO0bnYR5o/gOJvLJ
         PqMc40rxLILHumK5eOrp7azICvxkO3KgyPSvqb9L/GkSFnRDu2veAiFq3pAIFyXBQr0b
         GioXqiHn/vNKdtDIdIOkaVQahGRHf5Kt/XRWYUqbfIG6dWC+YTVexptKCupumVkpbLzG
         sp759a+6uTPxPalIb2sEs/LhyfWSGQNUHtoe46r+K2PqXOKLTSIO/y3Ep88ZeHbGZxgu
         5yeNFepW76upTfrjLPqVsrwBditNkbF4shMRrte9f3NvRm540BAH1Yy+1iDXI+G4HR43
         SGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428375; x=1761033175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwrJbLqYUIs2hdIZr04E/5ekc/E1RfYrlr8r6ix4a88=;
        b=mZ2DtSB7yVdt5u/c/Kvza4zPgI6Z2shW7moug3K0h5z51i5vOp89TVF1m7I0OrYHjl
         U+fMUU6JMa59qxjICGgpK4v0U30EyaFrtng1r/Mliz5Zu1gWBCpwKlqh6Fm0gf5JtMuW
         osGHXj71QH8LCriu+vFRfLnAtLRdXwIJ7Ag2Ig5He8FAkM02M0HUnf6kITyIsoPftmQq
         0R9KWOcktBG2a8M6eWRgF4vamJD4LYn3KpMEXfFMd2lT4XmGZ+NK8sUYL7Uas9vGFGN7
         3v/R7eEWWwotaoI/NsVP+rGtfGBx/EJ6jlUIFe5nlTcnASiYyY8SPjHS2JU1HOIxEDzI
         V83w==
X-Forwarded-Encrypted: i=1; AJvYcCXq7G0hn9jFudEjxUasnb5RCVR1mIA8t24OHC6uABIHJ9ELLYbJPtLhJAY0b66B4nEdMCOot8q5dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiA2uPaE+1sKbxmFh5t3bwx8hkfYobk0V2moswAAx8KKxYRIyv
	Rlfr+ldWK082Q1kg9lqIfrWn69/01ZgZyhGI8ebWNrRRf1XvN/3BJ0kIkoEADmfvJaLcxd8byO+
	mIjp1FyAu5gdGmt+Weq280070ltdkQ/2VXgEGW/zIqA==
X-Gm-Gg: ASbGnctlWtqRfB3LrC6VPGNHDNaKLxPaEsOn8dHyPzVHmavHZ9N8ZBa1vQNvXKsWJIt
	zwf5z6FYROteLodva2ANxXVKBQnWwuoGsGhyewLVfEnnrLmt6UlXhYdQaHOaapiPFx9iyzvtY7V
	wfTNCCnyysVau3dzKllQ9nXMZiOTEtcCo5oHqX+4I0YITHwtsva2hwBUDrbtOec0nQozhFLL2rc
	EVp8oD8or2ue4x9dJlINVQmictJwFU3jj7WjZYow028Kyd1uWDEytZzLgI=
X-Google-Smtp-Source: AGHT+IE6gg+MLBxMH7PzBTZswQ1htTybiRf8di7CCXjc7HVRjNQ5sXwPlBAm2r4gvNL/pfqQj+6D1NfuyxLQ/PTPyB4=
X-Received: by 2002:a2e:9a12:0:b0:336:7c7c:5ba5 with SMTP id
 38308e7fff4ca-37609e10855mr73524151fa.23.1760428375403; Tue, 14 Oct 2025
 00:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919153008.324338-1-marco.crivellari@suse.com>
 <20250919153008.324338-2-marco.crivellari@suse.com> <CAJZ5v0hvTogN-egwXWRp3F1iJ0HS_eSJ4hEavjrMuKF5RVxuHQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hvTogN-egwXWRp3F1iJ0HS_eSJ4hEavjrMuKF5RVxuHQ@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 14 Oct 2025 09:52:44 +0200
X-Gm-Features: AS18NWBEnf1NwISRN12NIVApf9Z9zdxOb-FVRSihzo52lcsL7sWcjBRM1cAsi1s
Message-ID: <CAAofZF45x0y1a8bEbv9BrPgVp8EGbfPYTjvL_sv=xnf-r80u8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PM: WQ_UNBOUND added to pm_wq workqueue
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:51=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>[...]
> Applied as 6.19 material, thanks!

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

