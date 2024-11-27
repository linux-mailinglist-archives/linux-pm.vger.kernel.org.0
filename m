Return-Path: <linux-pm+bounces-18148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519F19DA7DB
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 13:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8377DB21880
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048101FBEAA;
	Wed, 27 Nov 2024 12:24:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C831FBEA8;
	Wed, 27 Nov 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732710247; cv=none; b=lYvyYWV91jCeKvnz3QCbizS6Xmdk5Wc8OwFvmd15sSFJbNPl+daKqwT64fJJReMYrlfyQHeph4asPlRD8VEXLPfDK9gcshCTftL/TLT3KGK3SewJoyEYxT9OtgOuxA7YAIdQJMn+SB2B/KJ5vR1Y/XTKlu2oyjYbMGD8xS3ACMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732710247; c=relaxed/simple;
	bh=2xyqF7R5BBjLbNh4gI4Md/YFXkgS97KqFmr0wKaER5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3VnNyPqbh7W/0D8Vu6YpEw3uZVSEUkvisiaMfbeuGvEeIPoWbw4E0PBGpNpfxF6gaUwW6BjJWZd5YgPf1I5/3uMq1CPpfGZw0GgNNrwmUQ80f7sTKwITomV08EifcRvTYMAIZp6GlO4XA0kbjsiMrAuy9C+Epx0gvJ7k9CdaP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4af122fb98aso1008701137.1;
        Wed, 27 Nov 2024 04:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732710244; x=1733315044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJmD8VGU1XR+wNB0IA5Up4mnKITrJR2nrWnVBu6wRTQ=;
        b=IUK2y4E+1ImzBoWZ40H2SUmOO13KQ4I18GG8wU2uep13ic4jWD9tBf9iJVS5Jazvvs
         brx9qWDtrxyBkEamCyu8rg4RmBcwkimkC6udlcUqmmSEKISudjMYyOlquL6pIcBMx+m7
         bZVYBo2th5Y5TJdGHJv8GRPnEfw5XrrFVh98P4grtlQekjcuWcwHxl7wMd7kFfMJK3JV
         dhsg/7amuCcNy7z8NCInieNwtbSkwA6RL8PwVIgz8zZj6DVSXjxF0mu+iU9DTn4brwG8
         YoOIYZlJzsguitjlPFCHhgI32azF4lSylMAz3pZJejVvkw94WiFOQ+mYrlBvRokGW72s
         TBhw==
X-Forwarded-Encrypted: i=1; AJvYcCVRcHmRkemUVEnNmFnGs5f5UNBYRp8V6FXuwKVc3M8N6lLLaph9WpV76/9eWdrSqgzFYe5BN/dhTfH61rv3rTW5TME=@vger.kernel.org, AJvYcCWrwVerKz84agVtiDOeSOgiodqsz62zL2E4zJ//cmmfGfWXPMj3Gt3RCFgTlqZWYPqMPRY2kKLsCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkn0suDcLsYqji7vMms/U0FTTDqIxynAGDWfZ9xUsKruTltsG
	H9gj4rG9kNO4KV0OcU71xemufsK/JW7bBBA5dTv36uyoZu/CcpWeDFrr6Yel05U=
X-Gm-Gg: ASbGncutn21XM58YRlorfKWZ3mohpIZ2UGlrcNPZhf8VAqbOwtf7Xq1sFnlVMkOAiL5
	P0SRaVQssaEpu8Si6PEzMPkX/E7fWP5LGJpSXqfoA39oX3WTk9/myXJQDh+yk3NXKgZiKWB96tL
	BNScBZzonYDgmMKy9WlXSb4i2MiiZ+jFMEtC6sWvmTQ0Ac0UB0rBz/r6q2Y5j0lC5qSkpazQuve
	RQ08NaKsAOkHnwfiTZ0RUZKIXuQUo7rZP+Jd5beV7Mp6x08XEvopJinolAAKh8rS6Yn46BZEJe9
	BCWGAD6WMUYQ
X-Google-Smtp-Source: AGHT+IGhPVAHyiLw8h/PESrrz6gtM3D2EciAxoiYerdKtBPevHV0gdtvVGyjOv1eHczRlUAjzCIXtg==
X-Received: by 2002:a05:6102:e0a:b0:4af:3f28:77cc with SMTP id ada2fe7eead31-4af4487db32mr2880175137.10.1732710244492;
        Wed, 27 Nov 2024 04:24:04 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4af358234c7sm722405137.18.2024.11.27.04.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 04:24:04 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4af3de962a7so315135137.0;
        Wed, 27 Nov 2024 04:24:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9HJDpyBQFnrEPyyndOWxTnkMDU65m7eIjN3uAcbUdhKAIHl1ltY6Eubz76vdLJ7Ds+oKzVTPIefHLgLPPV3mU6qc=@vger.kernel.org, AJvYcCX+7vLkI9wFOAbj57kis8V2cqIRuRI572UxH76io3GvpPk3Y034UKMX17yNDgFwlv8pHiNyC3BYBw==@vger.kernel.org
X-Received: by 2002:a05:6102:32c3:b0:4ae:3a0e:e11d with SMTP id
 ada2fe7eead31-4af448c57abmr3127893137.13.1732710243607; Wed, 27 Nov 2024
 04:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120120336.1063979-1-niklas.soderlund+renesas@ragnatech.se> <20241120120336.1063979-2-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20241120120336.1063979-2-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Nov 2024 13:23:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWT7tg8H0iQd1OdQ8CUzmC6702kFmHPePvCZ7XDccO-_w@mail.gmail.com>
Message-ID: <CAMuHMdWT7tg8H0iQd1OdQ8CUzmC6702kFmHPePvCZ7XDccO-_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: rcar_gen3: Use lowercase hex constants
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 1:04=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The style of the driver is to use lowercase hex constants, correct the
> few outlines.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
> * Changes since v1
> - Update a few more defines not related to the fuses missed and pointed
>   out by Geert, thanks!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

