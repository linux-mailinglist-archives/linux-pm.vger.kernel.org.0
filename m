Return-Path: <linux-pm+bounces-13422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE74B969E93
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 15:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9932286CAC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CAA1A7263;
	Tue,  3 Sep 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ6b8fln"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6D1CA687;
	Tue,  3 Sep 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368524; cv=none; b=q7Z+Hz03XTOvl7NmTPYCp0jSpwPwcAsmmSmobdhW+PL++yhLrod8jE0tJXdrRQTTxyN0nEdXp/dT8zwaYBixLnbyM1Si2VGnFwMlp0olr1eBUI6tZhdBcZltzfbD5mL7qb/AOaDaNqVUjHVXZTH8yH8urvVhNaiK6+6Xrxly5V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368524; c=relaxed/simple;
	bh=8OIOegP9FBkYI+B3igpq06xfWraWjeDI2QpZnHymEJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QU/25h5AqtQE29y/ev/KvNyQ5tZ/oDoXE5OO2IiptFwTNcCYvNODXRDyd7ORpkDRlHVRJdg957yzopkRJjE1xgyJKn6ia3NzqaU9db624PYKZZT5aagqD1t8gBp04tEeMPivi4Ayxsh7EGTpCJV3eT2GJWRXbc+0kdBt+spMju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ6b8fln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD50C4CECA;
	Tue,  3 Sep 2024 13:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725368524;
	bh=8OIOegP9FBkYI+B3igpq06xfWraWjeDI2QpZnHymEJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gJ6b8flnAVrDiI6h/tZo+isUs0NPNaxrFdGp7UyXy8q5lZVJ7WS9qKHxGBPnnOyu2
	 rgZUs7/qEsnNdsxyi/c74XspJa8ZDfhPUIvxb9pmQcOeNODVDKwAcIizo2lJyOquPg
	 h5p5nsZLQAr0Sc7w6BkZHjeolaY0C5UzRD6QNayWb0x8c/2JjwR7JV20Io2MpTJ8sl
	 ujqVVis5val6WrN50kjNsdSJ2FMlAwIxZOAhWKX0pBLDsGHMUcEwnrbO0KLtIrcdmm
	 qyn+0EcyPXcIkkgqhvwGFC8AgoTcL2oN5dYOUjPkNSaN9/G9LVo8tW8RsAib2uuv9H
	 h8wh3aTtg9Xgw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5dcd8403656so3769549eaf.1;
        Tue, 03 Sep 2024 06:02:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSyqDsEqm2BXJoLRCo5hI9CyODWWxiY1G+EiuREfsceuTH2s3PKKjzzbMSLtMGpbeqsURYCk6I2pA=@vger.kernel.org, AJvYcCXEW1qUIOeUOnpmSGx5Un1tJ2lv5hg0wVGYSTU6BXLaa+reEU7bY0eKzXmTbRnvB60Jw88wYVhXO0w95v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsSRuxvuqlHMGzFnaxf+K7TInex0/BJYZZYzJRhUeEaNmUdCkf
	isHvAdBWv2wcNjLuvWxb58sUBZOCWVx/52bYaIC9/7y1hRu1Uxo3ndjGWipKQ549zGcnfp5oJye
	uyEbMAv09gIZh2Fwxh5Sw37zDisU=
X-Google-Smtp-Source: AGHT+IFlEFGjfbhedCE8N2PESVnWtNm2uKq021SxQrP1WNu+kvQuO1CAd0ljWfW2wAuJbG517JZfpPDsT8tWk+OLZb0=
X-Received: by 2002:a05:6870:b411:b0:260:3bdb:93a8 with SMTP id
 586e51a60fabf-27790319b9emr16950187fac.41.1725368523669; Tue, 03 Sep 2024
 06:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902054959.28073-1-00107082@163.com>
In-Reply-To: <20240902054959.28073-1-00107082@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Sep 2024 15:01:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gZ9oAByawssaARFN1_crTuMZ-CnU5Fy9D1sWv+Moo-sg@mail.gmail.com>
Message-ID: <CAJZ5v0gZ9oAByawssaARFN1_crTuMZ-CnU5Fy9D1sWv+Moo-sg@mail.gmail.com>
Subject: Re: [PATCH] PM: add: move warn message out of mutex lock.
To: David Wang <00107082@163.com>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz, 
	gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 7:50=E2=80=AFAM David Wang <00107082@163.com> wrote:
>
> dpm_list_mtx does not protect any data used by
> dev_warn for checking parent's power, move
> dev_warn out of mutex lock block make the
> lock more efficient, especially when the warn
> is triggered.

It does protect the power.is_prepared flag of the parent.

