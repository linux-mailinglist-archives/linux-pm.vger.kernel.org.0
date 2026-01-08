Return-Path: <linux-pm+bounces-40477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A486AD04509
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 17:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48C2931A7AD5
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AA72C11CB;
	Thu,  8 Jan 2026 15:42:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430C922DFA4
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886926; cv=none; b=TLpqFJiTart7Ma3kc/kCBUz7eruxv5AYdDsYRoheZdewWJxXJ024M8j3IPKdzOY4dZa/mbJ8OecHu7L82j8QHMRRimqkX3Ht313rYsUVowOOxGze/3VNBUMSIzJKxoUhbobvtJwyq8+OqqjSYV5NAt765ROGVi/zoA/FrifB0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886926; c=relaxed/simple;
	bh=T9TwGPbtb/Jk65sCRD6p+Z4CpjSXQctqiN+jSbkE11s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjPFdIrgzQeCshc4takUKeHPm7XTjvBxIWxlU0V7LENkx2tntixK7m5lAIzS3/Ajc3gpehlmVN49Ol+i1utWaLJyuHvcEqIiBqLILHZUHWb6b0kGnOWJ7YtIgrk2yAijXhwqMTO/Y4V90tgnmOuWhz1ShnQ+tENdrdcn9vxvcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-55b26461e78so1048767e0c.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767886924; x=1768491724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdIqtM+rBkxv36T/mfvwWrTjJhzVX0CXMe7ykzjRBh4=;
        b=Mz+b8xeeQbKREgmsZAr36tFnCVhjPDhGt27II4L5zNTB9+VlJAGFmIb/3dQmZs+1WU
         NJOx9zp4EMQVJbBPsak8RwbgzrLnIpfoq4jJNa721f0zixd8/T3LINBqxGa3Co/ESVIG
         SH5TGyhGJysJfJXxvrfY3WCGEWAj785lVtFzKGDgjt50Y6E38u8opvh+bXVNMQjXGXxv
         0Z1nbv1BPrER3qw6HkkyvdtbeJH9UHHh70tHVxyKjp/nOW4fgxBDp8XVnCsDEG3NqWMv
         nOJcAnc0jXg8/KI1GyY6cCfeCIP4z04jiLALmiiTV/7QA+7JPXVUtN4MIwyw+DHWiMYn
         PFmA==
X-Forwarded-Encrypted: i=1; AJvYcCX7Om/WKnnTMbxfpXmMhcKb1A90lNexu1VW6qHyj3UHfk9TagZz9UCy5lJG5Bx4IO8isJVCOBXj+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIxp7Mp12a3Gl1M61+I8rbezOm87HqnPTAh6briGk6mx46sZ7r
	x3VOlYhH0z9WeOMEUOJb74GPaqBB5AdRrgkSGlHKbQqvHn9aewN3rCncz8sKPNEG
X-Gm-Gg: AY/fxX6eYiiknnw2TDIJ4PJlrOWyXrGMlZK81aCpLP9eCcDTScUoNTntq9HCTP8syPR
	klFhJ6RXoVUkOz2QkXy2FARko8u/wzdcQiEyad48t4wZPsGAD7HMZs6Us0dKqrA8/H+srmRlC6w
	dzsCMMQJi/BrLcpyPWmUHmNwUjLXjlBvFskdDxQ4vqIskmFe7Wg/PbSjEbZH+aspT+vmYkznzmk
	cArusIqX1NHJANFdLLWvYlculSL4dUttoBb1zigkiSLNhvh0ibMQkqED4O73ZWDNvGWvRSs882n
	1F/YlTXw/ByQyZmUoD18zunBqIZnzJk8mFXy+5t0rEUzsN036iYzWLIZxR1fFuQ6RIZqjjbbie6
	r9XeaiP6S3Is8FEKUXY6kgqOeqMPDgUfNmjDNXOjLl7BuDuGPMfEZowrgTI1UM/B7AYeu9onfj8
	qUwb8IvXeLwx4dBa0FUGLaXTisD8W5ep0CDaCbJY7bBqxHgym1
X-Google-Smtp-Source: AGHT+IEH9Zptz7aofzKPThbqSUfMeZBEJgfQitmbLoFUnz/kVlKCScL+0LGzNNcD+Pj4tVAkOuTN/w==
X-Received: by 2002:a05:6122:616e:b0:559:8089:9445 with SMTP id 71dfb90a1353d-56347fad422mr2100010e0c.12.1767886923929;
        Thu, 08 Jan 2026 07:42:03 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a20a183sm6384094e0c.9.2026.01.08.07.42.03
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:42:03 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-93f64ae67dbso1037526241.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:42:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWdmxu8qkRjIyO5qnfJmWTttk+5IqYio42pylPzbaYdrKr8LV7CsAGX0cfi/rj3PtShIKsIia6VeQ==@vger.kernel.org
X-Received: by 2002:a67:e112:0:b0:5ee:9e4b:a81c with SMTP id
 ada2fe7eead31-5ee9e4baa91mr722934137.22.1767886923130; Thu, 08 Jan 2026
 07:42:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251126130356.2768625-8-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251126130356.2768625-8-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Jan 2026 16:41:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUVhHZgd7MugxMk85gvzTXPj7GsgmWRef6KjH2j8WUkEw@mail.gmail.com>
X-Gm-Features: AQt7F2oqUJcYTOpHjX-h4M0p98Sgtm1uZRHOlAe1Y5tgQeYww1060qUHgkV9uew
Message-ID: <CAMuHMdUVhHZgd7MugxMk85gvzTXPj7GsgmWRef6KjH2j8WUkEw@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] arm64: dts: renesas: r9a09g087: add OPP table
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Nov 2025 at 14:05, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Add OPP table for RZ/N2H SoC.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.20.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

