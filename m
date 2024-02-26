Return-Path: <linux-pm+bounces-4397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED43866FFF
	for <lists+linux-pm@lfdr.de>; Mon, 26 Feb 2024 11:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AF91C25AEF
	for <lists+linux-pm@lfdr.de>; Mon, 26 Feb 2024 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F584612F6;
	Mon, 26 Feb 2024 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R1VtCByz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB0612EC
	for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940752; cv=none; b=FGaPR7kqXF90tOHeI3hjiMk4BAzeTqWHogG9Oohg1c6gjA33p+S799p8+xQiAW9ee9tCH10ugFPmT+jciDaXTNDXGW1LAJ26SdgDCiOHwWqwZ9Rj8m2zGgMXU7GjrY5DQBdFwdem9V03HCAqOCI9Itqj+51/pF/tPctSoEEOeOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940752; c=relaxed/simple;
	bh=uJT54+Njg4WM6tIO47QUf0ooA5zNNfMnXfBEFJz87qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P72Nfnr8+zcs0DikRY3MN73HQeHwnfaMXQPo70WGRutaZ0M/ccpIbj0aMJkHsON3hLJ5hSTLS4jzs31RrSxG1UZsP/SVtiww8sGpZV9hpE8956BbJEjMp4jcRbMJ+0NCKNV3oue9UhOErnh8yw+T21ggp50Qsv/Y8LNfZWGnpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R1VtCByz; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56619428c41so1056a12.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 01:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708940749; x=1709545549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZT3jK5Gj1aIKjYSj7Fjltcf1HIECW9YIZ/DXJQ0Ddc=;
        b=R1VtCByz7ztvNaxHc7Z1C72vh+nm4OhBO6QLuN5znmYYd7p5LJPUpznHapy2TG2lDZ
         NX3Kjiso4YNd4AXrd1yurCu+SjIHmkO5fmLrBWRWu8y+dttfLq7JP4NscXpYk0tOHhub
         UBwUPQjGPaEfanuY+I0QyG7/rX8ydEMrUsg2x6AjHkPWdAQ8oPmIcpl0BG8GRUVuPN6C
         IUYwVBrNtZi9P+8TphdJLLSELA/ZQzXd7OFzADy7BJHGDei/roX3tAK0Epqe+vLCoyyG
         OYbrMhj/u4GrjE4NxGXVIJukPI86Wqn/SkydtQp7X5/fVf+lWscKuPkf6XGu/jKfwFqi
         ++EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940749; x=1709545549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZT3jK5Gj1aIKjYSj7Fjltcf1HIECW9YIZ/DXJQ0Ddc=;
        b=Wbh7h8XXByZrpxNh5SbSON1+ZxNVNPwTR8i4P6okkqP1v3GJKhNjguYDuoSRzqoY+D
         htlXX+cSRRoLGE1suMqJ2EFJuWmZRGoCHx4lZPJ0itJZp0N6P+5CQ0FqjAatG9oulPbz
         ORoFbSJhf3rtN5KP1IzegCg+gfWL8jffgEvBlDeVw6j1zHjUwJzNJ6xgZPKSA0skuyg3
         i3jiyb60X04P2ze4V6dOC4P1jbt8uro5lL5SZfoVrkKMjeDabeCJMI1Ar+DZCO6dqA/D
         rh5FMpZ8suaPY50C2haXzw/ic2qenkwjwC4PjYZs9E8BReYnXnr6hl8YXkauY2wMwOYD
         eeLw==
X-Forwarded-Encrypted: i=1; AJvYcCVjNJLIU8ogAIzzCkw9R5X0AShb9Jj7PZfnfdI1Cm+u10fLIPENFIx3OrfqEBRwBDTOrkXSGnBXGkcJdeh12N+hlBtifVuDxaw=
X-Gm-Message-State: AOJu0Yz+/5R8VBOrnVzrLZbvcAOKizMK0tHO7N+/IaT9dy/qOziY22Vb
	YZk1YV5IPw0GtNhpa/l9ynxQyNOt99+NZnwYJJR9OoWfoY5YT0kg2aHVrkNOShp8NUEUv8uGaxK
	k9ZYJK02DXItp7gjJzkxVXxAX9cbnZX+nuYPv
X-Google-Smtp-Source: AGHT+IGw7zA63B11yii8IK4JQCFm9+V9/xg0w78cK7iNkrNIe8WNKE/5M0T7SENyqjOzsmxXUWuOc4+TZu0jmTSQldE=
X-Received: by 2002:a50:9f28:0:b0:562:9d2:8857 with SMTP id
 b37-20020a509f28000000b0056209d28857mr268773edf.6.1708940748588; Mon, 26 Feb
 2024 01:45:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143833.1509961-1-guanyulin@google.com> <CAJZ5v0gM=0rU6a1A6Bh2Ed=4=1AtQ3p5aDJVCOioA6qxGv1jtQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gM=0rU6a1A6Bh2Ed=4=1AtQ3p5aDJVCOioA6qxGv1jtQ@mail.gmail.com>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Mon, 26 Feb 2024 17:45:00 +0800
Message-ID: <CAOuDEK1NdFSZgy8_ebO_zSxbU-gLJHsCzjd6JSr2cckQAFgaTg@mail.gmail.com>
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com, 
	rdunlap@infradead.org, james@equiv.tech, broonie@kernel.org, 
	james.clark@arm.com, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 1:44=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Feb 23, 2024 at 3:38=E2=80=AFPM Guan-Yu Lin <guanyulin@google.com=
> wrote:
> >
> > In systems with a main processor and a co-processor, asynchronous
> > controller management can lead to conflicts.  One example is the main
> > processor attempting to suspend a device while the co-processor is
> > actively using it. To address this, we introduce a new sysfs entry
> > called "conditional_skip". This entry allows the system to selectively
> > skip certain device power management state transitions. To use this
> > feature, set the value in "conditional_skip" to indicate the type of
> > state transition you want to avoid.  Please review /Documentation/ABI/
> > testing/sysfs-devices-power for more detailed information.
> >
> > Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
>
> Please explain how this is intended to work.  That is, what exactly
> you expect to happen when the new attribute is set.

The sysfs entry 'conditional_skip' for a device indicates which power
transitions (e.g. PM_EVENT_SUSPEND) are omitted within the system
power management flow. During the processing of an identified power
transition, the device's power.entry will not be added to the
dpm_prepared_list, preventing the device from undergoing that
transition. As 'conditional_skip' is modifiable at runtime, a device's
participation in system power management can be dynamically enabled or
disabled.

