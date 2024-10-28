Return-Path: <linux-pm+bounces-16567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CE19B2F08
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 12:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF95B22344
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744DA1D5ACF;
	Mon, 28 Oct 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk7GHunJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F09A1CC89D
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115398; cv=none; b=rJu46/a61gw2yURq29WlygtOskHBN5TB8IXI8D4a8auHVCmWynCJFj40sXb5IApErIjB0uASJWKtKFjJRMgcCiJzLoYnfW2zd0fyhuh1ia6Z7dmEbPhjNhWxkr6BPvFbN8GRsDI5GGp+R5qfG8sK27fwYysw5f1RFv9Hk1s85kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115398; c=relaxed/simple;
	bh=ApufkU0QgcQ3CeXRMRxJ6x8mYTVTJ7x5ThuXtYoYtoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYLIyqsOhXRbcAiLtbfiHBuykO4yx6gpYE8+pXtai4fUQnnskjAaJW/8dG3tkNvr8MSMTw1GfKuScUvVsubRpdR4Go2eEqdE5crXP5LWYrIb6OuHcSwJYmwAE/BdOEc5Vpc231S1zTbV23GEd9EuHhe/eQQ/I6eSVrw3H3IPtTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk7GHunJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB124C4AF09
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 11:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730115397;
	bh=ApufkU0QgcQ3CeXRMRxJ6x8mYTVTJ7x5ThuXtYoYtoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qk7GHunJTrilNKvUga+86kWL8wPTf+3opx0UuNY0fVNUSEVMBO2Ht/DQDBBNtjWAc
	 s/gz5KjFd3LPCtsB/iPxvEisocn6K3+8sP8fPtpA+7GqpS8MIiHHjll8zcfiG2Obpj
	 i9zVKH+SNcQPwfnp2HYmaRcCdndEIX1d64fKqwvp+yrKVGLkW22anGufeHod691V0g
	 4GadJNHYq6wzC2BSSuH27UsA8bNwjbPIueJ08KHPwUstNWgqg4v60cYdvYoTMNYwWH
	 duyV89mPQhMuNz/F/eqxGqJKW+vTBq/C9gkMdEGjb+aTqO1K+NWAGR4PrCDhrdUHhJ
	 b8lHvmKRmbeQA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2887abeefbdso1929241fac.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 04:36:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUytNt6HAgE5BGTfN6AMMVJ+b3b3M+h3VOxMPUI/vlB9eQwNDMwTEwsy170RB2jQ2yA3UyUiKu4FA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvclmLjT6zXDQpe7/yqnTQ3IDRoqPU8BRdmxwbM05TekCPr0aX
	NgCPRX0bYaKL5/PAXUL3GJ1YwqOnDH1awZRbzR8JpXV9JUCDpw7sQ9yeM7YrGHnfbHXWRGVBSnu
	0fwLjN/ydRc6yL94hO/+biiMErDw=
X-Google-Smtp-Source: AGHT+IF14QKZcfrAF70VUkj4y8e9vsPKklHTx4SR3dBzUABQLzML4mhWYOP8MN4p3gH0hZhyk2iwB/eNNa8Oe1xgoiI=
X-Received: by 2002:a05:6870:198d:b0:25e:1ced:744 with SMTP id
 586e51a60fabf-29051decfb7mr5178508fac.47.1730115397218; Mon, 28 Oct 2024
 04:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bfd6e381-b3e1-457e-b992-d6d9be5e446d@amd.com> <CAJZ5v0gwO6hLGu1iNu+GKz6_LAMaZdY_8htDhVoFVixUhSO1zg@mail.gmail.com>
 <CAJZ5v0j7HpUN-heihZL3HZDMLV0y7XCw2nvkHgFCGZPhhFroAQ@mail.gmail.com>
 <a2e7c093-66e2-4efb-928b-86fd55c21f65@amd.com> <20241026092451.GAZxy1YyuewwlQLem7@fat_crate.local>
In-Reply-To: <20241026092451.GAZxy1YyuewwlQLem7@fat_crate.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Oct 2024 12:36:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hT5r37_S1AAGCSSZ1FYEkDac_iyErdaYe1kzVRUqui3A@mail.gmail.com>
Message-ID: <CAJZ5v0hT5r37_S1AAGCSSZ1FYEkDac_iyErdaYe1kzVRUqui3A@mail.gmail.com>
Subject: Re: Preparing next amd-pstate PR
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 11:25=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> Ok Rafael,
>
> tip branch is here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Dx86/=
cpu
>
> You can merge it and base the rest of the stuff ontop.

Thank you!

