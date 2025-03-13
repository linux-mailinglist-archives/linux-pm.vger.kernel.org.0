Return-Path: <linux-pm+bounces-23975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 726F2A5F053
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 11:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296FB189C904
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 10:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECBD264630;
	Thu, 13 Mar 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwbW/ef5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1490D1BC5C
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860650; cv=none; b=e7QFFu6FTXIj48n64r9ymEhem8HKLxxT2EDWvVoBn2y2z46oIkhXVMIW8M8Bev1dqI+8m8FskdduSwGRMOoz4uMIpc1NsovZ8tfo6liPc5YLjsSB0tB30NIlDAdl7V0d5DyZka5G2qKeEjEtMHxu6NeHXq8ZJMFH/2QAd9P2XB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860650; c=relaxed/simple;
	bh=TbxwI+znO/sxGqbs11RbQ/Plw0Mybu0NGFX5kC+YrbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEIMflo2JmsenyOhE9R+DPVlBbYU5HxzRyK7yAA+OM82nJ26VttIXw68nAc5VySL5zh2toFf2oWFyVbscujmo4P3FG8Xh+R9xWiVcBEj8vLWc+ibZxvJf+rUlZm2rKdI7kRCClk6oP9JLX9w9ooW8d+ZhurM+vKdKsQdKDMPv4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wwbW/ef5; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e6341e4d0b4so1653679276.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 03:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741860648; x=1742465448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEq4gSc+pVBLq6kDjW0dhNwCO81EyRwI+zgKcB69s94=;
        b=wwbW/ef55DSMJsruWuOsko1h8+Lryk0Ui8JkBRE/FYY51KTwxhj4f1cXJbn7b92y6S
         HdwVzHqjItYpzevWfCC4ai5ELNAApv0BtxNkctHP+iYvNcFmTdTLvDFCJwPgJQ5VTv16
         rPiFSByCre04xhWpbQL2DWGo8IbuXmJgJJ1vqVo3uTIxST6+iRGuN2pwlpRMhH5dv6mg
         ha72AbQyCf5SczjqhmBW+zIodoj3S8RSD78iSqCxagdyzHCUQ0mb0fIyLnN77rjs830r
         5fqzJwhgEP/YIDmg5oMGPe81WYVwISQy2f1zm0agtK5NCo6HqMPBf6LdbyguzKtfnYSU
         yE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741860648; x=1742465448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEq4gSc+pVBLq6kDjW0dhNwCO81EyRwI+zgKcB69s94=;
        b=M2hnddTxTnfwzlVS3dS95KcqtzcnLVdxS5rlNEH67UEZLCd/gflGzJwjNUbompcEUo
         DV8aAhuOOJBhM042JvXmZHJ4J47hoErYNAWdY4x8TypygQRZM+5LfM2k3vWKbvJ69jiS
         OMCePcAJxiCAlEiG4lvdmUmOQhtiINbYTdEmBo1Gduv2mkd16TEqPYSb8Is+88HvUViP
         Ubj7WJUtnW2aBCydOhoCelErEOeXZusP9E0jSp3SXQJZQTWne7gHJhOUxQGsBhvyD+cc
         jqrxUsZ0kko4xX3d3DeAqvjbq5mGqIZCC4UMOB0CKE43M1Luez/MbX8nDnn2ypeG5rXO
         6cTw==
X-Gm-Message-State: AOJu0Yz15wNOT+ad6Tn1XUzrOnNFkPXb1i4qvyo9FxGnDYoIykXZvot1
	dFHzfgCroN8vuDrI1CTXqwquZ4CB7HIe4xqzb2Fks9FUVofDwIFLzOJzh55sSlq1eYQV4lMqso1
	N5sh53MXieaWEgm7aPpPlvjqLdKl8fuzyV34EtUGKDERfYjHy
X-Gm-Gg: ASbGncv9y5YRwywzOBuo4n/6t3sVmVxLtu/t+d9HhT+zTsXedahAgo/14qqQbc+J/A4
	W6+lvK2bBX84tB4pVLIZnwy8HGggCs4bH1mjNFkVjBXxAz2JW3TCuwoUPQEFiATFYBp84Zqumz/
	xi+YlbRKVDy9IwW4YgJHynXpHL6IaHXdfa4DENlg==
X-Google-Smtp-Source: AGHT+IES4ylSRZLRhz4IqnSjIJ4SbTq78c06VoJ6seezxJB5E2x1gFW3S9k2nq1/9lT8UoeNfaCTlenakAPZsdBj9dI=
X-Received: by 2002:a81:c702:0:b0:6fe:4ee5:a6d5 with SMTP id
 00721157ae682-6ff2f45d995mr23159657b3.0.1741860648042; Thu, 13 Mar 2025
 03:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311160827.1129643-1-ulf.hansson@linaro.org> <CAJZ5v0hgzVvA6vcRxUeByhVPgjyeUfY7v5Aj5GPi=_T_XWpPvQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hgzVvA6vcRxUeByhVPgjyeUfY7v5Aj5GPi=_T_XWpPvQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 13 Mar 2025 11:10:12 +0100
X-Gm-Features: AQ5f1JpdkM0uH49Oh4WBEU6OiQEkUVTrTDRedrw1VN-bzd_F5ywqSRzg6HsfmUs
Message-ID: <CAPDyKFq=Ne9xt5UaQWdWVFfu6fc8ZFmaNYiJ2s6kRCowVxzagw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PM: s2idle: A couple of minor lock-simplifications
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Mar 2025 at 21:20, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Mar 11, 2025 at 5:08=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > While working on s2idle a few things caught my attention when looking
> > closer in the code in the s2idle_enter(), in regards to locks. These tw=
o
> > patches tries to improve the situation a bit.
> >
> > Kind regards
> > Ulf Hansson
> >
> > Ulf Hansson (2):
> >   PM: s2idle: Drop redundant locks when entering s2idle
> >   PM: s2idle: Extend comment in s2idle_enter()
> >
> >  kernel/power/suspend.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > --
>
> Both patches applied as 6.15 material, but I rewrote the new comments.

Thanks!

> Hopefully, this is not a problem.

Looks good, thanks!

Kind regards
Uffe

