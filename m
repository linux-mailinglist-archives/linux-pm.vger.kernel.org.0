Return-Path: <linux-pm+bounces-13562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62B396BC75
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7011F2178B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC3D1D9330;
	Wed,  4 Sep 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0jnbcwr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488631D0491;
	Wed,  4 Sep 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453213; cv=none; b=lspSCXPQ626N7UfHd6V+sgBJIlzAWA5ixnOmPQqCo0CW+Fh6LwbNuO2JwZ4Je6rv4SOHMtSxRfopmbaLkgdxuDY8IbtDjSnbQXk/AfQitffN66vZshxnyKm6G+YPD5Lzd+vsQeTxOa8y8w7JfMpcfZJnFEVW7zUGgh5TanPcRrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453213; c=relaxed/simple;
	bh=YKDCZscyU2vQ/uLd3Ew3F0b96EzQTeTNQOivdxV+9qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWfpO/IYEq5nwvixTZDQkI7m3MwMFfmZfW8BrhjeXz6tL4VGAiNOZTNNZ2CwvF1JKHrdOGi6TQPqep6dnDHLe1tN7aNrz3xZpOKLJisC0y1+sCi8anfP8Ef5ocXG93plGSVWoY8pSp+cQzAE+JTJLKH1BkuwcgijzU3Hc68dVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0jnbcwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62E0C4CEC6;
	Wed,  4 Sep 2024 12:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725453211;
	bh=YKDCZscyU2vQ/uLd3Ew3F0b96EzQTeTNQOivdxV+9qw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D0jnbcwreHF+LGgrT/u2MTlQc+X0mxwzp02dzQqwE8vqdEllSvDDnKCpf6oD/3tiN
	 DurEWDIfWrTf4yX80idaQHAoclBhCj5/lAZoeEe0Fmchm+OdYyeiKs+NfLsk0YwKFu
	 qpxriyGlxdasAbsmq4mdttpj9C9B7BGm1rNf1JooEmUQNq3Cdfos2KgYq6lyDMcX2k
	 QmRksXEf4rC6IQ/BTTbUVGsZmML+xIaU2Wp5RnnSGs5bqG8uNowNjMijp6vKXYr/ta
	 gAapOsQNuqJG4I77BFPsu6MtRIMVU9Es6jRtKAa0HUR67Nk9Ou5P/F5p9qW4zPYr4y
	 Vdcq+DnnMudnw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-277e6002b7dso1657182fac.1;
        Wed, 04 Sep 2024 05:33:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcc3UmdM2JU8mIfVUkCZWZ6Ull3BIuDXbTLwQth6Fc+C4Eem86GLcmN4uRGt9bqK7XrqjsEzegLlRNSy4=@vger.kernel.org, AJvYcCWmrSfzuZPLYe0VwsjO+xyxJXUqGvKCLyNhsyQgLiaJnBTjyjcDfgWaDDfpWXGzdEzlenvvan6isOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV15vz8HVdIKsHEvj3I47ihfjpgb6S4oVUEytTtag5rCBJS8B6
	1xRyIdeVhg39Wq+IV8oEmc/Y/0SliwIr8MoOfljGYPfrTS08S+MUZT/q0WO8SbwQmc4DsJK+Cmd
	tAKlK+tHXJIDCwF/hVYZ0VAjsrWQ=
X-Google-Smtp-Source: AGHT+IGU0sxnm3qPEJXMW7b58le6Sz6zJEsfDbYFrUu3U5GQqzrJJXRZV7t23N9424rvR6g9wQBMpRvdlUY9vBnlkxY=
X-Received: by 2002:a05:6870:3d8c:b0:270:1dab:64a9 with SMTP id
 586e51a60fabf-277c8055c7dmr14711515fac.14.1725453211209; Wed, 04 Sep 2024
 05:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825095353.7578-1-0xff07@gmail.com> <7ea23975329e4a22fd235cc28d365296fec47739.camel@linux.intel.com>
In-Reply-To: <7ea23975329e4a22fd235cc28d365296fec47739.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Sep 2024 14:33:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iW5_NcJ8wXQkuObw4nhJbViBim7uLiGz5PghMDKYybOw@mail.gmail.com>
Message-ID: <CAJZ5v0iW5_NcJ8wXQkuObw4nhJbViBim7uLiGz5PghMDKYybOw@mail.gmail.com>
Subject: Re: [PATCH] pm-graph: ignore sleepgraph.py artifacts
To: todd.e.brandt@linux.intel.com, "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, ricardo@marliere.net, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 10:49=E2=80=AFPM Todd Brandt
<todd.e.brandt@linux.intel.com> wrote:
>
> On Sun, 2024-08-25 at 17:53 +0800, Yo-Jung (Leo) Lin wrote:
> > By default, sleepgraph.py creates suspend-{date}-{time} directories
> > to store artifacts, or suspend-{date}-{time}-xN if the --multi option
> > is used. Ignore those directories by adding a .gitignore file.
> >
> > Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
> > ---
> >  tools/power/pm-graph/.gitignore | 3 +++
> >  1 file changed, 3 insertions(+)
> >  create mode 100644 tools/power/pm-graph/.gitignore
> >
> > diff --git a/tools/power/pm-graph/.gitignore b/tools/power/pm-
> > graph/.gitignore
> > new file mode 100644
> > index 000000000000..37762a8a06d6
> > --- /dev/null
> > +++ b/tools/power/pm-graph/.gitignore
> > @@ -0,0 +1,3 @@
> > +# sleepgraph.py artifacts
> > +suspend-[0-9]*-[0-9]*
> > +suspend-[0-9]*-[0-9]*-x[0-9]*
> This seems fine. If you run the tool inside the tools/power/pm-graph
> folder I can see how it would be annoying to have all those output
> directories show up in git status. (re-send with Acked-by)
>
> Acked-by: Todd Brandt <todd.e.brandt@linux.intel.com>

Applied as 6.12 material, thanks!

