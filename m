Return-Path: <linux-pm+bounces-38695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CD0C89877
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 12:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93B8F347E03
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821A9320CCB;
	Wed, 26 Nov 2025 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4dH+6wh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2FB23AB88
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156686; cv=none; b=hYq6lkEVxkRpA62D4exE9W8aYnW392dH7uy4qjYUr01e8Ar+2PL24klSvNrCvPUp6RAZynrsflMEvi7VUgFWRosnRnnbVya4BVwPrHYSyc9LXac3/nHCGHXJQp6DzUbRHMDqaQkTDU8RJzzE9d41N+QtVoI+PzMEXM1GTxUNX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156686; c=relaxed/simple;
	bh=Fz1h1hp5wiEAzprxBqkpGc0mfgeBRwY4AooaFcWtZdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBpnzqzujGnvL+6dVFlda1zHSsPToCcY//Df2G++qukQGmVWJa7oN9mDU1yjWpKIT//Hc2ep5d5Wq8O7369SuJ1o+gcxQpRWe9JNhoRMuy60gRlufuLaVIsXkl6m1OFz01HWmi3sci0WbIyygIpQxqkGSAG6RgeldxbD9JzXAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4dH+6wh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1266CC19423
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 11:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764156686;
	bh=Fz1h1hp5wiEAzprxBqkpGc0mfgeBRwY4AooaFcWtZdE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r4dH+6whmnqjPY/raUy8dkW2z1k1Hb7NCCCCQagQOMECPPEwzF9//dUkY4T9T5Oto
	 AZj4cJ67RGMCs0rdrMwOg6TPUD5HkMqbvCOIu4zcA4HQpB4OXqZj2Gr6Tq8Z9wyy0l
	 VgAxn5s9wghVU2NJqnuuzAvTbnnRsLHKC69eXqRCYH20/MaZGViMkea/HwZ8CtioEH
	 rbQOKT+hRF30/LOyy2OIeG5TzZG5Sj2IN/RRGX9v5RkAlgnMaWNS0WBgyDyjwRZeba
	 uGCXd/E3tCN+FWyK9av9uoXcCVohUoZoDUF1noy0lHfQ5KUqxuZVKYAZuZtfsioSaW
	 9KjAn1gSTwEPQ==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4510974a6bbso985268b6e.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 03:31:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpv3wZvmFSSYdMkfXSKsiwePcUd8tIC4y4nNn4nqEtH3t63c6YROyNbiXGJbGfgwCZkdvcEEYEog==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAH1UzrEhqvbPlabCH56dr2UtUz7o1YTxKWaL2e/61kTEpdqLu
	jSsuEmDHNiwxXfLFjmbCoY9jJkZTrskpEnlziBzaGTYasqVa6jhYLk/04ZQ/hBOY7QQza776Y1r
	balJnSjn2rI2sSpQKJpzM4rcyaDm95UQ=
X-Google-Smtp-Source: AGHT+IE4NggPrXNFo2cmtQKshfyTQB3WRTZfkzjp3WItjLKG/5sjuYXyzLcfPNWXM2bsFcKp5sZ7PhDOEdS3KKSr8n8=
X-Received: by 2002:a05:6808:c2d3:b0:450:125d:d9e with SMTP id
 5614622812f47-451159c7a91mr6809637b6e.21.1764156685328; Wed, 26 Nov 2025
 03:31:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com>
In-Reply-To: <20251126101636.205505-1-yang.yang@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Nov 2025 12:31:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jsdsyVd3hPWni1Vj+daQS8PdWJCjboJHHHbBjBMeSxzg@mail.gmail.com>
X-Gm-Features: AWmQ_bk0lkjd4wgJ4f1n4iXpMFQZ77WG6i-5RV0nYJqcwu3OGBKWxcMUjXu2F4s
Message-ID: <CAJZ5v0jsdsyVd3hPWni1Vj+daQS8PdWJCjboJHHHbBjBMeSxzg@mail.gmail.com>
Subject: Re: [PATCH 0/2] PM: runtime: Fix potential I/O hang
To: Yang Yang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 11:17=E2=80=AFAM Yang Yang <yang.yang@vivo.com> wro=
te:
>
>
> Yang Yang (2):
>   PM: runtime: Fix I/O hang due to race between resume and runtime
>     disable
>   blk-mq: Fix I/O hang caused by incomplete device resume

This is a no-go as far as I'm concerned.

Please address the issue differently.

