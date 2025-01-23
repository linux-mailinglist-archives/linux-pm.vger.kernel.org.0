Return-Path: <linux-pm+bounces-20886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE08A1A832
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 17:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F88188BFB4
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAABD145B03;
	Thu, 23 Jan 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfjN55IM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5781448E4;
	Thu, 23 Jan 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651279; cv=none; b=baMKreZA041cky2XK4/Odq+YlNvOclzrABJr7902HzNeECigNiCYO52vC0ZYn1WgGE9H315ft1f+mq+LgnP9cc6xqEeI1/XNwQk48I4csdZMs5z7b34qiuVH/3783zYsbXY3Q/8amFpArrsHtZ2Vjnchl28S3jZtHZZHUQ1gl/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651279; c=relaxed/simple;
	bh=Hid7Db26fqZnQOvVyvaxAJUgkDlopTQak0m7RywXNiE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fPzsWgR2NzVT4sfwHA8KO0odcYc8RFcaF0qmI9uwD4mLX3vqb6QIxk13cezUD0tkDbiaA9u1C7OzNJfaXuVv42D6ytFVLHqvESObYyuTugsGhRTpHSkHz7EcKGKPjxbKQpaRIqRpAbQGIwg1TnGe4L/paBg2XV5vCNWcGL1BbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfjN55IM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa68b513abcso252668066b.0;
        Thu, 23 Jan 2025 08:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737651276; x=1738256076; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hid7Db26fqZnQOvVyvaxAJUgkDlopTQak0m7RywXNiE=;
        b=AfjN55IMfxp+sXcaDBSeLTGMZFavLY1ERGps1napf3nrNdJXINfyYEQkehcXE/5Msy
         sA6aTavV5B06YwthUbozyVZblLwSYF6I0TfHIJxi+abkqtlfrnytZUxILd4FwtWCHLdR
         EajA/lsIhS8rPdALSyWoM6YrutB87U+1xqYjFJGHECgXlaX6KOnoUlnHvufScidhPdjw
         oupYvimqfs7734KVLd/cnjRTEU8Xk9NIhnerzKNxUGSTHCO8Aan4yf/fAbVEDzwWI5n8
         EGFcOzg+CAWhLRHQocLIXoUfBvoevNb4/8XI3n34ghWvoj0i85pH75HV5svEoXG3SnTm
         jFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737651276; x=1738256076;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hid7Db26fqZnQOvVyvaxAJUgkDlopTQak0m7RywXNiE=;
        b=bigQlblIv5Kw0eyrE4HrOQDAs2wOZBXkNXDME3Lelka5TzwK8T0uzsQp4N4e3D3iS1
         IBp+uQ8rI0iBMI+pUI4wpSbFd+FrUZUvuC+mET+HuXGoot5+86ttGNXSeUS+ZJ8udtw3
         AJzMIdyOwYhxIPRe1mVjf1lt+4m0ojHBiQ9P1v07YR6v2Q5RCLSqW9rqjCR1E8c/nQZP
         Aq3UqJuxVk2RmaP952p8DiTffDXb37pKKv8oW36EP/ix79UPC0TfL+BvS4D9Lg6d8fnA
         KdlJQwxB24aXBuzAcpjpyqg7X4pLlx9rYusybAVpJnxJitti2W6eddGkQlXBmJ3E6Zal
         ctcw==
X-Forwarded-Encrypted: i=1; AJvYcCX6qx5LW/nUo2dqEh8DjDAIvVyghe8UGJ+YIO6DVeojAaSY3b4tIW9MGUGNcGNIJ+v0uNWH6Q+f7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyykNT99aQ90Q3iVx+4YWP/qvGOsVpRdkYUwJYdFh5bg2uOB+pH
	GAEVzNAXgQIBzQj3MDgDs2zV3ol2Wgj+s90ZgOJpN4oeXSmr3WcgQQg7mlma
X-Gm-Gg: ASbGncsOdlKzpIgk/DzAHQylBOa9ITdsBpnZywlgzCQVuKSkly7cI8EIeP+AJDg0zzK
	c/U8xK6QIOKhpZ5Vsk/LKWM1Waci2tdW0ZVWzXAauxo1NboIfOWmj8PiITz4Gfa8/C8eJwld5s2
	HD41UW3f7OTM8hudU0yEoxvKYqmKKWZldqJyjObmAI+304OS2wTkTNQXIZEqDdDOHIGYjpiGIu2
	0GAId4Uvsaj60lJdv1M0sgS87t+RAocQzyFhRWxyUZLPtD85eEIRyUWs4oMiDbTggIoco+bSndR
	73N8uT2INNqc5CSKY4izv+nIBQ6vekuS8g==
X-Google-Smtp-Source: AGHT+IGUksJTb/THBST8sKvAFpMGgn5XesTEt8kzLThKIh+O6GxD6jp+NRFVKBR3F0/SM4lB35rweQ==
X-Received: by 2002:a17:907:7eaa:b0:aac:4324:977e with SMTP id a640c23a62f3a-ab38b163018mr2876703066b.27.1737651275933;
        Thu, 23 Jan 2025 08:54:35 -0800 (PST)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f8d86esm1097364766b.154.2025.01.23.08.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 08:54:35 -0800 (PST)
Message-ID: <00fffcc11f41ffd069c499010e89244d4ccb6cec.camel@gmail.com>
Subject: Re: [PATCH v1 1/4] cpuidle: teo: Add polling flag check to early
 return path
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Aboorva Devarajan
 <aboorvad@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano
	 <daniel.lezcano@linaro.org>
Date: Thu, 23 Jan 2025 18:54:33 +0200
In-Reply-To: <842b1500-9f4f-47e5-9777-ee89351f956e@arm.com>
References: <4953183.GXAFRqVoOG@rjwysocki.net>
	 <13679187.uLZWGnKmhe@rjwysocki.net>
	 <842b1500-9f4f-47e5-9777-ee89351f956e@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-10 at 13:16 +0000, Christian Loehle wrote:
> This would then enable intercept-detection only for <50% of the time,
> another option is to not allow intercepts selecting a polling state, but
> there were recent complaints about this exact behavior from Aboorva (+TO)=
.
> They don't have a low-latency non-polling state.

What folks think about the following idea.

Idle governor algorithm essentially predicts the sleep time (step 1), based=
 on
that, the idle state gets selected (step 2).

What if we add a sleep time factor and expose it via sysfs. The predicted s=
leep
time would be multiplied by the factor (between steps 1 and 2).

Default factor value is 1 (or 100%). If users want teo be more hesitant
selecting deeper idle states, they can set it to 0.5 (or 50%) or some other
value < 1. I users want teo to be more enthusiastic about selecting deeper =
idle
states, they set the factor to a value > 1.

We could expose it via sysfs and allow changing in some reasonable range.

The idea is to let users adjust the level of idle governor (teo in this cas=
e)
enthusiasm regarding deep C-state.

Thanks,
Artem.

