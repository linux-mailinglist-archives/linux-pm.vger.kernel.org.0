Return-Path: <linux-pm+bounces-22543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79013A3DA6F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 13:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6113317EC78
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 12:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812211F5836;
	Thu, 20 Feb 2025 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4jCKz9g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67D6134B0;
	Thu, 20 Feb 2025 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055852; cv=none; b=ASK+QlVRB55dU9kdW65TKJ2Ufgw9CfHu190lOJ/543AM0+2bcHudq/+jNUGlPfi41s4eUfZXqqCzNLneRq3Ul8VJfj3Fi5fgfwzzeSfh4pojyXhACfutCrg0oyXatsQN8eYzY+9Ks6q1jVgBVSwZ0pFNXeS4Zq0TnTJCV9GVas8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055852; c=relaxed/simple;
	bh=5CdqDe6a+TgCmrvpY0A7LzJCD1blyf0ZlG7AQjJyN4E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XwJ7+IwSEZk+RaDEgJpwHz+5I2wb+dTCmlcIIa8ZWjpSooxE9mfG8/47vAkWA0PSVSEgr+1G4CLn4bXTWjja2D2czcZLSNMCA4EeMGAm7z+G77sUYkppYhEb3mupFMFjl89Ux8DuK6fm1tkrjodFC8+V4TQ7nSDAJYceKmLOZJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4jCKz9g; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e050b1491eso3557655a12.0;
        Thu, 20 Feb 2025 04:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740055849; x=1740660649; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CdqDe6a+TgCmrvpY0A7LzJCD1blyf0ZlG7AQjJyN4E=;
        b=a4jCKz9g4DtMxh2XdqyZo1+IrgkwVuuM/SZk7M29dl2e7Iypu5gN8z6zwmftrZWerY
         D9StLxWTSkN9pi9c2ZDgBpFI8WVBj5qzyKu9h9/AOFiyU9HFlnUC1mpjEmMjSM9BKhjE
         BePuqA6DKi0lN74SiVRwyJVqcsPH9y+C46kuu2SNu1d8C0OiGJoFP3eKq1PtlWlqpP4F
         V46VLUkOZ/DSDyTpLw9kfO1iEsVfVcd0WFXgshLr1JNUqmiYgrBz+wA15ke+8AURrS6N
         F+CUN9al8JvIsEevuw0TQhUT3dCmK96i06+emmgzUTpNCcWlRGtH910iI0sKK9B73N9w
         HPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740055849; x=1740660649;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CdqDe6a+TgCmrvpY0A7LzJCD1blyf0ZlG7AQjJyN4E=;
        b=omFuU7uJZEJUOAZkxUtQc/eXQKwa60nQnS4f1nOAd6uA0fj8GyhW+GlEzJO2+I+dkd
         n8N1OtTs1Jj1EAyu8QYOzviGYBTaupgU69fAXqWxVw3sx5IMQBxH7Pu+XGKr7WHBWF14
         bBs+qUHWuIpzvK4yvv3Jexv0eGpYvKMg29qVzUuRz1Q9coDMrNNRuKZUNNJ84qyYc4Ei
         1+YiZsTmHvsgMb7ryV+pCHuyXVbXpjpdaxP75tzxYCn2tz4FuYk1Q2lMj2ybO0CNloUx
         IWUJ0FqTw+fn3+tO+KCBRRiRnlbR9gYMlWTPfn08R59cBPrZtsJUbJ1JbFlf8k+TjLx2
         b3QA==
X-Forwarded-Encrypted: i=1; AJvYcCUzEt3D/ERx0MGQa7pCbY5UT9nRqACsprR5+vbfZIYubqE3C8Q469gzcV+jnAtPoWACKB47evgQMK4yJiyw@vger.kernel.org, AJvYcCX333zdNLfySwDlg6l67jwxBApq4Fe2hGzcwZj6MoktBY8OUqtyIbBslhcyjknkLg6lkPXwe2ib6Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOLxcrODnGYeoa7AY+OTretRfwI1FoTEy4/17sewcCJ54K5/3n
	AUuhLxa2vEpYUFgoFnHvMj00b6Xrz9I0JQUzhto+WvjjaJ14pJNgyMNIn/zoE7A=
X-Gm-Gg: ASbGncuXWAeoY38ZQRryfqbtREUhDkUIWtBrubvVtBAYvNpzhCC0zsJp85v4FAhmnrV
	SUau47r6GIm5sNN59v2Pvl9vpwdXdcqPR9Jb0SKkK+USgzd2qPh7hJ9CEWrtvLiKhRDAQfg6PHG
	YgVoywIPzBuzIZ0X1C+EcNRNY6jJQ1urvXSwOQVQbw3MmsPrqAIGraGk/ztiyL9gaIOdhjgx1BU
	3DcVNnAbN1zRWOdB1zDQK4EgRdObnr+dOhU2AOaC1dK/OjPZAhNT9meNoRgkLb/bfxRR9ZUd+1y
	sbqzNyC3hFAiGJygUTOSrIcKz/TNt5W3mU+VjEFkQhfRaw==
X-Google-Smtp-Source: AGHT+IHtm/rvi3VIjBkWuIExSB85ST7i+4B0cXT1pvysb3E5JpPYV5QDujzd5YmocYgA3XX2V8kIRQ==
X-Received: by 2002:a17:907:d109:b0:ab3:3b92:8ca5 with SMTP id a640c23a62f3a-abbeddc5984mr305310166b.12.1740055848569;
        Thu, 20 Feb 2025 04:50:48 -0800 (PST)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8eea4d65sm874370366b.161.2025.02.20.04.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 04:50:47 -0800 (PST)
Message-ID: <9b67088de0b6a24a67cfe0a1860011d290307c08.camel@gmail.com>
Subject: Re: [PATCH v4] intel_idle: introduce 'no_native' module parameter
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: "Rafael J. Wysocki" <rafael@kernel.org>, David Arcari
 <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, Prarit
 Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2025 14:50:44 +0200
In-Reply-To: <CAJZ5v0g27Sutp_Ww7zGe0xB95kxFh-pzjd5-PpjR==h7-s8MLA@mail.gmail.com>
References: <20250128141139.2033088-1-darcari@redhat.com>
	 <20250213160741.445351-1-darcari@redhat.com>
	 <CAJZ5v0g27Sutp_Ww7zGe0xB95kxFh-pzjd5-PpjR==h7-s8MLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 20:57 +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 13, 2025 at 5:07=E2=80=AFPM David Arcari <darcari@redhat.com>=
 wrote:
> >=20
> > Since commit 18734958e9bf ("intel_idle: Use ACPI _CST for processor mod=
els
> > without C-state tables") the intel_idle driver has had the ability to u=
se
> > the ACPI _CST to populate C-states when the processor model is not
> > recognized. However, even when the processor model is recognized (nativ=
e
> > mode) there are cases where it is useful to make the driver ignore the =
per
> > cpu idle states in lieu of ACPI C-states (such as specific application
> > performance). Add the 'no_native' module parameter to provide this
> > functionality.
> >=20
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: David Arcari <darcari@redhat.com>
> > Cc: Artem Bityutskiy <dedekind1@gmail.com>
> > Cc: Prarit Bhargava <prarit@redhat.com>
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: David Arcari <darcari@redhat.com>
> > ---
> > v4: fix !CONFIG_ACPI_PROCESSOR_CSTATE compilation issue
>=20
> Artem, have all of your comments been addressed in this version?

Hi, I was away for few days. Yes, this patch looks good to me. Works, and
useful. Granted your comment is also addressed:

Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

