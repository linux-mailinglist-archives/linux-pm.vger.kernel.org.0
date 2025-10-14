Return-Path: <linux-pm+bounces-36067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D57E7BD9CD1
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 15:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80F5735321E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 13:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E790623815D;
	Tue, 14 Oct 2025 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZZURML6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F8221710
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449639; cv=none; b=MqbWGWxb3f4ccvE122fOlDTRv/gpvYJIYux77FNQ+XqaLp5GqY6cruRuiclOCtzaNxuZp8ZlEvH+h9ogvGrlkjHN84f6ZC1RMFlcDPJ2L9n8pseN52TUfdGl4AaUmuAk+44skk3NzmE0hxfQfCE8oCQcWkrx4I+j7+9BLn3Dzi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449639; c=relaxed/simple;
	bh=FiyH3HbysJHIUya6HD8TWJH15efuCVgzlLJ6VhuzQDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rjj6HKxt3NiknWq2IgmiL8eTh/fLBKJfKmkfGgWT2q04xlbAqtR2UVC3ZiAlU302Ae3EslsvxP+aPHWHFRWDSSR5yoGigfdrgv+Gkk1/Dzcw93KIxOSHe9yiOh9d/3VPD153YuqzAVxfp5TeL946nDS4HFmZpKFsKpJ0G7oZuE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZZURML6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AD9C19422
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 13:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760449639;
	bh=FiyH3HbysJHIUya6HD8TWJH15efuCVgzlLJ6VhuzQDs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VZZURML6hVuzmSChY5ByDgxyVVw95GXY/1dlNcW0WnkqJjc52ZPgL/r1NczJ0I/k4
	 EHgmRoU9b6E9LLfG9i0FbRBR91L8PqfbzmBGrG431fMC9JvR7SzicgEk6VY4R90VV6
	 Y5pmSGxh2wj7ygfgxFdiCJCJ/DypLLwjRtgt/Tw9p1nufVNw9WdjXdxwcXQdOcrSwp
	 G2AUX4ZTFRqi3LNjmyRnHK3lTyD3eXnlSBVs2sUihIUPLjNKv7OJpCeUIzHIwr7ehk
	 DSNjHK8gBhZh5NGbYw+fqvokYMyIXcUxx4LNTfjjFRysZk2cgS4Wh87RhiS4YjXYFZ
	 6U202kW/zAlsQ==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-43f8911522cso3617439b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 06:47:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCbDf++9pvvpXZAI+FYFr9r2OREupk8qEkKSFLATlvcHv4Vp5KtSbewjansoaJHAIMCjVJmv6CiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhwfWI8uwDC0cd74Bu3NURMBSe3y7+qL1qyxlZ+pzc/xwQ8UAj
	JKuTo7rG1+XDe03Zzhn+YCMjDgoTS/a0IkyfxHs7xVXHPlMi1VC6b0jG5Egg/sJgHG/6PYnHPZU
	TUnaRdyX1Ks0UfKzESA8aNfjjapq/2yw=
X-Google-Smtp-Source: AGHT+IFKdZN6ge3UA9PmzHlP2xLrNNqxW7vEeMa7BKOK7ktylhLXEl8XSOWc6vfk0wQTHsMb6jpquijdfDXJa+k9Sqc=
X-Received: by 2002:a05:6808:2028:b0:434:ef1:568a with SMTP id
 5614622812f47-43fefa71ec3mr13128919b6e.0.1760449638648; Tue, 14 Oct 2025
 06:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com> <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
In-Reply-To: <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Oct 2025 15:47:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>
X-Gm-Features: AS18NWDOTKJOUDRsGacceCYS3_zrSEM9Fs-sfsGd6d-Fu57AFnPpu7CbKcyjsmo
Message-ID: <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 12:23=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/10/14 10:50), Christian Loehle wrote:
> > > Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
> > > invalid recent intervals data") doesn't address the problems we are
> > > observing.  Revert seems to be bringing performance metrics back to
> > > pre-regression levels.
> >
> > Any details would be much appreciated.
> > How do the idle state usages differ with and without
> > "cpuidle: menu: Avoid discarding useful information"?
> > What do the idle states look like in your platform?
>
> Sure, I can run tests.

Would it be possible to check if the mainline has this issue?  That
is, compare the benchmark results on unmodified 6.17 (say) and on 6.17
with commit 85975daeaa4 reverted?

