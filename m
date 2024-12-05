Return-Path: <linux-pm+bounces-18634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 336909E5D01
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 18:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC13A1881E36
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D684A21D595;
	Thu,  5 Dec 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9R45A/j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0082EB1F;
	Thu,  5 Dec 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419481; cv=none; b=cuisJLaUcan5U2CR7PRkLOxniH17wHnqZ0GHp/3PjFqOH/Z3C6Z3lvaJabbWpHnnQkP6oIik4S5ZbKiv9F6xCUl8BBE2bmYJ3bgJIUrmBFRPaUEpCxllrjWdPJa/6+LkY3BSvG/KBEC96uRT1Djlt+H4hpP78a8xnktZZSPzhJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419481; c=relaxed/simple;
	bh=tLgBZc38dJzW7Rr8Wfgpk+YsydrUjmicWc03HHuWjzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzXP/Racyv6wkAmcrDInEcjrDmw2gs7n3wCF1nyMGXweBwvFd7H6lZ75lRcSXznsI9wGhipASp9joxNn/DGBCV4YC3D0Hmv8Zr4qTPJYLDWIj8xnHy0Mpr3LnOW0xNBPlndk+fSoAwUJMp+FtoG/WdledwJzpqVjA2t5eVoFtOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9R45A/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AECAC4CEE1;
	Thu,  5 Dec 2024 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733419481;
	bh=tLgBZc38dJzW7Rr8Wfgpk+YsydrUjmicWc03HHuWjzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V9R45A/jTPZW0ZGRo1nwAPyXIk/w59AIMC5jV8QEfY4/fm3zKUMNyMYuoHO73F7Az
	 ohxGSEI+iaH8MSCG93YLZjiQGXCpM+ZIiVw4LugSOl7QbJ7KsP92kf+PAm+0rc1x+4
	 a4E3uODyBQyZluKzTOzCIE12O7hPXu9V3p4n8AN3dv8VHqZ7j7EaQ7ZXjfxVzX2ud/
	 ggmuEi066mUfP1ZUBrC8fnUjkCmBbtM1daMltfPscYZrcN7S09yQWe1RgATHdEGoTF
	 E4yL9T4eKi8smOfBUxK5qqyXcgB6dprBmsqolhTTiqQPvE8OHhJoOzbygTM09e/Row
	 ULU+LFACatOQg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2689e7a941fso395076fac.3;
        Thu, 05 Dec 2024 09:24:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqrLYi1jOTCpqOJv+M9zI7wYVJD+zvHlTahhNrMqeRvLMsVZmDUsMypbpNu9sFqnVVHUz7AJ3i8Kw=@vger.kernel.org, AJvYcCV7eayjtg3m3QzLIRWl/AwInnYAzaffHoLJXS/39jHAMkYz2BRHDbcGWARNw5HuRHMVvQKyjWYO13h//8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXW12/C3esr3bvOQJD7MlzT10YEIKeEPTWarVsSLxYSYm/X4yi
	Iumwtu/M7ZqQivjAmbIuiNglAeePSVbyjAVRHOO+/QOSqqhSOhnd5wBOzCJlPxfmzmFu2M+lR/6
	1l2IFCLCp1hlr/Fgj3L/g9iaFlaQ=
X-Google-Smtp-Source: AGHT+IFZPb8cpGeot0dOVQk3lMKfuBZkvl8/ZKJwTqLXAD/tJFXfIcthG/sVlgF/YAsDkOLqGiNoXHYduV9uVBATXFY=
X-Received: by 2002:a05:6830:6208:b0:718:9ae5:9030 with SMTP id
 46e09a7af769-71dad6046e6mr7921633a34.4.1733419480417; Thu, 05 Dec 2024
 09:24:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08f3bd66d7fc8e218bb6958777f342786b2c3705.1731554471.git.len.brown@intel.com>
 <CAJZ5v0g1JwGRECd2JVKScWO9a=hmrY03YQx95JKZ+q5KisRb1w@mail.gmail.com> <f6621a09-d5e4-4d3b-9b5c-55294c22030f@rowland.harvard.edu>
In-Reply-To: <f6621a09-d5e4-4d3b-9b5c-55294c22030f@rowland.harvard.edu>
From: Len Brown <lenb@kernel.org>
Date: Thu, 5 Dec 2024 12:24:29 -0500
X-Gmail-Original-Message-ID: <CAJvTdKm-7LbbeRkLpTDW5WBLR9vVNzjNhYWeRvM+Y4myCHN6uQ@mail.gmail.com>
Message-ID: <CAJvTdKm-7LbbeRkLpTDW5WBLR9vVNzjNhYWeRvM+Y4myCHN6uQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] PM: sleep: Ignore device driver suspend()
 callback return values
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 10:09=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:

> > IMV, drivers returning errors from their suspend callbacks without a
> > sufficiently serious reason are kind of a problem.
>
> There is a least one driver whose suspend callback returns an error if
> the device is enabled for wakeup and a wakeup event occurs during the
> suspend procedure.  We don't want to ignore those races.

That driver should invoke pm_system_wakeup() on that wakeup event, right?

Len Brown, Intel Open Source Technology Center

