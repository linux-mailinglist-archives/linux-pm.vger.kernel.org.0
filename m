Return-Path: <linux-pm+bounces-25603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF98A914F0
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 09:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5353619E09B6
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4A7217F36;
	Thu, 17 Apr 2025 07:20:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E772147FB;
	Thu, 17 Apr 2025 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874446; cv=none; b=b3F57tG2eALzM3XWRNfVn/CUcO2reWp6aaywlpJV45M94WwPt/EzYzu0dZ1LorUizdUGMZaRWhlN/MKhhukPWxT8aTumMcj37l7YaSpcG4NpzTeocMnDYpK1qZLyGiAPvfbJjauTYLWQCojJyTbSYog7AcpFN3e+D4AOtDlJ2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874446; c=relaxed/simple;
	bh=QyhbxHAbNWI97LfKLS2k+ny8t1SV9wPT6bs06/rAvAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eY6+DDGUx9JVKfx/0aqZ9d8NrgvpzgCOy/5y/PmgGyyhAzxdD9rXXFY2G9qqqbdZsycBwvf8g6Ws/FE7KsmTCegvgVA2KeCiVQaq27AFvzTIxA7UDbEFzqM4dLL+/uG/ysVb8NehhumSLBpQhrhF/o0KJUP6SQvk47ILnVdXDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5242f137a1eso197796e0c.1;
        Thu, 17 Apr 2025 00:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874441; x=1745479241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJlwgfdjlKlj72m9IIHqT+BTPyJAYFDO/iuqVhlAcZU=;
        b=IxHqa3U5jpTXNvJXMJRi/Gocwu1En/EElXG5hCq8BfFIB28pSR0SkcFe6T51wSY8AA
         c8XvFkcvWzFIAGTvdiaYh9/f+iGPB//dfMm4v3rlDiMijMdM+qmxs3pvIa/GDaZ9HQLx
         PDcocScf3BJyeb7v/4wHCqg6j6XA9Jn88l+M9R2slu/TdYP5PxOmqqnMbaeXmNCeZ7Uc
         eAQ5e8Bb/BWokJ0ApZFPgz99EeN/HVZSYjhWTlgGmb1ofsHYUujqeFa343H8O/0IFig7
         0xouYGcWxZoFohqnMpi5XXOyBw+Z1IhGgp3UifzEXaIO/jxA2MlIoiZq73VLlYcUt+qu
         u7fA==
X-Forwarded-Encrypted: i=1; AJvYcCViSbg4rmmRX/+qyfvCHPU9Q5diI68OaWkJYYEBUZiOIaCb2RKFIvd0etj3jL+i4GRtJBg7oK8xUYE=@vger.kernel.org, AJvYcCWRzjpwwR2LRJ23YZ9L50As40orsQR/D/y6Ic5JIHcUCQlDExHNYRJt6GDNVJ30/PRvtURD0o50Z/HFfgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGmO+/HsiGWfMcxvX954XLcXoNOjoNsO7GoFRJI80fhYRf3aNL
	8qIbnEnFFCFeC0/VnJru1ko50yR74md1Ks5BugvL8Hj1qrV6sE8/KBD39cqK
X-Gm-Gg: ASbGnctE23ExKGBE4t2gn1saA9pwQFSuARyO+UlPA5l/nliunktM1+haiwkFT/26yJ6
	SYy8tGjocftzMv2zoLUoxI+angaO8yuQaNJ1VZN+Z2qe6+J2POJUSbmuMi2ot3oJ+/FOuhWi4E0
	VOuXZsXUp0OoO2NoWkQ47hWld3h8+hAycC+6A82u5c7z5xANq5ObmF4YZLiSLFaQiSguaxiHSQ0
	wPSmA617gU3x1ytRyhqHx9ppxzTSoCqWCyrBYClY5dl7g3taTbGfG6PF2KkDTCYv7b2M4LgTl4N
	FY8NeVvrWIZmmwZSULxxIITiqCkC/pxCzhlsbsSg7EObwzcl9HXeed3jyAMBuLpvo7KpXIxncY2
	Xlsk=
X-Google-Smtp-Source: AGHT+IEVjDeBrfr9Jcm8shhx4xC2+uyxs+Cp1nRsUo6xK/0cGrd/NBqVyAMuJcWAl55aixkFbvDhsQ==
X-Received: by 2002:a05:6122:2001:b0:528:bd71:8a8e with SMTP id 71dfb90a1353d-5290dfe1882mr3795822e0c.5.1744874440992;
        Thu, 17 Apr 2025 00:20:40 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abe8d74bsm3459815e0c.35.2025.04.17.00.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 00:20:40 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86fab198f8eso192592241.1;
        Thu, 17 Apr 2025 00:20:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUxuElXMAYlGS+/6AYxbHrAwhslz7G7O5wSw3WQiL+DZFjCqykCuYS7EOPaPzLKwPuKHSydVduMEGeeMM=@vger.kernel.org, AJvYcCWl/Grh+AUs/Dpl1L/gW3+ry/Z+EInoYJBxdWmDFChMgOlSHBDEl6k84YWCNJK0HkvtWydURR8QIUI=@vger.kernel.org
X-Received: by 2002:a05:6102:55d3:b0:4bb:9b46:3f8a with SMTP id
 ada2fe7eead31-4cb591b7d30mr2988752137.2.1744874439951; Thu, 17 Apr 2025
 00:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <143378b0-5740-4f2b-9a79-f04cf9ef1f77@arm.com> <tencent_C16C813B177E434BEAC73E842C46D872BC09@qq.com>
In-Reply-To: <tencent_C16C813B177E434BEAC73E842C46D872BC09@qq.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Apr 2025 09:20:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVAvMuzmn48aVB-xshMjbENXFc1MmYB=r7iPrMvfDZjDg@mail.gmail.com>
X-Gm-Features: ATxdqUGiXYh3QJkTgWt9shrcBT3lBi2PArasakP1xODfxivBaBiSHWBEneAs48k
Message-ID: <CAMuHMdVAvMuzmn48aVB-xshMjbENXFc1MmYB=r7iPrMvfDZjDg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: EM: Fix potential division-by-zero error in em_compute_costs()
To: Yaxiong Tian <iambestgod@qq.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>, rafael@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yaxiong,

On Mon, 14 Apr 2025 at 11:14, Yaxiong Tian <iambestgod@qq.com> wrote:
> I wasn=E2=80=99t sure whether the new patch should reuse the current Mess=
age-ID
> or create a new one, so I checked with ChatGPT and kept the original
> Message-ID for v2. If a new Message-ID is required, I can resend the
> email.

Different (revisions of) patches must have different Message-IDs,
else they can no longer be distinguished by our tooling.
Fortunately it seems like you didn't succeed (which is good ;-),
as all four revisions do have different Message-IDs:

https://lore.kernel.org/all/tencent_8478BF8F2549630842D323E7394CB6F49D08@qq=
.com/
https://lore.kernel.org/all/tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq=
.com/
https://lore.kernel.org/all/tencent_6D2374392DB66C9D23BF6E2546638A42EC08@qq=
.com/
https://lore.kernel.org/all/tencent_2256A7C02F7849F1D89390E488704E826D06@qq=
.com/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

