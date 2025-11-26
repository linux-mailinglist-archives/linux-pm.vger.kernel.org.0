Return-Path: <linux-pm+bounces-38748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B313C8BE2B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 21:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36CAC3595E7
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 20:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94373148BD;
	Wed, 26 Nov 2025 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rr3M4MRu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F17816DEB0
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764189462; cv=none; b=dE9HGB/yTyEv3vJVKX5GWc/PyARYSDsnJ4PPGaU7JPtTXaV5FuGJk0zJJWFWn1a2u28WiXEAuVJrPj4ZHTSfbUA3DQOliFoe0ZEvsSE3zBSv08CDQBqZZg/+P9KI2ggyj7zVSjl4YJ8IbxIazMSLV4VLix/0VScWKTBO5zPXnUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764189462; c=relaxed/simple;
	bh=PFiWrutATp6P0FHVQlvzD7mpXHMY/83LGzVu2Q3rIbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7Qzxf5W5utL76gcuiBkrL+gBrLHSGSxcVcgQd/6cEhiGUrMUj3sAc9cCSnt0lSpf7BQ8Hg36k++VRq8j9uW970sptMfvJoFs5FAwcipse9U7rfmY626Jvra8eVr33ZGZgLG2YZoAFCPBp9fXMGFOV0eaTzhM7PS5Y5p+apdpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rr3M4MRu; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so344715a12.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 12:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764189459; x=1764794259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=moKsNVBhCEiWpG7LYSwgh2lfK1TAqbPDg67fuqnbbN4=;
        b=Rr3M4MRuYZqaAXU5UWBaDEUKy9rv52yCDlvCSB44XvhOfHTrqQoaD4R/rS6nClPO8b
         hY5K3iiNxGayR67BJs6pc4mZnMQ8c1X4RJspjuF8lD2+YMORSbu81ORLK+1E33l+7Mmz
         inQGv9falHdUb6ycN575/YmcTE1st8IGfcY8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764189459; x=1764794259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moKsNVBhCEiWpG7LYSwgh2lfK1TAqbPDg67fuqnbbN4=;
        b=fdjWPC+0XALtpF1V19FA+TC1hkAMNCI+sxsEn+zAkZJ4WhhYeybwaZ0eSu4FwjiXa5
         oDDFFceyXUPTnqFrL3v8cyGSpKCWblsDya8aqeMjpu/dZFB8eoMX0zFfAglDznaNyDT/
         S5fChxv8ccvm6P1h03rrZTCsaYPgP6deupBKEYkWw6IqTBwHYwEDNG1+SvLk+3u4Vy29
         ESlmX11x32IU3r5O0fHD2gW5uDqqbtScZ/C4aPeDi3X0OmkFQot+KedE/7Ss33cOjLls
         TQfSE4Gn4fe8CVQwaFWyl9+0kG48RpvBdC6jdHIZb2dguJdKrgs4fYFNX0BmlnWJ8zMp
         fPjg==
X-Forwarded-Encrypted: i=1; AJvYcCX4lwhITPiAR/5rnFup9xJP/FZtVsVBDQoqcRpzXpRYqkIyxlvSvddMVVRwTUWLLEhdwibGvZxGYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTMAMSc1aOu++3eYRO60KTP9/6N2Mk22AFrThSJWgjXICW2xp
	UkCPM0Owh9q1wObXiiYgvqMjIUQBEjR/HR974Gq7C7tkaCpNV4hDSLPQnAD+A6Y6P8AmFM/HAhe
	lcA0svpaz3g==
X-Gm-Gg: ASbGnctz+Uf18UeEjiBIwe86pWn0xG7nct6CVqDvVrNA1CsTyVeK8NLN4Tnsmtoh+DA
	6xetwwfMyZz8/Cia4K6iocDhr47+Savcg9X6W5VvTqpwYz8TKjyixV7gsOB4AW9C4It7EJPKCC/
	Js69U413xZ+m4IPdK8zynnVZEkj5w+ymygje7eXDX1IhS3Zar/hyZSvbfWY1KWIf9M42qU5eexW
	VaRVDDjR2JuDK9FXe7/QbAIZQipX1OhgScSpA0GS9uZ+mgn/u6DdeiUfPEYy29q5kBTOLhqzS9Q
	tc6SX2AjTncpxuMPaVvkDt9z5IVWd77x6R8r46RUciWwDGBUsxu9K15EYKvd8w6HxO9aUlpgbTK
	xSZlZSDKizHeF48k201fLBZ5XrejJk1SXRODgk1jLc2QkEJBc8tWYwoLFh8WgJrOc02KcuZq9Cn
	xdSI06xqlHwB9pt5crVPr9ZixxkTQPh0MSrX5uoYgTPRcPhBJtqQD0d3t2rmVV
X-Google-Smtp-Source: AGHT+IFU237/DtdSIqhumMiw5QUeAv+wGtBcammmox/Bs7wkOdVJpwnBRhByViaA37KnXs7eTTyJ/w==
X-Received: by 2002:a17:907:9711:b0:b46:6718:3f20 with SMTP id a640c23a62f3a-b76718cfde7mr2171700466b.48.1764189458754;
        Wed, 26 Nov 2025 12:37:38 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d80665sm1924279266b.31.2025.11.26.12.37.37
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 12:37:37 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so395803a12.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 12:37:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLi6fsMyQzlSqSZY/hWTZwaEnIUM4kuwRLVzCkBBSIwpTWvkzcUZO/IOno4H3RIdYGyP2WmBG51Q==@vger.kernel.org
X-Received: by 2002:a05:6402:5247:b0:640:74f5:d9f6 with SMTP id
 4fb4d7f45d1cf-64555ce8d37mr17453523a12.25.1764189457254; Wed, 26 Nov 2025
 12:37:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiFS7=wrjCoEguQUqwd=L4tJHNP8mCdagg0FR8NQTGLtw@mail.gmail.com>
 <0e90cb97-c0bc-48a9-92ec-2493e89ce6d5@roeck-us.net>
In-Reply-To: <0e90cb97-c0bc-48a9-92ec-2493e89ce6d5@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Nov 2025 12:37:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj0coxhdnHMvhKAGfEy3AMgk+BX2n=Qvemt0Z=ZxsM8+A@mail.gmail.com>
X-Gm-Features: AWmQ_bmgtSVKgHiEgvIR8ul7mWuAcW57LhzM1HeBFs8R9gV6zusRuhgTVAkMtdg
Message-ID: <CAHk-=wj0coxhdnHMvhKAGfEy3AMgk+BX2n=Qvemt0Z=ZxsM8+A@mail.gmail.com>
Subject: Re: Linux 6.18-rc7
To: Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Nov 2025 at 15:49, Guenter Roeck <linux@roeck-us.net> wrote:
>
> i386:allyesconfig still suffers from
>
> Building i386:allyesconfig ... failed

Bah. I'll give up on waiting for proper channels, and am just fixing
this myself.

The code looks wrong anyway, since it seems to round to usecs at the
wrong point, causing *two* of those divides.

And if my untested fix - at least it builds for me now - causes
problems, I'll just mark that driver broken. It may be new, but
doesn't seem to be maintained: this build issue has been going on for
way too long.

             Linus

