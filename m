Return-Path: <linux-pm+bounces-20441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8497A111C0
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 21:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1030188A771
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 20:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003161FCF79;
	Tue, 14 Jan 2025 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfjuUodd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE601B87EF;
	Tue, 14 Jan 2025 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736885769; cv=none; b=KrZGD62MZe4de/0wISTpFyUq1MlPTf8qjm3EiDthaBVcd60dzMiem++8zDjmzlESROx/zbqhi3R/blrZuIfXabE+bSCXgjZghIweZpuybgCjM0N20pY+iHpKsXuOTBMlKs7HxHvCjKvQK+6GqyxD/0UZCBNQZ28D0TiBHZR6PsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736885769; c=relaxed/simple;
	bh=56n7CrE9/ZyzzThF+RkERPs9a7o/w3MWpqgHJmrmLPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wqtoixyw1ePYIjI/TCinUOfwWNipnXcWZ+lcCM2YUSXnJWU3NvBZ040+r9qf5hTXMMkRScZ9oLQWw+vK+i1QCh6wz6PUIXDAdXHtEVC+694i0ztUIZWulmcrl0AlYzTpE/vhO/75HsHrz34JOCMkae/wjJQJ5kU3LV8tjX1i4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfjuUodd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE52C4CEE3;
	Tue, 14 Jan 2025 20:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736885769;
	bh=56n7CrE9/ZyzzThF+RkERPs9a7o/w3MWpqgHJmrmLPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BfjuUodd0IkG1V/nSt6+JZFoEKIJEBTW8RKP2zoTWb57f+LfhkhpAheIwit9cIkk9
	 GrLb7RBKhJlhaqJH4WzLeveWDpFZXdr2S8z9+3tTKylq5c153/GEYOi/g/Wm195ZcA
	 TNbWhO3HG8Ph/BM9qxLRZ8VU3ORZRY4XSJsdEsDjqowEPt9uUQHTkAT9JitDs23vSl
	 JDXjy3WjVt8+EXBYk1WZE2OHeJjS/tjcGuzGRTHQ6kdTATlSucL0cr4U4Kt92jJL5V
	 54XUKhr+lPKsuPNg3E1zqdiU8qUZQh6DoLV5HkAuV8s7RTE5RrpXig/JJjaaMm9WJg
	 EJDW7h673NGFw==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eba0f09c3aso1932176b6e.1;
        Tue, 14 Jan 2025 12:16:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEbJ5k/Ozp3rBKh3k39EULcyXlVaP8cxgo13louqgAYgJkBgMkz44D+uDZTk8xLnMiKn42RpBylQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYAARM7KbZgZp0yEcPzbMgMI0vg5PCXGLbX7pbQsT+5Qio9np+
	FIkB0YL+aeOLBDUXXyJ1lx6V7f9Ztr3I+EcnK2ZUGRaa6KzqtfQLZ8qglV1FpjLg1rbOJDpJErB
	OaEn/KTYnOq1Lkgr48ufsebPwQxA=
X-Google-Smtp-Source: AGHT+IENimwZm+d5OOFvty0bB5LMNRnbUaXd80MwQ+Xd5h7l7mNVlHFKUNgZPwlB9CTGQ5x8Tguf/GTcbUhF/SqhuDw=
X-Received: by 2002:a05:6808:6144:b0:3eb:3f7d:b777 with SMTP id
 5614622812f47-3ef2ee472d6mr14297702b6e.31.1736885768665; Tue, 14 Jan 2025
 12:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111063107.910825-1-rdunlap@infradead.org> <Z4Ju6JqtDxMmmv8Q@duo.ucw.cz>
In-Reply-To: <Z4Ju6JqtDxMmmv8Q@duo.ucw.cz>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 21:15:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0haM9yfQYNdccTYtD60-78FEuQo+_8tYUsg6S59radejA@mail.gmail.com>
X-Gm-Features: AbW1kvZeRImLPgQ1atcf2E-jJS7uIlp-tfh9_gRtEvg7wr7iw-QxHVKH-_qoFaM
Message-ID: <CAJZ5v0haM9yfQYNdccTYtD60-78FEuQo+_8tYUsg6S59radejA@mail.gmail.com>
Subject: Re: [PATCH] kernel/power: convert comment from kernel-doc to plain comment
To: Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 2:15=E2=80=AFPM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2025-01-10 22:31:07, Randy Dunlap wrote:
> > Modify a non-kernel-doc comment to begin with /* instead of /**
> > so that it does not cause a kernel-doc warning.
> >
> > power.h:114: warning: This comment starts with '/**', but isn't a kerne=
l-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> >  *      Auxiliary structure used for reading the snapshot image data an=
d
> > power.h:114: warning: missing initial short description on line:
> >  *      Auxiliary structure used for reading the snapshot image data an=
d
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Applied as 6.14 material, thanks!

