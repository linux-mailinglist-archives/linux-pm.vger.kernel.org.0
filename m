Return-Path: <linux-pm+bounces-35304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722E2B9BD52
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 22:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5263AEA33
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 20:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55E32857D;
	Wed, 24 Sep 2025 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl1cBxGL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC742328576
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745071; cv=none; b=mIBrSSh7SbnMhqoaNLJX6ueudqtEvZchc9r9gktcfdsc7bP7W/Qw7hGv9prGS4348ZluXe/0yi7HkAP8BXQbxKhjho9dcqM/e9PGne5qdgb/d/2YsOpSyNbF6gnVRTZa15qIUjdoGFtAwxA69NQMuVV0o7uNEMnSuaDQbZ55r24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745071; c=relaxed/simple;
	bh=87PpMdhKz4da+xy5/E826ZZFF9DIRJqOQ7VddMx3ig0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQm0clCY20tztvBuGdFe46hR1fxzFOz39LB2rVyntTWtGa7dZatiABZ9C/59rkmkwILbbKcJr5Q6JltEKV37jfoevhShCaiETlVDiEBav5qYjFfiLbjKMo+6ycxd2Ii4AW2kYL7rjTbsUbpzlsjQirCacmuIIx0KwdZrLHyQyN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl1cBxGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871A2C4CEF4
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 20:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758745071;
	bh=87PpMdhKz4da+xy5/E826ZZFF9DIRJqOQ7VddMx3ig0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yl1cBxGL2pw9yOMixoVnf7y1DArd74x+TMTTh7agOKoksCpwsqIOOfev5E+GmHKFm
	 /bsUcOS6QAGMSWCLGjfbuJ4pDw5whmQYEPVewY9o3DrqCBqwlfKagmsbfNdqlXDYcv
	 +Xa8QXSvP848R7ed1Gqp5EJvhCeRFaCgXIRCYXSIk23im0N+dIrt8pPnz8fu8Vepxe
	 c+/AbIeWrOLEi9+huEQyyzqNZpkKxRqDhh8Ll3X92+aIZj4Q8w17ycBNZtwXOFWZ6C
	 ugv9L+adMCG2V8IXZtdrw9hzV1s/CvXa8hMsOmHpr1AQJhnI0/7P59Avz3ucx5JZ8f
	 Nbd0dTw1a1fmw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6218fc7c6b7so58918eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 13:17:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9jsYV4wVTQMLwiMMbvS8ht1X8Z9s5fupNl+zEqq4+AQ6V3sFTFIGgjzXshPg/gYzP28IJAq9/WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Ee6Iqi9jOkELq5n8VvGAEylgR4os8zx0LD0TVaVYnn2fpVTd
	3K4UR6lH5t8NZK/fa/Us8ohLtTIyirtvLJ/qUSJhrFvMjjz+vAkKBDwJfZD0vkm+Dh972wqzK3i
	dituArnN8AbEbCgHlaac8RFuaKSYqmJY=
X-Google-Smtp-Source: AGHT+IHK/rT9LaKq4Op3qK5AtbzD/0aTqXSDsBghtMhmZ+izMQjP+v45O7plShVAaGwV6VcU2Eu0TFLt0ndLHXuWZaU=
X-Received: by 2002:a05:6820:220f:b0:624:f051:dcd9 with SMTP id
 006d021491bc7-63a299e8384mr489709eaf.0.1758745070874; Wed, 24 Sep 2025
 13:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923150625.1.If11a14e33d578369db48d678395d0323bdb01915@changeid>
 <20250924052846.vaoehgsrj5ejanhg@lcpd911>
In-Reply-To: <20250924052846.vaoehgsrj5ejanhg@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Sep 2025 22:17:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hMMK+42RALk7yZUnyHwOYcRrmen7tLortcORS+A3nMWw@mail.gmail.com>
X-Gm-Features: AS18NWBEtOwwOTKsVXwk1xFFVUoajeGugPjONQTYd6PnKqzNAiTR5feiTvwA-hI
Message-ID: <CAJZ5v0hMMK+42RALk7yZUnyHwOYcRrmen7tLortcORS+A3nMWw@mail.gmail.com>
Subject: Re: [PATCH] ABI: sysfs-devices-power: Document time units for *_time
To: Dhruva Gole <d-gole@ti.com>, Brian Norris <briannorris@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arjan van de Ven <arjan@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 7:28=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> On Sep 23, 2025 at 15:06:26 -0700, Brian Norris wrote:
> > Many .../power/... time-related attributes have an "_ms" suffix and als=
o
> > include language in their ABI description to make clear that their time
> > is measured in milliseconds. 'runtime_suspended_time' and
> > 'runtime_active_time' have neither, and it takes me a nontrivial amount
> > of time to poke through the source to confirm that they are also
> > measured in milliseconds.
> >
> > Update the doc with "millisecond" units.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Applied as 6.18 material under an adjusted subject and with a slightly
edited changelog.

Thanks!

