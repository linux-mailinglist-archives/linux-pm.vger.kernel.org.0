Return-Path: <linux-pm+bounces-38321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD47FC7636D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 21:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58D593454EE
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 20:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111D92D8375;
	Thu, 20 Nov 2025 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y58sdKW/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03F82652A2
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670895; cv=none; b=OQWCqgj34hY6kdSxwGGbFUIJ1y9mXa2Mhq/EY04AKjzKovah7PNzV9VhLnIP+wdTj/oD8izKMMMn3wyCiHJZUfepBS+MeV59i3ltLbJ8x/ciQ/owPVQ55hTLh0o2NoQaUAwbHOt2vlB8eejgiCMAI0/764eFXOiSvYzcRmOdgb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670895; c=relaxed/simple;
	bh=+3EPyEqahop0Sw0Nneuy64POtCZ4cyQ/t3ZQzQV1Ly0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpTVvZ1mgYGvVTRqYQQJr81IFvDIPTinyW6kSE/hQD2/Ynvq9ycYf+cNdheNsdIEtPvwLt8BjOqNrTVU942ExRZMTxvMUKSTLajPJLqgMDzq+zbAqUevSf/WP7YdOQdODyVomY5XMZwWvwWRLvJjh9epqMX+awZNXqY4IZ+mPXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y58sdKW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E34C19421
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 20:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763670894;
	bh=+3EPyEqahop0Sw0Nneuy64POtCZ4cyQ/t3ZQzQV1Ly0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y58sdKW/JR7udLpNyyVKW+K4lL0IBYqyeaeD6SqvRf6XY5QA87ZWgGm99aWhQl49N
	 uFbATnwMnj5ZtBUdmMsfTgzKiGK3P8Lkccj0re+VjzDcEtp1m//5GPfFYAyhQ65CdO
	 REIjZkEWz3BGai2NLvGkSOE1oRpkDJs0z20y5MASlxYgtLzicAZx17XN/mnLNXd/Me
	 11gkYsFQ2hobUnhZqa4x2XhVO0Z/yL5TEfhfvg3qE8nL5zICL6bshbB8H7I/p+02EZ
	 ZNAeLux8rKFNawWjrQL/QREnofBogsxr3+REY9eiESQ08slh9FGtu18GpMmJqOLMMG
	 Yt67abVYeqGjQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-65748e230f9so443585eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 12:34:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUj115x85X/IpPbVC6T74Dyj8APjJd/Tue/xCIo+8QwSPNs8QGJ55uPAQ9Z5akBjK2diSpPdc/syw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFmR8UBRe0lutpopMP+qmvJqyJ856cnrpf4LC0r3hfDmhckWWL
	QQo/b7jI2TLekfjd8EIfrIH+pZZgQOBWANEkfenQ1l3+QyvAHvUJAu/unzAG5QyyhyLjXwIe0Xd
	GA0kNMrEMwpZIOMr1OvIyqtZvZ9z++gU=
X-Google-Smtp-Source: AGHT+IEcBoK4EydGJZublvYo0ZCvFoxo1gmj5xwMPWIsqZZBE6Geg3SKtuMCg6rLMczgburZoXm/XMuzCaj+2lJ9c0g=
X-Received: by 2002:a05:6820:2111:b0:657:5f19:55fa with SMTP id
 006d021491bc7-657857b449bmr1544748eaf.3.1763670893920; Thu, 20 Nov 2025
 12:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118223620.554798-1-srinivas.pandruvada@linux.intel.com> <d31c0601-318f-4f85-9982-96bcb5de973d@infradead.org>
In-Reply-To: <d31c0601-318f-4f85-9982-96bcb5de973d@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Nov 2025 21:34:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gq+aaGOv2fU=tsEYs_A4YSWYsJS3HriqkrNnDx+pEw-g@mail.gmail.com>
X-Gm-Features: AWmQ_blws8kFPOlTohi_YztwlS9yQMKV9HBInndNqGQR8qx-gjq2cnZnaVloyhw
Message-ID: <CAJZ5v0gq+aaGOv2fU=tsEYs_A4YSWYsJS3HriqkrNnDx+pEw-g@mail.gmail.com>
Subject: Re: [PATCH] docs: driver-api/thermal/intel_dptf: Add new workload
 type hint
To: Randy Dunlap <rdunlap@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: daniel.lezcano@linaro.org, corbet@lwn.net, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 1:44=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 11/18/25 2:36 PM, Srinivas Pandruvada wrote:
> > Add documentation for longer term classification of workload type for
> > power or performance.
> >
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Applied as 6.19 material, thanks!

