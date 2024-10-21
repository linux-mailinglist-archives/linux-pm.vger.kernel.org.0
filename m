Return-Path: <linux-pm+bounces-16077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5429A65EF
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF1B2824D5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E561E47A6;
	Mon, 21 Oct 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pATrULGT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42539FD6;
	Mon, 21 Oct 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508929; cv=none; b=m5wAP9s9pgTo+jG0bKnOf6KgtRikNIl4pfGLxsBzkpJ44VlZ2SqhwJiFyiyRBD64Dbc8jjkXo0DHbfmkCjcFTh0TRTcZIzsHfxUShPZz67VsrWkyYTNUdQiNhDEjRi6tuIN9h9fcDoX9TUSYIbKhFqHLVQy7zsJQa1a5CpbO31g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508929; c=relaxed/simple;
	bh=OF3YQJNOHAwOJ4wqBRrTi+APrTW81rts9A+uLky2rEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5VEk4KADl7oyMETuxgBwYHJrFBNMXZrDa31GLWBO6d2qTvkUaTqFj0qQRWTRgLNP+pinDEm97XxTfxvmv+VkPEsx7qstjMgEWGKs/VyMyT/Qza43jlanV/Lyfxu3WVzY9NqIGl7G+gNpwKHgsr6pOMJws0R9oMtSk/S8jllJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pATrULGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CF8C4CEE5;
	Mon, 21 Oct 2024 11:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729508928;
	bh=OF3YQJNOHAwOJ4wqBRrTi+APrTW81rts9A+uLky2rEc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pATrULGTWNBa19h4o7C3Vug2LQHhRwR7L8Fpmb6j6gxjuaTeAPCR8bfDdybHFButi
	 CEq87ulCx4RoupmNAVNZlMQo+Z07bQ8zTpucmMU34aVmJbbSsL+glVXCR4xVGQwL+6
	 9i2iVQetTLjhVp8Mu2uotYjsyAMSzmfdxZbE3xezv1MCvAJQWtna+jVkMpaQyv2D/k
	 at1oeUkKtfPsXd51i3iL/PeYBjr1vhOS3LlDPRg1H2wP6+xg/ikWuuko/u0sDiXyVl
	 cEoSXzDNq0khqB6N4qwXhK04rG+qoMGHKqKn1+PFxl0OoVLwyQ/6U7FmuD0amkXh76
	 lLm5SOjUkC/yQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-277e6002b7dso1488067fac.1;
        Mon, 21 Oct 2024 04:08:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YymBXTxPlz415c2BdiAzjFO6Rhf5tJEm3XwPh/xow4CvIYt0Kdq
	tZkOuPmWTuPMpFh1FBYUk7WWWGEbjpdZ4yffb0bA4Teqg19qa9NfaI6tAvsL/fTxxm9wdxf4iNK
	0Ahdb8jcWsF8Ab1Ol+fneAeQRea4=
X-Google-Smtp-Source: AGHT+IGCO5f9yRRu4pJKjmgHVZZjES9ccAyz/6MdgSiSg296qJ+sZcEddd75nEC0iUqja4+ve6sHG0f2916xoUn8gr0=
X-Received: by 2002:a05:6870:80c8:b0:270:1352:6c10 with SMTP id
 586e51a60fabf-2892c5435d9mr8965609fac.37.1729508927935; Mon, 21 Oct 2024
 04:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4985597.31r3eYUQgx@rjwysocki.net> <CAJZ5v0iV4-3-sqmK12ZoRQXzUSgO0NDySe5LZ3z7FMQOFJCymQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iV4-3-sqmK12ZoRQXzUSgO0NDySe5LZ3z7FMQOFJCymQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 13:08:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hHFp+FROxs_NbyjA8_ODKmiirFrdJNhGiHYvDMjZ2h3A@mail.gmail.com>
Message-ID: <CAJZ5v0hHFp+FROxs_NbyjA8_ODKmiirFrdJNhGiHYvDMjZ2h3A@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] thermal: core: Reimplement locking through guards
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 8:51=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Oct 11, 2024 at 12:22=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki=
.net> wrote:
> >
> > Hi Everyone,
> >
> > This is a continuation of
> >
> > https://lore.kernel.org/linux-pm/2215082.irdbgypaU6@rjwysocki.net/
> >
> > and (quite obviously) it is based on that series.
> >
> > The majority of the patches in it are new iterations of patches include=
d in
> >
> > https://lore.kernel.org/linux-pm/6100907.lOV4Wx5bFT@rjwysocki.net/
> >
> > and there is one new patch ([02/11]).
> >
> > All of these patches are related to locking, but some of them are prepa=
ratory.
> >
> > The series as a whole introduces guards for thermal zones and cooling d=
evices
> > and uses them to re-implement locking in the thermal core.  It also use=
s mutex
> > guards for thermal_list_lock and thermal_governor_lock locking.
> >
> > As usual, the details are described by the individual patch changelogs.
>
> This material is now present in the thermal-core-experimental branch
> in linux-pm.git.

I gather that it is not controversial as it was covered in the PM+TC
session at the LPC and it has been around for quite a while, so I've
just queued it up for 6.13.

