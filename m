Return-Path: <linux-pm+bounces-31025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF79B093B7
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 20:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358341C41912
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247852FEE0C;
	Thu, 17 Jul 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9CdLmJ2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018B2FEE0A
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752775521; cv=none; b=oTaQh1h5o6VwSRZ6gkmlqhtzcmOlBA8K/MqLAHjI5fD7iPqUfTMi1ieCzDaYUe0qy52qLDvyPgt5VL8M5TAO40Wj1w2bVcSYVvJ5+7geckYqqaU5y7UrxveK8LZr+oiZeUFx0UCzoL0mwRV5hATajM5R/pRbfVRq8i5OP90ZcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752775521; c=relaxed/simple;
	bh=JmxivOqfGGBsqKovIFPwoQb1nj+/TPiKbMjCo+qI7CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDductf/glGMrhhVGQdzaxCPLrrEWyJOgLiaEM+6Sle7gJcHQjd4QrzD7oOst94QV7aey3AbxgDTfsPykFmvfIQdj94NMIEy6/uCwuhwrTEBJTk03Deh7ktYbBMTJxsHLOw4gfIG9aTg01TY2p3F+Cl9SRhMnwiEZlCiGb1+sVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9CdLmJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75866C4CEE3
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752775520;
	bh=JmxivOqfGGBsqKovIFPwoQb1nj+/TPiKbMjCo+qI7CQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r9CdLmJ2bneTAR6qctjsSsg3JPg3XXVHcRDGg73gXVFAeok4s6iammFDniJ5VAaw8
	 Gsqb057yMAkfHSQE7zpSFca6x4HTZg9E7EjZ/cleYtX2hfcMcG9NELHgRlmskmmK1r
	 ZGeNOEJGe4hnbfgDVy1Ub5Sv3lXziY/myqkNE1GxnPc3wX7Kdp4SK5/h3YcdoA6nBx
	 BL7jIg6xaKKa0ey7n4Gmeu997O5YOBJmV22MLyBBvmzDuzlxwZPIGiQi4RDXnoMgQw
	 uH+Co/zA7Ni+5xd+jDdXn/rKFymhnWlCyHcEdJildTJhtFUoBWb2owQ0KR9ODHcRku
	 /MlW/l+0Ci41A==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2ffb85aed35so903928fac.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 11:05:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHDHjEzsTyOAYwmVRritgZ1VHo5sP1Ir0IzVi/0PxkppgOEHlKY62hzw/dA/bz6k9ggWIFmz+XGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/0GRgBqdgRBkhN5guHQrC9hPKBygu3iUqaCoIRHk3H1BWqgU
	tPiJmhnhsgNd6VbyBZEg5TfLtL11yHyDBEgykITB4cGEsoqkePxfh6Yjs5xJSlCiyvHVwpMQEe7
	PPXjLVrgmOZo+fmg1zQlU7Z+1c6GrRCU=
X-Google-Smtp-Source: AGHT+IFvK8TTnIGdnHYSuVYjtyuhAGlAFUwm1gsWeGQu/gc5gec8NbmaIEB2iGVEbCuIxsxdmEl39N8sinhHSQh42zU=
X-Received: by 2002:a05:6871:2996:b0:2ff:9517:f296 with SMTP id
 586e51a60fabf-2ffaf2505ddmr6371662fac.2.1752775519697; Thu, 17 Jul 2025
 11:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd21aada-a816-485a-b0d0-c4530adf0425@kernel.org>
In-Reply-To: <bd21aada-a816-485a-b0d0-c4530adf0425@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jul 2025 20:05:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iPZoEfWK+m1G0+n5npDmmJyNn3k6OjC65pMZxDPVYN6g@mail.gmail.com>
X-Gm-Features: Ac12FXwa2Yww3ZWzUnWvHcSoXFoG9e3xUs-5gWMf7t8hQ-2MWbs2Rw8rwK0r7rU
Message-ID: <CAJZ5v0iPZoEfWK+m1G0+n5npDmmJyNn3k6OjC65pMZxDPVYN6g@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate 6.17 content (7/16/25)
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 10:01=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf19=
11:
>
>    Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.17-2025-07-16
>
> for you to fetch changes up to efbc5b4ac98e187375bf14c18ecc76988d3bab3c:
>
>    Documentation: amd-pstate:fix minimum performance state label error
> (2025-07-16 14:55:58 -0500)
>
> ----------------------------------------------------------------
> amd-pstate 6.17 content
>
> Documentation update
>
> ----------------------------------------------------------------
> shouyeliu (1):
>        Documentation: amd-pstate:fix minimum performance state label erro=
r
>
>   Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Pulled and added to linux-pm.git/linux-next, thanks!

