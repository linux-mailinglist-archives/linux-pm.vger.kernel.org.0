Return-Path: <linux-pm+bounces-33885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E99B44688
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 21:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D64D584615
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 19:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383C4273D6B;
	Thu,  4 Sep 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJQ3n7Xu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC726A0C5;
	Thu,  4 Sep 2025 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014652; cv=none; b=N3hnNpfZQCdb/eJ86lX5ihOGoDnFlbfvHU3+pMr8Y7V1Z8dI2PE/Qf63dY8+V3ARYRpmnZSZHJWKRO8i+BLxqeiIvwkmADcSGOd2NbNMDnk8DngDliS/SpPnSaiLLNf8lERWPpz08G4Bwtjps2eR7yBAab0pioIFW9fCt7d7r1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014652; c=relaxed/simple;
	bh=TDoylOXD5ciLSskYTbNihAxiYFz/Px6Na6LHqpi/t2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPmSwiaflQ2lls3U6BVwfn8Og593JERVC48M8G0QVGATh0Q48dyvfBX+wzD423ri6WuF5lW3Me9e0fVBAkT8N9nK7eNZRMPK7HzmpOM9vFfypV/vBMambtz567WGy94Wr6SVticfn1WLKExM3sGDwPDY/ZDz0pNhwolK9e3huvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJQ3n7Xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93557C4CEF1;
	Thu,  4 Sep 2025 19:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757014651;
	bh=TDoylOXD5ciLSskYTbNihAxiYFz/Px6Na6LHqpi/t2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XJQ3n7XuTTPSOVwMCEMavOo//TQDr9WlBWNp7rJt+JEuO0uYlaT4+y0p6g8avobOV
	 J8CsSgUw6SsuGM9f9agIVujvWrJK61G+DeeEKhf0lW4s92aCPqLLpy1ha+MzrjhaGB
	 chxJXCxItr7oc+fcS8FBMCuwV7icCwuPDT6jKx7wpSNtLkV7IqLkKFGosGVbky8SAN
	 BfFGf1waIGdOBMWHVftT1U5qwIvzz1DeqB7Gt0KZD3XPPf8oJfdXQ38vqoWL700EuT
	 pInoZBlO+l6L8F+bAc5HSCCNYoZzn+FoP1+EOsZsVInRjDys4tgzQiEbj3D6k0JUa/
	 sNu1oFZ3M7geA==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-746d7c469a8so397435a34.3;
        Thu, 04 Sep 2025 12:37:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPINRZSDG112X2vAFpILOrG/KEXMR/4HW9imHvpZJTwWT9G+B8sWiR3ZKY+QJ8aBazeHLa9HXqdvVTgG0=@vger.kernel.org, AJvYcCVzyzzj2g2NYQo1RfAlvj94zHPL7ReuwVpd3C8aXPRLdcxVLj+TJCYTuMZJbxtMalcb8xc/Whwjvvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgItYlyyuYFhlkLOso8ocWtUvNjMCuJ175Y2oBdYtWzDoE1nmm
	wu0yeT9PpG2Zn2u3XJCN0f4CU42IQhN1mxU+AdSCL2EatL2zEzTixkd3Y0k5ORPmNTK/Relm3JB
	qz9dqSwKvkL1Ml0KnykqkpPTk3zQfSOw=
X-Google-Smtp-Source: AGHT+IGh4zyXiX5/8UySg6CnF/0Po/f2mWycNLVviSQumSfoUo05ZtR3cgcsU+YLle89jtub4MZE2QIM33671iAeuPc=
X-Received: by 2002:a05:6830:6ac2:b0:742:29a0:1c20 with SMTP id
 46e09a7af769-74569e852famr11250654a34.28.1757014650918; Thu, 04 Sep 2025
 12:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826091937.991667-1-luoxueqin@kylinos.cn> <CAJZ5v0gD8RkKG8+6MneaDkxndS-oAm8a1AswEDP1w8HVCGZDdw@mail.gmail.com>
 <e0968be3-e33a-4e94-ab8f-215cdaa2be17@kylinos.cn>
In-Reply-To: <e0968be3-e33a-4e94-ab8f-215cdaa2be17@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 21:37:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j2Xa410LBfcKhxP3K1r0bpe6TU1FbnqXZJjUEJpubynQ@mail.gmail.com>
X-Gm-Features: Ac12FXwsR0Xb0pEfy2FOoZEp8-r7iL6_NyVuzMEZIeoMhgCBz6zNXFbSwukgfFI
Message-ID: <CAJZ5v0j2Xa410LBfcKhxP3K1r0bpe6TU1FbnqXZJjUEJpubynQ@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: make compression threads configurable via
 kernel parameter
To: luoxueqin <luoxueqin@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 5:30=E2=80=AFAM luoxueqin <luoxueqin@kylinos.cn> wr=
ote:
>
>
> =E5=9C=A8 2025/8/26 19:43, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Tue, Aug 26, 2025 at 11:19=E2=80=AFAM Xueqin Luo <luoxueqin@kylinos.=
cn> wrote:
> >> A new kernel parameter 'cmp_threads=3D' is introduced to
> >> allow tuning the number of compression/decompression threads at boot.
> > And why is it useful/needed?
> The number of compression/decompression threads directly impacts
> hibernate and resume time.
> In our tests(averaged over 10 runs):
>      cmp_threads   hibernate(s)   resume(s)
>              3                           12.14          18.86
>              4                           12.28          17.48
>              5                           11.09          16.77
>              6                           11.08          16.44
> With 5=E2=80=936 threads, resume latency improves by ~12% compared to 3 t=
hreads.
> But on low-core systems,
> more threads may cause contention. Making it configurable allows
> integrators to balance performance
>   and CPU usage across different hardware without recompiling the kernel.

So please add this information to the changelog of the patch and resend it.

Thanks!

