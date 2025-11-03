Return-Path: <linux-pm+bounces-37316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B62DC2DA86
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 19:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E20D64EE233
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 18:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FCA1A9F94;
	Mon,  3 Nov 2025 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6dtcWW0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090B31BC95
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194150; cv=none; b=Sew8LV3MFNDvPxqiXtcGOrnXmerlDJk1pRi1Vpfy6Ce8IkgaFiMgT97t9HFLWl9cnNS1PSPfvKF9Ut1TF+iCmceZwYjlF0vm7Sk0lvzd7vs99emIbtrPCmPsXORZFR0UvMTCCRGQZYDJcHtoZy0DrRguY4zpbgFO7vdfxa3l/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194150; c=relaxed/simple;
	bh=OIIAIXY5e2PHES2Q4QtwFg5puL8a5FTP+kSSoBXbO24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VV/GGcFu+ppQSWLB/6ye34yzPNlgNNhsC3c6KH9bb79wFDnFGDDr9ZD+C3TELGiOLrR9Ms4uKCb7OhK4YpkhCZotNaFGI7QeBQmnWEfp7vKbN9HXK11xgCTUj8FwlO9xHiKqfHIiOmNdG8xTWjATFhsvM6c3v/B3SXuyUydAWm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6dtcWW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C2EC16AAE
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 18:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762194149;
	bh=OIIAIXY5e2PHES2Q4QtwFg5puL8a5FTP+kSSoBXbO24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J6dtcWW0egFcH+EyuJ2RbcBXPychB7USwtyyRoNJSLTPOkcGmJ+pAMFUGVOsb/+qB
	 EzQqde1GAzDhBSVT8AF/vCF0Doj7L6LfW3+CnaOyy1uXD8v25O0/WQRGIXqCkF/++v
	 9zGwyz/EUwScpYt6/WQCroIUcJhfSmPDGQ/O0r1MJCqw+l2tGbAjoXeuaXbxilpr3n
	 qDgzPgao1mSljQDf/Nud+mVCaqB7YO2DE7b+asiGAEGabZ/63r6NFxoODrGM7OC9sc
	 kvG1uxjAfLkZC/8xFgCRJn6JCJud9+sMmgEiC/V56nZr9IBCFzI4AiSsEMVT2OFAgT
	 jETcMJYygznjg==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-44dad158d96so1391701b6e.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 10:22:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrpoRAkgklcffEj4h4GZKuyuBXx1kkse68llJvnI1S4l5jAT8rtIQkEHEJQVXP8UO+UUi1ns1txA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5OL8YciYnGm5azmuJAru+apeF3msco5wdeaOY3auZoxOYPYJ
	6wdFOm2i3Kr2XdTYi8zviRD2sYghOSDFm1N/S5KdL6v1hWruDTG9J1T4rA9DxQi69JZP2zHPaOy
	C6vgUvY9DepLVGvKQ5/F8viYOn8jN4oc=
X-Google-Smtp-Source: AGHT+IGF37BqtqBozjdq5PkZjqmQRfCMzQrdwIPtWfhxnb0iVjRlSIoMQOOeo3L2dAVzcjB5NuzOGwo7slugsTSWlbo=
X-Received: by 2002:a05:6808:c154:b0:441:8f74:f34 with SMTP id
 5614622812f47-44f96060465mr84478b6e.62.1762194148971; Mon, 03 Nov 2025
 10:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101055614.32270-1-bagasdotme@gmail.com> <d5584bfb-d138-451b-96e8-02347886349f@infradead.org>
In-Reply-To: <d5584bfb-d138-451b-96e8-02347886349f@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 19:22:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hNEpb=k+bG5x7A2=j3E2tLKAMNcvewnRAa0RRdebtzgw@mail.gmail.com>
X-Gm-Features: AWmQ_bmbG1eUHMWJOjaUDkDYjNixhJHFAH7iVfoa37c3lBmOsJWyu7we4qVPpKc
Message-ID: <CAJZ5v0hNEpb=k+bG5x7A2=j3E2tLKAMNcvewnRAa0RRdebtzgw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: intel-pstate: Use :ref: directive for
 internal linking
To: Randy Dunlap <rdunlap@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 5:56=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 10/31/25 10:56 PM, Bagas Sanjaya wrote:
> > pstate docs uses standard reST construct (`Section title`_) for
> > cross-referencing sections (internal linking), rather than for external
> > links. Incorrect cross-references are not caught when these are written
> > in that syntax, however (fortunately docutils 0.22 raise duplicate
> > target warnings that get fixed in cb908f8b0acc7e ("Documentation:
> > intel_pstate: fix duplicate hyperlink target errors")).
> >
> > Convert the cross-references to use :ref: directive, which doesn't
> > exhibit this problem.
> >
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>
> LGTM. Thanks.
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Applied as 6.19 material, thanks!

