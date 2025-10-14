Return-Path: <linux-pm+bounces-36042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8061DBD8050
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 09:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A66218A6062
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF8E30E85D;
	Tue, 14 Oct 2025 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Isd29rg8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1630F53A
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428492; cv=none; b=NlVvBS9PjFGr6xQgbEuqhcgm5m1+HtDclWqRBL2B/MKM/ZXxCRdjKgjr2ZgbXfmr3NH7FmbaRsMrgrb2aiJuEMpwLE8ShwqvuKxeuBcX2h6enUMK3958nPlUWPUGjSiplzhTpkOjDHYs4IsROKBIdM4sm1F0lfzfbD7JvYhfC68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428492; c=relaxed/simple;
	bh=IPU5z0Jlg1yO/rxNLxtj9z4MrewbKL/7K6aEPJLzYTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz7ayNpighTvb2b5E5XvKuO8CAVnk6B9erL7FPMVpfmuftTEZYncQiCqowGK4bK+f/qr9elHBy8HNXHPSSMC4tMSS4sVAKtmIPyPSIO2NsXp30s8OT0R8vV0dxiwvpC7Igqdyvnjgv2kTGTTeO/PLq/rPGlIXxJwpwV/XKtPdBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Isd29rg8; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b60971c17acso4022328a12.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 00:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760428490; x=1761033290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksS8LYkJl9QHQKVTv7IPKK1Z2Yj/b9KllkjM/XlVz50=;
        b=Isd29rg8TF50sXI2d1MSHVL0JSOynekWdCVGxF63mL1iu1EDdlH69fqTWeU41EstMC
         3tPrdCVcQdCpbR8hEdO2oqJwDzAShJg/mm84FjDKb5qS15uj1kY3eqYxaMfE1B5HyDfD
         3FiOYwTTTPtC6UNz8ZDj+ubxGRD7UC9W5H3Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428490; x=1761033290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksS8LYkJl9QHQKVTv7IPKK1Z2Yj/b9KllkjM/XlVz50=;
        b=EkI3BZLu259d3GsXfPVuak9nDyEQqUhoMUMZpO7Xl4777AOndIAZyG4zEOUB/4jkkB
         YtQCwZWOUpdefZgaPGuqEpodKaIKigG5XIeVJF5JC+Zb42B1rFOnodTWsmWPA7RYVT+4
         yyE7g0+iK/nGC/YB6Mzlaf6+GTdiDWO5b8u1dIPbz78v9dO43K0LhGq86YZm6Aecmy6d
         vDKi19Y+KGpoTPit/WVKYTx5UjZusuSQJ3oP5Wi7dP3N17UmI9EJpbZQQMBWg1zuDvbL
         RUB9lPFJ+825d29P6XzdhAimyG6fBAEsG+XqrwdcTUniB4LCugh9aAOCcWwyokQ6CT0T
         547w==
X-Forwarded-Encrypted: i=1; AJvYcCX/5ptPUhpBfQJGbkYkd6VTRkav4AMRRicoZJOh4dAbKmwBNS3zvP+PRRDPAjW84iaAPjdNAw3nFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsr/k57a5L5byqFjn0ezUuU4ILq58ACB+IupcTszjeVpdzXhtg
	qeWbS6t3lN+Rje+FTKd1igueTn1TQ/u4QTBYE7dVt5RRnd1PbzBGeQ/ksFiOhXy/hw==
X-Gm-Gg: ASbGncs2khxtfcrybxd7bRZgdmAiBD4mDfAc1pPVFaCGnVVFB/7Ru2XbtbK7GX7nbsC
	+ThAPh1bNgc6inD35+iwMh4QtgB6vdGvJL2u7/yBa7P2w8/DQ5M5X9u+wGoGwOAZ4ZA+lSZ7Q1u
	wMfNHyVoWrfjU9bjqOHj8zGQyuA+9VML2TNGP5qipTCu5GdTEJs4PV3Pdd+lLmWGwJTYaPMNTv9
	UOjRO2iutztoAISUzRzJFxC1VaswKiNbgJDC0toWuSzBV4aUR5TRuYdXqwc/ZniHOq9MY2U2xGD
	wIOriAR/3Fb+Pr4uBmARWwBnodDn8C/i+8YZhPpHcsxebvFk2SaF2HwoxEsNJ4fUdDH9dstWsLH
	XQWZrg9cjM5aZK4rt3vKWvd3EF16GgKbUdcUtLZ/PDW4hUKWh/lW6KakBoZi9dXzv
X-Google-Smtp-Source: AGHT+IFvIVVGJj7wXuIXy69FB6dwSBFxEn9vka5rzvUJ8F3THFqGapMxGBUUn0K/GJKYj64Jy6pczQ==
X-Received: by 2002:a17:903:1a90:b0:269:d978:7ec0 with SMTP id d9443c01a7336-290272c19bdmr295819825ad.28.1760428490089;
        Tue, 14 Oct 2025 00:54:50 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f89972sm154634655ad.112.2025.10.14.00.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:54:49 -0700 (PDT)
Date: Tue, 14 Oct 2025 16:54:45 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Christian Loehle <christian.loehle@arm.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <zfmoe4i3tpz3w4wrduhyxtyxtsdvgydtff3a235owqpzuzjug7@ulxspaydpvgi>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <2025101451-unlinked-strongly-2fb3@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101451-unlinked-strongly-2fb3@gregkh>

On (25/10/14 09:47), Greg Kroah-Hartman wrote:
> On Tue, Oct 14, 2025 at 04:43:43PM +0900, Sergey Senozhatsky wrote:
> > Hello,
> > 
> > We are observing performance regressions (cpu usage, power
> > consumption, dropped frames in video playback test, etc.)
> > after updating to recent stable kernels.  We tracked it down
> > to commit 3cd2aa93674e in linux-6.1.y and commit 3cd2aa93674
> > in linux-6.6.y ("cpuidle: menu: Avoid discarding useful information",
> > upstream commit 85975daeaa4).
> > 
> > Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
> > invalid recent intervals data") doesn't address the problems we are
> > observing.  Revert seems to be bringing performance metrics back to
> > pre-regression levels.
> > 
> 
> For some reason that commit was not added to the 6.1 releases, sorry
> about that.  Can you submit a working/tested backport so we can queue it
> up after the next round of releases in a few days?

Sorry for the confusion, the commit in question presents both in
stable 6.1 and in 6.6 and appears to be causing regressions on our
tests.  I copy-pasted wrong commit id for 6.1: it should be a9edb700846
for 6.1 (and 3cd2aa93674 for 6.6).

